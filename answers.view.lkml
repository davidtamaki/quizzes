view: answers {
  label: "1) The Quizzard Results"
  sql_table_name: quizzes.results ;;

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

  dimension: question_string {
    hidden: yes
    type: string
    sql: CONCAT('Question ',${TABLE}.question) ;;
    order_by_field: question
    link: {
      label: "See Wrong Reasons"
      url: "{{drill_common_wrong_reasons._link}}"
      }
  }

  dimension: quiz_name {
    type: string
    sql: ${TABLE}.quiz_name ;;
  }

  dimension: question {
    type: number
    sql: CAST(${TABLE}.question AS INT64) ;;
    link: {
      label: "See Wrong Reasons"
      url: "{{drill_common_wrong_reasons._link}}"
      }
  }

  dimension: question_passed {
    type: number
    sql: CASE WHEN ${passed} THEN ${question} END ;;
  }

  measure: all_questions_passed {
    type: list
    list_field: question_passed
  }

  dimension: results {
    hidden: yes
    sql: ${TABLE}.results ;;
  }

  dimension: scheduled_plan_id {
    hidden: yes
    type: number
    sql: ${TABLE}.scheduled_plan_id ;;
  }

  dimension_group: submitted {
    type: time
    sql: ${TABLE}.submitted_at ;;
  }

  dimension: url {
    hidden: yes
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: user_id {
    hidden: yes
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

  dimension: all_wrong_reasons {
    type: string
    sql: ARRAY_TO_STRING(${wrong_array},', ') ;;
  }

  # todo need a better way to do this (only counts when question has been attempted)
  measure: total_questions {
    type: count_distinct
    sql: ${question} ;;
    drill_fields: [question_string, tries, correct_rate, users_with_correct, users_with_wrong]}

  measure: users {
    type: count_distinct
    sql: ${user_id} ;; }

  measure: users_with_correct {
    type: count_distinct
    sql: ${user_id} ;;
    filters: { field: passed
      value: "Yes"
      }
    }

  measure: tries {
    type: count
    link: {
      label: "Correct Rate by Question"
      url: "{{ drill_correct_rate_by_question._link}}&sorts=answers.question&vis={% if passed._is_filtered %}{% else %}%7B%22color_application%22%3A%7B%22collection_id%22%3A%226c27c30e-5523-4080-82ae-272146e699d0%22%2C%22palette_id%22%3A%2287654122-8144-4720-8259-82ac9908d5f4%22%2C%22options%22%3A%7B%22steps%22%3A5%7D%7D%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22y_axes%22%3A%5B%7B%22label%22%3Anull%2C%22orientation%22%3A%22left%22%2C%22series%22%3A%5B%7B%22axisId%22%3A%22answers.tries%22%2C%22id%22%3A%22answers.tries%22%2C%22name%22%3A%22Tries%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Atrue%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22type%22%3A%22linear%22%7D%2C%7B%22label%22%3Anull%2C%22orientation%22%3A%22right%22%2C%22series%22%3A%5B%7B%22axisId%22%3A%22answers.correct_rate%22%2C%22id%22%3A%22answers.correct_rate%22%2C%22name%22%3A%22Correct+Rate%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Atrue%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22type%22%3A%22linear%22%7D%5D%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22limit_displayed_rows%22%3Afalse%2C%22legend_position%22%3A%22center%22%2C%22series_types%22%3A%7B%22answers.right_rate%22%3A%22line%22%2C%22answers.correct_rate%22%3A%22line%22%7D%2C%22point_style%22%3A%22none%22%2C%22series_colors%22%3A%7B%7D%2C%22show_value_labels%22%3Atrue%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_column%22%2C%22hidden_fields%22%3A%5B%5D%7D{% endif %}"
      }
  }
  measure: wrong_tries {
    type: count
    filters: {
      field: passed
      value: "No"
      }
    link: {
      label: "See Wrong Reasons"
      url: "{{drill_common_wrong_reasons._link}}"
      }
  }

  measure: correct_tries {
    type: count
    filters: {
      field: passed
      value: "Yes"
    }
  }

  measure: users_with_wrong {
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: passed
      value: "No"
    }
    link: {
      label: "See Wrong Reasons"
      url: "{{drill_common_wrong_reasons._link}}"
    }
  }

  measure: correct_answers {
    type: count_distinct
    sql: ${question} ;;
    filters: {
      field: passed
      value: "Yes"
      }
  }

  measure: questions_wrong {
    hidden: yes
    type: count_distinct
    sql: ${question} ;;
    filters: {
      field: passed
      value: "No"
      }
    link: {
      label: "See Wrong Reasons"
      url: "{{drill_common_wrong_reasons._link}}"
      }
  }

  measure: percentage_complete {
    type: number
    sql: SAFE_DIVIDE(${correct_answers},${total_questions}) ;;
    value_format_name: percent_1
  }

  measure: correct_rate {
    type: number
    sql: SAFE_DIVIDE(${correct_tries},${tries}) ;;
    value_format_name: percent_1
    link: {
      label: "See Wrong Reasons"
      url: "{% if question._is_selected or question_string._is_selected %}{% else %}{{drill_common_wrong_reasons._link}}{% endif %}"
      }
  }

  measure: wrong_rate {
    type: number
    sql: SAFE_DIVIDE(${wrong_tries},${tries}) ;;
    value_format_name: percent_1
    link: {
      label: "See Wrong Reasons"
      url: "{{drill_common_wrong_reasons._link}}"
      }
  }

  measure: highest_question_passed {
    type: max
    sql: ${question} ;;
    filters: {
      field: passed
      value: "Yes"
      }
  }
  measure: highest_question_tried {
    type: max
    sql: ${question} ;;
  }

  measure: drill_common_wrong_reasons {
    type: sum
    hidden: yes
    sql: 1 ;;
    filters: {
      field: all_wrong_area_checks.all_wrong_reasons
      value: "-NULL"
      }
    drill_fields: [all_wrong_area_checks.all_wrong_reasons, all_wrong_area_checks.total_wrong_reasons]
  }

  measure: drill_correct_rate_by_question  {
    type: sum
    hidden: yes
    sql: 1 ;;
    drill_fields: [answers.question,answers.correct_rate,answers.tries]
  }
}
