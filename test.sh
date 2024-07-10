# curl -X POST "http://localhost:5001/api/parseDocument?renderFormat=all" \
#     -F file=@./tests/test_color.pdf \
# | jq 

# curl -X POST "http://localhost:5001/api/parseDocument?renderFormat=all&applyOcr=yes" \
#     -F file=@./tests/test_color.pdf \
# | jq 

# curl -X POST "http://localhost:5001/api/parseDocument?renderFormat=all" \
#     -F file=@./tests/test_multiline.pdf \
# | jq 

# curl -X POST "http://localhost:5001/api/parseDocument?renderFormat=all&applyOcr=yes" \
#     -F file=@./tests/test_multiline.pdf \
# | jq 

# curl -X POST "http://localhost:5001/api/parseDocument?renderFormat=all" \
#     -F file=@./tests/test_flattened_text.pdf \
# | jq 

# curl -X POST "http://localhost:5001/api/parseDocument?renderFormat=all&applyOcr=yes" \
#     -F file=@./tests/test_flattented_text.pdf \
# | jq x