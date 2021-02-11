Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA68BC433DB
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A128264E2A
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhBKAEs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:04:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54792 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhBKAEj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Feb 2021 19:04:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B003SH123011;
        Thu, 11 Feb 2021 00:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=xFDVWByD2oAC85jpuSE1pSb/AgKJj7UFlwVSzmEx6wE=;
 b=H0tLtdgDVbDnGHWElD+UWz1HCkMa6YNHgwdEiYal32Zj2X+q36mZ7PF+XpDtxJ7hID1k
 4AprgG1dpjGYjmw/5Ksf7BsjCtMzqZJkFGU2RYlfKW0RzQ4Z5DAnL1t+vaFUTgzj3x2W
 WLgmuNEHtYf50BaUT0I+OuIbm7DLaf7duJv3o8mlMND31n8W9TdvXQ/g2NFX9F9CEQ0j
 598n4vaY1G5tfMbUwTFJe0MvmTDlFq9HmRmo293mOSNeHjYGT3pnOy05ylBCDKgryNDs
 fPKD7r4Ew4g4bCr7HhD2RpDWRtj3ncxpfsQNzkDCR8fdAJ9HhnD/A3n/RJfb2pkeU+XN dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36hkrn5fv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B018pB028014;
        Thu, 11 Feb 2021 00:03:45 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2056.outbound.protection.outlook.com [104.47.38.56])
        by userp3030.oracle.com with ESMTP id 36j51y8pj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezv7eyO0MM/ugL3U2BWWpgZlGGTaPlC+50GhetSqGx7fZkhsSapbZDIp7qjC9ZRV8DjRmRX0tsL4YTvfWc/bh8ox7nxYlYPzjLHLbxJqlSk47bIh6rTIc5hSe8CkEYLACh0XSMMAWBRDAtrf2EpvBf+Ra8aNTjU5d2xIV49pW656uYI4fWOUAd0FMzuGEUZR8PZc1VJgheaqc3wAnN9B0wCH+onhUeMIITe1AdLCKzKsZBN50GOP/0HE78RgDvTACUPkM/EC6fUisiP49IfAj/XJE+Pm1vSJbAEV5ahbOtn42/WQkT0IHSru7cIjWn8QGosAvceG/Y+PQZ0dPRwIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFDVWByD2oAC85jpuSE1pSb/AgKJj7UFlwVSzmEx6wE=;
 b=P7yUqZ1nNwFuXUDMUrjXubSdQbltl892KcpCDNxTgSqzT1Bi8xuj0HmY6+lP8L/Gr2SB1g1/WWdBOXGHxSUxp5OAJFVzEkaCTVXrWL49PvSn2kwxBV10tFYu1pRojrlagF7wMSKl+baHX4UrAyWsTR2AKMTLAnjvyNiwQ9FEDQfseVNPdr0R1fz3NMDOhaLOSqTISnoNwC7L+/rVhebI8H8DBTzf6pl1eI1r0ewLF7XFAAdy2urhqrPQvR4jp3KOc/cT9lTyNYJMWgE3ptIA8un+v2fGTs2nqXgtBkozw+LP2ffGgR0ji4/EQje0944mBMMNiYBaVrQ/tsiInuaMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFDVWByD2oAC85jpuSE1pSb/AgKJj7UFlwVSzmEx6wE=;
 b=V3mle0EDAPUgMBBGnFntuigWnbYwxxmCJGTzJFJ+kTPnGkyuboFIYdaHGHP06IUuCgm+dvx1JTDV5vccLsw+SBcrrMiBUXOO9qrKRi6GoaSfsahhts4PSkmBw6qYYWVK0TuWJZDfDR4KD1mvUAkIR86QkA4Uj+Q2e76tfsnCcNE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1933.namprd10.prod.outlook.com (2603:10b6:300:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 11 Feb
 2021 00:03:42 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Thu, 11 Feb 2021
 00:03:42 +0000
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
Subject: [RFC PATCH 5/5] mm proc/task_mmu.c: add hugetlb specific routine for clear_refs
Date:   Wed, 10 Feb 2021 16:03:22 -0800
Message-Id: <20210211000322.159437-6-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR01CA0032.prod.exchangelabs.com (2603:10b6:300:101::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 00:03:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 703a04e7-6d7e-4493-b9db-08d8ce207dba
X-MS-TrafficTypeDiagnostic: MWHPR10MB1933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB193368824FA8B11E63D5D3EEE28C9@MWHPR10MB1933.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bS9AxGaAbmEytK+Yh5ULJxL0Siyho4mjv/w5yZvGele0SghLWkDSo4CwzVaKBtDJ5s0D03AxXPlsuDYaoFfIPTHh//CxraNE4jOV9HeBo/S+OLjMQllEK0aAl/X5xG4EpnChvIHDMZwA2b00+IiCfwEpV+SXNvur3lAKEz92IeiynCljCez4e8HSNzfhm7UGamNbjHPyAr1vMGHqx1PQrkQks8EzdhDpZqd9UTeGrIVI60+PvWaUpRi6sZ3yiXP/NyQAnRDOAMESb1PNhu8P2TVMC/DlcaRuE8AbCqRiOtB1gOpGMWB30pWwEatvKDg8qR6DxPvqi1xjWUEEsjzmk02apAPAlucpOj6+bqiu9cbNiQmavvbHGgJsFutyk5NQcL74h189YDn3+v2Lv9XkXShGVEmyoYxIlLkmjMHlrAxEpy3Mue645l0/ILIXXuDmi1ANQK4JmoBz7BmZE9FZFOdI+sMVKY0JEPQj+Lva0P056BOL7xPtxOqwp/GgHlAtxhEcKfvqJ5gyd2E/rmae7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(376002)(346002)(7696005)(5660300002)(26005)(478600001)(52116002)(86362001)(1076003)(2616005)(956004)(186003)(36756003)(16526019)(8936002)(6486002)(66946007)(316002)(44832011)(7416002)(107886003)(8676002)(2906002)(4326008)(6666004)(66556008)(66476007)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ro/dEOPiGmHiPE06hxt4NoxNurlGma6YN6sOipMkALeilkUozRjsZkUyNXi2?=
 =?us-ascii?Q?PbB2Uoe1HWS17mRz8UFoMw10t3QGcqCb13xQhOUN/yK2QA7u1lRIlJ6gp/hH?=
 =?us-ascii?Q?s4xvv3cmX6LFbU31NC8Vx0TtXDQ0Sa2CcNqrsiEzLUuwWy3Z9YV2VgHKwCuw?=
 =?us-ascii?Q?zKgmWBOZ2ubmhsAwUFyIYlUgwliY/WaubpjE2x3Dri36d+b6bnU38NfdIlsk?=
 =?us-ascii?Q?aGwwAWU5Ecfg1Atoa5GvkwlxHT6sSUouXYWhFI5fTW1U+ZFCZ/91VPwsXCMe?=
 =?us-ascii?Q?Xu/0kRw2ZmL5zY7bX140+DRcygQn35NTd/kEqCGuHjn3CwaI97iO7vYcT1B4?=
 =?us-ascii?Q?jugso+YCaDoSjZzObYsDfWAHyXzFYNmmByfB/LG1cIBxb1IFrVDqQLTrDhVh?=
 =?us-ascii?Q?3+WhmOi+FafnYIkXSUM1A7zPOOxyglvnu+S+x2pwBOsJQF97Y4rK+HJBtxKT?=
 =?us-ascii?Q?QidO0g+qX/IcEfeqozuwcOZbX6NUKXUZqnu+Q/qNhEbj72pGY8gw0nFo0s1G?=
 =?us-ascii?Q?JrWectnSbS1sa0sfcWzOoC5wT8J+rsCi/PA72uJhhi5V1FEKEvsoUiFfqfGf?=
 =?us-ascii?Q?93R4Z/y3JiWAj/t7ZvSiox1JGuvBtkgcphN923B7/5WjtPdiVbfTKZvwaHMW?=
 =?us-ascii?Q?gduJRIy9PbSXe6BcJFtSKc6D/f+wThPc/my7Qs9cZ2ewo4G4vv3ZlJRXxdlt?=
 =?us-ascii?Q?grSS1vn5T0PNc268LBIjxC3Xu5o7+YYUlIMMbT/J/7/U+FJ4h13vmZv88Lvu?=
 =?us-ascii?Q?cLZfQ/TRs0pJUG2MtibalC0uCrZ0PmwcF6df5MN45yN/qzlZRw86xLE0NcSb?=
 =?us-ascii?Q?55Yx5OmVrHda+KxW3p4SvdPlPmfhES92VcuZqG/5WpqCs3v2/BNEc1GAnYLt?=
 =?us-ascii?Q?oExcHQ5eb2+FoFDJQOGIrHbr6O4fDd/Hggd0ut0r+Q4auKlM0EbgIETeeMUm?=
 =?us-ascii?Q?9S5Nm93cn0YQrOeAnoif004KWToW4BF2WdQ2jq7Ymn5kMKsr9LcXC4GSjRBl?=
 =?us-ascii?Q?cK6rKA9BnozghKY8S1Vo2U/fFuups/CediBtoyNrs4BHl31a2qBiUeJi9GJU?=
 =?us-ascii?Q?g0SmFW7NEiVQDj7kM5Ee49byvojVmBDjkMYlxWMtDJSaS/KP7VFhzMtaYHFB?=
 =?us-ascii?Q?6l9v67XlB7BWdldRJOArK9aGmkSo92m3wjbgcg52vB1JBcf6EWRUJK2Hca3y?=
 =?us-ascii?Q?WGYnfN+TUbuLtbnzvkZar3yTasN+P0a0e/d5dUmXZgkuBt1SGAM6R69A3+bH?=
 =?us-ascii?Q?07E/rhvFzbhQRyVROEOEUKeE4ODgHqyYhAFwQpp59D2gn/l8tjXy2R3aRpZ8?=
 =?us-ascii?Q?M5vB8w0nKx5+DIoKYJ7chWrE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703a04e7-6d7e-4493-b9db-08d8ce207dba
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 00:03:41.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWFocIIsVsJBvsNyjSsA5W0MF1T/CkYn8bXMI7uVODF4UBolRrnQlZx/DGDTcZrRNs67nGkUbhKt1TEeA1mnlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1933
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100209
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100209
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

There was is no hugetlb specific routine for clearing soft dirty and
other referrences.  The 'default' routines would only clear the
VM_SOFTDIRTY flag in the vma.

Add new routine specifically for hugetlb vmas.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/proc/task_mmu.c | 110 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 829b35016aaa..f06cf9b131a8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1116,6 +1116,115 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE
+static inline bool huge_pte_is_pinned(struct vm_area_struct *vma,
+					unsigned long addr, pte_t pte)
+{
+	struct page *page;
+
+	if (likely(!atomic_read(&vma->vm_mm->has_pinned)))
+		return false;
+	page = pte_page(pte);
+	if (!page)
+		return false;
+	return page_maybe_dma_pinned(page);
+}
+
+static int clear_refs_hugetlb_range(pte_t *ptep, unsigned long hmask,
+				unsigned long addr, unsigned long end,
+				struct mm_walk *walk)
+{
+	struct clear_refs_private *cp = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	struct hstate *h = hstate_vma(walk->vma);
+	unsigned long adj_start = addr, adj_end = end;
+	spinlock_t *ptl;
+	pte_t old_pte, pte;
+
+	/*
+	 * clear_refs should only operate on complete vmas.  Therefore,
+	 * values passed here should be huge page aligned and huge page
+	 * size in length.  Quick validation before taking any action in
+	 * case upstream code is changed.
+	 */
+	if ((addr & hmask) != addr || end - addr != huge_page_size(h)) {
+		WARN_ONCE(1, "%s passed unaligned address\n", __func__);
+		return 1;
+	}
+
+	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, ptep);
+
+	/* Soft dirty and pmd sharing do not mix */
+
+	pte = huge_ptep_get(ptep);
+	if (!pte_present(pte))
+		goto out;
+	if (unlikely(is_hugetlb_entry_hwpoisoned(pte)))
+		goto out;
+
+	if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
+		if (huge_pte_is_pinned(vma, addr, pte))
+			goto out;
+
+		/*
+		 * soft dirty and pmd sharing do not work together as
+		 * per-process is tracked in ptes, and pmd sharing allows
+		 * processed to share ptes.  We unshare any pmds here.
+		 */
+		adjust_range_if_pmd_sharing_possible(vma, &adj_start, &adj_end);
+		flush_cache_range(vma, adj_start, adj_end);
+		/*
+		 * Only atttempt unshare if sharing possible.  If we unshare,
+		 * then pte's for a PUD sized area are effectively removed for
+		 * this process.  That clears soft dirty.
+		 */
+		if (adj_start != addr || adj_end != end) {
+			struct mmu_notifier_range range;
+			int unshared;
+
+			mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR,
+					0, vma, vma->vm_mm, adj_start, adj_end);
+			mmu_notifier_invalidate_range_start(&range);
+			i_mmap_lock_write(vma->vm_file->f_mapping);
+			unshared = huge_pmd_unshare(vma->vm_mm, vma,
+								&addr, ptep);
+			i_mmap_unlock_write(vma->vm_file->f_mapping);
+			mmu_notifier_invalidate_range_end(&range);
+			if (unshared)
+				goto unshare_done;
+		}
+
+		if (is_hugetlb_entry_migration(pte)) {
+			pte = huge_pte_swp_clear_soft_dirty(pte);
+			set_huge_pte_at(walk->mm, addr, ptep, pte);
+		} else {
+			old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
+			pte = pte_mkhuge(huge_pte_wrprotect(pte));
+			pte = arch_make_huge_pte(pte, vma, NULL, 0);
+			pte = huge_pte_clear_soft_dirty(pte);
+			pte = huge_pte_mkyoung(pte);
+			huge_ptep_modify_prot_commit(vma, addr, ptep,
+							old_pte, pte);
+		}
+
+unshare_done:
+		flush_hugetlb_tlb_range(vma, addr, end);
+	}
+
+	/* reference bits in hugetlb pages are not reset/used */
+out:
+	spin_unlock(ptl);
+	return 0;
+}
+#else /* CONFIG_HUGETLB_PAGE */
+static int clear_refs_hugetlb_range(pte_t *ptep, unsigned long hmask,
+				unsigned long addr, unsigned long end,
+				struct mm_walk *walk)
+{
+	return 1;
+}
+#endif /* CONFIG_HUGETLB_PAGE */
+
 static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 {
@@ -1198,6 +1307,7 @@ static int clear_refs_test_walk(unsigned long start, unsigned long end,
 }
 
 static const struct mm_walk_ops clear_refs_walk_ops = {
+	.hugetlb_entry		= clear_refs_hugetlb_range,
 	.pmd_entry		= clear_refs_pte_range,
 	.test_walk		= clear_refs_test_walk,
 };
-- 
2.29.2

