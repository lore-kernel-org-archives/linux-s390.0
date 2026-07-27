Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F537DABE
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141136; cv=none; b=Ltm7SVtL9W7b0quENE6kxdSHwjl5vNOc9rd3fZZO0uODxsbhxhBwwvdc2iQ6JWtiLIm5uop09toEd7wKUAhQYnx79/uNYtO2rzY1S3Pjg6qvdCvxOCv+tijYdEk4rq9zJuWV0bgLodQstxItSbEckJDkDxaIzLCJj0bLy3cvJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141136; c=relaxed/simple;
	bh=PSkG/GgDvl4bTPOXJ6LTvjF9hMzShahaqb4ynFgi+fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBC72Ek2aOIJbNfcdgfEOjZYaJgezyliA0msB4XGHrDXRJQbT9d1WQtVxyHRNsO9GdOS6OtxEPD02kZEVsyclEb1Yeto/Afcv4LZWGF7aipqsOJ4YCChZ1pcTQ6tx0y34tURL/i3ifVaiGveiiBDkjfwzYGb8iI493jshBW7gzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hAEn8Inc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hAEn8Inc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7m9vg1514679
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rORIt4tiLdJTQE9r3QI3g5FYC+GWm4GsL+u8U7SMO
	Ss=; b=hAEn8Incqitrj3oPTvqF0dKcRpu6OhALMltzhwrsVNjI+oFUy5VpZwCKH
	YBfydV/5v8icxmvRJR5hX8zi6lQKKI7ldm9+z3NtqqhfIFt/23ziUodvdXzzee0c
	kqVYxygLOGYIj/ewbzQ67hqbfi3tm+ZfNx/xjCFwNgHBbf4F+jIBRSK9IMJA4bZ4
	ye6qsQMDItg+hYcRsAbGy5GdXjeJ4ygcGFEYDldH9PzMgcE5rngCI4/YJUNoTwmL
	eIAagwUGxgY6TRVx5sCHIE87+XWUDxPpLNd6028whYugXHZ//BQiGy1EjzpvbN3l
	xVm5mi5kU9To4yjle5uFMS7GGwc+Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nemqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:32:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R8QG3l013086
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:32:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg4c4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:32:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R8W9g948628066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 08:32:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90EB82004D;
	Mon, 27 Jul 2026 08:32:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7776B20067;
	Mon, 27 Jul 2026 08:32:09 +0000 (GMT)
Received: from funtu2.fritz.box (unknown [9.111.203.40])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 08:32:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v6 0/2] Improve code in zcrypt msg type 6 handling
Date: Mon, 27 Jul 2026 10:31:58 +0200
Message-ID: <20260727083200.151976-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4MiBTYWx0ZWRfXz1awHR/3K74e
 5iIQz4SYj1xRMYVCgDIsrXxJ6Tf9H/ceSbyEnCYkEuc5WtszVeI/yY9Z47pfaSm3JA2FCK3GlXu
 1ReEtqC8FM4aTwJZq0jSs3rskRDagXc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4MiBTYWx0ZWRfX8uYwIdASfQZ5
 G+BpDd1TT3RuIVUZ5JDXROYaOmOBig5PA+OJyyGq8YT29FrEOtL35q5wEGTcRhO353LcXvkWQVu
 5F610lZ4cM2Q4AXKAEKokeSN/BSWgYCZw4BX8bHnS2E1o+aY+/AP3LpTLrBBqCWWj/F+yUU1r5H
 zo5joxhMSJMDvtKSShH6vBzMaT0xdOfxSMdV+7nv0Mm9r3qhwELISvyAv05vp/mf4X2DmbaKAS6
 pQOL80RgEAwi4tecxUyTMVVeX9hlLXYpG9hqHESW9e3qGNZN7DhoIv4doksrMk2ltH3/yIkqVjE
 bTupC/FeEj1Z0CXRJ4UzHuki4aB5cb83xNylgFAO919zBQm65KeuDuQHtBNR7987QrMzkNALKZb
 8TZG+31a08mrsLE31ijD0WoBJxjA9UT1RC+Q1OwqJKHaw9bVyrzYGflr5hL3hPB0LOIgxUgLj4T
 W224lqEVCS67Ty6QjhA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a67178e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=LWQEhQUvDEEWaAVg7TkA:9
X-Proofpoint-GUID: 4D1spLJ70ecQsi3yvfjBNUCOXFWloULG
X-Proofpoint-ORIG-GUID: 4D1spLJ70ecQsi3yvfjBNUCOXFWloULG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270082

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
v5: - Yea, sashiko still found out that the min req size needs
      to take the minimal payload header into account. Fixed.
v6: - And finally add padding zeros when there is a gap between
      user space provided message size and rounded message size
      in kernel.

Harald Freudenberger (2):
  s390/zcrypt: Improve CCA CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB length and overflow checks

 drivers/s390/crypto/zcrypt_msgtype6.c | 101 ++++++++++++++------------
 1 file changed, 55 insertions(+), 46 deletions(-)

-- 
2.43.0

