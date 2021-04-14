Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9A6C43460
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 02:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DC0610CB
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 02:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhDNCjd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Apr 2021 22:39:33 -0400
Received: from mail-eopbgr1310052.outbound.protection.outlook.com ([40.107.131.52]:35264
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346783AbhDNCj3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Apr 2021 22:39:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh2Vum7VzPbHJIn/rJkWpg9CuzFi/xzXS9kqKllhdfgS6zkGMewiFhLxbpM2oXMWC9Sy89mcvAD9XobePXeqEz4RZMy3Bk0TAeLL2Vn4R3bxSxmFvo7FGRiLD8i10Bvy65kHlSM7Ef99ekEckFBg67v2X4zYQB2f5CWJaooDDNeaNxjeOlMJtJjwkSR+TZS0rm3RTCrDVIgXKMPAVle5hoMFGq828XzaxPMrndvVP9BldJvNJo/6DrVT0mRxr1GsWqzp9tiNmtLjD52KQtaD7f65zeGbHcgo3KsDO3XfCHysPmZwvlnorL/oPPN+vSlAUgsB6MdxeAyM6vonD2SQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjMnYonZ1USZfZmij9epfJRaILoyZ9bPbRnGSZkHJzk=;
 b=SvSqGaxdO7QwP9EW/8PX0k6nH3dZ9ruAAqVke8IVVdLeZt2yI4tEC/s2dsK7HTODP5ccceCi8TPq7Dnqy+KSUobq0eR30sojIDPYibfoTXk8LK6hlObSO86QXfrSOejXXArqJVBTELhFy/AR6ZNK2/yy9riQ+rcLaFmc8rtFS4C1o1b9L/ayZFSkHXmp6dbM33NQN4z47g759wUDCsLM/S5PohBLhjJXjutg6uD+T2Tpo73hs/t3tbwatsfL67cPalJGucxbb67i5QNvUALGQo7jlbLeEk6lMX12QjpOpx7VVrszqbN2vGjohXimhWI7L4b+eziGByNszaD2HaYm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjMnYonZ1USZfZmij9epfJRaILoyZ9bPbRnGSZkHJzk=;
 b=DfffP33DbS9tL5lwz6Xxiz4GX7yP1Vt7vrvAjAzVJ1ajRFGHm1o2nR9YEk7OF9GzWr+oPz3TMggyYAm2t8NoizKHby7oHjk1x45iee2aOUv2e3icF5p4caL0RHkwPwv3QT8+BjlEFxE4/xmeN7+Z6z3LCfs6N4+/tpRzG4d7eN4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13) by TY2PR02MB3536.apcprd02.prod.outlook.com
 (2603:1096:404:61::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 02:39:03 +0000
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::e566:135b:f810:1f9d]) by TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::e566:135b:f810:1f9d%4]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 02:39:03 +0000
From:   lipeifeng@oppo.com
To:     peifengl55@gmail.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lipeifeng <lipeifeng@oppo.com>
Subject: [RFC] mm: support multi_freearea to the reduction of external fragmentation
Date:   Wed, 14 Apr 2021 10:38:03 +0800
Message-Id: <20210414023803.937-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.102]
X-ClientProxiedBy: HK2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:202:2e::16) To TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PA80248179.adc.com (58.255.79.102) by HK2PR06CA0004.apcprd06.prod.outlook.com (2603:1096:202:2e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 02:39:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f991da5-94c7-4322-92f2-08d8feee770e
X-MS-TrafficTypeDiagnostic: TY2PR02MB3536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <TY2PR02MB35362F40324FF74B8A527EC4C64E9@TY2PR02MB3536.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nI5ayHiX5M1bQfc446k5zTSP2vNNEBvH+RJAOZfVYp3iUALA8rtL4IaJQT9x+UcI5AhyvbqfVTi68JPYYtv3x/A6Gs+eh9UcfxxVVAJH8ZCKoYpEOEBlYd4kdxrtnCfXZLQFSZrBZbcZlioZPd2wvNLHNlSWd8PSJBVfQ0k4VM6FbFS02gYd3B/IeJKPDaHY8Gpa2K6+uOdO9rNhO2BdlYyTGib9+Gx7OKE0UIfAsMMiMN4zj/whCEi0jy1l7xv7LYnxD/8f0edLaAAuyNQgDyjedpSDR/l/mssZmZEo+CBqx4cOhokrJHbbB/F10wqFTMp4kGEaTg/oN+uY9eT5qXZKv5wuHNaOhnvWl5eEsdL5G+Jdro421YcuOcTatsTXA7n9bnl+B0QcyIS6czuVOr8YS23qyA6Y5hzCTNltl92kGNOzUib8q6BFMjo20zNCS/0TF8Zbbhp7uMLCwWbjJssp+wsfb64Ni9F7ElDzh0TzSw48+ENUbSR3hIB9s4TrhzSMQ+cvdvVVOy7+9CahN9W04x6Hg4kFH2P0Dp5ivl2pTzbTSbihunSsdUkXSBb/ayr4zNp5ULlobjKxW7/F1tXPbMbUDrpZZiWrXxUqHcr0Aai+is+i0H9fZPrq68lOtRw9VanPoCT6xgkQBhWdd3/y62MbqYq3tOZD/SvgG1uZsKu0gLW7cBf+0kHX7YD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4431.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(86362001)(316002)(38350700002)(38100700002)(6512007)(9686003)(8676002)(4326008)(8936002)(478600001)(1076003)(956004)(5660300002)(52116002)(36756003)(30864003)(26005)(66946007)(107886003)(16526019)(2906002)(66476007)(66556008)(6506007)(6486002)(83380400001)(2616005)(186003)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0Fh8x7s9zhXJu3R24CC4JMY9vm78Nw/ldZA3CLinzmVYN+798HFhkEwmrPq1?=
 =?us-ascii?Q?8GWhNeOmvQ4S7z7QqDi6bc6w6/UUiORQSKkYysHx4TWi3Q70jacLTQBCHmNA?=
 =?us-ascii?Q?dLSHDfK5UcO/oOERkQTRfpDWiPVFISaXQnXqxViuIFrdeRePBN9yiY6HiKYJ?=
 =?us-ascii?Q?PtxRzPy7NrYe12ZK/bZzSDZmm18HR5i4I/bLqwjL8KIgAHaIPN4ORSGGq8i3?=
 =?us-ascii?Q?/+eUBo6VCAL3ozVT0tqhSN5cy3wm1RwJw0wM6A6dLfXkL6q42IgiqBLiVTMf?=
 =?us-ascii?Q?CoDOmmugZr5Pw0lv/prBaDus76+TV6HV0PyRw4nPxqsYh5hgn1XNln33Mx19?=
 =?us-ascii?Q?hKQT9FYb2r5Ul1z/VTZzepannRI2RYGUWMEW/lcpGFFDPxDlBljD6Ju1Z3vw?=
 =?us-ascii?Q?CREUIDBhN5JGfI3h4QbLu1aS+4dM2JwG++TdWwbK7v3O7IROO5QdZwkZc9QN?=
 =?us-ascii?Q?b0kvzNhqlRzoaQZMvPbf5ebA2cjwIvSwHiTpplXqzarhvxV1d4w9Tynkl+dg?=
 =?us-ascii?Q?VP9CAk4AJpc255fJreoPH+Wg5OPaubhPkjbH5hcw1Z2JvnP4sFupz6U7/QWK?=
 =?us-ascii?Q?LcQqKJRp3lL3EyfSFBV6n2lHJICuMEXYaEQ6YqBGYuTKf0nqfHKVydizLGQh?=
 =?us-ascii?Q?Ip57t8GzliaMP4OSc1W3UOx+amYYDtykFh0QMUfOg6UdndZXYo+xUkNIS5zV?=
 =?us-ascii?Q?sA8jPuq5AqKTb1m4Jk1KB2Hgt8SP8uBuhLYwUBfvrVQbUdm0tVMSWWUhHwUJ?=
 =?us-ascii?Q?XmEYa/sI7p8k7Tq2+lvpA+oI6gsI0A8X75difthCkqRA4QxLCsC1orQfqFV3?=
 =?us-ascii?Q?Y96oDMZoK9k3cNMxl7HEEf9jQSHTNbYxrKJ1qhaL5rrtE/PeGMmev677yUUr?=
 =?us-ascii?Q?D9NP9EZbol6lrvuy0C1p6GwNiuAQJgaE4sAchEOmtKQ6K8/86PAIgebRygtM?=
 =?us-ascii?Q?29UKdW/MFAFUYkJcoXnNFcb6IUUGuF457zO2F8a46eZKAl0QWqRS+d7B5AWF?=
 =?us-ascii?Q?TX30XvHgtJb4vcefclNHa3j4Zd8AsPcLHs6oy0UuDcGlB4vd5jOMtZWuICwb?=
 =?us-ascii?Q?8/GWva8cIk2KRowWRoMIgMFVpYCf/b0Qo/reRF4y6RMY9AmaNcs7Ns0YQMlI?=
 =?us-ascii?Q?4R1slZ/D/+VfQfAq5wwmT/80W9OVUzGuX11wH/FjUvKMvDDokNPwhSkTutWs?=
 =?us-ascii?Q?cwSXjnhJxeDmOtqGxY2+7aWItTUztVK/zuC0/NMDY4dbxTr2DL3a6SkmHX9d?=
 =?us-ascii?Q?P9zWKxssX4uuf2x2J+jTaPhmMwZIhnOeMSTIO4znlbHfhG36E6uJ15ko1D6O?=
 =?us-ascii?Q?f/sQEgnopRFmcZR8T9BKTwZn?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f991da5-94c7-4322-92f2-08d8feee770e
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4431.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 02:39:02.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4Kd5SclleywJZxCZWJNW2P/m+h96+FdTspamNuEbCh5YqDSg7uO3uI0aGTSqqBxw0tzcW7ZZ78+JGoZcuYKgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB3536
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: lipeifeng <lipeifeng@oppo.com>

This patch would "sort" the free-pages in buddy by pages-PFN to concentrate
low-order-pages allocation in the front area of memory and high-order-pages
allcation on the contrary so that few memory-pollution in the back area of
memory and the probablity of high-order-pages allocation would be increased
significantly.
-----------------------------------------------------------------------

  1) Divide memory into several segments by pages-PFN
     "Multi_freearea" would divide memory into FREE_AREA_COUNTS segments
     by pages-PFN,each memory-segment corresponds to a free_area.

     Example: machine(4G of physical memery) and FREE_AREA_COUNTS(4):
        page-PFN:0x0     0x40000(1G)   0x80000(2G)  0xc0000(3G) 0xFFFFF(4G)
                 |------------|--------------|--------------|-------------|
        free_area:  [0][]           [1][]           [2][]        [3][]

     NOTE: Selecting the corresponding freearea when pages are freed back
	       to buddy:
        - pages-PFN[0, free_area_segment[0].max_pfn] -> free_area[0][]
        - pages-PFN[free_area_segment[flc - 1].max_pfn,
	            free_area_segment[flc].max_pfn] -> free_area[flc][]
                   (flc > 0)

     By this way, all pages in the same segment/free_area is within a
     certain range of pages-PFN.

  2) Select the corresponding freearea to alloc-pages
     "Multi_freearea" would select the corresponding free_area by the
     allocation-order when alloc-pages.
        - order <  HIGH_ORDER_TO_FLC:
	        free_area[0] -> ... -> free_area[FREE_AREA_COUNTS - 1]
        - order >= HIGH_ORDER_TO_FLC:
	        free_area[FREE_AREA_COUNTS - 1] -> ... -> free_area[0]

     Example:
        The machine(4G of physical memery) and FREE_AREA_COUNTS(4)
        and HIGH_ORDER_TO_FLC(3).
	If user allocs page(order = 0),it would take page from
	free_area[0][] first, if that fails,try free_area[1][] and so on.
	If user allocs page(order = 4),it would take page from
	free_area[3][] first, if that fails,try free_area[2][] and so on.

     By this way,low-order pages will be concentrated in the front area
     of memory.Because of few memory-pollution in the back area of memory,
     the sussessful probablity of high-order allocation would be improved.

  3) Adjust the location of free-pages in the free_list
     "Multi_freearea" would place free-pages in the head of free_list if
     pages-PFN is smaller than free_area_segment[flc]->median_pfn and in
     the tail of free_list on the contrary.

     Example:
        page-PFN:        free_area_segment[flc]->median_pfn
                                        |
        free_list: page->page->page->...|...page->page->page
        pages-PFN:|   < median_pfn      |  >= median_pfn    |

     Because it would take pages from the head of the freelist first in
     buddy system,the free-pages in the tail are more likely to keep in the
     buddy system.The closer the PFN of pages kept in buddy system, the
     greater the probablity of merging that into high-order pages.
