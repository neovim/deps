typedef struct {
  // ^ keyword.type
  //    ^ keyword.type
  a_t b;
  // <- type
  //  ^ property

  unsigned c_t (*d)[2];
  // ^ type.builtin
  //       ^ type.builtin
  //             ^ property
}, T, V;
// ^ type.definition
//    ^ type.definition

int main(const char string[SIZE]) {
// <- type.builtin
//  ^ function
//        ^ keyword.modifier
//             ^ type.builtin
//                   ^ constant
//                         ^ constant

  return foo.bar + foo.baz();
  // ^ keyword.return
  //     ^ constant
  //         ^ property
  //                   ^ function.call

error:
  // <- label
  return 0;
}
