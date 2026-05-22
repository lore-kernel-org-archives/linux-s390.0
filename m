Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2937F017;
	Fri, 22 May 2026 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453003; cv=none; b=roa90weD8QVZiE07LFrjvQIB5g0xsxcDu6krc42x4Pfh/IKmuFy33q8M6tp7K6ZKW51SMSqs2isgC9ousBnhdLatCxxr22o89kLiuye7mAtnGvUnXucWMH/vAQDe2VPLfrTwS5MehVnQccI6LRsmcQj5qAltKI0+aASs9joF5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453003; c=relaxed/simple;
	bh=P7qaDdKKMhVMlrmIM6RQrVjo4d2FEX4zH0cuXtDUDSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cAAjox4PF28ZmyEuobqtphrYP3qaDFiyZk0ppU9x3ewLN4PLMRuBtClE66q/IJrkn+GXQoS4/C4SK/bV9kojxIJjQEovb8LSIKPqR7kifNeyyS5KfAXt13czxNvonjuEsLtDleM0CKYsoRoJ+1y+KzpznzNe7cwwVAjDo4Mi+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kA8be2T9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kA8be2T9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MBi67l591905;
	Fri, 22 May 2026 12:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=O6jrUgtjGnoyKQQ+o+0bSOrrvmxK3GrQqwmQoBTpi
	nI=; b=kA8be2T9Lqk88kzBbJRj9yh+eI1IpNb2BqlMkew0r+xK4ht4OinYYtbA9
	pdN40G80VAUiJL4hJvVh545gZJp+IJX1xVJksXwKyj1kfZF8/NNY1Z8g8OTaUNpF
	eewNwHQER2b1viVqrN54IRBkkqhxdDV9bwh/JrvJ8F5ZF5x4r4jgOsEBHuchTtUr
	MkZRcpruSUSPlnWQoghwlZGad+tIWRXUUGCoegBtKoRWG3IXUttsywWVOlT+eQZp
	+w0yrWFx+tlGYT7778ZsBzPkQSnyFFZcfsHF6naQg5MjLdlq3uGEZVD2VOBdNNM3
	qbKTXgxfG3KAcUauUQdHrlaFFRt3w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h75bvjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MCOBRa001479;
	Fri, 22 May 2026 12:29:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkgtxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MCTpW350528538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 12:29:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A288D20043;
	Fri, 22 May 2026 12:29:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 701D120040;
	Fri, 22 May 2026 12:29:51 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 12:29:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 0/5] KVM: s390: some vSIE and UCONTROL fixes
Date: Fri, 22 May 2026 14:29:46 +0200
Message-ID: <20260522122951.117120-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a104c46 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=WLamS9KfzQc7_2FcH0gA:9
X-Proofpoint-ORIG-GUID: K8gA5b4sElDgODZHxalhEvycZkujkKB9
X-Proofpoint-GUID: K8gA5b4sElDgODZHxalhEvycZkujkKB9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEyMSBTYWx0ZWRfX5839b3q/71g6
 QETd7DSu31lDRLJeer3KMuVQdJ09t73CxPfjCpu9ywNnwfIZDrVXHJ7D8TRoGgLyBDokikcLH5X
 McKcx8wH2OWteHbtEjU6Dh2IQihsjPuS5qnZm5iQAr2WOKjORsqMTDvgOKVOPQn89yizTT/np94
 5NSyJr+u1Umtg2nyLz1eVG+GYJ3b1deDVkIHPObJhf5dAizz5UqOkpYm+Z206lJBDnMC10NN2Sf
 9ZK7dlr9eM7Fdg7o4ZcnT+Cg2+7UJKAMKjfPcA2Tyfn6LDTz2INnUoN6WJJXUNcBEPhcJrs2W+u
 pUEDHKto6VMQKO4pupPPimiCF6YW69Ci8oG+S6kijaKLFw5zlxp2sQwzlcXejbGtZFz9pcbrbK/
 jB3MlpeN3DRBWzejxCBGb7BxwADNoJbOiZh9YCbEJhg3z4qhE36/5H4h8ElClPd7ftoTwiVH1PO
 XYxtzPJXlUU80MyfLHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220121

Ciao Paolo,

please pull this small, but important, bunch of fixes for vSIE, still a
fallout from the gmap rewrite.

Claudio Imbrenda (5):
  KVM: s390: vsie: Fix memory leak when unshadowing
  KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
  KVM: s390: vsie: Fix unshadowing logic
  KVM: s390: vsie: Fix redundant rmap entries
  KVM: s390: Properly reset zero bit in PGSTE

 arch/s390/kvm/dat.c     |  1 +
 arch/s390/kvm/dat.h     |  3 +-
 arch/s390/kvm/gaccess.c |  1 +
 arch/s390/kvm/gmap.c    | 18 +++++++-----
 arch/s390/kvm/gmap.h    | 61 +++++++++++++++++++++++++++++++++++++++--
 5 files changed, 73 insertions(+), 11 deletions(-)

-- 
2.54.0

The following changes since commit 6779b50faa562e6cca1aa6a4649a4d764c6c7e28:

  Merge tag 'pci-v7.1-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci (2026-05-21 15:02:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-7.1-2

for you to fetch changes up to 9029496abfae3c208336855ae6f3e1f5f881ef76:

  KVM: s390: Properly reset zero bit in PGSTE (2026-05-22 11:25:11 +0200)

----------------------------------------------------------------
KVM: s390: some vSIE and UCONTROL fixes

Fix some memory issues and some hangs in vSIE.

----------------------------------------------------------------
Claudio Imbrenda (5):
      KVM: s390: vsie: Fix memory leak when unshadowing
      KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
      KVM: s390: vsie: Fix unshadowing logic
      KVM: s390: vsie: Fix redundant rmap entries
      KVM: s390: Properly reset zero bit in PGSTE

 arch/s390/kvm/dat.c     |  1 +
 arch/s390/kvm/dat.h     |  3 ++-
 arch/s390/kvm/gaccess.c |  1 +
 arch/s390/kvm/gmap.c    | 18 +++++++++------
 arch/s390/kvm/gmap.h    | 61 ++++++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 73 insertions(+), 11 deletions(-)
