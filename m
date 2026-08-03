Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCFA3502A5;
	Mon,  3 Aug 2026 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773381; cv=none; b=cxSYHpK2NNIth9pMN/mkCuLWJtMjct0J0Cu/j04wTnOWvH5j5RaW70m5R5NgPrxLggF3wCx8oat37zZJDWzALW/x7gGjgoCu698k0Ak+1l7ZZVVa8yCfY/66ZSJ9TVb7H64KXcEUe2vP5oC3xgjUP4OTzb5+Lg9ANGJ12TGjtmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773381; c=relaxed/simple;
	bh=U7GL5Ke8vz7j+WVr2NBgaRWRFvtJSV+0iWEymZZrL8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orZuBjSkNh822ZP0akYlvI6KC9bVACtNGqsux5mOgUY/MeaAM2RUemE6B8/Dlfmr306DJbhz43oOpDif6x7fhVNHCyjE0ZQnZtDpvVKXHQcpFXgCsyM01Xt0UyBDxkpe3anxRhDfKbxRUIiWrPPGveynl4YOHVBDskMClrGk9vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gFix5bsL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gFix5bsL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHgnB413916;
	Mon, 3 Aug 2026 16:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JvCzgcf/c37iYlEEdHVY2b4M6R0KN0/wrvKR95bVL
	h4=; b=gFix5bsLyurul6YMQ6NPR4+YaShZC6KES9HiKDR+06mG1eIQlNcvV3aV/
	mvfp5IUzylH2nkIQzRsw/8Us/qFfKcSn55QoSwJkWK/rx6A/YzbKGIdYhFbWw4ne
	h8meXelTnL3N98IYbLuBbUTXFB0yB7ITN02HNvi1qX1jMYsxsaMTku/duaWe/cvW
	IVNv9YGkhF5lrSJBeuvCpdV8d2QvpKjBls1gVe5ub2+gkgOS4hQey8thm95YcbB6
	+OPBzR0t1oWhg6o0s1qqKrK1tVNMk2l0fDak1hVDSwL2eLk3FWDjJE6r+FEwPTHn
	fb5wmwnd7lFEIg4HgI8XyOkbCMGvg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqhp8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuIJB006959;
	Mon, 3 Aug 2026 16:09:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh63tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9P3g29557214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E62A520043;
	Mon,  3 Aug 2026 16:09:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBEDF20040;
	Mon,  3 Aug 2026 16:09:24 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:24 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 00/23] KVM: s390: Misc KVM and vfio-ccw fixes
Date: Mon,  3 Aug 2026 18:09:01 +0200
Message-ID: <20260803160924.236807-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3auuwwGyuYQX-kW4ASNuBvCaLeOqME90
X-Proofpoint-ORIG-GUID: 3auuwwGyuYQX-kW4ASNuBvCaLeOqME90
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX1Q4wDLZgX9K4
 bUnWZBMgBk8Jd/Xhyq9ofdTix5A1R1Nt/XbLZmTZP1F6l5/5sPbaIHoq2WlaudUa6dGuPzWxlFG
 iY0xctH75hhwsF0dzKoxygzU+QXQA7I=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a70bd3c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=qfEP_K_nxXoyjRaTxD4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXzzyzBr0GYFkN
 WxofIl71Tp8qgKBkMRK4mI1sZrZj3HxoJweFFO4cuD7AJcddQGptQQWj2Ltmk6kQDX0J7IBP4mS
 /myL0FFAuo5IJASWdc0nfK11rAfvHd7wR9ZMBONxoVeoX7p2E5o+pn244ZS6oS4ToX3/2wosHpH
 rvgxcb0zuapXjoP3mEWdhCsoq9YC9xl736+nQHcnXTANjM0WPgEBXkm8GAJEmYTCJX0r1PNXVfI
 l6TEggOoxWTbRtqsTPiTyKhWx3QowmeztkGZNoTMFDt6DiUlYsrJpGMkfN+zipI0+I8aph4zpl1
 3dEIYqws8kICbGzgY3oI21Zd8fd1MikPUw7cFC4GpNhfOHheLJuq3LgkxnhOi46zOP2ZvMwsQsf
 aOG5R8j838J9ikUdS8x2650EiZdM+ULFX99AWRY3Xx4D15j0+oRll1AwicqkywXs9BX8gvca27Y
 /20rV8UZ/SHdwhMSdEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

Ciao Paolo,

In this pull request there are a bunch of fixes to various KVM/s390 and
vfio-ccw issues.

There are still some small known bugs, which will be addressed later in
a different series.

The following changes since commit 9972befc3e34ff8b6847198c84f11bfc312dde40:

  KVM: s390: Fall back to short-term pinning in MAP ioctl (2026-07-27 09:23:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-7.2-3

for you to fetch changes up to feadc5e84dcb53422a437556c35af9efd9826fd5:

  KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu() (2026-08-03 17:09:46 +0200)

----------------------------------------------------------------
KVM: s390: Misc fixes for 7.2

Fix a bunch of small issues that came up during the previous round of
fixes.

They are mostly extremely unlikely races, but they should be fixed
nonetheless.

----------------------------------------------------------------
Claudio Imbrenda (13):
      KVM: s390: Fix unlikely NULL gmap dereference
      KVM: s390: Do not free SCA if it was not allocated
      KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
      KVM: s390: Fix overclearing ESCA in case of error
      KVM: s390: ucontrol: Fix sca_clear_ext_call()
      KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
      KVM: s390: Fix race in __do_essa()
      KVM: s390: cmma: Fix dirty tracking when removing memslot
      KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
      KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
      KVM: s390: Return -EINTR if a signal is pending while faulting-in
      KVM: s390: Fix ordering when adding to SCA
      KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()

Eric Farman (10):
      s390/vfio_ccw: Free all memory if cp_init() fails
      s390/vfio_ccw: Limit the number of channel program segments
      s390/vfio_ccw: Fix out of bounds check on CCW array
      s390/vfio_ccw: Ensure first IDAW remains constant
      s390/vfio_ccw: Calculate idal length based on idaw type
      s390/vfio_ccw: Ensure index for read/write regions are within range
      s390/vfio_ccw: Cancel existing workqueues
      s390/vfio_ccw: Move cp cleanup out of not operational
      s390/vfio_ccw: Selectively expand io_mutex
      s390/vfio_ccw: Implement a crw lock

 arch/s390/include/asm/kvm_host.h    |   1 +
 arch/s390/kvm/dat.c                 |  23 +++++--
 arch/s390/kvm/dat.h                 |   2 +-
 arch/s390/kvm/faultin.c             |   6 +-
 arch/s390/kvm/interrupt.c           |  19 ++++--
 arch/s390/kvm/kvm-s390.c            | 125 +++++++++++++++++++++++-------------
 arch/s390/kvm/priv.c                |  10 +--
 arch/s390/kvm/pv.c                  |  43 +++++++------
 drivers/s390/cio/vfio_ccw_async.c   |  16 +++++
 drivers/s390/cio/vfio_ccw_chp.c     |  31 +++++++--
 drivers/s390/cio/vfio_ccw_cp.c      |  74 +++++++++++++++------
 drivers/s390/cio/vfio_ccw_cp.h      |  10 +++
 drivers/s390/cio/vfio_ccw_drv.c     |  21 +++++-
 drivers/s390/cio/vfio_ccw_fsm.c     |   8 ++-
 drivers/s390/cio/vfio_ccw_ops.c     |  39 +++++++++--
 drivers/s390/cio/vfio_ccw_private.h |  10 ++-
 16 files changed, 320 insertions(+), 118 deletions(-)
