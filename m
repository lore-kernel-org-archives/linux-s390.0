Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D2456DFD
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325219; cv=none; b=m27hlE5iHaGMdNHSna9acvEUnDWiVz6/RU19reqXObymZdtUJgA4YIhNwJz7fOL1o3SpN5ZtiY6/oZ+tSeCmJC2eS//ByZermnTnCOX24XLfnRltYf1LBtWukWMdPK+6t1Vic/92LpqP/L6cFBIukATuKy9Hz6/8IkMJncNQffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325219; c=relaxed/simple;
	bh=Z4oACbE02a6iqoCiPRHwva/qo7THPIOsc7xVxWpqdbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKwazMpa9HIhOC73+DR42c4z5lcdmzaBYLtC2AYifAva/icNNgrDOUhbP8ratCGmMpHlVHFPi4nvuzkyOpcqhFAElkXkjugrga6OfNH7/35W3fX/WTWgV6DX+FMJmtMC1eMbvx7dqHZzHeV6gc2lzcZcfXZ/5IxH+ur/bTs1Oic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YHhH+HRR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YHhH+HRR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHqnW2164188
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0qDBFs5AxPiwQ/v6Y6zGYIlo3KEdWxbmU3lw+b/Pr
	J4=; b=YHhH+HRR9Cl4nzpK7DJkKxKig6m30I8hx4pUhP832PuuYjYDPomFy3Svk
	1UUi5Mk17Onb1xfvAIa2mo71mmgJsQ42otdVr+mcfksvamZNxmIMzUpFq1KS8qZ1
	c1Ihvl4oXhWSbLpNBdDldsW8UuKzcM75g+r1PjsAK/ZuBE2Aj4B/3liOJKN6hwSz
	t24AaoeNqVZTuUzgQpZWTKgXK1tLW4rrbhjTyJnGIKEzTGiVclCfihkE6+p4MMtv
	lqIM8TNwm67cORG7CguIHNlyRqvOnRD6hs8Oub+IUlCTtK8QNN1wNMyWzN4IZMB6
	+8iuuNKIb+OL4BAZAcdbJxWPWwiUQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycjbnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:40:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBQOv5004218
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:40:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhed21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:40:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TBeA1Y52166918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 11:40:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85E6E20043;
	Wed, 29 Jul 2026 11:40:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5165320040;
	Wed, 29 Jul 2026 11:40:10 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 11:40:10 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org, ifranzki@linux.ibm.com
Subject: [PATCH v4 0/1] Fix buffer over-read in cca_cipher2protkey
Date: Wed, 29 Jul 2026 13:40:08 +0200
Message-ID: <20260729114009.187946-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: czkHnZVZhDOiQ-OzMShnKpnL3N6JuIkJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX+XM8BCbrzmUh
 irilEmPaST6w3TwrqNObQf2kaOvoqFIXr52I17duyEcv+bKaUHvlfo0FC0Fig3NSqOaZq+00L/k
 lr1eDHNTm+TrcVEB+yF/6BMTYuN5nqHkZUCd9mdA9cjy+sK+JhaQ0w2hq6vWyyjAEOYd1WCcsLQ
 mSKhB8wA9KQcExAx/D99gf8rBDJYRQbVYyfEGGskD5k1sf9qDFp8o9DzrqSHLf1mxMjU1kCKryA
 vV4O14L1bC0QCcYTApiM7mkNnZQoXxeE79Iy3wYMoaJklmWK4iAOl9SwWfls4mVTVqx71GuIPHv
 Ektw4yHFhkFH1yYSOatFMu1sSaAafjmh+OlU7twb22PVnZUC39tmb9M6QlztHifLUAhF4VhdKUX
 52+iIjGKMz99JXzUBbGHhUZ/lhiSB5yVHfUNb3wIi9q0G7iPBMaz2neiN+FEe295r7JtlbRGUUl
 AwZRKTj7Po1EiNJxgdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX1e7TPM6J0xDH
 xVHInt7ZznKOpUbN1ljYhPufNblYb25EQWO0uOFlmI4mCPK5jvED/Stf0iS4PoBNhSe2gtJOcJg
 4q7Z35v/ARdIEJTcOpFvwUXDSE1dNZw=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a69e69f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=ZDySonMx3ZsRDnxkPS0A:9
X-Proofpoint-GUID: czkHnZVZhDOiQ-OzMShnKpnL3N6JuIkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290093

Add validation of both the actual key buffer size and token length
fields in all the cca_check_sec*token() functions. Additionally check
in cca_gencipherkey() for possible underflow with returned key size.

The CCA token structures contain user-controlled len fields that
were used in operations without proper validation against both the
actual buffer size and minimum token structure size. An attacker
could set this field larger than the actual buffer size, leading to
reading beyond buffer boundaries. This may result in a kernel crash or
exposure of memory via sending this as part of a request down to the
crypto card. Also an attacker could have used a very small len value
and thus enforce a buffer under-run which may produce similar effects
as a over-read.

So now a key must
- key buf length must be at least sizeof the token struct
- the key len field inside the token must fit into the range of
  sizeof key token struct ... key buf length

Changelog:
v1 - initial version
v2 - extend the length check to all cca_check_sec*token() functions,
     also check for min given buffer length and token length field.
v3 - there was still a possibility to under-run the length checks in
     function  cca_gencipherkey(). Fixed as suggested by Ingo.
v4 - Reviewd-by from Ingo added.

Harald Freudenberger (1):
  s390/zcrypt: Fix buffer over-read in cca_cipher2protkey

 drivers/s390/crypto/pkey_cca.c       | 15 +++----
 drivers/s390/crypto/zcrypt_ccamisc.c | 64 +++++++++++++++++++++++-----
 drivers/s390/crypto/zcrypt_ccamisc.h |  6 +--
 3 files changed, 62 insertions(+), 23 deletions(-)

-- 
2.43.0

