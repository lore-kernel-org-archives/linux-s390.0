Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A14C77B1
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862866; cv=none; b=CY3jm0EqSA0PdF84JhTgvS400hGxY4ZaIiPS1Dc3XAm+Z/HUviJ6ps9XKPB5urON9gBwEeECv/Pvosxfybct5b2gzxoNE74lmagOh0NXUvD+dcv79s9vLUkCpu5QNCOrnuuk+/MaHiU+P1BW94sPPHkGOfS/vU/JTz2cHH8FJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862866; c=relaxed/simple;
	bh=PKm6yMQn9ytGBUMxB8VlM8Kv8Fne4+TyDtMfAFjxZ1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mllVwtsww0KxLzPXptAPywalLKqrUO7r6U3NY21nsZzdZEuRcLa2RU7+BbjSeyN4kwSDL1vAR6zxdDcic86UfP7xNgvDji/ys3ATvYLBQZPCfXLT5VNEtGR7F3150HNeREknjydR2kTWmqva5J0mv+WjoEeiFoA0Hjx7hMEo60E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pf9s1DF2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pf9s1DF2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886VZc7065733
	for <linux-s390@vger.kernel.org>; Tue, 8 Sep 2026 10:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Sz3W7sf+t5rsDXBC1rSvK+V2Q18Bd7lQwAIg3wA1r
	jA=; b=pf9s1DF2VqpAjzGfgrkKilp29WVjNIspybPJE7ya/Hdxpqn7aFeEp74cS
	AD4WalxlzMyT25hW/7o1AbFf3yG8kLV16MpXlxDhXcn+yqiWB08oAemq2oJ+9k5P
	8zizZIcSXI1HViE1hCTmxIIMH6/47uOZa/+LEXLJbHwrzEkC7EEceIIts88U12Hm
	G9B2NixbIlfVi16rDWnxTuOBLTj1SX7ksyHhY619ExGa4qB2ofIxLMXxbKlW9VTe
	szuP++oTbzkAkSIpE7jDX4MsMfSpj3jmvnMoacKKmG6lXT0HlmbEOKwfjQZSwWBe
	8+QuLDQiRlf1GFm+Ag2OPwNqxqAoA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf3x60b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 10:21:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688ACv4U003570
	for <linux-s390@vger.kernel.org>; Tue, 8 Sep 2026 10:21:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqbajj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 10:21:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688AKwbx45679054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 10:20:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4889F2004D;
	Tue,  8 Sep 2026 10:20:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26CB12004B;
	Tue,  8 Sep 2026 10:20:58 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.138.252])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 10:20:58 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 0/1] Fix and improve zcrypt reply message checks
Date: Tue,  8 Sep 2026 12:20:56 +0200
Message-ID: <20260908102058.14329-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _qfHAX1HAdcw9RTyagt0PxJTYjJ4EdJn
X-Proofpoint-GUID: _qfHAX1HAdcw9RTyagt0PxJTYjJ4EdJn
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6a9fe18f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=BMAjGlgp6OJUh1CPVxgA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwNiBTYWx0ZWRfX4LGbIvbqtupt
 uFLUaEBkyFMkwPIQxMCuIlthvzqzXrzbwfjLAAQctPdkDCtHI4PBm+1G+cr0uiOWl6gY/w2dBdK
 78P5O4dbN9xNtGsTuNi6J66clMaRWZsa1/oRGAi8lziGIZn1XptrogPR0rBGCnBfiZsS61/Z/NU
 KL4nLxE+T9rkTkqXcfPjzyAMQoftDmJrg90le+fvTN08LjR/jTmGOgUNFtsZYx7EsrKB8TtAtQv
 U4bKegY9pCQaTnWnAcqe/+OjAdgSJte/bg8dy+iv4qExhn2noGW+6BXDzF6grfWN+yMaXtYdykB
 V4PyfZS6y8YiLiu+NoTc7tZNE1tL3UBOvDrjnvVzXJzNAkqJW+hE0f0+Hot7K02re04MLLGCaOa
 MgvBOzPIQNxSKb8VfxffNBVZ22+AF6FE0PZiO9Kp0hujIMpdtt1tAKzkx5Mxn9b4932XxWKa401
 dcPWqjOf+juN6+p4VIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwNiBTYWx0ZWRfX925cSL4vEVgj
 u1loHcZeCU+RzzsKBVjReC0EB/87foSzofjQfh0F0+6nziwAyY0xtvFolC+P3ZYZj7mMfRDoQPm
 SXhbLwDBaLg1ONbwlfwzrF2+PSpzzT0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080106

Fix and improve zcrypt reply messages of type 6 - CCA and EP11 - and
type 50 - ICA.

Harald Freudenberger (1):
  s390/zcrypt: Fix and improve zcrypt reply message verification checks

 drivers/s390/crypto/zcrypt_msgtype50.c |  40 ++++--
 drivers/s390/crypto/zcrypt_msgtype6.c  | 162 +++++++++++++++++--------
 2 files changed, 138 insertions(+), 64 deletions(-)

--
2.43.0

