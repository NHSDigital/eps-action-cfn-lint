setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    docker build -t cfn-lint .
}


@test "simple file does not produce errors" {
	run docker run -it --rm -v ${PWD}/test/resources/simple:/github/workspace cfn-lint
    assert_success
    assert_output --partial 'cfnlint.runner - INFO - Run scan of template /github/workspace/SAMtemplates/good_file.yml'
    assert_output --partial 'No errors found'
}

@test "bad file does produce errors" {
	run docker run -it --rm -v ${PWD}/test/resources/bad:/github/workspace cfn-lint
    assert_failure
    assert_output --partial 'cfnlint.runner - INFO - Run scan of template /github/workspace/SAMtemplates/bad_file.yml'
    assert_output --partial 'W8001 Condition IsTrue not used'
    assert_output --partial '/github/workspace/SAMtemplates/bad_file.yml:8:3'
    assert_output --partial 'Errors were found'
}

@test "multiple files are scanned" {
	run docker run -it --rm -v ${PWD}/test/resources/multiple_files:/github/workspace cfn-lint
    assert_success
    assert_output --partial 'cfnlint.runner - INFO - Run scan of template /github/workspace/cloudformation/good_file_1.yml'
    assert_output --partial 'cfnlint.runner - INFO - Run scan of template /github/workspace/cloudformation/good_file_2.yaml'
    assert_output --partial 'cfnlint.runner - INFO - Run scan of template /github/workspace/SAMtemplates/good_file_3.yml'
    assert_output --partial 'cfnlint.runner - INFO - Run scan of template /github/workspace/SAMtemplates/good_file_4.yaml'
    refute_output --partial 'cfnlint.runner - INFO - Run scan of template /github/workspace/ignore/good_file_5.yaml'
    assert_output --partial 'No errors found'
}