Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5943B4A7;
	Tue, 14 Jul 2026 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018980; cv=none; b=Mf79Skkj7L+D7KS1C0Vfie6LiB2xWW18+xXGpl29KPZ33HO7KXIhhxh3Qi0ImA0ga/EAxWJtY3pHpCPYbmvUF6fbGeC8z8mEaHeA/7PVxdzm/s1SozzT8IAumU9B2lakbFbpNcXCP2ltXANx7DmGDiL4EE7m8141DgpxMCnUnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018980; c=relaxed/simple;
	bh=pWk+EHXA0gkHhBn1nmSvYa6FvqTEXC1IPSolntufdX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hprMPpPsNhuB9XcEWnf5e6E5ugL0/+QDypap9INnHkTasWI+HiOGSXUU27rWgOaGmkVj/QLhii6MG6eTmaoAU7hn66S3FdmzON+dNRsXqLSnacoFykKbVltt3VhB8Rh+b9AmLR979x+V5tjkuBY83tluelV4ulKJQXCB4Vy7KRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k4MzZU8e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k4MzZU8e"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6fZn8569363;
	Tue, 14 Jul 2026 08:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QfI8b7m2edweveHIG
	O9q1AENGco0V8chDgxVQ8HaJ5I=; b=k4MzZU8eKXEpOrfB9gr4Kxx7juKA6cN04
	wbIvjdNoLMvf/Zj6iTOdXE/q17TsuNmAyZ4bkz/+wDmy9hOA+m8XmsWi70vsD5nT
	uXYqyy5EAKOxGF6uDy3XzCG8mb3FvQWJkltjBGlUnEbSVPjPjf5SP4g07KQqWIxL
	2BgYke3432xywvaeZVbOm5gBxUxnZ5g+UKDEDMozlZ4LETVgx4AGr/fibCB8ewPH
	fD9VQ0urEexo6L+cqRsuJDF5M0/o274cf9+LeyDs553dranfYRm1xBifATwXCpV2
	U+Y343ekH8+MeJtenoidb/kygmNRRBOk6wyPx7q8bp9DqOaiagepA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt563w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 08:49:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E8Ye3K027430;
	Tue, 14 Jul 2026 08:49:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05q21yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 08:49:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66E8nQfU20185592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 08:49:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DCCF20049;
	Tue, 14 Jul 2026 08:49:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDA5920040;
	Tue, 14 Jul 2026 08:49:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 08:49:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id C729B162557; Tue, 14 Jul 2026 10:49:25 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 1/2] ptp: ptp_s390: Add missing CC check for ptff()
Date: Tue, 14 Jul 2026 10:49:20 +0200
Message-ID: <20260714084921.3926697-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714084921.3926697-1-svens@linux.ibm.com>
References: <20260714084921.3926697-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1lMo2irHp3PycZT9fu8xqUo9ZeYsShoZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfX4rS3L3rE0iZ7
 IJRiZh40/8T7Od50bJ0yvE0p7zAYrj0GpvpPuNCmLQW5d71rKst/sTDno4kJz2GkuuKaZUIfh1Q
 oOWY35S6p+2hyZG2CUj0f+PKgi7+qag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfX8FidIk//+4Cy
 ren0DXnsnhYe+Hf6+EURSLGUCFC13sbsLxbtydLsv9153iQDgFY2Qcc4t3sMFe1d+MgBeurbop7
 Ncv/iVZFcWq+tCG2aX6tbm0cUPXqBy4JNMxAAEc43C0kE96A7ZEclW3cD4VNlZyJRZXDYaQVZpi
 YUhz2mYxh0xpAOo31BtWvFTcqC0jNTa8Cv6lcryRUIXfjr0peUGnhbdOVGYzqLu8ZkvE+cD2YVa
 vE4qQgw+FqgpT6MekBBMAGjjEOhzGzMyvTp8oaRp4RbM6TTbxvVQI0pYWJVI2Y8biguqgGZ1iCH
 6+bZBx2c4NuwFXDSS+yg1fqiHL+hcetEVKhwoVLYp2Xm259bGEGFTjTfMDlcYE4kwShUd9kYfQA
 mEI/XO3aH+Rz/dBeSxzEponA8j57g6KR/ZY8kSIM0YFPtzQH17hMQkm/C8YD9Uh9TqKX+IsbUpa
 /WsnMrYH9Ew51GjDyUg==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a55f81b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=aJ9vwCNxJAxr5Z7Rpj8A:9 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: dtNs76m55R2kKiKWAvNi2HbM3lOdsATc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140090

The code doesn't honor the returned condition code when issuing
the PTFF_QPT call. Fix this by checking the return code and returning
EIO if it is not zero.

Fixes: 2d7de7a3010d ("s390/time: Add PtP driver")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Cc: stable@kernel.org
---
 drivers/ptp/ptp_s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_s390.c b/drivers/ptp/ptp_s390.c
index 29618eb9bf44..7299c3aae65f 100644
--- a/drivers/ptp/ptp_s390.c
+++ b/drivers/ptp/ptp_s390.c
@@ -48,7 +48,8 @@ static int ptp_s390_qpt_gettime(struct ptp_clock_info *=
ptp,
 {
 	unsigned long tod;
=20
-	ptff(&tod, sizeof(tod), PTFF_QPT);
+	if (ptff(&tod, sizeof(tod), PTFF_QPT) !=3D 0)
+		return -EOPNOTSUPP;
 	*ts =3D tod_to_timespec64(tod);
 	return 0;
 }
--=20
2.53.0

