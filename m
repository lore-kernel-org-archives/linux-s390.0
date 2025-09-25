Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA902EE60F;
	Thu, 25 Sep 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815239; cv=none; b=CKg/TcLPuvYEbahvb0r+l7PqBJeR7xff17Ebwg/MlnAuXZDJNuqtWVfu/+BzkwB6qool+zC+JDRN/vKQdn6zt26Xo7QTuYqTlbZbFbFzbi4K9hrdW22lMWArKTdSdTfRl9flAUUL9JbmGMalPqrHJczPTfbcJGbGWt1eMcVTAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815239; c=relaxed/simple;
	bh=Hq47Vh6usBDFxK+c3WRO4oyVtHPNQ1U+xQdDXTAM8zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/44eIL4GxtAfdhDaaJWi2lsyqOod47+AtfDSQQv5p1it6YuH2y8NJQisQCE+0aVO923IY4TSff+as36a/GZcY2JiArungSZOc1n0jeE2wkm6g1J7Woc3xspu/RHCm7/3AbgXBZe9DgChcpOZXK0qXrXZeMde7Fmzf0xZjND9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K7EBFryx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K7EBFryx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PBKuCJ008695;
	Thu, 25 Sep 2025 15:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DiJKBd6DCJosTzi7s
	IDvHXNi7nNFoTJadkf0nT8eZ7I=; b=K7EBFryx6AsOCMxOY+piiBRu48TTk20b7
	2eCXXAcb7YwjPhlpOE/lGC89oDm4ZsJeHLnj2E4mpycL/KWYeE/WgEh8xLE63Ixv
	lXHbGXd17n97Jtmr7aAEsV8ag76iZw0JOGBxwJ5DeE3yfNJ0y0zB5yik1DUBOqtb
	3TJJ8It08rX/w/iy7iVJL/tewNT5HQqTuJrvrlLp02Sa1VJNa2qUExoRs5R2aQ1m
	mGC4wYIuBXaGaPEA4Pj4nW/ZL902TKdWIENZ9YDy47LhC9ShdakeeVvUFs+yaOKc
	ryPf9mypg9Q8eKBbkoNHPm36d/5zhGDO+rtDelMjyh2JLkJr1MfXg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jxm8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 15:47:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PDk4M9013334;
	Thu, 25 Sep 2025 15:47:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49cj34dt38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 15:47:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58PFl9RU52429302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 15:47:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F04D52004B;
	Thu, 25 Sep 2025 15:47:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFC5020040;
	Thu, 25 Sep 2025 15:47:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 25 Sep 2025 15:47:08 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id B2601E16A6; Thu, 25 Sep 2025 17:47:08 +0200 (CEST)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH 2/2] s390/dasd: enforce dma_alignment to ensure proper buffer validation
Date: Thu, 25 Sep 2025 17:47:08 +0200
Message-ID: <20250925154708.644575-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925154708.644575-1-sth@linux.ibm.com>
References: <20250925154708.644575-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX6eVoocr11yyT
 2HWPL0e3L5VJkGGMZ/+VG7mXgbX83nVTIBGvXH/OnqQLAygeDxpKYrQaELVXTlb6aU9sOUjEdYt
 JztVt8jy3d4/7lQFTDS4WeKaf/3FUGzzWmL5CdtH8A19DTNvSXfLf/y3SduMZ/UYzyMz75jgHiq
 hUr4Fije2VB14o49IyqFzsMhzbYCIAPdOSiBDMLykoNMMPaWfVb2vUQ9ymINf8Q+iyz90damkGu
 gZHuKO3z0rvgF5Zs5qOHr8hH6gLFMpOckmTicd7NuPl9+f221Hi3KVZR/ZLMhWv56LVYp8SFJG2
 6DQuuhb3CRPivjJv7EjdozlbL47KBMn4WTHUIokKW9RCP8ITJXcr1SOrGrVSKRn9mmm4bS+o6CB
 xZYhyfZg
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d56404 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ckwvwCoAd6Cgpq2gxNsA:9
X-Proofpoint-ORIG-GUID: NnB5mjbGA1EkKO5y9MFos-Oc5giZHoUI
X-Proofpoint-GUID: NnB5mjbGA1EkKO5y9MFos-Oc5giZHoUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

From: Jaehoon Kim <jhkim@linux.ibm.com>

The block layer validates buffer alignment using the device's
dma_alignment value. If dma_alignment is smaller than
logical_block_size(bp_block) -1, misaligned buffer incorrectly pass
validation and propagate to the lower-level driver.

This patch adjusts dma_alignment to be at least logical_block_size -1,
ensuring that misalignment buffers are properly rejected at the block
layer and do not reach the DASD driver unnecessarily.

Fixes: 2a07bb64d801 ("s390/dasd: Remove DMA alignment")
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Cc: stable@vger.kernel.org #6.11+
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 6224ba412623..417a2dcf1587 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -334,6 +334,11 @@ static int dasd_state_basic_to_ready(struct dasd_device *device)
 	lim.max_dev_sectors = device->discipline->max_sectors(block);
 	lim.max_hw_sectors = lim.max_dev_sectors;
 	lim.logical_block_size = block->bp_block;
+	/*
+	 * Adjust dma_alignment to match block_size - 1
+	 * to ensure proper buffer alignment checks in the block layer.
+	 */
+	lim.dma_alignment = lim.logical_block_size - 1;
 
 	if (device->discipline->has_discard) {
 		unsigned int max_bytes;
-- 
2.48.1

