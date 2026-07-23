Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A22C0268
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818846; cv=none; b=m3T89T5Q1zPJvf722yAXJPP6VTuahIQqYyrd/GkJvmZlgFXXIngaq7rJRAjMsTt1H7rQMCgHnILhqpoKhFXgnTnIUmvfj052Ym5Sp6IkRO0zOiaJs5lXoXvxLsmSvPZXh3Xh+xlcHo5F5E24YdcoVmKWVKNuKoLz6UDW5RKDE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818846; c=relaxed/simple;
	bh=90Aw07Lr8u2yo00BgsoDtjFtLJbKkh1A7DZeElqmtHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQETtSA57Yx/MWYH3H8EiCaIa2W7hEHfGo7MFPN5YlwaDgCrAK5GZnm31LhSjT++CGOjGbUihnrbagVCmzkuoXnCqA+yHCbTWjRkN0n7WVqG5R8K0VPXX1VCHaUULpTpJEimV1OSVjEnycROwK/zF4ULejYEGJGzqsMXEklwelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gox7HygW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gox7HygW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBulm3095090
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rZKYq6kipa5wb1/ya+Ejatuvi97Mt/dAZzPo1nLv1
	to=; b=gox7HygWs+TQvNbGPnjg+gu81CKJy6j0+lIdnNvxDxO/TAVXeCXez7ZPX
	k7W3lBP8sqHhpG69KFkM0PDSghv7RL6JwXOktbmzCRxYXXJ8cgDPpCI3xCywi3MT
	4ST0+ddtb/Dztad9FefBmKEFuH0Fkn+SG2wC+HoRdlx/ALLIhWKCDbxLpgiBj0t5
	qUgNSNEsocw2uSjBBH9qy985GXTOComZaK13uzbVqgP/50oChEAOQ/M0ryI3Ukw2
	1HCuBronQrM9ieyc7CHdq+V8a6xS+OMDrAo5CRtOW+gDBEIXELFftIQreN7ne6oF
	Vi84ImlutCEAPLIa5jLFpANAWbFFw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahfjh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:00:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NEngPU021067
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:00:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk4qe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:00:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NF0dto33751480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 15:00:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FE0720065;
	Thu, 23 Jul 2026 15:00:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03F2F2006A;
	Thu, 23 Jul 2026 15:00:39 +0000 (GMT)
Received: from ibm.com (unknown [9.224.64.167])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 15:00:38 +0000 (GMT)
From: Finn Callies <fcallies@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, fcallies@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH v1 0/1] Fix the length of the qd field of the TAPQ response
Date: Thu, 23 Jul 2026 17:00:37 +0200
Message-ID: <20260723150038.93617-1-fcallies@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lDPH22Ygex2LP_Qc4cND5VIT6P5WJVax
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0NSBTYWx0ZWRfX0NM2OynetQUU
 c0cuYahmq1EgaiS3KZr/u1NoRxHBGFbnE22z5dfe//qtn0ULFpnJxmGOfQYK/gIDuEqeUdG7oOf
 CwxHugOtV3pP7/A9KkpI0fJUASJhwFRgphrl1JldaqPJbmyM/8zGML1kcI6HhmNUNYuGD6fw/oM
 wu5tCt7q6ZjLFGJuOmBzuArulJU1cCNneVbjHGezxepj+eJT57XxTWmhBI4/kImR4OieDG7r+zB
 WefLS2QG0/eswUhhCiiEZFtKL45+NeVPFqTgRL+aKNDD1OUtwm0Ifw3RRzfehf3tErM+IAqqCBh
 +dpvdKuv6UsChXbewEaV+9aeJLHMeqGh2GIzVPrAzUfvyxJ0l0sxTgj96hgY7FpRpkD8Bkv1+AH
 Ez24OFxrlT/MV2JPP2EPiqlk4AVjHzgKR0Vh9L7Ab4mKujucboK86Wq16lIvwTZWyW1DuShZjNB
 YdfOk/dbfFWFUXmTkiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0NSBTYWx0ZWRfX+SxE1Udy3Q7A
 yHvNDsq38aYQvKnj3ELddTx28Ov00a7zt8Pye3gKSU8U5Zoyibu0aKFzlwbqdzBAlPmO4nGgdR1
 7TzMdb1vrWGrgkc/upEN8kqZ5b4zYuY=
X-Proofpoint-GUID: lDPH22Ygex2LP_Qc4cND5VIT6P5WJVax
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a622c9b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=cxeqTIfnZHFz3sRM:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=tvZ2WQ1Ha0vXV3piIuEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230145

====== CHANGELOG ======

v1:
    - initial version
    - review from Harald

Finn Callies (1):
  s390/ap: Fix queue depth field length

 arch/s390/include/asm/ap.h   | 4 ++--
 drivers/s390/crypto/ap_bus.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Finn Callies <fcallies@linux.ibm.com>
Linux on Z - crypto

