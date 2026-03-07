Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D0C13B;
	Sat,  7 Mar 2026 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841943; cv=none; b=ob4tu4JS/YarIHyBDj/R1anyOANu1a7qe+avSjUroCUjrvHVayispPlAip9i+xHWOcF7Ar0/MauqwsluG2fu/bs2dyk79JU6n5ke92FLAlodTgs2zJhL0g1v8fjtNxuALcU/ds4fO6aMBm3EI9Xng5l8awCQD/DGBAokWRFfiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841943; c=relaxed/simple;
	bh=bzULGLbg6oGKonbxZHELbDUk69cyz3XX0gK0e3MHumQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DL2CAmoXPnQAUBFXkbrh86IfsREBlWabeWtWrVFguk8MmwCm5jb3P9doMppJf/mPOFPeuaIQitTbpNG+KP/B/al1R3JyCwSB4OhchRXn2vZqD3qREGX4FJWWe4OXEOneMPl5Xnn0bGUUumQ+hiW8MARdM2fHi2SzvLdKKGexYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RkN6SwPv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RkN6SwPv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626Fm0711233029;
	Sat, 7 Mar 2026 00:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=Y+R2UgWeche4G4w2nskgf1a1Q6Q2heTPx/nbt4+QeKg=; b=RkN6SwPv
	dHjizmtCl//TAjD6uevL14aSvwnDOxA3H1z7+/nKvvt5zNczf9Cgbsc+kA2NKQ1E
	DdgXqG3Dm7DBvGAFJe2W9+bzhoLlR9wTY+g0b/nbYXnpUQDUAutdMJk+m0EsufJQ
	m6Fk3cZvA4yt+FjDBefQF45EGVc5bntkb283RfPpwM8oXxyClPPB/WpfIkdK4WkV
	PPcIAtnzMcL80kA2+5myw5SJbS30jg8uCSP0ulMsTFlbggs6uX/Xjn//nFYC/7Nl
	yKi/wsltSTV3mP18RXhnDYFUFScYOtAvpOjXLWA/1BMPnXnax3XrS7141URg23dO
	JAuQDkYVpegD2w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk4a9qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Mar 2026 00:05:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626NtNXt027713;
	Sat, 7 Mar 2026 00:05:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjsrvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Mar 2026 00:05:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62705ZKj49217830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 7 Mar 2026 00:05:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE3ED20043;
	Sat,  7 Mar 2026 00:05:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 720E920040;
	Sat,  7 Mar 2026 00:05:35 +0000 (GMT)
Received: from localhost (unknown [9.111.48.204])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  7 Mar 2026 00:05:35 +0000 (GMT)
Date: Sat, 7 Mar 2026 01:05:34 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.0-rc3
Message-ID: <ttbi5la@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BafaxdXFhN_b1zK1ETjZhvCvXqMMWvYp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIyMyBTYWx0ZWRfX6/pW4KKduIAQ
 ktT3f0m2sWNkfVJIh3YoGOF7RKXjkAnLXWE75ifyyoUpYDbTjJxVxdA+/PNBYOCUE7JoD7CEtMi
 OCCpScAvQ8eAzzVMbh2dW1hS6eUWUvHWalE1RNVx+WgZ22jKDF5K82ugf/Cm+PF5m4UVpeHq8Hu
 jZQ/lvFEJ0wvSy9oL95fBD8VXK/vNlMGm8O2X4N4fnM7802rRsgkUJniF82tiksWuO8oHqx+8gm
 zbhw3U8BGAX93gOC7WrXw2/n4+WZ0IZhlcoUNj6VXVWdXVRG5TQz8jdy8Cr/ZNY+7Ef9wQubYXG
 Mm10yFQpVbjdA5/pAzT0ZlTy8unQIAE3Sws7aC0xxxAQf9aUFhV19EGHQu5Q3fecqRY5nTi1D0S
 momCjgv1N0IvNCyUKoZdf3rUKGyCJEYbEnpclZtTrZ3WTFt8AonxydgwpldB3i727DO/AzyeV7p
 4GRU0p685vF4QFORgvw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69ab6bd4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=tXdEs6FklAayX_DD9KUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BafaxdXFhN_b1zK1ETjZhvCvXqMMWvYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060223

Hello Linus,

please pull s390 fixes for 7.0-rc3.

Thank you,
Vasily

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-4

for you to fetch changes up to 674c5ff0f440a051ebf299d29a4c013133d81a65:

  s390/stackleak: Fix __stackleak_poison() inline assembly constraint (2026-03-03 16:42:14 +0100)

----------------------------------------------------------------
s390 updates for 7.0-rc3

- Fix stackleak and xor lib inline asm, constraints and clobbers to
  prevent miscompilations and incomplete stack poisoning

----------------------------------------------------------------
Heiko Carstens (3):
      s390/xor: Fix xor_xc_2() inline assembly constraints
      s390/xor: Improve inline assembly constraints
      s390/stackleak: Fix __stackleak_poison() inline assembly constraint

Vasily Gorbik (1):
      s390/xor: Fix xor_xc_5() inline assembly

 arch/s390/include/asm/processor.h |  2 +-
 arch/s390/lib/xor.c               | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)
