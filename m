Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CAFC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 19:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CE361B3A
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 19:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbhKQTnD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:43:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230367AbhKQTnC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Nov 2021 14:43:02 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHJHj2j024549;
        Wed, 17 Nov 2021 19:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xCE66YfTb9C1x2b628zttatGHfkjwh3Xv2qVm9PVTY8=;
 b=pOMQzpuwRey2H0xQlsZXBGnvhJdmS+75c3vx925jTub1tv+lwzbA+qnyxxnm06jNwhJ1
 nycxHnbH6wUuJ4DaKOw9lw+zdsCceluQEBKiXkES9OQpQ2+cJJvWoMITAyxRkTKQD4Ao
 AUL4C3XpWD9MK3eFbCJ90V1xMFLmYCN3FphrJlrwS66FYcGmB30WBF+JYCVw3SpMYoFc
 fv8/evz3VIN8Ttt4obbJYPJEsqiFsqH6pzel0Ec23ed1Sx/45w5YZIe0qXh8lUh0xiJj
 +1JK1NmlxDCxqTMc9R4Kv2ls3gImt5kVUFvXTe7eUksBK9YloRm8iFw/BdcDfslJRmqR DQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cd7s1gbsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 19:39:55 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHJXDYc006924;
        Wed, 17 Nov 2021 19:39:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3ca50adfpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 19:39:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AHJdpMA62128398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 19:39:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7274BAE045;
        Wed, 17 Nov 2021 19:39:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30D1DAE053;
        Wed, 17 Nov 2021 19:39:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 19:39:51 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 0/1] mm/slub: endless "No data" printing for alloc/free_traces attribute
Date:   Wed, 17 Nov 2021 20:39:31 +0100
Message-Id: <20211117193932.4049412-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HNdSxD-ouFbi2_qAvqm8TOIq7GYJMhcV
X-Proofpoint-ORIG-GUID: HNdSxD-ouFbi2_qAvqm8TOIq7GYJMhcV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_07,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Steffen reported endless printing of "No data" when reading from
alloc/free_traces attribute in /sys/kernel/debug/slab/, at least on
s390, but I don't see how this could be arch-specific.

I must admit that I am completely confused by the seq_file interface
in general, but even more so from this specific implementation.

First I suspected a bug in slab_debugfs_next(), because of its very
weird usage of the *v parameter, which seems totally useless, but not
responsible for this bug. Still, out of curiosity, does anybody have a
clue why it is done this way, and not e.g. like this?

diff --git a/mm/slub.c b/mm/slub.c
index f7368bfffb7a..0b1832b16f5b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6105,10 +6105,9 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
 {
        struct loc_track *t = seq->private;

-       v = ppos;
        ++*ppos;
        if (*ppos <= t->count)
-               return v;
+               return ppos;

        return NULL;
 }

Anyway, NULL is returned for the "*ppos > t->count" case, as described
in Documentation/filesystems/seq_file.rst, for "if the sequence is
complete", so that should be ok, but still very confusing. Unfortunately,
the documentation does not seem to explain that *v parameter at all, or
I missed it, but in this case here it seems to be simply ignored and
misused w/o any need.

The documentation does mention that "in most cases the start() function
should check for a "past end of file" condition and return NULL if need
be". So I just added a similar check to slab_debugfs_start() and return
NULL for "*ppos > t->count", which apparently fixed the bug. "No data"
is now only printed once, like it was before commit 64dd68497be7
("mm: slub: move sysfs slab alloc/free interfaces to debugfs").

However, since I obviously do not really understand the seq_file
documentation, and also not the alloc/free_traces stuff in general,
that fix might be wrong or incomplete. Comments are welcome.

Gerald Schaefer (1):
  mm/slub: fix endless "No data" printing for alloc/free_traces
    attribute

 mm/slub.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.25.1

