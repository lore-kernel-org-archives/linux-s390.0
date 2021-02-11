Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029A5C433DB
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D824E64E2A
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhBKAEu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:04:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50500 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhBKAEp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Feb 2021 19:04:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ANwanx049333;
        Thu, 11 Feb 2021 00:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=41m33m6pb/5tzcg1lV7rHhfzJFmmxyrpW6KDrRb/R8Y=;
 b=LSgWQMxuEr8Utti8NtxKQ0xae/uZfgPZHhBsEtvSNQf2fTkqou0GL3/hNsQd2mBlcKn+
 TzcJpa/e1K26ohAzT8K5npFWdewk1QOim8cuByCxecKg9B6sIgQ5jCl4z2cx87PtrJpP
 21aVdBfUtqQGD6ambDwSB9rP+zGgQ0H2b22PGSTTVRs56ugLWeWfgfqvn7iRRAVXLpe1
 CLC1MIv7b0ElCAn1EWRxfta76Q51WW6MvphcqT519pqaKvzhXCcUkHXa2jazNjSs3G/5
 i73kWkQn23u1h07HTQjn2gvYe4vD1Pzo7+tTGHnpJ0FGPwbw4uU2YvCoBW5rZwXSj1Qa Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36hjhqwhr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B01UV6063108;
        Thu, 11 Feb 2021 00:03:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3020.oracle.com with ESMTP id 36j513asg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRfGhzXxHZzlE9bWPkclEkkmJrdbrFOt4FApoQFaZYj7iMlRJ9UdlCLaLX8qyudDBRHHCMOlIAGEnMsvs6KNkPIsmEjz4g/8ULBdk2nnBAtjCgB8errwWrkj55I6MOI9+GWczTqsa221Yk4Tw9XF9bFzlAuHfh4rKnkuJKUXNufrwYdcqHfRIDP79wTaf+WUfgNTPoEc34Ok3EcjX6hPnkiRxURRpQvf/zkSI5dKxL4wdwhbUsTH5fn0fTAAQotM8AwHDI1xnwmRDCDk6yKqnFrUhdljaY/gNc5cgCFGYhxXtSaSud00oWe1th0zgjpQ7m8LKaGM/f2JoJzQUtlCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41m33m6pb/5tzcg1lV7rHhfzJFmmxyrpW6KDrRb/R8Y=;
 b=mORW2tFvwGU3ROpyuvvw2vvSEqZNu4RNNWpXvje0WV6Iay3tNeGvv7nVpRGoeb7jqrLUgP+Fl81DPEndOrjo4bp5U8+WgPAPncWYq1WZYRk0RebUNSHe86rXc6BKtkgFM8GSM158fJPsW1aWUn6nhkFgFGQ4JlR7mCG/uqtxH7EGZj/kIvhz4yZb0mR/0ydPmfBjGmuhKvgv/ftqnFxWiRXKx07eMYmZAVx58PE/lDEtSX63PePTwVbZkH4yXvOYGsxje4ip5GwmFqAE7m8vImi8KCTUU9bJqUYsMrBlb7/3bTnsceyd0bzb3kSmOcLZ81s4v97Jp0l+mEy17nl3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41m33m6pb/5tzcg1lV7rHhfzJFmmxyrpW6KDrRb/R8Y=;
 b=LMUSzjNLQvfOEhoXtpMcLeWgJVUf0u4urwz4wcuC93Tvny2k/UUIbGmdTQlZNWw52rpKZliHd7GDm0l1ogViA/98obZvPb0K5t54xQt+E3ZJzvvamin85yXv6wbPL8tvJPg+VmCYmDfpyr2gQyo/Ff3sAVes05hK1UlnEfSp1Ok=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1341.namprd10.prod.outlook.com (2603:10b6:300:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 11 Feb
 2021 00:03:38 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Thu, 11 Feb 2021
 00:03:38 +0000
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
Subject: [RFC PATCH 3/5] mm proc/task_mmu.c: add soft dirty pte checks for hugetlb
Date:   Wed, 10 Feb 2021 16:03:20 -0800
Message-Id: <20210211000322.159437-4-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR01CA0032.prod.exchangelabs.com (2603:10b6:300:101::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 00:03:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cee33d-11b8-4455-0043-08d8ce207bd8
X-MS-TrafficTypeDiagnostic: MWHPR10MB1341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1341E6D557CC558512E939CFE28C9@MWHPR10MB1341.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPuykCYzUl7j+djUECd2t7e2xAzfO5Zd5huSz88FrTC89EiqV9LMVfvqff4BI6T85dBlkYL16aq54zDWad8MWk1YxipuFddM5f4DXN4i7sCzyVpH8eMeNvifnHbHAVwlQE9AudDPhEqttsyDP15FQHNeMtF58Jl0L8clzOAE0DCRquw2y1/U816RJM4y4sYtiNdpyiwi5uxFQDuuQwFLr+2j/SlDRvQbaYs12y2h3Y899I2RCdcThdkMA/9hd9UZhu2dlwvQcRNk2tU1BXWvcKUrimOotBiUfdRfRcazDRhUTfs6a66Ck5Xk6MziqBaNAyslbFByZDhCsDUSGBK3t+KT/1l4esDDaWTFhMXE6VNS05AoYzaK30S34zLNzhAlbAsag/piW0XYKdg6mU3NFvOfi0EdqWOK3DgLwdy1YeeC6Rw2qED2pz0hN1xSiN4xNHwylqD0b1eK/JIopl0jcFmdbqPz6j6x98Rl1g3LVljQkN3q7U9P38SeK5Icf16cv8SoZ/Y/OWP5ZbzuOuuFuxBWe2ERXqSVMlby85cwTGos1nPCnEk0/IufvoCjXBmk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(366004)(396003)(136003)(107886003)(4326008)(6666004)(2906002)(8676002)(44832011)(7416002)(66556008)(66476007)(54906003)(1076003)(2616005)(956004)(7696005)(5660300002)(26005)(478600001)(52116002)(86362001)(8936002)(6486002)(66946007)(316002)(4744005)(186003)(16526019)(36756003)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?un5siEY7ATgDBVlI1LqymOBYogAp8COB9gqeODpkOLhLep0ydF38A4NIOWcZ?=
 =?us-ascii?Q?9jbCgSPGs7+hccr3LX88TApQ/72fE5Xs7DScjXVZ5b/Jusr80ZOfWHqIxzz7?=
 =?us-ascii?Q?biY/kWruJqk4tAfMhjX+tf4Ak9j0Rkc3UiJwWMvrbocf1mGFxZX7EhW1a40g?=
 =?us-ascii?Q?hjGOOBz1i6sEaEZ4G5RLOckeUfXzEs7UaQdMjf4vcBibRJ/Q/IFbzT3OHTLn?=
 =?us-ascii?Q?cVZiloCZjETkGtDCgsnDrJvoDjzy7+/l4fDO95ryXVGDkEic8+lsnm77833n?=
 =?us-ascii?Q?wXM7M5GELV7JA00rOlYgkwbEXW1RiP1CZXrFt/OWvo2iZG44BcazkRIIhSkK?=
 =?us-ascii?Q?SmFsR0NbnjhNp5tRN5mwZn3TgI9dD4yaBiYorOZg/WOjpDIob2GJm751EtFs?=
 =?us-ascii?Q?ZSj2RsX3LA8LKw9eTxnVkUSsQpGabueo1qDHEbb8qAkQlSQY2KCD2Zxc3MUA?=
 =?us-ascii?Q?DT4E+tsRnaxZjzchDjYaX1XyBqZv1wELiC1NgDIPQD170kil5gfu/As/ASZ4?=
 =?us-ascii?Q?0a2+BQ+aLmizy1T/ijDfhrZFyp4Ht+VWOgRdRNt10cHZN+UYekM1wxBXc3Qu?=
 =?us-ascii?Q?Pm6duDKnskcblZUGohl2SXC0VzWwx50N916eXvvBgB8scZPOGCSvLJ/9UaU+?=
 =?us-ascii?Q?B4+kuiDzLxy72lr9DR5Fjopy34KI04dljAXbgKoGft4laKUGo1zSP3MK0Rz0?=
 =?us-ascii?Q?EyMYVu/BLUwr7oQ2pubEV+YAgir8EeCIFQvD6iDc87jNkq1OywNXXJrMVN7w?=
 =?us-ascii?Q?TIXqFg0SuwCiuPxYbM/1xyDA7UjQm6xrffVej35dcMhNdoOzK6fHNzDl1nLm?=
 =?us-ascii?Q?ljRRSIcPCRk6Jn2Lic+6/v1t0ehYA5W5qaMUUExkN4WbVLjc6d7RYfZBq+94?=
 =?us-ascii?Q?4tbkn/TXBJlOV8z3BhdxAnb+nvWXPmjtLUKvhnQypULiVdQTCgOSutYXRst+?=
 =?us-ascii?Q?xswKQVSi2rAZ72XroJsD+A4l4jinPA8R/3k1SujtLvqnyaUXdhdcR5rqT74h?=
 =?us-ascii?Q?2FxrFEVF+jxCVWmyimnBvjmncTZO6uCDW2bLLlrfwRb45BjZadTQ2k3AXGvp?=
 =?us-ascii?Q?ijKqj8JAK9QaL5s+45LfboPC9CD3FNzrG7S1p+j+CilFyaSggcplX6LvDhoL?=
 =?us-ascii?Q?4d94bqkEH+fWa3bjr5touxKps9Bvd3WiIJXAxhBAZe08y1a4EVW3qMUrSbYO?=
 =?us-ascii?Q?aoQHrgOn+0Yt32/SI1xxVM3XjbhLeL+0CXDQ6+aYQZj3kHgvLsIWJWL0bb2r?=
 =?us-ascii?Q?Wz17uCRPamu1rD5ZM88oVvpeP2HBpSLF3bvRMscmYlUlzq+b/yIq2GcqfBTF?=
 =?us-ascii?Q?Hco6bcwq2gcx8LD0iXgNQKoE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cee33d-11b8-4455-0043-08d8ce207bd8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 00:03:38.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rNgNZ/Ff9agW0QNZFLCoREFojky8E2O/CFGwQsBEACvTxgCpasC1JxTEbUCHFhGbPoxqysX+n45OKEGMXk+JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1341
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100209
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100209
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Pagemap was only using the vma flag PM_SOFT_DIRTY for hugetlb vmas.
This is insufficient.  Check the individual pte entries.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/proc/task_mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 602e3a52884d..829b35016aaa 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1507,6 +1507,10 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 		flags |= PM_SOFT_DIRTY;
 
 	pte = huge_ptep_get(ptep);
+
+	if (huge_pte_soft_dirty(pte))
+		flags |= PM_SOFT_DIRTY;
+
 	if (pte_present(pte)) {
 		struct page *page = pte_page(pte);
 
-- 
2.29.2

