Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C52FDC28
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318806; cv=none; b=gpTfkLmhLd2wuSmDw8+ErqMcau9FS/NKPHm4P6E07hUd+HOroHcnes+VJ9iF2xm97sd8Fbwxcx+s/aSYevHAQaaUXOZlv3AigbihyVOeCtE+t12GsmIUGLHpvP/4LMi3MoEzD7bS3KKtoHrKkeJTR61x28Y8w6681y/TzvHPlAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318806; c=relaxed/simple;
	bh=1WGSbi5EJQDecmy1+FV90VG4H+R2VtVk8RgwHfBaAoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thWlM+OqZQdoSYujG6eR335XQYlpSGk9g2eHIN5zOe+9h+vc8e58U8rBgCxKFDEWvU0iz5C5B42vQ5w5cxYoA0DfA+O55+c8/fniTuyrwYpMAUYNJv8x0gqeI20omMUHbGuVsev9R72zww1FYxW7gJ9JAhKzNrLjBRg+DQHtny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fsa9a0t8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fsa9a0t8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7lmlP3507877
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3H8u4vYDFafvYO5bydYeCfOA6b/GYemWcccaak4Dg
	QY=; b=fsa9a0t8n4DxYGVJmLfWX6YK8cx9MLzyBvDgSYz2KJsDuaBiyFJSpdu//
	yjOMEVuxuGI8ucRWl1KMJWVozc0UZli2kxwuHmFi8gy3IKSTZMG+0laaOS4FcQUz
	/VSCifnLQYMuDN82ThQQznBul4vyn+5w5eRt7a/1jxMMixD4gaFDmoOMOACLc4ni
	pZ8vTM3PUz/o7lZRbGK1tFBh0a6SYpr/WzxjeyEgox6ep3nDSl2nmRL5mMSxY8er
	uTmHTJaK5p1L5yUOUw+7saEKOUfqvmIPJXFj/iR+0oNUR5hozUhaBY3s7kPDybIo
	k5YpVL3tDyh6leRKZi5hPN7taKXcw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ns7s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9fHdg014413
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqeacd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T9rJGG30343516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 09:53:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F56C2004D;
	Wed, 29 Jul 2026 09:53:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A09720049;
	Wed, 29 Jul 2026 09:53:19 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 09:53:19 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v7 0/5] Improve code in zcrypt msg type 6 handling
Date: Wed, 29 Jul 2026 11:53:13 +0200
Message-ID: <20260729095318.184141-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX9Sp9SNRqL8sD
 X7Yd4OaJocCWv2oWBHm5NeB47FF+3eLkfprDykk/lGVUL6TPgaVccvva8ai8uXwizTeAWTKvitu
 v59lLVJ+LXRgR40O0DQkcbYEzLJVRdw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX5rDd3CUNDVG8
 7Kj929LbKHkgygLqv0IEFZMc9lKyjxv5DW+he6+Q3dhgvoVll7Dt3WdsXKHF+YLmJotHqSCVhrA
 AA+MLyrEwps9qtGUjUeIyR4mr/yIw5x6gmeC7ugI61iBCW8rd4O05L/uEv7mhy+Ax7UB7/cBqaa
 2+SzutBoVOnlg0nqZTtVR5HTraoZ07fYoDFLblxUYE65V1Cn9OSGc4owNpGKVBOoW2rVJ0wkPBO
 EJmzIot2+OJF0dhbAiai2L60AzO/DFMl3awq8DzRPrP4vdduD60qcLrbqEbYxIqc+ZJSZXZUdKQ
 fyCU7RomyYHsczYBpjhkpQ4REJQOXBBvqgqpocURbH680tOOTOyj6Rulsp/YOsw2B3tNrubt/aI
 MCIcgsawK8ByPsC+Y65ePKi0pnlw8HI0Udp40AUfSkgxA3XI96pdHQ0GjExS4kGFt4nLMM1sHq6
 x3y/63n6A9PXWnSsvZw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69cd93 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=SE25KUJiYdbvKPOzYiAA:9
X-Proofpoint-GUID: jS4Fw5H_FrgcQxEImmXbuGofux2kk5kx
X-Proofpoint-ORIG-GUID: jS4Fw5H_FrgcQxEImmXbuGofux2kk5kx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290080

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

Harald Freudenberger (5):
  s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
  s390/zcrypt: Improve CCA CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
  s390/zcrypt: Pad trailing CCA or EP11 message with zeros

 drivers/s390/crypto/zcrypt_ccamisc.c  |  16 +-
 drivers/s390/crypto/zcrypt_ep11misc.c |  12 +-
 drivers/s390/crypto/zcrypt_msgtype6.c | 357 ++++++++++++++++++--------
 3 files changed, 264 insertions(+), 121 deletions(-)

--
2.43.0

