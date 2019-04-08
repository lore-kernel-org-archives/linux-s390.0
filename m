Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/12] s390: zcrypt: initialize variables before_use
Date: Mon,  8 Apr 2019 23:26:18 +0200
Message-Id: <20190408212648.2407234-5-arnd@arndb.de>
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ingo Franzki <ifranzki@de.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The 'func_code' variable gets printed in debug statements without
a prior initialization in multiple functions, as reported when building
with clang:

drivers/s390/crypto/zcrypt_api.c:659:6: warning: variable 'func_code' is used uninitialized whenever 'if' condition is true
      [-Wsometimes-uninitialized]
        if (mex->outputdatalength < mex->inputdatalength) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/s390/crypto/zcrypt_api.c:725:29: note: uninitialized use occurs here
        trace_s390_zcrypt_rep(mex, func_code, rc,
                                   ^~~~~~~~~
drivers/s390/crypto/zcrypt_api.c:659:2: note: remove the 'if' if its condition is always false
        if (mex->outputdatalength < mex->inputdatalength) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/s390/crypto/zcrypt_api.c:654:24: note: initialize the variable 'func_code' to silence this warning
        unsigned int func_code;
                              ^

Add initializations to all affected code paths to shut up the warning
and make the warning output consistent.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/s390/crypto/zcrypt_api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index eb93c2d27d0a..23472063d9a8 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -657,6 +657,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
 	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
 
 	if (mex->outputdatalength < mex->inputdatalength) {
+		func_code = -1;
 		rc = -EINVAL;
 		goto out;
 	}
@@ -739,6 +740,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
 
 	if (crt->outputdatalength < crt->inputdatalength) {
+		func_code = -1;
 		rc = -EINVAL;
 		goto out;
 	}
@@ -946,6 +948,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
 
 		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
 		if (!targets) {
+			func_code = -1;
 			rc = -ENOMEM;
 			goto out;
 		}
@@ -953,6 +956,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
 		uptr = (struct ep11_target_dev __force __user *) xcrb->targets;
 		if (copy_from_user(targets, uptr,
 				   target_num * sizeof(*targets))) {
+			func_code = -1;
 			rc = -EFAULT;
 			goto out_free;
 		}
-- 
2.20.0
