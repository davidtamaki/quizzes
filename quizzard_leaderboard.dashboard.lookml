- dashboard: the_quizzard_leaderboard
  title: The Quizzard Leaderboard
  layout: newspaper
  elements:
  - title: Total Questions
    name: Total Questions
    model: quizzes
    explore: answers
    type: single_value
    fields: [answers.total_questions, answers.tries, answers.questions_right, answers.wrong_answers,
      answers.right_answers]
    limit: 500
    series_types: {}
    hidden_fields: []
    y_axes: []
    row: 10
    col: 1
    width: 6
    height: 2
  - title: Total Tries
    name: Total Tries
    model: quizzes
    explore: answers
    type: single_value
    fields: [answers.total_questions, answers.tries, answers.wrong_answers]
    limit: 500
    series_types: {}
    hidden_fields: [answers.total_questions]
    y_axes: []
    listen: {}
    row: 2
    col: 1
    width: 6
    height: 2
  - title: Wrong Answers
    name: Wrong Answers
    model: quizzes
    explore: answers
    type: looker_pie
    fields: [answers.passed, answers.tries]
    fill_fields: [answers.passed]
    sorts: [answers.tries desc]
    limit: 500
    value_labels: labels
    label_type: val
    inner_radius: 50
    color_application:
      collection_id: 80e60a97-c02b-4a41-aa05-83522ee2144b
      palette_id: 629b455f-662e-4854-a424-4f0c9d4bbdfb
      options:
        steps: 5
    series_colors:
      'No': "#B42F37"
      'Yes': "#3FB0D5"
    series_labels:
      'No': Wrong
      'Yes': Correct
    series_types: {}
    hidden_fields: [answers.questions_right]
    y_axes: []
    title_hidden: true
    listen: {}
    row: 4
    col: 1
    width: 6
    height: 4
  - title: Correct Rate by Question
    name: Correct Rate by Question
    model: quizzes
    explore: answers
    type: looker_column
    fields: [answers.question, answers.correct_rate, answers.tries]
    sorts: [answers.question]
    limit: 500
    color_application:
      collection_id: 6c27c30e-5523-4080-82ae-272146e699d0
      palette_id: 87654122-8144-4720-8259-82ac9908d5f4
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: !!null '', orientation: left, series: [{axisId: answers.tries,
            id: answers.tries, name: Tries}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: answers.correct_rate, id: answers.correct_rate,
            name: Correct Rate}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types:
      answers.right_rate: line
      answers.correct_rate: line
    point_style: none
    series_colors: {}
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    listen: {}
    row: 0
    col: 7
    width: 16
    height: 7
  - title: Top Answerers
    name: Top Answerers
    model: quizzes
    explore: answers
    type: table
    fields: [answers.email, answers.correct_answers, answers.correct_rate, answers.tries,
      answers.all_questions_passed]
    sorts: [answers.correct_answers desc]
    limit: 500
    color_application:
      collection_id: 6c27c30e-5523-4080-82ae-272146e699d0
      palette_id: 87654122-8144-4720-8259-82ac9908d5f4
      options:
        steps: 5
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: '', orientation: left, series: [{axisId: answers.right_answers,
            id: answers.right_answers, name: Right Answers}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: answers.right_rate,
            id: answers.right_rate, name: Right Rate}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    series_types: {}
    point_style: none
    series_colors: {}
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    listen: {}
    row: 7
    col: 13
    width: 10
    height: 5
  - name: <div style="text-align:center;">Need Help?</div>
    type: text
    title_text: <div style="text-align:center;">Need Help?</div>
    subtitle_text: ''
    body_text: <a target="_blank" type="button" class="btn btn-primary btn-lg btn-block"
      href="https://docs.google.com/document/d/14U5JQ5hIs6gKGsGhh00yZVZuuFlzwlRhvLlijRQZcxM/edit">See
      the Documentation</a>
    row: 0
    col: 1
    width: 6
    height: 2
  - title: Correct Rate
    name: Correct Rate
    model: quizzes
    explore: answers
    type: single_value
    fields: [answers.correct_rate]
    limit: 500
    column_limit: 50
    series_types: {}
    listen: {}
    row: 8
    col: 1
    width: 6
    height: 2
  - title: Your Score
    name: Your Score
    model: quizzes
    explore: answers
    type: looker_single_record
    fields: [answers.email, answers.correct_answers, answers.percentage_complete,
      answers.correct_rate, answers.tries, answers.all_questions_passed]
    filters:
      answers.is_current_user: 'Yes'
    sorts: [answers.correct_answers desc]
    limit: 500
    color_application:
      collection_id: 6c27c30e-5523-4080-82ae-272146e699d0
      palette_id: 87654122-8144-4720-8259-82ac9908d5f4
      options:
        steps: 5
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: '', orientation: left, series: [{axisId: answers.right_answers,
            id: answers.right_answers, name: Right Answers}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: answers.right_rate,
            id: answers.right_rate, name: Right Rate}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    series_types: {}
    point_style: none
    series_colors: {}
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    listen: {}
    row: 7
    col: 7
    width: 6
    height: 5

