Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782578;
	b=3nvz9WHteQ8No/ZkiWanKoRrxCpoUyccDvPuHwp7ZndwSFMwNMjMtYF40y5iepYJ/tSS
	 A019yFkZTwlU6OIB8vwCWZ0Zt1HUcEnYzxodR1tW97Z4wQPkNUPUbuE7U8JamkOrOMQQJ
	 IPqvemIEm3lIqQXmlBasrZa31omZzUH7b6o0/VYe+fBJCtI5qkMl4uv9GUzJiXuUxI2bs
	 ZTtIlfFK/G7tNW9/9kYBoMiRkZJUJPG/WQeIQVZGMSGxKCdyjscVj6ww2vjfWBgIXsjUu
	 fnWrACQVdE/aSVoVpvg7bOTpsphvRENPJP1UmiqeEA0lxgtxuwAc5F264JTdtaD4mZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782578;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rMQ9ivpPC+eYfH05XZvd5us0dsMxs+C8hqULavuLw+A=;
	b=rJ2jS8+745FpWW94lq47tRjrHwEEG2mC2PVOSn4McIvXIUoOp/E65R5nDmt4O/l6u16C
	 CKUeioAtLr0AXA3odck1FyDIHjW3EFgC7RvfC5iPh32iaC0wppS/9ND0flZQJuvLvgB4y
	 WkKtua+jRz5F4DAwqVX1CI8VI1OfP0EMjxtrUWkOV6A6KG8ouzToRm0gVBos3UZrqV0Gq
	 NY/Onp3hr8/p/AX87dCH0wX5cr4Z4Ac8QJSl/lpCEZJr2qsFSugzsX/RjTamROgLol+el
	 Z8CPhh9uqPSr+/T01TKvVOa7Hju8skNhEcWKMifu3lm1se8WON8N0y+BXy2YOjdOEaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pCJe5MDA;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF2606A328;
	Wed,  4 Nov 2026 08:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DFF2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pCJe5MDA
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48j3Tu2664578;
	Wed, 4 Nov 2026 08:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rMQ9ivpPC+eYfH05XZvd5us0dsMxs+C8hqULavuLw
	+A=; b=pCJe5MDAXNwLsH7tJIKgOAue4mX3Y4eOr9dD1f2FHR1NDU9acf2VgNfHU
	GRGN3DCO5D5ZlEJLbBaUYKR4FxEYflq1/eO7PH+tOed1aqc/cyMlE5WWCaAOSr6I
	NCm5z4j8IJey0H0nstdutn7yoOnz2/9AK6WfcACOQjkaTqwiuUP8GGg804jaIcEs
	o27YUCuU0iZ8e6felbreB0F3fs9zmwi1AapFALDAL8Z66k63/GtWxnrRQ04Sc/UB
	obczUsYDvLyKsjDKRxRzPk/QHu+YZuRHBAIJDIPCAPT1KHrLg5ROJlNlk+qQ2u7o
	Efa+7jjk7YIuKMzIMovv2e/+N2jug==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80sttx9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:56:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48Jt5X3779821;
	Wed, 4 Nov 2026 08:56:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqcrcda87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:56:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A48u68642009014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 08:56:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D9B42004E;
	Wed,  4 Nov 2026 08:56:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C5F02004B;
	Wed,  4 Nov 2026 08:56:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  4 Nov 2026 08:56:06 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id E56BB160E2C; Wed, 04 Nov 2026 09:56:05 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH net-next] MAINTAINERS: Add Hidayath as net/iucv maintainer
Date: Wed,  4 Nov 2026 09:56:05 +0100
Message-ID: <20261104085605.2040729-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: xcBPiexbBR8YK9Guig7h2QWi77xLSr4X
X-Proofpoint-ORIG-GUID: shkmZdV_Q4Shn9hctiQmjQNWGzlOELQq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX8tDffGo2UTL+
 HhriY+MKNuM/dSLWOTu1GeFFQIehK5GSgrtTlKg/Y6nNdNByTsin8kRI1fWMPvbokUzLQfEtKhz
 8LkUjlseb084W7LqDdqWKmB2Kklha+vKtgqpDXg/zYzlbkSopEzxF0dJtsshFfr/WlA817EwR8h
 kLIH1DtJmoqKAN1On2VMdJEegoOBe28bPei6qaOsTwe9fxNK6LXcIpzgrh/JdBKGKeG2SBWM6KJ
 XUfYL4RWnr2lpClBr9YG1cFlREFP5+aaScc3RWSGkIohiiEyg7UKZF6f7dEe/TCH/9DkxTJg2Xf
 Ak/7CG5YBQk57L5NELOSd3EQIOYhGFaE8Z2ZGjKcCKnMwPnJKPnbxM9n7rmov4rhKX0Uu416V8S
 sZtOYyRgdqoT6+Eu0IFxf7jJPgXSK+aTOhHDXQT1ExrOj7CueNITPooAVhzSOv6k8acInyr9XeV
 imP92/p4sNe+eju9nfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX1Zew4mRSKeN7
 T5x6zKFd5hzZVAb644ZK7qqnuBcI1a1bXMbDM4It50Uad9nDGM0xBGlNJRQokVo3SEUvuaBrDVl
 Tx+/CEU6rrcyN3/DgH6S0wBbAe9DJHQ=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aeaf32b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=z1mcxeMOiUYAy7at5kUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040034

Hidayath Khan takes over maintership of s390's iucv transport mechanism a=
nd
af_iucv sockets from Thorsten Winkler.

Thank you for your support Thorsten, and thank you Hidayath for taking on
this task.

Acked-by: Hidayath Khan <hidayath@linux.ibm.com>
Acked-by: Thorsten Winkler <twinkler@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09713dc4c6a7..e15ed4a004a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24680,7 +24680,7 @@ F:	drivers/iommu/s390-iommu.c
=20
 S390 IUCV NETWORK LAYER
 M:	Alexandra Winter <wintera@linux.ibm.com>
-M:	Thorsten Winkler <twinkler@linux.ibm.com>
+M:	Hidayath Khan <hidayath@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Supported
--=20
2.53.0

