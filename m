Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BEF30BF4F
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746020; cv=none; b=q2ZzCr3YZE3vDnqXXOh188MFC/D1Dm6ELwqnq1Y38Y7kllvVUexS8kIIi1wSkPbkUAiWsG8kmrEWSbrcHCjlNBU/IqH41n4pVql53rArtNE1Lv2ypM6+CcB7ct5y9Jd4JsKuyJY9wLcjO8fluW7swIckduLOFaoeziMzbEM8HdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746020; c=relaxed/simple;
	bh=qtEqpVPdS9NfqWhfmn3x7sf8Ea3CtCWROBWiR3abeh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=piAOtT7Y5hGHfwbgyRdz1YMh7KvcVi28oFellq79nH04lfyYXGN2TrIVTEcfApL+U77cD/ISp8yqmMhu6ysfXL+iGg+Jpnwe/GzvrE7yWajcjthzXWt4LIh6ibkm7p0Ae2uc0lgPokAxVA0UXLMG/I9v7z8q5JgN21/pg0eMIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XUpi8+FO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XUpi8+FO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Llo3e291104
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 08:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RiOQ8tnpSYp6cu2aKHlNglyRyAclkPQxt0RMBy6yS
	Ns=; b=XUpi8+FOmj8f93llX+QLFPe9Ax7G3RkpolX9qP8eWs+yg0PN5dY/cyrfe
	RPZJdI8TA5MNlVKiKVBoBZekX20QbohkwS+BvPfltut479nElFdkoD+ayaB5wtVb
	PwTP2iweRxaTYHVtU9aWU4tGfpJ2zIJdCQ6vzhD/DZv8kQpXElnKyTkXgSoBXpNe
	XNMID0p+McMpTR/rnWUoAqE6Qqe1tz5r/p86pgTCjTsHc8uWgKONELggJMQIIBtH
	oFn0ET8NKyy35aKt82KGyJznbLsODyzY1ONd1nyz4XRjkAKaXixiAhg0lmAjP3dV
	MD7EMS7s9Ai1O1sb11hqoRz5vhPtg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eufd57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 08:33:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6738QQhN031703
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 08:33:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyc8fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 08:33:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6738XXbL41550288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 08:33:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 790DC20063;
	Mon,  3 Aug 2026 08:33:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57C062004E;
	Mon,  3 Aug 2026 08:33:33 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.207.251])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 08:33:33 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v11 0/5] Improve code in zcrypt msg type 6 handling
Date: Mon,  3 Aug 2026 10:33:33 +0200
Message-ID: <20260803083339.212885-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CYWZDTkehEHP45CfJnKApAm0Kyb2Bd6U
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA3MiBTYWx0ZWRfX6zvWR8ZXRQ/F
 F5PxIzhj2UPXGiY4TZJaX6wpdiIUVMdC+VBUigLB+/nTJOUF97dG6Kl/IcCObar71UUKqyVLtGe
 vvBf1NpQu2EmKEJvo8OBar0Ou+rHdcg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA3MiBTYWx0ZWRfX0/329Cp9hZGq
 3P0u3x+z3ZLH9N+hk9SEEEtMgPSB0XU/Ys2QbiXmitFPRLq1zWpgypKuvidg0m5c8AdlODyPmJk
 6jwtmT37GUfap92fDg9VJc6mtUqLihJCW+I6Zn+4RNSQgsFivF8GHfYFUJAP/peWBT5XOxZVapp
 lYfYqevMLXJGghjZcohP8baX8GnZ+E8y0HHrioZq8x2GTI6dXBWHLPfO8Q0ylMB5H4Sxq2GdNn4
 hOYJ+u36+FOKwUHtJ+02Dkd6H+w51zFHVjQgtabjbJ/85/dBOGrMrgg4MooYKDaDetL04o1UPXp
 DxfewE2lFym8pniFtJncFmOFLZbu52wVVHWCgKAqHq5eK6ad1IvtKHGgHDDuNmvHcQagyA5Tkx0
 RpbJtvX82f8aOTfQXeln3JL36TdZyPqRqWHTunENSy6oSh6lIGzQK5Fxe7i6Lz2S8F4nK6kQliK
 6iKE2de8ioS497xnQ0w==
X-Proofpoint-GUID: CYWZDTkehEHP45CfJnKApAm0Kyb2Bd6U
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a705261 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=Q7xrHvb9Vs8x3X5MzAIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030072

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
v11: - Added some Reviewed-by from Holger.
     - Fixed the wrong limit checks with offs >= pld_len mentioned
       by Sashiko.

Harald Freudenberger (5):
  s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
  s390/zcrypt: Improve CCA CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
  s390/zcrypt: Pad trailing CCA or EP11 message with zeros

 drivers/s390/crypto/zcrypt_ccamisc.c  |  20 +-
 drivers/s390/crypto/zcrypt_ep11misc.c |  16 +-
 drivers/s390/crypto/zcrypt_msgtype6.c | 366 ++++++++++++++++++--------
 3 files changed, 278 insertions(+), 124 deletions(-)

--
2.43.0

