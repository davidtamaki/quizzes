view: all_wrong_area_checks {
  view_label: "2) Answer Checks"
  dimension: all_wrong_reasons {
    type: string
    sql: all_wrong_area_checks ;;
  }
  measure: total_wrong_reasons {type: count_distinct sql: ${answers.pk} ;;}
}
