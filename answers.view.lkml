view: answers {
  label: "1) The Quizzard Results"
  sql_table_name: (SELECT *, GENERATE_UUID() as pk FROM quizzes.answers ) ;;

  dimension: pk {primary_key: yes hidden: yes type:string }

  dimension: is_current_user {
    type: yesno
    sql: ${user_id} = ${current_user::string} ;;
  }

  dimension: current_user {
    type: number
    sql: {{ _user_attributes['id'] }} ;;
    hidden: yes
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: passed {
    type: yesno
    sql: ${TABLE}.passed ;;
  }

  dimension: question {
    type: number
    sql: CAST(${TABLE}.question AS INT64) ;;
  }

  dimension: results {
    hidden: yes
    sql: ${TABLE}.results ;;
  }

  dimension: scheduled_plan_id {
    type: number
    sql: ${TABLE}.scheduled_plan_id ;;
  }

  dimension_group: submitted {
    type: time
    sql: ${TABLE}.submitted_at ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: count_wrong_results {
    type: number
    sql:
      ( ${answers_test_results_vis_config.wrong::number}
      + ${answers_test_results_fields.wrong::number}
      + ${answers_test_results_filters.wrong::number}
      + ${answers_test_results_limit.wrong::number}
      + ${answers_test_results_sorts.wrong::number}
      + ${answers_test_results_pivots.wrong::number}
      + ${answers_test_results_num_rows.wrong::number} ) ;;
  }

  dimension: wrong_array {
    hidden: yes
    type:  string
    sql: [
        ${answers_test_results_vis_config.reason_wrong}
      , ${answers_test_results_fields.reason_wrong}
      , ${answers_test_results_filters.reason_wrong}
      , ${answers_test_results_limit.reason_wrong}
      , ${answers_test_results_sorts.reason_wrong}
      , ${answers_test_results_pivots.reason_wrong}
      , ${answers_test_results_num_rows.reason_wrong}] ;;
  }

  dimension: all_wrong_reasons {type: string sql: ARRAY_TO_STRING(${wrong_array},', ') ;; }

  measure: total_questions {type: max sql: 18 ;; }
  measure: users {type: count_distinct sql: ${user_id} ;; }
  measure: tries {type: count }
  measure: wrong_answers {type: count filters: { field: passed value: "No" } }
  measure: correct_answers {type: count filters: { field: passed value: "Yes"} }

  measure: questions_wrong {
    type: count_distinct
    sql: ${question} ;;
    filters: { field: passed value: "No"}
  }

  measure: questions_correct {
    type: count_distinct
    sql: ${question} ;;
    filters: { field: passed value: "Yes"}
  }

  measure: percentage_complete {
    type: number
    sql: SAFE_DIVIDE(${questions_correct},${total_questions}) ;;
    value_format_name: percent_1
  }

  measure: correct_rate {
    type: number
    sql: SAFE_DIVIDE(${correct_answers},${tries}) ;;
    value_format_name: percent_1
  }

  measure: wrong_rate {
    type: number
    sql: SAFE_DIVIDE(${wrong_answers},${tries}) ;;
    value_format_name: percent_1
  }

  measure: highest_question_passed {
    type: max
    sql: ${question} ;;
    filters: {field: passed value: "Yes"}
  }
  measure: highest_question_tried {
    type: max
    sql: ${question} ;;
  }
}
