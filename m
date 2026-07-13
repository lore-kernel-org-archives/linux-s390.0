Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4243900E;
	Mon, 13 Jul 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953761; cv=none; b=hZDoiuS6zl1r6iut5J4luxhrcvzwouE4BzD/6kUP6KVWbwhFszLkpUZBuWsoduVRZZSCuCSBog0HUIVlSFRlWiqz3hF4blP20DRIYP0ezNa3EZxGgL6aGUicvJM6YAlITI35OYP/YYynzFynBLSlgLZL3fgB8iTI0Vk49hX1TlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953761; c=relaxed/simple;
	bh=q9RDx/MSHZDqOQVhPWPbygYd95THqQgUIaSWVg3cXIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lg6jG0kvH68a49o59Ke0ibPTlkdjDdZfMJ3B3/cZQWTFC+n/2hM3T/osjR36R6c4bWPKbqkVRUcXk8ds/BWyPqCRtSZwZG4AvlVpHkljVPUdzkXg+y/dYFB6mDOI6rQrdMCjqeFQW6lUHazN+WrYvyO2dv8RSMTxBnSajAzjclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kyb5mlRL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kyb5mlRL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCD1Tb2375266;
	Mon, 13 Jul 2026 14:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SWjcVdLnz9p9O6sFEufEo40kMYTf/Zpi87oHKvWJ/
	3c=; b=kyb5mlRLweC609luLKCtrJu/DJiWmZSe3YlJNIN1Oldv1Y7A3tw2Oausb
	wvnAAhcNwMJvCvO+m66CvB1O1xW3cUE0BiTO64PMo57UG3E/lpjd6gUg2K24qIEx
	KDlu+XlVbUcOKKBhy8kKWBG+iqDePD/WH/j+nCcnn4I6NRRGep4FZEcgChC5FNsm
	X9PAyKoiyZ26B1vk8oGkZRMheh7pZNQqQInbYt+DCNT10iR+AhlZG0wXW74ePEEf
	TnfMxeOibbW3nkpYo0MKnfALa9VCqnqj2JUzdvg/QvPmNg2ekNmuSSAaXhAJvJLK
	76MTNIH9OZVFixhqreaRHR6rzpifg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a0t7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 14:42:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DEYade017246;
	Mon, 13 Jul 2026 14:42:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg5wbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 14:42:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DEgXaB30736776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 14:42:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAB8E2005A;
	Mon, 13 Jul 2026 14:42:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB7F20043;
	Mon, 13 Jul 2026 14:42:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 14:42:33 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/2] s390/vdso: Fix GNU_EH_FRAME PHDR
Date: Mon, 13 Jul 2026 16:42:29 +0200
Message-ID: <20260713144231.1251145-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX1i09H9rgbD4z
 npXE2/oiPAxwxal4Z6eYDVhEznsZZXrprbBOhMnMKJVNTDXE+IMn/j/UA1nmnfshePGuoivd31A
 4amh8vjCjoA/BcM4lNoN11jYutkso0c=
X-Proofpoint-GUID: sKAJPyqPSaJWT5-JfRoY00amIeutDUI2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX0M8pFbMlkOw0
 b49hg8zPERPAsYQOrNtBDUOBjUL09b+3Ws+VFKA8KF+MGsQp6zwm8gV6v4nFwFx+mU8PiXzjqGU
 wXcfKJHxJRkMfIcz7xt3Ob5BFy77uBpct7Knmc5ST1k7auE0bFQEYPSI28lmdUhKONJqKVSWhrb
 6F14qhfKoQUrI442bEb+nPt6F/xpA3VaBw9AKhCc4DDmhtfqtlC89/bnv+7ZQE/dAriQVRCD1lM
 B8XDgBvgd2zWgwD/oSikVnbWLhZEz5+LVGwXpNquMIpihBMmjFsMSJrwRqUxstsp14N6DOEQJ1x
 2X4W3NX9FifjLcDjHalE16HxDEch3Eg6mmSXtEHQAk6z5OXgAkg0kGBEo8pgsXjM2bcZ4nlprhL
 skP1so8t/+Jnky1ByOWmF/kn9GDfC6sAfXa70pdY97PFRJX4jrcrIxBS2Ss0gmNBPuROk9y7NRX
 qyKNqTDvs1UzDlSq5jQ==
X-Proofpoint-ORIG-GUID: sKAJPyqPSaJWT5-JfRoY00amIeutDUI2
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a54f95e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=L-4QY-Uup-fI9X5xHgwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130153

Patch 2 uses symbolic constants for the PHDR permission flags to improve
readability and explicitly specifies the GNU_EH_FRAME PHDR to be read-
only.

Changes to v2:
- Address review feedback.

Regards,
Jens


Jens Remus (2):
  s390/vdso: Pass --eh-frame-hdr to the linker
  s390/vdso: Use symbolic constants for the PHDR permission flags

 arch/s390/kernel/vdso/Makefile   |  3 ++-
 arch/s390/kernel/vdso/vdso.lds.S | 11 +++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.53.0

