# instructions : python main.py <path to config.json>
import os
import json
import sys

def run_command(cmd):
	print("Running : ",cmd)
	retval = os.system(cmd)
	if retval != 0:
		print("[ERROR] Return value =", retval, "for ",cmd)


jsonpath = "config.json"
if len(sys.argv)>1:
	jsonpath = sys.argv[1]

with open(jsonpath) as r:
	config = json.loads(r.read())

if "python_path" in config:
	pythonpath = config["python_path"]
else:
	pythonpath = "python"

projectname = config["project_path"].split("/")[-1]

# path to the constant files
const_folder = os.path.abspath("const_files/")
print("Const folder : ",const_folder)


# Enter the kgg folder
os.chdir("kgg")

# # Run initialize.py
run_command(f"{pythonpath} initialize.py {config['project_path']} {config['output_path']}")

# # Run examine.py
run_command(f"{pythonpath} examine.py {config['runs_json_path']} {config['output_path']}")

os.chdir("../")

## Running the query engine (to generate TTL)
os.chdir("qe/")


project_output_folder = os.path.join(config['output_path'], projectname)


for folder in os.listdir(project_output_folder):
	if folder.startswith("exe_"):
		xml_folder = os.path.join(project_output_folder, folder)

		# inputs
		static_file = os.path.join(xml_folder, "final_static.xml")
		dynamic_file = os.path.join(xml_folder, "final_dynamic_0.xml")
		comment_file = os.path.join(project_output_folder, "final_comments.xml")

		# outputs
		mapping_static_file = os.path.join(xml_folder, "mapping_static.p")
		static_ttl = os.path.join(xml_folder, "final_static.ttl")
		dynamic_ttl = os.path.join(xml_folder, "final_dynamic.ttl")
		comment_ttl = os.path.join(xml_folder, "final_comment.ttl")
		final_ttl = os.path.join(xml_folder, "final.ttl")
		all_store_file = os.path.join(xml_folder, "all_store.p")
		files_file = os.path.join(xml_folder,"files.p")
		name_tokens_file = os.path.join(xml_folder,"name_tokens.p")
		name_tokens_dict = os.path.join(xml_folder, "name_tokens_dict.p")
		comment_tokens_dict = os.path.join(xml_folder, "comment_tokens_dict.p")
		program_domain_dict = os.path.join(xml_folder, "program_domain_dict.p")
		# tf-idf outputs
		token_file_count = os.path.join(xml_folder, "token_file_count.p")
		file_token_count = os.path.join(xml_folder, "file_token_count.p")
		tf_idf_name_tokens = os.path.join(xml_folder, "tf_idf_name_tokens.p")
		symbol_token_file_count = os.path.join(xml_folder, "symbol_token_file_count.p")
		symbol_file_token_count = os.path.join(xml_folder, "symbol_file_token_count.p")
		tf_idf_symbol = os.path.join(xml_folder, "tf_idf_symbol.p")
		
		# consts
		name_token_similar = os.path.join(const_folder, "name_token_similar.csv")
		comment_top10_similar = os.path.join(const_folder, "comment_top10_similar_model_200_W10_CBOW_NEG5.csv")
		crossSimilarity_file = os.path.join(const_folder, "crossSimilarity_matrix.csv")


		# all_store
		run_command(f"{pythonpath} all_store.py {static_file} {comment_file} {all_store_file}")

		# mapping_extra_id
		os.chdir("parseXML")
		run_command(f"{pythonpath} mapping_extra_id.py {static_file} {mapping_static_file}")

		# parseStaticXML
		run_command(f"{pythonpath} parseStaticXML.py {static_file} {static_ttl} {mapping_static_file} {xml_folder} ")

		# parseDynamicXML
		run_command(f"{pythonpath} parseDynamicXML.py {dynamic_file} {dynamic_ttl} {mapping_static_file}")

		# parsecCommentsXML
		run_command(f"{pythonpath} parseCommentXML.py {comment_file} {comment_ttl} {mapping_static_file} {all_store_file} {xml_folder}")

		# merge TTLs
		print("Merging TTL files")
		run_command(f"{pythonpath} merge.py {static_ttl} {dynamic_ttl} {comment_ttl} {final_ttl}")

		os.chdir("../similarity_tokens_dict")
		# name_tokens_dict
		run_command(f"{pythonpath} name_tokens_dict.py {name_token_similar} {name_tokens_dict}")		

		# comment_tokens_dict
		run_command(f"{pythonpath} comment_tokens_dict.py {comment_top10_similar} {comment_tokens_dict}")

		# program_domain_dict
		run_command(f"{pythonpath} program_domain_dict.py {crossSimilarity_file} {program_domain_dict}")

		## tf-idf files
		os.chdir("../tf-idf")
		# file_token_count
		run_command(f"{pythonpath} name_file_token_count.py {static_ttl} {file_token_count}")

		# file_token_count
		run_command(f"{pythonpath} name_token_file_count.py {static_ttl} {name_tokens_file} {token_file_count}")

		# file_token_count
		run_command(f"{pythonpath} symbol_file_token_count.py {static_ttl} {symbol_file_token_count}")

		# file_token_count
		run_command(f"{pythonpath} symbol_token_file_count.py {static_ttl} {all_store_file} {symbol_token_file_count}")

		# tf-idf
		run_command(f"{pythonpath} tf_idf.py {file_token_count} {token_file_count} {tf_idf_name_tokens}")
		run_command(f"{pythonpath} tf_idf.py {symbol_file_token_count} {symbol_token_file_count} {tf_idf_symbol}")

		print("Required files for query server are saved at the following paths")
		print(f"all_files = '{files_file}'")
		print(f"all_name_tokens_dict = '{name_tokens_dict}'")
		print(f"all_comment_tokens_dict = '{comment_tokens_dict}'")
		print(f"program_domain_dict = '{program_domain_dict}'")
		print(f"tf_idf_name_tokens = '{tf_idf_name_tokens}'")
		print(f"tf_idf_symbol = '{tf_idf_symbol}'")
		print(f"all_store_file = '{all_store_file}'")
		print(f"TTLfile = '{final_ttl}'")


