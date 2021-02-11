Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD261C433DB
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DE164E31
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhBKAEo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:04:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54760 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhBKAEf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Feb 2021 19:04:35 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B00vap123526;
        Thu, 11 Feb 2021 00:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=lWuyKdSvNH7sRgrTc7guPksVygGWWPSQVwqqKuMLE04=;
 b=q2YQpqhfZo38GyY+7ysC80wGjyB6jOKQfUTjZGUbqGbRNWPFBGXZkyN43DRzl+e1qKIL
 cW+nBwBpkcwOd/ex/jSWNWOB1EaBxRPsNcjARcaERYDWHchYpTmn2s9xS5ED0ghclrkS
 bFAxooOWUXI05d+N4rAyRp+FXEDzSLW9lfuw5xvIgPwHJRsxdEEwVNv03RS6kKhVao5m
 kBjHhn7IU7dxXtaEsitKQvRSHscrZX9/n1ahHQccbVhqK7QToj1W0pHXyQcGzBK4LGN9
 pWMBXt2fZMZU3N/WLV6nJBmzm576uKr2x2hLUyotdkNTThIx6ts3q/KMgqtrKi1QASDW qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36hkrn5fv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B001rp158444;
        Thu, 11 Feb 2021 00:03:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3030.oracle.com with ESMTP id 36j4pqtph3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSE7nqoEyBQNniTvQdK0ewBHPuu/in01Sy5OQrYVV2j6XsAX3C3kM5F3qGL+ERE6rU35Y5P65JMTHeVRaeCYiRXffa4kax7KJc+bBZ3GcuvU3Lzgf/W+JAeyTru33LLQ329OcCuY16vPJEbfngoRyIgx4xcxinFleGejGklnqxDT6algUa4wOm/eTRtpVzZRXmZIGG4f9msXszlsYne6I47dmxr3lEpt9Ls866QxmUjBLH8XWEBfpLEeedjkbD6mAlDRFT1NSGsp1fqhvzCTVFUmw73kZawapNdNvLyWvC+9GzhJZyWmTifzPvNN2uLUt0LYPaYOtnKwKwiSQ62/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWuyKdSvNH7sRgrTc7guPksVygGWWPSQVwqqKuMLE04=;
 b=gixddey1NH7VC0Mm/exMzwpAiJPAVzzBIb53qQ+tx9eF+NCir9M5fbSlPZD6z/gp0uJ/zZcY0TG5aeGCyO0DesRrb4gj2Pf8wDn+p3zqLGW3fWJvKVeJgGzrs+wYqpoML5Su+uInS/gN8Wn2cHyknB5534OZWOyhH9Hxt0RjeGI98SZLWtjKbQ1tNXxp53DBMbHbF1qWrVp0l9FV48kKvk2eOAMizsvnA2zC3/zZda2KJokr19BGC498x8shd14elEm0zRM7b6WxVGxXWMKe3evwUfhaTIE8mtPCqgxG3MK8T5BFlupBzdcVdwlTbp1TEfQ3kPixCLn46OAbb1QKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWuyKdSvNH7sRgrTc7guPksVygGWWPSQVwqqKuMLE04=;
 b=w9XOru1MR8UpVPdB5mqxA8hFoTWn3H+y1HvcSNb1XzYNfaKl0TnKywMhbwrTHtOJvO1xrSEySVMYnNqPCr7Vg1J12vUBouPi9zswFJXCXUxnIScm7DGa8Ds6517NfPpBkgMZtqOvXomHsYFPtXTVscVWNRGRxr0kDT86jtOa0VE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1341.namprd10.prod.outlook.com (2603:10b6:300:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 11 Feb
 2021 00:03:37 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Thu, 11 Feb 2021
 00:03:37 +0000
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
Subject: [RFC PATCH 2/5] hugetlb: enhance hugetlb fault processing to support soft dirty
Date:   Wed, 10 Feb 2021 16:03:19 -0800
Message-Id: <20210211000322.159437-3-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR01CA0032.prod.exchangelabs.com (2603:10b6:300:101::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 00:03:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f7f2bbe-a67f-4e51-1f39-08d8ce207ae4
X-MS-TrafficTypeDiagnostic: MWHPR10MB1341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1341328E316004ECB0827C71E28C9@MWHPR10MB1341.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIsAGNNgNlLyMfCxx9W0RFLcX8tZHMUfkRzhA0KMDTHTdyJpkNK1JQXpTMhy12EA3iHI6wasX9lvloTswnfIRChXojYyYMEg2K7qhU/a1MFLlb2FUXONwAv5/cXARP6LiVR4GvrI917q+w33vTnK7/HBLNXm22F8kY04EVHMiqE88do9lwHzXSZTv/Jqxc83nkUYTf0V9qmpuQBE0QYEDC9GizjTFK8kZK5TRt5GWGpGHN40ieqbn91fPedtRK4aOcQzia6uo+iJNRcgCgwhmG7E+9f/JdD3jEdDmrnsSlCBlO4WoNBeck56R9v+yirVmLqdnKa1/KiMWmNhlw1Nk8HC4Qnc+YxposaR8b0vAwSeHZk2RTNNQU1rZvf7nweh2C43VfDih4Pk/u5AaHssQOrgMQLKmUB6d9IeZgoAVvqqXgKgJu1cjEiLbpkV9TtxU+mrUKdPLclHHijf2yadbIXCX48exguICD5HpeFTkMGXeC0/VlPiIse9ZrAzJIsri1WRhleF+fzDUQf8z56AxeChh3o9l3lbpuF+k8Ys9F+UIfwKrwdfh5yFEueLAwLH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(366004)(396003)(136003)(107886003)(4326008)(6666004)(2906002)(8676002)(44832011)(7416002)(66556008)(83380400001)(66476007)(54906003)(1076003)(2616005)(956004)(7696005)(5660300002)(26005)(478600001)(52116002)(86362001)(8936002)(6486002)(66946007)(316002)(186003)(16526019)(36756003)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HFlX9d0ng6lP6Vqf/N21PM/JZBYqgjEI+jD70iO+l+x5xuRbNOJ3FlrEUoWP?=
 =?us-ascii?Q?uF20tkPJ401CM9jrd3tYuTA7t50uSzZln0eQvz+ZsCERhtFtmIu60p4GDZrS?=
 =?us-ascii?Q?NacL5s4ONUk2b6rdUypzTeAMywgHySXZSNsCtI7LOv1OQjZmnQBhuo//b9yu?=
 =?us-ascii?Q?iudBIK9PolY/QYxMhufAiBVwWIju1tvtSQ1NmUPT3VAh7xWW2FWT66boHQli?=
 =?us-ascii?Q?Fj7NhIl3U2Ofxufd+9gPLWk35p8e2DzRigFsKHXoWO/lejZiZaI81I1dgu0v?=
 =?us-ascii?Q?MY5UTt02sGX/3SRY2TUPkS8nxChxURiK53Et0hG+HTaK60kDJQYj/ZaqeIxn?=
 =?us-ascii?Q?IriUIJC3X70BleSjTkChdE8ndK7FGYT9QRW+kVy4JTzb4JL++den36zlIoVQ?=
 =?us-ascii?Q?fTTjXf4MB4piRpMutqWzS4WW4PfhrAeLU7B0swQF+LFuwVAgOX6XQZ77GJ8D?=
 =?us-ascii?Q?GXs+B+TMzZ9n1E9iSVbROeUHCfXRfxx+D4QuaLyzL8Z351sEZRCX0wVZDiwx?=
 =?us-ascii?Q?jq7mksl2d6/XRQ01HaUz/hoLA9Igw7azafx7IT5IoI7xsk/63F2bkk/6wpBD?=
 =?us-ascii?Q?CGepMO+C8IU/QrBFbQ/otAn5Fq0Gkr40Poa/qSVq8Zoia9VSJPeqWsWmoiRj?=
 =?us-ascii?Q?7TEmyhRhH1cNVz6m0XjTM4Egm8W0jsd74HhjTUqKRZUwv8bMkdX8u9UwYrqR?=
 =?us-ascii?Q?9sybzG56qnE1d27OHPEOmEAiPdrHs4YAQHhTxNfGKVB5GJHXKAxnzLRMTPpT?=
 =?us-ascii?Q?KxI44Rp3PLDmFFGOzj3IJcjuqcj1wl41zDe/Hw9iQ27ycBo779I73u39Y4Oo?=
 =?us-ascii?Q?KznR6vJktFjNusevh40qCIVQUBMQUALJk+XDChVl3jARihT4XlSX8vQAez6B?=
 =?us-ascii?Q?njj9YZqQEhDLnoeGgPFKWcMSakIHd3LpW6BnHmau43dMVnluBOvw6JMA+zxN?=
 =?us-ascii?Q?zZu6ztNLpahEM6vdNemk88LSSogcrPsh3CiU6Jgw7K7kTQGR5JMvRSRlAvaa?=
 =?us-ascii?Q?MmJ0N1xrYCXrpFBWkA+XVoziqE5iTvfyu4U48hqY//dPaDxVWkLatqq8JF7F?=
 =?us-ascii?Q?2PP/gVjxE+qmREvPKiisQ8xsyUFkwwO6MSdcy4N4NRYsqcu5dXUnudwe7r5z?=
 =?us-ascii?Q?QcFlSjgaybu9577w6b3Fj7lKXF2KwSpNynp+lVtr6+X/b53s+3VYZh0QlkvJ?=
 =?us-ascii?Q?v+W4PLD4fEuz7aRR5lMd47UH0ssh2n2713HomeVzq8sfHs6Wp9BKOM8Nm8LF?=
 =?us-ascii?Q?7HqRHN6F2WVmDhAgzU9RpUtYMWfNfApAhvEgnvuhgAMK0KD2JO7qIEKXSGdq?=
 =?us-ascii?Q?qucc1D+c/K0L8jqFRlYOdt/o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7f2bbe-a67f-4e51-1f39-08d8ce207ae4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 00:03:37.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOML5WnJf7tvSy9ZmE/9E41VOiOrFfuh/Vt7u9Vm4JRxwZzPyKHsJ7KN5KRweb5w5TuK/6TkyKpWg7T39hhZCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1341
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100209
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100209
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

hugetlb fault processing code would COW all write faults where the
pte was not writable.  Soft dirty will write protect ptes as part
of it's tracking mechanism.  The existing hugetlb_cow  code will do
the right thing for PRIVATE mappings as it checks map_count.  However,
for SHARED mappings it would actually allocate and install a COW page.
Modify the code to not call hugetlb_cow for SHARED mappings and just
update the pte.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 47f3123afd1a..b561b6867ec1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4584,8 +4584,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * spinlock. For private mappings, we also lookup the pagecache
 	 * page now as it is used to determine if a reservation has been
 	 * consumed.
+	 * Only non-shared mappings are sent to hugetlb_cow.
 	 */
-	if ((flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
+	if ((flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry) &&
+					!(vma->vm_flags & VM_SHARED)) {
 		if (vma_needs_reservation(h, vma, haddr) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
@@ -4593,9 +4595,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		if (!(vma->vm_flags & VM_MAYSHARE))
-			pagecache_page = hugetlbfs_pagecache_page(h,
-								vma, haddr);
+		pagecache_page = hugetlbfs_pagecache_page(h, vma, haddr);
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
@@ -4620,9 +4620,18 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & FAULT_FLAG_WRITE) {
 		if (!huge_pte_write(entry)) {
-			ret = hugetlb_cow(mm, vma, address, ptep,
-					  pagecache_page, ptl);
-			goto out_put_page;
+			if (!(vma->vm_flags & VM_SHARED)) {
+				ret = hugetlb_cow(mm, vma, address, ptep,
+						pagecache_page, ptl);
+				goto out_put_page;
+			}
+
+			/* write protected for soft dirty processing */
+			if ((vma->vm_flags & VM_WRITE) &&
+					(vma->vm_flags & VM_SHARED))
+				entry = huge_pte_mkwrite(entry);
+
+			entry = huge_pte_mkdirty(entry);
 		}
 		entry = huge_pte_mkdirty(entry);
 	}
-- 
2.29.2

