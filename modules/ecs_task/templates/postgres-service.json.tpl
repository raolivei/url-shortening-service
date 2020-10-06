[
    {
        "name": "${task_name}",
        "image": "${task_image}",
        "cpu": ${cpu},
        "memory": ${memory},
        "essential": true,
        "requiresCompatibilities": [
        "FARGATE"
    ],
        "portMappings": [
            {
                "containerPort": ${container_port},
                "hostPort": ${container_port}
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "/ecs/${task_name}",
                "awslogs-region": "${region}",
                "awslogs-stream-prefix": "${environment}-${task_name}"
            }
        },
        "environment": [
            {
                "name": "DB_PASSWORD",
                "value": "${db_password}"
            },
            {
                "name": "DB_USERNAME",
                "value": "${db_username}"
            }
        ]
    }
]