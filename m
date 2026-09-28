Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCE33EB01;
	Mon, 28 Sep 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600860; cv=none; b=DmzEFk3FGe36omACoaIIohHeyXLuinxw2I7A2XUpFp76vuSYTt97PSGTaYQO0q6J+DGe9qeCiWRXu7V1REaplFhy5EoO/ny0X112si+//KilaYME/f3svBS25dJpp+ZK7Ofy9zNaiw7caP04xmvSimnTGw93X7Yzssro62sDH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600860; c=relaxed/simple;
	bh=HyX/iDcSsA8Wpj5ALg1rKINrt1MNK2L/+DHmyHOdmao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cZfGslOWsESR6DREo8QVhwWpOje8CEfkAiy7p6QfVAq5zhEio5pGqdF5avsPUZSPQzZQUkjGEW7Y5B140K+VUL6w2eMilJm7B9UyMZ1/K6KQ5Ayh/EYnWBFW1DMJ7msQlv+puAvTc4MyTF5fSLYSrJi+ahsiw9RjtjbpQZrTgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ot3qaigB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ot3qaigB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZa7g823791;
	Mon, 28 Sep 2026 13:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Aw/YH6AU7HaYEn5EoggLYb/lvqaG
	yVKu2hAw2/tbfQo=; b=Ot3qaigBPc/KzRTsgwHFuVzvVTMhwR1KYapzgqJs9tMV
	VqRVQuS9s9y80Q4RwoAm6kWxSPS3X4TgmYJab1OWPnpEA1qGvSXmwLFtwjI2+Jyi
	+VFkdpd4DWcNTXFnHIsmAzMwIffFb17z6Svqlw/YqcPFs0ASRuKvX974rWqphax8
	Ewla9L6pK1uj6Oha019wXTabhr1QEBfWigLWDYPTe41Yckx2YdCja0xxsy1hFqBs
	mmXCrm9k28YvkRZNm6dXQXn6/+POBHGbD9Bdfc9JgPjQezvwR6RYCc4sN+ZTP0Ch
	DeGqEgx3kpEk1EGifUOaoGjSHMIfVn1rGte4wRZ1hg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk1bwr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 13:07:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHX1S069402;
	Mon, 28 Sep 2026 13:07:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpnfj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 13:07:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SD7EwA42991880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 13:07:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8C3C20049;
	Mon, 28 Sep 2026 13:07:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A70E20040;
	Mon, 28 Sep 2026 13:07:14 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 13:07:14 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Subject: [PATCH v4 0/6] KVM/vfio: Use file-based reference counting for KVM
Date: Mon, 28 Sep 2026 15:07:01 +0200
Message-Id: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MSwrCMBSF4a1Ixqbk1UccuQ9xkKSJvWAbSTRUS
 vduWgpKcXgu9/snFG0AG9HpMKFgE0TwQx7ieECmU8PNYmjzRoywijSU4eTAYydJJdtG6VKUKL8
 +gnUwrpnLNe8O4tOH91pNdLnuAoliikvjLNHUKWHr8x2G11iA7gvje7REEvtCSfgGWYbWCdMKK
 on6D/kPZGKDHBMsFJOCk7qWtd7DeZ4/joV+uQ4BAAA=
X-Change-ID: 20260812-vfio-f9069d8ab545
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LNxxJbZtYmWFKo4GoBDrAfeJeK0MT7P_
X-Proofpoint-GUID: cYVvOHNPT2RWuWRvvsjgPAc656ALrldR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfX5HluGe6um9T2
 AEbMgnnRkTNeS2g87P9g2pTQuaVdpRcAKHevNnCbj//1m8cJOQWSQLxZqA3Ey5tVYt2LnQgxidx
 vTNQB39vvoqB0soCEf35kOCuzj0oXyk=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6aba6688 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1mAWvp4K8iewrBkhS6QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfX00tdB8a4eRP6
 PoN15hbkNBowVicpXF8MMrJz147zdiNdlsqn3MUNiibMImLZBFUru0vr7Xdcd/p4gRRcc37pNMq
 RArXDLOyicx6FScV9Xfg6C0Qir4rkaC5o9p9XbspRMd4rPEpbRHfX4g+Pv+q9eR/tGoXZeIAbM2
 K2rb5EyiUFx/LgocDOfIH8vAmIzNv2y3by/aRRHVhXQzFJ9PX6hS6mmYJUqDBzGbnNUbgxAQ+sw
 MBtX5IwDsVITcqn1RorvBH+ID7/SKX/PLxtlEu77FOPgriOHlL/5VaCypjOl+bgMayJfXpOQAlF
 1tz3Z1sYQ4oeRld1erIsq4aROr6MhIY/H1dQMCVhvk0KY9y+xrwqJLEMnXUYEho4guCciQLfALz
 mGq1pjmNKsU+h8WS/ORPnjnXEJZem7Xt5g9HJuBDmFFwV6h5/GaHfRYsK2Fg60qpBtvLpStOdJ5
 wNwm45UXld5co16VcfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280052

