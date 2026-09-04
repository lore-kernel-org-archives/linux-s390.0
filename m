Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB42D738A;
	Fri,  4 Sep 2026 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502020; cv=none; b=KHMuhTxSVdrQL4uMJW32AIpHj1CiixWBtN4lXssuW+i2c3RAmGiKEhrBdP1pmIo7md1pOkVrkRIWbyX6PSTp06Mu9tNyYOV3+kkhFa3eQjShydfOWHwnW6hn0SsO5R9MZUugcLab+hu4z5ghhPkL4PvmpAYmClYPFj+hxeRUDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502020; c=relaxed/simple;
	bh=fjWa1y/vyRJSdRBJmLewtgmQsasUi3C4mFWM4RfWtN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t9/Eq9TrXpe0RwgPoHvJ55/Dq+8Pyn4g8Jybx8qRaW3Yu/up2f4yoZC3oxVTBit0vcY6a5eqeivPkNjRJbL8Tmk31xkpzyj3A0BJYVzZiieTVOunonLPBKVNY07IW+rOBagjVIadozdkk0bMXx9N8fO3NYm24pnm6y4ETr16xDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dO80QCGG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dO80QCGG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464K2S936887;
	Fri, 4 Sep 2026 06:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RHUzKiPE+ROiILqdcigqc9jKEfO5gA5pkK5FQcJq9
	+0=; b=dO80QCGGtpJnABbhQlZaHULMz5ZSxi1EOR/EGr2SQtBnuui0aUvZ9ona4
	KyWJgjfGgdPHmoZ4v8quk1D4Ya5u6UShex2rDFAdjpJP/IRVlQPSk1d6Gh09ZX8p
	TXYenbjw6YrYrSSZpCcIIcF6GjkA3+h7S0TQuA4p3zVq314cjpLWJd5tu1HgEON5
	8pFrIWf5ddup8L/Q1UBUXkj6/hqMnaD5kzSC5dlmPZYvWER0xDkXxTbIhkeR9F6L
	ZJ6onX2SdYmM/3WH5hR5mWAi/ZE13aK11sTfRbZcBeRiYu7w/k0+PioFK60NHGoA
	BKZOHXCN7/RIxhiJriQi9stcE4HXQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx610qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uPT1023468;
	Fri, 4 Sep 2026 06:06:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyguas2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466mLH46399998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B3E220049;
	Fri,  4 Sep 2026 06:06:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13F4B20040;
	Fri,  4 Sep 2026 06:06:48 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:47 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 00/11] KVM: s390: Misc fixes
Date: Fri,  4 Sep 2026 08:06:36 +0200
Message-ID: <20260904060647.562443-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9a6000 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=0cG9luZ50kEA2NGqmBEA:9
X-Proofpoint-GUID: isl1oTsRrAK7571NaDRm0byoNE7oPtYU
X-Proofpoint-ORIG-GUID: isl1oTsRrAK7571NaDRm0byoNE7oPtYU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX1/AI4r9a2ogQ
 et4851DlUYVNOnkZyZpS9oHQrUgxcH7Lpy0mqg/30u0T+OaE7LBD0dd4x8VxzH2XXcUnEnMxzYh
 YnkF5wvW+P81d4aRYk3pZB9zdvFxNec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXyC8Pa6B/7SRO
 TLkrRz3GoJeMV9LoWyK5zdOv2jQ/wGZVoYh3o2Pcrl2Yc+zouL5VbcDs+Fxt8RR6SMWz6HFjoW7
 f5bX/+PzxYRm96JuNSGfwxg76JlV8mgktxSEyt+SVrLwK/9dYjOVLSLwDgsMW2qTYHFGHEk8tx6
 q26WJQSoMSSZviqLA8Wa2oyDRcwJ01/P7ZVmj39GVP5A+wfkzis9ZrFtuTwqa00PIh3oJoBoshz
 64brfYwyugB2tOGHU7BhNfjS7bNQX/bLPMZ7enuW6I1zWRnx4vlXDbqFynodyTiBq5vjhSaXoc2
 Lmch7IO/bZ5N0QN3+XbbIGyllDmzTgsecZ3fx70FP1JVP94IdoK4oIH6g/E8681I9tmwI8wJiQd
 LFmrkgq7PgppDolsAtfBfBDWm5wTbHwQoOCAl8GbU5SMxHn2bAY1eKgtMZk8VpKpO+CSHwKq2KU
 GDLEj1BPzNl4T/ksWUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054

