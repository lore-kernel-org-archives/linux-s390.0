Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA4C07E9C
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 18:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBDD6197B
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 18:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhGESzt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 5 Jul 2021 14:55:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229970AbhGESzt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Jul 2021 14:55:49 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165IZAxO082841;
        Mon, 5 Jul 2021 14:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tBLhHqmv8Xr1QxendNUR/DvIJZUmas2B18j2RZcJe90=;
 b=VNCxy8+JCw6kjy+bxizvOMve0X8Ha6lplJrGJoRB8hxmSpv2nm4NFRKPgSKvflnxggpN
 RMxvgIc46dgqUVTO2iu57KSrvx6xxJTi/7Pwat0FrGPIlogo+YA1rwnW01aK3eVowqO9
 XZ18Cvm6iN58JbDDB/ynkCTHvMO4svQirFDlhNf3AL1dKCE6TPs3XQ7tb8/O1fklsSDI
 iQsXlALN/hTLpKJqifZcatRzYGVMAv2pUNMc1bI40JrVp4OC8iddckmx2r+wWZno6ZD4
 JtnzHPReXrFtBG60HyJyRe3lwaYqUUzDPTrvvdyh/YMZNnEvjbE/j/j0UeQd94EI3P8l uA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39m6k01j6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 14:53:03 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 165IoBnc015081;
        Mon, 5 Jul 2021 18:53:01 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 39jf5h8ww8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 18:53:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 165Iqwge33423678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Jul 2021 18:52:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42ED742042;
        Mon,  5 Jul 2021 18:52:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02EEB4203F;
        Mon,  5 Jul 2021 18:52:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Jul 2021 18:52:57 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>, <iommu@lists.linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [RFC PATCH 1/1] dma-debug: fix check_for_illegal_area() in debug_dma_map_sg()
Date:   Mon,  5 Jul 2021 20:52:52 +0200
Message-Id: <20210705185252.4074653-2-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210705185252.4074653-1-gerald.schaefer@linux.ibm.com>
References: <20210705185252.4074653-1-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gV9b_hflviYi124sNTpneb2U3SZKbgLQ
X-Proofpoint-ORIG-GUID: gV9b_hflviYi124sNTpneb2U3SZKbgLQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_10:2021-07-02,2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050099
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The following warning occurred sporadically on s390:
DMA-API: nvme 0006:00:00.0: device driver maps memory from kernel text or rodata [addr=0000000048cc5e2f] [len=131072]
WARNING: CPU: 4 PID: 825 at kernel/dma/debug.c:1083 check_for_illegal_area+0xa8/0x138

It is a false-positive warning, due to a broken logic in debug_dma_map_sg().
check_for_illegal_area() should check for overlay of sg elements with kernel
text or rodata. It is called with sg_dma_len(s) instead of s->length as
parameter. After the call to ->map_sg(), sg_dma_len() contains the length
of possibly combined sg elements in the DMA address space, and not the
individual sg element length, which would be s->length.

The check will then use the kernel start address of an sg element, and add
the DMA length for overlap check, which can result in the false-positive
warning because the DMA length can be larger than the actual single sg
element length in kernel address space.

In addition, the call to check_for_illegal_area() happens in the iteration
over mapped_ents, which will not include all individual sg elements if
any of them were combined in ->map_sg().

Fix this by using s->length instead of sg_dma_len(s). Also put the call to
check_for_illegal_area() in a separate loop, iterating over all the
individual sg elements ("nents" instead of "mapped_ents").

Fixes: 884d05970bfb ("dma-debug: use sg_dma_len accessor")
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 kernel/dma/debug.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 14de1271463f..d7d44b7fe7e2 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1299,6 +1299,12 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (unlikely(dma_debug_disabled()))
 		return;
 
+	for_each_sg(sg, s, nents, i) {
+		if (!PageHighMem(sg_page(s))) {
+			check_for_illegal_area(dev, sg_virt(s), s->length);
+		}
+	}
+
 	for_each_sg(sg, s, mapped_ents, i) {
 		entry = dma_entry_alloc();
 		if (!entry)
@@ -1316,10 +1322,6 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 
 		check_for_stack(dev, sg_page(s), s->offset);
 
-		if (!PageHighMem(sg_page(s))) {
-			check_for_illegal_area(dev, sg_virt(s), sg_dma_len(s));
-		}
-
 		check_sg_segment(dev, s);
 
 		add_dma_entry(entry);
-- 
2.25.1

