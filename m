Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] s390: char: sclp_async.c:  Cleaning up missing null-terminate in conjunction with strncpy
Date: Sat, 26 Jul 2014 16:30:47 +0200
Message-Id: <1406385047-2942-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Replacing strncpy with strlcpy to avoid strings that lacks null terminate.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/s390/char/sclp_async.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_async.c b/drivers/s390/char/sclp_async.c
index 5f9f929..585de0a 100644
--- a/drivers/s390/char/sclp_async.c
+++ b/drivers/s390/char/sclp_async.c
@@ -132,12 +132,12 @@ static int sclp_async_send_wait(char *message)
 	request->command = SCLP_CMDW_WRITE_EVENT_DATA;
 	request->sccb = sccb;
 	request->status = SCLP_REQ_FILLED;
-	strncpy(sccb->evbuf.data, message, sizeof(sccb->evbuf.data));
+	strlcpy(sccb->evbuf.data, message, sizeof(sccb->evbuf.data));
 	/*
 	 * Retain Queue
 	 * e.g. 5639CC140 500 Red Hat RHEL5 Linux for zSeries (RHEL AS)
 	 */
-	strncpy(sccb->evbuf.comp_id, "000000000", sizeof(sccb->evbuf.comp_id));
+	strlcpy(sccb->evbuf.comp_id, "000000000", sizeof(sccb->evbuf.comp_id));
 	sccb->evbuf.header.length = sizeof(sccb->evbuf);
 	sccb->header.length = sizeof(sccb->evbuf) + sizeof(sccb->header);
 	sccb->header.function_code = SCLP_NORMAL_WRITE;
-- 
1.7.10.4
