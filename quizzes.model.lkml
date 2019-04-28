connection: "bfw_bq"

# include all the views
include: "*.view"

datagroup: quizzes_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: quizzes_default_datagroup

explore: answers_test {
  join: answers_test_results_vis_config {
    view_label: "Answers Test: Results Vis Config"
    sql: LEFT JOIN UNNEST([${answers_test_results.vis_config}]) as answers_test_results_vis_config ;;
    relationship: one_to_one
  }

  join: answers_test_results_limit {
    view_label: "Answers Test: Results limit"
    sql: LEFT JOIN UNNEST([${answers_test_results.limit}]) as answers_test_results_limit ;;
    relationship: one_to_one
  }

  join: answers_test_results_num_rows {
    view_label: "Answers Test: Results Num Rows"
    sql: LEFT JOIN UNNEST([${answers_test_results.num_rows}]) as answers_test_results_num_rows ;;
    relationship: one_to_one
  }

  join: answers_test_results_filters {
    view_label: "Answers Test: Results Filters"
    sql: LEFT JOIN UNNEST([${answers_test_results.filters}]) as answers_test_results_filters ;;
    relationship: one_to_one
  }

  join: answers_test_results_fields {
    view_label: "Answers Test: Results Fields"
    sql: LEFT JOIN UNNEST([${answers_test_results.fields}]) as answers_test_results_fields ;;
    relationship: one_to_one
  }

  join: answers_test_results_pivots {
    view_label: "Answers Test: Results Pivots"
    sql: LEFT JOIN UNNEST([${answers_test_results.pivots}]) as answers_test_results_pivots ;;
    relationship: one_to_one
  }

  join: answers_test_results_sorts {
    view_label: "Answers Test: Results Sorts"
    sql: LEFT JOIN UNNEST([${answers_test_results.sorts}]) as answers_test_results_sorts ;;
    relationship: one_to_one
  }

  join: answers_test_results {
    view_label: "Answers Test: Results"
    sql: LEFT JOIN UNNEST([${answers_test.results}]) as answers_test_results ;;
    relationship: one_to_one
  }
  join: question_all_wrong {
    sql: LEFT JOIN UNNEST(${answers_test.wrong_array}) as question_all_wrong ;;
    relationship: one_to_many
  }
}
