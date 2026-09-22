Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8949502A;
	Tue, 22 Sep 2026 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106725; cv=none; b=GdmKY+IRO0gIgkI05iw9iUtYNg7/H+5EtPmcQtlT7tMjmDkcP/OhZxTeUZx8SwxmVNDXjfdGboWUtvUHBykf1ruyIa55vhRtyRBTQnIDzqMHzn8ZJZwuD3dfXiSQIuBFVWU82r03ypQ6Z4ko8uUuu5uMPcRI2Z/DIT0vMZOlolw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106725; c=relaxed/simple;
	bh=rO46+qCjXpkCxSolKr5Zydyt/pCFNQF2M7IstQo9H30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1SAkwfZjNiencwZ+6mrlCjrNoioz+9ZNS1i/OrrK8ws+XEqwruwYZohhMA2lGYEMNh9XF41e28o+EF4pULGnfgKSH3kb8ORieaXM6a1CoKMhyJ9p7DzybFPlpTPTNwrOTCzPSH0ZQyONeJeeLnpN/l97BTzxtjOopfOwJFk3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V3c+aq1J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V3c+aq1J"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI7bQg965141;
	Tue, 22 Sep 2026 19:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=I6Dz1pScvuchOON2TsOXdwLzSDjb2wOmqPU1mfIgg
	6o=; b=V3c+aq1Jcz1ih4tLfakFsWrgc4yJs1Eka77qj8XVe2D1Z60ljHnu9TfL1
	apfw8exsKcuhthuV23L9I9VEQH6CF4ColVn85oHl6TrNX4aiUEjZxtocdB+qnpWP
	MWSZZ+XHdDXIE9CL2JyQqOHTEN5KccHQXm4MoHXJy9tmpCE2Hw0gPdm2nJLMaIND
	vLOIWZLrgcEuq49RvG2zOZytpvM/jhr+5yfq6LYZiueXJ8M82+SDoHvypO+WcoDT
	jPE6c3srRiK+jP7M/cDGjkP6aWjg5h3Gu+wJnh28Sjs5XsJqQT6uaNlAw1ufxNQv
	CU6tWQQ+FWR3goLkqDcAQKCWWueGg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1fdtw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 19:52:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIHX0I3239749;
	Tue, 22 Sep 2026 19:52:00 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gu66y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 19:52:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MJpw7x30474752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 19:51:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74BFC58050;
	Tue, 22 Sep 2026 19:51:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F37F58045;
	Tue, 22 Sep 2026 19:51:56 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.246.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 19:51:56 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org
Subject: [PATCH v7 0/4] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Tue, 22 Sep 2026 15:51:37 -0400
Message-ID: <20260922195141.94548-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o_tWGYj_dUNR6t1isvgECCU0FkapIX98
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfXwJenkal3EMj3
 csnCHlZ/JuLheLE/oVviw8LhrMGP8MbkWKDRm/BJ/ZpfddBZ6mttsqIlE0pCtEufypuxxxujjel
 eOW9SfGpNrX2SyZNWjsldRBa/Cz0bXX71+zYCBXvPl/cT/5Wk3WhIMxbkBGPC+pzGonBAdbxi4C
 0jly7ZdyLvAlFMVJey5vwWePt/nqsQBpv/NZm3V33d6K0syJgaRd/ofWKZap8i0sm/Xd36sBKXu
 05MqYI3CMI+cN7j8mY0RusMGRRp0xiMHW/QahwQzd+YvPuP9SF8VcSjmBHS3CaROynpO8kXg8jW
 fbm3Lz/GibTL7B3u5cQArs3JXKsiZCavykqd5BgEBr+Uz3M6I/KDbujenNuD7ChT0jwyCEGGEMt
 tKs2lBKiMLsx0eRejRriGINDNrX+O1MVTSdqG6cksqt96kjmwU0zcgnb7b++9w45hdRUxQ3CuP5
 pYwBBo4Uvn3xPpYhWTw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab2dc61 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Or8v72Ccw2kqKKHgtsQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX2GsqnO54K1yO
 rSziFV53+h290oA4jskTPnl5vHM/oe/SBdehqgRdfmpBfh4DDSGZJqbSTzUkECthGgMnIxwnOsn
 2QhdvOTjptsbZZicuCzZuTl/GqW1NJs=
X-Proofpoint-GUID: o_tWGYj_dUNR6t1isvgECCU0FkapIX98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220287

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390.

Changelog
=========
v6 -> v7:
* Patch 2/4:
  - Don't re-enable FMB if it wasn't already enabled

v5 -> v6:
* Patch 2/4:
  - Rework the FMB re-enablement code to reuse the same buffer again
  - Make the FMB buffer persistent once allocated for as long as the
    device's lifetime to accommodate an architectural quirk
