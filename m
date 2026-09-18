Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3A511E85
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747946; cv=none; b=J4VHn182rxnwIO5MLgoaFvgQwItzAYuuvYoXQQa2JTCPr4hLwF5jsQG/aqegwbVGGGiMqa9GwZpvEEDXgW1rGaEBmmuDDEILplx7oxEnZN0fQsMyQp3kXhbeRcJrWfRyOpoYwUyV/zlNkwrO6wxGCmsaDpkEWupx3FCpXzrvQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747946; c=relaxed/simple;
	bh=/WoZ8qJ4L/6SX4FKj5ca+etsm/UgQyHmkxbRyFDC87A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGFd7LyvEUNxmBerfddupPrmNJTHRjvDkMsWIBcNpre8ur7tfsVv730pAD1qhUuw7iFYu8VtAWGXhFiHIL3KtZ0T0bBZHKUUUu+HYlQ7Y68TUKH3j1NOTE84h5ibibObnJSEGU+6tzb3B2+Q7bIaMWsQNcjqtFB154ppPeieIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sXLKesmX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sXLKesmX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVbq41421243
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 16:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=lNRlxmYgM6wOFrvIqLKlu49i5wFvoIuZyGdnvn4Mj
	bM=; b=sXLKesmXA4nmhEGny82+nuYUbgybF9+WrXa0HUYzoFVy+eQvJ4f0AIyXo
	tlpWITkBxo7DMQvD0yYvmINo5AqzkXE61+PC+TYzn1KGil1ieohWJUo4CYBVArk1
	Ro9sH6DoKNC22xuS2Y9z79whEEB5VjXu9k1hbeBnSMAkobr5hYmGKxeVA6DNVes+
	2cih3FK4w5ikapG/KlWMrpAkddjjunGOSmnMslfcMud/HsO6bYoei3s+OV0dflvj
	JbXBBFVf7wD5rT/4Op2p9vQWGgoraFM/Jg8DxHT891dvbT4ami+IqW2hcwUN7kIz
	EQFUu22rnHoZ1HDHYZl+8y6fc6I7g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvgevr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 16:12:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNtsH771788
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 16:12:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffg52g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 16:12:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IGCFqc6029696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 16:12:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F1F620043;
	Fri, 18 Sep 2026 16:12:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3923120040;
	Fri, 18 Sep 2026 16:12:15 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 16:12:15 +0000 (GMT)
From: Peter Oberparleiter <oberpar@linux.ibm.com>
To: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH] s390/cmf: Fix virtual vs physical address confusion
Date: Fri, 18 Sep 2026 18:12:07 +0200
Message-ID: <20260918161207.1756809-1-oberpar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIyOSBTYWx0ZWRfX6oijpJqahhIS
 G7PFeHcKuv19/mCPNs2SZr1K40GKaB+zHKqtqZoQ33Bt/Bp2ab1oID+p66oZO0xgmTxI6BTNQv3
 q6Z2sS4pRd+dIyAzROpAU32rS78bjV4=
X-Proofpoint-ORIG-GUID: N8xFemz0MmR6dprxOaB0r1xGeI-GeTKy
X-Proofpoint-GUID: N8xFemz0MmR6dprxOaB0r1xGeI-GeTKy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIyOSBTYWx0ZWRfX8byqHhVXkJl2
 Eiq6z5iKdp32WU0cVEqK3urYmtUZUfL7Wl5g9U9168HxZJI6JURHTANafMqakjE1hQAcftJNv7U
 i8THVDJtcKJJ4iH9k2wnOBMsArOqZyKw4uTblRDOT6w1OiKl25e5h+Hrl7el7VMGWcFX7kRMmRn
 kaMyfCHF6+yRM1brZe+FcK+SNtbBjo5SX9MhdfrDxalxtVM2gJB0FNhLWZ7cOVvi83dkNYYvhMU
 ydeJyfEhe+Brt2q6BmR/brxkaM/V8ST9U0JKk9YlEzNRfBAI8RjLmHvGAYSj/mFftghNaTo5561
 0Mdb1U3u13A1VIckBPztBiQ3y2sib5Puu0Xf5swdfR0niqXYrlvDC6Qi7sTj4npaZ3+53DVhT8c
 P+3OUjz/nXhCOW1CVpsQ7tLR7GBm+gYOQ/EPX/G0C5MewBHx34c9jYPGPbihZRjUkjA3w+LUqgE
 kLw0i90O6Gp8SDrKRkQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad62e3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=tLthRNIcWGBJtGepR_YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180229

The measurement block address is an absolute address; therefore add a
missing virt_to_phys() translation.

Without this fix, a wrong address will be used by firmware when storing
extended format channel measurement data on kernels built with
CONFIG_RANDOMIZE_IDENTITY_BASE=y.

Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 drivers/s390/cio/cmf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 92ab3d546fe4..5f57a12762d2 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -183,7 +183,7 @@ static int set_schib(struct ccw_device *cdev, u32 mme, int mbfc,
 	sch->config.mbfc = mbfc;
 	/* address can be either a block address or a block index */
 	if (mbfc)
-		sch->config.mba = address;
+		sch->config.mba = address ? virt_to_phys((void *)address) : 0;
 	else
 		sch->config.mbi = address;
 
-- 
2.53.0