--------------------------------------------------------------------------

We tested the patch on linux-4.4/linux-4.9/linux-4.14/linux-4.19 and the
results shows that the patch is effective in reducing COMPACTSTALL.

Example:the machine with 4 gigabytes of physical memery and in linux-4.19.
	- monkey for 12 hours.
	- record COMPACTSTALL after test.
	Test-result: reduced COMPACTSTALL by 95.6% with the patch.
	---------------------------------
                     |   COMPACTSTALL
        ---------------------------------
	   ori       |     2189
	---------------------------------
	optimization |      95
	---------------------------------

Note: it is a patch in linux-4.19 to consult experts:
Is it possible to merge the optimization approach to the baseline?
I would develop a formal patch based on the lastest linux if there
is a chance.

Thank you very much indeed for your help to check the patch.

Signed-off-by: lipeifeng <lipeifeng@oppo.com>
---
 arch/s390/mm/page-states.c |   7 +-
 include/linux/mmzone.h     |  48 +++++++++++-
 mm/Makefile                |   2 +-
 mm/compaction.c            |   6 +-
 mm/memory_hotplug.c        |   4 +
 mm/multi_freearea.c        | 177 +++++++++++++++++++++++++++++++++++++++++++++
 mm/multi_freearea.h        |  18 +++++
 mm/page_alloc.c            | 119 +++++++++++++++++++++---------
 mm/vmstat.c                |  21 +++++-
 9 files changed, 357 insertions(+), 45 deletions(-)
 create mode 100644 mm/multi_freearea.c
 create mode 100644 mm/multi_freearea.h

diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
index dc3cede..0865772 100644
--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -260,6 +260,7 @@ void arch_set_page_states(int make_stable)
 	struct list_head *l;
 	struct page *page;
 	struct zone *zone;
+	int flc = 0;
 
 	if (!cmma_flag)
 		return;
@@ -267,8 +268,10 @@ void arch_set_page_states(int make_stable)
 		drain_local_pages(NULL);
 	for_each_populated_zone(zone) {
 		spin_lock_irqsave(&zone->lock, flags);
+traversal_multi_freearea:
 		for_each_migratetype_order(order, t) {
-			list_for_each(l, &zone->free_area[order].free_list[t]) {
+			list_for_each(l,
+				&zone->free_area[flc][order].free_list[t]) {
 				page = list_entry(l, struct page, lru);
 				if (make_stable)
 					set_page_stable_dat(page, order);
@@ -276,6 +279,8 @@ void arch_set_page_states(int make_stable)
 					set_page_unused(page, order);
 			}
 		}
+		if (flc++ < FREE_AREA_COUNTS)
+			goto traversal_multi_freearea;
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fa02014..4c6ed49 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -29,6 +29,18 @@
 #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
 
 /*
+ * FREE_AREA_COUNTS means counts of free_area in per zone.
+ * Multi_freearea would divide memory into FREE_AREA_COUNTS segments by
+ * PFN and each memory-segment corresponds to a free_area.Buddy system
+ * would give pages first in the front free_area if Low-order page
+ * allocation and high-order page-allocation on the contrary.Low-order
+ * pages would be concentrated in the front area of memory which can
+ * reduce the memory-pollution in the back area of memory and increase
+ * the successful probablity of high-order memory-allocation.
+ */
+
+#define FREE_AREA_COUNTS 4
+/*
  * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deemed
  * costly to service.  That is between allocation orders which should
  * coalesce naturally under reasonable reclaim pressure and those which
@@ -98,6 +110,35 @@ struct free_area {
 	unsigned long		nr_free;
 };
 
+/*
+ * free_area_segment: record the max PFN and median PFN in freearea
+ * max_pfn: the max page-PFN in the free_area.
+ * median_pfn: the median page-PFN in the free_area.
+ *
+ * "Multi_freearea" would divide memory into several segments by comparing
+ * pages-PFN and free_area_segment.max_pfn,each memory-segment corresponds
+ * to a free_area.
+ *
+ * "Multi_freearea" would adjust the location of free-pages in free_list by
+ * comparing PFN and free_area_segment->median_pfn and selecting the
+ * corresponding freearea by comparing PFN and free_area_segment->max_pfn.
+ *
+ * Example: the machine with 4G of physical memery and FREE_AREA_COUNTS(4):
+ *	- free_area_segment[0].max_pfn = 0x40000(1G)
+ *	- free_area_segment[0].median_pfn = 0x20000(512M)
+ *	- free_area_segment[1].max_pfn = 0x80000(2G)
+ *	- free_area_segment[1].median_pfn = 0x60000(1.5G)
+ *	- free_area_segment[2].max_pfn = 0xc0000(3G)
+ *	- free_area_segment[2].median_pfn = 0xA0000(2.5G)
+ *	- free_area_segment[3].max_pfn = 0xFFFFF(4G)
+ *	- free_area_segment[3].median_pfn = 0xE0000(3.5G)
+ */
+
+struct free_area_segment {
+	unsigned long max_pfn;
+	unsigned long median_pfn;
+};
+
 struct pglist_data;
 
 /*
@@ -355,7 +396,6 @@ enum zone_type {
 };
 
 #ifndef __GENERATING_BOUNDS_H
-
 struct zone {
 	/* Read-mostly fields */
 
@@ -436,7 +476,6 @@ struct zone {
 	unsigned long		managed_pages;
 	unsigned long		spanned_pages;
 	unsigned long		present_pages;
-
 	const char		*name;
 
 #ifdef CONFIG_MEMORY_ISOLATION
@@ -458,8 +497,9 @@ struct zone {
 	/* Write-intensive fields used from the page allocator */
 	ZONE_PADDING(_pad1_)
 
-	/* free areas of different sizes */
-	struct free_area	free_area[MAX_ORDER];
+	/* free areas of different segment of memory and size */
+	struct free_area	free_area[FREE_AREA_COUNTS][MAX_ORDER];
+	struct free_area_segment	free_area_segment[FREE_AREA_COUNTS];
 
 	/* zone flags, see below */
 	unsigned long		flags;
diff --git a/mm/Makefile b/mm/Makefile
index 26ef77a..b70ed15 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -39,7 +39,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o mmu_context.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o $(mmu-y)
+			   debug.o multi_freearea.o $(mmu-y)
 
 obj-y += init-mm.o
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 5079ddb..57b6b74 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1314,6 +1314,7 @@ static enum compact_result __compact_finished(struct zone *zone,
 {
 	unsigned int order;
 	const int migratetype = cc->migratetype;
+	int flc = 0;
 
 	if (cc->contended || fatal_signal_pending(current))
 		return COMPACT_CONTENDED;
@@ -1353,8 +1354,9 @@ static enum compact_result __compact_finished(struct zone *zone,
 	}
 
 	/* Direct compactor: Is a suitable page free? */
+traversal_multi_freearea:
 	for (order = cc->order; order < MAX_ORDER; order++) {
-		struct free_area *area = &zone->free_area[order];
+		struct free_area *area = &zone->free_area[flc][order];
 		bool can_steal;
 
 		/* Job done if page is free of the right migratetype */
@@ -1396,6 +1398,8 @@ static enum compact_result __compact_finished(struct zone *zone,
 			return COMPACT_CONTINUE;
 		}
 	}
+	if (flc++ < FREE_AREA_COUNTS)
+		goto traversal_multi_freearea;
 
 	return COMPACT_NO_SUITABLE_PAGE;
 }
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e60e281..4cfeb66 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -41,6 +41,7 @@
 
 #include "internal.h"
 
+#include "multi_freearea.h"
 /*
  * online_page_callback contains pointer to current page onlining function.
  * Initially it is generic_online_page(). If it is required it could be
@@ -391,6 +392,7 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 			zone->spanned_pages = pfn - zone_start_pfn + 1;
 	}
 
+	adjust_freearea_segment(zone);
 	/*
 	 * The section is not biggest or smallest mem_section in the zone, it
 	 * only creates a hole in the zone. So in this case, we need not
@@ -417,6 +419,7 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 	/* The zone has no valid section */
 	zone->zone_start_pfn = 0;
 	zone->spanned_pages = 0;
+	adjust_freearea_segment(zone);
 	zone_span_writeunlock(zone);
 }
 
@@ -693,6 +696,7 @@ static void __meminit resize_zone_range(struct zone *zone, unsigned long start_p
 		zone->zone_start_pfn = start_pfn;
 
 	zone->spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - zone->zone_start_pfn;
+	adjust_freearea_segment(zone);
 }
 
 static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned long start_pfn,
diff --git a/mm/multi_freearea.c b/mm/multi_freearea.c
new file mode 100644
index 0000000..e442bfe
--- /dev/null
+++ b/mm/multi_freearea.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-1.0-only
+/*
+ * Copyright (C) 2018-2020 Oplus. All rights reserved.
+ * Written by Peifeng Li (peifengl55@gmail.com)
+ */
+
+#include "internal.h"
+#include "multi_freearea.h"
+
+/**
+ * list_sort_add - add free pages in buddy.
+ * @page: pages to put back to buddy
+ * @zone: zone that free pages belong to
+ * @order: the order of free pages
+ * @mt: the migrate type of free pages
+ *
+ * 1) Select the corresponding freearea to alloc-pages
+ *	"Multi_freearea" would select the corresponding free_area by the
+ *	allocation-order.
+ *		- order <  HIGH_ORDER_TO_FLC: free_area[0] -> ... ->
+ *				free_area[FREE_AREA_COUNTS - 1]
+ *		- order >= HIGH_ORDER_TO_FLC: free_area[FREE_AREA_COUNTS - 1]
+ *				-> ... -> free_area[0]
+ *
+ *	Example:
+ *		The machine with 4G of physical memery and FREE_AREA_COUNTS(4)
+ *		and HIGH_ORDER_TO_FLC(3).
+ *		If user allocs page(order < 3),it would take page from
+ *		free_area[0][] first and if that fails,try free_area[1][] and
+ *		so on.
+ *		if user allocs page(order >= 3),it would take page form
+ *		free_area[3][] first and if that fails,try free_area[2][] and
+ *		so on.
+ *
+ *	By this way,low-order pages will be concentrated in the front area of
+ *	memory.Because of few memory-pollution in the back area of memory,the
+ *	sussessful probablity of high-order allocation would be improved.
+ *
+ * 2) Adjust the location of free_pages in free_list
+ *	"Multi_freearea" would place pages in the head of free_list if page-PFN
+ *	is smaller than free_area_segment->median_pfn and in the tail of
+ *	free_list on the contrary.
+ *
+ *	Free_list "sort" by free_area_segment->median_pfn:
+ *		page-PFN:	free_area_segment->median_pfn
+ *						|
+ *		free_list: page - page - page ..|...- page - page - page
+ *			| pages-PFN < median_pfn| pages-PFN >= median_pfn |
+ *
+ *	Because it would take pages from the head first in buddy system, the
+ *	free-pages in the tail are more likely to keep in the buddy system.
+ *	The closer the PFN of pages kept in buddy system, the greater the
+ *	probablity of merging that into high-order pages.
+ */
+
+void list_sort_add(struct page *page, struct zone *zone,
+				unsigned int order, int mt)
+{
+	struct list_head *list = &(zone->free_area[0][order].free_list[mt]);
+	unsigned long pfn = 0, segment = 0;
+	int i = 0, max_flc = FREE_AREA_COUNTS;
+
+	pfn = page_to_pfn(page);
+
+	if (unlikely(pfn > zone->free_area_segment[max_flc - 1].max_pfn)) {
+		list = &(zone->free_area[max_flc - 1][order].free_list[mt]);
+		segment = zone->free_area_segment[max_flc - 1].median_pfn;
+		goto add_page;
+	}
+
+	for (i = 0; i < max_flc; i++) {
+		if (pfn <= zone->free_area_segment[i].max_pfn) {
+			list = &(zone->free_area[i][order].free_list[mt]);
+			segment = zone->free_area_segment[i].median_pfn;
+			break;
+		}
+	}
+
+add_page:
+	if (pfn >= segment)
+		list_add_tail(&page->lru, list);
+	else
+		list_add(&page->lru, list);
+}
+
+/**
+ * page_to_flc - find the flc of free_area the page belongs to.
+ * @page: page belone free_area[flc][]
+ *
+ * Return: the flc of freearea that page belongs to.
+ */
+
+int page_to_flc(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	unsigned long pfn = page_to_pfn(page);
+	int flc = 0, max_flc = FREE_AREA_COUNTS;
+
+	if (unlikely(pfn > zone->free_area_segment[max_flc - 1].max_pfn))
+		return FREE_AREA_COUNTS - 1;
+
+	for (flc = 0; flc < FREE_AREA_COUNTS; flc++) {
+		if (pfn <= zone->free_area_segment[flc].max_pfn)
+			return flc;
+	}
+
+	return flc;
+}
+
+/**
+ * adjust_freearea_segment - adjust the max page-PFN and the median page-PFN
+ * in free_area.
+ * @zone: the zone that free_area belongs to.
+ *
+ * "Multi_freearea" would divide memory into several segments by comparing
+ * pages-PFN and free_area_segment.max_pfn,each memory-segment corresponds
+ * to a free_area.
+ *
+ * Example: the machine with 4G of physical memery and FREE_AREA_COUNTS(4):
+ *	- free_area_segment[0].max_pfn = 0x40000(1G)
+ *	- free_area_segment[0].median_pfn = 0x20000(512M)
+ *	- free_area_segment[1].max_pfn = 0x80000(2G)
+ *	- free_area_segment[1].median_pfn = 0x60000(1.5G)
+ *	- free_area_segment[2].max_pfn = 0xc0000(3G)
+ *	- free_area_segment[2].median_pfn = 0xA0000(2.5G)
+ *	- free_area_segment[3].max_pfn = 0xFFFFF(4G)
+ *	- free_area_segment[3].median_pfn = 0xE0000(3.5G)
+ *
+ * "Multi_freearea" would adjust the location of free-pages in free_list by
+ * comparing PFN and free_area_segment->median_pfn, select the one freearea
+ * to place free pages by comparing PFN and free_area_segment->max_pfn.
+ */
+
+void adjust_freearea_segment(struct zone *zone)
+{
+	int i, max_flc = FREE_AREA_COUNTS;
+	unsigned long prev_base;
+
+	for (i = 0; i < max_flc; i++) {
+		zone->free_area_segment[i].max_pfn = zone->zone_start_pfn +
+			zone->spanned_pages * (i + 1) / max_flc;
+	}
+
+	for (i = 0; i < max_flc; i++) {
+		if (i == 0)
+			prev_base = zone->zone_start_pfn;
+		else
+			prev_base = zone->free_area_segment[i - 1].max_pfn;
+
+		zone->free_area_segment[i].median_pfn = prev_base +
+			((zone->free_area_segment[i].max_pfn - prev_base) >> 1);
+	}
+}
+
+/**
+ * adjust_flc - select which free_area to alloc-pages.
+ * @current_flc: the flc of current free_area
+ * @order: allocation order
+ *
+ * allocation-order >= HIGH_ORDER_TO_FLC:
+ *	free_area[FREE_AREA_COUNTS - 1] -> free_area[0]
+ * allocation-order <  HIGH_ORDER_TO_FLC:
+ *	free_area[0] -> free_area[FREE_AREA_COUNTS - 1]
+ *
+ * Return: the flc adjusted by alloc order.
+ */
+
+unsigned int adjust_flc(unsigned int current_flc, unsigned int order)
+{
+	/* when alloc_order >= HIGH_ORDER_TO_FLC,
+	 * we like to alloc in free_area: 4->3->2->1
+	 */
+	if (order >= HIGH_ORDER_TO_FLC)
+		return (FREE_AREA_COUNTS - 1 - current_flc);
+
+	return current_flc;
+}
diff --git a/mm/multi_freearea.h b/mm/multi_freearea.h
new file mode 100644
index 0000000..8043aad
--- /dev/null
+++ b/mm/multi_freearea.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2018-2020 Oplus. All rights reserved.
+ * Written by Peifeng Li (peifengl55@gmail.com)
+ */
+
+#ifndef __MULTI_FREEAREA_H__
+#define __MULTI_FREEAREA_H__
+
+#define HIGH_ORDER_TO_FLC 3
+
+extern void list_sort_add(struct page *page, struct zone *zone,
+				unsigned int order, int mt);
+extern int page_to_flc(struct page *page);
+extern void adjust_freearea_segment(struct zone *zone);
+extern unsigned int adjust_flc(unsigned int current_flc, unsigned int order);
+
+#endif //__MULTI_FREEAREA_H__
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4446a52..8e23400 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -72,6 +72,7 @@
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
 #include "internal.h"
+#include "multi_freearea.h"
 
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
@@ -132,6 +133,7 @@ unsigned long totalcma_pages __read_mostly;
 int percpu_pagelist_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
+
 /*
  * A cached value of the page's pageblock's migratetype, used when the page is
  * put on a pcplist. Used to avoid the pageblock migratetype lookup when
@@ -806,6 +808,7 @@ static inline void __free_one_page(struct page *page,
 	unsigned long uninitialized_var(buddy_pfn);
 	struct page *buddy;
 	unsigned int max_order;
+	unsigned int flc;
 
 	max_order = min_t(unsigned int, MAX_ORDER, pageblock_order + 1);
 
@@ -836,7 +839,8 @@ static inline void __free_one_page(struct page *page,
 			clear_page_guard(zone, buddy, order, migratetype);
 		} else {
 			list_del(&buddy->lru);
-			zone->free_area[order].nr_free--;
+			flc = page_to_flc(buddy);
+			zone->free_area[flc][order].nr_free--;
 			rmv_page_order(buddy);
 		}
 		combined_pfn = buddy_pfn & pfn;
@@ -888,15 +892,16 @@ static inline void __free_one_page(struct page *page,
 		higher_buddy = higher_page + (buddy_pfn - combined_pfn);
 		if (pfn_valid_within(buddy_pfn) &&
 		    page_is_buddy(higher_page, higher_buddy, order + 1)) {
+			flc = page_to_flc(page);
 			list_add_tail(&page->lru,
-				&zone->free_area[order].free_list[migratetype]);
+			   &zone->free_area[flc][order].free_list[migratetype]);
 			goto out;
 		}
 	}
-
-	list_add(&page->lru, &zone->free_area[order].free_list[migratetype]);
+	list_sort_add(page, zone, order, migratetype);
 out:
-	zone->free_area[order].nr_free++;
+	flc = page_to_flc(page);
+	zone->free_area[flc][order].nr_free++;
 }
 
 /*
@@ -1820,6 +1825,7 @@ static inline void expand(struct zone *zone, struct page *page,
 	int migratetype)
 {
 	unsigned long size = 1 << high;
+	unsigned int flc = 0;
 
 	while (high > low) {
 		area--;
@@ -1835,9 +1841,9 @@ static inline void expand(struct zone *zone, struct page *page,
 		 */
 		if (set_page_guard(zone, &page[size], high, migratetype))
 			continue;
-
-		list_add(&page[size].lru, &area->free_list[migratetype]);
-		area->nr_free++;
+		list_sort_add(&page[size], zone, high, migratetype);
+		flc = page_to_flc(&page[size]);
+		zone->free_area[flc][high].nr_free++;
 		set_page_order(&page[size], high);
 	}
 }
@@ -1974,22 +1980,27 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 	unsigned int current_order;
 	struct free_area *area;
 	struct page *page;
+	unsigned int flc = 0, flc_tmp = 0, flc_last = 0;
 
 	/* Find a page of the appropriate size in the preferred list */
+traversal_multi_freearea:
+	flc_tmp = adjust_flc(flc, order);
 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = &(zone->free_area[current_order]);
+		area = &(zone->free_area[flc_tmp][current_order]);
 		page = list_first_entry_or_null(&area->free_list[migratetype],
 							struct page, lru);
 		if (!page)
 			continue;
 		list_del(&page->lru);
 		rmv_page_order(page);
-		area->nr_free--;
+		flc_last = page_to_flc(page);
+		zone->free_area[flc_last][current_order].nr_free--;
 		expand(zone, page, order, current_order, area, migratetype);
 		set_pcppage_migratetype(page, migratetype);
 		return page;
 	}
-
+	if (flc++ < FREE_AREA_COUNTS)
+		goto traversal_multi_freearea;
 	return NULL;
 }
 
