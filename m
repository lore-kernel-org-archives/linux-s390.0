Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0333311967;
	Thu, 23 Apr 2026 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954430; cv=none; b=rYkT/QJcUh95QFqYElm643wFRaSOSND7vq8Rt3VTR1gzB3/IAh9lzm8L0Z9uC4QVMNpIFqinYVh3uXYHGfqZ4o7BUmjwaYU47lFAMM5G7gphTAf6oS3H15dAKR5IJSh4FVf2miyMJrzqH5FjFwDUFh8bqSWdkohwz2EhWJ+5iew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954430; c=relaxed/simple;
	bh=lM6V0bzSahFntk6r+/mn6Gn1o5v3gobkoJaEE0WvLgI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JZeJQS0bOcBlOFFpLaxqlVk+FnIway4aeimi9R4cg/FWEGBAu/LfWcm70T1Bh0xoIqIrFFhoUfrYGUUmbcqKb+M8sWw385F3kE6ympxZmKiApXaloGc6qCkZqh8h4Pv3Iarcmt7rIe+wvJiaoRmLYKIVeJNpHXXA/QTJRKOJnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e6nY0QDM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e6nY0QDM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N86KFU3291979;
	Thu, 23 Apr 2026 14:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=LZoJcU11omsJG9tT8g7dZCteo24C
	GlOxzZtSg7znF/k=; b=e6nY0QDMBZYNZHvxdK00atNMEAXvJqUOSvZ4W/8EUvaa
	KGLiZP5/dB/tosq4EFUOjg8Kz71VuhHbN/cmFO+paeQA09zY+nH3bFnvaPmkQGY/
	pflTOPoPlFQFddKMKoC0c167xHXy3gfNalrXVPiYmmtR3lkDs5UgCbFvI8vPS0FP
	RpGOsZThHI9UWryeVTmqMRgDD/Qv+oGW5AHzybogdtwNMEwLPmqT3u04+knWZ42y
	C+R6x8PXkCz4fbj4n7xmw2EATPFLviOrsnRc0fUOHb/yn2CwlMaDBOhg7l2K7Wgl
	8w8GHhNPKlnD7ith09w2vsCkj9X/gMF7tGWD9llk7Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrgg15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEKSXp032544;
	Thu, 23 Apr 2026 14:27:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky6xn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NER1pC31719732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 14:27:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D03920040;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 250C720043;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v4 0/6] s390x: Add test for STFLE
 interpretive execution (format-2)
Date: Thu, 23 Apr 2026 16:26:44 +0200
Message-Id: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QzW7CMAwH8Fepcl5Y89FSOPEeaIc0/APWSLola
 cSEePdFZRIS7BLJsv2L7StLiITEts2VRRRKNIUa6LeG2ZMJR3A61JjJVvZtfXhJBJ6yO4M7Y7l
 uFbTu14cBktWmrwhHlwXcs8/i+Rwo84yUE/uo+ROlPMWf5b8ilqo7LcQzXQRvue7t2sB2GyHH3
 ZnCfFnR6Fd28gtX5INQUr8QshIdOjlCQreD+I9QD0LL1ylUJZQFBg0HZ9QzcbtvHfE91+vlv9V
 Hk8Br3lPeNlOkI4V3b1JGrB23X0MDBrp3AQAA
X-Change-ID: 20260202-vsie-stfle-fac-403e4467d8e2
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=lM6V0bzSahFntk6r+/mn6Gn1o5v3gobkoJaEE0WvLgI=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmvdEySL0sWJcdMSGkR2/eW832RWu67HRVd/0R+sJ6Tl
 TRpTuzvKGVhEONikBVTZKkWt86r6mtdOueg5TWYOaxMIEMYuDgFYCIuwowMP5wPilpfjOmyuyE4
 R24C1/HY9SXfj4nzClsopginrcjpYGSY1r7Jh/u5neRknY4Lph+6r9rd1l7zQDtiT8baC9Neu83
 kBQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WP6c_cU9T63nbZMCKu5srb_Wu7A5WeWf
X-Proofpoint-ORIG-GUID: WP6c_cU9T63nbZMCKu5srb_Wu7A5WeWf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfX9rjtxQXk2sr+
 IF+U7h14zrWV6vuec6mC+YcMOjCW/7y6P96vcAe5DyoqBaWtdULPbuBTUoTj5roVl2GGe2oM3lW
 LhHrsGXy3R2ozJ3HMXmfuY7kME0Dt0hrSi7EKZuSnj8gErqWa91yMAOcu/a2cPgp86qObJYyMAP
 IPbDTLttLaOQjtFuwnvwHRF2LaqBY+wwKONQrSzH48sKZHNJaGzISZgjqG1VTzAgqlOYbSF0I2y
 qMw2CkeNwXbdTsKM7bNbSHkn2mif0cYhVBSvhyl4IvxHC/crfwlPKKkxODsOQq5Y/EfuSwrkUMd
 eamr+xGNc3oxJBvmbnWe0P+CX7usjP2CdcDZ6k+YqBjKgysGX1GR1CRw3kQ/tGUR+1qYqf01xz/
 Uh6dhz1DOzeZQW2xUtzgEtNGXLTWMuqM9FP8NkrZpb4BFMLg5bayKanqEvvWkZoGfrPeIWdoP7X
 N0y9WDCsUqt+wmlEIDg==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69ea2c39 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=X28-lOWfyt9Dm7dHER8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230142

Test the shadowing of format-2 facility list when running in VSIE.

The tests will skip the format 2 tests
* if running with unpatched kernels or qemu in G1 or G2
* if running on machines prior IBM z16 GA1 (where ASTFLEIE2 is not
  available)

---
The original series was started by Nina and finished by me.

---
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

 lib/s390x/sclp.c    |  7 ++++--
 lib/s390x/sclp.h    |  8 +++---
 lib/s390x/sie.c     | 11 ++++++++
 lib/s390x/sie.h     |  1 +
 lib/s390x/snippet.h |  6 +++++
 s390x/spec_ex-sie.c | 10 ++------
 s390x/stfle-sie.c   | 72 +++++++++++++++++++++++++++++++++++++++++++++++++----
 7 files changed, 97 insertions(+), 18 deletions(-)
---
base-commit: ea91ac1763561b23e7eba3f7c1fa3d45f29b89be
change-id: 20260202-vsie-stfle-fac-403e4467d8e2

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

