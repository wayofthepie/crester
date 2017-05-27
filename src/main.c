#include <string.h>
#include <stdio.h>
#include <ulfius.h>
#include <jansson.h>
#include "lib.h"

#define PORT 8080

int callback_json_stuff (const struct _u_request * request, struct _u_response * response, void * user_data) {
  y_log_message(Y_LOG_LEVEL_DEBUG, "Building some json bitch!");
  json_t *json = json_object();
  json_object_set(json, "test", json_string("Woop!"));
  ulfius_set_json_body_response(response, 200, json);
  return U_CALLBACK_CONTINUE;
}

int main(void) {
  struct _u_instance instance;

  if (ulfius_init_instance(&instance, PORT, NULL, NULL) != U_OK) {
    fprintf(stderr, "Error ulfius_init_instance, abort\n");
    return(1);
  }

  y_init_logs("crester", Y_LOG_MODE_CONSOLE, Y_LOG_LEVEL_DEBUG, NULL, "Starting crester");

  ulfius_add_endpoint_by_val(&instance, "GET", "/test", NULL, 0, &callback_json_stuff, NULL);

  if (ulfius_start_framework(&instance) == U_OK) {
    printf("Start framework on port %d\n", instance.port);

    getchar();
  } else {
    fprintf(stderr, "Error starting framework\n");
  }
  printf("End framework\n");

  ulfius_stop_framework(&instance);
  ulfius_clean_instance(&instance);

  return 0;
}
