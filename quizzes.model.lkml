connection: "david_bq_quizzard"

# include all the views
include: "*.view"
include: "quizzard_leaderboard.dashboard"

datagroup: quizzes_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}



explore: answers {
  persist_with: quizzes_default_datagroup
  label: "The Quizzard Answers"
  join: answers_test_results_vis_config {
    sql: LEFT JOIN UNNEST([${answers_test_results.vis_config}]) as answers_test_results_vis_config ;;
    relationship: one_to_one
  }

  join: answers_test_results_limit {
    sql: LEFT JOIN UNNEST([${answers_test_results.limit}]) as answers_test_results_limit ;;
    relationship: one_to_one
  }

  join: answers_test_results_num_rows {
    sql: LEFT JOIN UNNEST([${answers_test_results.num_rows}]) as answers_test_results_num_rows ;;
    relationship: one_to_one
  }

  join: answers_test_results_filters {
    sql: LEFT JOIN UNNEST([${answers_test_results.filters}]) as answers_test_results_filters ;;
    relationship: one_to_one
  }

  join: answers_test_results_fields {
    sql: LEFT JOIN UNNEST([${answers_test_results.fields}]) as answers_test_results_fields ;;
    relationship: one_to_one
  }

  join: answers_test_results_pivots {
    sql: LEFT JOIN UNNEST([${answers_test_results.pivots}]) as answers_test_results_pivots ;;
    relationship: one_to_one
  }

  join: answers_test_results_sorts {
    sql: LEFT JOIN UNNEST([${answers_test_results.sorts}]) as answers_test_results_sorts ;;
    relationship: one_to_one
  }

  join: answers_test_results {
    sql: LEFT JOIN UNNEST([${answers.results}]) as answers_test_results ;;
    relationship: one_to_one
  }
  join: all_wrong_area_checks {
    sql: LEFT JOIN UNNEST(${answers.wrong_array}) as all_wrong_area_checks ;;
    relationship: one_to_many
  }
}
