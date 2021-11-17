Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608FBC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 19:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39CF261B3D
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 19:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbhKQTnC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:43:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232482AbhKQTnA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Nov 2021 14:43:00 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHIfXwq017422;
        Wed, 17 Nov 2021 19:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GG0zw38m8UAMNZHTD8EcEiXU/BujDBluyOZnVM89dsA=;
 b=eA+ii5YvcFd2K9VagMUo+4tERr0KCMLnI5si1Lyfdpbia9dEosgi5LwpB4YEvki6aFyt
 lT7qAj/rc1qwwaH036tRh9Q/j5YcZCv3ysEFmezWwtRFWRBZOQCBwI7+ptO6wVYtYVXX
 XIjukA2j5Oc+vZCpV23dZJGqDjWuazl6Ars32Fn7CdtuqMUbqlbKQ4rTLpUH/kUhL7/r
 LKFLZneM2wYFFBn8Rx5r2dXZoWkzZX3LqwchOlgsEs6pAbVhml5IfCdHby95SzDb7kOz
 FHME8YnsS18QlG/uzvFP9cNCueIi5BdAv6qabE8GNrGMgiTT0/TnnPmfQxS7AEdu7q3s Cw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cd781h47w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 19:39:56 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHJWtlL022503;
        Wed, 17 Nov 2021 19:39:55 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3ca50ckwe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 19:39:54 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AHJdq3u66584916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 19:39:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 825EBAE045;
        Wed, 17 Nov 2021 19:39:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37B1AAE053;
        Wed, 17 Nov 2021 19:39:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 19:39:52 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 1/1] mm/slub: fix endless "No data" printing for alloc/free_traces attribute
Date:   Wed, 17 Nov 2021 20:39:32 +0100
Message-Id: <20211117193932.4049412-2-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
References: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yvRbY4G85Vivysos-VQD-eKrumQh25x6
X-Proofpoint-ORIG-GUID: yvRbY4G85Vivysos-VQD-eKrumQh25x6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_06,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=787 mlxscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Reading from alloc/free_traces attribute in /sys/kernel/debug/slab/ results
in an endless sequence of "No data". This is because slab_debugfs_start()
does not check for a "past end of file" condition and return NULL.

Fix it by adding such a check and return NULL.

Fixes: 64dd68497be7 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")
Cc: <stable@vger.kernel.org> # v5.14+
Reported-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 mm/slub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index f7368bfffb7a..336609671bc2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6115,6 +6115,11 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
 
 static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
 {
+	struct loc_track *t = seq->private;
+
+	if (*ppos > t->count)
+		return NULL;
+
 	return ppos;
 }
 
-- 
2.25.1

