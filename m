From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Mar 2018 19:28:55 +0000
Subject: [GIT PULL 07/10] s390/char: Rename EBCDIC keymap variables
Message-Id: <20180314192858.172855-8-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

The Linux Virtual Terminal (VT) layer provides a default keymap
which is compiled when VT layer is enabled. But at the same time
we are also compiling the EBCDIC keymap and this causes the linker
to complain.

So let's rename the EBCDIC keymap variables to prevent linker
conflict.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <f670a2698d2372e1e990c48a29334ffe894804b1.1519315352.git.alifm@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/char/defkeymap.c | 64 ++++++++++++++++++++++---------------------
 drivers/s390/char/keyboard.c  | 32 +++++++++++-----------
 drivers/s390/char/keyboard.h  | 11 ++++++++
 3 files changed, 60 insertions(+), 47 deletions(-)

diff --git a/drivers/s390/char/defkeymap.c b/drivers/s390/char/defkeymap.c
index 98a5c459a1bf..60845d467a1b 100644
--- a/drivers/s390/char/defkeymap.c
+++ b/drivers/s390/char/defkeymap.c
@@ -9,7 +9,9 @@
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
 
-u_short plain_map[NR_KEYS] = {
+#include "keyboard.h"
+
+u_short ebc_plain_map[NR_KEYS] = {
 	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,
 	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,
 	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,
@@ -85,12 +87,12 @@ static u_short shift_ctrl_map[NR_KEYS] = {
 	0xf20a,	0xf108,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-ushort *key_maps[MAX_NR_KEYMAPS] = {
-	plain_map, shift_map, NULL, NULL,
+ushort *ebc_key_maps[MAX_NR_KEYMAPS] = {
+	ebc_plain_map, shift_map, NULL, NULL,
 	ctrl_map, shift_ctrl_map, NULL,
 };
 
-unsigned int keymap_count = 4;
+unsigned int ebc_keymap_count = 4;
 
 
 /*
@@ -99,7 +101,7 @@ unsigned int keymap_count = 4;
  * the default and allocate dynamically in chunks of 512 bytes.
  */
 
-char func_buf[] = {
+char ebc_func_buf[] = {
 	'\033', '[', '[', 'A', 0, 
 	'\033', '[', '[', 'B', 0, 
 	'\033', '[', '[', 'C', 0, 
@@ -123,37 +125,37 @@ char func_buf[] = {
 };
 
 
-char *funcbufptr = func_buf;
-int funcbufsize = sizeof(func_buf);
-int funcbufleft = 0;          /* space left */
+char *ebc_funcbufptr = ebc_func_buf;
+int ebc_funcbufsize = sizeof(ebc_func_buf);
+int ebc_funcbufleft;		/* space left */
 
-char *func_table[MAX_NR_FUNC] = {
-	func_buf + 0,
-	func_buf + 5,
-	func_buf + 10,
-	func_buf + 15,
-	func_buf + 20,
-	func_buf + 25,
-	func_buf + 31,
-	func_buf + 37,
-	func_buf + 43,
-	func_buf + 49,
-	func_buf + 55,
-	func_buf + 61,
-	func_buf + 67,
-	func_buf + 73,
-	func_buf + 79,
-	func_buf + 85,
-	func_buf + 91,
-	func_buf + 97,
-	func_buf + 103,
-	func_buf + 109,
+char *ebc_func_table[MAX_NR_FUNC] = {
+	ebc_func_buf + 0,
+	ebc_func_buf + 5,
+	ebc_func_buf + 10,
+	ebc_func_buf + 15,
+	ebc_func_buf + 20,
+	ebc_func_buf + 25,
+	ebc_func_buf + 31,
+	ebc_func_buf + 37,
+	ebc_func_buf + 43,
+	ebc_func_buf + 49,
+	ebc_func_buf + 55,
+	ebc_func_buf + 61,
+	ebc_func_buf + 67,
+	ebc_func_buf + 73,
+	ebc_func_buf + 79,
+	ebc_func_buf + 85,
+	ebc_func_buf + 91,
+	ebc_func_buf + 97,
+	ebc_func_buf + 103,
+	ebc_func_buf + 109,
 	NULL,
 };
 
-struct kbdiacruc accent_table[MAX_DIACR] = {
+struct kbdiacruc ebc_accent_table[MAX_DIACR] = {
 	{'^', 'c', 0003},	{'^', 'd', 0004},
 	{'^', 'z', 0032},	{'^', 0012, 0000},
 };
 
-unsigned int accent_table_size = 4;
+unsigned int ebc_accent_table_size = 4;
diff --git a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
index 5b505fdaedec..db1fbf9b00b5 100644
--- a/drivers/s390/char/keyboard.c
+++ b/drivers/s390/char/keyboard.c
@@ -54,24 +54,24 @@ kbd_alloc(void) {
 	kbd = kzalloc(sizeof(struct kbd_data), GFP_KERNEL);
 	if (!kbd)
 		goto out;
-	kbd->key_maps = kzalloc(sizeof(key_maps), GFP_KERNEL);
+	kbd->key_maps = kzalloc(sizeof(ebc_key_maps), GFP_KERNEL);
 	if (!kbd->key_maps)
 		goto out_kbd;
-	for (i = 0; i < ARRAY_SIZE(key_maps); i++) {
-		if (key_maps[i]) {
-			kbd->key_maps[i] = kmemdup(key_maps[i],
+	for (i = 0; i < ARRAY_SIZE(ebc_key_maps); i++) {
+		if (ebc_key_maps[i]) {
+			kbd->key_maps[i] = kmemdup(ebc_key_maps[i],
 						   sizeof(u_short) * NR_KEYS,
 						   GFP_KERNEL);
 			if (!kbd->key_maps[i])
 				goto out_maps;
 		}
 	}
-	kbd->func_table = kzalloc(sizeof(func_table), GFP_KERNEL);
+	kbd->func_table = kzalloc(sizeof(ebc_func_table), GFP_KERNEL);
 	if (!kbd->func_table)
 		goto out_maps;
-	for (i = 0; i < ARRAY_SIZE(func_table); i++) {
-		if (func_table[i]) {
-			kbd->func_table[i] = kstrdup(func_table[i],
+	for (i = 0; i < ARRAY_SIZE(ebc_func_table); i++) {
+		if (ebc_func_table[i]) {
+			kbd->func_table[i] = kstrdup(ebc_func_table[i],
 						     GFP_KERNEL);
 			if (!kbd->func_table[i])
 				goto out_func;
@@ -81,22 +81,22 @@ kbd_alloc(void) {
 		kzalloc(sizeof(fn_handler_fn *) * NR_FN_HANDLER, GFP_KERNEL);
 	if (!kbd->fn_handler)
 		goto out_func;
-	kbd->accent_table = kmemdup(accent_table,
+	kbd->accent_table = kmemdup(ebc_accent_table,
 				    sizeof(struct kbdiacruc) * MAX_DIACR,
 				    GFP_KERNEL);
 	if (!kbd->accent_table)
 		goto out_fn_handler;
-	kbd->accent_table_size = accent_table_size;
+	kbd->accent_table_size = ebc_accent_table_size;
 	return kbd;
 
 out_fn_handler:
 	kfree(kbd->fn_handler);
 out_func:
-	for (i = 0; i < ARRAY_SIZE(func_table); i++)
+	for (i = 0; i < ARRAY_SIZE(ebc_func_table); i++)
 		kfree(kbd->func_table[i]);
 	kfree(kbd->func_table);
 out_maps:
-	for (i = 0; i < ARRAY_SIZE(key_maps); i++)
+	for (i = 0; i < ARRAY_SIZE(ebc_key_maps); i++)
 		kfree(kbd->key_maps[i]);
 	kfree(kbd->key_maps);
 out_kbd:
@@ -112,10 +112,10 @@ kbd_free(struct kbd_data *kbd)
 
 	kfree(kbd->accent_table);
 	kfree(kbd->fn_handler);
-	for (i = 0; i < ARRAY_SIZE(func_table); i++)
+	for (i = 0; i < ARRAY_SIZE(ebc_func_table); i++)
 		kfree(kbd->func_table[i]);
 	kfree(kbd->func_table);
-	for (i = 0; i < ARRAY_SIZE(key_maps); i++)
+	for (i = 0; i < ARRAY_SIZE(ebc_key_maps); i++)
 		kfree(kbd->key_maps[i]);
 	kfree(kbd->key_maps);
 	kfree(kbd);
@@ -131,7 +131,7 @@ kbd_ascebc(struct kbd_data *kbd, unsigned char *ascebc)
 	int i, j, k;
 
 	memset(ascebc, 0x40, 256);
-	for (i = 0; i < ARRAY_SIZE(key_maps); i++) {
+	for (i = 0; i < ARRAY_SIZE(ebc_key_maps); i++) {
 		keymap = kbd->key_maps[i];
 		if (!keymap)
 			continue;
@@ -158,7 +158,7 @@ kbd_ebcasc(struct kbd_data *kbd, unsigned char *ebcasc)
 	int i, j, k;
 
 	memset(ebcasc, ' ', 256);
-	for (i = 0; i < ARRAY_SIZE(key_maps); i++) {
+	for (i = 0; i < ARRAY_SIZE(ebc_key_maps); i++) {
 		keymap = kbd->key_maps[i];
 		if (!keymap)
 			continue;
diff --git a/drivers/s390/char/keyboard.h b/drivers/s390/char/keyboard.h
index a074d9711628..c467589c7f45 100644
--- a/drivers/s390/char/keyboard.h
+++ b/drivers/s390/char/keyboard.h
@@ -14,6 +14,17 @@
 
 struct kbd_data;
 
+extern int ebc_funcbufsize, ebc_funcbufleft;
+extern char *ebc_func_table[MAX_NR_FUNC];
+extern char ebc_func_buf[];
+extern char *ebc_funcbufptr;
+extern unsigned int ebc_keymap_count;
+
+extern struct kbdiacruc ebc_accent_table[];
+extern unsigned int ebc_accent_table_size;
+extern unsigned short *ebc_key_maps[MAX_NR_KEYMAPS];
+extern unsigned short ebc_plain_map[NR_KEYS];
+
 typedef void (fn_handler_fn)(struct kbd_data *);
 
 /*
-- 
2.14.3