@@ -2074,8 +2085,8 @@ static int move_freepages(struct zone *zone,
 		}
 
 		order = page_order(page);
-		list_move(&page->lru,
-			  &zone->free_area[order].free_list[migratetype]);
+		__list_del_entry(&page->lru);
+		list_sort_add(page, zone, order, migratetype);
 		page += 1 << order;
 		pages_moved += 1 << order;
 	}
@@ -2161,7 +2172,6 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 					int start_type, bool whole_block)
 {
 	unsigned int current_order = page_order(page);
-	struct free_area *area;
 	int free_pages, movable_pages, alike_pages;
 	int old_block_type;
 
@@ -2223,8 +2233,8 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	return;
 
 single_page:
-	area = &zone->free_area[current_order];
-	list_move(&page->lru, &area->free_list[start_type]);
+	__list_del_entry(&page->lru);
+	list_sort_add(page, zone, current_order, start_type);
 }
 
 /*
@@ -2320,6 +2330,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 	struct page *page;
 	int order;
 	bool ret;
+	int flc = 0;
 
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->high_zoneidx,
 								ac->nodemask) {
@@ -2332,8 +2343,9 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			continue;
 
 		spin_lock_irqsave(&zone->lock, flags);
+traversal_multi_freearea:
 		for (order = 0; order < MAX_ORDER; order++) {
-			struct free_area *area = &(zone->free_area[order]);
+			struct free_area *area = &(zone->free_area[flc][order]);
 
 			page = list_first_entry_or_null(
 					&area->free_list[MIGRATE_HIGHATOMIC],
@@ -2378,6 +2390,8 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 				return ret;
 			}
 		}
+		if (flc++ < FREE_AREA_COUNTS)
+			goto traversal_multi_freearea;
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -2402,15 +2416,18 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype)
 	struct page *page;
 	int fallback_mt;
 	bool can_steal;
+	unsigned int flc = 0, flc_tmp = 0;
 
 	/*
 	 * Find the largest available free page in the other list. This roughly
 	 * approximates finding the pageblock with the most free pages, which
 	 * would be too costly to do exactly.
 	 */
