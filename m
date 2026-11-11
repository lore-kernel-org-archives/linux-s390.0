Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414514;
	b=2AOt+kVjZtYy9/lHPt3oLqS3Kqwvs4mlqdrHnOvzqZV7vWRfeSgWLlfSRhR8kykD2JVT
	 QpHhLi4YzCiVoJkc843LyOQtrxCfiCi4J2fprfxNirq+p7dYkdnXzlLfyvJRlv83AmqMj
	 4+8vuZcuxW/85WKCD9MOZ+QDrFKmbn0aa2QA+XA+6Sz4oSfDvpp8BJPvYBsf5pjf7qme8
	 HL1AWSNz9f5lb5+SzLQ27+taTUIgozbsUyWUY30w/Mb2JN75/4MF1dpa1NIEAjJYEZc4P
	 R/dzDMUMbmIV+Nm/DMqTGv9SuxLoBBKY+8QCdW4xJLaf/Cbpkz3c//wm3dVcRORwt3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414514;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xJlFBp67y9FjXh+v8NgxXopGc/6zAVqRU+DbANR8AoQ=;
	b=18OWfdwC2DpCbj9i+UvdwsjQSn98FsbO0PaBVKblX/yoGDW9Mn0e8Mhe5JSyb7wkKQsI
	 lt20PUUVveBLx+txBxxatCtFhuhuyunf8WtWBNdzP1ptJBoR9xQ/7raoT++epZaE7RNYA
	 8IldeEw64NvkrnMCK7BW1MV7K75aReUxWTnFHhQY+S2bMQdfq6W/M1mCJT48bZB3OCLZb
	 +n9iesOYbbOE7AbhXn2XCPNtmu2LW+XNSi+WBraezYYGOtkCOBIAXHQO4EzYmv5bkVJbK
	 qFapWEFFfsxOKtHEzR79zb0X1TmN5I/HmXS2wJSoXIKr3TFN8F6eKdemM6Mwjay3TpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y5PvtGNm;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFEF606A33E;
	Wed, 11 Nov 2026 16:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CFEF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y5PvtGNm
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFEH7V1456527;
	Wed, 11 Nov 2026 16:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xJlFBp67y9FjXh+v8NgxXopGc/6zAVqRU+DbANR8A
	oQ=; b=Y5PvtGNm0gniS9RvzSA3DvrZCruVHj76hDqHdg3HfpN/BZkYJz/Cea7Tr
	gNX08JkZNwf8ZvN7OGHu77JLF9G44uQhrCYRfYL8IuHnihS6Du7KlYVaPG/17k2R
	t0lze8tWNueJSTSY70tzH87W2C8SlAjA8LAkKN0h1l9KBrdtsYRzxs+tMN7Xjyq3
	o4LEBVwsNy0i592RKPdft3nKZVBKvVwuQnstvcm3/RhHYFUOtJ0D7F0sRxU0ojve
	zFob2Glh+uR9zOEwZAogegAfqPtfZQC27D/SNPmx7ReuyvjD5G5USqRtVByoEJPL
	i7FIEwUG/O4qf/EGj7aM3Fhz3sZkg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv29ug-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABF56fN2382118;
	Wed, 11 Nov 2026 16:28:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51tuss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABGSNGu5309058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 16:28:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5452D58017;
	Wed, 11 Nov 2026 16:28:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2F7658059;
	Wed, 11 Nov 2026 16:28:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.186])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 16:28:20 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v13 0/5] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Wed, 11 Nov 2026 11:27:53 -0500
Message-ID: <20261111162758.9792-1-oelghoul@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfX3tpQmSN+unpv
 QeUTI37h3uZk+we6QOk0sfiiJ0BDFNkKbAzota6t4bS/O6yWgNk6w3ivW2N8320W3Yf4N7m2/zO
 o5JKLUBc9u/yzALrzOEhD9qmNJlYnw0=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af497ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=4XtsKJ7C2CqOUlitrrcA:9
X-Proofpoint-GUID: QrE5duV_j2gq-9JvzKm4O2BSkmtYSLmF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfX4lFnuS6jXWXf
 b4xu3t5t1BbtLzMM4joy8KAzAkIuwcIhoqF+BSCmWRooCwK9qxuEQ18Ww4PLGVz4MWm5REkOrVW
 caUT/lAwdSUixEewaAfM4u6w76cszx6AGhoRmbEA0EyrLSdnpzb76z9o4tSyexxQ0jwys+QBzqQ
 YMYormcWC9cZ8Fgz4ppt1Kq1LhAcvMaCiyVPIf63Qq9EImZlPbpz6LoNVzz0Zltch7wKYknaP2o
 NVpaawb+VuxO9WPrzuX//B+u06p8L3Ai4Z5pJ+7cLIkwO9Om2Yi0194Wp01FJmN8jfkADzUtOmg
 L9lb/jbtY9iXlhdPTfifHpTqs8ZDXRbOywsGJZ0DO7tvwKq7pd0nalm2zsLEsrXpKDh7d5qo+pU
 gRKRjJ5eX2s1xznVA+lgmvzT5CIm5OFvp0KLop5AwfI/DCKdRN88TDg6WIFEnZOB9dtmtMbBwsk
 LwcDttYMouTVgMXz1lg==
X-Proofpoint-ORIG-GUID: QrE5duV_j2gq-9JvzKm4O2BSkmtYSLmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110064

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390.

Changelog
=========
v12 -> v13:
* Patch 3/5:
  - Track FMB enablement in zpci_update_fh() to account for the case
    where the PCI function was disabled from under the kernel

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
 arch/s390/pci/pci.c              | 123 +++++++++++++++++++++++--------
 arch/s390/pci/pci_debug.c        |  15 +++-
 drivers/vfio/pci/vfio_pci_core.c |   4 +
 drivers/vfio/pci/vfio_pci_priv.h |  18 +++++
 drivers/vfio/pci/vfio_pci_zdev.c |  64 ++++++++++++++++
 include/uapi/linux/vfio.h        |  30 ++++++++
 7 files changed, 226 insertions(+), 36 deletions(-)

-- 
2.56.0

