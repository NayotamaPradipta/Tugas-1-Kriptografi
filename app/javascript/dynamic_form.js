document.addEventListener('turbo:load', () => {
  const inputTypeSelect = document.getElementById('input_text_select');
  // Add textCache to save input text value after reload
  const textCache = document.getElementById('text_cache').value;

  const updateDynamicField = (selection) => {
    const dynamicFieldContainer = document.getElementById('dynamic_field_container');
  
    if (selection === 'file') {
      dynamicFieldContainer.innerHTML = `
        <div class="label-container">
          <label for="file_input">Input File:</label>
        </div>
        <div class="input-container">
          <input type="file" name="file" id="file_input" class="file-input">
        </div>
      `;
    } else {
      dynamicFieldContainer.innerHTML = `
        <div class="label-container">
          <label for="text_input">Input Text:</label>
        </div>
        <div class="input-container">
          <textarea name="text" id="text_input" class="plain-text">${textCache}</textarea>
        </div>
      `;
    }
  };

  // Initialize dynamic field based on current selection
  updateDynamicField(inputTypeSelect.value);

  // Update dynamic field on selection change
  inputTypeSelect.addEventListener('change', () => {
    updateDynamicField(inputTypeSelect.value);
  });
});