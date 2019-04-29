view: answers_test {
  sql_table_name: (SELECT *, GENERATE_UUID() as pk FROM quizzes.answers ) ;;

  dimension: pk {primary_key: yes type:string }

  dimension: result_categories {type: number sql: 7 ;;}

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
  measure: right_answers {type: count filters: { field: passed value: "Yes"} }

  measure: questions_wrong {
    type: count_distinct
    sql: ${question} ;;
    filters: { field: passed value: "No"}
  }

  measure: questions_right {
    type: count_distinct
    sql: ${question} ;;
    filters: { field: passed value: "Yes"}
  }

  measure: percentage_complete {
    type: number
    sql: SAFE_DIVIDE(${questions_right},${total_questions}) ;;
    value_format_name: percent_1
  }

  measure: right_rate {
    type: number
    sql: SAFE_DIVIDE(${right_answers},${tries}) ;;
    value_format_name: percent_1
  }

  measure: wrong_rate {
    type: number
    sql: SAFE_DIVIDE(${wrong_answers},${tries}) ;;
    value_format_name: percent_1
  }

  measure: failures {
    type: string
    sql: STRING_AGG(${answers_test_results_vis_config.reason} ;;
  }
  measure: last_question_passed {
    type: max
    sql: ${question} ;;
    filters: {field: passed value: "Yes"}
  }
}

view: answers_test_results_vis_config {
  extends: [answer_check_base]
}

view: answers_test_results_limit {
  extends: [answer_check_base]
}

view: answers_test_results_num_rows {
  extends: [answer_check_base]
}

view: answers_test_results_filters {
  extends: [answer_check_base]
}

view: answers_test_results_fields {
  extends: [answer_check_base]
}

view: answers_test_results_pivots {
  extends: [answer_check_base]
}

view: answers_test_results_sorts {
  extends: [answer_check_base]
}

view: answers_test_results {
  dimension: fields {
    hidden: yes
    sql: ${TABLE}.fields ;;
  }

  dimension: filters {
    hidden: yes
    sql: ${TABLE}.filters ;;
  }

  dimension: limit {
    hidden: yes
    sql: ${TABLE}.`limit` ;;
  }

  dimension: num_rows {
    hidden: yes
    sql: ${TABLE}.num_rows ;;
  }

  dimension: pivots {
    hidden: yes
    sql: ${TABLE}.pivots ;;
  }

  dimension: sorts {
    hidden: yes
    sql: ${TABLE}.sorts ;;
  }

  dimension: vis_config {
    hidden: yes
    sql: ${TABLE}.vis_config ;;
  }
}

view: answer_check_base {
  extension: required
  view_label: "Answer Checks"
  dimension: check { type: yesno sql: ${TABLE}.check ;; group_label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', '' | capitalize }}" label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', '' | capitalize }} Check"}
  dimension: wrong { type: yesno sql: NOT ${TABLE}.check ;; group_label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', '' | capitalize }}" label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', '' | capitalize }} Wrong"}

  dimension: reason {
    group_label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', '' | capitalize }}" label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', '' | capitalize }} Reason"
    type: string
    sql: ${TABLE}.reason ;;
  }

  dimension: reason_wrong {
    group_label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', '' | capitalize }}" label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', '' | capitalize }} Reason Wrong"
    type: string
    sql: CASE WHEN ${wrong} THEN ${reason} END ;;
  }
}
