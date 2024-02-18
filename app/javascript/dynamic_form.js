document.addEventListener('turbo:load', () => {
    const inputTypeSelect = document.getElementById('input_text_select');
  
    inputTypeSelect.addEventListener('change', () => {
      const selection = inputTypeSelect.value;
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
            <textarea name="text" id="text_input" class="plain-text"></textarea>
          </div>
        `;
      }
    });
  });
  