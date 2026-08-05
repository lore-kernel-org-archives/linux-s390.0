Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113FD434E21;
	Wed,  5 Aug 2026 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928590; cv=none; b=Rw/vvpJl8VGdPjFaHYvGT5hT3srhxYsjT+ApM1PH1Ja4rpsRPdpTvNKznh58CqEiLAxK70hiV6/XVc/O+6m/Elq28pxc0EFxCs3nH7ZhauSFs9QJLYAq3ok81wFY3KG2RGt00UJQmkrKOgsyv58yOGxqBQ+M2hZbvydYlO9HP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928590; c=relaxed/simple;
	bh=E5eoyvYQTCKUkZrTNj3fYUhYRJfSjxU/zTOQOcYNnWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKc6EchMdR3mdQwDqm91bY1EYvMettsrvwZfPNYcvzxj2j0AYQr61y6614G9EKejl97lS2qXWOSmukMfDmmRiTmI6VEcJ6PH4Ew7cXGXCIKr2Ub6XK0x4aCT6HFKEIurROwhesPR47ZRM6U8vtNFD+sli3rOklOvvgq9nGYyb6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F36FSCTm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F36FSCTm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lY2u3387224;
	Wed, 5 Aug 2026 11:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N08zY9
	1AwRUBe1HMnQCU6ps+6pWC8eZPBwIyNJQNTYE=; b=F36FSCTmCwE53PtJZhZx6H
	osrt+LMFwwpLUlb2YhvhxOs6uMN78X5dpHEozP9kOOo9UIZgG1Dh9h8ixGIhrrwd
	vWDHP5WdToOgJVysf84UgZnKmbZG+Q9Q6F+Th6qlfYEGTWjeunHtvT9ra19ot/VS
	60sHePARn+vce0lMiGfosuJaxe//8KTl53bQuyRr5J28qEnLJLLBw3n+72tnHcoJ
	CKQ9gWHPQQ5mt55FrqedCu5bDRWklTHmqNgIC7QjQgL8ddHVTkk1LL/3YNlAesAe
	ua4dgd9tzxlHByUa18oZxMGzcwBbBSYJIdTDrhWvbiaJrFFL2PgyvPocTz5bMhjA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h52q1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBLr8012766;
	Wed, 5 Aug 2026 11:16:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyp0v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGHtF46989760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81D7D2004D;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FE9D2004B;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 06/19] s390/dasd: Use GFP_KERNEL in dasd_alloc_device()
Date: Wed,  5 Aug 2026 13:15:59 +0200
Message-ID: <20260805111612.1285190-7-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805111612.1285190-1-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX3zpkXlleYNBA
 VrSr0y/1H7CBLS6eoijL4loXn4Vz9DQ9KvpF2qNw+FIVrnVy6gZzEyXc1FjnoXhAJpUpF/BmMpq
 RoGMGWZRxkrCIGN9NOk36rJRTVxUPr4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX1aPZBls10IRO
 t/27qNKDw8H6tXen6ocHdd8yXLP0Rb8da1DXgjC4+6WTIW+B8EtqIQnDMYrtQggLYI9uOhJ1EKb
 ePSyblSeVkL+uJG2GprIyHtUwqyd2Hz4UKbwBqZQUbUXnbNq3WXvIoI85dbOv1iBbdNgr1YeTjV
 REkNsfOPg87f9gx4HSlM4DhW7FmC2vaPGhpac1wQ2qdfUNkmUL95eI9ii0DGUY+Q0pRFgZEn1z7
 TalfpZwSfFxbWCZeO2hNkmqy/Mc5lFvvWiCy4nu8kFAHIVlaVSQuFKxyi1a/Rbq4LWbrLFVYbnw
 Q6kdKKGeGL105Iih3lV58pNB4RiWjvyZFGuvl97deKqklNBrGk5kTTB2w3mp1hxFeL0WJLL3PTr
 bd2YN8RRffEmHnb/+IBoePyPYrod/rk2nEgGIS/SVdAMMpNY6NnCh/XTyo6e3Ebxx/9C/A6NtB0
 WmT4sQy6yaTJHXevpeA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a731b88 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=yoix-QT8sNaOgVSsM-MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -a4BzRLAYj_mFqJ9jdxZ0ax_FMXefNIi
X-Proofpoint-GUID: -a4BzRLAYj_mFqJ9jdxZ0ax_FMXefNIi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

dasd_alloc_device() runs in process context (device set_online), so its
pool allocations do not need GFP_ATOMIC. Use GFP_KERNEL instead, which is
more reliable, especially for the larger DMA allocations that later ESE
full-track work adds here.

No functional change intended.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 34b563917098..12fa04537fb0 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -87,25 +87,25 @@ struct dasd_device *dasd_alloc_device(void)
 {
 	struct dasd_device *device;
 
-	device = kzalloc_obj(struct dasd_device, GFP_ATOMIC);
+	device = kzalloc_obj(struct dasd_device, GFP_KERNEL);
 	if (!device)
 		return ERR_PTR(-ENOMEM);
 
 	/* Get two pages for normal block device operations. */
-	device->ccw_mem = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
+	device->ccw_mem = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA, 1);
 	if (!device->ccw_mem) {
 		kfree(device);
 		return ERR_PTR(-ENOMEM);
 	}
 	/* Get one page for error recovery. */
-	device->erp_mem = (void *) get_zeroed_page(GFP_ATOMIC | GFP_DMA);
+	device->erp_mem = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!device->erp_mem) {
 		free_pages((unsigned long) device->ccw_mem, 1);
 		kfree(device);
 		return ERR_PTR(-ENOMEM);
 	}
 	/* Get two pages for ese format. */
-	device->ese_mem = (void *)__get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
+	device->ese_mem = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA, 1);
 	if (!device->ese_mem) {
 		free_page((unsigned long) device->erp_mem);
 		free_pages((unsigned long) device->ccw_mem, 1);
-- 
2.53.0

