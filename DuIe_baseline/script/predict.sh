set -eux

export TASK_DATA_PATH=./data/
export DEV_FILE=military_test.json
export MODEL_PATH=./pretrained_model/
export CHECKPOINT=./checkpoints/step_1121/
export TEST_SAVE=./data/

export FLAGS_sync_nccl_allreduce=1
export PYTHONPATH=./ernie:${PYTHONPATH:-}
python -u ./ernie/run_duie.py \
                   --use_cuda false \
                   --do_train false \
                   --do_val false \
                   --do_test true \
                   --batch_size 64 \
                   --init_checkpoint ${CHECKPOINT} \
                   --num_labels 8 \
                   --label_map_config ${TASK_DATA_PATH}relation2label.json \
                   --spo_label_map_config ${TASK_DATA_PATH}label2relation.json \
                   --test_set ${TASK_DATA_PATH}${DEV_FILE} \
                   --test_save ${TEST_SAVE}predict_dev.json \
                   --vocab_path ${MODEL_PATH}vocab.txt \
                   --ernie_config_path ${MODEL_PATH}ernie_config.json \
                   --use_fp16 false \
                   --max_seq_len 128 \
                   --skip_steps 10 \
                   --random_seed 1