* Patch 4/4:
  - Update the liveness check to use the new FMB enabled bool

v4 -> v5:
* Typo in the cover letter
* Swap the ordering of patches 3/4 and 4/4 to ease merging (i.e., to
  ensure the three s390 patches are ordered before the VFIO patch)
* Patch 2/4:
  - Drop the refactor of zpci_fmb_enable_device() and the separation of
    zpci_fmb_clear_iommu_ctrs() and zpci_fmb_do_enable()
  - Allocate a new buffer in zpci_fmb_reenable_device() rather than
    reusing the same buffer to avoid firmware edge cases

* Patch 3/4 (previously 4/4):
  - Avoid reading from userspace while holding kzdev_lock unnecessarily

* Patch 4/4 (previously 3/4):
  - Drop allowing usercopy of the FMB when initializing the kmem_cache
  - Avoid copying to userspace while holding fmb_lock unnecessarily
    - Restore the FMB bounce buffer to achieve this one
  - Clarify uAPI documentation and ensure it accurately describes the
    behavior of the VFIO features

v3 -> v4:
* Patch 2/4:
  - Replace mutex_lock/unlock in zpci_reenable_device() with a guard

* Patch 3/4:
  - Allow usercopy of the FMB when initializing its kmem_cache
  - Move the guard in vfio_pci_zdev_feature_fmb_enable() lower to only
    protect the FMB
  - Ensure vfio_pci_zdev_feature_fmb_enable() fails on double-enable for
    consistency with the documentation
  - Eliminate the bounce buffer in vfio_pci_zdev_feature_fmb_read()
  - Replace the void pointer with __aligned_u64 in the FMB read uAPI
    structure

v2 -> v3:
* Patch 1/4 (new patch):
  - Fix race conditions in pcibios_enable/disable_device() with regard to
    the FMB enable/disable
  - Assert that fmb_lock is held within zpci_fmb_enable_device() and
    zpci_fmb_disable_device()

* Patch 2/4 (previously 1/3):
  - Move the FMB enable logic into a static function zpci_fmb_do_enable()
    to reduce code duplication between zpci_fmb_enable_device() and
    zpci_fmb_reenable_device()
  - Reword commit message to use the imperative voice more consistently

* Patch 3/4 (previously 2/3):
  - Split the previous VFIO feature into a SET-only and a GET-only feature
    for enabling/disabling and reading the FMB respectively
  - Remove FMB definitions from the VFIO uAPI and instead treat it as an
    opaque structure

* Patch 4/4 (previously 3/3):
  - Clarify goto label name to reduce misunderstandings

v1 -> v2:
* Patch 1/3:
  - Address a possible race condition in zpci_reenable_device() caused by
    calling zpci_fmb_reenable_device() without holding fmb_lock
  - Assert that fmb_lock is held within zpci_fmb_reenable_device()

* Patch 3/3:
  - Address a possible race condition in pci_perf_seq_write() caused by
    consuming zdev->kzdev without holding kzdev_lock

Motivation
==========
The firmware on s390x machines allows for tracking a variety of statistics
relating to zPCI devices in a function measurement block (FMB). However,
the kernel currently lacks a structured mechanism of sharing this
information with userspace, beyond /sys/kernel/debug/pci/ID/statistics.
This can lead to shortcomings when running a guest on KVM with PCI
passthrough devices, as QEMU is unable to provide an accurate FMB snapshot
to the guest.

Proposal
========
We propose adding a new VFIO device feature to zPCI passthrough devices,
allowing userspace programs to read the latest FMB snapshot as it is
written by the firmware. We ensure that function measurement enablement is
preserved across device resets on the host. Furthermore, we guard against
host tampering with the FMB via sysfs when the zPCI device is in
passthrough to protect the VM's state.

I'd appreciate some feedback on these patches.

Thanks in advance.

Omar Elghoul (4):
  s390/pci: Hold fmb_lock when enabling or disabling PCI devices
  s390/pci: Reuse FMB buffer and preserve state in device re-enablement
  s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
  vfio-pci/zdev: Add VFIO FMB device features

 arch/s390/include/asm/pci.h      |  2 +
 arch/s390/pci/pci.c              | 85 +++++++++++++++++++++++++-------
 arch/s390/pci/pci_debug.c        | 11 ++++-
 drivers/vfio/pci/vfio_pci_core.c |  4 ++
 drivers/vfio/pci/vfio_pci_priv.h | 18 +++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 60 ++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 29 +++++++++++
 7 files changed, 191 insertions(+), 18 deletions(-)

-- 
2.55.0

