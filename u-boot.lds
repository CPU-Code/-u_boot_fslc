OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
 /DISCARD/ : { *(.rel._secure*) }
 . = 0x00000000;
 . = ALIGN(4);
 .text :
 {
  *(.__image_copy_start)
  *(.vectors)
  arch/arm/cpu/armv7/start.o (.text*)
 }
 .__efi_runtime_start : {
  *(.__efi_runtime_start)
 }
 .efi_runtime : {
  *(.text.efi_runtime*)
  *(.rodata.efi_runtime*)
  *(.data.efi_runtime*)
 }
 .__efi_runtime_stop : {
  *(.__efi_runtime_stop)
 }
 .text_rest :
 {
  *(.text*)
 }
 .__secure_start
 : {
  KEEP(*(.__secure_start))
 }
 .secure_text 0x00020000 :
  AT(ADDR(.__secure_start) + SIZEOF(.__secure_start))
 {
  *(._secure.text)
 }
 .secure_data : AT(LOADADDR(.secure_text) + SIZEOF(.secure_text))
 {
  *(._secure.data)
 }
 .secure_stack ALIGN(ADDR(.secure_data) + SIZEOF(.secure_data),
       CONSTANT(COMMONPAGESIZE)) (NOLOAD) :
  AT(LOADADDR(.secure_data) + SIZEOF(.secure_data))
 {
  KEEP(*(.__secure_stack_start))
  . = . + 4 * (1 << 10);
  . = ALIGN(CONSTANT(COMMONPAGESIZE));
  KEEP(*(.__secure_stack_end))
  ASSERT((. - ADDR(.secure_text)) <= (64 * 1024),
         "Error: secure section exceeds secure memory size");
 }
 . = LOADADDR(.secure_stack);
 .__secure_end : AT(ADDR(.__secure_end)) {
  *(.__secure_end)
  LONG(0x1d1071c);
 }
 . = ALIGN(4);
 .rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
 . = ALIGN(4);
 .data : {
  *(.data*)
 }
 . = ALIGN(4);
 . = .;
 . = ALIGN(4);
 .u_boot_list : {
  KEEP(*(SORT(.u_boot_list*)));
 }
 . = ALIGN(4);
 .efi_runtime_rel_start :
 {
  *(.__efi_runtime_rel_start)
 }
 .efi_runtime_rel : {
  *(.rel*.efi_runtime)
  *(.rel*.efi_runtime.*)
 }
 .efi_runtime_rel_stop :
 {
  *(.__efi_runtime_rel_stop)
 }
 . = ALIGN(4);
 .image_copy_end :
 {
  *(.__image_copy_end)
 }
 .rel_dyn_start :
 {
  *(.__rel_dyn_start)
 }
 .rel.dyn : {
  *(.rel*)
 }
 .rel_dyn_end :
 {
  *(.__rel_dyn_end)
 }
 .end :
 {
  *(.__end)
 }
 _image_binary_end = .;
 . = ALIGN(4096);
 .mmutable : {
  *(.mmutable)
 }
 .bss_start __rel_dyn_start (OVERLAY) : {
  KEEP(*(.__bss_start));
  __bss_base = .;
 }
 .bss __bss_base (OVERLAY) : {
  *(.bss*)
   . = ALIGN(4);
   __bss_limit = .;
 }
 .bss_end __bss_limit (OVERLAY) : {
  KEEP(*(.__bss_end));
 }
 .dynsym _image_binary_end : { *(.dynsym) }
 .dynbss : { *(.dynbss) }
 .dynstr : { *(.dynstr*) }
 .dynamic : { *(.dynamic*) }
 .plt : { *(.plt*) }
 .interp : { *(.interp*) }
 .gnu.hash : { *(.gnu.hash) }
 .gnu : { *(.gnu*) }
 .ARM.exidx : { *(.ARM.exidx*) }
 .gnu.linkonce.armexidx : { *(.gnu.linkonce.armexidx.*) }
}
