Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC42F60CC;
	Thu,  6 Aug 2026 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021267; cv=none; b=Ro7x+b0eMYJe9eTWGw2F2HrIUZdLAEgbHjrlx9sHdJPTXlkt7mnTefvqCh7Px2emZ+M89iFBDwmIr54TEehzgNOanvNpvYLeN601Z913ArEnN4UpyoAk4qwFXp/Nz0LQFYIdvceu6p9m95U77xgFpuz3mWMA4sS5YpFNCzwmwk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021267; c=relaxed/simple;
	bh=ZAaqhht7UCGF+FavF6oXKUd2SxqKM2wqg+2iLaVzlQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6v5JXsurfAYCCAc6YfDVyHImtErGhY04JMRcON7rrmxwSjp5mDBpePIOK0yvDEJH5A+QJKza55G/bIn/Kc1m8VYz2ePs6cg69b9+aidqCcBuzVLcj1HbMJhfdtPEpkD84i1V/SsA62wLZhS3VOkeYKpMY6mx1l/VQ+VypgZbC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QAlBF5zu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QAlBF5zu"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NmYxf1067629;
	Thu, 6 Aug 2026 13:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tmu9uLGK6FOMztW1v
	qr4Xu9dhQGuX0NF+SbzRsUlSuw=; b=QAlBF5zui4pwvTlCdeuDENExP71Yls4xT
	iFUPUsICXeNXfoABOYmh4zcnIxP91Y35d8rxSPT0CV4HUGtD7q7ipYJX+9jpaXRO
	dZp+eCF3L90/KUIR8KYkHMZFEjCqnXHtERt7zcscW/VwLmlD1k+sRVd3V2N4tyA5
	1iu4mTJ4chQsi3yQLPscc/U+Aj9EnKniHUNMCEKK4jWi6Xn5lZuNII7UoNA2onTF
	WkiAU2oQfVKQqxlWcYcCIKPdnxCFiUbbqQJHo7jri8QA3FS5exQwfuG6mwIkMMDb
	fWYQx3z586cL1GbHEYNRXMJGFLbjaa4ZywZ5MaDvg/N+MdeX813yA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a488tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:00:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676CuJ32022024;
	Thu, 6 Aug 2026 13:00:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhk4k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:00:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676D0pMV43516356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 13:00:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1680920040;
	Thu,  6 Aug 2026 13:00:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8E6F2005A;
	Thu,  6 Aug 2026 13:00:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 13:00:50 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 2/2] s390/block: Enable CONTEXT_ANALYSIS
Date: Thu,  6 Aug 2026 15:00:50 +0200
Message-ID: <20260806130050.2057443-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806130050.2057443-1-hca@linux.ibm.com>
References: <20260806130050.2057443-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a748588 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=c8_Hlv1mvRlDMxlCQVsA:9
X-Proofpoint-ORIG-GUID: IFaH7WDWX6sXziasGZjyRZagDnXVRoQm
X-Proofpoint-GUID: IFaH7WDWX6sXziasGZjyRZagDnXVRoQm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX9rBVmhntX+N0
 yWA6+J+K9RxC9rHtnEmTXo5b/IEkoCbHQNNLnJGynzxBRyrML8mF8PWQlm5swyXp7/noZUYTnyR
 iBaXQuOS4Uyzi99Jtx1Evtl92bUnr7g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX3382Z7fho6CL
 96l8bfpYFy7/6h8jYCSBBXev9Q7S4Rpjz3ZGXc63Aayac3LklX7kcPfFDdWqlz6qdW6IcEEe/v2
 Nip3Fyp2DxtSUxHyUU4jzjGp6ryXkGi462/PB30s4e71h1l0bPr9qarayI/jZ01v3PMpQZqNHKn
 IwAbtoHe41BDoIqTUcuGd9xw5hdiKJwKj6r49+SOXP/2bvi65w8S3hRXvBN/CFUC31renZbTaAK
 9E9MG0/fd+9XtkBUo9l5P0MSVs0yKRws5Y3Xp9npeSNMmEt7lyeKGe/McwSPuAw2Tjg0dv3p9uv
 uH8+Z+CHrmZYnPhEYs2pHzpuLi3NfK4RonwTI3/MRJILYr7fHBk2ZRFzuLfbK2V3yE5CaH6Yn/5
 IAlzeYFYFWdPlMxtHfBXh/itNmPHBWp6EmuzRWRNxcsaCuQApxkr52xukH5Nw0lIn+88G2rjikJ
 syhYnyvI/Dzc+IJqT3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060101

All drivers in drivers/s390/block pass clang's compile time context
analysis. Therefore enable CONTEXT_ANALYSIS.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/block/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/block/Makefile b/drivers/s390/block/Makefile
index a0a54d2f063f..3dd1a3ce7ed1 100644
--- a/drivers/s390/block/Makefile
+++ b/drivers/s390/block/Makefile
@@ -3,6 +3,8 @@
 # S/390 block devices
 #
 
+CONTEXT_ANALYSIS := y
+
 dasd_eckd_mod-objs := dasd_eckd.o dasd_3990_erp.o dasd_alias.o
 dasd_fba_mod-objs  := dasd_fba.o
 dasd_diag_mod-objs := dasd_diag.o
-- 
2.53.0

