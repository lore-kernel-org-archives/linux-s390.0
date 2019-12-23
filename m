Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbfLWODi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Dec 2019 09:03:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNE3TVR081043
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:03:37 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x21tyd21f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:03:37 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 23 Dec 2019 14:03:34 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/6] s390/qeth: fix false reporting of VNIC CHAR config failure
Date: Mon, 23 Dec 2019 15:03:23 +0100
In-Reply-To: <20191223140326.16488-1-jwi@linux.ibm.com>
References: <20191223140326.16488-1-jwi@linux.ibm.com>
Message-Id: <20191223140326.16488-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

From: Alexandra Winter <wintera@linux.ibm.com>

Symptom: Error message "Configuring the VNIC characteristics failed"
in dmesg whenever an OSA interface on z15 is set online.

The VNIC characteristics get re-programmed when setting a L2 device
online. This follows the selected 'wanted' characteristics - with the
exception that the INVISIBLE characteristic unconditionally gets
switched off.

For devices that don't support INVISIBLE (ie. OSA), the resulting
IO failure raises a noisy error message
("Configuring the VNIC characteristics failed").
For IQD, INVISIBLE is off by default anyways.

So don't unnecessarily special-case the INVISIBLE characteristic, and
thereby suppress the misleading error message on OSA devices.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 15e2fd65d434..fc5d8ed3a737 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2041,7 +2041,6 @@ static void qeth_l2_vnicc_init(struct qeth_card *card)
 	error |= qeth_l2_vnicc_recover_timeout(card, QETH_VNICC_LEARNING,
 					       timeout);
 	chars_tmp = card->options.vnicc.wanted_chars ^ QETH_VNICC_DEFAULT;
-	chars_tmp |= QETH_VNICC_BRIDGE_INVISIBLE;
 	chars_len = sizeof(card->options.vnicc.wanted_chars) * BITS_PER_BYTE;
 	for_each_set_bit(i, &chars_tmp, chars_len) {
 		vnicc = BIT(i);
-- 
2.17.1
