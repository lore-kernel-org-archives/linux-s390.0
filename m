Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCF415F07;
	Fri, 14 Aug 2026 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693863; cv=none; b=T4f90DwGLG5myEeIVUZApJuSvMql5ndLDS39uGOnfBTYWFPRDYj342I4jIFHIXVjuz3k/How2S3qJy5OECuehQK6fZyoowkU3tibVVfIbUF1ypYJWI5EughshGjmE8+j5T8846MSYZ0pj+oWupSaY91DsNKJqVpDa+YM2p2MwdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693863; c=relaxed/simple;
	bh=wRLiyu919A91h61qKtI5ODrKXYhm2DUNg+aAPD4zDzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A4KZSPoXvX9ygi7iVqgbiUof/gMBo99wvNhLhZ3/ghkVEJUbC28M6H7xmuJuHpkIYhAVZOcW9k5FuZVbvZsZq+iS1lfTT8+ORv0Oj/BrgDSU+NnpO5rsvm94FZ3ehYDztqLoZFAREDS1+YaK1Oq0V6I09q0G2et5iPSkr2CcqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eMcORFcT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eMcORFcT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4VrsS103187;
	Fri, 14 Aug 2026 07:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=8kZBJwa2tp5GUmb76bsZ5LzMD2CC
	v69Z85+g7Pni0XQ=; b=eMcORFcTLikqSV3RJjvhrEwSz7sC3yu36/+FZWkiL5F3
	EbYRqm2wog2klf8Xn80LDGTnewnLPgPbeDxFuzKxK/URvtFBH2kuyMTVsuMlOGXA
	D9QMMV9Zx4TiOw+4R8/xqoDolWUO9p46LxJdBLmheMCObE919sqZCsgDOK7rNKgI
	aB5CXHcOURtsvIqsBDCW7pCJ1SDUtXa+SWkN4FMrT8csjNWXm03TnMHkYDASCqJS
	rnCqqzv8KPk5PmS7TUhRYpqE1x53aIYaL/qRDZXO3A/6PkeZ2MOMpgJaxjC66x16
	D5UflU/AofWKos+02LxsGauKcIwrqZ0AREwF+JksKQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9urs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:50:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QIg8001528;
	Fri, 14 Aug 2026 07:50:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9heca6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:50:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7orsu16515712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:50:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F5BF5805B;
	Fri, 14 Aug 2026 07:50:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4557A58058;
	Fri, 14 Aug 2026 07:50:50 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:50:50 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Ciunas Bennett <ciunas@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [GIT PULL] KVM: s390: Features and Fixes for 7.3
Date: Fri, 14 Aug 2026 09:50:49 +0200
Message-ID: <20260814075049.223793-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6auKQb2jjnXRVOyxV9XiCemdhKfMhzzS
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7ec8e0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ia4a_n5286Zw_cLP8bAA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX3UbwPyXb7ONV
 4DiHvJkGmZ76VUuaLFeJyQiVO1qm4MV44z1V4GXT95khXGhEV7J/WHIMR6OxWBqkRG4NKIrLlzg
 lpJYG3P6tL01A3jrnoL3+lL98m7eaRZvfOIuRIP18KGaP3W+V8JV6MQOq6mxgVKZWN86st0aKhb
 kiEaY0d1+PdIjEBO5ssA8ibsLpMIX5svTDi3GwIwaBzTQ2OAcH1zXnSXzMAUCtkTt6sfLU3xdGA
 nZuBJ5zOf40aBWWyvYjXGj0ns8OtK3iXRS7bxJ2aMWExFHGvi2pBZCjpwuCwO0XtTjIc3bX1JzW
 dt4p0FTxxPhg6QwAYso2c808jTS7pKfKBlGTbk649NFgnPOfT4CYhzUijPG/rHGpCH7iP653r9+
 n0+dEa16cdSoBmDOsuihwR6vOttWrRlg92Rrm9XQkXK8T96WB/zFKLAbhgcRbDOTUUPbphEnXRF
 6pXM5Pkj9ZlX5fgITOQ==
