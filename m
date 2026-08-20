Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE077474246
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234687; cv=none; b=iMozV6mn8UJmTK/+swvkCsjR5YwvENVwWjwjSVWmxv90OO89zdCQ5I3kP+15mUF68MCQ07xensRgnxf48KuWsndo19Mdr3Ozx0tZ8EE0vmh0T1uf9IY9fNR5vvtJx+qVRvDefinWCoQJiwvw9lurBpkoZVmdYMgPdBvgCx/etAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234687; c=relaxed/simple;
	bh=5exnWWMWFLPVNSLniltalMAuvK1SM/zimfft8/TZpXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUxHFqGnBnkUsO9Ipquz0rrPhLXzURch37L7yxnSmpQ9QMoqyq+K9V4Wp7G9E7baQUVIf3DdLnQQ/SvrP210u0yosVGlVdFmI9eRYSGWWYDLBujHAmnW2kuop+vxKq0PK8qcXm0iJ2xo+RGkmE+/bA1JjQYeR+FdYESrWYEK+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kksTnrgU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kksTnrgU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K9MKCv424416
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=t4pxv5GiAqsbG+x8Sjy10egS57YtZbWVi2rg6FzOl
	SM=; b=kksTnrgUGQvoxou99MaVpXo39Y5PdoOdKUP83gi/qY6VEMRfHqWEg1UsZ
	pL/XH6zvLbq+JapWT/71XSRCRzvexfh+pcf+QKyfgiGLGkIy+qjVyadv+z5c0Br3
	07PkyCiy7vlyblNikBzxh+2ZhysP7FXR34t0I3WnLp42ezNwarUe5t8tQOY5vXOy
	mAXWoceFDaQGGSV71d7N2n/yFXqYZxZIFL+E15owdVl1/Z+qHN+WIFGuDGy0H2/K
	083StTWT6Ye2tvgOvKuTSElqRW82iqwRzoSB0aQ00AjNJVP4YOzNz1R9Z9B8mm2f
	QyMxhcGrjv/faTef5EINsEWcotYww==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1jrd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:04:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuMKw014642
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:04:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ypn8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:04:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KE4d6i44171728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:04:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A750920043;
	Thu, 20 Aug 2026 14:04:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E9CF20040;
	Thu, 20 Aug 2026 14:04:39 +0000 (GMT)
Received: from ibm.com (unknown [9.224.91.220])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:04:39 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
Subject: [PATCH v1 0/1] 390/zcrypt: Validate length information in reply
Date: Thu, 20 Aug 2026 16:04:38 +0200
Message-ID: <20260820140439.892324-1-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a87097c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=MqckkIrbGG8MBoPC69UA:9
X-Proofpoint-GUID: qcxucVyiUwTUg_lPUUlrbPGR3aF09W9c
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX2gEZsHrpJaSL
 UTFCR9AD9aJDnCKSJr9I9yFuIuxSCIE26y2kojrmaXpi0C+r235b/PYuMyBWyT3BlzlYX9ajmWU
 NfIegjXSRtn/d8l80lDa/GO/0oXIQQQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX7lLMBChKDhmC
 T3B8p7ZsQoBbuUu4Vqp09CWUkbfUzOP7LNqJU0YKmPLMWxO946Vp09VuQGgTz6sgzdNWuPw8TqX
 CXdduTxMX1aqeCVmPGtHc8xCWYkKsL9noUsA0NzDeEtVtXEXpjDo/InX9RIeHcYHxHSnWuWId3l
 5PlSt13517ReYKAOFgmtoD3Y8z3pPq+dkccbutFOIXzvLzi1I6YxK3iUThG1cb+2bDI92OZR+rI
 V36dMkhjmUxgs7WCVmFj6bcWVsdoLE8qBUBqI9kRvJtocdtJnTVdIuTQDlkEti7dENBBwFoJGo6
 58HXkCYEtF7imWFjgCb4lcKhyEcHYztdtEE5j00gFRfrcXD5AKVrvVul1hCA+Di8JRJoZ2GLhyx
 JC06W5CNZh+9ccUJcUMlsjxzZR6F+9PCBInv2B+GHydWxmLMVnTGTfdwkRxOOCAbvVd7Ipk74lw
 RiCkK2NEGurDkuGQxOQ==
X-Proofpoint-ORIG-GUID: qcxucVyiUwTUg_lPUUlrbPGR3aF09W9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105

This series contains adds validation of a length information in a
hardware reply, to prevent buffer over-read/over-write in case of a
broken/modified replies.

This series applies on-top of Linus' master branch.

Holger Dengler (1):
  s390/zcrypt: Validate length in reply before using it

 drivers/s390/crypto/zcrypt_ccamisc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)


base-commit: 59e6295fac26b8e85c1ea859cdd89fa1e47519d7
-- 
2.55.0

