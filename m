Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgCKJJS (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 05:09:18 -0400
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] s390/zcrypt: Use scnprintf() for avoiding potential buffer overflow
Date: Wed, 11 Mar 2020 10:09:15 +0100
Message-Id: <20200311090915.21059-1-tiwai@suse.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/s390/crypto/zcrypt_cex4.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index 9a9d02e19774..dea96d5b65fb 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -128,16 +128,16 @@ static ssize_t cca_mkvps_show(struct device *dev,
 		n = snprintf(buf, PAGE_SIZE, "AES NEW: - -\n");
 
 	if (ci.cur_mk_state >= '1' && ci.cur_mk_state <= '2')
-		n += snprintf(buf + n, PAGE_SIZE - n, "AES CUR: %s 0x%016llx\n",
+		n += scnprintf(buf + n, PAGE_SIZE - n, "AES CUR: %s 0x%016llx\n",
 			      cao_state[ci.cur_mk_state - '1'], ci.cur_mkvp);
 	else
-		n += snprintf(buf + n, PAGE_SIZE - n, "AES CUR: - -\n");
+		n += scnprintf(buf + n, PAGE_SIZE - n, "AES CUR: - -\n");
 
 	if (ci.old_mk_state >= '1' && ci.old_mk_state <= '2')
-		n += snprintf(buf + n, PAGE_SIZE - n, "AES OLD: %s 0x%016llx\n",
+		n += scnprintf(buf + n, PAGE_SIZE - n, "AES OLD: %s 0x%016llx\n",
 			      cao_state[ci.old_mk_state - '1'], ci.old_mkvp);
 	else
-		n += snprintf(buf + n, PAGE_SIZE - n, "AES OLD: - -\n");
+		n += scnprintf(buf + n, PAGE_SIZE - n, "AES OLD: - -\n");
 
 	return n;
 }
@@ -251,11 +251,11 @@ static ssize_t ep11_card_op_modes_show(struct device *dev,
 		if (ci.op_mode & (1 << ep11_op_modes[i].mode_bit)) {
 			if (n > 0)
 				buf[n++] = ' ';
-			n += snprintf(buf + n, PAGE_SIZE - n,
+			n += scnprintf(buf + n, PAGE_SIZE - n,
 				      "%s", ep11_op_modes[i].mode_txt);
 		}
 	}
-	n += snprintf(buf + n, PAGE_SIZE - n, "\n");
+	n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
 
 	return n;
 }
@@ -305,21 +305,21 @@ static ssize_t ep11_mkvps_show(struct device *dev,
 			     cwk_state[di.cur_wk_state - '0']);
 		bin2hex(buf + n, di.cur_wkvp, sizeof(di.cur_wkvp));
 		n += 2 * sizeof(di.cur_wkvp);
-		n += snprintf(buf + n, PAGE_SIZE - n, "\n");
+		n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
 	} else
 		n = snprintf(buf, PAGE_SIZE, "WK CUR: - -\n");
 
 	if (di.new_wk_state == '0') {
-		n += snprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s -\n",
+		n += scnprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s -\n",
 			      nwk_state[di.new_wk_state - '0']);
 	} else if (di.new_wk_state >= '1' && di.new_wk_state <= '2') {
-		n += snprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s 0x",
+		n += scnprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s 0x",
 			      nwk_state[di.new_wk_state - '0']);
 		bin2hex(buf + n, di.new_wkvp, sizeof(di.new_wkvp));
 		n += 2 * sizeof(di.new_wkvp);
-		n += snprintf(buf + n, PAGE_SIZE - n, "\n");
+		n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
 	} else
-		n += snprintf(buf + n, PAGE_SIZE - n, "WK NEW: - -\n");
+		n += scnprintf(buf + n, PAGE_SIZE - n, "WK NEW: - -\n");
 
 	return n;
 }
@@ -346,11 +346,11 @@ static ssize_t ep11_queue_op_modes_show(struct device *dev,
 		if (di.op_mode & (1 << ep11_op_modes[i].mode_bit)) {
 			if (n > 0)
 				buf[n++] = ' ';
-			n += snprintf(buf + n, PAGE_SIZE - n,
+			n += scnprintf(buf + n, PAGE_SIZE - n,
 				      "%s", ep11_op_modes[i].mode_txt);
 		}
 	}
-	n += snprintf(buf + n, PAGE_SIZE - n, "\n");
+	n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
 
 	return n;
 }
-- 
2.16.4