+find_traversal_multi_freearea:
+	flc_tmp = adjust_flc(flc, order);
 	for (current_order = MAX_ORDER - 1; current_order >= order;
 				--current_order) {
-		area = &(zone->free_area[current_order]);
+		area = &(zone->free_area[flc_tmp][current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
 				start_migratetype, false, &can_steal);
 		if (fallback_mt == -1)
@@ -2430,18 +2447,24 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype)
 
 		goto do_steal;
 	}
-
+	if (flc++ < FREE_AREA_COUNTS)
+		goto find_traversal_multi_freearea;
 	return false;
 
 find_smallest:
+	flc = 0;
+steal_traversal_multi_freearea:
+	flc_tmp = adjust_flc(flc, order);
 	for (current_order = order; current_order < MAX_ORDER;
 							current_order++) {
-		area = &(zone->free_area[current_order]);
+		area = &(zone->free_area[flc_tmp][current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
 				start_migratetype, false, &can_steal);
 		if (fallback_mt != -1)
-			break;
+			do_steal;
 	}
+	if (flc++ < FREE_AREA_COUNTS)
+		goto steal_traversal_multi_freearea;
 
 	/*
 	 * This should not happen - we already found a suitable fallback
@@ -2714,6 +2737,7 @@ void mark_free_pages(struct zone *zone)
 	unsigned long flags;
 	unsigned int order, t;
 	struct page *page;
+	unsigned int flc = 0;
 
 	if (zone_is_empty(zone))
 		return;
@@ -2737,9 +2761,10 @@ void mark_free_pages(struct zone *zone)
 				swsusp_unset_page_free(page);
 		}
 
+traversal_multi_freearea:
 	for_each_migratetype_order(order, t) {
 		list_for_each_entry(page,
-				&zone->free_area[order].free_list[t], lru) {
+			&zone->free_area[flc][order].free_list[t], lru) {
 			unsigned long i;
 
 			pfn = page_to_pfn(page);
@@ -2752,6 +2777,8 @@ void mark_free_pages(struct zone *zone)
 			}
 		}
 	}
+	if (flc++ < FREE_AREA_COUNTS)
+		goto traversal_multi_freearea;
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 #endif /* CONFIG_PM */
@@ -2881,6 +2908,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
 	unsigned long watermark;
 	struct zone *zone;
 	int mt;
+	unsigned int flc;
 
 	BUG_ON(!PageBuddy(page));
 
@@ -2903,7 +2931,9 @@ int __isolate_free_page(struct page *page, unsigned int order)
 
 	/* Remove page from free list */
 	list_del(&page->lru);
-	zone->free_area[order].nr_free--;
+	flc = page_to_flc(page);
+	zone->free_area[flc][order].nr_free--;
+
 	rmv_page_order(page);
 
 	/*
@@ -3143,6 +3173,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 	long min = mark;
 	int o;
 	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
+	int flc = 0;
 
 	/* free_pages may go negative - that's OK */
 	free_pages -= (1 << order) - 1;
@@ -3190,8 +3221,9 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 		return true;
 
 	/* For a high-order request, check at least one suitable page is free */
+traversal_multi_freearea:
 	for (o = order; o < MAX_ORDER; o++) {
-		struct free_area *area = &z->free_area[o];
+		struct free_area *area = &z->free_area[flc][o];
 		int mt;
 
 		if (!area->nr_free)
@@ -3212,6 +3244,8 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			!list_empty(&area->free_list[MIGRATE_HIGHATOMIC]))
 			return true;
 	}
