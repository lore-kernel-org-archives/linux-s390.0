Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E562FC07E99
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 18:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC246197B
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 18:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhGESzn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 5 Jul 2021 14:55:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229773AbhGESzn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Jul 2021 14:55:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165IZHtI134717;
        Mon, 5 Jul 2021 14:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=czo1vFpxqD713Z2zbAYdbC/AI+eQiwU5XzkJ7mBbe7k=;
 b=WlhTUOZ/G4jMWjeuyd/Tt40oaC82am81sepq8/s/k9Hj3sGCJxVLNK36aQAEUeiGESTG
 /UyHybELJWlmGrFY1RF4y0gqYbTgp5Mka9QJDecS7EuJAgnq8Km9wgZ//Jl2LMCbceGL
 0l5jw543+q4SmZ7X6hZJpFCspJXXy+P0dJGptfZbnwq34VI7nLI1+KP+hnS9aWKF0aXX
 1nLzgHw2vchb5S8pDhrtJ4hnwaKo3qHiiGPIIy5wJEX6eHs1yzsLuqid1u7vFkYWXgRj
 agynqTfiYjaLJmPXDt5oZJpoShKMspVGN1o1uvLMHxA4Jtv8aZHS4OAXvRNEmd/VKOM8 tA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39m0k73us7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 14:53:02 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 165IqOrZ029046;
        Mon, 5 Jul 2021 18:53:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 39jfh88gck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 18:53:00 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 165IqvBY33292622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Jul 2021 18:52:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38EA54203F;
        Mon,  5 Jul 2021 18:52:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E186342041;
        Mon,  5 Jul 2021 18:52:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Jul 2021 18:52:56 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>, <iommu@lists.linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [RFC PATCH 0/1] dma-debug: fix check_for_illegal_area() in debug_dma_map_sg()
Date:   Mon,  5 Jul 2021 20:52:51 +0200
Message-Id: <20210705185252.4074653-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qHm7NlTafyVvKnbnd_SNpAa3ymBoTpkw
X-Proofpoint-ORIG-GUID: qHm7NlTafyVvKnbnd_SNpAa3ymBoTpkw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_10:2021-07-02,2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050099
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The following warning occurred sporadically on s390:
DMA-API: nvme 0006:00:00.0: device driver maps memory from kernel text or rodata [addr=0000000048cc5e2f] [len=131072]
WARNING: CPU: 4 PID: 825 at kernel/dma/debug.c:1083 check_for_illegal_area+0xa8/0x138

It is a false-positive warning, due to a broken logic in debug_dma_map_sg(),
see patch description. In short, the check is mixing up kernel start address
for sg elements with the length of possibly combined sg elements in the DMA
address space.

I am a bit confused by the whole logic, and not sure what would be the best
way to fix this. The false-postives should have been possible since commit
884d05970bfb ("dma-debug: use sg_dma_len accessor"), which is included since
2.6.31. Also, it seems to me that even before that commit, the check would
have been wrong, or at least incomplete, because it is located in a loop
that iterates over mapped_ents instead of nents. So it would not check all
physical sg elements if any were combined in DMA address space.

Gerald Schaefer (1):
  dma-debug: fix check_for_illegal_area() in debug_dma_map_sg()

 kernel/dma/debug.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.25.1

