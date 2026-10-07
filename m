Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4858D385529;
	Wed,  7 Oct 2026 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381594; cv=none; b=t3s2uVGXksQyHDIlj7cgrFZT7wgvdRU349QoYuq2CkfF72entNXMwfFBCHWg2xdWJQTmf+dBIE7QrpiDQhEZZiUPuCHylvKQsfdPbo06lCquWgj8yY9ZKkGMp/RAoROCoN2IuZTnHreL7t2au+rZnnVvRQY1/r4asRuCAbjjoto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381594; c=relaxed/simple;
	bh=DsQCmULnM4//KdTCubaYobVgnyOqBasryTRP2NRxDMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krsS5VEsxQ1r/5ilfEnqxLdACRX4NhMB4lKNYM2GzCRRR5dd3DGDn8psg7E3INAa/iI8IJQXD6lnMSBIC7VC5G3YlCPteOMebhVu+FHmAO4uQcVscT7vtYg4FGv0PTUXaspR4TMEOGYa77AnvulS3ErXKu5zdXaFa7s8/g2oITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UfZsrGc+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UfZsrGc+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697Baq5X2465222;
	Wed, 7 Oct 2026 13:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=epJi+YDEr+vWy0mu06CicRRVW4ubCJQwPnlaTWtr0
	y4=; b=UfZsrGc+f7jk3xDDFwK96sdPcjkpFfSj+w20ZhJn+Z3zsGOQ5/Ox/PLVL
	cRApvF0OIzBxo5KYQeeU96vJ9XyhhYk4+UO1vasJg5O4JdHT1o0Sq9P8PwZutfss
	pqDh09ASgAM60mVTRo4lJc1beXSM5IkdL6ztLcGuC+Q1NC/L0TguetlkPA/yvg0u
	cq38CIWBSpiHqL5iqLcyaUXj5eKMjFPy6ORDTCokV8ABggY/d6fNCW62lrYdbB6E
	1zTNpYGD/ebscQkgfjLHaajOPu9hQPP8UyAmYk2qu9mnd1FzEgeNouAwRDZWj98w
	byHXKSg94Ccywp7IZdrOSwVpYKJ6g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74wuqp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:59:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWcTB1810431;
	Wed, 7 Oct 2026 13:59:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek31x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:59:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697Dxamh17891924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 13:59:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7968758060;
	Wed,  7 Oct 2026 13:59:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 937365804E;
	Wed,  7 Oct 2026 13:59:34 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.253.231])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 13:59:34 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v9 0/4] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Wed,  7 Oct 2026 09:59:22 -0400
Message-ID: <20261007135926.82935-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rz71JCTSCqC9iFeGEbRKjYKMLVbo72Dh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX8Qhd/oKF2QdU
 wyMouDs1LSc93YDp2RGqU35s4X3C4BeLFUjg/CSE+2nA9ZXt6KEbuusFQ0PuoG/iganGP9622PL
 alYet0hq5ra6fET8mobqUOj5z0FEq78=
X-Proofpoint-GUID: rz71JCTSCqC9iFeGEbRKjYKMLVbo72Dh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX9fbPxSAepI2+
 l74n5f/9OUuKE9XYAwtudlngnciiUQlx5QlrnU/S0GJ6YGOJMUNqUgu9cSfFpYsjVkG0hmGBCyp
 yHYoT34j3yHQRae6j3/obr6yiw36xXo463cKiyGAK/vI4XA1396dvicnPnmwDdY3j6wPaC2cNQI
 lehXGZ5UiAs5r75TyE1THKSBIsqEd1S7oJDbAkvBqqq3PhQmMCxLn8YMLcET0yH7i8RAl8jUk7I
 DSIK8AtdK9M8Sj2s5SRJjadEZg/M3TbFAW/WAFVmt0FJAOisg0FG48INdIZu5031jnfV6xofXvG
 GZlm3m7ju1CW51zSiwh5Yyuagx56nW4oAfHoJIAW9n6+ST6lOWxX2Tr/04m61s1qNwGsNEtNl3h
 RBM1/CHZjGmSOaBCxCDUopqI5R/7vYVLinMsBQj4yqHzrAc8KPslIY+QeeN2ZOl7H/oRUI86h4P
 nEsl1Xost9Xv1YYdsRQ==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac6504c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=5osLMtGHjg6MEC5_PQ4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070054

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390.

Changelog
=========
v8 -> v9:
* Patch 2/4:
  - Remove the intermediate disable step from zpci_fmb_reenable_device()
    for more uniform semantics
  - Rename fmb_enabled to fmb_requested with the intent of tracking the
    desired status of FMB enablement
  - Make zpci_fmb_enable_device() delegate to zpci_fmb_reenable_device()

* Patch 4/4:
  - Set fmb_requested when the user enables measurement

v7 -> v8:
* Patch 2/4:
  - Replace the fmb_enabled bitfield in struct zpci_dev with a dedicated
    bool to avoid future tearing bugs
  - Rewrite commit message for a more natural flow

* Patch 4/4:
  - Replace mutex_lock/unlock() in vfio_pci_zdev_feature_fmb_read() with
    a scoped_guard()

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

 arch/s390/include/asm/pci.h      |   2 +
 arch/s390/pci/pci.c              | 108 ++++++++++++++++++++-----------
 arch/s390/pci/pci_debug.c        |  11 +++-
 drivers/vfio/pci/vfio_pci_core.c |   4 ++
 drivers/vfio/pci/vfio_pci_priv.h |  18 ++++++
 drivers/vfio/pci/vfio_pci_zdev.c |  60 +++++++++++++++++
 include/uapi/linux/vfio.h        |  29 +++++++++
 7 files changed, 195 insertions(+), 37 deletions(-)

-- 
2.56.0

