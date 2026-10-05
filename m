Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732C4854ED;
	Mon,  5 Oct 2026 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215265; cv=none; b=KOhGRcaBqg2kOcV4WnPyBoCnhY40oMTLcsnItXF0aWfjiwp00TCaKqWiHYXNATQZYUIsRwquTtYxaT+yGoWgjmPIKWxEPben/ZHaV0pD/d6ptJ4+P5VAgo0L7IUTH+112j+Tm2gJQnMEWvOpMH2A/31KhWmJZhytZgOljR8FbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215265; c=relaxed/simple;
	bh=yh07cLqEdZk9Sw1l0uJeR4b7jf0BAPvbd8MvHOrmWLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3g6EXMbyW8aZKaHZgQ406faC+Qh3qnv5F3uszbwqfwHgQEJqLlqstGA80m+XeE7HxXnZFdBGkcxvG0ZtkDZZmKH4LA25jRorc7p5LylGtJOWOwZVVv5CXaS6zhZzvQzm07DI+zGC5VFlnH8HKPKOGurFX5TYZQhj2qIUrgHMi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tO2O3d5E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tO2O3d5E"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EZakH3876221;
	Mon, 5 Oct 2026 15:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zuA+m3Ve+yKXr13CA2AYZtkxBuc5aJc3dY3RzdWTZ
	YI=; b=tO2O3d5Eq1fuJjjcjsDHSguI1M11+jztYXNBfSK6CY31Vt6Z2zISvFryr
	gEW4rRekYrpcZwhbvSIlCRYqIjXez0hSzRD5mXckrY48Wf+2AVxD10kfMM4tOR1i
	Re1zxzdCEPS0ol0Mdnsvn3k7W4dNwDdtO1GoDl/HT4Ggc0GqCMoPkCC0x8QgOZE2
	g5tcxqGjOPGMLCVC8vOantGyhc5kMlJmtbV5/X2XQ7QBb+FCAk8q+0B1AyeV1FlG
	3l6B1EJQyCU0SH/6nqmtg+w9vMNjvp0ZkpFFtLcO6Wj89KNwitdBoygD56oL3rjA
	e7qZyY7/kmLz+MXYlTmC2pplNGGaQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4ftj2h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:47:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695EWVpv3063876;
	Mon, 5 Oct 2026 15:47:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy5v4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:47:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695FlKJG36438628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 15:47:20 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45E2B58063;
	Mon,  5 Oct 2026 15:47:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CEE358055;
	Mon,  5 Oct 2026 15:47:18 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.252.89])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 15:47:18 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v8 0/4] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Mon,  5 Oct 2026 11:45:53 -0400
Message-ID: <20261005154557.57801-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac3c68b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=5osLMtGHjg6MEC5_PQ4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MSBTYWx0ZWRfX2koCGGQa06kg
 3kfuQLDDk/cvu7TffnJIXLF7xesOGHNX5k9mOoXUapoz8iLnpe5aVgdJPg6gn6HeJoGChhIgzsQ
 HyYfxvx9owk8jlSHo3DnroL9h6sDDExpkbhj2RivEWWEsxRC0CZQ9BGb3gT8i76xi+s7ueltF6z
 xfyjzHKXAVw1MptNuWEmxqwgmaIKyT256BK2YDt78HK0Q/4Ya5GMLSSWX3XlvSV3ycCnOZynVdX
 6sIqoQsL8o48hhhW5cf2GjIANiKZdxNmcqkZlTr4TH+tVu+Utmrl1uL+EOZcpd26l+ANLG3nNk8
 f8jK8YGBefQYx3WyufdrTH3RGhn1I/GJKZzrmwMnnhUO8tTghQ6zf+agyAW49OSUUjaXgID1Xi4
 b3c0I3EP+CZmzwsdhtRecHzRg6MtX7W4inR5NMLC+8wOym50fBNKknQOuRhha+2Q7vZMVsKcmdT
 RImcFI0eNI+y1riDvZg==
X-Proofpoint-GUID: cYVBEVDvki_2AKBGS80ZI0ta55EAPJ-7
X-Proofpoint-ORIG-GUID: cYVBEVDvki_2AKBGS80ZI0ta55EAPJ-7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MSBTYWx0ZWRfX0Fq6zjVYRpHo
 Vj+oH6U5NHes2UC8OGw2L1EGOAkrVPVyNk3OuKnsCOINRH5A5BSyWzBlU7U7AJmQepct82yE7eh
 TTAKjVDlYs9K4BptNVa8ORv98S1gT7Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050061

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390.

Changelog
=========
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

 arch/s390/include/asm/pci.h      |  2 +
 arch/s390/pci/pci.c              | 84 +++++++++++++++++++++++++-------
 arch/s390/pci/pci_debug.c        | 11 ++++-
 drivers/vfio/pci/vfio_pci_core.c |  4 ++
 drivers/vfio/pci/vfio_pci_priv.h | 18 +++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 57 ++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 29 +++++++++++
 7 files changed, 187 insertions(+), 18 deletions(-)

-- 
2.55.0

