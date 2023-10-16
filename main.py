import uvicorn
from llama_cpp.server.app import create_app, Settings

model_path = "/models/llama-2-7b-chat.Q4_K_M.gguf"

verbose = True
host = '0.0.0.0'
port = '8080'

if __name__ == '__main__':
    config = {
        'model': model_path,
        'n_gpu_layers': 35,
        'n_threads': 4,
        'verbose': verbose,
        'host': host,
        'port': port
    }
    settings = Settings(**config)
    app = create_app(settings=settings)
    uvicorn.run(app, host=settings.host, port=settings.port)