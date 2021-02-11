Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF85C433E0
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A4B64E2E
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhBKAEm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:04:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48760 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhBKAEe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Feb 2021 19:04:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ANxdJV100513;
        Thu, 11 Feb 2021 00:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=wAWXgNyLuvU0f8MOWGmRhDVqVdXn0dina7dfnF9YD9E=;
 b=uY66WZUFdMIs5OzEaT9MJ5MYjolWkQd0mT17m06WnuXkwyX56ZsbSJgL/vx5bgRtAiRe
 akkcKRfEUE17hbx7Yxa7l8+VXwoebobkbIxyvzvpymsjkbpI9jyvgx06bJVPz/9v3d80
 sF6Lw+86Fd40AJCKaMx0z8jgXoCPwpn1OBwLJxj8RMp/lC7uUYnHguwkSggdeOCirO2C
 V/errWaQib0Q03yrkbb/HhvUprExZ3wd/PhL8jQJyOmbH8AYBHXXo6OPXxLlRDq3UBZe
 fdWQxMcSpniZcCL6IcBn3slkqWO/BUW/amf9fujcWF8wDgrQfxuBrvJCRhxflDYS4grh 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36m4upv2bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B001ro158444;
        Thu, 11 Feb 2021 00:03:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3030.oracle.com with ESMTP id 36j4pqtph3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyPvZZY09gy2YshrKBzKCrEssTwc4LafuLkxb68KXcZDuNsJJaT3pJOtkELBARLOaxOlJhXq35xwvEx/pZtK27C36HJ4SfWPnlNyYo47H0iqrJA7aROUYpyUXej7XYAgXYnDB/xQ14BgfqtwCSDlPGGiZNWhlXTKVPp9K/xtobl+07lpb5gDOMP89hZelqRbRo8CIGVEtXEYxMXPrTz6aNNchnTBqIsR1hxxpE+3OQUAaRHxtvEW4Ek3GOho/GKWd0wKJvqjhFLTIpibO4tCjj2YevFMlz28ZhGOhccEcAgT1CoL8UMOqpHpF5ZWGV2dFCz7bCupNHjkqK+4diWFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAWXgNyLuvU0f8MOWGmRhDVqVdXn0dina7dfnF9YD9E=;
 b=Ssed28rbIU9JW6j33GlPOG5E2cfyC2K4Sv+7m9TmUSKmCm41vlY5auV3iDgtNzAMdXmq2NfemL/T5R0kqQgw3zlZhPkI5fTjaIgG2YghX0v4TORImLq6GP1Jz59XohD38cL3E39cqFTQo5bX7yedHhgmRT5nleYlNHum6oGAMxLpBYQLcARKrrr8JFmIYMoTQfR5u26guktl1wPGfXrHF/Y9Gqo9FVOCaaCvJPb0/3ZjF/c61gGc+FqamN1wq+fN7RNw9++CMO6DKnZhwEBRp46tpJsZt5tDc16U//b8hyHxARK36JbLaOS8TMKkwfOxhzvnG5NBsevHfjUsF24UnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAWXgNyLuvU0f8MOWGmRhDVqVdXn0dina7dfnF9YD9E=;
 b=z9z7xE3EK/lffIPCpMpLqHQAqzffDK5nCEcsBD3GHXypeS1YZRIwtj1fVBLleaifaLzVVHuCSZuwRmPqKyuqElGz6BcR26a3HMYHwyfiTkNk0r7/vkejVSUCNn59hPdTiJF17+SgpqwQXuuarolYbKBS71xdizCg4idyl4FGr54=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1341.namprd10.prod.outlook.com (2603:10b6:300:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 11 Feb
 2021 00:03:35 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Thu, 11 Feb 2021
 00:03:35 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     shu wang <malate_wangshu@hotmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 1/5] hugetlb: add hugetlb helpers for soft dirty support