This series switches the KVM-VFIO interface and external consumers over to
standard file-based reference counting, eliminating all external KVM symbol
exports.

This is a spin-off for the arm on s390 series (old version: [1]) to
address all the relevant persons w/o polluting their mailbox. The
arm-on-s390 series now dropped those patches and depends on this series
(for beeing able to link with KVM=y)

Currently, VFIO integrates with KVM by looking up kvm_get_kvm_safe() and
kvm_put_kvm() dynamically using symbol_get(), manually tracking module
reference counts and storing a put_kvm function pointer in struct
vfio_device.

In the ARM64-on-s390 architecture, a second concurrent KVM module
(kvm-arm64) is introduced alongside native KVM to host hardware-accelerated
ARM64 guests. Having exported global symbols (like kvm_get_kvm/kvm_put_kvm)
creates symbol conflicts and prevents clean coexistence of two KVM modules.

Additionally, the file based counting simplifies the code and reuses
the existing fs refcounting.

Instead of passing raw KVM pointers and managing module symbols manually, the
interface now passes the underlying VM file descriptor throughout VFIO and
associated architecture subsystems. To safely extract the KVM instance from a
file, an architecture-namespaced helper mechanism is introduced that verifies
the file belongs to the expected KVM implementation before accessing its
internal state. A back-pointer from the KVM instance to its associated file is
maintained across its lifecycle so subsystems can safely acquire file
references on demand. Finally, with VFIO, architecture page tracking, and
device hooks converted to use file references, the remaining KVM reference-
counting exports are restricted strictly to internal KVM modules.

	Steffen

[1] https://lore.kernel.org/all/20260918133107.1042730-1-seiden@linux.ibm.com

---
Changes in v4:
- Add patch to remove now unused file_is_kvm()
- Add Jasons r-b
- Link to v3: https://lore.kernel.org/r/20260924-vfio-v3-0-4a294307797b@linux.ibm.com

Changes in v3:
- Split the previous single monolithic patch into 5 smaller, focused patches:
  1. Add opt-in macro infrastructure for `file_to_kvm_<arch>()` helpers.
  2. Add `kvm->file` back-pointer to `struct kvm`.
  3. Use `file_to_kvm_x86()` helper in AMD SEV.
  4. Convert VFIO, s390 vfio-ap/zpci, and x86 page-track to file-based refcounting.
  5. Restrict `kvm_get_kvm`/`kvm_put_kvm` to `EXPORT_SYMBOL_FOR_KVM_INTERNAL`.
- Introduce macro-generated, typed `file_to_kvm_<arch>()` helpers instead of generic casts.
- Clean up `vfio_pci_zdev.c` by passing `struct file *` through `zpci_kvm_hook.kvm_register`.
- Update x86 page-track and s390 AP/PCI to use `file_to_kvm_<arch>()`.
- Update x86 Makefile export checks.
- Link to v2: https://lore.kernel.org/r/20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com

Changes in v2:
- Rebase on 7.3-rc1+ and resolve conflict with 9f240376d034 ("s390/pci: Store
  PCI error information for passthrough devices"),
- Fix stub prototype for vfio_group_set_kvm for !CONFIG_VFIO_GROUP
- Link to v1:   https://lore.kernel.org/r/20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com

---
Steffen Eiden (6):
      KVM: Introduce file_to_kvm_<arch>() infrastructure
      KVM: Add file back-pointer to struct kvm
      KVM: x86: Use file_to_kvm_x86() in SEV
      KVM/vfio: Use file-based reference counting for KVM
      KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules
      KVM: Remove unused file_is_kvm

 arch/s390/include/asm/kvm_host_s390.h |  4 ++-
 arch/s390/kvm/s390/pci.c              |  9 ++++--
 arch/x86/include/asm/kvm_host.h       |  2 ++
 arch/x86/include/asm/kvm_page_track.h | 10 +++---
 arch/x86/kvm/Makefile                 |  4 +--
 arch/x86/kvm/mmu/page_track.c         | 22 +++++++++-----
 arch/x86/kvm/svm/sev.c                |  8 ++---
 drivers/s390/crypto/vfio_ap_ops.c     | 20 ++++++++----
 drivers/vfio/group.c                  | 11 ++++++-
 drivers/vfio/vfio.h                   | 12 ++++----
 drivers/vfio/vfio_main.c              | 57 +++++++++++------------------------
 include/linux/kvm_host.h              | 19 +++++++++++-
 include/linux/vfio.h                  |  5 ++-
 virt/kvm/kvm_main.c                   | 21 +++++++++----
 virt/kvm/vfio.c                       | 13 +++++---
 15 files changed, 129 insertions(+), 88 deletions(-)

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e

