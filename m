Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726754AbfLWOEK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Dec 2019 09:04:10 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNE44v0008165
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:04:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x21b0da6d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:04:07 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 23 Dec 2019 14:03:37 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 6/6] s390/qeth: fix initialization on old HW
Date: Mon, 23 Dec 2019 15:03:26 +0100
In-Reply-To: <20191223140326.16488-1-jwi@linux.ibm.com>
References: <20191223140326.16488-1-jwi@linux.ibm.com>
Message-Id: <20191223140326.16488-7-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

I stumbled over an old OSA model that claims to support DIAG_ASSIST,
but then rejects the cmd to query its DIAG capabilities.

In the old code this was ok, as the returned raw error code was > 0.
Now that we translate the raw codes to errnos, the "rc < 0" causes us
to fail the initialization of the device.

The fix is trivial: don't bail out when the DIAG query fails. Such an
error is not critical, we can still use the device (with a slightly
reduced set of features).

Fixes: 742d4d40831d ("s390/qeth: convert remaining legacy cmd callbacks")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c64ef55f0dff..29facb913671 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5026,10 +5026,8 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 	}
 	if (qeth_adp_supported(card, IPA_SETADP_SET_DIAG_ASSIST)) {
 		rc = qeth_query_setdiagass(card);
-		if (rc < 0) {
+		if (rc)
 			QETH_CARD_TEXT_(card, 2, "8err%d", rc);
-			goto out;
-		}
 	}
 
 	if (!qeth_is_diagass_supported(card, QETH_DIAGS_CMD_TRAP) ||
-- 
2.17.1
