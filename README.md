# docker-vite-react

### 環境構築
1. Dockerfile と docker-compose.yml を作成  
    - Dockerfile  
    `RUN mkdir node_modules` はコメントアウトしておく
    - docker-compose.yml  
    `- node_modules:/usr/src/app/node_modules` はコメントアウトしておく
2. イメージをビルド  
`docker-compose build`  
3. create vite を実行  
`docker-compose run --rm react yarn create vite`  
※reactの部分はサービス名  
4. プロジェクト名を聞かれるがカレントディレクトリに作成するので「.」と回答  
    ```
    ? Project name:.
    ```
5. どのフレームワークにするか聞かれるので、Reactを選ぶ  
    ```
    ? Select a framework: › - Use arrow-keys. Return to submit.
        Vanilla
        Vue
    ❯   React
        Preact
        Lit
        Svelte
        Solid
        Qwik
        Others
    ```

6. バリアント聞かれるので、TypeScript + SWC を選ぶ  
    ```
    ? Select a variant: › - Use arrow-keys. Return to submit.
        TypeScript
    ❯   TypeScript + SWC
        JavaScript
        JavaScript + SWC
    ```

7. appフォルダ内にviteのファイルが作成されていることを確認
8. app > vite.config.ts にserverを追記  
    ※watch > usePolling を trueにするとホットリロードされる  
    ```
    export default defineConfig({
    server: {
        host: '0.0.0.0',
        port: 3000,
        watch: {
            usePolling: true
        }
    },
    plugins: [react()],
    })
    ```

9. コンテナ内でviteを起動する場合はhostを指定する  
app > package.json > scripts > dev に`--host`を追記
    ```
    "scripts": {
        "dev": "vite --host",
        "build": "tsc && vite build",
    ```

10. Dockerfile と docker-compose.yml のnode_modules関連のコメントアウトを取る

11. もう一度イメージをビルドする  
`docker-compose build`  

12. packageをインストール(node_modulesのvolumeにインストールされる)  
`docker-compose run --rm react yarn install`  

13. コンテナを起動する  
`docker compose up -d`  

14. ブラウザからローカルホストにアクセス  
`http://localhost:3000`  