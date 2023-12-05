#!/bin/sh

# Start the controller
# python -m llava.serve.controller --host 0.0.0.0 --port 10000 &
python -m fastchat.serve.controller --host 0.0.0.0 --port 21001 &

# Sleep for a moment to allow the controller to start
sleep 5

# Start the Gradio web server
#python -m llava.serve.gradio_web_server --controller http://localhost:10000 --model-list-mode reload --port 7860 &
python -m fastchat.serve.gradio_web_server --controller http://localhost:21001 --model-list-mode reload --port 7861 & 

# Sleep for a moment to allow the controller to start
sleep 15

# Start the model worker
# python -m llava.serve.model_worker --host 0.0.0.0 --controller http://localhost:10000 --port 40000 --worker http://localhost:40000 --model-path liuhaotian/llava-v1.5-7b --load-8bit &
# CUDA_VISIBLE_DEVICES=0 python -m fastchat.serve.model_worker --model-path lmsys/vicuna-7b-v1.5 --controller http://localhost:21001 --port 31000 --worker http://localhost:31000 &

# python -m fastchat.serve.model_worker --host 0.0.0.0 --controller http://localhost:21001 --port 31000 --worker http://localhost:31000 --model-path lmsys/vicuna-7b-v1.5 & 

#python -m fastchat.serve.model_worker --host 0.0.0.0 --controller http://localhost:21001 --port 31000 --worker http://localhost:31000 --model-path meta-llama/Llama-2-70b-chat-hf & 
#python -m fastchat.serve.model_worker --host 0.0.0.0 --controller http://localhost:21001 --port 31000 --worker http://localhost:31000 --model-path lmsys/vicuna-33b-v1.3 & 
#python -m fastchat.serve.model_worker --host 0.0.0.0 --controller http://localhost:21001 --port 31000 --worker http://localhost:31000 --model-path mistralai/Mistral-7B-v0.1 & 
# python -m fastchat.serve.model_worker --host 0.0.0.0 --controller http://localhost:21001 --port 31000 --worker http://localhost:31000 --model-path meta-llama/Llama-2-7b-chat-hf & 
python -m fastchat.serve.model_worker --host 0.0.0.0 --controller http://localhost:21001 --port 31000 --worker http://localhost:31000 --model-path SUSTech/SUS-Chat-34B & 


sleep 300

# Start the API server
python -m fastchat.serve.openai_api_server --host 0.0.0.0 --port 7860 & 

# Keep the script running to keep the container alive
tail -f /dev/null
