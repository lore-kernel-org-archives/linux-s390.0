Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0A39A058;
	Fri, 12 Jun 2026 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266999; cv=none; b=u/LKstecWa9fx4BKn8vzhmi9sBGPmPEDjL9wZ/KyFKj0PBGBoqJrtLQuncVMEXMorFlAEZZNcDcfzvQAb77HIWuB1a1ox/O4+I2O1ntap7iQiQb/Tp3JYkK6npM1LQ1vvbpfM0ZJPLOeXEJxZUdLgO+JzbvPHaHI4UKx9uAwFN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266999; c=relaxed/simple;
	bh=ilPETxSb3BlhT79obZf2kVHmCMoVVquWE1k7i6obO8o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PO6mCdYIPqi8gwN8NMlNSwweHh2DQTOH5VVwxPGlIbPK5w8NvPzaRWNFj5cFzXXJQJcmF6qF/flbGRme/6kJmjWxUo9uroLv4BNSHMci2E/zl7a87MrHEAiDpB0VEHYhZmhmgyCbvBZViA4Q9kgbZk4YvoUD68Ja88QPEObequ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qa4h+wMM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qa4h+wMM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BNAQQF677840;
	Fri, 12 Jun 2026 12:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=EijzVCgmuJilvCLqz/eTgZIkakLi
	DWTvP8/G1zwhMSM=; b=qa4h+wMM/0Gg3ceJGH+Gdv9+nEMWQ47lpqJ7zHDh6KaG
	CgCZqfkUs0yf5AzL5bdZgvYYn3vdxst9CNVjxbyAiMBN4EnXuQKBo3GiCuD5vLrq
	4b/iTp3W2a1CELl8/jcF/dsH1L2RDfZ5svJ++JtpJ9YyDDMULGcnvvdEaNqKxO4d
	jUF6mKUkUFEoD931OaU+dh5vdY8HdssvxUxRVrD1W4heIv0xCRhkQdJjPVCH5Jxo
	8r+qLAOypXGIB9/qP8+90Tx2pI/vmNgesE70BfFAVqEfLoegPRa1fzYyZKjTONK1
	DaejoWf8qKlzq6++IIZA/jyFfGUqWwDuqTSEAkRUyA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8arhre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:23:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CCJsr6032363;
	Fri, 12 Jun 2026 12:23:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09qscx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:23:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CCNCbE16777502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 12:23:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F87420049;
	Fri, 12 Jun 2026 12:23:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A05D220040;
	Fri, 12 Jun 2026 12:23:11 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.8.71])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 12:23:11 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH v4 0/4] KVM: s390: vsie: Implement ASTFLEIE facility 2
Date: Fri, 12 Jun 2026 14:23:00 +0200
Message-Id: <20260612-vsie-alter-stfle-fac-v4-0-74f0e1559929@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQzW7DIAwH8FeJOM9RcFgoPe09ph34cFZL+eiAo
 k5V3320OWzS2uPfwM82F5EoMiWxby4iUuHE61KDemmEP9jlk4BDzQI7HDqJBkpiAjtlipDyOBG
 M1oPrA+6cUTupBlGfHiONfL6z7x81HzjlNX7fuxR5q24gSnwMFgkdBK3RkVZWBfs28XI6t+zm1
 q+zuKEF/0A4PIGwQkYqo5V3BtE/gvpfaJDyCdRXyEnbv9JIwbp/E123vSN9neov5m154WwiqOc
 z531TdNtB9Lpevv4AuZ/yoHoBAAA=
