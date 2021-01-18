Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40653 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390223AbhARLdP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Jan 2021 06:33:15 -0500
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] s390/tape: Fix spelling mistake in function name tape_3590_erp_succeded
Date: Mon, 18 Jan 2021 11:32:22 +0000
Message-Id: <20210118113222.71708-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Rename tape_3590_erp_succeded to tape_3590_erp_succeeded to fix a
spelling mistake in the function name.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/s390/char/tape_3590.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index ecf8c5006a0e..0d484fe43d7e 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -761,7 +761,7 @@ tape_3590_done(struct tape_device *device, struct tape_request *request)
  * This function is called, when error recovery was successful
  */
 static inline int
-tape_3590_erp_succeded(struct tape_device *device, struct tape_request *request)
+tape_3590_erp_succeeded(struct tape_device *device, struct tape_request *request)
 {
 	DBF_EVENT(3, "Error Recovery successful for %s\n",
 		  tape_op_verbose[request->op]);
@@ -831,7 +831,7 @@ tape_3590_erp_basic(struct tape_device *device, struct tape_request *request,
 	case SENSE_BRA_PER:
 		return tape_3590_erp_failed(device, request, irb, rc);
 	case SENSE_BRA_CONT:
-		return tape_3590_erp_succeded(device, request);
+		return tape_3590_erp_succeeded(device, request);
 	case SENSE_BRA_RE:
 		return tape_3590_erp_retry(device, request, irb);
 	case SENSE_BRA_DRE:
-- 
2.29.2
