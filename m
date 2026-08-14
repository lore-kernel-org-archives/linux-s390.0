Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB440BCD8
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692162; cv=none; b=rRotHajE4lRUm3zydU81j9HKpjaFxDdA4zptJhxUPpiz8uEOF2HzneXTuD+urjZz/sCr9DP4PlPuhSle2YIEA+pl0uGx8xCuS4P6SKXAWcBL5FChCUypM5lP67JZ0IvjY1P6ETo1duUX7PYVTMQexIl6izBuWhh/+KzF/NtQKIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692162; c=relaxed/simple;
	bh=pSeCro6LZOEsQkpzyeb7xEnOz/bLIteoNq1acy8Ybas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuYJG+XrrdVvFqqqGan5HYq+Z4GfaOoRbm2bu965TxesJtq47uRlhVK2Maike7dTVVgyQV2YET9kO7ROHnfYzNJgoFge41pbYsB2TRFkMjSdCxh58TLyVO9pcQKtbFRtmiPNJ+t177FBzWB38riiZZ6ZomJYr8JCMIs5asY4E3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CQO1Takd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CQO1Takd"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4VVbv154625
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 07:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=UqFP7X+ReydunnCCDisgekZSBbbC+c+tFSKCn67zB
	dA=; b=CQO1Takd5mgn3vY/CxvIStjEy03J42pLupaq3xV92WuTP2y3FjgbzHqEw
	1VcIDiD8x4EK4xSjg667dmNBslR4xCFUwgXjXon/uqQ8VO1B5R2aCYVFmVCwxMpo
	2a0WFinJ14H1QE8bA1elwhfEIQeni7QCF4Gm2KRor98KmudNr6bhcbW5CGLlxpGp
	O2cxXshAwqVXj6vcVKj1k8UxcmXrhjCvTDrYr4vpX2Tsz61xoPBGFAdMgM2o6s1C
	paWVLoxait8GeZ7/N8qkc3k/V72sy1qWKaFnSGuOd6E+7+NlJD8SiNPg/PcQ0shp
	PBziBGPn8jwpl6XM2bU+pDMmzm4Dw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma3s3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 07:22:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7BHvZ028768
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 07:22:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpv93dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 07:22:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7MZBC52363714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:22:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74FC72006C;
	Fri, 14 Aug 2026 07:22:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5890E2006A;
	Fri, 14 Aug 2026 07:22:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 14 Aug 2026 07:22:35 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 3DD0E160401; Fri, 14 Aug 2026 09:22:35 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH] s390/stp: Drop CLOCK_SYNC_STP
Date: Fri, 14 Aug 2026 09:22:23 +0200
Message-ID: <20260814072223.2218864-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1NCBTYWx0ZWRfX6zKaMHsKm1XP
 SYyabNK+RWx1mm4lqLgmSMDokOXfTZXNYJu5I6mtXTIiOgxQMQLoDQPjkXtBmDH3eXbXN5AnEnP
 t+GbPhDUuqhEfZAt+IvYPkJVR6tKSSP8HoG0FhidJkqJmU3d+8guCDL0WGEsD/gAOSVDm5pqvd6
 O0FfudjZdUXSMjeMVrLdrdiX2Hy0vvrc/Yl60glq16k6h3F7L4cF6NsYjb4iszy1iLJxSmn/MW0
 QhyzGJnZreoHWZBqKROHyMZjkMQSq/sqSAsS25EEauLwsAlhlvJ2Ug0qt5XgYoOJASCPzjB9NKY
 gw4zIoaeLsgfVQH4fHX12ldY7P7IyPVg9zEsbiwtdfsQiHYpYiASKcGt3hDzBbWYXS2n8QuXuDv
 2SWw/2NVUxod+5hdoUK0PN2/bEhlXZXuqvvBPQd9OBb3OaN6EWW9HI5ea/kP1zyavr/kZHYbhkU
 ywuW605KxffC5GjJ0Eg==
X-Proofpoint-ORIG-GUID: B2xU11OYpRYlkRSXZ16CxHztfuqdK-R6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1NCBTYWx0ZWRfX05Cux0crKD9v
 Q4FXV9Q+7m8WaUO6cqHLRQD9KwvMjNk0vO1p81SIp/z/2IhALPujwR6FmQ3NsDqJM4z/XeN9rfl
 vQ1TAge/vU2XZv+VKRZ5Iw91hvFSUdU=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7ec240 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=GS6fbiYYDX-2dTScUO4A:9
X-Proofpoint-GUID: B2xU11OYpRYlkRSXZ16CxHztfuqdK-R6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140054

CLOCK_SYNC_STP is never set when the stp=3D1 kernel command line option
is used, or stp is enabled by default. This cause get_phys_clock to
return -EACCES. Fix this by testing stp_online and remove
CLOCK_SYNC_STP.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/kernel/time.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 2b989bebd220..de80e2a316ba 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -69,6 +69,7 @@ EXPORT_SYMBOL(ptff_function_mask);
=20
 static unsigned long lpar_offset;
 static unsigned long initial_leap_seconds;
+static bool stp_online =3D true;
=20
 /*
  * Get time offsets with PTFF
@@ -274,8 +275,7 @@ static DEFINE_MUTEX(stp_mutex);
 static unsigned long clock_sync_flags;
=20
 #define CLOCK_SYNC_HAS_STP		0
-#define CLOCK_SYNC_STP			1
-#define CLOCK_SYNC_STPINFO_VALID	2
+#define CLOCK_SYNC_STPINFO_VALID	1
=20
 /*
  * The get_clock function for the physical clock. It will get the curren=
t
@@ -299,7 +299,7 @@ int get_phys_clock(unsigned long *clock)
 		return 0;
 	if (!test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags))
 		return -EOPNOTSUPP;
-	if (!test_bit(CLOCK_SYNC_STP, &clock_sync_flags))
+	if (!stp_online)
 		return -EACCES;
 	return -EAGAIN;
 }
@@ -397,7 +397,6 @@ struct clock_sync_data {
 /*
  * Server Time Protocol (STP) code.
  */
-static bool stp_online =3D true;
 static struct stp_sstpi stp_info;
 static void *stp_page;
=20
@@ -795,10 +794,6 @@ static ssize_t online_store(struct device *dev,
 		return -EOPNOTSUPP;
 	mutex_lock(&stp_mutex);
 	stp_online =3D value;
-	if (stp_online)
-		set_bit(CLOCK_SYNC_STP, &clock_sync_flags);
-	else
-		clear_bit(CLOCK_SYNC_STP, &clock_sync_flags);
 	queue_work(time_sync_wq, &stp_work);
 	mutex_unlock(&stp_mutex);
 	return count;
--=20
2.53.0

