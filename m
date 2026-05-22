Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4736CDF2;
	Fri, 22 May 2026 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452530; cv=none; b=gEIi62U0Wci3gHhMAasyqN+xEPwvpwSPJSLLxHivL3NC35z2lPmyDZmGLAaIm+NIJTcXGvhWlHz9mRTTJfxCTZH/RuM88uLpqjaR66U/iJjiu2rfO8wlgowmF/M4a95zSJbqxyL26U++AdQNd09N6uYFg7YhEPVx9FLGQofwNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452530; c=relaxed/simple;
	bh=O7Z5/jg7KRAqtNDoR8/b+RkGEEJUHeglp67GkRPGg9U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ocMw/Og3gBd/EBSTltb4S99dOZkNPIAp4RiBw8fq+yPqE0ldT4yK5ngStWkki2jEUxfNA5YshdTGyET0UJNQa/fIRHrjO7quVi9PrZUI6N0UvPoa967QP87ebqX7eX4KKSwXTiGbJMVbUop+xTWjR3VUVJOhyKPF+QrAPHIU9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GpuLH243; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GpuLH243"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M5U87a130203;
	Fri, 22 May 2026 12:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=mcJ4AzeXOa/Xauwd+EzhGWJEHBr3Jg4OFVOc3V9ugBc=; b=GpuLH243
	uWUOcMBaDq6zKf2K43aHltwtvq1FGqZobmuTAGQwVfRlm+l9CDiM+bXpgNpg9KPc
	ViC5d8jk6/ERBmr1vL6VCPbg++2TJAWOixMgaJ7O5eR1tW4UglSvuP8rpfH0rWmY
	YPSfJEEDtWgO52LJD6TvQ3/agnBPgtLzwInvcxZnOss+k6sKO6Ny39WF1aEfPJhc
	x3S4Rh3Gf63rG1D+CqshDExYZ7KCjPSNv8EBD37HFJ7EF+RytJq+rGhBWlfJk7Gu
	U5x2zmkLPa4lCm1IDgXR3uMUHlgA5C22gfasyBxKonM7/rtCX8eQp6Mop5OiZke5
	rkuf1c8vNIcD4A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88tcjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:22:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MC9Ekl032552;
	Fri, 22 May 2026 12:22:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqh20j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:22:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MCM2qB47644952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 12:22:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC59120049;
	Fri, 22 May 2026 12:22:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A391320040;
	Fri, 22 May 2026 12:22:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 22 May 2026 12:22:02 +0000 (GMT)
Date: Fri, 22 May 2026 14:22:01 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 7.1-rc5
Message-ID: <20260522122201.3111318Aac-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3_Sgc9uD0A4txXp4Es7oLFMAtXAKughq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEyMSBTYWx0ZWRfX/KlVBd3eyw7Q
 zuG53658dPKYyCiqmFXqwhlFjmGcMKXy0q7okUbD5hEVyQNyRZefo4UptYcM60ti/DFlJyT4Jdj
 BA8Zn2VRGcfcq6yhjogpStSiHPL4y1+A0uwieDTBbX8rnHQe8qDDl1UPW0aZY7838kvzXXyIiAQ
 oYjkFeACl2eanVe1kouJz1VDECVh0H5o0p1IcuDaFinrXQurmOj3SvGMbl05s4Z4+Y+xJN6ssu8
 Ho1Xg8qjzfq6HfYWrWK67kRO3lnv5XIYGneszKQ/duEFgrS/RyBRWurJoVhs/l2yjMiZqn9lxVy
 pR+lx/F9uknjOSID+mXNOPSrjiApQ30w8HfQwjvcuqCc8BfiGF1D3LNMXonv2I6VCV87dHSDJOz
 G57ic5Gp9y6hL/hUoESeiB7Xs4XSP2dXk5Gw28e29BFEUrotqeNlk0QQDbW2jgIzmHoP6fP6umq
 X77y0rp0cv2HorSv8tw==
X-Proofpoint-GUID: 3_Sgc9uD0A4txXp4Es7oLFMAtXAKughq
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a104a6f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=bbDwr-No4U6dU8bOYbIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220121

Hi Linus,

please pull s390 fixes for 7.1-rc5.

Thanks,
Alexander Gordeev

The following changes since commit b95e0e792822bad8fc9eb33ea3a90005e29e75e9:

  s390/mm: Fix phys_to_folio() usage in do_secure_storage_access() (2026-04-28 14:45:03 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-3

for you to fetch changes up to 540f4a4f6ef806a28e794001bb4beac4840a6090:

  s390/topology: Use zero-based numbering for containing entities (2026-05-20 09:39:24 +0200)

----------------------------------------------------------------
s390 fixes for 7.1-rc5

- Fix PAI NNPA mismatch between counting and recording, where
  sampling reports twice the value

- Fix loss of PAI counter increments during recording on systems
  with many CPUs under heavy load, while counting is not affected

- On some supported machines, CHSC cannot access memory outside
  the DMA zone, causing CHSC command failures. Restore GFP_DMA
  flag when allocating memory for CHSC control blocks

- Align the numbering scheme for higher-level topology structures
  like socket, book, drawer with other hardware identifiers e.g.
  in sysfs, procfs and tools like lscpu

----------------------------------------------------------------
Alexandra Winter (1):
      s390/topology: Use zero-based numbering for containing entities

Peter Oberparleiter (1):
      s390/cio: Restore GFP_DMA for CHSC allocation

Thomas Richter (2):
      s390/pai: Disable duplicate read of kernel PAI counter value
      s390/pai: Fix missing PAI counter increments under heavy load

 arch/s390/kernel/perf_pai.c | 31 +++++++++++++++++++++----------
 arch/s390/kernel/topology.c | 10 +++++++---
 drivers/s390/cio/chsc.c     |  4 ++--
 drivers/s390/cio/chsc_sch.c | 20 ++++++++++----------
 drivers/s390/cio/scm.c      |  2 +-
 5 files changed, 41 insertions(+), 26 deletions(-)
