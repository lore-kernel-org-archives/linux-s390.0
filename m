Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066238DC46
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607244; cv=none; b=NQfSLcNRY4DNh4fKpwHoRwj2nuV1mLA3KE/7AAxPmk3CLKYNR/KQ0tAOMyzuBLd5bAojs5nyqYLgCDS75FAaHAtxuE6HCyIQR0+qzK67yYCb/4SwCTRZCkQabenUyDLpF3dI4VwKp8VfX/wDzM3EFpOC3F1rJ7J/cD3fvVyUY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607244; c=relaxed/simple;
	bh=2Cy1EGx6iYkQYdsK/PCNkierRJsx0oG/QxtTrEzYHMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDN1J+mQNOpv5MzPYjPDZSDdE9JJbPqx+YFBsJeeLCrF9NUghbDKmw2d77/ClNB/QhQqztCEKzWNIQnv3nEru9SIVxXhHa4OdklB4BfwvhtdKEK2+Yy/nSCyNL3R+vhTmtTbe5KAsJ2cGxqqgtqxj5rPrEnENQmrvmwM6aalC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lm2Cdo1e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lm2Cdo1e"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671FnQhT1001723
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=chvKDX
	/ZCbChaAJ2TCmhInNUdxj7IXzKQoC/xVByzSQ=; b=lm2Cdo1eXRBXv/zwjbzcKp
	APKJr0B4m8lrkOpHPLdb62cJjuueRR6FEcdu+qDn3BXIxsrEQCaU+a/EUME+3U+h
	OnSRFWhjdQm4C5BU+GxbyOcQ1t5twTITWw0Gsw+qcKXSYuLp8eUovA+odj+NXUeE
	OlTsqTo/wloAbrImkwbEvxFFOlRm4Z4B9K0RGiE2mvzn06WHaDUURNLFPyzcKBXB
	jwBOkLJERx+lTdvKh3oBEk0QE9qCMp+MTt6D9yoWjrK3YtAGxfOG6lF8bQtQ/wCA
	Nag6l6DL0Ie75rkVVDvLueCAdpqS2oQZy0yVOc2iBJt6gH8kW1TndzVMJ59RGbPg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eu9y77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HuPP0014510
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkmr97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0akt49348972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6624C2004B;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E3222004E;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 02/19] s390/dasd: Propagate partial completion length across ERP recovery
Date: Sat,  1 Aug 2026 20:00:16 +0200
Message-ID: <20260801180033.3679412-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801180033.3679412-1-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wHFhIMwwsQwes_IdGm_pcIBNo0ptBk8K
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX2KdC+z1bDeXa
 ASqglYUwmTtQf7IOYUnfrxQl5+fOuorsKoppcM+QCypwJBq8ZVCyV1pvoQD2fZ2C/yRdrGDyEqh
 j+siDwzrGVeVKflPHCGZLJ+JbLmuBLE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX6/zTSKyYotE8
 E5r3lsSpSmRhIdOPsd4ydN92DhmAdO+qw2xnWS8DF/F0L2ZcnOZ3bvRrknwPtTBlltUYtaU23s4
 E44vwJe8R9nXWr8uEOvP1bHNqgn3R4H99D51IMN/eR6tjnqTjJUJ0hho7n9Fjpoc8sRrQnK0xxq
 iN0IGOV0b4se07FYOIw7zrZ6ZvBJoamccdtviw2xM5WW+UfetCE7Z70aq9qTs2+ecK/V429cA94
 6tspbgwtUUhbmmz7UL/VfswjobremyMDROo575coZEH+dIqzKJ4pKrZttswrETSEQkdBmcdLBXT
 Ri5qnRWgM19zbBN/WcoK7QbQdnOBID7nm5RaSMFUaLydjg2c4QXy4Ujyb3yXOuNdn+n0Mu8dKpR
 TQap/eTqMVE7ymtQxSlEesk2XuXTeJyb6iVGjbapBG/MvuItHEvGk4Tjfn1a1imPtJ6o15sE39G
 xlMrfNTuSWuh+cz1hPg==
X-Proofpoint-GUID: wHFhIMwwsQwes_IdGm_pcIBNo0ptBk8K
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a6e3449 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=01JC27pNfGPOVEZEpjYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010143

dasd_default_erp_postaction() copies the timing and device state from
the finished ERP request back to the original request but drops
proc_bytes. A request that was partially completed, an ESE read of a
not-yet-allocated track returns fewer bytes than requested, and then
recovered through the ERP chain loses its partial-completion length.
__dasd_cleanup_cqr() then sees proc_bytes == 0 and completes the whole
request instead of requeueing the remainder, silently returning zeroed
data for the part that was never read.

Carry proc_bytes over to the original request like the other
per-request state.

Fixes: 5e6bdd37c552 ("s390/dasd: fix data corruption for thin provisioned devices")
Cc: stable@vger.kernel.org
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_erp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
index 89d7516b9ec8..468f0b2cc342 100644
--- a/drivers/s390/block/dasd_erp.c
+++ b/drivers/s390/block/dasd_erp.c
@@ -123,6 +123,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 	int success;
 	unsigned long startclk, stopclk;
 	struct dasd_device *startdev;
+	unsigned int proc_bytes;
 
 	BUG_ON(cqr->refers == NULL || cqr->function == NULL);
 
@@ -130,6 +131,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 	startclk = cqr->startclk;
 	stopclk = cqr->stopclk;
 	startdev = cqr->startdev;
+	proc_bytes = cqr->proc_bytes;
 
 	/* free all ERPs - but NOT the original cqr */
 	while (cqr->refers != NULL) {
@@ -147,6 +149,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 	cqr->startclk = startclk;
 	cqr->stopclk = stopclk;
 	cqr->startdev = startdev;
+	cqr->proc_bytes = proc_bytes;
 	if (success)
 		cqr->status = DASD_CQR_DONE;
 	else {
-- 
2.53.0

