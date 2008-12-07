Return-Path: <linux-kernel-owner+w=401wt.eu-S1754597AbYLGWPU@vger.kernel.org>
Date: Sun, 7 Dec 2008 23:14:57 +0100 (CET)
From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 1/2] drivers/s390/crypto: Move dereference to after IS_ERR
 test
Message-ID: <Pine.LNX.4.64.0812072314270.7130@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julia Lawall <julia@diku.dk>

If reply is ERR_PTR(...), then it should not be dereferenced, so I have
moved the dereference from the declaration to after the IS_ERR test.

The semantic match that finds the problem is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@match exists@
expression x, E;
identifier fld;
position p1,p2;
@@

(
x = E;
|
x = E
|
x@p1->fld
... when != x = E
IS_ERR(x@p2)
... when any
)

@other_match exists@
expression match.x, E1, E2;
position match.p1,match.p2;
@@

x = E1
... when != x = E2
    when != x@p1
x@p2

@ script:python depends on !other_match@
p1 << match.p1;
p2 << match.p2;
@@

print "* file %s dereference %s test %s" % (p1[0].file,p1[0].line,p2[0].line)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/s390/crypto/zcrypt_cex2a.c  |   10 +++++++---
 drivers/s390/crypto/zcrypt_pcica.c  |   10 +++++++---
 drivers/s390/crypto/zcrypt_pcicc.c  |   10 +++++++---
 drivers/s390/crypto/zcrypt_pcixcc.c |   10 +++++++---
 4 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_pcixcc.c b/drivers/s390/crypto/zcrypt_pcixcc.c
index d8ad36f..e7a1e22 100644
--- a/drivers/s390/crypto/zcrypt_pcixcc.c
+++ b/drivers/s390/crypto/zcrypt_pcixcc.c
@@ -635,13 +635,16 @@ static void zcrypt_pcixcc_receive(struct ap_device *ap_dev,
 	};
 	struct response_type *resp_type =
 		(struct response_type *) msg->private;
-	struct type86x_reply *t86r = reply->message;
+	struct type86x_reply *t86r;
 	int length;
 
 	/* Copy the reply message to the request message buffer. */
-	if (IS_ERR(reply))
+	if (IS_ERR(reply)) {
 		memcpy(msg->message, &error_reply, sizeof(error_reply));
-	else if (t86r->hdr.type == TYPE86_RSP_CODE &&
+		goto out;
+	}
+	t86r = reply->message;
+	if (t86r->hdr.type == TYPE86_RSP_CODE &&
 		 t86r->cprbx.cprb_ver_id == 0x02) {
 		switch (resp_type->type) {
 		case PCIXCC_RESPONSE_TYPE_ICA:
@@ -660,6 +663,7 @@ static void zcrypt_pcixcc_receive(struct ap_device *ap_dev,
 		}
 	} else
 		memcpy(msg->message, reply->message, sizeof error_reply);
+out:
 	complete(&(resp_type->work));
 }
 
diff --git a/drivers/s390/crypto/zcrypt_pcica.c b/drivers/s390/crypto/zcrypt_pcica.c
index 12da481..17ba81b 100644
--- a/drivers/s390/crypto/zcrypt_pcica.c
+++ b/drivers/s390/crypto/zcrypt_pcica.c
@@ -247,17 +247,21 @@ static void zcrypt_pcica_receive(struct ap_device *ap_dev,
 		.type = TYPE82_RSP_CODE,
 		.reply_code = REP82_ERROR_MACHINE_FAILURE,
 	};
-	struct type84_hdr *t84h = reply->message;
+	struct type84_hdr *t84h;
 	int length;
 
 	/* Copy the reply message to the request message buffer. */
-	if (IS_ERR(reply))
+	if (IS_ERR(reply)) {
 		memcpy(msg->message, &error_reply, sizeof(error_reply));
-	else if (t84h->code == TYPE84_RSP_CODE) {
+		goto out;
+	}
+	t84h = reply->message;
+	if (t84h->code == TYPE84_RSP_CODE) {
 		length = min(PCICA_MAX_RESPONSE_SIZE, (int) t84h->len);
 		memcpy(msg->message, reply->message, length);
 	} else
 		memcpy(msg->message, reply->message, sizeof error_reply);
+out:
 	complete((struct completion *) msg->private);
 }
 
diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
index 54f4cbc..286dd02 100644
--- a/drivers/s390/crypto/zcrypt_cex2a.c
+++ b/drivers/s390/crypto/zcrypt_cex2a.c
@@ -264,17 +264,21 @@ static void zcrypt_cex2a_receive(struct ap_device *ap_dev,
 		.type = TYPE82_RSP_CODE,
 		.reply_code = REP82_ERROR_MACHINE_FAILURE,
 	};
-	struct type80_hdr *t80h = reply->message;
+	struct type80_hdr *t80h;
 	int length;
 
 	/* Copy the reply message to the request message buffer. */
-	if (IS_ERR(reply))
+	if (IS_ERR(reply)) {
 		memcpy(msg->message, &error_reply, sizeof(error_reply));
-	else if (t80h->type == TYPE80_RSP_CODE) {
+		goto out;
+	}
+	t80h = reply->message;
+	if (t80h->type == TYPE80_RSP_CODE) {
 		length = min(CEX2A_MAX_RESPONSE_SIZE, (int) t80h->len);
 		memcpy(msg->message, reply->message, length);
 	} else
 		memcpy(msg->message, reply->message, sizeof error_reply);
+out:
 	complete((struct completion *) msg->private);
 }
 
diff --git a/drivers/s390/crypto/zcrypt_pcicc.c b/drivers/s390/crypto/zcrypt_pcicc.c
index 779952c..f4b0c47 100644
--- a/drivers/s390/crypto/zcrypt_pcicc.c
+++ b/drivers/s390/crypto/zcrypt_pcicc.c
@@ -447,19 +447,23 @@ static void zcrypt_pcicc_receive(struct ap_device *ap_dev,
 		.type = TYPE82_RSP_CODE,
 		.reply_code = REP82_ERROR_MACHINE_FAILURE,
 	};
-	struct type86_reply *t86r = reply->message;
+	struct type86_reply *t86r;
 	int length;
 
 	/* Copy the reply message to the request message buffer. */
-	if (IS_ERR(reply))
+	if (IS_ERR(reply)) {
 		memcpy(msg->message, &error_reply, sizeof(error_reply));
-	else if (t86r->hdr.type == TYPE86_RSP_CODE &&
+		goto out;
+	}
+	t86r = reply->message;
+	if (t86r->hdr.type == TYPE86_RSP_CODE &&
 		 t86r->cprb.cprb_ver_id == 0x01) {
 		length = sizeof(struct type86_reply) + t86r->length - 2;
 		length = min(PCICC_MAX_RESPONSE_SIZE, length);
 		memcpy(msg->message, reply->message, length);
 	} else
 		memcpy(msg->message, reply->message, sizeof error_reply);
+out:
 	complete((struct completion *) msg->private);
 }
 
