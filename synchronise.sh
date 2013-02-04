#!/bin/bash

PROJECT_DIR="../ceygen"

pushd "${PROJECT_DIR}"
rev=$(git describe --dirty)
popd

make -C "${PROJECT_DIR}/doc/" clean
make -C "${PROJECT_DIR}/doc/" html
rsync -am -v --delete "${PROJECT_DIR}/doc/_build/html/" \
	--exclude /.git --exclude /synchronise.sh --exclude README \
	--exclude /.nojekyll --exclude /.buildinfo \
	./

git add .
git commit -a -m "synchronise.sh: regenerate documentation for Ceygen ${rev}"
git push