X-Proofpoint-ORIG-GUID: 6auKQb2jjnXRVOyxV9XiCemdhKfMhzzS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX7414ZL3f1DXY
 wZIr4kwu/Gyoi5FIt9Ey3wRRdZ7EJgUaz3Mg2Wc+V0mE0EEZ7nrgSqMS4129s03/g6mvhPx9/6+
 6uYXmCvC6Y7slgOfTODnhRY9i2e1oDw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140058

Paolo,

large chunk of s390 fixes and feature without patches as reply due to
the large number. Series is on top of v7.2-rc2 but I merged
kvms390/master to pick up additional fixes that came too late for 7.2.
Of course also other patches/fixes directly on top. This automatically
contains all the previous s390 fixes for 7.2, but this will reduce merge
conflict potentials, so I see it rather on the plus side.
I made the pull request statistics on top of rc7.

sashiko reviews for the patches
1. Fixes for vfio-ap
https://sashiko.dev/#/patchset/20260812200240.818004-1-akrowiak%40linux.ibm.com  without patch9
https://sashiko.dev/#/patchset/20260806173435.105044-1-akrowiak%40linux.ibm.com
2. Fixes from Claudio
https://sashiko.dev/#/patchset/20260812104436.109741-1-imbrenda%40linux.ibm.com without patches 4 and 9
3. vsie Fixes from Christoph
https://sashiko.dev/#/patchset/20260807-vsie-cleanup-202607-v1-0-b18659b55e3d%40linux.ibm.com
4. diag 9c tracing from Ciunas
https://sashiko.dev/#/patchset/20260724103959.14861-1-ciunas%40linux.ibm.com
5. enable CONTEXT_ANALYSIS for cio and virtio from Heiko
https://sashiko.dev/#/patchset/20260806153849.2622576-1-hca%40linux.ibm.com
6. move KVM code to prepare for additional arm64 support
https://sashiko.dev/#/patchset/20260812153631.3376090-1-seiden%40linux.ibm.com (patches12-21 only)
7. AI triggered fixes all over by me
https://sashiko.dev/#/patchset/20260811153738.206885-1-borntraeger%40linux.ibm.com
https://sashiko.dev/#/patchset/20260805110455.7200-1-borntraeger%40linux.ibm.com

-- 
2.53.0

