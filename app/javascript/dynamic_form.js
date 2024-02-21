document.addEventListener('turbo:load', () => {
  const inputTypeSelect = document.getElementById('input_text_select');
  const inputKeySelect = document.getElementById('input_key_select');
  // Add textCache to save input text value after reload
  const textCache = document.getElementById('text_cache').value;
  const keyCache = document.getElementById('key_cache').value;

  const validateFileExtension = () => {
    const fileInput = document.getElementById('file_input');
    const cipherSelection = document.getElementById('input_key_select');
    
    if (fileInput && cipherSelection && fileInput.files.length > 0) {
      const fileName = fileInput.files[0].name;
      const fileExt = fileName.split('.').pop().toLowerCase();
      const selectedCipher = cipherSelection.value;
      
      if (!(selectedCipher === 'vigenere3' || selectedCipher === 'super') && fileExt !== 'txt') {
        alert('Only .txt files are allowed for this cipher.');
        fileInput.value = ''; // Reset the file input
      }
    }
  };
  
  const updateDynamicField = (selection, dynamic_element) => {
    if (dynamic_element.id === 'dynamic_input_text_container'){
      if (selection === 'file') {
        document.getElementById('input_type').value = 'file';
        dynamic_element.innerHTML = `
          <div class="label-container">
            <label for="file_input">Input File:</label>
          </div>
          <div class="input-container">
            <input type="file" name="file" id="file_input" class="file-input">
          </div>
        `;
      } else {
        document.getElementById('input_type').value = 'text';
        dynamic_element.innerHTML = `
          <div class="label-container">
            <label for="text_input">Input Text:</label>
          </div>
          <div class="input-container">
            <textarea name="text" id="text_input" class="plain-text">${textCache}</textarea>
          </div>
        `;
      } 
    }
    else if (dynamic_element.id === 'dynamic_key_container') {
      if (selection === 'affine') {
        dynamic_element.innerHTML = `
          <div class="field-container" id="m_field_container">
            <div class="label-container">
              <label for="m">m value: </label>
            </div>
            <div class="input-container">
              <input type="number" id="m" name="m" class="key-text">
            </div>
          </div>
          <div class="field-container" id="b_field_container">
            <div class="label-container">
              <label for="b">b value: </label>
            </div>
            <div class="input-container">
              <input type="number" id="b" name="b" class="key-text" min="0" max="25">
            </div>
          </div>
      `;
      } else if (selection === 'hill'){
        dynamic_element.innerHTML = `
          <div class="field-container" id="n_field_container">
            <div class="label-container">
              <label for="n">Matrix size(n): </label>
            </div>
            <div class="input-container">
              <input type="number" id="n" name="n" class="key-text" min="2">
            </div>
          </div>
          <div class="field-container">
            <div class="label-container">
              <label for="key_input">Key: </label>
            </div>
            <div class="input-container">
              <textarea name="key" id="key_input" class="key-text">${keyCache}</textarea>
            </div>
          </div>
        `;
      } 
      
      
      else {
        // Show key
        dynamic_element.innerHTML = `
        <div class="field-container">
          <div class="label-container">
            <label for="key_input">Key: </label>
          </div>
          <div class="input-container">
            <textarea name="key" id="key_input" class="key-text">${keyCache}</textarea>
          </div>
        </div>
        `;
     }
    }
  };
  const cipherSelection = document.getElementById('input_key_select');
  const fileInput = document.getElementById('file_input');
  if (fileInput) {
    fileInput.addEventListener('change', validateFileExtension);
  }
  
  if (cipherSelection){
    cipherSelection.addEventListener('change', validateFileExtension)
  }
  
  // Get dynamic containers
  const dynamicInputText = document.getElementById('dynamic_input_text_container');
  const dynamicKeyContainer = document.getElementById('dynamic_key_container'); 

  // Initialize dynamic fields based on current selection
  updateDynamicField(inputTypeSelect.value, dynamicInputText);
  updateDynamicField(inputKeySelect.value, dynamicKeyContainer);

  // Update dynamic field on selection change
  inputTypeSelect.addEventListener('change', () => {
    updateDynamicField(inputTypeSelect.value, dynamicInputText);
  
    const newFileInput = document.getElementById('file_input');
    if (newFileInput){
      newFileInput.addEventListener('change', validateFileExtension)
    }
  });

  inputKeySelect.addEventListener('change', () => {
    updateDynamicField(inputKeySelect.value, dynamicKeyContainer);
  });

  fileInput.addEventListener('change', validateFileExtension);

});