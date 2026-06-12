Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE60395D8E;
	Fri, 12 Jun 2026 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287859; cv=none; b=FyivClU5b/JpBahePT0ojTulxM05h9ao2pKRyyAulwis74th6CpiYdoUOuCfoO+BKjCXoIz9k9HT/i0aLEChsXc3HuQJFvxEgOlkxQvDByGAVzTJtELEd5+UajMLZlqx5qAI9pAbcTH9xQLjp2WdnjJ+2QXNDKkf1CPs6YmbNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287859; c=relaxed/simple;
	bh=uI8rBc9ewDtKqYRiNwr5heTjCZerbdtNRt32qkK4fGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYnqz2f9vuyo9oiLkfmGZmK4QtpWbo6Q5oXkHqndH9u5G2T9UcwnjecB8VAsDIGmdo1Qg7HqgppwBmdQ+umStlOXp0S5a0eH3WoBpad9Fwq5MJq1nM4NNPb6LhsVNFXcJOcBTNMdgpx4rYSUo5kXsm9frPfe0K/XYJCFCSO1UKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NU5+5ok3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NU5+5ok3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CF0Ukn1741881;
	Fri, 12 Jun 2026 18:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jzVHuy4UbyD6IDt7wRZEfGA+jSCcogBwuv9iJ0oIW
	dA=; b=NU5+5ok3+Hk+a5rsVPCKDj5ZSbN6vYDx3EqH4crc6SDM7pCi2MVnJqRuR
	Pk3Kh43/hJYhwg3AXDHiVAkZ+1ZrIAIhosrtkrhSR5ckF1oA9/rnT7ai/3Ko5jkP
	hQMCEnoWX1OrCT0PSdH4H4WF3R1ACNfSGpthdJ0foflwXcRjuFd+z8dotVfTmYvC
	bzw6mmOUPnOhOf/mMga/ZY01xqfONyG6eelunJVZ0+8LtoQIEjgDJyFVnLH9Tp+8
	sSH97vKpvbwLZolwHj0Em74yFwj4n1I7nk6zXEy/dHK+42vpWSAMMXRKRWTMHpw8
	1Cy9Db31MrVd1Mdt4jNkfG5EtcVGQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8bswde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 18:10:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CI4bEM026082;
	Fri, 12 Jun 2026 18:10:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe09125c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 18:10:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CIAoIb57737542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 18:10:51 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B037258056;
	Fri, 12 Jun 2026 18:10:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 919EE5805E;
	Fri, 12 Jun 2026 18:10:49 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.255.20])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 18:10:49 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v4 0/4] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Fri, 12 Jun 2026 14:10:44 -0400
Message-ID: <20260612181048.91548-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2c4baf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=INpJ-xd0T3vPFEcI0U4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE2OSBTYWx0ZWRfX45By2UqMy9F4
 YFUvwOlDXHSYoEFucgu+I3Jr34mD4+7jrmKDzrQ7K4Qp5T7iGpxM1mPgCJWJ+TVodTHVZkxo/xO
 Bdh8VtPN3Ynqyj6/750d9lSuJpdrDQjbgQgqix3cotYVgWV98wI0oWq9TMqg4U5LNXtJvWd2vju
 QFesiGjkmycYb9kDaoueEWri8K+KVXZrbjkKbxAC0lzp7SAa3u79HW6eJ2izuf4aD9GVOtsqAXb
 U9XnkWegQSvQUgzuc36GdFJ8HekRJ6HDSIxIzAhIajKdBrOeBYJjMTABdLQnpWPIRRmmbXMlfJD
 MUp8+alceMLwoJzXSqg/LZdj9fFrLzbFVUa/69fLnC9XN18W/0G9t/oU+mScRceWArWzkYr8/Ww
 KCPAfRwVDMuxrEc0zN1jhsJ75Xdf1++VMesoOjBnuTN7pxFfhHhUtzQ7vP/Eu78L20r2qGEq2QM
 aEPwha4ECq13sIWR6Bw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE2OSBTYWx0ZWRfX1wTGk96aSzXq
 +X4CtROw6iNdwIG1gFx3w284qL4YU0aKCjAOYT4qHQ7q8+uJqt39zcvok0qK46KJ+Qhbyk6u7xl
 2eQTP+jt9Azv5CGkP+p5cfgal7WnjTI=
X-Proofpoint-ORIG-GUID: VJe4tbmBmJzNM8rxfkrlr1bQE-wCs1AB
X-Proofpoint-GUID: VJe4tbmBmJzNM8rxfkrlr1bQE-wCs1AB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120169

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390x.

Changelog
=========
v3 -> v4:
* Patch 2/3:
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
  vfio-pci/zdev: Add VFIO FMB device features
  s390/pci: Fence FMB enable/disable via sysfs for passthrough devices

 arch/s390/include/asm/pci.h      |   1 +
 arch/s390/pci/pci.c              | 107 +++++++++++++++++++++++++------
 arch/s390/pci/pci_debug.c        |  11 +++-
 drivers/vfio/pci/vfio_pci_core.c |   4 ++
 drivers/vfio/pci/vfio_pci_priv.h |  18 ++++++
 drivers/vfio/pci/vfio_pci_zdev.c |  55 ++++++++++++++++
 include/uapi/linux/vfio.h        |  29 +++++++++
 7 files changed, 206 insertions(+), 19 deletions(-)

-- 
2.54.0

