class FiltersState {
  static Map<String, dynamic>? tempPetFilters;
  static Map<String, dynamic>? tempOngFilters;

  static Map<String, dynamic>? petCurrentFilters;
  static Map<String, dynamic>? ongCurrentFilters;

  static void setPetCurrentFilters(Map<String, dynamic>? newFilters) {
    if (newFilters != null) {
      tempPetFilters = petCurrentFilters;
      petCurrentFilters = newFilters;
    }
  }

  static void setOngCurrentFilters(Map<String, dynamic>? newFilters) {
    if (newFilters != null) {
      tempOngFilters = ongCurrentFilters;
      ongCurrentFilters = newFilters;
    }
  }
}
