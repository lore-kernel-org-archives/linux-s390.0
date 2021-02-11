Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E589EC433DB
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EAF64E2E
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhBKAEt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:04:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhBKAEh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Feb 2021 19:04:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B00Wt8101389;
        Thu, 11 Feb 2021 00:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=b6uhz8t6mOEare+e+GqBSxU9tnKQVAFPSxxdOxPKIsI=;
 b=EhwJ8l2c7PWMaeToSVzq2gp361kQ0zey299RjVIMQsmJJIOUIqsS+hhx8X+Zi531ngBP
 QnWBrFDrc5kSk+RioskWe8diXvZA4IY4qBjqscyFMPpU6S7RYOZl3NxapmIlxh7LqxZi
 yvsa0k6T5dLXmOP8YJB+sqT/pSyDjISPf3D0OWjEQ1yGSocHoxGgA9wf9zYrzDodmM9D
 At7CWr9hVf1iEZmwWDPZngf4BMSzPjFCkMTXxPQQPk6RbkOYqNJA04izp56h4SQKmmB2
 /86Ml2hEp1vlFcIJFsFWjp/STgWIRhxr1PjlXiIE9lZxpuZdDf21W9j+R2Ebw1intwP4 9A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36m4upv2bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B01UV7063108;
        Thu, 11 Feb 2021 00:03:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3020.oracle.com with ESMTP id 36j513asg2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXTGsM+BUBaPwPMgQgPy39myphRKNEhPUrJZrjIkV9MEPGJNFhC6u5ezm1DKdDhyWYL3KuGkMgzsWpBuX7KQ7BcHtSwGArMaCGMODGVJx5wJLwB675Sc5HJQWjK1ww2XQhZXzGVYCyLhCBskgNP43qlCMQdL3FmM74V7BoUp4qI4e8758Xm/zha2a+BwH7BMU45Yc8fdlF2lih5tFVe13LOc5fYxwIsPz729vb5S/U1ff8BnvvQ56b2Y+yUQcLxo2fDbKpFFDOk3z+eHnEmtfKXlA4RqS38smCImT4Nixab5rPK4/ye/cOqBlRygTVLdK7SCLjTj8Sn4jmvthN0DjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6uhz8t6mOEare+e+GqBSxU9tnKQVAFPSxxdOxPKIsI=;
 b=badELTo3DwQLLVCVSlNig7nVXBgyWARhlPvOnc/gDAmAX+JNu76+i4MpeRZ5HSeSReIdnkd4h3CprN3sVpjZ8jWCRh9LwF6Dl90q4GuW5+dZIk9hCVTpsuNhRz68EH1aZzw4wbA3ILP0M79jkd6rAm5jtwBsSayODF+eOk3kBgkZJ3nWoJ4tI80fybl9GZgJUJhUwWvMv1XbsA0rr6i9169mZFm1jxBHuX5SMgNTwuZjRazdee1MSBgJ6cwTrnTdZMkJncFb7WJVeC2Orlmpczi9wAtzs6OkP+m0M43aKhXHZ7f73ENVpSbeCpVP9gBdsHq1rriSVoYi6advIvMHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6uhz8t6mOEare+e+GqBSxU9tnKQVAFPSxxdOxPKIsI=;
 b=F57cB+s8STO5xn8VcOlukT6hve2TiiZhSopvH92ibjA/L4P01dBE+MKKl7x4YnnjDczh2a0t06ti1rstncmn0X+adhJlTSDEnbsFmceKm5fIkRXglbEyXEvE2jEX5SeeE5dGGyxc1i+TwIiZpKoZV8v9sRVj6/GfpYb2hDdT2Bk=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1341.namprd10.prod.outlook.com (2603:10b6:300:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 11 Feb
 2021 00:03:40 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Thu, 11 Feb 2021
 00:03:40 +0000
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
Subject: [RFC PATCH 4/5] hugetlb: don't permit pmd sharing if soft dirty in use
Date:   Wed, 10 Feb 2021 16:03:21 -0800
Message-Id: <20210211000322.159437-5-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR01CA0032.prod.exchangelabs.com (2603:10b6:300:101::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 00:03:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36f53ff6-f073-41a3-56c0-08d8ce207cc3
X-MS-TrafficTypeDiagnostic: MWHPR10MB1341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB134190B3F1424F292CED477CE28C9@MWHPR10MB1341.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ksQx2B7qbn6kIB+HD5OxcDnHXMRnV66FB24g168VLFlucRy1ylhQTgE4iATT18TRGCVVeT3gi0aSP4YL541sLIOVrMlOPyaFpMy2lGi9HMnoyw/h4AgJnLpznqsij3NQHr/TLSDYRHIOKmTSRC2mvsAG3O9XTqaTsC32dD6CrLmj3CbYtPFt9mjPpvlTNd3ak8+7nMh95UpVb93U6sitimeOHKfRG3TDqmGMqaSiq7qPEX4W3UZGkAyY7/FaaUlzYAJLhi8H2XexedYfKZ/iRnObYWYlfYHaMY4CfvoN8iVl20lN8doyfcgSIS1XFpCPV/7MfaGoAWfdEYS3UrgY3qxkqxgks9WKyLaxKDpeSgs7jkHTx2NQoxjODCFmEn8T+MJJQxJiEKmFG9efsx33wat8KcL42SoiCRXFr66/LgJrj378Mw5loaPev2UqGRu4B/G0mwxut6dYyISXd5yzQilATPsCNpNhfe0yZeyLahHIw2DhPTfnBibDvDioyLCyOhqqK/f2j8w+azKccn5U+Z0sh/ZKZy2lj05GsdCl7BpZacuHsY/uYe6tD6a6HW+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(366004)(396003)(136003)(107886003)(4326008)(6666004)(2906002)(8676002)(44832011)(7416002)(66556008)(83380400001)(66476007)(54906003)(1076003)(2616005)(956004)(7696005)(5660300002)(26005)(478600001)(52116002)(86362001)(8936002)(6486002)(66946007)(316002)(186003)(16526019)(36756003)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jjem+YexpO/FALGLqGAW9Z7jnn46WQJQqrpOg3g24oEIo1zxRLQs5Ax79HrA?=
 =?us-ascii?Q?fawxZ5qhFyxWhpiCIvb5AUjVnzDKJIE04epxXVygJpjdAsKDbF+LkDBDX7jZ?=
 =?us-ascii?Q?whRYpUokE0phz2xBjoMRltCoq7GqUI1wJMXsZNEXBM1MOO4lv+FSEb+f0rxP?=
 =?us-ascii?Q?m/Fp2Ix3+WxNFaL5uv4T9m+3cFBzYDA1PeMZNJG7OI52ODecDpjba6CfzWo8?=
 =?us-ascii?Q?qtzucX7P7C4IVkclpRfWcoNZ732dGiF/PtA6aaPRwXYxWmQQeH5edIk6Zv9Q?=
 =?us-ascii?Q?yqbQgrb1d6CgfPQch0MNI67O1LXx8P/9DZ7QnIYuFxcccu7NAQVR/9mE/qoa?=
 =?us-ascii?Q?iZ9jOxYFusy8ustp2gotc6BYpOR21lhutZsNbAL8nBLWW1wz75FIBYcPCMI/?=
 =?us-ascii?Q?N6LvTACIzWl8i0xtfgnHa6qOyUR6QbqNGgdawhoynSBo1fkj+3bD/ZGIWQh5?=
 =?us-ascii?Q?AebGjiQDRe7j/5VS8YLCRp1Q4PclI+5KADydUvch8P6CWHGA/p6QCwAHhf2F?=
 =?us-ascii?Q?QNBpn8j2Nh+UACUQevyf54IVP6KEfNgp8gbcDFqZ6FFVyqzkZjv8F3oYVnVw?=
 =?us-ascii?Q?jFYCJbBWreG/RMnfnuMg5SJaEGx8gg4aiw64koM/+4NUjRWI3mOMGbHQYgic?=
 =?us-ascii?Q?Nq5rkmFMgWcSNOExaYeif1I+OalB4PvuKLmer0UDUDgy57iKDeGGRZWKYbUK?=
 =?us-ascii?Q?LffabyLfthrQfoNDTQT34l7iGR3gCmjefxqEUbu0GL9EG7qYKvBhxc+71HDo?=
 =?us-ascii?Q?e1ZR4Fj4qJVjyeJwOmsJePLoOYPPzoFRF/NpcJZ21tRVXSmGD0gd8qGxNUnB?=
 =?us-ascii?Q?DWKSNRdhaYYKIWIBPg7wI5REQnXYpJBa6Rn11fVMsL9jN9dYgsMhNc129Q+t?=
 =?us-ascii?Q?D57Zzv/d6YJsNnyUEztVlCahHYGJCaCgz8nl/EDx5Dtg80azU4yj1X91Gxg+?=
 =?us-ascii?Q?tHf9HYVdjBN+6zYfWVCx/AkFgaF5RjvYXjmIINp8U8khIaI+ynu/LOeK5Za0?=
 =?us-ascii?Q?VtzLcZdO+aWeHv0jHeTcWbqCAwRbI7DOsZreMD95jDEzW7dCSoECUDo4gIDO?=
 =?us-ascii?Q?X0ld6obdkHcZhIxcBhazHWAGtWEH93qDgTwsXJpqmxPEbdUnv5jFvilFM+5o?=
 =?us-ascii?Q?frsTmFUS/1mBCZhqvOJzItu91EsHzYUHXpHxyoksR1R+oUhcohqy4e23u7W4?=
 =?us-ascii?Q?dYkfJYwdKH0JBeFYpzMBQI508kr0PRCj0Hhpff84HSGrbryPmmT84BZ4431p?=
 =?us-ascii?Q?mmyG3llZv+1ArX3oc3mikdSu0PvZ4UcWwzAuo/WL+TPKUau9gjG7sLju/MqW?=
 =?us-ascii?Q?zGn7RXyMHdyc2cwJqRAAm2TA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f53ff6-f073-41a3-56c0-08d8ce207cc3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 00:03:40.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KP1EZdlXjsMyX4ld5C/DMXQmDIibMO23yvqqhBTznPVNOYUmJLx7aqFvaK71XA55kq6locs8QfgF/mxBqv2KFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1341
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100209
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100209
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

If page modifications are being monitoried with the soft dirty mechanism,
then this information is contained in page table entries.  Tracking is
enabled on a 'per-process' basis.  hugetlb pmd sharing allows processes
to share page table entries.  This makes pmd sharing incompatible with
soft dirty monitoring.  So, pmd sharing must be disabled if soft dirty
tracking is in use.

The VM_SOFTDIRTY flag is set in all vma's by default.  When soft dirty
monitoring is started, the flag is cleared.  We can therefore allow pmd
sharing in vmas with the VM_SOFTDIRTY flag set.  Check this when deciding
to perform pmd sharing.

A subsequent patch will add code to allow soft dirty monitoring for hugetlb
vmas.  Any existing pmd sharing will be undone at that time.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b561b6867ec1..cf4aa63be9b1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5285,6 +5285,13 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
 	unsigned long base = addr & PUD_MASK;
 	unsigned long end = base + PUD_SIZE;
 
+	/*
+	 * Do not allow pmd sharing if soft dirty tracking is in use.
+	 */
+	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) &&
+				!(vma->vm_flags & VM_SOFTDIRTY))
+		return false;
+
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-- 
2.29.2

