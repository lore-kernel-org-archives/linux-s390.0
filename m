Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F438C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  6 Oct 2021 20:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE196113E
	for <linux-s390@archiver.kernel.org>; Wed,  6 Oct 2021 20:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJFUWD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:22:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229677AbhJFUWC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Oct 2021 16:22:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196JiVUt015907;
        Wed, 6 Oct 2021 16:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=M41UkCw+LRaLXHLWRVrNOY4v6ynlGS293Of0HYK1TNc=;
 b=B+U92Wp9Lxx/TOm+cfpa0qN49Mh5ikAbvqukl40su9Rj3HsyQGU1FJQEOAwJ2n51IpSq
 egMRKoVoOlaRTjC4+MxcW4UmdDVoV1KK3cOjwEYtc041t1n8psbPZ5K2Ve3Va9uscUJx
 ptyjXPgbaOFNiI9RQYJuTOY2CxnV4+gwmRtCY37uTSk09rsOfUkiRUMHb3P4aVbFxIHO
 FPAL3E5X7A2jObBY20tc0as738ga7gSUE6s+/3TCgQDDzr6rsWSuhHuKU4p+6BPS2nkY
 I3paKgsSNhWisKE8rln/0umbVqCdkoXlGGDL55G2CGCI9S4+dB/aqGbypeROX5Oq0svg eg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bh0fdxamk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 16:20:03 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 196KCtwx000619;
        Wed, 6 Oct 2021 20:20:01 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3bef2ae99b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 20:20:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 196KEc0A59900228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Oct 2021 20:14:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D15F811C04C;
        Wed,  6 Oct 2021 20:19:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79CA111C04A;
        Wed,  6 Oct 2021 20:19:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Oct 2021 20:19:57 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>, <iommu@lists.linux-foundation.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH] dma-debug: fix sg checks in debug_dma_map_sg()
Date:   Wed,  6 Oct 2021 22:19:43 +0200
Message-Id: <20211006201943.1272825-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KRLNGAIPTo9wf9ZECrqkn06d0zY6MFB6
X-Proofpoint-ORIG-GUID: KRLNGAIPTo9wf9ZECrqkn06d0zY6MFB6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060125
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The following warning occurred sporadically on s390:
DMA-API: nvme 0006:00:00.0: device driver maps memory from kernel text or rodata [addr=0000000048cc5e2f] [len=131072]
WARNING: CPU: 4 PID: 825 at kernel/dma/debug.c:1083 check_for_illegal_area+0xa8/0x138

It is a false-positive warning, due to broken logic in debug_dma_map_sg().
check_for_illegal_area() checks for overlay of sg elements with kernel text
or rodata. It is called with sg_dma_len(s) instead of s->length as
parameter. After the call to ->map_sg(), sg_dma_len() will contain the
length of possibly combined sg elements in the DMA address space, and not
the individual sg element length, which would be s->length.

The check will then use the physical start address of an sg element, and
add the DMA length for the overlap check, which could result in the false
warning, because the DMA length can be larger than the actual single sg
element length.

In addition, the call to check_for_illegal_area() happens in the iteration
over mapped_ents, which will not include all individual sg elements if
any of them were combined in ->map_sg().

Fix this by using s->length instead of sg_dma_len(s). Also put the call to
check_for_illegal_area() in a separate loop, iterating over all the
individual sg elements ("nents" instead of "mapped_ents").

While at it, as suggested by Robin Murphy, also move check_for_stack()
inside the new loop, as it is similarly concerned with validating the
individual sg elements.

Link: https://lore.kernel.org/lkml/20210705185252.4074653-1-gerald.schaefer@linux.ibm.com
Fixes: 884d05970bfb ("dma-debug: use sg_dma_len accessor")
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 kernel/dma/debug.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 95445bd6eb72..d968a429f0d1 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1289,6 +1289,13 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (unlikely(dma_debug_disabled()))
 		return;
 
+	for_each_sg(sg, s, nents, i) {
+		check_for_stack(dev, sg_page(s), s->offset);
+		if (!PageHighMem(sg_page(s))) {
+			check_for_illegal_area(dev, sg_virt(s), s->length);
+		}
+	}
+
 	for_each_sg(sg, s, mapped_ents, i) {
 		entry = dma_entry_alloc();
 		if (!entry)
@@ -1304,12 +1311,6 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		entry->sg_call_ents   = nents;
 		entry->sg_mapped_ents = mapped_ents;
 
-		check_for_stack(dev, sg_page(s), s->offset);
-
-		if (!PageHighMem(sg_page(s))) {
-			check_for_illegal_area(dev, sg_virt(s), sg_dma_len(s));
-		}
-
 		check_sg_segment(dev, s);
 
 		add_dma_entry(entry);
-- 
2.25.1

