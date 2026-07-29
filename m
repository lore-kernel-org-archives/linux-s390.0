Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9753AAF48
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339907; cv=none; b=dwGEZigqZx1JGaqItD4E3wmY4XdK6upXp6KoKqps6je94BJICmckHnjrrcnBzLesmamDr2bmsBtIitJeYicZFxv7znlWZJ6imKFwFMioTEwgpxFWTc4ILJq8JkdEI4Q7BvOrO2vzS7e6YUbayQB64Fv/R525+EpMu3TGIhbfK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339907; c=relaxed/simple;
	bh=DUZiRIBuxfwdUaxFyYxqYyxbDtlc3ecrOllLwfXsCFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KA8FJ88eP+dpwD69XOcL7/8jz4sxfiQK7sykq2o0m02FdVEoO8F4c21RH35s79GkuY4ZgqlJPFeS445PPNo9LQVXhev5UHxvuxrqDr1HFM0Z3sqZ6msrgoBMy2dNfRFTN+9XIcjBbe5cnBj/AUCjAS+Fl4bkZgFc7ZhlFEJGZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sp4aPgc3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sp4aPgc3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHmXj278657
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7ZWxdRtCElslgA/lOecryS/0GrL1wdmi5IgqxLbmT
	Yo=; b=Sp4aPgc3r2PejpP29pBzUgGsQsI3T+lPir4WhflkW/xR+mHOE5pYtojfy
	B2WDICll+rAZOxcuPl7Wzbc1O8LaWbQqJEs5gyQ0hwUNhuszgXy7Lz1tavCXVaip
	A5Gb0XxxxLNrq44se+sulJX7duzA7r3sTB1mq7/cVP664+4Haze3HSHAYZ/2UCVQ
	4VK9ebbyx+w0+opE+0705YmYeMZBtnI0IwpP2IdtiNEeT/OBOPY9qazzY7Vmfz0i
	3YZo+zHD+oMnJi5mLJdCq4eA7xMmHur4OR1JKUUqZBLsfYNhD0ZdYCtnW8F4oV2e
	tiwpUf1SsgOFp4pWTSbop7itjwIyA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjanx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFfHlX003494
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk7bb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFixro43909528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:44:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4BC12004B;
	Wed, 29 Jul 2026 15:44:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 984CD20040;
	Wed, 29 Jul 2026 15:44:59 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:44:59 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v9 0/5] Improve code in zcrypt msg type 6 handling
Date: Wed, 29 Jul 2026 17:44:53 +0200
Message-ID: <20260729154458.195135-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXzOPEC3HQz2IE
 Gt9AMoWds+MSq96b2/ohfAxRBKV3z2Fs1QxYAPWcpOZcZ7vL7aCRpO9F1iaq7n+XAwXXBeN32l3
 wdCdAEzVny+3bJIwT5LH9V3GTLOVjew=
X-Proofpoint-GUID: LgMgNdYaiB9HwIFxtLVCcS_uh9k-7HAs
X-Proofpoint-ORIG-GUID: LgMgNdYaiB9HwIFxtLVCcS_uh9k-7HAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXyhMKcm/aw6kG
 IFCliNnnoVF8nue2HrG10ElLZdF9WeF+B1YnRjbL7Lq8rMjzNlzOiKPlU1h8uoTZ81XtkUTSVEn
 gIXo2fWQ5L8jB1NrjExCSXI1r5vM7FG4cNv5Ff/GzFPMUWrSodiFgJTmcN0sRgB7HR6StC6eguC
 f+fxcxr31UYWPpJcNNoMQM4BjDMDQd0OaC1vUiTZp/o5a76sFQkRbI0id8xMrfkAad+NmFZfSCM
 BQ3aU+MsXGMliAbs4Am6VZZkUeHMI+oWXc/xLB9DNbnErjI2vDThvUeCznNdX5iIcXc7IrHeGR6
 JKdGVKsqd09vVudQsRSbuAesgtiQSrbMQ2ydGCSUyqSZ7jN/3Wd3jVlCTENvi/sXn1Quo0ur2eZ
 9Z2ODDci1eyjcOM6+RgqPhxy540BMGonSpGhDS7nMXkia5jPV4iLs6Dfwv/JdMdwOty6dLZE7XX
 AFElydEiObJ/MDBv2gw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a2000 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Q7xrHvb9Vs8x3X5MzAIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290123

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

Harald Freudenberger (5):
  s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
  s390/zcrypt: Improve CCA CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
  s390/zcrypt: Pad trailing CCA or EP11 message with zeros

 drivers/s390/crypto/zcrypt_ccamisc.c  |  20 +-
 drivers/s390/crypto/zcrypt_ep11misc.c |  16 +-
 drivers/s390/crypto/zcrypt_msgtype6.c | 358 ++++++++++++++++++--------
 3 files changed, 271 insertions(+), 123 deletions(-)

-- 
2.43.0

