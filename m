Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B919492180;
	Wed, 22 Jul 2026 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710645; cv=none; b=Z0xwLrb16LBKgA7PeZf8apBPXCeyrAlu0Ru5IncdhYER+Qg7gpx6EWlaJ1/IX5S2FaopYRXYMXJnfwdq0BGQ9x/1XD2BTFB5lyZ0wjjTWNkmy+wneG+ZQYEGHpALEqOkFWe/GiFsY/Qnu49aC1TcT52PyyZuUg7J7mdMWz57Wvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710645; c=relaxed/simple;
	bh=5O/wOOZP/mT5aWbcMohoidEAHzl+0OLlwruGREpObp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sw0j4zinUe2lI1noYtkXY9foahEOg1v4r2a4V7mbF2jvWbcX08K3tqxdKv+dw2JHy3ZyYrGzKKeX0BOtAyQ8znBkXLEL5P5WA52QK3m5W40938dqw2RyYGqLgZTqy1Rfl2l2IjoXXsKxdqPJzI1ml2TxcudZRFN8j5vOgq3uHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VnrzgWyQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VnrzgWyQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M5Bd7r1270782;
	Wed, 22 Jul 2026 08:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=u7SORX/O6RnKgikCVx7tUxocjd9ra1oLpsw0ysUxg
	GY=; b=VnrzgWyQMldClojI/imS5FLCQBsDsU05VhcxJ2qN2XG/fQzgyhToShDvx
	OTix5QCZEFg/XagYpBSgLn8IlSMVZrONudEnfNQMIdFeW7IDUUQa/AmysPKylOhK
	QLcXgZ6hjyoQAW8drLc4smLfcTs+4bd35Sc/SBJxFEMkItZhYb4Q/O4WfB601QNl
	BoAzTiXFqyB50Y47GyFkEhTVYHn3I0Qs0OokmGwh7swSthaXKQCHK5ar8okla3xh
	ekgJi/TBNKtV9JpHNCIIyGLJcVpsjcakLTvSd5KMvnv2P7KbWoXesW7576OrsQ0O
	AYKn8CSZsQUBRNJ5ExKM7xJMI5cbQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77ah73c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 08:57:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66M8nk8V020473;
	Wed, 22 Jul 2026 08:57:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgye88m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 08:57:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66M8v8Rb31654290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 08:57:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02A202009F;
	Wed, 22 Jul 2026 08:57:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 858C3200A3;
	Wed, 22 Jul 2026 08:57:07 +0000 (GMT)
Received: from dhcp-9-224-66-107.ehn-de.ibm.com (unknown [9.224.66.107])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 08:57:07 +0000 (GMT)
From: Wenjia Zhang <wenjia@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>, aswin@linux.ibm.com,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next] MAINTAINERS: Update SHARED MEMORY COMMUNICATIONS (SMC) maintainer entries
Date: Wed, 22 Jul 2026 10:57:05 +0200
Message-ID: <20260722085705.56755-1-wenjia@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: IBGwD4MMRaOTAsnleDzAvHFb_uD5rQfT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA4MSBTYWx0ZWRfX5w43Wywvzqpt
 e9UozM7yLHQeOF/EOxqbrc+ytXkqZx3sLJuf1jn5Jv/Uj9/KYhvflcXeveGsHCyurZoDK3wyKU1
 AOfH4LMA0bsWp0Cov65QXU+KdyURPLw=
X-Proofpoint-GUID: NzFx8Xv1Cs3NGbpKCdY7vSeV_UcdvS15
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA4MSBTYWx0ZWRfXy3chUbF4EJFv
 CBPgRfjKAFfE/BPtebfNOcc4DwH9JDyJ6PreRome2T0AzdrXXF53BZmYMS/VIYNGZ5S/PVBPQFp
 oySbt60J21HuyIDe/Fo2UUj0TEI5liJjaQC1ryL+uv07AQdhlcIHIhEjDRwr0zLLttYXV9qh2CA
 +KftdCpI5/F63IeF1pk7Tdosuwarj/YDQfWTVCyPhdLn7aGfzVseRHrSr/80t1K8xyBZIrnRF2H
 jXOkkU3EVX6pUWWrFNB99VIowGmnLMFOVlTn0zsrYScdb2von3p/Xs/hD6o9jEgtRjms65tmCEM
 zUlWf5y/J16aXQS/HROFylLERNhhb+/sl8BMNPr2S9BEjDvsXXQGn50k0Qvry5wZGp+crYcUsed
 /SibXT0X5neI8tJbCUKYeZQZdFGw+YDhBTi7U/SKOVo/6hz1aTY8SJ7bB2ADDWrjIyWUyGZMqR/
 XEa/xk1EsGrm3HaFZ9w==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a6085e9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8
 a=R2opemQ909qh3vjeI2QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220081

Due to a change in responsibilities, I can no longer serve as an SMC
maintainer and need to be removed from the MAINTAINERS list.

To reflect these organizational changes, promote Mahanta Jambigi
<mjambigi@linux.ibm.com> from reviewer to maintainer.

Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 Kernels.code-workspace | 1 +
 MAINTAINERS            | 3 +--
 file                   | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 create mode 100644 Kernels.code-workspace
 create mode 100644 file

diff --git a/Kernels.code-workspace b/Kernels.code-workspace
new file mode 100644
index 000000000000..9e26dfeeb6e6
--- /dev/null
+++ b/Kernels.code-workspace
@@ -0,0 +1 @@
+{}
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab8736850ea..f60ccc62e710 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24631,8 +24631,7 @@ SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
 M:	D. Wythe <alibuda@linux.alibaba.com>
 M:	Dust Li <dust.li@linux.alibaba.com>
 M:	Sidraya Jayagond <sidraya@linux.ibm.com>
-M:	Wenjia Zhang <wenjia@linux.ibm.com>
-R:	Mahanta Jambigi <mjambigi@linux.ibm.com>
+M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
 R:	Tony Lu <tonylu@linux.alibaba.com>
 R:	Wen Gu <guwen@linux.alibaba.com>
 L:	linux-rdma@vger.kernel.org
diff --git a/file b/file
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.50.1 (Apple Git-155)