+	if (flc++ < FREE_AREA_COUNTS)
+		goto traversal_multi_freearea;
 	return false;
 }
 
@@ -4887,6 +4921,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 	int cpu;
 	struct zone *zone;
 	pg_data_t *pgdat;
+	int flc = 0;
 
 	for_each_populated_zone(zone) {
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
@@ -5032,7 +5067,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 
 	for_each_populated_zone(zone) {
 		unsigned int order;
-		unsigned long nr[MAX_ORDER], flags, total = 0;
+		unsigned long nr[FREE_AREA_COUNTS][MAX_ORDER], flags, total = 0;
 		unsigned char types[MAX_ORDER];
 
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
@@ -5041,12 +5076,13 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		printk(KERN_CONT "%s: ", zone->name);
 
 		spin_lock_irqsave(&zone->lock, flags);
+nr_traversal_multi_freearea:
 		for (order = 0; order < MAX_ORDER; order++) {
-			struct free_area *area = &zone->free_area[order];
+			struct free_area *area = &zone->free_area[flc][order];
 			int type;
 
-			nr[order] = area->nr_free;
-			total += nr[order] << order;
+			nr[flc][order] = area->nr_free;
+			total += nr[flc][order] << order;
 
 			types[order] = 0;
 			for (type = 0; type < MIGRATE_TYPES; type++) {
@@ -5054,13 +5090,20 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 					types[order] |= 1 << type;
 			}
 		}
+		if (flc++ < FREE_AREA_COUNTS)
+			goto nr_traversal_multi_freearea;
 		spin_unlock_irqrestore(&zone->lock, flags);
+
+		flc = 0;
+printk_traversal_multi_freearea:
 		for (order = 0; order < MAX_ORDER; order++) {
 			printk(KERN_CONT "%lu*%lukB ",
-			       nr[order], K(1UL) << order);
-			if (nr[order])
+			       nr[flc][order], K(1UL) << order);
+			if (nr[flc][order])
 				show_migration_types(types[order]);
 		}
+		if (flc++ < FREE_AREA_COUNTS)
+			goto printk_traversal_multi_freearea;
 		printk(KERN_CONT "= %lukB\n", K(total));
 	}
 
