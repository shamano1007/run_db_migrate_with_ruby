# run_db_migrate_with_ruby
rubyでdb migrate 実施

## 設定値
下記に設定値定義  
`lib/config.rb`

## コマンド一覧
```
rake db:create    # Create database
rake db:drop      # Drop database
rake db:migrate   # Migrate database
rake db:rollback  # Rolls the schema back to the previous version (specify steps w/ STEP=n)
rake db:version   # Retrieves the current schema version number
rake g            # generator
rake generate     # generator
```

### db
#### db:create
テーブル作成

#### db:drop
テーブル削除

#### db:migrate
テーブル作成・更新・削除

#### db:rollback
migrationバージョンを戻す

#### db:version
現在のdbバージョン確認

### generate/g
#### model作成
`$ bundle exec rake g model <model名>`  
対象パスにmodelファイル作成 + migrationファイル作成

#### migrationファイル作成
`$ bundle exec rake g migration <migration名>`  
対象パスにmigrationファイル作成

