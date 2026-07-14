Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814246AF05;
	Tue, 14 Jul 2026 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034257; cv=none; b=lSjDI3gmX7tdOFt0a7JSFKOFAb9e7RqUZ9W8mrZKviucd8ix/MsqSFXFKc47JsTW9K+I+i+YNQIXKeRq6ehACY+MmK5EFWLF7ELXuOFD9/1yUSUdR7in0Q8u1r/Ek5W5v9lg1F7OfuovDFwFmDm26z2wRYypfv7iJhX72rToDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034257; c=relaxed/simple;
	bh=u6Y4cZi6tzUrGstUrSdbyH2IwuPZh3HQWfr0VcpVZ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYzz8fz6COXSh9bD6kYC+hcAPxT5QR2vrSeAphtxE870PxVWdiEwYeiDo0LXBS1dd6DZE3cuFerWOlnrizEX1W3Lzc9teGTAS5lCZvhaOGLK7p3HYyZ9TQUkZMe4cV/AMbE1xuJZIQ/jPUqbhkmGc8kyGTza9gCOWoVR7Ve6LuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G05lOHnz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G05lOHnz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBg0Hr1195053;
	Tue, 14 Jul 2026 13:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cHjbBjagGNXJRbi52
	imbwuO2vVnHqFzUUUIrp5kwSlk=; b=G05lOHnzKb9sdvFxQFhcBy0FewIButqar
	HmZHT9JAgimjLFwibsa9FEJzeT4cg9p0EE8LS+VU3Ww1ZXb0hyLf9EE0dIz/iEul
	Lu2dCFEsQ9uIVn8p634lZOM/310HpCj3Z+wEM9DbcjWu7N3A7AHMzZi3bOuh9MuR
	rKFpFFOlv7MpAg7JbcvEVdUVHi9Nf8kN7kC8/9A3VUP7qwpIH9swxMNKfP9oY8EM
	IOpsNi/w3obAWMlnhb9dhI/zMx9+IVsZfVONJviJB7Y/RyVK6Z83D6T/QKgq2IBR
	E6TYqXWj/l7Yo2Kg7i+cYWjVvmasPBnDR9PVKGtVuciPGLdiHTDAA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbnt5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 13:04:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ECnfU4012006;
	Tue, 14 Jul 2026 13:04:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgantk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 13:04:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ED44Gb49479984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 13:04:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D1FA20063;
	Tue, 14 Jul 2026 13:04:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 532D720043;
	Tue, 14 Jul 2026 13:04:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 13:04:04 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 3AEA3162605; Tue, 14 Jul 2026 15:04:04 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 2/2] ptp: ptp_s390: Add missing facility check
Date: Tue, 14 Jul 2026 15:03:42 +0200
Message-ID: <20260714130342.1971700-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714130342.1971700-1-svens@linux.ibm.com>
References: <20260714130342.1971700-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a5633c9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=QjX40KQ7ckxDZ_rv0CQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfX9SaK97QAH6Xm
 AdWfAWW6k3rSi1OErN8OjxueiojAfZ0dGGzOXwGmHlwqpaOn8wCj9qsHqik0JnUUBsesmsxIB+a
 2Vi5BuCgniaXmx67VIBd4tDgsdbOveFUSaKXZ+bk3gNPHaLaT5L2bbfkIEP3miPMYMMgPzXeBKH
 1tWqol+qIGfjkAQbeBaKu4YEd8/Q7oki/Ifo3B/Lnuz5kyG+id3asRFx5k2zPrHZWSg7/6heEn5
 bW/5JJCJu/Yvb8l5oWu465C5b9d95UelqqzRGvcLQUEPm76dqV/pTkN5PwB1mHfWTng93bmuAs+
 lSvni47fZr8Minc0l5Bg+sgT8ss5ryYI5onNFaLJNBOThnQdb1zB+64UW0YM3mmJO92Tdc3ZJ8l
 NblIw8wSqtf1tzU/TBVd8mmA975VKF4cjZw6rGNU6VrASdwLBoGyKBseBa2IfJw1hhWaa7fYYYL
 QPSDmKB8EPnFyX97bbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfX2J7OYxh8osWr
 +BqfC0Djeqm8blxijUIB5q8rvrZTvpcPOUqaLjxwosCaOnjfFJkuiPgwvQPy32B3o9al8Kzj73c
 H9yrxMCd821Gbh3zCR7ePh0TC5cakmI=
X-Proofpoint-GUID: OFjLOZJ4ceWp2H49yGxilT2FpSCLnUMP
X-Proofpoint-ORIG-GUID: LY2LUNy6qIyRtiM9ab_9ugjXcmIGi807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140132

Only register the physical clock when facility 28 is installed
and PTFF QAF returns that PTFF QPT is available.

Fixes: 2d7de7a3010d ("s390/time: Add PtP driver")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Cc: stable@kernel.org
---
 drivers/ptp/ptp_s390.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_s390.c b/drivers/ptp/ptp_s390.c
index 29618eb9bf44..02d624d89a0a 100644
--- a/drivers/ptp/ptp_s390.c
+++ b/drivers/ptp/ptp_s390.c
@@ -107,6 +107,9 @@ static __init int ptp_s390_init(void)
 	if (IS_ERR(ptp_stcke_clock))
 		return PTR_ERR(ptp_stcke_clock);
=20
+	if (!test_facility(28) || !ptff_query(PTFF_QPT))
+		return 0;
+
 	ptp_qpt_clock =3D ptp_clock_register(&ptp_s390_qpt_info, NULL);
 	if (IS_ERR(ptp_qpt_clock)) {
 		ptp_clock_unregister(ptp_stcke_clock);
@@ -117,7 +120,8 @@ static __init int ptp_s390_init(void)
=20
 static __exit void ptp_s390_exit(void)
 {
-	ptp_clock_unregister(ptp_qpt_clock);
+	if (ptp_qpt_clock)
+		ptp_clock_unregister(ptp_qpt_clock);
 	ptp_clock_unregister(ptp_stcke_clock);
 }
=20
--=20
2.55.0

