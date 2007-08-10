Return-Path: <linux-kernel-owner+w=401wt.eu-S941351AbXHJQk5@vger.kernel.org>
Date: Fri, 10 Aug 2007 18:39:56 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: 2.6.23-rc2-mm2: drivers/s390/char/keyboard.c compile error
Message-ID: <20070810163956.GA3772@interface.famille.thibault.fr>
References: <20070809224254.11f42716.akpm@linux-foundation.org> <20070810155656.GH18938@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20070810155656.GH18938@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

Adrian Bunk, le Fri 10 Aug 2007 17:56:56 +0200, a =E9crit :
> On Thu, Aug 09, 2007 at 10:42:54PM -0700, Andrew Morton wrote:
> The change to drivers/s390/char/keyboard.c doesn't compile:

> (.text+0x2d666): undefined reference to `conv_uni_to_8bit'
> (.text+0x2d906): undefined reference to `conv_8bit_to_uni'

Ah, so s390 doesn't yet have the notion of consolemap and supposes
latin1...  Then fine, it's actually simpler, here is a patch.

Samuel

Turn the kernel accent_table into unicode, and extend ioctls KDGKBDIACR
and KDSKBDIACR into their equivalents KDGKBDIACRUC and KDSKBDIACR.

New function int conv_uni_to_8bit(u32 uni) for converting unicode into 8bit
_input_.  No, we don't want to store the translation, as it is potentially
sparse and large.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/drivers/acorn/char/defkeymap-l7200.c b/drivers/acorn/char/defk=
eymap-l7200.c
index 9e18ce7..28a5fbc 100644
--- a/drivers/acorn/char/defkeymap-l7200.c
+++ b/drivers/acorn/char/defkeymap-l7200.c
@@ -346,7 +346,7 @@ char *func_table[MAX_NR_FUNC] =3D {
 	0,
 };