X-Change-ID: 20260129-vsie-alter-stfle-fac-b3d28b948146
To: linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1750;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=ilPETxSb3BlhT79obZf2kVHmCMoVVquWE1k7i6obO8o=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnav/R+72hTj1Rf+ltv+dFc8Tm/TQq3+J91yJ4i9e473
 6HQ2c8+dJSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjARiQOMDIuLDQ60HdlReVXz
 /N7/F4rMmf8/3vEj4d1h7Y4dkUfsvu5nZOgQMFdKnHzy12Ilx1Vl8/5VPnb6vT9pw7sZj+wrBAJ
 Wt/IAAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0gmjzlV_kGAtWER3t16VHy1AF7fUd3R8
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2bfa34 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=JTEGq0UErLZmNMgf6yQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDExMSBTYWx0ZWRfX/1b8WW/+ZLJg
 Ei/BdAHiv/gNWnMG8u1thRE7m4sPutVge5ir7Thv+8aEC0OjIVzq2BwqdgNfTqNpSmOzO1Rjh/v
 vaP2FkVUkb2Q76q5t1uTpMO55w3f0mJG33N7hGWMTJ6/KVMfStU8099JA3/PuN0WdH5YktY0rkI
 xqz+2UE9KCCqS9gO3bZ4nALprqYjK1CyjxUCIqPJawMevkvlOdkX8Lj4suQOyO4+MBpFkhDAn5N
 LS1BAse2FGD80r2lmg9jf+H1RgUD+066bxKCAJxyYisixm/HT5wqVWuV3fT4RySxOzKMkkBWpLM
 1edSuJ2YnBcbGmWHHcj6kQwn5P46SEZM52r8R6Z4G/QDugZecECk1Smh6DUdnRL8RJoAuaaiRwu
 ctC2yg0mHVZUdwQFi3EVpcpB5INN/yTJqW9QHi1bpHFU7LvPWmSSjd7ht9PB6zyUVFXB4PMIhzJ
 3oq5euall5rob6Oe/HA==
X-Proofpoint-GUID: 0gmjzlV_kGAtWER3t16VHy1AF7fUd3R8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDExMSBTYWx0ZWRfX+fKEXc/RFAg4
 Pb+gge+Gc9CQ99VAPkylfZjt5vIycmXRPP1IO7q44yVxngNtqHqV7tt36393f4XrM3GSZ13JgzM
 kC/fVLAe3vcMG2ycb6yLJGNvi0/vjC8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120111

Add support for STFLE format 2 in VSIE guests.

The change requires qemu support to set the ASTFLEIE2 feature bit.
ASTFLEIE2 is available since IBM z16.
To function G1 has to run this KVM code and G1 and G2 have to run QEMU

Tests are implemented in kvm-unit-tests and sent as a series to that
list.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
The series was originally developed by Nina and only rebased and
slightly adjusted by me. It was not sent earlier since the accompanying
kvm-unit-tests and qemu changes were not ready.

---
Changes in v4:
- adjusted struct kvm_s390_flcb2 to make sure reserved0 is always 0

Changes in v3:
- renamed struct kvm_s390_f2_flcb to kvm_s390_flcb2 as requested by
  Janosch
- rebased

Changes in v2:
- adjusted variable naming in handle_stfle()
- add some constants for readability
- add struct for format-2 facility list control block
- rebased to v7.0-rc1

---
Nina Schoetterl-Glausch (4):
      KVM: s390: Minor refactor of base/ext facility lists
      s390/sclp: Detect ASTFLEIE 2 facility
      KVM: s390: vsie: Refactor handle_stfle
      KVM: s390: vsie: Implement ASTFLEIE facility 2

 arch/s390/include/asm/kvm_host.h | 12 ++++++
 arch/s390/include/asm/sclp.h     |  1 +
 arch/s390/include/uapi/asm/kvm.h |  1 +
 arch/s390/kvm/kvm-s390.c         | 46 ++++++++++------------
 arch/s390/kvm/vsie.c             | 85 +++++++++++++++++++++++++++++++---------
 drivers/s390/char/sclp_early.c   |  4 +-
 6 files changed, 104 insertions(+), 45 deletions(-)
---
base-commit: 0e5d0a0b5ca6ea4e391d6786266405c5871e0151
change-id: 20260129-vsie-alter-stfle-fac-b3d28b948146

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

