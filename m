Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718120;
	b=3Y0hhw8YXHA0aWUY84xrDR4ZMpHzRyfbTYyd5tAPQJvggENenZ93J41Gx0zhjNbLP52U
	 KVw4yMcFWhWN9kEx9Kvp2d/C6ZMeX7yG7EDSTyCXp3/glHtT2Tjb+L4AsGkuTJPh6AYXg
	 +QWWPkA08RN+yiWm4ysp0aC3+bqphlpCDV9QkB75el0cD30JI2IG8l4nIKnGZL8hX3nm0
	 4u6KmBh0v+k1uRnC5UHo2m+VNjtAz2w2RWfXB9n5hjTF2n4/mUQWeYk4a6IZeRTFnninv
	 Kr+sEOpfxOHSSp6jRuUI5GWjNmrUso3p7lV+Eh/92qiQFh4M0F7eTOmztJJAW6Y6Bzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718120;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1XkLgRUBj+7HQsE36aNtoV9eLCviOgt46ycf9wNu/GQ=;
	b=4vwmJSaQF+jEWEKFGTb01NoTb3BEdptdj+BGqv/c3Myruo3zO+u04UFzlw5na8E9Im9C
	 VSpG0DlFyOn7DhHWmkPTk9HL04LI4IGemJOnuu5j1w6tdrwegWnOxAPRvyUeP+1jAA5oj
	 ocXjK1STa26326nx3TWIeSm3wT/g3ygS1QpY+0CKPdIQNcx9Y4WfHOc1CPXRxOERDYrXn
	 cAa0bDuxr45abzQb07+7DpCDBatqRgOcHsqTrJ7D1TUCC7wgtdEh4jYxb66Mv0OPb0E0d
	 +y2I8WvK42b+zTLB3lbSxXJccuR7UMxH+EYq+7tWzM0a6jMH6xhujvWIspKSNiD1+Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Nb/9ftFX";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA433606B265;
	Tue,  3 Nov 2026 15:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA433606B265
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nb/9ftFX
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EED3s860848;
	Tue, 3 Nov 2026 15:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1XkLgRUBj+7HQsE36aNtoV9eLCviOgt46ycf9wNu/
	GQ=; b=Nb/9ftFXtWUWsh0SxJr0ZZpy7ZjDfv2KEt6GFnlHSly8ZL8ZqmcH8HiN6
	MEIRbfTOCMZkdyftje+ruSa7wWs+uIjD/1DnZLMPZHdWwPM7w0RvlXBy6RxDXAxy
	84i/bHdPznMbuaSfipxzYSd0sNzkxjj7RnUx8QbCdlZbY7Ce8TqG39rFAd6Fu7YB
	nZ4qu8gSKhjVUK5sznV1wwn4bl9dCsNCdAKcCtJdqiQMJH0F3+RXBQ6l1O6U3ru7
	IoUsNWtQZa26qWL7jO9I0HMCcJWmXcNLWZed46pRozfQDPrkF7F73lk6Cdhs4X0f
	cobUdMBNUswTboYKbKkmbGggVyCYg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd68s5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:01:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EJvxM2625362;
	Tue, 3 Nov 2026 15:01:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqbqk9kjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:01:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3F1Jh531392286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 15:01:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CBFE58060;
	Tue,  3 Nov 2026 15:01:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33D585803F;
	Tue,  3 Nov 2026 15:01:18 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.243.67])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 15:01:17 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v12 0/5] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Tue,  3 Nov 2026 10:01:09 -0500
Message-ID: <20261103150114.68873-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EaCAseHP6r29Qn9Pg-YVwq9BkPmXl7Me
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1OCBTYWx0ZWRfX1xoZZhZh2moC
 aA9JCz77u2+r7SueaVqT2m7hRUkdR31hFHPQlUVTgh9rcmABpYdrV4pSeuzzZYWvSDGiHkeJH2U
 /yeUcBdX70OfqINA1jQZzjeq4cr9Az3lUzxQeg0ZgpvpQhWV/6FmkNqhTFiUwOBljA8JOhi/9qC
 tQ1TTQFlQGc23WVpClQzCVTRh2aWNZP+QJtPv1XcqrYeBJp+HgP4UX//Xa/lChOeRMbNiEd3bHf
 1AIzX55qaeMM1hT5jerTVSY1afrXQv23oSmKgJdv1XJ4C8UTVRBhauVVmSrjHHgwohgqOHeQBVg
 pxFx4TOqp2r4wzzymPlHy0zQa7X+BUMoEtfJk4J5D+niDWCqYKOwexkCp7IIAlEF+2awYjhHcJM
 k2S6p4Tujnkg89Fl5qBlZnphKHnkvhqA0poEDDLI8RpeaiHOkLY+wjDlyOyiU792DHFmmEyRiW0
 ymwclzc7R/e87+O+Pug==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1OCBTYWx0ZWRfX47oM5mBnE+0K
 MsnZghMXfppbiwpN2RQ7skbU79k/PoIkEVQacbXP63M5EX2176xi1rtRAbE6HbZwS9cRT6p9eii
 n4EAcATS8wYwer667/+eSvwK8t+gHTM=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae9f743 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=4XtsKJ7C2CqOUlitrrcA:9
X-Proofpoint-ORIG-GUID: EaCAseHP6r29Qn9Pg-YVwq9BkPmXl7Me
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030058

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390.

Changelog
=========
v11 -> v12:
* Patch 2/5:
  - Replace the statistics_on bool with a bitfield

* Patch 3/5:
  - Add the fmb_enabled bitfield to struct zpci_dev to track the actual
    FMB enablement
  - Replace the kmem_cache allocator with kzalloc/kfree after learning
    it guarantees alignment for power-of-two sizes

* Patch 5/5:
  - Use fmb_enabled as the FMB liveness check

v10 -> v11:
* Patches 2/5 and 3/5:
  - Swap their ordering within the series
  - Set/unset statistics_on after an enable/disable succeeds instead of
    before

* Patch 5/5:
  - On FMB re-enable, use an intermediate request-off step instead of
    directly touching the device state

v9 -> v10:
* Patches 2/5 and 3/5:
  - Split the old 2/4 into two patches; the new patch 2/5 reuses one FMB
    buffer per device, and 3/5 improves FMB state management
  - Rework FMB management functions to decouple requesting enablement or
    disablement from managing the user's intended state
  - Preserve measurement state in pcibios_enable_device()

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

Omar Elghoul (5):
  s390/pci: Hold fmb_lock when enabling or disabling PCI devices
  s390/pci: Improve function measurement state management
  s390/pci: Improve FMB memory management
  s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
  vfio-pci/zdev: Add VFIO FMB device features

 arch/s390/include/asm/pci.h      |   8 +-
 arch/s390/pci/pci.c              | 121 +++++++++++++++++++++++--------
 arch/s390/pci/pci_debug.c        |  15 +++-
 drivers/vfio/pci/vfio_pci_core.c |   4 +
 drivers/vfio/pci/vfio_pci_priv.h |  18 +++++
 drivers/vfio/pci/vfio_pci_zdev.c |  64 ++++++++++++++++
 include/uapi/linux/vfio.h        |  30 ++++++++
 7 files changed, 224 insertions(+), 36 deletions(-)

-- 
2.56.0

