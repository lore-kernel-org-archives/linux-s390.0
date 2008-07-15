Return-Path: <linux-kernel-owner+w=401wt.eu-S1757281AbYGOM6d@vger.kernel.org>
Date: Tue, 15 Jul 2008 15:58:18 +0300
From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] chsc headers userspace cleanup
Message-ID: <20080715125817.GB24533@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Kernel headers shouldn't expose functions to userspace.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

BTW: For compile-testing my patches it would be nice if s390 had
     more defconfigs (e.g. also a non-64bit one).

 include/asm-s390/Kbuild  |    2 +-
 include/asm-s390/chpid.h |    6 +++---
 include/asm-s390/schid.h |    3 +++
 3 files changed, 7 insertions(+), 4 deletions(-)

0ee038c850fe402d0a8a548b438ae045e8e06f50 
diff --git a/include/asm-s390/Kbuild b/include/asm-s390/Kbuild
index 09f3125..bb5e9ed 100644
--- a/include/asm-s390/Kbuild
+++ b/include/asm-s390/Kbuild
@@ -8,9 +8,9 @@ header-y += ucontext.h
 header-y += vtoc.h
 header-y += zcrypt.h
 header-y += kvm.h
-header-y += schid.h
 header-y += chsc.h
 
 unifdef-y += cmb.h
 unifdef-y += debug.h
 unifdef-y += chpid.h
+unifdef-y += schid.h
diff --git a/include/asm-s390/chpid.h b/include/asm-s390/chpid.h
index 606844d..dfe3c7f 100644
--- a/include/asm-s390/chpid.h
+++ b/include/asm-s390/chpid.h
@@ -20,6 +20,9 @@ struct chp_id {
 	u8 id;
 } __attribute__((packed));
 
+#ifdef __KERNEL__
+#include <asm/cio.h>
+
 static inline void chp_id_init(struct chp_id *chpid)
 {
 	memset(chpid, 0, sizeof(struct chp_id));
@@ -40,9 +43,6 @@ static inline void chp_id_next(struct chp_id *chpid)
 	}
 }
 
-#ifdef __KERNEL__
-#include <asm/cio.h>
-
 static inline int chp_id_is_valid(struct chp_id *chpid)
 {
 	return (chpid->cssid <= __MAX_CSSID);
diff --git a/include/asm-s390/schid.h b/include/asm-s390/schid.h
index 5017ffa..7707eb9 100644
--- a/include/asm-s390/schid.h
+++ b/include/asm-s390/schid.h
@@ -10,6 +10,7 @@ struct subchannel_id {
 	__u32 sch_no : 16;
 } __attribute__ ((packed, aligned(4)));
 
+#ifdef  __KERNEL__
 
 /* Helper function for sane state of pre-allocated subchannel_id. */
 static inline void
@@ -25,4 +26,6 @@ schid_equal(struct subchannel_id *schid1, struct subchannel_id *schid2)
 	return !memcmp(schid1, schid2, sizeof(struct subchannel_id));
 }
 
+#endif /* __KERNEL__ */
+
 #endif /* ASM_SCHID_H */
