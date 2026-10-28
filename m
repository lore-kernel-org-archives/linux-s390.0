Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202245;
	b=mNUnj/+GmTADnf1LM70xT9pc816A8f3ZohBfm6PzJarjCVPbVAFTyjsHsRRMZU8FGHDK
	 /XcntqjYG6XDWww0D3VSC5hB8Ulu9dU/L8CG8ggJed4UwqwuLSPRpZASfHVaHYA//yiAk
	 Tl9lnCIRJeRXf3oVi5mwqYQ7UsC+mr728sR/S+/A/j1q1XOqnYUlvzIkWG81OHlboPb96
	 JnvQgHehs66v9ZjiSYTc+IUlDGrSlQaPmPWg7R1hTJu3+HacMdoNEtTwPkATjmQ6xZ31W
	 GfX8UJaUGGnlxx5MCTmNXmZ//AKDgcWWNzfW+wvzI97FMgg/SGLsFDtHUFQIL6JJSog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202245;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=t/08vwfETV8IbDEZxPUKUquVUb1PKJkwoP7rTsXE+jc=;
	b=uBsUz2S/HyR3OS4bl340hz8L5OkPCxwFF3AJHZnLut61HX34QvbjNJCjKMnCHNUirzV5
	 AHZjRAi+GZ1wu6YKZwWuJo1wknhvtEUszK8c0XfNbau63jEJvI87XWlGl2ZxxKXFmD6iz
	 B+77AE/u9ZuZ8zA+nmztiOngzo8oB+WZmmGa69I63mOjF7zl7IWHAy6Q6jCgvdiA4acOS
	 laKJpS4tpUofGJBmMHYMKtXeE8IoGJq5k8TBMgXcZw7R2MUeaYE83AxBEEWRlmPmS5poI
	 cEJyREt62+DaKqnpLJukGFCHAtJR8uP7BQLhSvQKyB9qvFNmQrjwIBD2OXrVf4A8SwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IuhGMnvD;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345F606A327;
	Wed, 28 Oct 2026 15:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E345F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IuhGMnvD
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFEAAW1600762;
	Wed, 28 Oct 2026 15:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=t/08vwfETV8IbDEZxPUKUquVUb1PKJkwoP7rTsXE+
	jc=; b=IuhGMnvD/A2X/nfC1e/iptBFyglBTDJ5Jy3TBpNr8lshV3Az4/aG6iDVW
	144yySoM5YSzillwXXBVQc+b+5crwnwLenCYvVQfDE5aUpC6dXHpz+EjuLut29fQ
	bUt8TVpqU0vUgyrztfxIqA2PzCJUag3PrwX73jHgWipZCrO5U93BHRsHyrp5tPM4
	1FwXw7hgACQx+NuTi81jA1wUIelYAHfpukqbSDm9ZuiitCpV9ns72W0R3N2hlL1s
	u8XZ8q2e+6HA0Y0ZOqYYmUrnDEZxk4r5wKt4OOFLE+x65UTrlRUFxwJ22nuEsylI
	cK7/R6wqXw5mk2JfN9Ono67KOa5fg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavn3rf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFK34H553110;
	Wed, 28 Oct 2026 15:44:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010m5hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SFh9tt22479554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 15:43:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE5E858050;
	Wed, 28 Oct 2026 15:43:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6A5A58052;
	Wed, 28 Oct 2026 15:43:55 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.240.205])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 15:43:55 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v11 0/5] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Wed, 28 Oct 2026 11:43:47 -0400
Message-ID: <20261028154352.15108-1-oelghoul@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae21842 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=4XtsKJ7C2CqOUlitrrcA:9
X-Proofpoint-GUID: 8UvYj_DU664hO_psVjlwHkmSwYtHQ3uv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX304yFtkFQIJG
 jcPS+1THlHz1NnaqVF0env6iwWN1cPTw+Tqdph+OCeX6vcdlAwulhnrCYdUKESDuyq9l09sOIWI
 cEaqxqKoiJde+/5w78WqrbldkDLJNlQ=
X-Proofpoint-ORIG-GUID: 8UvYj_DU664hO_psVjlwHkmSwYtHQ3uv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX0bwBgHQONEh9
 Gp0tFPgzxVib0aU+OUQgFpoiacvHKcti1tgOCgqhRzES1i98PsL3lN/2jLyI+OhB/MoTIUONRHe
 ioKnQELq7wEE50trkNWqnEvuAuwTW6NgYCwtCL3mnd4ER+L4/p5p4JsOAjES93lo6XlOZg+lBh1
 9sZuPRE8IS4/CeUKeRrTG/voea99YDHvHq5On/v8noy5KXV+FuoooseGghIM0TmI44Yb2fDajVY
 nhyVv35/U07Tc1L42fQEL99ZjZ6QZjunCcQYfvFHwlzRYtxzWsw6afwOLJvLwC60+lusrVWZITC
 jrCWKjQf+4uHg8a/lMqRIGNWilILuVJPu9+aRPr13dnQzyVKUF0yrfg+4jmIz25FXyW/4u0VbJo
 lwG2/IOCxOGskAyTrQUNZq7c75PiEopqdOYFYgorWlXbu3imPcCCvCPgLWV6TYKlE1+J5TVCsCq
 6MnwAPhWToL4kNl8UTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280062

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390.

Changelog
=========
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
  s390/pci: Reuse FMB buffer across enable and disable cycles
  s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
  vfio-pci/zdev: Add VFIO FMB device features

 arch/s390/include/asm/pci.h      |  7 ++-
 arch/s390/pci/pci.c              | 97 +++++++++++++++++++++++++-------
 arch/s390/pci/pci_debug.c        | 15 ++++-
 drivers/vfio/pci/vfio_pci_core.c |  4 ++
 drivers/vfio/pci/vfio_pci_priv.h | 18 ++++++
 drivers/vfio/pci/vfio_pci_zdev.c | 64 +++++++++++++++++++++
 include/uapi/linux/vfio.h        | 30 ++++++++++
 7 files changed, 210 insertions(+), 25 deletions(-)

-- 
2.56.0

