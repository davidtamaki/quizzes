view: question_all_wrong {
  dimension: question_all_wrong {
    type: string
    sql: question_all_wrong ;;
  }
  measure: times_wrong {type: count_distinct sql: ${answers_test.pk} ;;}
}
