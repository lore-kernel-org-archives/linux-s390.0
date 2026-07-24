Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F91F26B755
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901711; cv=none; b=b0ThlS3GYGp2ILIYnTw2KRkkq4A38yBqLWy14JNTXP2Yw9KQNtDL42HSxFa4utdEtkPu3mX2dFY5/XaLDP5RiDkVwmkOpFgfDWoAc5an2TGmyvnnA4FojymiGbDpzbJVpmNHbJGMFGfjAbrsF0WZUajUsEpleD7bZV1q67qsjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901711; c=relaxed/simple;
	bh=vguoY86fY43DbZoetq6olYkd3fhk24W3u6rQ18hMa0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBC82yTNtljPzlAmlTcZZSva0VvMqMScLqHejpvu2Ojm7BTPb/IA8afdvqPVQzXhZUn04LkSIn3FBU0R6Q5yitAxTZa/KbD4z9+M5cKPzJxYvN3sYn6PY0z5A1SW56HS5BaBbVvLqXWBqYl7BELA4irKoE88vUj5NtKpvkv90Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=np22/RIU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="np22/RIU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODgBOD1899465
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Aj74ykb+jO52SvfuMqg+QFI78J9CeAkI41rq3cFXB
	6Q=; b=np22/RIUEOYHxbEOjKIvg6fYeVzlw1VPc7faeosbk1oo1SvrnOGjwTrQk
	rb3lJ8ZClnaQmFdio0sGFO9wzLUJk5yeJcbifPZGr3Agb61KcAI3LfzvIDIHSnC7
	4dpp/zsspIS4Tk8ZkvSxoxSf5u8FDlQ4gZV/6kRdLvYs3zDVOPc8wprxSXjAntTr
	/odbQIA5ziUpjanj5pzuFnuQfmAWNbNBBcADHqgwXevG7HDd9l7zBe27P72f4Nvl
	zo1wG8QoZ4qvJWguYd+D7LlQpuvp6F+10IrTg/YjrFVFQHk99x2HBYjmVI28GMWq
	fQ/bINkl6spsVa2Twy9yfLAUl36cg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kmd4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ODnwvP027460
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wh90p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OE1ilr44499310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:01:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1E1B20182;
	Fri, 24 Jul 2026 13:45:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC4A620177;
	Fri, 24 Jul 2026 13:45:53 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.143.218])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 13:45:53 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 0/2] Improve code in zcrypt msg type 6 handling
Date: Fri, 24 Jul 2026 15:45:54 +0200
Message-ID: <20260724134556.144597-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a63704c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=3TONbTXcJe2WL8_750YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX/t5MtnmmhH2w
 V5u4M0RY57NbVvb9Mt+yDcVa1vu8gHwRvJBZIeqMU7p/inO27CeyHcFBnuPl8vqFiU7QKjn9isA
 2xWk8Mjs893dykILxj0OkaiK6BHu4u3DckDkpKosJAQBxM1/IElA8ogcXky8LudPjL/tLVtua0+
 5XYU+gUT86DMLlSRrdrKqY0Iju6ts70MWAPMHh6AQ1CmsUuHjEv57ZMptLhgsVJpJQsqYmZzlop
 yNEp0Uu+n2q5iBXVs8pir4hWfs6418yOfAWwjUZOxtwCguJ22o+RcoK7mIi33rlBRJ6QPQXAmgB
 AWKvvOXVRUMESWWgOyiMu6nLXFOPUltoYSRYzwLYtdb++A4p1fbxsGQQ+u8WYmGAxoYBdPm5J6O
 hHIpbnrnMkjkMBk6B6jGJe1tV0d9SxMQGypTgI+rjXq2YRZYBgivgC/wybYt3SMGhMr/7aX82pT
 nIu5RrFW20ObOjbBxyA==
X-Proofpoint-ORIG-GUID: fN6Y0ITnp03vXWnMC77XfjWlDNcuDZPD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfXxoHfSpnkOdtR
 EwzOcNysbgMdkTRhzViCxMgel/p7PHC7qF5Ju5rSVgk9aFzZIuxWOAm5e9IEWxQJK3Ael064qcV
 RgzTFfWIXudu88dr0BwRsmbHDpfEEvY=
X-Proofpoint-GUID: fN6Y0ITnp03vXWnMC77XfjWlDNcuDZPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240124

Rework the limit and overflow checks in the both functions
xcrb_msg_to_type6_ep11cprb_msgx() and xcrb_msg_to_type6cprb_msgx().

Changelog:

v1: initial version, one patch dealing with overflow checks around
    the use of the CEIL4 macro in zcrypt_msgtype6.c
v2: Sashiko found a regression: The check
      if (ap_msg->len > ap_msg->bufsize)
    was missing in the rework. Added again this important check.
v3: - Split into two patches  - one for CCA one for EP11
    - rework upper limit/overflow check 
    - add lower limit check
v4: - tried to address all the remaining complains from sashiko.

Harald Freudenberger (2):
  s390/zcrypt: Improve CCA CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB length and overflow checks

 drivers/s390/crypto/zcrypt_msgtype6.c | 97 ++++++++++++++-------------
 1 file changed, 51 insertions(+), 46 deletions(-)

--
2.43.0