@@ -5576,9 +5619,14 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 static void __meminit zone_init_free_lists(struct zone *zone)
 {
 	unsigned int order, t;
-	for_each_migratetype_order(order, t) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
-		zone->free_area[order].nr_free = 0;
+	int flc;
+
+	for (flc = 0; flc < FREE_AREA_COUNTS; flc++) {
+		for_each_migratetype_order(order, t) {
+			INIT_LIST_HEAD(
+				&zone->free_area[flc][order].free_list[t]);
+			zone->free_area[flc][order].nr_free = 0;
+		}
 	}
 }
 
@@ -6365,6 +6413,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		set_pageblock_order();
 		setup_usemap(pgdat, zone, zone_start_pfn, size);
 		init_currently_empty_zone(zone, zone_start_pfn, size);
+		adjust_freearea_segment(zone);
 		memmap_init(size, nid, j, zone_start_pfn);
 	}
 }
@@ -8102,6 +8151,7 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 	unsigned int order, i;
 	unsigned long pfn;
 	unsigned long flags;
+	unsigned int flc;
 	/* find the first valid pfn */
 	for (pfn = start_pfn; pfn < end_pfn; pfn++)
 		if (pfn_valid(pfn))
@@ -8137,7 +8187,8 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 #endif
 		list_del(&page->lru);
 		rmv_page_order(page);
