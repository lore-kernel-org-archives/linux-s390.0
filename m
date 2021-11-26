Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335DFC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 26 Nov 2021 17:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhKZRYU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 26 Nov 2021 12:24:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231520AbhKZRWU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Nov 2021 12:22:20 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AQHFqXi030074;
        Fri, 26 Nov 2021 17:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=b7ntKJBdYE4PWhHtmSjJVHxK46N8CKvYSfv9jWeLfCM=;
 b=pT+uMYM7mEjQfSnJddWOyOm9ODic3jf0CJ/pKnI42iYIj15/LZyViqkHdCrTBGnbhYGH
 YP4tyQ3xebUSYwvU+2mJSs1oKqPmGXfSnuU42DhvOBmamaPlTXRzYwcAS1beTtf+prrI
 Txz+XX0Q4ZyN2m7A+A52pwwvIShpLkzOZJXfmxYkJ/ZpoN2AtCB3BuyeXnSPH+hG1O07
 Ih9FmNMwZ7ZAU/xXcF1wqO49rkxUDKVmothGdzq7nnZJttD4lUFRuIof3cfzLJctPbE0
 OYBmI5rQYqiqlqXH38yTCIoP9p0XIBujqW0s7UpPWDLlbPDiIjpopdFM+CS59vTCT6fB tQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ck3u1820g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 17:19:00 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AQHCoGt013600;
        Fri, 26 Nov 2021 17:18:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3cernab6sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 17:18:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AQHBdsl64225782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Nov 2021 17:11:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38DFA4C040;
        Fri, 26 Nov 2021 17:18:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB8234C052;
        Fri, 26 Nov 2021 17:18:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Nov 2021 17:18:54 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/slub: fix endianness bug for alloc/free_traces attributes
Date:   Fri, 26 Nov 2021 18:18:48 +0100
Message-Id: <20211126171848.17534-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <7c909b82-8e1c-a8ce-516d-e3aa9bc2fd81@suse.cz>
References: <7c909b82-8e1c-a8ce-516d-e3aa9bc2fd81@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5FYrfJZA68Nx5hNKW32gQhs0rNmK-4d1
X-Proofpoint-ORIG-GUID: 5FYrfJZA68Nx5hNKW32gQhs0rNmK-4d1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_04,2021-11-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111260099
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On big-endian s390, the alloc/free_traces attributes produce endless
output, because of always 0 idx in slab_debugfs_show().

idx is de-referenced from *v, which points to a loff_t value, with

unsigned int idx = *(unsigned int *)v;

This will only give the upper 32 bits on big-endian, which remain 0.

Instead of only fixing this de-reference, during discussion it seemed
more appropriate to change the seq_ops so that they use an explicit
iterator in private loc_track struct.

This patch adds idx to loc_track, which will also fix the endianness bug.

Link: https://lore.kernel.org/r/20211117193932.4049412-1-gerald.schaefer@linux.ibm.com
Fixes: 64dd68497be7 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")
Cc: <stable@vger.kernel.org> # v5.14+
Reported-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 mm/slub.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a8626825a829..abe7db581d68 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5081,6 +5081,7 @@ struct loc_track {
 	unsigned long max;
 	unsigned long count;
 	struct location *loc;
+	loff_t idx;
 };
 
 static struct dentry *slab_debugfs_root;
@@ -6052,11 +6053,11 @@ __initcall(slab_sysfs_init);
 #if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
 static int slab_debugfs_show(struct seq_file *seq, void *v)
 {
-
-	struct location *l;
-	unsigned int idx = *(unsigned int *)v;
 	struct loc_track *t = seq->private;
+	struct location *l;
+	unsigned long idx;
 
+	idx = (unsigned long) t->idx;
 	if (idx < t->count) {
 		l = &t->loc[idx];
 
@@ -6105,16 +6106,18 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
 {
 	struct loc_track *t = seq->private;
 
-	v = ppos;
-	++*ppos;
+	t->idx = ++(*ppos);
 	if (*ppos <= t->count)
-		return v;
+		return ppos;
 
 	return NULL;
 }
 
 static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
 {
+	struct loc_track *t = seq->private;
+
+	t->idx = *ppos;
 	return ppos;
 }
 
-- 
2.32.0

