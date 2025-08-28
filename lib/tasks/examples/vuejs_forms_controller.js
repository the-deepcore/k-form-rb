import { Controller } from "stimulus"
import { FormStore } from 'k-form-js'

// OPTIONAL: import a custom vuex plugin that allows adding additional behaviour
// import plugin from 'path/to/plugin'

// OPTIONAL: use custom components
// import CustomComponent from 'path/to/plugin'

export default class extends Controller {

  static values = {
    initialTouch: Boolean,  // if true then all inputs are considered as touched (by default the value is false)
    disableValidation: Boolean, // if true then user inputs will not be revalidated on the fly
  }

  getHttpMethod(element) {
    let methodInput = element.querySelector("input[name='_method']");
    if (methodInput) {
      return methodInput.value
    } else {
      return null
    }

  }
  connect() {
    let { controller, values: serializedValues, validationUrl, ...others} = this.element.dataset
    let values = JSON.parse(serializedValues || {});
    let authenticityToken = this.element.querySelector("input[name='authenticity_token']")?.value
    let httpMethod = this.getHttpMethod(this.element) || 'POST'
    let globalauthenticityToken = document.querySelectorAll('meta[name=csrf-token]')[0].content

    const app = new FormStore(Object.assign( {
      authenticityToken: authenticityToken,
      additionalComponents: {
        // 'k-custom_component': CustomComponent
      }, // optional
      plugins:[
        // plugin
      ],  // optional
      element: this.element.firstElementChild,
      globalauthenticityToken: globalauthenticityToken,
      httpMethod: httpMethod,
      validationUrl: validationUrl,
      values: values,
      initialTouch: this.initialTouchValue,
      disableValidation: this.disableValidationValue,
    }, others)).app
  }
}