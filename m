Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609E397956
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335976; cv=none; b=PG5x97USPV29egQvmanOaSY++kDl8Au7+Huyjbc81kzKqMm0n9vk11hPJplaha7oNJMkiq7y1L/nT+GPefzcBgk4Z0j2AWsRFYjrx7T5X3ovQBS7USxfcfNwOCLeOfAXkh7izRrLZCgxAX4dPmm7R1j0Y6WZ816vrz2wJ9vUa3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335976; c=relaxed/simple;
	bh=NtEQ61KpSCQ+nAy4jx/z7fxz5T/vYKDUuVruqg8EcYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URdCFm8XCdzD6+WRiXfJRFyLEvdCglASmRvw9Ma85pgglQPPvLEcM3oJ6z91U0kxahLu3JjTz83f39qa8giiAqQPZRz/tTW253XJTXr2urRIZjiXW+k9Vo76cXmyAoz65QZYyDwHbmDY1ng0D8jdHE94VxiDwfhFkCHt/oZcOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lp4sPtKT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lp4sPtKT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDHrWb095251
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BAvIHtolHfNuLwoTHlSgWDRzDcm0vyR4ndRWmypjJ
	Fw=; b=Lp4sPtKTsv6nlBPAjrN6Ibz3jfP8fQJx9PW6oWXbSAxyrr5iZ9e9tK9wz
	1b1FPEzvBG7JuCcyTwbz5qkZ4ovaSD83/oYTC0wg0iMFXxbzltBkEwOmJGW2nxmI
	waBmEFcvLsiiM/u6MuRBw+YGTWXOnV8ICoGlp348h4h27nbmXgOWnDRJjR69Jj1t
	We+19Bw9HX0O12C+VThHmxfmpbcOMKHlMIMUAVVbsUOKdTSYYNfw+Fn+lwGzO17C
	0YdErsGtbkcLIDWZ9WRqfILuCXiGWLCLRiFqLZzkAIJNpkCeM26k9yt/H3aVkJDA
	xj8/n1kqKQnEJkZ3JKGHgM0FKKpfw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7k62s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TEQbOg031574
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgewm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TEdSGQ45482240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:39:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5C2E20043;
	Wed, 29 Jul 2026 14:39:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA68B20040;
	Wed, 29 Jul 2026 14:39:28 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:39:28 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v8 0/5] Improve code in zcrypt msg type 6 handling
Date: Wed, 29 Jul 2026 16:39:23 +0200
Message-ID: <20260729143928.191969-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xcOFB9t-Qng5vCR9ascqdV-eZuLEkXtn
X-Proofpoint-ORIG-GUID: xcOFB9t-Qng5vCR9ascqdV-eZuLEkXtn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNyBTYWx0ZWRfX4bxsxLGekCsm
 /h/2GRVe+GAsyiAk07mgIrqaPXp7g3S4FsNwAfZOt8qH1Y3QFGYDttLWgEGSkqPDk4VykpAa0a/
 dE4RZHGQPN6WK/zKGCqVchN0KHRbrpk8PGhiLF7M5WrA25Sd1AG0daf/YUyg/MnKMk5gHsOfrSE
 /454dZj+BC7qzEnZ8tZXgO/u2fgshIlmiZD2kNiO62XsmDPll5i+EHmHcIkvg+K7lj4qbR+XlNf
 tThwPXlfR6Kw2EUnz2z7oBI01df8nJdYgjD9vuMCqbj3oBV6Nn96yxxJU/MVTGuynYIQ2uketmL
 Gr+1+awyQ3DCtmD5rPM6iw6+A1N8qZEJFfVDwoZTWgjFAHPrJG4YIlc/GaXJ9jSfBRar3fKh/cd
 Vc9Vr7aGK+GJe5KWERNBPvhtDSm+Ep06dt3CFoOgi8Rt/RSSGzoQsmdtEnGgubeRQrVSNxPYbTT
 Jo9jiV8P/0Q9ZE/8RvQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6a10a5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=eLZlGypqnGxa_DfLJdAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNyBTYWx0ZWRfX2rqK6YYtyEw8
 reuPgzejPJjKenvV+q/z3Yg5ICYphINHshLp2+MayCCKQm60fPz7iJjpXOjJRN7LrRhZWZoyWa3
 kKjNc9hcc07l4CYxuApzHsA6SQhyMqk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290117

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

Harald Freudenberger (5):
  s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
  s390/zcrypt: Improve CCA CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB length and overflow checks
  s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
  s390/zcrypt: Pad trailing CCA or EP11 message with zeros

 drivers/s390/crypto/zcrypt_ccamisc.c  |  20 +-
 drivers/s390/crypto/zcrypt_ep11misc.c |  12 +-
 drivers/s390/crypto/zcrypt_msgtype6.c | 357 ++++++++++++++++++--------
 3 files changed, 267 insertions(+), 122 deletions(-)

--
2.43.0

