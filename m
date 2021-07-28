Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC6C41537
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55B060ED4
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhG1TDI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:03:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231458AbhG1TDH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 15:03:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SIdu8O117481;
        Wed, 28 Jul 2021 15:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TY2BxtcboaFxsAjIWr+bqU571UGJno7E1tOu/3N/QY0=;
 b=lTHi+jCt0vZ5FBLm4TIAjk4Wj9kXWpVze3u1salpz+OT5b1dvF6/Ko27MJMWOE8AeOsS
 5RfSIejPgwjzJ2qjsKmdns+1ope9z8yL0jqFHou4zl8MWv4DVenfRqucm3ODDsctecVq
 eD06DbUd8Tp3O8DHJUtmAYlB2lBh+D0amTq37oWCkJttVzTZKW4k7c3JH/xGDY4xpaTC
 ZiIJrwyp7jyk31wXvcuhxmopkToDqeTG3pzxCWcDDkjqrQiQN+XXZmldrIg7G65QmAus
 f6+8nmDiC+CSoncl3DyuQFuABLO3/LcTNZc5DNB+MdH0SZQAkWf3U+aiXRsqGTL63tBf wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3cbd149e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:03:02 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SIeF6T119128;
        Wed, 28 Jul 2021 15:03:02 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3cbd148b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:03:01 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SJ2xYB001174;
        Wed, 28 Jul 2021 19:02:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3a235yh8rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 19:02:59 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SJ0DBE34668868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 19:00:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04589AE04D;
        Wed, 28 Jul 2021 19:02:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 968E0AE045;
        Wed, 28 Jul 2021 19:02:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 19:02:55 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/4] s390/mm: implement set_memory_4k()
Date:   Wed, 28 Jul 2021 21:02:51 +0200
Message-Id: <20210728190254.3921642-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728190254.3921642-1-hca@linux.ibm.com>
References: <20210728190254.3921642-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H2XAFT0iBukiW2CNa3D3fDpkJ8eIW_KB
X-Proofpoint-GUID: lyj2SiATl_2gzjzM9MnZ3TOdVVj8g_bp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_09:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280106
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Implement set_memory_4k() which will split any present large or huge
mapping in the given range to a 4k mapping.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/set_memory.h |  6 ++++++
 arch/s390/mm/pageattr.c            | 12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
index a22a5a81811c..950d87bd997a 100644
--- a/arch/s390/include/asm/set_memory.h
+++ b/arch/s390/include/asm/set_memory.h
@@ -10,6 +10,7 @@ extern struct mutex cpa_mutex;
 #define SET_MEMORY_RW	2UL
 #define SET_MEMORY_NX	4UL
 #define SET_MEMORY_X	8UL
+#define SET_MEMORY_4K  16UL
 
 int __set_memory(unsigned long addr, int numpages, unsigned long flags);
 
@@ -33,4 +34,9 @@ static inline int set_memory_x(unsigned long addr, int numpages)
 	return __set_memory(addr, numpages, SET_MEMORY_X);
 }
 
+static inline int set_memory_4k(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, SET_MEMORY_4K);
+}
+
 #endif
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index ed8e5b3575d5..b09fd5c7f85f 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -155,6 +155,7 @@ static int walk_pmd_level(pud_t *pudp, unsigned long addr, unsigned long end,
 			  unsigned long flags)
 {
 	unsigned long next;
+	int need_split;
 	pmd_t *pmdp;
 	int rc = 0;
 
@@ -164,7 +165,10 @@ static int walk_pmd_level(pud_t *pudp, unsigned long addr, unsigned long end,
 			return -EINVAL;
 		next = pmd_addr_end(addr, end);
 		if (pmd_large(*pmdp)) {
-			if (addr & ~PMD_MASK || addr + PMD_SIZE > next) {
+			need_split  =  (flags & SET_MEMORY_4K) != 0;
+			need_split |= (addr & ~PMD_MASK) != 0;
+			need_split |= addr + PMD_SIZE > next;
+			if (need_split) {
 				rc = split_pmd_page(pmdp, addr);
 				if (rc)
 					return rc;
@@ -232,6 +236,7 @@ static int walk_pud_level(p4d_t *p4d, unsigned long addr, unsigned long end,
 			  unsigned long flags)
 {
 	unsigned long next;
+	int need_split;
 	pud_t *pudp;
 	int rc = 0;
 
@@ -241,7 +246,10 @@ static int walk_pud_level(p4d_t *p4d, unsigned long addr, unsigned long end,
 			return -EINVAL;
 		next = pud_addr_end(addr, end);
 		if (pud_large(*pudp)) {
-			if (addr & ~PUD_MASK || addr + PUD_SIZE > next) {
+			need_split  = (flags & SET_MEMORY_4K) != 0;
+			need_split |= (addr & ~PUD_MASK) != 0;
+			need_split |= addr + PUD_SIZE > next;
+			if (need_split) {
 				rc = split_pud_page(pudp, addr);
 				if (rc)
 					break;
-- 
2.25.1

