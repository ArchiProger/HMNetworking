# don’t forget to build or you’ll get blank pages
swift build

# parameter values are case-sensitive!
swift package \
	--allow-writing-to-directory ./docs \
	generate-documentation \
	--target HMNetworking \
	--output-path ./docs \
	--transform-for-static-hosting \
	--hosting-base-path HMNetworking
