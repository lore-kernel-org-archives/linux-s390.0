Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404364AbfFKQiM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 12:38:12 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BGWQtr008607
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:11 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2ecpwkgv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:11 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 11 Jun 2019 17:38:09 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 01/13] s390/qeth: don't mask TX errors on IQD devices
Date: Tue, 11 Jun 2019 18:37:48 +0200
In-Reply-To: <20190611163800.64730-1-jwi@linux.ibm.com>
References: <20190611163800.64730-1-jwi@linux.ibm.com>
Message-Id: <20190611163800.64730-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Current code suppresses debug entries when an TX buffer completes in
ERROR state with no error indication set in SBALF15.
This was introduced back with
commit 58490f18071d ("qeth: HiperSockets SIGA retry support on CC=2.").
But qeth no longer retries after CC=2, and this sort of suppression
make no sense anymore. Remove it.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index b1823d75dd35..cd9e2f70d8f6 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3236,13 +3236,6 @@ static void qeth_handle_send_error(struct qeth_card *card,
 	int sbalf15 = buffer->buffer->element[15].sflags;
 
 	QETH_CARD_TEXT(card, 6, "hdsnderr");
-	if (IS_IQD(card)) {
-		if (sbalf15 == 0) {
-			qdio_err = 0;
-		} else {
-			qdio_err = 1;
-		}
-	}
 	qeth_check_qdio_errors(card, buffer->buffer, qdio_err, "qouterr");
 
 	if (!qdio_err)
-- 
2.17.1
