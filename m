Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1466C433DB
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855EA64E2E
	for <linux-s390@archiver.kernel.org>; Thu, 11 Feb 2021 00:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhBKAJe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:09:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57026 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhBKAJd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Feb 2021 19:09:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B008Hn123030;
        Thu, 11 Feb 2021 00:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=Bsctkq57JSaT40cpFveOgi9TJ3BanrKGCjZ8mgj40J0=;
 b=J9pxody6E5FccDKun2f4iSMl60d3pHusOrhwq3LM0iabJTvFk6B/bJ36ErrYEyH6lgtY
 ZNUk3tMgDSJWK1bj3sjYipJDQBVTc69mhL/r5zf1YTfQJuw2nRaM/M1raFXrDXJ9yyfz
 T46xXDEH37zQAM+Psii9Q65KyBdNMlgL8YdI/8f0rgpxueDpWFKxdnzisQioloQRoPNM
 8MtnqHmfaA6SWEX8ZMsXCYntcT8tINT2D4zU3EcQiz2PxOKLNZ4VorhN2o1FSCo+mUz1
 LCMyA5GOpeo+pbhVDGZXpLOyJyPhsgmp1dsoLCzRXi8yGurvdkUwFye5RBO4WkDySti9 Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36hkrn5fuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B001ZG158383;
        Thu, 11 Feb 2021 00:03:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3030.oracle.com with ESMTP id 36j4pqtpfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:03:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3DbQEmeDESqLzh+0LEEGxa/SnYHDNHakg1nsn9vp/I/kwdI0rvRGAuoW4bFCMl2sWyfN7+peyeFjpJw5vJ2YosswHYdQYdMhk6n5JIx0FWMWmP07ik/Ns+V51LfyOhvz6FTK+WkW4hzdkVZPA4GtOOFka9zakMnVJn4/PimIsan+6UzyZxmzFdj9cso+H1Ogcci51YbkG5ANlc0qTpD8B6U6q+3oVoVLXphckaOtUdQ5UEmVTyj70AClG1bZr/llfQkzK/LziG99gn8qRNdf0DA03maJ+OYDr6deGbNqHQCy3ckImkW0Mn14gtQnZXrFM4TgYb8X07L3w5L7oB4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsctkq57JSaT40cpFveOgi9TJ3BanrKGCjZ8mgj40J0=;
 b=ZTCwokDb5z/WLnEcib+jMOcHLhmpec07IvaBoqjoUMBQI9IQZe0v6b+GPgBZjFHdMVCRvcE44tjh0+QMbvYsSTonZ1E4tXVjLayYxNMHVKvYnMpPUBQ7BFiySjhK4hniEeNP3UcrHaTMz5U1b//tp4MOnyaDlaq6yhKnmrUBkyz8SqoG+FFFzM0xROZPrXQTUxiaFDa3d8keZQUYEDyay8LKFj1GGpNhn+9vqicp3+juCvQpmWMxBjBSksMSw68iyVznb3ZtlgBy3W37NOeWo6wI0LrmpfbmdY+DamyS7d5wAMjIbglwUiSothVyMsBV5q2gHFL8aVhLb7Wp2xt6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsctkq57JSaT40cpFveOgi9TJ3BanrKGCjZ8mgj40J0=;
 b=dwMosigWhKqW6gay/wxlNBuMZtFp9k7xFmxj9x9DIbZW0/sPW/Ft7+P9WGfrB4XDDkq+DfiuhxzJ2XBAdK/+i4BTYygoVnJMEbOlMVOuntPXHv3T05rAxwtL3H5UFCXSc5E7JAF+67tVvhKmGq8lQZQbQtgFHTHLhtcsZr4d0zw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1341.namprd10.prod.outlook.com (2603:10b6:300:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 11 Feb
 2021 00:03:32 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Thu, 11 Feb 2021
 00:03:32 +0000
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
Subject: [RFC PATCH 0/5] Add hugetlb soft dirty support
Date:   Wed, 10 Feb 2021 16:03:17 -0800
Message-Id: <20210211000322.159437-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR01CA0032.prod.exchangelabs.com (2603:10b6:300:101::18)
 To MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR01CA0032.prod.exchangelabs.com (2603:10b6:300:101::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 00:03:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fef043d0-fbc1-4e1c-e763-08d8ce207827
X-MS-TrafficTypeDiagnostic: MWHPR10MB1341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1341B0FC19A7A4373DC5EC2AE28C9@MWHPR10MB1341.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7VTX64i7BoTzrAwZ/FChqJzkxIwtthgGwHYZ+G5zjG0QX/QMkjVGptSYEpyn6sYY63rKkTLaLmmAIRHZPdRPzz5uVTNThYeMJiZ+VQA6uoWJLBYwliZdPBqZY7PLAgtYXF17cULPH312imb/kq5kwiN1u0vpufIHoB0ySktzzFUE/HhOfefaEb4wSwqTnnAiJcs6pk3ATksfLsaEQjL/gvzJRzjgLhAMsWy28BNcirfYCUqa+FoTf370y+Bm5YP1FY2HTy5dhM+Zbalirpynk6cFndBnHv/lKPo/txrSDsLiT/TQPi6/w7C9bIF7KPuIlVUy12wBAlCL48umxDhZ8p2ZgZxmtqJUlj5quIpT0vjqa5v74hiosYDvIF1B4ukKZOHD9odhTMmeHiF5nbyPIE8/WuX81J1uDxngG8yVCizbAnS9hItR+qBkoYvs3RvVubYhuw38rBltF/mMKcmSDM/n/ePkfUtQKWzlOvwSsQqio/sidm239Wo1UzqlaA/o7IMvPSU+0FhhzW4fOnAjK5YLzFX+V2/SxV/p8pI8NhH5Voa0Wxn9rgAnpsQN/phfqWGyDBmWXkK8OHy8goX2BI55QLQA/bzfleHvGMXAXExK/7kVivA9SxPeDWzIOd4xLNJZ7FeK6LN6lBX1jzZzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(366004)(396003)(136003)(107886003)(4326008)(6666004)(2906002)(8676002)(44832011)(7416002)(66556008)(83380400001)(66476007)(54906003)(1076003)(2616005)(956004)(7696005)(5660300002)(26005)(478600001)(52116002)(86362001)(8936002)(6486002)(66946007)(316002)(186003)(16526019)(966005)(36756003)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cXJ3VjlLL1NhZE5nYnNUSXM0V3I2alQ2ZGdJeUNBMTNyWjJyL3BENEFSc1B1?=
 =?utf-8?B?dm1EbzFvRG94bTJqeEtWeXlIT1FtRGJtRnFOcWR5Z05pdzBNNStPSzlHa1NE?=
 =?utf-8?B?NmJhdUVPb3dkS3hRRUVoMk0wanlVUnBtT3BlbG8rYU5SMVJTUEg5cTZvZTFO?=
 =?utf-8?B?K1JkVmRDRXI1a0J1cGgwYURPcHNvM3cwN1lXcWJNNVkycURnV0x0b0hLQWV6?=
 =?utf-8?B?WEhpZHpJeWV4bVlrVHdNb0JGdmZ1MXloYlpabEpmMExmbzgvZ1V0eEVYMWJn?=
 =?utf-8?B?OURaM1MvNjlOVXVPNHdwQ0xQcjBXdXllVG0yMmg2YzdGODVjeGhSNzIzeHds?=
 =?utf-8?B?QXQ2bEhxZlBSZzBzc0kvZlBpWGVoM2ZDa0gzejJmTVJsUm54MVNPSVk1V1Zu?=
 =?utf-8?B?UDdRdmw1UEN5T2FpcDY5aVorQmh6QStBc3h5VFZlY2tMWTA2cnFSZU9EU3Jt?=
 =?utf-8?B?U3VPUTFCQXk5TkQzc2dML3p5eDRkSXJhT0J4ajFDNjJ2a3doU2I3aFFRajdU?=
 =?utf-8?B?cmJBNEg1enFjYlM5ellWTXhXNTM2amxuT25CQnVaa1V5bFVkZUI0YStoeEI4?=
 =?utf-8?B?WkU2K2s4UXJPNnFWZUhzMC9kdDRVNitOY1VXMDBWSXlqQVViMHAySDY4L2Rl?=
 =?utf-8?B?UlpjZElKSkhQRk1jZjlCNmQ1a3ZoZy9kVWlUOHk5c2JXV2ZCL2pGdjhwMXE5?=
 =?utf-8?B?aDlIK3pheWRTTlI5UWRjNkJ6OGlpWDREVUFPREkyQTZEckhCU00xNjBHc2tx?=
 =?utf-8?B?K2RtYlIvZHFBN0x6Zm9VNWFRN2k2ZHRZaVJ2OFJXM2IrV3BMbXlVUjZFaG11?=
 =?utf-8?B?c0hLT0RVT2NuWEZTU3ZpWm5nZVJLZytmYWNSaDkxYUJiU0t0ZndLWjhGWFNm?=
 =?utf-8?B?WFFpVzFvNkN6UzJKQ2VpOU1aZHBBR3JaZmx4M25zZFlIUHI2VSs1VXdBcDZU?=
 =?utf-8?B?T2VDb1dveUFsUjZCb1ZvallJSXFlbGJ3bVYvUmVuVWp5dUFZVjlHdU5qUDRP?=
 =?utf-8?B?WGFOTFJiL01lNHZhcFdlOXJzeUxPWDk3M1ZuY0ZNOEthZkxQMmtQZkl2b0t1?=
 =?utf-8?B?THJTU1p3RHljWTR1WGpPRmlkMmlKRVhyS2RjN3NIUUU2QU83T0c2Qnhlc0t5?=
 =?utf-8?B?dkZDMHlBdHJJQUs2SmorV2tnZnJRN1Q0QndHc0dUU3lsYmdWK1hnK2tnR1lQ?=
 =?utf-8?B?WlBwTkJXK3JtVHMwQVFLcndIV0VUNktaZzNPaW1iYnBEUjMxa0tnS2k4M1Mx?=
 =?utf-8?B?MVdySkJuZWpLWkpNd1ludi9ublVoRCtQRjFST1B3N1I5T0c3aC9FNVl3Zm93?=
 =?utf-8?B?Yjl1RFFQdVhoVEc5WUZDeTl2VGRWUmpndGNWNXJ0eitZb09hdis5R2svZzUw?=
 =?utf-8?B?bFE3OHpnMFBTd255bWxUVHJJQ1l6WHlGL3pYNVAweitQUkFPYzRwWUdmZktp?=
 =?utf-8?B?Mk9qdjRGMDl4UlV2ZUFTS2xOclFFdkZwWUZ3Nmxwa25VWXFxK001SXNQZVdJ?=
 =?utf-8?B?MUxLZ1FKRkhvYmJzYWpGOGpKZjNFLy9SZTF5dlo0WEVIb0YxZnVuSGcya0dR?=
 =?utf-8?B?M0dHTTh4VWQwSCtwOGhORlJvcXB2c05YYTRpaVI3OHBZNHBqWkRaRlZqOXIy?=
 =?utf-8?B?L0twbmhuRG9VNWh3ZmJnV1prSFJiSS9KaEJ0d2pGS2JBR3ZuWC96RlpVbjQv?=
 =?utf-8?B?eW5QYjY3V3VLU2xObnJCTUtNV2ZqSnZIcndLMkNLNW9hcjlBRjBYVkFXdXZF?=
 =?utf-8?Q?mmURtsy7jOrt4GpQJbpTk4S66pHp4DwgEBxELGA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef043d0-fbc1-4e1c-e763-08d8ce207827
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 00:03:32.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vg4oZFoECFo+DFEMgfva9NbJwcEXr5w1m7hn5+IEB9ahkHhSGRhbEdExqg8Vx3mPxWy7GWo+2MU0F1DVy5kOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1341
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=572 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100209
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=752 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100209
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Shu Wang opened bugzilla 211287 [1] saying,
When a memory region is mapped with huge pages, the softdirty bit is set
only right after the huge pages is mapped. After the memory mapping, if
the softdirty bit is cleared and the memory is written again, the softdirty
bit is not set when reading from the process's pagemap.

Their use case for hugetlb soft dirty is,
We maps both PMEM and hugetlb DRAM to process’s address space to provide
large amount of memory to the application. Periodically, we clear the soft
dirty bit by writing ‘4’ to the clear_refs. Then, we check the page’s soft
dirty bit from pagemap and use this information to track write activity to
memory. We migrate the data between DRAM and PMEM based the write activity
for better performance.

A quick check of the code revealed,
The /proc clear_refs code handles THP pages and 'normal' pages.  There is
no check/processing for hugetlb pages.  All the code will do is clear the
VM_SOFTDIRTY vma flag and vma_set_page_prot.  None of the individual ptes
or page flags are touched.

The only soft dirty checking done by the /proc pagemap code is at the vma
level.  It checks the VM_SOFTDIRTY flag.   It does not look for soft dirty
on the individual ptes.

That explains the behavior described in the bugzilla report.

This series adds soft dirty support for hugetlb.  It has only passed
some very basic testing and likely needs more work.  However, Axel
Rasmussen's "userfaultfd: add minor fault handling" and Peter Xu's
"userfaultfd-wp: Support shmem and hugetlbfs" work touch the same areas
and have similiar issues.  Therefore, code is being sent earlier than
normal so that efforts in common areas can be coordinated.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=211287

Mike Kravetz (5):
  hugetlb: add hugetlb helpers for soft dirty support
  hugetlb: enhance hugetlb fault processing to support soft dirty
  mm proc/task_mmu.c: add soft dirty pte checks for hugetlb
  hugetlb: don't permit pmd sharing if soft dirty in use
  mm proc/task_mmu.c: add hugetlb specific routine for clear_refs

 arch/s390/include/asm/hugetlb.h |  30 +++++++++
 fs/proc/task_mmu.c              | 114 ++++++++++++++++++++++++++++++++
 include/asm-generic/hugetlb.h   |  30 +++++++++
 include/linux/hugetlb.h         |   1 +
 mm/hugetlb.c                    |  40 ++++++-----
 5 files changed, 199 insertions(+), 16 deletions(-)

-- 
2.29.2

