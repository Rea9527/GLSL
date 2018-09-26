

#include "main.h"

int main() {

  // initialize
  if (!glfwInit()) {
    return -1;
  }

  // glfw forward compatibility
  glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  // create glfw window
  GLFWwindow* window = glfwCreateWindow(640, 480, "GLSL 4", NULL, NULL);
  if (!window) {
    glfwTerminate();
    return -1;
  }
  glfwMakeContextCurrent(window);

  // gl load generator setting
  int ogl_loaded = ogl_LoadFunctions();
  if (ogl_loaded == ogl_LOAD_FAILED) {
    glfwDestroyWindow(window);
    return -1;
  }
  int num_failed = ogl_loaded - ogl_LOAD_SUCCEEDED;
  cout << "Number of functions that failed to load: " << num_failed << endl;

  // buffer settings
  glEnable(GL_DEPTH_TEST);


  // GL MAIN LOOP
  while (!glfwWindowShouldClose(window)) {

    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glfwPollEvents();


    // swap front and back buffers
    glfwSwapBuffers(window);
  }


}