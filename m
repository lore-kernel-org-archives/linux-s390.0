Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5AE3C73E1;
	Tue, 28 Apr 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364144; cv=none; b=Za6YHBwuBJl2Z+6ly7+YRd2AOTgRrW77vmDJUbCCjKId7NzyHjBPApJlBw2dqKNBtSisQvNun1rz+FqivpGRf1acKWTVNLSjFYrDwslXIQQm03XkxZXjOKFE/lbsNogsbZCHtWZLM1XPh03ajl3qTD7kRYf7kLy3NyHhMJV+X04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364144; c=relaxed/simple;
	bh=I4Ag1MVFzr+Gb84hUKwdq/+XSGM4hTIocWsnjKxZvOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LHyWxfv6aer+P8VowQ6rIc4aQQTS0UG0HqBRbrC3FfU9IUgcvDWrUyhzZBU4r29OiqDHZMU9MAzP2GjHCJlVJFzDZil+z0UmUwHqCal06uLHbEXNIeIJzyjsuvCOJ2uPMp3HpyH/JmPRZvm3t45nBgBj9YuhDVAnvMY4FJolmR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tPVXzHaq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tPVXzHaq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6JbtY2724560;
	Tue, 28 Apr 2026 08:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=k6c9WtgoGyXAjd8Xd8VGSS9hdLRL
	HlH72jnzJhffHPY=; b=tPVXzHaqQaFI3pxj4aM3vGyaD96wruQaieww9wDYNkZw
	bwPiw61PTgoQN/PhIlDnTNUY5OQ2OgqnqPzwuHb5rKXAiiLNr/kqDzkXxZO2b3M8
	T8OO3rEBqPvdXNGMEf4NrzDZyXA0zaF9JN1+s3DaSDBlCzAZRmH/xPJRx2h11eMn
	7ji36QQMgM+IRzyGGzXyPDUvetNqzN9ti5AYdJQOZL+hlfT1AydHhlSuorKTvTV4
	fqIPu6L5BCvfzbEIRbBIfwVAohWp3HvjvMhnKNZ0l3vG0TfthtbfJIfBzFFPGsy3
	eEPQvM/VPEN7ujLTV0/inx0zExP39b/7e7uJxwd/OA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vba5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S88wRk029054;
	Tue, 28 Apr 2026 08:15:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq8x16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S8FXH849611064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 08:15:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95DC820043;
	Tue, 28 Apr 2026 08:15:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A77E20040;
	Tue, 28 Apr 2026 08:15:33 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 08:15:33 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v5 0/6] s390x: Add test for STFLE
 interpretive execution (format-2)
Date: Tue, 28 Apr 2026 10:15:21 +0200
Message-Id: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23RwW6DMAwG4FdBOS8dcQwFTnuPqYcQTGutgS0Jq
 FPFuy+j01q1vUSynHyOfp9FIM8URJOdhaeZA49DKoqXTNiDGfYkuUu1gBzKPB1yDkwyxP5Isjd
 WYq4Jsdx2FYFIjz499XxawXfxMTs5DRxlpBCD2KX+gUMc/fc6b1brrQut1D09K5lLLO3WkC1qB
 e3bkYfptOHWbezoVm6GK6EBHwhIREEFtASEeaWeEfpKIDz+QidCW6IKqafe6GcE3hL6gcBfAmr
 UPaHWNd4TyyU4T19TWkD8S681gWTqO45NNnre8/DqTIjkxe12mux/bovSui7hJE2lgLocoCzqJ
 qW0W5YfddfibuwBAAA=
