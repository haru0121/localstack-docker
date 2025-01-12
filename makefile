.PHONY: localStack

localStack:
	docker-compose up

# LambdaのCreate[make lambdaBuild FUNCTION_NAME](都度DeleteしてCreate)
 
lambdaBuild:
	cd src && \
	zip main.zip index.js && \
	cp main.zip ../main.zip && \
	rm -f main.zip && \
	cd .. && \
	aws \
	--endpoint-url=http://localhost:4566 \
	lambda create-function --function-name ${FUNCTION_NAME} \
	--runtime nodejs18.x \
	--handler index.handler \
	--role arn:aws:iam::000000000000:role/lambda-rol \
	--zip-file fileb://main.zip --region us-east-1 \
	--profile localstack

lambdaDestroy:
	aws lambda delete-function  \
	--function-name ${FUNCTION_NAME} \
	--endpoint-url http://localhost:4566


lambdaStatus:
	aws lambda get-function \
	--function-name ${FUNCTION_NAME} \
	--endpoint-url http://localhost:4566

# Lambda 関数を更新
lambdaUpdate:
	make lambdaDestroy FUNCTION_NAME=${FUNCTION_NAME} && \
	make lambdaBuild FUNCTION_NAME=${FUNCTION_NAME}

# LambdaのInvoke
lambdaInvoke:
	aws lambda \
	--endpoint-url=http://localhost:4566 \
	invoke \
	--function-name ${FUNCTION_NAME}  \
	--profile localstack  \
	result.log