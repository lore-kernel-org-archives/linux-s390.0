Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C14402BB3
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888038; cv=none; b=DeWIoTo+5LpCZU7YhqHHo5qfJgM38lbXU46DWTvOZjzuPUEzVrVDxXT6ZRVZGg0oFmNKzdevP9TogkIZNEOhCZ82rVAjs79tWU8rtoaieEvF11qYN+6OfdReD+HfiCjRmXa+/fBCyKr0uF6D+R3Dma0z8oQbr/ktf8zziHqnnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888038; c=relaxed/simple;
	bh=Q/RMiF2UwUgL5p5LS+FLyDqZJM6UfHyENm8XD/4bZn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TY1wFcsLxh6glruHE4eE0ytnzmunZxceHs/Ir1h7nMp87tG1kl8J9l0gWulpaVqgO1nRuVwN9G1c0bZL3/QRx8vHXIUDjy9iaBTT5Q7RWmC3ZtRgQ4CyAX5Bcj9FCq6ZFK/zreBcAJTwYUNEFCSYyBKzdM5oZOqtaLLhYtxtFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LU7Bf7/v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LU7Bf7/v"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADFLD3851277
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WOegtqEnustok7WG2g7+S3XNB7gcKNYV5n/WIlZUC
	1s=; b=LU7Bf7/vHB1QZYhvthyxJ199faawbS6QBVac2ZVSrIYgkLF1Ehj3FCdl/
	WQlltM9pvWmiTgAADKGjfJIxxjFXh2o7Fa9Jj6NBwqAig5vOHdRSnKA0M0nesu+b
	FcH3RjItZVcQZUkVnp1g2UiTGxkK6Hhe6ZiZeJkfieqDqoy+9PWhMhnBJBNEJGj9
	GxQpwXVraji7B30tsLDI1llsYRlTKmvtzXReqfjgfK0ULgnSQmA3AsbYm4DkmuKU
	5rxgWOowoRKq/+8esCGln69DsMUkfLnnVFas8NwbI+69WaJG/HxA4jsdI5DQmaYj
	O+vKsxDWmT5K1RcH8hhiWvVsuNO3A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77av5a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OA4Zuf019354
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyr5f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OADpnm32637196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 10:13:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 114B020257;
	Fri, 24 Jul 2026 09:51:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E531720256;
	Fri, 24 Jul 2026 09:51:25 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.143.218])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 09:51:25 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 0/2] Improve code in zcrypt msg type 6 handling
Date: Fri, 24 Jul 2026 11:51:26 +0200
Message-ID: <20260724095128.140810-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uLGZjp8yuxBrF6WnRqOBdPfAdVU6Nos-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX4X5NHvnJ4sG4
 wCG7hc+qi6hdaojVld2XtOHzPlZqo4iNLQwgf6GX81U/BhhkUEadL+89+jQZFpI/TPaikn+FuBt
 LsFFWJ5CnnFt2fdRQ2hpnNvctioo3Z0=
X-Proofpoint-GUID: uLGZjp8yuxBrF6WnRqOBdPfAdVU6Nos-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX4vx6DDriaBUM
 Rrs4202WJ96fLpSj/k0jKfJQ/9pO7zj8I1bqKVFRG7Zj6gW3vcuoN7vhXM6mYyjmV3goMiE0Tan
 I9q9opPZbGnf2cAOQUI9PMgbOJEFmQFRUKXeTk529ATJNVFfGruTgseeD4+osYQT5lpZob8Ok/E
 oxRYT51IS9Uh5u06pMp9g2tZ/uhrA9o9uYj3iMqpsx9Jk1g63Kaar7IboGBI+Y+BDDSP5M4qItP
 jcPC6ogPw3dUGMtVTyiNciUxyazrlzFmiRwEYG28UIiKq3bJNDmTbAiQa9zIgM3ODgE6cxLgoCW
 Ujewh8ewFIhIrZeooieKztVr9oWW2W4F20fq2Z9ne/WE712PA6pQydkmhHeqmQvAEkBtd+z6jJe
 JfxokdeHTjlnrR9tnWNkRNT82jHvWk/wLEgd9n30u+P96r5JLkkfYHg6U4nrHGZ+kUKlyUVyd7d
 FzDxjsd+h8VH+jEESlQ==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a633ae4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=lBdAcpDw1wAZ-li3s1EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240093

Changelog:

v1: initial version, one patch dealing with overflow checks around
    the use of the CEIL4 macro in zcrypt_msgtype6.c
v2: Sashiko found a regression: The check
      if (ap_msg->len > ap_msg->bufsize)
    was missing in the rework. Added again this important check.
v3: - Split into two patches  - one for CCA one for EP11
    - rework upper limit/overflow check 
    - add lower limit check

Harald Freudenberger (2):
  s390/zcrypt: Improve CCA CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB length and overflow checks

 drivers/s390/crypto/zcrypt_msgtype6.c | 94 ++++++++++++++-------------
 1 file changed, 48 insertions(+), 46 deletions(-)

-- 
2.43.0