X-Change-ID: 20260202-vsie-stfle-fac-403e4467d8e2
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=I4Ag1MVFzr+Gb84hUKwdq/+XSGM4hTIocWsnjKxZvOk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJkfcpYEfrg3Y8+mzKMHryXL2ypGLzznnMTQ/GZN1dcKl
 ddbnBnyO0pZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZjI7SkMv9m0fdvrFJdNnVE2
 f6feIYnkbaGrojoOXDz2VD3WwbruyTxGhoXHLCanqLEFeq7Jroxj2RHO+uibE5fhq+pf/ToP96d
 28AIA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f06caa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=MwmhjpgLNsuZdhXYqscA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L6FKNfQ4BOQmvGZBsbHILcjXqPdkKX3r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3MSBTYWx0ZWRfX95SdtOMaxB4x
 mLKVjiqV2Jw+BfSyZekXwUu9BKad97hAPKEPRLr+T0I3ZAwgw76feZgS9aYnXdzxSypUUKo5Yu7
 pX78Ho/uLJo0nfrYpu4BHwZoLUL7G+8ju9PT+UcH9X+yWMnht04nh4GsNGFvUUfxdIQEeJpUqKF
 saZvvjTpFW54lzXSHwzgIUqxUICcJ5qnk6Zc6T1JcNiRCktF3uibNOmMNt/2zo+0+BCgCj+yE3P
 VaqZUpAuOFjNdVga61y/hiDMlcD5FutarzBDL7Lx3SGV4JAaAFG3t9mqYxefcg+olKWKKm1bVeu
 StenXLS6ZHZ2y63mPxgAP9+EcNMb1CfNlaWBQzqmSZy7+io95XH6vhOQgvjRule4EDSRJs9L7kI
 SwB6Zh5nXE7zLcTatM4aMNqBkCymLjNZFJGvQ3vBE39LljHCWvVIuml9vzDg8HIevCbD9QWI4G4
 sLK2B0FfI+TCIflpCXA==
X-Proofpoint-GUID: L6FKNfQ4BOQmvGZBsbHILcjXqPdkKX3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280071

Test the shadowing of format-2 facility list when running in VSIE.

The tests will skip the format 2 tests
* if running with unpatched kernels or qemu in G1 or G2
* if running on machines prior IBM z16 GA1 (where ASTFLEIE2 is not
  available)

---
The original series was started by Nina and finished by me.

---
Changes in v5:
- readd reading the astfleie1 feature bit. Thanks Janosch

Changes in v4:
- check feature bit presence before reading feature bits
- revert sclp_facilities_setup() early returns

Changes in v3:
- Remove unnecessary format loop in test_stfle_format_0() - formats are
  already addressed explicitly
- Added patch to use sclp_feat_check directly for DIAG318
- Add no-stfle prefix to improve test log
- Move prefixes to main() to have prefixes in no-stfle checks

Changes in v2:
- Rework sclp_facilities_setup()
- Removed explicit manual padding from struct sclp_facilities

---
Christoph Schlameuss (4):
      s390x: sclp: Remove unnecessary padding from struct sclp_facilities
      s390x: sclp: Check sclp byte before reading feature bits
      s390x: sclp: Use sclp_feat_check directly to read DIAG318 feature bit
      s390x: Add test for STFLE interpretive execution (format-2)

Nina Schoetterl-Glausch (2):
      s390x: snippets: Add reset_guest() to lib
      s390x: sclp: Add detection of alternate STFLE facilities

 lib/s390x/sclp.c    |  8 ++++--
 lib/s390x/sclp.h    |  8 +++---
 lib/s390x/sie.c     | 11 ++++++++
 lib/s390x/sie.h     |  1 +
 lib/s390x/snippet.h |  6 +++++
 s390x/spec_ex-sie.c | 10 ++------
 s390x/stfle-sie.c   | 72 +++++++++++++++++++++++++++++++++++++++++++++++++----
 7 files changed, 98 insertions(+), 18 deletions(-)
---
base-commit: ea91ac1763561b23e7eba3f7c1fa3d45f29b89be
change-id: 20260202-vsie-stfle-fac-403e4467d8e2
prerequisite-change-id: 20260423-b4-cmdline-a812ed022659:v2
prerequisite-patch-id: a4f8fe5f0bfda36807ec96fce6497f3c343553fa
prerequisite-patch-id: b63bd69e2333a37621826d6a5f17ff351c94b9fa
prerequisite-patch-id: 590688853b16bb736963593be0d0e4adc81e309f
prerequisite-patch-id: a156d54bf3a24dee421f0a6b34065cb3536affc8

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

