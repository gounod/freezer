jQuery(document).ready(function($) {
  $( "#food_embedded_at" ).dateDropper({format: "d.m.Y", lang: "de", minYear: "current year", maxYear: "2025", years_multiple: 5});
  $( "#food_best_before" ).dateDropper({format: "d.m.Y", lang: "de", minYear: "current year", maxYear: "2025", years_multiple: 5});
});