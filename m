Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D17A477E38;
	Wed,  6 May 2026 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076731; cv=none; b=LaCg3wJEvtZptPm9Sg93vKAggbVEGsDGG/L2x7zqFpvGynCTV3fDD1hDrNf+datOiyWKrFgv6QzVdqARqUEQsRfknYFowpybCKNX9ZkQTMUpEtT7DmOULzdRggU5snEbcgn3g72TFs7UvhJ8wkl81jL+l+PCE3C6A/gkbVDL0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076731; c=relaxed/simple;
	bh=+6wcaLLZPKP/zuIur69NMZsGh9M1Z41GftAPr96X5MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjVKwlW5bQPgLHKC5Y/efxLS9LKFEObSPeRlkuIVgvv5naVJm5YeZKvYwaL2Vbic11k8HPI4xDXregirB+90kR+I8iNHILH6vNYXlu0ddx+QudP1Y+JqrsyVbkCQ3J6bc6DXqR9JvSgAkUK900shnCv5HUpWCp4njX7DdeFsqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q6LyjEf1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q6LyjEf1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646CuksL2899203;
	Wed, 6 May 2026 14:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=i0tXywX0RkLWGqIQ5isMN8rxqfkBCundqUiP0w9OT
	9U=; b=q6LyjEf1jCMgoouZ/bZXDR1DiPH1DhvRvlva64zN4xbymtaXFQ1jPxrpt
	ZlsQBtcM9vmjYwKh/nV6nJih79zDFRb/FyuHyIhd6a4hotD9wSLLlZpv3Eh8nPQf
	Ugi0hsPaUfuy5y5LfFhAXchT0CMHN1/MWPAsAeLGvou6la9rWlRy6m7IP5IhKf0y
	7Eq4ovo3PM5w/2TRDF4FOd8TgBMOQ4GvM9bf0KmSfG7gAI0S+CbibRktD1oQ6WFS
	0KUjj13n583YnRk8bAsJOSTUB4o0uHeA6H99E2Rz+x3WOa95K4T+dVo4MQ0v6AgF
	HhvJmHnz+tozEgzhqhLEPNCGaTQvQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6gcv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:12:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646E9bL2025458;
	Wed, 6 May 2026 14:12:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9ye9px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:12:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646EC0Da60162494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 14:12:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 404CE2005A;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1136C20043;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 0/3] KVM: s390: some vSIE and UCONTROL fixes
Date: Wed,  6 May 2026 16:11:56 +0200
Message-ID: <20260506141159.154240-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb4c36 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=ikpnumYZmNHv35E1yZIA:9
X-Proofpoint-ORIG-GUID: wQ6gcLA43BVs-5SCIpXjyMUIS9qx5CVk
X-Proofpoint-GUID: wQ6gcLA43BVs-5SCIpXjyMUIS9qx5CVk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzOSBTYWx0ZWRfX5K1U+sqxVAZn
 182E4oS6EuAEHrH9I4X/lgRZkUKmIX5Xz2HOAps9aty091vn1fVTsKSzuLDotTDKthU65j+q7Pj
 FUl7yiJBjvE4HQHjalm5PuTNmuuTHdCJV4+vikB5KwBaQlfQfZLL783feEJY8NCtXwJj/GqRYrs
 NaZBxEW7MoCxyKgzvpajW+mj0C3J4Lr0Pe3+Je+fYyhNHUxNxTMht00MEe4t7m8SdZvlVko1ged
 osxbxzw2JgLqM9q5uoqb0hZjzUXphFSOQwpDRb0uX6j9qWoJlA6H2sDNRfOh9HVdNQhon1MQWTF
 h03pDspGrZlmWrKMmgnKUV2K4iIj+YCZh+NGz1lX+1rRsEAvwUOITJr+1uHEZcuPk5QTiOj/W4R
 JDBkNiuRObOVATxggBGOACgF5H975b6H98VL8D3UWqUGV1KL65oQ/gjh4CY49MPMTqntzTHPdz6
 4DahrhmXS6DELIHAeDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060139

Fix some memory leaks and some hangs in vSIE.

This is still a fallout from the gmap rewrite.

Claudio Imbrenda (3):
  KVM: s390: vsie: Fix memory leak when unshadowing
  KVM: s390: Fix memory leak in UCONTROL path
  KVM: s390: vsie: Fix unshadowing logic

 arch/s390/kvm/dat.h  |  3 ++-
 arch/s390/kvm/gmap.c |  9 ++++++---
 arch/s390/kvm/gmap.h | 12 ++++++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.54.0

