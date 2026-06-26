Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7F3A7F66;
	Fri, 26 Jun 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496601; cv=none; b=hZRQmcT+64oMbld4B9jRVbkfZvHsrAJtvBEM2YB0dKuMJeiGLZ+1DC8XH7w3R0gsk0N1NOoXCFTe4X8DtsGvejXj7WDupPZeXA6+n5cJ170PdGFWE9K9vNtdXYBzdAJD8QCJ8Rjur45ltsrb+1+jbz9meUJZ5WoydOhhDYMIIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496601; c=relaxed/simple;
	bh=s6S1x3nkT9WQwqw+FT15FKJJuIe0GiRz6xjAqd4SoCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwPLzT+4MCNJIgIyJdXrnMQcyhYL2LrWiuRrVFGGYahrnieywkJv562ebSlGFa4Q8D8EEJIYER6xhhoM4ec2VW6zRnrBIlbIL88A4y1df+Ygs7uAgkO+fvTbZ8lgQ6LqJ31GNdVlryljaxsmdTEByiobHt2CKBJ2S/glcMoFJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aVh2M1hh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aVh2M1hh"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QFnDmG3620705;
	Fri, 26 Jun 2026 17:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=42T2xjFL1JC+Nuexm+El/bn1cAH6iB7GllO8wRAlh
	pY=; b=aVh2M1hhlYL0YJ3DawOgAfAo/U2V6wmsoGdZjl2+K8L5P14NTUs+K8dyZ
	1Chx6cFTLdzxTLsfVfU0T/QGQpbbE2bzJ+wot+N0h4ljA72VgrhgBc+ap0hxZ0Yd
	q9gtTIHxphv5vXzfE/89p4JAYY2fPVbmIK5fSD4DnPR4DGoPjMuDYnz/e+PekcJb
	iPs8Id+sypWJeFmw5Gae4s31d2vcrcuTbD70Cad/UODdzKDybNBTU3bILPiV40Hv
	17vtOkkC1kspS+HOfHrlZAua/VRR3oz0lhKETWHTGJb/kkBNBIpsxzn40jiKmf+J
	dWkGr5NSvUMAT+SX43SnZvX7Wx9yw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr87jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 17:56:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QHnf30010353;
	Fri, 26 Jun 2026 17:56:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgky8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 17:56:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QHuWf31311650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 17:56:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E42D58050;
	Fri, 26 Jun 2026 17:56:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8B8E58045;
	Fri, 26 Jun 2026 17:56:30 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.243.21])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 17:56:30 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v5 0/4] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Fri, 26 Jun 2026 13:55:21 -0400
Message-ID: <20260626175525.37370-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3ebd55 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=WbsiLw5XBHQt59x1OoAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE0OCBTYWx0ZWRfXzYWL/ZMamk64
 +cZbMA/biW8yc4FsZ1GC+ImtTlT+9yj8kdS1jk4sTIztUP0rpZ/VTBC/JbtnCko/BbhV4HpvSW4
 OPWUdq22VyiKBqnV/CtlwEHuh36MpjL8I9kTLMhGPgtQkfrUPMwW0PkkUHRCU1/kuI6SD6jXc0F
 H653+hYam/aWyNYBVIgfDwmOocoKL0i2fG6Nz4zeBuklQy8+vsAqIklS72PITjtTnH/W95Y5pdM
 IMsD7P+zSdnDa4Vgw+Sj5S3nUlqq8eUXpRnaRVHicpxm8R6Mo1/ir3K1FodTirpoJXYJdmpyQiR
 27qSPl34pF6B0jWP4tmFwSFyIs09/9VWb0NlJuvugJ/u18tgnuiU++5PQIsABIMci/5hadKE340
 eZuhgt77U7xPvMeIERE8SqjQ7Y0/w/TF6naidYB30XpQL5swU4xmVU81fZvj1g7pXOJWjkRKnAu
 Kp6VsXOYvX6wFqKL+Kg==
X-Proofpoint-GUID: zEq2-GdXktaw53CxxcWV1l4kVQn-ekRm
X-Proofpoint-ORIG-GUID: zEq2-GdXktaw53CxxcWV1l4kVQn-ekRm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE0OCBTYWx0ZWRfXx2c40+FSOazC
 m3wNFuhmgicaoNU4bmlvw6diDT+qqzlJf7AUuLV3qbYEqnWIAdTUGE+0sdX7mNw2NsTMtHBGKR5
 gX1VAGjWOJeZ+QJtDlL7fbQHRVAKr/4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260148

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390x.

Changelog
=========
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
  s390/pci: Preserve FMB state in device re-enablement
  s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
  vfio-pci/zdev: Add VFIO FMB device features

 arch/s390/include/asm/pci.h      |  1 +
 arch/s390/pci/pci.c              | 42 +++++++++++++++++++++-
 arch/s390/pci/pci_debug.c        |  9 +++++
 drivers/vfio/pci/vfio_pci_core.c |  4 +++
 drivers/vfio/pci/vfio_pci_priv.h | 18 ++++++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 60 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 29 +++++++++++++++
 7 files changed, 162 insertions(+), 1 deletion(-)

-- 
2.54.0