=20
-struct kbdiacr accent_table[MAX_DIACR] =3D {
+struct kbdiacruc accent_table[MAX_DIACR] =3D {
 	{'`', 'A', '\300'},	{'`', 'a', '\340'},
 	{'\'', 'A', '\301'},	{'\'', 'a', '\341'},
 	{'^', 'A', '\302'},	{'^', 'a', '\342'},
diff --git a/drivers/char/consolemap.c b/drivers/char/consolemap.c
index 4b3916f..689d820 100644
--- a/drivers/char/consolemap.c
+++ b/drivers/char/consolemap.c
@@ -670,19 +670,29 @@ void con_protect_unimap(struct vc_data *vc, int rdonl=
y)
 		p->readonly =3D rdonly;
 }
=20
+/*
+ * Always use USER_MAP. These functions are used by the keyboard,
+ * which shouldn't be affected by G0/G1 switching, etc.
+ * If the user map still contains default values, i.e. the
+ * direct-to-font mapping, then assume user is using Latin1.
+ */
 /* may be called during an interrupt */
 u32 conv_8bit_to_uni(unsigned char c)
 {
-	/*
-	 * Always use USER_MAP. This function is used by the keyboard,
-	 * which shouldn't be affected by G0/G1 switching, etc.
-	 * If the user map still contains default values, i.e. the
-	 * direct-to-font mapping, then assume user is using Latin1.
-	 */
 	unsigned short uni =3D translations[USER_MAP][c];
 	return uni =3D=3D (0xf000 | c) ? c : uni;
 }
=20
+int conv_uni_to_8bit(u32 uni)
+{
+	int c;
+	for (c =3D 0; c < 0x100; c++)
+		if (translations[USER_MAP][c] =3D=3D uni ||
+		   (translations[USER_MAP][c] =3D=3D (c | 0xf000) && uni =3D=3D c))
+			return c;
+	return -1;
+}
+
 int
 conv_uni_to_pc(struct vc_data *conp, long ucs)=20
 {
diff --git a/drivers/char/defkeymap.c_shipped b/drivers/char/defkeymap.c_sh=
ipped
index 453a2f1..0aa419a 100644
--- a/drivers/char/defkeymap.c_shipped
+++ b/drivers/char/defkeymap.c_shipped
@@ -222,7 +222,7 @@ char *func_table[MAX_NR_FUNC] =3D {
 	NULL,
 };
=20
-struct kbdiacr accent_table[MAX_DIACR] =3D {
+struct kbdiacruc accent_table[MAX_DIACR] =3D {
 	{'`', 'A', '\300'},	{'`', 'a', '\340'},
 	{'\'', 'A', '\301'},	{'\'', 'a', '\341'},
 	{'^', 'A', '\302'},	{'^', 'a', '\342'},
diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 2ce0af1..3bec260 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -41,6 +41,7 @@
 #include <linux/sysrq.h>
 #include <linux/input.h>
 #include <linux/reboot.h>
+#include <linux/consolemap.h>
=20
 extern void ctrl_alt_del(void);
=20
@@ -403,9 +404,12 @@ static unsigned int handle_diacr(struct vc_data *vc, u=
nsigned int ch)
 		return d;
=20
 	if (kbd->kbdmode =3D=3D VC_UNICODE)
-		to_utf8(vc, conv_8bit_to_uni(d));
-	else if (d < 0x100)
-		put_queue(vc, d);
+		to_utf8(vc, d);
+	else {
+		int c =3D conv_uni_to_8bit(d);
+		if (c !=3D -1)
+			put_queue(vc, c);
+	}
=20
 	return ch;
 }
@@ -417,9 +421,12 @@ static void fn_enter(struct vc_data *vc)
 {
 	if (diacr) {
 		if (kbd->kbdmode =3D=3D VC_UNICODE)
-			to_utf8(vc, conv_8bit_to_uni(diacr));
-		else if (diacr < 0x100)
-			put_queue(vc, diacr);
+			to_utf8(vc, diacr);
+		else {
+			int c =3D conv_uni_to_8bit(diacr);
+			if (c !=3D -1)
+				put_queue(vc, c);
+		}
 		diacr =3D 0;
 	}
 	put_queue(vc, 13);
@@ -627,9 +634,12 @@ static void k_unicode(struct vc_data *vc, unsigned int=
 value, char up_flag)
 		return;
 	}
 	if (kbd->kbdmode =3D=3D VC_UNICODE)
-		to_utf8(vc, conv_8bit_to_uni(value));
-	else if (value < 0x100)
-		put_queue(vc, value);
+		to_utf8(vc, value);
+	else {
+		int c =3D conv_uni_to_8bit(value);
+		if (c !=3D -1)
+			put_queue(vc, c);
+	}
 }
=20
 /*
@@ -646,7 +656,12 @@ static void k_deadunicode(struct vc_data *vc, unsigned=
 int value, char up_flag)
=20
 static void k_self(struct vc_data *vc, unsigned char value, char up_flag)
 {
-	k_unicode(vc, value, up_flag);
+	unsigned int uni;
+	if (kbd->kbdmode =3D=3D VC_UNICODE)
+		uni =3D value;
+	else
+		uni =3D conv_8bit_to_uni(value);
+	k_unicode(vc, uni, up_flag);
 }
=20
 static void k_dead2(struct vc_data *vc, unsigned char value, char up_flag)
diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
index c6f6f42..e4d817b 100644
--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -23,6 +23,7 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/console.h>
+#include <linux/consolemap.h>
 #include <linux/signal.h>
 #include <linux/timex.h>
=20
@@ -582,10 +583,27 @@ int vt_ioctl(struct tty_struct *tty, struct file * fi=
le,
 	case KDGKBDIACR:
 	{
 		struct kbdiacrs __user *a =3D up;
+		struct kbdiacr diacr;
+		int i;
=20
 		if (put_user(accent_table_size, &a->kb_cnt))
 			return -EFAULT;
-		if (copy_to_user(a->kbdiacr, accent_table, accent_table_size*sizeof(stru=
ct kbdiacr)))
+		for (i =3D 0; i < accent_table_size; i++) {
+			diacr.diacr =3D conv_uni_to_8bit(accent_table[i].diacr);
+			diacr.base =3D conv_uni_to_8bit(accent_table[i].base);
+			diacr.result =3D conv_uni_to_8bit(accent_table[i].result);
+			if (copy_to_user(a->kbdiacr + i, &diacr, sizeof(struct kbdiacr)))
+				return -EFAULT;
+		}
+		return 0;
+	}
+	case KDGKBDIACRUC:
+	{
+		struct kbdiacrsuc __user *a =3D up;
+
+		if (put_user(accent_table_size, &a->kb_cnt))
+			return -EFAULT;
+		if (copy_to_user(a->kbdiacruc, accent_table, accent_table_size*sizeof(st=
ruct kbdiacruc)))
 			return -EFAULT;
 		return 0;
 	}
@@ -593,6 +611,30 @@ int vt_ioctl(struct tty_struct *tty, struct file * fil=
e,
 	case KDSKBDIACR:
 	{
 		struct kbdiacrs __user *a =3D up;
+		struct kbdiacr diacr;
+		unsigned int ct;
+		int i;
+
+		if (!perm)
+			return -EPERM;
+		if (get_user(ct,&a->kb_cnt))
+			return -EFAULT;
+		if (ct >=3D MAX_DIACR)
+			return -EINVAL;
+		accent_table_size =3D ct;
+		for (i =3D 0; i < ct; i++) {
+			if (copy_from_user(&diacr, a->kbdiacr + i, sizeof(struct kbdiacr)))
+				return -EFAULT;
+			accent_table[i].diacr =3D conv_8bit_to_uni(diacr.diacr);
+			accent_table[i].base =3D conv_8bit_to_uni(diacr.base);
+			accent_table[i].result =3D conv_8bit_to_uni(diacr.result);
+		}
+		return 0;
+	}
+
+	case KDSKBDIACRUC:
+	{
+		struct kbdiacrsuc __user *a =3D up;
 		unsigned int ct;
=20
 		if (!perm)
@@ -602,7 +644,7 @@ int vt_ioctl(struct tty_struct *tty, struct file * file,
 		if (ct >=3D MAX_DIACR)
 			return -EINVAL;
 		accent_table_size =3D ct;
-		if (copy_from_user(accent_table, a->kbdiacr, ct*sizeof(struct kbdiacr)))
+		if (copy_from_user(accent_table, a->kbdiacruc, ct*sizeof(struct kbdiacru=
c)))
 			return -EFAULT;
 		return 0;
 	}
diff --git a/drivers/s390/char/defkeymap.c b/drivers/s390/char/defkeymap.c
index 564baca..389346c 100644
--- a/drivers/s390/char/defkeymap.c
+++ b/drivers/s390/char/defkeymap.c
@@ -150,7 +150,7 @@ char *func_table[MAX_NR_FUNC] =3D {
 	NULL,
 };
=20
-struct kbdiacr accent_table[MAX_DIACR] =3D {
+struct kbdiacruc accent_table[MAX_DIACR] =3D {
 	{'^', 'c', '\003'},	{'^', 'd', '\004'},
 	{'^', 'z', '\032'},	{'^', '\012', '\000'},
 };
diff --git a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
index f62f9a4..5ab0d9e 100644
--- a/drivers/s390/char/keyboard.c
+++ b/drivers/s390/char/keyboard.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/sysrq.h>
=20
+#include <linux/consolemap.h>
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
 #include <asm/uaccess.h>
@@ -82,11 +83,11 @@ kbd_alloc(void) {
 	if (!kbd->fn_handler)
 		goto out_func;
 	kbd->accent_table =3D
-		kmalloc(sizeof(struct kbdiacr)*MAX_DIACR, GFP_KERNEL);
+		kmalloc(sizeof(struct kbdiacruc)*MAX_DIACR, GFP_KERNEL);
 	if (!kbd->accent_table)
 		goto out_fn_handler;
 	memcpy(kbd->accent_table, accent_table,
-	       sizeof(struct kbdiacr)*MAX_DIACR);
+	       sizeof(struct kbdiacruc)*MAX_DIACR);
 	kbd->accent_table_size =3D accent_table_size;
 	return kbd;
=20
@@ -183,8 +184,8 @@ kbd_ebcasc(struct kbd_data *kbd, unsigned char *ebcasc)
  * Otherwise, conclude that DIACR was not combining after all,
  * queue it and return CH.
  */
-static unsigned char
-handle_diacr(struct kbd_data *kbd, unsigned char ch)
+static unsigned int
+handle_diacr(struct kbd_data *kbd, unsigned int ch)
 {
 	int i, d;
=20
@@ -460,7 +461,6 @@ int
 kbd_ioctl(struct kbd_data *kbd, struct file *file,
 	  unsigned int cmd, unsigned long arg)
 {
-	struct kbdiacrs __user *a;
 	void __user *argp;
 	int ct, perm;
=20
@@ -481,17 +481,40 @@ kbd_ioctl(struct kbd_data *kbd, struct file *file,
 	case KDSKBSENT:
 		return do_kdgkb_ioctl(kbd, argp, cmd, perm);
 	case KDGKBDIACR:
-		a =3D argp;
+	{
+		struct kbdiacrs __user *a =3D argp;
+		struct kbdiacr diacr;
+		int i;
=20
 		if (put_user(kbd->accent_table_size, &a->kb_cnt))
 			return -EFAULT;
+		for (i =3D 0; i < kbd->accent_table_size; i++) {
+			diacr.diacr =3D kbd->accent_table[i].diacr;
+			diacr.base =3D kbd->accent_table[i].base;
+			diacr.result =3D kbd->accent_table[i].result;
+			if (copy_to_user(a->kbdiacr + i, &diacr, sizeof(struct kbdiacr)))
+			return -EFAULT;
+		}
+		return 0;
+	}
+	case KDGKBDIACRUC:
+	{
+		struct kbdiacrsuc __user *a =3D argp;
+
 		ct =3D kbd->accent_table_size;
-		if (copy_to_user(a->kbdiacr, kbd->accent_table,
-				 ct * sizeof(struct kbdiacr)))
+		if (put_user(ct, &a->kb_cnt))
+			return -EFAULT;
+		if (copy_to_user(a->kbdiacruc, kbd->accent_table,
+				 ct * sizeof(struct kbdiacruc)))
 			return -EFAULT;
 		return 0;
+	}
 	case KDSKBDIACR:
-		a =3D argp;
+	{
+		struct kbdiacrs __user *a =3D argp;
+		struct kbdiacr diacr;
+		int i;
+
 		if (!perm)
 			return -EPERM;
 		if (get_user(ct, &a->kb_cnt))
@@ -499,10 +522,31 @@ kbd_ioctl(struct kbd_data *kbd, struct file *file,
 		if (ct >=3D MAX_DIACR)
 			return -EINVAL;
 		kbd->accent_table_size =3D ct;
-		if (copy_from_user(kbd->accent_table, a->kbdiacr,
-				   ct * sizeof(struct kbdiacr)))
+		for (i =3D 0; i < ct; i++) {
+			if (copy_from_user(&diacr, a->kbdiacr + i, sizeof(struct kbdiacr)))
+				return -EFAULT;
+			kbd->accent_table[i].diacr =3D diacr.diacr;
+			kbd->accent_table[i].base =3D diacr.base;
+			kbd->accent_table[i].result =3D diacr.result;
+		}
+		return 0;
+	}
+	case KDSKBDIACRUC:
+	{
+		struct kbdiacrsuc __user *a =3D argp;
+
+		if (!perm)
+			return -EPERM;
+		if (get_user(ct, &a->kb_cnt))
+			return -EFAULT;
+		if (ct >=3D MAX_DIACR)
+			return -EINVAL;
+		kbd->accent_table_size =3D ct;
+		if (copy_from_user(kbd->accent_table, a->kbdiacruc,
+				   ct * sizeof(struct kbdiacruc)))
 			return -EFAULT;
 		return 0;
+	}
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/drivers/s390/char/keyboard.h b/drivers/s390/char/keyboard.h
index f7bf45c..5ccfe9c 100644
--- a/drivers/s390/char/keyboard.h
+++ b/drivers/s390/char/keyboard.h
@@ -25,9 +25,9 @@ struct kbd_data {
 	unsigned short **key_maps;
 	char **func_table;
 	fn_handler_fn **fn_handler;
-	struct kbdiacr *accent_table;
+	struct kbdiacruc *accent_table;
 	unsigned int accent_table_size;
-	unsigned char diacr;
+	unsigned int diacr;
 	unsigned short sysrq;
 };
=20
diff --git a/drivers/tc/lk201-map.c_shipped b/drivers/tc/lk201-map.c_shipped
index a9df8f5..4d2aba5 100644
--- a/drivers/tc/lk201-map.c_shipped
+++ b/drivers/tc/lk201-map.c_shipped
@@ -225,7 +225,7 @@ char *func_table[MAX_NR_FUNC] =3D {
 	0,
 };
=20
-struct kbdiacr accent_table[MAX_DIACR] =3D {
+struct kbdiacruc accent_table[MAX_DIACR] =3D {
 	{'`', 'A', '=C0'},	{'`', 'a', '=E0'},
 	{'\'', 'A', '=C1'},	{'\'', 'a', '=E1'},
 	{'^', 'A', '=C2'},	{'^', 'a', '=E2'},
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index 06b2768..e2bf7e5 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -16,4 +16,5 @@ extern u16 inverse_translate(struct vc_data *conp, int gl=
yph, int use_unicode);
 extern unsigned short *set_translate(int m, struct vc_data *vc);
 extern int conv_uni_to_pc(struct vc_data *conp, long ucs);
 extern u32 conv_8bit_to_uni(unsigned char c);
+extern int conv_uni_to_8bit(u32 uni);
 void console_map_init(void);
diff --git a/include/linux/kbd_diacr.h b/include/linux/kbd_diacr.h
index 1c1a3ff..7274ec6 100644
--- a/include/linux/kbd_diacr.h
+++ b/include/linux/kbd_diacr.h
@@ -2,7 +2,7 @@
 #define _DIACR_H
 #include <linux/kd.h>
=20
-extern struct kbdiacr accent_table[];
+extern struct kbdiacruc accent_table[];
 extern unsigned int accent_table_size;
=20
 #endif /* _DIACR_H */
diff --git a/include/linux/kd.h b/include/linux/kd.h
index 28be4fb..c91fc0c 100644
--- a/include/linux/kd.h
+++ b/include/linux/kd.h
@@ -125,6 +125,16 @@ struct kbdiacrs {
 #define KDGKBDIACR      0x4B4A  /* read kernel accent table */
 #define KDSKBDIACR      0x4B4B  /* write kernel accent table */
=20
+struct kbdiacruc {
+        __u32 diacr, base, result;
+};
+struct kbdiacrsuc {
+        unsigned int kb_cnt;    /* number of entries in following array */
+	struct kbdiacruc kbdiacruc[256];    /* MAX_DIACR from keyboard.h */
+};
+#define KDGKBDIACRUC    0x4BFA  /* read kernel accent table - UCS */
+#define KDSKBDIACRUC    0x4BFB  /* write kernel accent table - UCS */
+
 struct kbkeycode {
 	unsigned int scancode, keycode;
 };
