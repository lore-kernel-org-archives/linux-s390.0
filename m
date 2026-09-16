Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD0B44AB90;
	Wed, 16 Sep 2026 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594450; cv=none; b=J7Evth+ogr8CrdKoDtQiBLiNSJ8zd6sU6zMlLawIGNlgWqIwINyNDoEBuNjc1tejGeMAaSES+qZSQKYbqf6g+S9LmuD7b71+RvvlVM3+o+Lm0yWo3ZAK/mhJqs02K5KHe1If2h7d3FEWVTbIwKihubmweKPI3Cbi8FyobcahUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594450; c=relaxed/simple;
	bh=WxPXmg9P33Wt31ORP5T275Fq4+7dXkLwdjiZgh0rZbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KRdfD2wZKVrv59TYFxih6oE1QRqq/ZjxuRQ+7syeaQDpvZNbga0DTrtwgm/YHud4zniGD2W0Rc1zJX8BoXnw8frsc7Fmx3lxrYSO87cmpdr5CYpFYjsFsNoaepoJ1yZEhFRk9x2ZlTVNzbJG5VMf8Pbb88KYZyLCn4t2hZgS5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rKdVjeXw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rKdVjeXw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1T4v006661;
	Wed, 16 Sep 2026 21:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jUzO+nqjHpWKhspYR7ZMgGcoNhzP60X8NlRMAwjSO
	T8=; b=rKdVjeXwyhuyrNLg42BNXTF4mgNXPTtORf+Ha2t/+TvmwLeu0GcPxnODH
	bEuqjSYR02zMsDJvVKP8XObsSAMK+h/krh7M4oaqOsWhBZhSwxi4E6c8HsuU1sPE
	7lX89qTWTJLsMFZm+B4sxu7q/B4DF2CZrgEMuZj8eUHGRmm38h7AZ+VGj9egZeMB
	qzDGtC2cQ6UstssWwBSygoWPn7k2GA9E5H0zKtfTfLsUzUcoqDjEUHf380EwaJ2R
	Siai9/3gQUtYOELjZDizAkxh8EX2O8K+ibKF8OuoWFfScZwSunNQNrbJvrUvHACJ
	CoFj0N4tl6qcmevT2EokludQQWfhg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83y55c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 21:33:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GIxVaa1713021;
	Wed, 16 Sep 2026 21:33:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywf0m59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 21:33:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GLXqHb30016036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 21:33:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAFE55805C;
	Wed, 16 Sep 2026 21:33:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5BE05805A;
	Wed, 16 Sep 2026 21:33:50 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.251.90])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 21:33:50 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org
Subject: [PATCH v6 0/4] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Wed, 16 Sep 2026 17:32:18 -0400
Message-ID: <20260916213222.233-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMwMCBTYWx0ZWRfX+zlhCACs8/eQ
 rjZpExO80lTJy4WZe7lThlTgBZ1s2FgHopowfmiOpsdnDZAZAYasInQ5djLttnzgYh7hnKQQ4Md
 xRVuaHIgwTJnTaLlujIQ7bCAt6I8Kotgsw4j3TO8NmRIlqkTRE1a5vIijVhydjfpdUDm9eyplRW
 VAcQVCkvukiQVWaCVRsDsUuveY4XCijR3u5S3l0YOXyyUmvK23s2iqI5aIMbVaVW1/bAaQKdZRd
 ojDEp5DVr0Pxr5WXiTJ9ntpLU83nIQrH+q/kibtxMf8HPnk3xmyekY/OBRWIV0XHB+kUiEj5XAG
 R9h1Bd9zaZpuxVYH1hoN8qcdwUBNPqSnWLfLRutjCpDH4jHYKLB4L/s77JaKNkG/iNxi8glgSFi
 UqexhTFewufw+O5UTIbebd73d0A88lSzBUsfD0W3LL4L1dQiA/DM7ksRBORPqBCe/4YHTShp9EX
 dw4YnGgCYjT7kpw3fig==
X-Proofpoint-ORIG-GUID: rIzolc52tf-94XgnQ4uAyPPSQmQ5wwgV
X-Proofpoint-GUID: rIzolc52tf-94XgnQ4uAyPPSQmQ5wwgV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMwMCBTYWx0ZWRfXzoSJ4JW5+FPg
 tFkHulF+Je4E9atPMns1WyXe2cEZaMUWDlNkkqau0Zx1Pihn8mEsk006uzKuQmTGOIzcOTXkkRw
 5neXNKt+2K31M2oo1nxn6eFaMq6ux0A=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aab0b45 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Or8v72Ccw2kqKKHgtsQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160300

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390.

Changelog
=========
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
 arch/s390/pci/pci.c              | 83 +++++++++++++++++++++++++-------
 arch/s390/pci/pci_debug.c        | 11 ++++-
 drivers/vfio/pci/vfio_pci_core.c |  4 ++
 drivers/vfio/pci/vfio_pci_priv.h | 18 +++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 60 +++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 29 +++++++++++
 7 files changed, 189 insertions(+), 18 deletions(-)

-- 
2.55.0

