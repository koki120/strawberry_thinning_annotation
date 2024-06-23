# iPhoneへのビルド手順

このドキュメントは、GitHub Actionsを使用して生成されたiOSアプリをiPhoneにデプロイする手順を説明します。


## GitHubからビルド成果物をダウンロード

GitHubリポジトリの Actions タブに移動します。
最近のワークフロー実行を選択します。
Artifacts セクションからビルドされた .ipa ファイルをダウンロードします。

## Xcodeで署名とデプロイ
### Xcodeの設定

1. Xcodeで新しいプロジェクトを作成:

- Xcodeを開き、新しいプロジェクトを作成します（既存のプロジェクトを開いても構いません）。
- Single View App テンプレートを選択し、プロジェクトを設定します。
2. .ipaファイルをインポート:

- ダウンロードした .ipa ファイルを解凍し、プロジェクトにインポートします。

3. 署名情報を設定:

- プロジェクト設定の Signing & Capabilities タブを開きます。
- Team を選択し、 Automatically manage signing を有効にします。
- 必要に応じてプロビジョニングプロファイルを手動で設定します。

4. アプリを再ビルド:

- Product -> Archive を選択してアーカイブを作成します。
- アーカイブが完了したら、 Distribute App を選択し、適切な署名と設定でエクスポートします。

5. iPhoneにデプロイ:

- iPhoneをMacに接続し、Xcodeから Product -> Run を選択してデプロイします。

以上の手順で、GitHub Actionsで生成されたiOSビルド成果物をiPhoneで動作させることができます。署名とデプロイの手順は、Appleの開発者アカウントが必要ですので、事前に準備してください。