Date:   Wed, 10 Feb 2021 16:03:18 -0800
Message-Id: <20210211000322.159437-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210211000322.159437-1-mike.kravetz@oracle.com>
References: <20210211000322.159437-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR01CA0032.prod.exchangelabs.com (2603:10b6:300:101::18)
 To MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR01CA0032.prod.exchangelabs.com (2603:10b6:300:101::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 00:03:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37ab7c82-c94e-4e69-f8ec-08d8ce207978
X-MS-TrafficTypeDiagnostic: MWHPR10MB1341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1341F81AF204175BDAABFB2FE28C9@MWHPR10MB1341.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZfA7ux8D8Fw6/1RTU3TBrlx8A9lcHoRy0kf0xrlBD+angg+TqMgR8InBYmSKHQRGzt3NzdF6jmpHqPGebOqZd8l7+dVlfS9Wjg6YZy8WCeVGwotLQiFhzHEdEVUVGVYopR2HSoOxSuY5xClWzXWSfUVVcTrSsMVqmFILXI+BV6uCaE0RO4Nx/GEAxpZQgWOm79+4n/WKR9S5phWWZ31b7TYsbSgSe2yWCwe70PF3BEscpJErOgPEgN3VI/lAeFXy4rQkyq01WvlkFS9DVjQ/w4Drr10TJDTryndMPUCB4agcPqxDLan4DUn/tPwKaDpgTdDiP7+ZFHi29zV3DgXDTCG3tRoWIpPXPF/sX03f5IBh19HS9QHvT/cF1ZbW6FYo4LiNol6kpa1RFBb+1IO589VK0Ps41ZPC5wUV/bmpFfASooe/P9Z5VvzrOeNfgzELRNc9A5EkQoNCOrv2d42AUebnX1364isM9W2m4e9M9bEo4+MCH+ZhDzpiyxmHVhy9p+Vq5Si4KZgI+Ct6iEnAy3/ItmQ1L/IwIYIPi1JvZm3Fqts/H+YCmYbzTy0FDpl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(366004)(396003)(136003)(107886003)(4326008)(6666004)(2906002)(8676002)(44832011)(7416002)(66556008)(83380400001)(66476007)(54906003)(1076003)(2616005)(956004)(7696005)(5660300002)(26005)(478600001)(52116002)(86362001)(8936002)(6486002)(66946007)(316002)(186003)(16526019)(36756003)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TXOJnrS4g8peNhlpBnmteGKecm2wU1ZSiosZ++NjNGBARnR+erg02vMmjfA5?=
 =?us-ascii?Q?x6PvZga6kh2usfppmeLHzqLqJhkI9BjAeSTRBjiQK+3KVGdTdRNISuLXLKJq?=
 =?us-ascii?Q?bTJ64oRgM0emU48xP4l5vdg+ilg8WH4Sw4trxxc4g7s4ffj95lxF9OvdMIni?=
 =?us-ascii?Q?x0+E8AFYcMjioC8oY+A/8vjX966wPD7TzU9NH+zjc5mwc5mS9/EpJO2QvfKu?=
 =?us-ascii?Q?yjN/HRQZOy6PebRV9Gg9J+RFNgZZVv7ktdx9GNbzRV7z6xTh56oKUBhRflvH?=
 =?us-ascii?Q?8uMiM/zQn3RWN9BMcrJYbRegvJnQF2eA05cgtfns+j8jwkvzWTy2OnN74ARM?=
 =?us-ascii?Q?QisA9gAn6Ldi/uYZLYu4uPznN6S7gY77meYLJGWMcTfLE3R1WZoixbWKNdAn?=
 =?us-ascii?Q?orXV4F31CkYGKPR7XBDKFyOMwein5zJ/npS1uvbWkYASKSQee880JbdD1Jrk?=
 =?us-ascii?Q?9RAXTBLVxlNVyZIvYomen4TJ/qyPZO+3jNtbWCfHzI3LO9S6yw7hCWUQrUkN?=
 =?us-ascii?Q?90d4PKa6moJP7XHdNqGM8vOQHRJjbUAQf6mQIiIaGRnZIrla+PqUcevahyGo?=
 =?us-ascii?Q?V86mk+9iknxDa/L8rf8eb6DBdsrePeZFy/pPYR5wkmupNQNkfxI0hU2X3Mzq?=
 =?us-ascii?Q?80zfChDoqBy3e9Osb0WoFcfEnOqLdv1cuDo/jl46R3Ga+cNNl5CqqiERXJN2?=
 =?us-ascii?Q?Y8cH6pEgLOex+l/nj+tXbX6ZxPI4DudMsd0RAa/XN10QvQrOkcqGV2RY6M/K?=
 =?us-ascii?Q?P3mGhkYutBc+KIn3HApD3VRG3GsQ4v8ig3UZHt9vqWIJnHbfo8VSNH03xsxM?=
 =?us-ascii?Q?mxqhOn6rjVJvEDQmqn36lx1pspo17KqzfxJmN9qFAh30+vs9pDRfHRvr0AZU?=
 =?us-ascii?Q?ZqUi8tpazHAyRHf7ipPIyT1QcUdxUumQ6SAM0y1bYAEVnu5WU/yUI1T6ohpe?=
 =?us-ascii?Q?U1EnwU8iBWYk5wKjovirlxUETfT0DESfZeCVAtqN+FuXiPTbdRL94UPWfd0C?=
 =?us-ascii?Q?mcMoG3oi0nszrMMfsKDOCczB6Jh1h9v/96L/tkCXu68TRhrTzWZasq9fO838?=
 =?us-ascii?Q?RqZYXzBGdyyKajrXfaTsk2eHt4591TTnJauRhmlMWpFlb4wkOrdeNjo9Rr5G?=
 =?us-ascii?Q?qdVk8+a5gc/a4hiZdZSUzB3CgfGXMw70tQhTsHD9KAZrlJiU3+7t/FJgO0mP?=
 =?us-ascii?Q?lzC26M1GLyfuAaYWWx1WqOIZsCWNw9ne78YZgcbBbQ4IFGII4kGeo0TPsSha?=
 =?us-ascii?Q?NbeGPtPVcrKkd53qNZhJjj/WT3Kh5WSbsMkrsntncb/jHb/cz8QsmQ2tbHWS?=
 =?us-ascii?Q?QCbAggJZpn36W6FT+/rT6Lo/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ab7c82-c94e-4e69-f8ec-08d8ce207978
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 00:03:35.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeaDhLT3mB4WQe7v8x8/95anFElVrsjS1mRTb4b9MwJZnFIJwakTk57pZO3o7CPEjKD2OX1oYM5XcNv8T1F6nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1341
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100209
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100209
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add interfaces to set and clear soft dirty in hugetlb ptes.  Make
hugetlb interfaces needed for /proc clear_refs available outside
hugetlb.c.

arch/s390 has it's own version of most routines in asm-generic/hugetlb.h,
so add new routines there as well.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/s390/include/asm/hugetlb.h | 30 ++++++++++++++++++++++++++++++
 include/asm-generic/hugetlb.h   | 30 ++++++++++++++++++++++++++++++
 include/linux/hugetlb.h         |  1 +
 mm/hugetlb.c                    | 10 +---------
 4 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 60f9241e5e4a..b7d26248fb1c 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -105,6 +105,11 @@ static inline pte_t huge_pte_mkdirty(pte_t pte)
 	return pte_mkdirty(pte);
 }
 
