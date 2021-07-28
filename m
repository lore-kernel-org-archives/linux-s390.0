Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDCAC19F31
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AD460ED4
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhG1TDJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:03:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231521AbhG1TDH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 15:03:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SIddcB085471;
        Wed, 28 Jul 2021 15:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lLMv06NdvqTmx5y8HUhXgPkm/QTRuWHf5/f5/uzWN8A=;
 b=iJC36z8N3/78Pxd1Z74FwkMje+Xe31vzXWSNllCKDVkjm485TqfzaXQog5F2QJjhABwG
 Ek2g7ukIgN72soE52N4irn0xxzu6Wv43peQ4hUgbnevOnU0BEY5eucggThvVKRf3LaBX
 rr+kfJynMskoU28rVy9fTwu02hHM0ugbtxEej4bqRMg1hGqXMRicFJjr++APsdgQHHcm
 hfRDMPfcSAgyCihXxl6LHW/nG3EYoYBbqyfhHtY5GDetEd8rYfcr0PgES5RWJta38NEd
 FVIMt7GF+DYMb9ojCmzhe5EmAgVLzWixb7tp6Iv8SpxmWNnhNUgld+6SCBgS9esbVTp5 vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3b0xucf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:03:03 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SIdgGc085784;
        Wed, 28 Jul 2021 15:03:03 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3b0xuceg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:03:02 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SJ30NJ001177;
        Wed, 28 Jul 2021 19:03:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3a235yh8rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 19:03:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SJ0HAW26411392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 19:00:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 660F6AE04D;
        Wed, 28 Jul 2021 19:02:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0424EAE051;
        Wed, 28 Jul 2021 19:02:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 19:02:56 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 4/4] s390: add kfence region to pagetable dumper
Date:   Wed, 28 Jul 2021 21:02:54 +0200
Message-Id: <20210728190254.3921642-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728190254.3921642-1-hca@linux.ibm.com>
References: <20210728190254.3921642-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kBtBiiHRGC3KLk1NfivqjvaINgTK5QIE
X-Proofpoint-ORIG-GUID: -tcTXh2f0dP8OWuGmKumfU33hNOrvJ1w
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_09:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280106
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/dump_pagetables.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index e40a30647d99..07dcec925bf4 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -4,6 +4,7 @@
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
 #include <linux/mm.h>
+#include <linux/kfence.h>
 #include <linux/kasan.h>
 #include <asm/ptdump.h>
 #include <asm/kasan.h>
@@ -21,6 +22,8 @@ enum address_markers_idx {
 	IDENTITY_BEFORE_END_NR,
 	KERNEL_START_NR,
 	KERNEL_END_NR,
+	KFENCE_START_NR,
+	KFENCE_END_NR,
 	IDENTITY_AFTER_NR,
 	IDENTITY_AFTER_END_NR,
 #ifdef CONFIG_KASAN
@@ -40,6 +43,10 @@ static struct addr_marker address_markers[] = {
 	[IDENTITY_BEFORE_END_NR] = {(unsigned long)_stext, "Identity Mapping End"},
 	[KERNEL_START_NR]	= {(unsigned long)_stext, "Kernel Image Start"},
 	[KERNEL_END_NR]		= {(unsigned long)_end, "Kernel Image End"},
+#ifdef CONFIG_KFENCE
+	[KFENCE_START_NR]	= {0, "KFence Pool Start"},
+	[KFENCE_END_NR]		= {0, "KFence Pool End"},
+#endif
 	[IDENTITY_AFTER_NR]	= {(unsigned long)_end, "Identity Mapping Start"},
 	[IDENTITY_AFTER_END_NR]	= {0, "Identity Mapping End"},
 #ifdef CONFIG_KASAN
@@ -248,6 +255,9 @@ static void sort_address_markers(void)
 
 static int pt_dump_init(void)
 {
+#ifdef CONFIG_KFENCE
+	unsigned long kfence_start = (unsigned long)__kfence_pool;
+#endif
 	/*
 	 * Figure out the maximum virtual address being accessible with the
 	 * kernel ASCE. We need this to keep the page table walker functions
@@ -262,6 +272,10 @@ static int pt_dump_init(void)
 	address_markers[VMEMMAP_END_NR].start_address = (unsigned long)vmemmap + vmemmap_size;
 	address_markers[VMALLOC_NR].start_address = VMALLOC_START;
 	address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
+#ifdef CONFIG_KFENCE
+	address_markers[KFENCE_START_NR].start_address = kfence_start;
+	address_markers[KFENCE_END_NR].start_address = kfence_start + KFENCE_POOL_SIZE;
+#endif
 	sort_address_markers();
 #ifdef CONFIG_PTDUMP_DEBUGFS
 	debugfs_create_file("kernel_page_tables", 0400, NULL, NULL, &ptdump_fops);
-- 
2.25.1

