Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AA37DEA9
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733633; cv=none; b=it9N7VouMrHIOWeTd6FQolYWnsit42OvcjAEv76oo4Z3GhqVUBuTV9yjjVb+/v8mKeJG3tGb7qCgTeTs1cwLPrbwcGJPZbbxDqvCZvQNere0KsvBnJwiTUlDcmnvLwYMS56WJ6lnoz3GPMuiekkwoyOVWrUnUta7lsTO9wE9Rk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733633; c=relaxed/simple;
	bh=IW1PRG/OJBe7P47Yy8Sq0Tw+jy15wbl8wdTsbNdE4MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSNNF+QOkhsM0kM7JUbazDfTwvCHSVKZqnV8dTQ3MCYi5N24RAlVFoMQd9WKeq7gwCr5btT7AkBPegwQUp72Kq8QAnQmkAK4y/tB+sOqo1SCRF/ggwFwLeoRq7gaRSktKRHDsnl70Cc/+RvIJ9s4fC+7HZ/4z5XdhurcvPW5w+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yr2wU3t7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yr2wU3t7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDfbef086180
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ppVvTfWjEvJbn3xIBel+t5LrUpmLivwUv7LLAk6kN
	A0=; b=Yr2wU3t7uB5Bwe87Ig/CDQpjMU24IF87TfelJ8TTxRpxGsPJL3zPbK3mL
	+geOy9AOLX8edog4LuPZUxhqsurKrUBGj4XpNtgrjXVLD1rCW9O0UhHSTSYJqCgN
	OD8ZKEAyqkqGy8J6Wpqk6VOlcqopt/jUjRk/YWCpN+kn7+Z/plYVBelwS5pYDdbk
	VqI7t9fcF7XeYv8BClXJhfrDTX8A2or03yKFow/sWU9pvgibB9FtW0gSNVsqVw3R
	7HDrwcJsBxKOALNJIuZm6zcfqczPp9ZX8S+nRLNOVKUQTmpt1Rj8KSCOzQveIYHa
	bz+ASJIztQZd3LCH9DRbY7h+4rOVQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abjx2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:20:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MFJm8S027825
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:20:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjyw64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:20:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MFKOTC60817766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 15:20:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BED5720228;
	Wed, 22 Jul 2026 15:20:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3EC120225;
	Wed, 22 Jul 2026 15:20:24 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.200.113])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 15:20:24 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v2 0/1] Close speculative mem read possibility
Date: Wed, 22 Jul 2026 17:20:24 +0200
Message-ID: <20260722152025.119391-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfXyJmgrC0NdLFj
 TdFlHrimpUMR6pM4Mh+BqnyRWN4mTND1/zPEiInHY4PJlWsJEx+iYb7/QGVeAY1rNBI7810i1XB
 gtLsn4Lm+94wWvLgwuXMDN7z4BzbokJnvAj+aFCteoSNo7ZQdGehfrDd4bG3tJyn9/BM3i+ea3V
 zEXMNMijNZAZdCxWD/PfOzrhb/Y9AzKfNngSWT0I2CO9zwV5wxSN9lBuubeHlEqXKX75dnU1rpF
 fkI/mcTzv49O98aa3E0B39oxhvL+ntQ2+g8cO+Cb+MTr39wedfRtuX7ZXZf81KU+Ui2o8GQ0/7S
 nR070AhKoIx19znS1Zf9kNOCg+HWQ70TTy+z14NIqtprjihqYXNZYFtlRE7R5+PBvJC151RMFSl
 ne0TbsZLsbj5d9BMFOVFvX7nDWcpdC1m+7YxhTf1x/GumYTlWhg7hTDosjfunX1r2D4+aF6bKxX
 JTun2S5lGzOcAgX54sg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a60dfbe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=bWcQ5X8g7MqgCo-7lkoA:9 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: fvq4Bb4sXfZtm6nTFzLQBldeKYXlqD1H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX1+R0G4e8PuPc
 1dNqiZFzq6ChuPZRkuVQ14VILpRhQLDGm0NhnUSVvgAnRnXXOJuAEP+IlTAfNu/YkKsOMUDLzCC
 9pJvBb3zOlENxlJKsDHdD8PgYC77Lak=
X-Proofpoint-GUID: fvq4Bb4sXfZtm6nTFzLQBldeKYXlqD1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220149

The domain value is extracted from a given CCA or EP11 ioctl struct
when a CPRB is about to be sent. Thus this is a user controlled value.
Under some special conditions (custom device node used, administrative
load) this value is used as an array index after bounds checking, but
without speculation barrier.

Add the missing array_index_nospec() call to prevent speculative
execution where this domain value is used.

Changelog:
v1: initial version
v2: Rephrased patch header text, added Finn's Reviewed-by, no code changes.

Harald Freudenberger (1):
  s390/zcrypt: Close speculative mem read possibility

 drivers/s390/crypto/zcrypt_api.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.43.0