+static inline pte_t huge_pte_mkyoung(pte_t pte)
+{
+	return pte_mkyoung(pte);
+}
+
 static inline pte_t huge_pte_wrprotect(pte_t pte)
 {
 	return pte_wrprotect(pte);
@@ -115,9 +120,34 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 	return pte_modify(pte, newprot);
 }
 
+static inline bool huge_pte_soft_dirty(pte_t pte)
+{
+	return pte_soft_dirty(pte);
+}
+
+static inline pte_t huge_pte_clear_soft_dirty(pte_t pte)
+{
+	return pte_clear_soft_dirty(pte);
+}
+
+static inline pte_t huge_pte_swp_clear_soft_dirty(pte_t pte)
+{
+	return pte_swp_clear_soft_dirty(pte);
+}
+
 static inline bool gigantic_page_runtime_supported(void)
 {
 	return true;
 }
 
+#if !defined(__HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE) && !defined(MODULE)
+#include <asm/tlbflush.h>
+
+static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
+					unsigned long start, unsigned long end)
+{
+	flush_tlb_range(vma, start, end);
+}
+#endif
+
 #endif /* _ASM_S390_HUGETLB_H */
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 8e1e6244a89d..d8a78dab63bf 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -27,11 +27,31 @@ static inline pte_t huge_pte_mkdirty(pte_t pte)
 	return pte_mkdirty(pte);
 }
 
+static inline pte_t huge_pte_mkyoung(pte_t pte)
+{
+	return pte_mkyoung(pte);
+}
+
 static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return pte_modify(pte, newprot);
 }
 
+static inline bool huge_pte_soft_dirty(pte_t pte)
+{
+	return pte_soft_dirty(pte);
+}
+
+static inline pte_t huge_pte_clear_soft_dirty(pte_t pte)
+{
+	return pte_clear_soft_dirty(pte);
+}
+
+static inline pte_t huge_pte_swp_clear_soft_dirty(pte_t pte)
+{
+	return pte_swp_clear_soft_dirty(pte);
+}
+
 #ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		    pte_t *ptep, unsigned long sz)
@@ -133,4 +153,14 @@ static inline bool gigantic_page_runtime_supported(void)
 }
 #endif /* __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED */
 
+#if !defined(__HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE) && !defined(MODULE)
+#include <asm/tlbflush.h>
+
+static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
+					unsigned long start, unsigned long end)
+{
+	flush_tlb_range(vma, start, end);
+}
+#endif
+
 #endif /* _ASM_GENERIC_HUGETLB_H */
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b5807f23caf8..7b6c35c5df99 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -187,6 +187,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
 bool is_hugetlb_entry_migration(pte_t pte);
+bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4bdb58ab14cb..47f3123afd1a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3759,7 +3759,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
 		return false;
 }
 
-static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
+bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 {
 	swp_entry_t swp;
 
@@ -4965,14 +4965,6 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
-/*
- * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
- * implement this.
- */
-#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
-#endif
-
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
-- 
2.29.2

