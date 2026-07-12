Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DFF2222AC;
	Sun, 12 Jul 2026 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783879585; cv=none; b=LoPbq3kMrQAORORiIGMhku8qQhHvxrqg3kEXa5xUjWSFFviT3gkPcNaLjcUKiXj06Iy0fwb9ABLniUGQoY+MfHMCHIgaFUf/nEj/NrZAAHmUhJTPOR5xCAfKYOSOuVx4nf9EAfpL49tlhukYyzO2GNLJM4h9YCpzSNnmbpt0hfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783879585; c=relaxed/simple;
	bh=q0/nv5RwKYGQhTYU24/ah0KsnrCuhTX1ytm/bz0/jBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fXGhVZ9ow8INNYfsDjYNJDyI1L2ObpYU+MVF+F52gpcdj7vqGpcAK21CPyJ6rVQfvwt9PlSqRJ+IRE1Lem1to9Jg71wszdMU4EnKAvFqtxQIqmKK9hr/LqgbzS4vakkWRNP9xoYHZbcmjFdUcKAoMHD+qqYAZ1tkVEaa9Mijz14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sa0FmZO9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sa0FmZO9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CHBjkV137332;
	Sun, 12 Jul 2026 18:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=/rFtVRdSO2/Fq0Om1Plhrq4kvr98FH/em1dAPqEIN/g=; b=sa0FmZO9
	jZx/LpnFqH4vyr7TyR7DMpKl6L8Mb1FohGQPsKvcdKEpnjf7OPaGQ2ytYDoc+Wbp
	I2WdCqqdiMHrx4HzPXtitsqD+ourmAmvsC1flRE/+L3ADmcQIjPi0RoFvSF6Xq7q
	bDK/0vxeBDdPNLpVwbYdLn6j8j9lYAKnKN2E+iNbWq/DHeoZPXm8VdCOjFvr0QPs
	92GFKu+9TLheZUJ9L+9Um4VODSUw9iRV6s84Iaw99s2vbV/O2fcxvfaqRcLdvz5c
	DLYeWJXOPkjjsUMcbXTwUyvaoAH9U8YM/+ELqFdn1zzNs+MVevK6DqAPYhAYKOvv
	3n3EqxLIEEC0Yw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbd1nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jul 2026 18:06:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66CI4cAK025425;
	Sun, 12 Jul 2026 18:06:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jjfpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jul 2026 18:06:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66CI6HF429622776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jul 2026 18:06:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2C0A20043;
	Sun, 12 Jul 2026 18:06:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76D7520040;
	Sun, 12 Jul 2026 18:06:17 +0000 (GMT)
Received: from localhost (unknown [9.111.25.5])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 12 Jul 2026 18:06:17 +0000 (GMT)
Date: Sun, 12 Jul 2026 20:06:16 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.2-rc3
Message-ID: <tti2qag@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a53d79e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=6-hqe5jbB1Gv4S7O8j4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDE5MCBTYWx0ZWRfX02ttdHyKZ8iU
 yS8Q6wsrc+MsAhJtW8DNF2xYVQn4U35jDWdZ47ie+IXWbhjA8iDkGfdfyoKXsrihJZ1YwFS0ZIB
 LX6u7d4UurTscqbdaOYDd68anbpVnm5fbdLbycmYGNodo7b8xxP/CGOI+QWyikyuUvc+npyj4nf
 oYH12adi1CSYhHutHbVBFNHV24YtUQDv/Xi+txkAnYO7PERhWBO4Mf2axzNivvV0EC9hmxcuVoD
 hdNSffoIUy+XE4a0OrG6mV53yxVaAc0YCSvs+jJtw9C6h4tii6m84FBiE4gh2MOfU7LEoXzzIPE
 2sqkrxbKeprHKxCJmvHoOc5IOfTakQp6mDmJauxjEME2w7VVmNinHeoo+VjQNGnmCzJVnHJ1ciI
 MCIj5SpciLFmdtJ9zXPE8YfZ60KiX/gXMF08ao8e7WpAoKH0X2APD7ldJB8pKOv6HUDtIf9nYxO
 JK3aGquazGpE40SBOgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDE5MCBTYWx0ZWRfX7iHwbq/Obn7c
 DA4/KiYejhwgYgjr5HLgwx44ZM17khE6JJ4eM5q2mP2F7OANShyYofTJAcsp0UEr790YJoC98ZT
 FgE/3pYPiPGb4bcyoRIUiLO7gmMpsGc=
X-Proofpoint-GUID: 2CbZDQOQPWAhPnsnel8MFmcpi3vhTp3F
X-Proofpoint-ORIG-GUID: 2CbZDQOQPWAhPnsnel8MFmcpi3vhTp3F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607120190

Hello Linus,

please pull s390 fixes for 7.2-rc3.

Thank you,
Vasily

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-4

for you to fetch changes up to 7d5c2f679147859c1db97d9f66366ff16909abee:

  s390: Add build salt to the vDSO (2026-07-08 17:02:48 +0200)

----------------------------------------------------------------
s390 updates for 7.2-rc3

- Fix missing array_index_nospec() call in diag310 memory topology code
  to prevent speculative execution with a user controlled array index

- Fix get_align_mask() return type to match vm_unmapped_area_info
  align_mask, avoiding possible truncation for future larger masks

- Remove empty zcrypt CEX2 files left over after CEX2 and CEX3 driver
  removal

- Add build salt to the vDSO so it gets a unique build id, similar to
  the kernel and modules

----------------------------------------------------------------
Bastian Blank (1):
      s390: Add build salt to the vDSO

Gerald Schaefer (1):
      s390/mm: Fix type mismatch in get_align_mask().

Heiko Carstens (1):
      s390/diag: Add missing array_index_nospec() call to memtop_get_page_count()

Rongguang Wei (1):
      s390/zcrypt: Remove the empty file

 arch/s390/kernel/diag/diag310.c    | 7 ++++---
 arch/s390/kernel/vdso/note.S       | 3 +++
 arch/s390/mm/mmap.c                | 2 +-
 drivers/s390/crypto/zcrypt_cex2a.c | 0
 drivers/s390/crypto/zcrypt_cex2a.h | 0
 drivers/s390/crypto/zcrypt_cex2c.c | 0
 drivers/s390/crypto/zcrypt_cex2c.h | 0
 7 files changed, 8 insertions(+), 4 deletions(-)
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2a.c
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2a.h
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2c.c
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2c.h