The following changes since commit feadc5e84dcb53422a437556c35af9efd9826fd5:

  KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu() (2026-08-03 17:09:46 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-7.3-1

for you to fetch changes up to dd6f4ef6f8a37412909ad787c837332fb070159c:

  s390/vfio-ap: Fix NULL deref in status_show() during queue probe (2026-08-13 16:04:33 +0200)

----------------------------------------------------------------
KVM: s390: Features and Fixes for 7.3

- merged kvms390/master to pick up additional fixes that came too late
  for 7.2
- Fixes for vfio-ap
- Fixes for the gmap rework
- Fixes for vsie
- AI triggered fixes all over
- diag9c tracing
- code move preparation for the additional arm64 support
- enable CONTEXT_ANALYSIS
- update to vfio maintainer file location

----------------------------------------------------------------
Anthony Krowiak (9):
      s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
      s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
      s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev objects
      s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object
      s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
      s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain removed
      s390/vfio-ap: Fix NULL deref in status_show() during queue probe

Christian Borntraeger (15):
      KVM: s390: move some facilities from FACILITIES_KVM_CPUMODEL to FACILITIES_KVM
      KVM: s390: Remove user triggerable WARN_ON
      KVM: s390: Zero initialize data structures for inject_pfault_token
      KVM: s390: Zero initialize irq in reinject_machine_check
      KVM: s390: Fix memory leak in guest debug handling
      KVM: s390: Fix old_data leak in guest debug error path
      KVM: s390: Take srcu when importing watchpoint data
      KVM: s390: Free guest debug data on vcpu destroy
      KVM: s390: Fix length check __import_wp_info()
      KVM: s390: Fix memory corruption by not reinjecting CK machine checks
      KVM: s390: keyop: use mmu_lock to read gmap->asce
      KVM: s390: vsie: zero stale crypto bits
      KVM: s390: pv: Fix rc/rrc offset for PVM_DUMP
      KVM: s390: Restore sigset on error path
      Merge remote-tracking branch 'kvms390/master' into 'kvms390/next'

Christoph Schlameuss (6):
      KVM: s390: Remove double 64bscao feature check
      KVM: s390: vsie: Remove duplicate assertion
      KVM: s390: vsie: Convert shift to phys_to_pfn()
      KVM: s390: vsie: Assert mcck_info offset in vsie_page
      KVM: s390: vsie: Assert crycb alignment in vsie_page
      KVM: s390: vsie: Create constant SCB_ALIGNMENT_SHIFT

Ciunas Bennett (2):
      KVM: s390: Refactor __diag_time_slice_end_directed for single exit point
      KVM: s390: Add tracepoint for DIAG 9c directed yield operations

Claudio Imbrenda (7):
      KVM: s390: Properly handle NULL pointer in dat_cond_set_storage_key()
      KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()
      KVM: s390: Fix get_all_floating_irqs()
      KVM: s390: Fix pgste_get_trylock_multiple()
      KVM: s390: Fix IRQ injection with SIGP Stop and Store Status
      KVM: s390: Fix kvm_s390_clear_pv_state()
      KVM: s390: Fix potential tiny kernel stack leak

Heiko Carstens (4):
      MAINTAINERS: Update s390 specific vfio sections
      s390/vfio_ccw: Add __must_hold() attribute to vfio_ccw_sch_quiesce()
      s390/cio: Enable CONTEXT_ANALYSIS
      s390/virtio: Enable CONTEXT_ANALYSIS

Steffen Eiden (10):
      KVM: s390: Extract gmap tracing to a separate header
      KVM: s390: Prepare include guards for a new location
      KVM: s390: Rename kvm-s390.{c,h} to s390.{c,h}
      KVM: s390: Move kvm_host definitions to kvm_host_s390
      KVM: s390: Move s390 kvm code into a subdirectory
      KVM: s390: Move PGM code definitions to asm/kvm_host.h
      KVM: s390: Prepare gmap for a second KVM implementation
      KVM: s390: gmap: Make storage keys optional
      KVM: s390: gmap: Make CMMA optional
      KVM: s390: gmap: Make prefix handling optional

 MAINTAINERS                                 |   8 +-
 arch/s390/include/asm/kvm_host.h            | 723 +--------------------------
 arch/s390/include/asm/kvm_host_s390.h       | 729 ++++++++++++++++++++++++++++
 arch/s390/include/asm/kvm_host_s390_types.h | 349 +++++++++++++
 arch/s390/include/asm/kvm_host_types.h      | 347 +------------
 arch/s390/include/asm/nmi.h                 |   3 +
 arch/s390/kernel/nmi.c                      |   5 +-
 arch/s390/kvm/Makefile                      |  11 +-
 arch/s390/kvm/gmap/Makefile                 |   5 +
 arch/s390/kvm/{ => gmap}/dat.c              |  17 +-
 arch/s390/kvm/{ => gmap}/dat.h              |  21 +-
 arch/s390/kvm/{ => gmap}/faultin.c          |   3 +-
 arch/s390/kvm/{ => gmap}/faultin.h          |   6 +-
 arch/s390/kvm/{ => gmap}/gmap.c             |  19 +-
 arch/s390/kvm/{ => gmap}/gmap.h             |  25 +-
 arch/s390/kvm/gmap/kvm_mmu.c                | 133 +++++
 arch/s390/kvm/gmap/kvm_mmu.h                |  18 +
 arch/s390/kvm/gmap/trace_gmap.h             |  47 ++
 arch/s390/kvm/s390/Makefile                 |  14 +
 arch/s390/kvm/{ => s390}/diag.c             |  21 +-
 arch/s390/kvm/{ => s390}/gaccess.c          |   2 +-
 arch/s390/kvm/{ => s390}/gaccess.h          |   2 +-
 arch/s390/kvm/{ => s390}/guestdbg.c         |  11 +-
 arch/s390/kvm/{ => s390}/intercept.c        |   2 +-
 arch/s390/kvm/{ => s390}/interrupt.c        | 109 +++--
 arch/s390/kvm/{ => s390}/pci.c              |   2 +-
 arch/s390/kvm/{ => s390}/pci.h              |   0
 arch/s390/kvm/{ => s390}/priv.c             |   2 +-
 arch/s390/kvm/{ => s390}/pv.c               |   6 +-
 arch/s390/kvm/{kvm-s390.c => s390/s390.c}   | 159 ++----
 arch/s390/kvm/{kvm-s390.h => s390/s390.h}   |  10 +-
 arch/s390/kvm/{ => s390}/sigp.c             |   2 +-
 arch/s390/kvm/{ => s390}/trace-s390.h       |   0
 arch/s390/kvm/{ => s390}/trace.h            |  40 +-
 arch/s390/kvm/{ => s390}/vsie.c             |  22 +-
 arch/s390/tools/gen_facilities.c            |  14 +-
 drivers/s390/cio/Makefile                   |   2 +
 drivers/s390/cio/vfio_ccw_drv.c             |   1 +
 drivers/s390/cio/vfio_ccw_private.h         |   3 +-
 drivers/s390/crypto/vfio_ap_ops.c           | 203 +++++---
 drivers/s390/virtio/Makefile                |   2 +
 41 files changed, 1703 insertions(+), 1395 deletions(-)
 create mode 100644 arch/s390/include/asm/kvm_host_s390.h
 create mode 100644 arch/s390/include/asm/kvm_host_s390_types.h
 create mode 100644 arch/s390/kvm/gmap/Makefile
 rename arch/s390/kvm/{ => gmap}/dat.c (99%)
 rename arch/s390/kvm/{ => gmap}/dat.h (98%)
 rename arch/s390/kvm/{ => gmap}/faultin.c (98%)
 rename arch/s390/kvm/{ => gmap}/faultin.h (96%)
 rename arch/s390/kvm/{ => gmap}/gmap.c (99%)
 rename arch/s390/kvm/{ => gmap}/gmap.h (96%)
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.c
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.h
 create mode 100644 arch/s390/kvm/gmap/trace_gmap.h
 create mode 100644 arch/s390/kvm/s390/Makefile
 rename arch/s390/kvm/{ => s390}/diag.c (96%)
 rename arch/s390/kvm/{ => s390}/gaccess.c (99%)
 rename arch/s390/kvm/{ => s390}/gaccess.h (99%)
 rename arch/s390/kvm/{ => s390}/guestdbg.c (98%)
 rename arch/s390/kvm/{ => s390}/intercept.c (99%)
 rename arch/s390/kvm/{ => s390}/interrupt.c (98%)
 rename arch/s390/kvm/{ => s390}/pci.c (99%)
 rename arch/s390/kvm/{ => s390}/pci.h (100%)
 rename arch/s390/kvm/{ => s390}/priv.c (99%)
 rename arch/s390/kvm/{ => s390}/pv.c (99%)
 rename arch/s390/kvm/{kvm-s390.c => s390/s390.c} (97%)
 rename arch/s390/kvm/{kvm-s390.h => s390/s390.h} (98%)
 rename arch/s390/kvm/{ => s390}/sigp.c (99%)
 rename arch/s390/kvm/{ => s390}/trace-s390.h (100%)
 rename arch/s390/kvm/{ => s390}/trace.h (95%)
 rename arch/s390/kvm/{ => s390}/vsie.c (98%)
