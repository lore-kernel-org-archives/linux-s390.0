Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8DC333439;
	Tue, 21 Apr 2026 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771947; cv=none; b=jrdJjDmGQdxJ0tAsl/OgC8fOV0g37XJf3GpGRnMtNVXZ4a5SkupksSloXhIljxix7kNRFqVwZXCRT10h1NHxDw1t/W+EiSpHaKlYRP5mUL9fR9EZcCx9gd+JGKpV07a+DyfDHxdAIVVu//6nzqdE0LHHrZPemeBoRZRExL9+TQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771947; c=relaxed/simple;
	bh=IaREYFeBeRCU+m8Ac53d8IcNx+QL4sJOy4X24CXH084=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IW6YEtOQhokG1/22hHLXY6OU3j3XHStFxzqmrmeJCeNBZ2Jf5QbAaTcgrXhPCnUVUnTZoS0V5E+FcScsrUv529tTMROR9BllcjRn4D8clsNavA9YccWoxnbRPUFLLlQMAjkJn7U6OriJI14Mj1xDc2Z6cyRbadi26SCnZH16C2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Evritmex; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Evritmex"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJgW3f1684508;
	Tue, 21 Apr 2026 11:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=USgV93WvDtC1wwTYswQQfRV+axg3
	iNjGr5tucCDPcDM=; b=Evritmexnxuc1fzG+HN4j3as0Hxc97pOIULBdIQZekG4
	yFXVr7c+YsfJ0zRsoKwDjHFIHXlK4uKayxUYOYehwdaSr0uVbSvJaM8ioLTFnKsi
	2YwDWQzDDlGQYo1GFDAYwLoqRAFGWG/gTm7+KcPxeK+Rr1L+3ziOVAgqWUHVDugS
	tFQsL2REzeQDwJqaOzh3fKEPLVwRcV68L/Dd/mTZ1SYmXBXMQYJFII+WoJuudTop
	SuvvoWhLSdaGa0b4KQtAtLw2MjOHWul9oreJWsI31EprC44Xa0/Bfgpg11v2EA9Z
	TZgUHRmNkHps58bcaVg1SOUBo/f39PHk/xG6Q8Ha9A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6m25r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LBZPC9013716;
	Tue, 21 Apr 2026 11:45:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9k0gcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LBjavS32833900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 11:45:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC4802004B;
	Tue, 21 Apr 2026 11:45:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA35420040;
	Tue, 21 Apr 2026 11:45:36 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 11:45:36 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v3 0/6] s390x: Add test for STFLE
 interpretive execution (format-2)
Date: Tue, 21 Apr 2026 13:31:06 +0200
Message-Id: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNyw6CMBAF0F8hXTukHcpDV/6HcQFlkIk8DC0Nh
 vDvNrgwwc0kN3PnzCosTUxWXKJVTOTZ8jiEkJwiYdpyeBBwHbJAiZkMA7xlAuuajqApDWiZkNZ
 ZXheEIhy9Jmp42cGbePoe5oEdOLLOinvYt2zdOL33f17trS+t1JH2CiTozOQlmfSssLp2PMxLz
 FUfm7HfOY8/IkH9R2AgUkqxIiQtC3Uktm37AKJrb38DAQAA
X-Change-ID: 20260202-vsie-stfle-fac-403e4467d8e2
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=IaREYFeBeRCU+m8Ac53d8IcNx+QL4sJOy4X24CXH084=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnPk+OFXG7o3qt8/7hoVnP+Q3OOrNmagTc4Q55nSJ/sY
 m2Offa6o5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIk8V2D4p3VE6Gz6J9n1DJpy
 757HCPYKCLoaVyVJ2R4If2ridWORO8M/pZWZ5oohbPlP6l8Hvfwv/Fp9+St1nk0t4Q/j7eqjosp
 4AA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMiBTYWx0ZWRfX1miyaLDh8BHY
 XbpgfzFLBiHeaAUE3FrjKxs7WrQ8QkG35TUB1wCySN3j46FJ4wDaxjudkhh5glw6RWL0skxFcDO
 gWsJ5bwH8hxERsezDk1jMw/v9IytL+rwSiobITUhd9Oh8xsDqUfYi8Ah/qyTlB/Iz34tHq1popH
 DaWongLw75MVdG1TM6l+hccGDCYWzfrgEqTl60X/Oc1UfKD0LI6zrZN00IPhcRJtJFEuHcbXZ5S
 tpcvMjs0OWPS/AtlRYDUDT4251PZIm3LzQc+VXJuh3e20jzhAzjQzpw8w8SUS6FGN1xPvJnArxv
 bDjgUJf/GXIuYmwsbZievrmyDCBCvWfkb8ym4T12ibMe7EjtliWvvkNqjQbkazIoMzqn1KTYczf
 bjj3Owz9g0g3YeMfcRdKrvtZd1EXFRQVs3OcVSLf9TI7y4tBshne4yypQXgSFU/fxHV6Ih9+5Gz
 B18bQ0WHHHXU0r1eltQ==
X-Proofpoint-GUID: P7AB6jwYP-Fs85rv3R-Qs_dzTB-rG5kr
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e76365 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=MwmhjpgLNsuZdhXYqscA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P7AB6jwYP-Fs85rv3R-Qs_dzTB-rG5kr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210112

Test the shadowing of format-2 facility list when running in VSIE.

The tests will skip the format 2 tests
* if running with unpatched kernels or qemu in G1 or G2
* if running on machines prior IBM z16 GA1 (where ASTFLEIE2 is not
  available)

Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: "Nico Böhr" <nrb@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>
To: linux-s390@vger.kernel.org
Cc: kvm@vger.kernel.org

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
The original series was started by Nina and finished by me.

---
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
      s390x: sclp: Rework sclp_facilities_setup() for simpler control flow
      s390x: sclp: Use sclp_feat_check directly to read DIAG318 feature bit
      s390x: Add test for STFLE interpretive execution (format-2)

Nina Schoetterl-Glausch (2):
      s390x: snippets: Add reset_guest() to lib
      s390x: sclp: Add detection of alternate STFLE facilities

 lib/s390x/sclp.c    | 30 ++++++++++++++--------
 lib/s390x/sclp.h    |  8 +++---
 lib/s390x/sie.c     | 11 ++++++++
 lib/s390x/sie.h     |  1 +
 lib/s390x/snippet.h |  6 +++++
 s390x/spec_ex-sie.c | 10 ++------
 s390x/stfle-sie.c   | 72 +++++++++++++++++++++++++++++++++++++++++++++++++----
 7 files changed, 111 insertions(+), 27 deletions(-)
---
base-commit: 6123bbbc271255d61873763b5fb9c4a69acfcfec
change-id: 20260202-vsie-stfle-fac-403e4467d8e2

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