-		zone->free_area[order].nr_free--;
+		flc = page_to_flc(page);
+		zone->free_area[flc][order].nr_free--;
 		for (i = 0; i < (1 << order); i++)
 			SetPageReserved((page+i));
 		pfn += (1 << order);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index ce81b0a..68d280a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -30,6 +30,8 @@
 
 #include "internal.h"
 
+#include "multi_freearea.h"
+
 #define NUMA_STATS_THRESHOLD (U16_MAX - 2)
 
 #ifdef CONFIG_NUMA
@@ -1021,16 +1023,18 @@ static void fill_contig_page_info(struct zone *zone,
 				struct contig_page_info *info)
 {
 	unsigned int order;
+	int flc = 0;
 
 	info->free_pages = 0;
 	info->free_blocks_total = 0;
 	info->free_blocks_suitable = 0;
 
+traversal_multi_freearea:
 	for (order = 0; order < MAX_ORDER; order++) {
 		unsigned long blocks;
 
 		/* Count number of free blocks */
-		blocks = zone->free_area[order].nr_free;
+		blocks = zone->free_area[flc][order].nr_free;
 		info->free_blocks_total += blocks;
 
 		/* Count free base pages */
@@ -1041,6 +1045,8 @@ static void fill_contig_page_info(struct zone *zone,
 			info->free_blocks_suitable += blocks <<
 						(order - suitable_order);
 	}
+	if (flc++ < FREE_AREA_COUNTS)
+		goto traversal_multi_freearea;
 }
 
 /*
@@ -1347,10 +1353,13 @@ static void frag_show_print(struct seq_file *m, pg_data_t *pgdat,
 						struct zone *zone)
 {
 	int order;
+	int flc = 0;
 
 	seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
-	for (order = 0; order < MAX_ORDER; ++order)
-		seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
+	for (flc = 0; flc < FREE_AREA_COUNTS; flc++)
+		for (order = 0; order < MAX_ORDER; ++order)
+			seq_printf(m, "%6lu ",
+				zone->free_area[flc][order].nr_free);
 	seq_putc(m, '\n');
 }
 
@@ -1368,7 +1377,9 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 					pg_data_t *pgdat, struct zone *zone)
 {
 	int order, mtype;
+	int flc = 0;
 
+traversal_multi_freearea:
 	for (mtype = 0; mtype < MIGRATE_TYPES; mtype++) {
 		seq_printf(m, "Node %4d, zone %8s, type %12s ",
 					pgdat->node_id,
@@ -1379,7 +1390,7 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 			struct free_area *area;
 			struct list_head *curr;
 
-			area = &(zone->free_area[order]);
+			area = &(zone->free_area[flc][order]);
 
 			list_for_each(curr, &area->free_list[mtype])
 				freecount++;
@@ -1387,6 +1398,8 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 		}
 		seq_putc(m, '\n');
 	}
+	if (flc++ < FREE_AREA_COUNTS)
+		goto traversal_multi_freearea;
 }
 
 /* Print out the free pages at each order for each migatetype */
-- 
2.7.4