Ciao Paolo,

Here you have a bunch of fixes to bugs found in the past few weeks.


Anthony Krowiak (1):
  s390/vfio-ap: fix KVM GISC and page leak when queue removed from host
    config

Claudio Imbrenda (8):
  KVM: s390: Fix dirty marking in adapter_indicators_set*()
  KVM: s390: Fix compile warning for kvm_s390_update_cmma_dirty()
  KVM: s390: Fix _gaccess_shadow_fault()
  KVM: s390: Refactor dat_set_slot()
  KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()
  KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
  KVM: s390: Fix potential races in dat skey functions
  KVM: s390: Fix race in _destroy_pages_crste()

Steffen Eiden (2):
  s390/uv: Fix loop condition in uv_find_secrets
  s390/uv: Prevent potential out-of-bounds read

 arch/s390/kernel/uv.c             |  8 ++-
 arch/s390/kvm/gmap/dat.c          | 65 ++++++++++++----------
 arch/s390/kvm/gmap/dat.h          | 10 ++--
 arch/s390/kvm/gmap/gmap.c         |  6 +-
 arch/s390/kvm/gmap/kvm_mmu.c      | 91 +++++++++++++------------------
 arch/s390/kvm/gmap/kvm_mmu.h      |  4 --
 arch/s390/kvm/s390/gaccess.c      | 13 +++++
 arch/s390/kvm/s390/interrupt.c    | 79 ++++++++++++++-------------
 arch/s390/kvm/s390/s390.c         |  3 +-
 arch/s390/kvm/s390/s390.h         |  2 +-
 drivers/s390/crypto/vfio_ap_ops.c | 18 ++++--
 11 files changed, 156 insertions(+), 143 deletions(-)

-- 
2.55.0

The following changes since commit 786262be6048deab760f68c8acc2c85607165894:

  Merge tag 'edac_updates_for_v7.3_rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras (2026-08-31 20:10:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-7.3-1

for you to fetch changes up to f47190b08b71e8482072978373ee88cb2dfbdaf4:

  s390/uv: Prevent potential out-of-bounds read (2026-09-02 18:50:42 +0200)

----------------------------------------------------------------
KVM: s390: Misc fixes

A bunch of fixes to bugs found in the past weeks.

----------------------------------------------------------------
Anthony Krowiak (1):
      s390/vfio-ap: fix KVM GISC and page leak when queue removed from host config

Claudio Imbrenda (8):
      KVM: s390: Fix dirty marking in adapter_indicators_set*()
      KVM: s390: Fix compile warning for kvm_s390_update_cmma_dirty()
      KVM: s390: Fix _gaccess_shadow_fault()
      KVM: s390: Refactor dat_set_slot()
      KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()
      KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
      KVM: s390: Fix potential races in dat skey functions
      KVM: s390: Fix race in _destroy_pages_crste()

Steffen Eiden (2):
      s390/uv: Fix loop condition in uv_find_secrets
      s390/uv: Prevent potential out-of-bounds read

 arch/s390/kernel/uv.c             |  8 ++--
 arch/s390/kvm/gmap/dat.c          | 65 ++++++++++++++++------------
 arch/s390/kvm/gmap/dat.h          | 10 ++---
 arch/s390/kvm/gmap/gmap.c         |  6 ++-
 arch/s390/kvm/gmap/kvm_mmu.c      | 91 ++++++++++++++++-----------------------
 arch/s390/kvm/gmap/kvm_mmu.h      |  4 --
 arch/s390/kvm/s390/gaccess.c      | 13 ++++++
 arch/s390/kvm/s390/interrupt.c    | 79 ++++++++++++++++-----------------
 arch/s390/kvm/s390/s390.c         |  3 +-
 arch/s390/kvm/s390/s390.h         |  2 +-
 drivers/s390/crypto/vfio_ap_ops.c | 18 ++++++--
 11 files changed, 156 insertions(+), 143 deletions(-)
