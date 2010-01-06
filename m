From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: next Jan 6: drivers/s390/char/defkeymap build break
Date: Wed, 06 Jan 2010 10:14:48 -0600
Message-ID: <4B44B6F8.9070209@windriver.com>
References: <20100106180342.43844983.sfr@canb.auug.org.au> <4B445470.8010402@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080204090705060707080005"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4B445470.8010402@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080204090705060707080005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sachin Sant wrote:
> Today's next fails to build on s390 with
>
>  CC      drivers/s390/char/defkeymap.o
> drivers/s390/char/defkeymap.c:30: error: static declaration of 'shift_map' follows non-static declaration
> include/linux/keyboard.h:31: error: previous declaration of 'shift_map' was here
> drivers/s390/char/defkeymap.c:49: error: static declaration of 'ctrl_map' follows non-static declaration
> include/linux/keyboard.h:32: error: previous declaration of 'ctrl_map' was here
> make[2]: *** [drivers/s390/char/defkeymap.o] Error 1
> make[1]: *** [drivers/s390/char] Error 2
>
> Probable cause could be commit 91570de..
> kgdboc,keyboard: Keyboard driver for kdb with kgdb
>
> Thanks
> -Sachin
>
>   
I had patched the include/linux/keyboard.h originally to expose the
definition which was already a global symbol.  It turns out the
kdb_keyboard.c implementation should not be accessing shift_map[]
directly.  It is accessed through a pointer to the data found in key_maps[].

I folded in a change to this patch to not modify
include/linux/keyboard.h and to fix the kdb keyboard code to use key_maps[].

Hopefully that fixes the problem.  Attached is the folded patch, which
reverts include/linux/keyboard.h to be unmodified by the kdb series.

Thanks,
Jason.

--------------080204090705060707080005
Content-Type: text/x-diff;
 name="keymap_kdb_keyboard.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="keymap_kdb_keyboard.patch"

diff -u b/drivers/char/kdb_keyboard.c b/drivers/char/kdb_keyboard.c
--- b/drivers/char/kdb_keyboard.c
+++ b/drivers/char/kdb_keyboard.c
@@ -145,10 +145,10 @@
 
 	if (!shift_lock && !shift_key && !ctrl_key) {
 		keychar = plain_map[scancode];
-	} else if (shift_lock || shift_key) {
-		keychar = shift_map[scancode];
-	} else if (ctrl_key) {
-		keychar = ctrl_map[scancode];
+	} else if ((shift_lock || shift_key) && key_maps[1]) {
+		keychar = key_maps[1][scancode];
+	} else if (ctrl_key && key_maps[4]) {
+		keychar = key_maps[4][scancode];
 	} else {
 		keychar = 0x0020;
 		kdb_printf("Unknown state/scancode (%d)\n", scancode);
reverted:
--- b/include/linux/keyboard.h
+++ a/include/linux/keyboard.h
@@ -28,8 +28,6 @@
 extern const int max_vals[];
 extern unsigned short *key_maps[MAX_NR_KEYMAPS];
 extern unsigned short plain_map[NR_KEYS];
-extern unsigned short shift_map[NR_KEYS];
-extern unsigned short ctrl_map[NR_KEYS];
 
 struct keyboard_notifier_param {
 	struct vc_data *vc;	/* VC on which the keyboard press was done */

--------------080204090705060707080005--
