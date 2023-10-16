import os
import uvicorn
from llama_cpp.server.app import create_app, Settings


user_config = dict()
for field, val in Settings().model_dump().items():
    if (uf := field.upper()) in os.environ:
        print(f"{uf} in env")
        user_config[field] = os.getenv(uf)

if __name__ == '__main__':
    print(user_config)
    settings = Settings(**user_config)
    app = create_app(settings=settings)
    uvicorn.run(app, host=settings.host, port=settings.port)