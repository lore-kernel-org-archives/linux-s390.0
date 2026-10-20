Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531486;
	b=VY8eKkD1tmgPqDTXE19u5fZxy4Q+reJtD+uS4d4TCFPxqd7kwc8S+XSob0q7AMrZVu8H
	 T6I82Glj8l09JhnSY3S+OGCgkvwJVKZGoiHethQRgzCMghl+In4vhyQ52A+TUngY0BDAA
	 3LLo8MdkfMzn7C0x2gQR9vSGikwkzR/P+bFaEb/l+fIHRR4WvrhhfYIDZIowEf/3N1HU+
	 jf/0vRZLy9qruTJYzO0Qi+fGlmQ4Sz9xUptHxN/jDJF04qse4Ozgv4OKcPA3JsllULxXZ
	 97v4ruzU8NgcqHWAJ9EIsbJAnRLQh9YaJdXOBazhG5XHjZFQ5XH8p0YPIerPVdm5MhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531486;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=eeMJ9eik/6iTalfM1QbgiJM1YJJZpIiUixe5HbN7fAg=;
	b=0wYKS+4hUM3X9TnDkR6GiB9f6Sb97dBnVKuq7BIV5vCURJZ0wGC/kW2yuMC45lVFw1IO
	 lxp/Rpf970iB9pk3c+IdX7jCTFNB1o4ankvbqPbvOVQYiDyIDQ+nQQz1asYWggbxpAtGb
	 cUCEXAIh5rFx/Z0Le9AjaY4EscmUb+vwzNHzSnmHmWf2j5GYL/mVkapzHj8lCcRufcAvQ
	 tqvAW0CD66269Pcki4gA1clq1Sq3F8DRdJpJ9lAogurZjBSrg9qzHVd8ngfd8xcaqrnU7
	 lPaJNZ+sKQMoRaiMDlqjjEvAiNpxwqjui34t3gA2pYd0IH+GvK17SxRjsDxxYUKNmwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jOxSyXfx;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC39606A319;
	Tue, 20 Oct 2026 21:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC39606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jOxSyXfx
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KLEEYl3671865;
	Tue, 20 Oct 2026 21:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=eeMJ9eik/6iTalfM1QbgiJM1YJJZpIiUixe5HbN7f
	Ag=; b=jOxSyXfxsVvhuTPcJP6xSsMQG9ox9eg23+jf7PS5BEIrT1hcKZTKbHOzN
	FpgYTRs/eypTZemM8kwOMY0MO9Hvs1deXKOrdCb722XoUUklFWmBnRRQzLWllk3q
	d6Nm9l9mjixqCD9W56IwXjJZHnmWOLchIff7Q/RpAxQnDNZmFZ7j9hSbesGdrbKv
	LWUqn2y+PJsDVK4rqKWb+cGx40YV13C3GzdBwTRDgVQ20wSmlSAOzd8oVPRLdt44
	abBQPEUYFZWKdRdHOSOjwoZeerLUmf8qCMq5ZAC8TJ3P2FE9XpAT4NNfnQfN/yXQ
	sn62xXt8VD1Sud4cj33GFOcXgLsWQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58ngqc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:24:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KL4wfU2113840;
	Tue, 20 Oct 2026 21:24:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmuh41wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:24:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KLOcIs23986758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 21:24:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B627F58056;
	Tue, 20 Oct 2026 21:24:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32C925803F;
	Tue, 20 Oct 2026 21:24:37 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.240.182])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 21:24:37 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v10 0/5] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Tue, 20 Oct 2026 17:24:22 -0400
Message-ID: <20261020212427.2561-1-oelghoul@linux.ibm.com>
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
X-Proofpoint-GUID: 89va64KW2VFdDL55j2S5c_GCKMCUCTYP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4NCBTYWx0ZWRfX6/cb3Si6oQm1
 ic8712kVhIRUtTY8N1PnQZpSUCfnXgT6m2AO1um42kFVkpYcf88zprUXNvxKqFw0yqubltARYs8
 yGVi4yfcCGIpr6sjvrGjnzpM1RQpyvM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4NCBTYWx0ZWRfXwOimkW/KyhjX
 G16rt3iXC4WbVqK4hZpvYRzT/hFvh2s++RcivW44mH5qyAXCmq6F7xGV9rrD08BOHHdfVelxDBH
 hpAdtqGkb1sIAIpxtxWu0mhDSy/yRaQc1ka3foAXGwdHRU5Q4njvw7ABeyPxbQnQfU4bLjce+sK
 f01/Ov/kAlD3R1ZpjVurxfhQfL/6RbajaDHe8Jt2NAjQ5lLuOBtttBCg4r4uEQP0mH8m1IdTaGl
 5Jnj8uQVW9FOlp4oyv8Zrhr92smeZTeM91tecGwRviWNYx7oNC0oAJ9gjDfiAEE+7J3bqhvZb+8
 FKgz4nlLsZADtqLwxkEKjjW/kOwKuy442gTpcBWdc0WxD8BJME/XvtRlcB6qYp/958m8KhgR+PB
 1XqvMddFvRWl1+EkoAlt/lE8ba0A5Rypf6zzVcEFfrvUU8BFPoMHUY+wKwmgXsCkgE5cb50t6Zm
 zYLD3z2Qti05ZJShPhQ==
X-Proofpoint-ORIG-GUID: 89va64KW2VFdDL55j2S5c_GCKMCUCTYP
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ad7dc1b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=6sK3PV2DqPywc776t1AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200084

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390.

Changelog
=========
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
  s390/pci: Reuse FMB buffer across enable and disable cycles
  s390/pci: Improve function measurement state management
  s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
  vfio-pci/zdev: Add VFIO FMB device features

 arch/s390/include/asm/pci.h      |   7 ++-
 arch/s390/pci/pci.c              | 102 ++++++++++++++++++++++++-------
 arch/s390/pci/pci_debug.c        |  15 ++++-
 drivers/vfio/pci/vfio_pci_core.c |   4 ++
 drivers/vfio/pci/vfio_pci_priv.h |  18 ++++++
 drivers/vfio/pci/vfio_pci_zdev.c |  60 ++++++++++++++++++
 include/uapi/linux/vfio.h        |  29 +++++++++
 7 files changed, 207 insertions(+), 28 deletions(-)

-- 
2.56.0

