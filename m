Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B687432BE5
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420915; cv=none; b=GxJNFm87ToO048xoBINxoIKhHBMeJnSYWX2I1xrhrvFqkmc1y2XLy6cc0Dqu5zy5nxv3ijFM5SXRGIBTSkXBqe76m4foQd5HzdYsHCHwuX7lmsAnlOCL/KDZTcpIfUK0Ca2Pqhb+3ML4WrG3h78VtjgN59BvMniT2aP3CWDVnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420915; c=relaxed/simple;
	bh=IMFkGtQAaJll8b74+UjoHXfIaXcmFSpNnm0XgBaSs50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/LorH1ERk6HBAUo4nmJkNo2LFVxvuUDppgaaftmZedWGmhyCQust+vG5PFNn+4AFN9UsliLemyriOgiaLxYDrUqdwtJNG24dYEEL887IofvTNBw6Iba6MfbW4Kehc6ec6SrM4clJDwCRKO+y27WrKBDGZ1YJltPXLaG0szxmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ndiEE6j7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ndiEE6j7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDHkHP3124977
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=eGiKdkZnDR9QNNhm4lBqmEDkFtxSefBj1XM5YkN6t
	jQ=; b=ndiEE6j7O0N3UXVkU3Q5FXoleNwPWqXHmQanycLmSaNXmBDxsailkMM/u
	KunDEBLywt+gAPXAafU6DLK47WyQ/umQ4T/2FGbMzNR2uDxTPm9jzBfwSnlFBoRg
	frdm9v6b/MRfg18yOVt+IEZBWlC+9Isju/sffpIe731wcmWQ0M+/7ORL3C7q6irb
	lwbmSmW4npz+3VHYg3sAqw8vlKl+1K8nvm9oyBrHi8fDa/0TGj0emxPN7k1k1zNn
	7M3ENYU7J95eJn3WFskI0iOBwEKVtmjl/tVe0kcwvt3hdeWJ6YQ7xMv1yjwbkL2F
	NmNmCxvzihOHYx4j1mk04HzJWk9jg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y06ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UEBKHK011776
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ybdxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UEF8lE24707704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 14:15:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69DD220043;
	Thu, 30 Jul 2026 14:15:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4955620040;
	Thu, 30 Jul 2026 14:15:08 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.145.36])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 14:15:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v10 0/5] Improve code in zcrypt msg type 6 handling
Date: Thu, 30 Jul 2026 16:15:04 +0200
Message-ID: <20260730141509.205970-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7IiUIcslKAO8phAckXa8zVlorY-yF9d3
X-Proofpoint-ORIG-GUID: 7IiUIcslKAO8phAckXa8zVlorY-yF9d3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfXw+aDQTSreY4Z
 jWaq+YU7a//K1bQb2Wd6rmzFxKqfu2AGunGZZxn9QCvmCjPDmK79oO73F3S7C2CPoo9GuL1zZEt
 B2fserj2qpqXLfu4siAnPjaEebkuc+o=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6b5c71 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=Q7xrHvb9Vs8x3X5MzAIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfXy/MbHxofWwT0
 PwEpTM7l79o3pgcXw6/NKCtq/EK4qDqPcLnKBCt1d6bhWZyL9trPALziCos+wt+jn4dVAwJK/Gl
 94LgCcSQsW03t5WWahbf3O/4U/KEPml41asK0ryr++dLp1HT8ztHUrp4asQYy5PQhjLZPrHjWo4
 r657kylDuIAFJ6Ali+nNJSSPdZ/mXxGE6ZiGOJv+IasyiFlofxkPUrotRrCNGL+bB07lneYOPDq
 C5magHIJPWMzuXFOc3PJtT6hKg8urz0qlUY5aTXhedYEXAEM37HAXspJFvvSHeG21A4bnPtWkK/
 jpDjzlzB73yqHmvPQhieD9v8BYYnGRy/mupH5t3g2ifqywSw7nVQq0jLrHmJzacWcHp2ZjnsWng
 p8AYUp9I3HZX2J9QlV10OJxnFaPXpvnqM3QOC+PQwwqjJH8sy8qWldS3EiSwVUM78qZ0t+AtXIi
 RFNTZfgpNt2VfhXHdtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300105

Rework the limit and overflow checks in the both functions
xcrb_msg_to_type6_ep11cprb_msgx() and xcrb_msg_to_type6cprb_msgx().
And more ... all related to the length checks done in these both
functions.

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
v7: - As requested by Holger, the padding code is now an own patch.
    - As the length checks are now so strict the allocation in the
      both misc files needed adaption to correctly allocate 4 byte
      rounded up message buffers.
    - The EP11 length check has been found to be a mess. The payload
      is asn1 encoded and now the length parses parts of this payload
      to extract the needed fields (function value).
    - Furthermore another function zcrypt_msgtype6_send_ep11_cprb()
      also needed to be adjusted to parse the asn1 payload to patch
      the domain value into the payload.
v8: - Sashiko found out that the cprb free with memory scrub also
      needs adaption when the allocation rounds up to a 4 byte
      boundary. So fixed just this in the first patch of the series. 
v9: - hunk for cprb free with 4 byte boundary for EP11 was missing.
    - use of put_unaligned_be16/32 instead of direct cast and store.
v10: - make the asn1 parsing bullet proof. Sashiko found that under
       some circumstances there could have been an access behind the
       actual payload.
     - Added Cc and Fixes tags.

Harald Freudenberger (5):
  s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
  s390/zcrypt: Improve CCA CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
  s390/zcrypt: Pad trailing CCA or EP11 message with zeros

 drivers/s390/crypto/zcrypt_ccamisc.c  |  20 +-
 drivers/s390/crypto/zcrypt_ep11misc.c |  16 +-
 drivers/s390/crypto/zcrypt_msgtype6.c | 365 ++++++++++++++++++--------
 3 files changed, 278 insertions(+), 123 deletions(-)

-- 
2.43.0

