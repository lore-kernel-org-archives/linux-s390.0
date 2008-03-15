From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Sat, 15 Mar 2008 18:27:33 +0000
Subject: [PATCH] S390:  Use newer, non-deprecated __RW_LOCK_UNLOCKED macro.
Message-Id: <alpine.LFD.1.00.0803151426350.25079@localhost.localdomain>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index fee22ca..7b0038f 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -53,7 +53,7 @@ static int iucv_callback_connreq(struct iucv_path *, u8 ipvmid[8],
 static void iucv_callback_connrej(struct iucv_path *, u8 ipuser[16]);

 static struct iucv_sock_list iucv_sk_list = {
-	.lock = RW_LOCK_UNLOCKED,
+	.lock = __RW_LOCK_UNLOCKED(iucv_sk_list.lock),
 	.autobind_name = ATOMIC_INIT(0)
 };


========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
