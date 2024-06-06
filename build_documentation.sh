echo "package.dependencies.append(" >> Package.swift
echo "  .package(url: \"https://github.com/apple/swift-docc-plugin\", from: \"1.0.0\")" >> Package.swift
echo ")" >> Package.swift

swift package --allow-writing-to-directory docs \
    generate-documentation \
    --target `basename $PWD` \
    --disable-indexing \
    --output-path docs \
    --transform-for-static-hosting \
    --hosting-base-path .

git stash -- Package.swift

open http://localhost:8080/documentation/`basename $PWD`

cd docs

python3 -m http.server 8080

