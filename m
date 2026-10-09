Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3487399CE9;
	Fri,  9 Oct 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556097; cv=none; b=hlFIo1+KekuXv8IbCokdcMdiCMdLWRbRCXRVZ4VwPwTPKX+DslHdNMnxh7Lk+hNPG3yrp6dyPgyx3cSuSZu1u5AAJFzlbW0S0GZSL8jCNY90mdo90201diJDjeRn4G3rZ8ZZC+EuZKYq2IwKAEqqyca+6OziFPoqRSIfVGx4Ztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556097; c=relaxed/simple;
	bh=+ihVru4w/e+YoWc+gVz9GPwSif5jOyQDMC8wDl5kOeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaFoQhtkHUX3lmzr8zMc1tXakP+ubpU5g813qQOOlfieSPp6gBNSRLDxZXPgSJh/IG+sVSJG8nIiYHhFMy1okrpW1pfSl9QKqOiD5K0LFG4m61Z2AL9dJVxDZLq5Z8ZqiwyObW9l5jyC5945+KCL6CxXyFoXmo/sh1mnwmbaXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gh8BLYsE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gh8BLYsE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699Da96T237184;
	Fri, 9 Oct 2026 14:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=e55VZ9S8b8BZI8aaCWugVoRWp7OmqL34OPoZdhEXx
	XY=; b=Gh8BLYsE5YsJ0yodnnLD8Hh4r/9ZutpVYZVSzDPZST6bjctBhgQDYk4Gf
	iI8LnQstR0vLUGpW5Usbnv5MZ0PbHTK+NaI54p/F337foNHe/7vcnmF2DCZnJ+KM
	X3X6qOsDrTw0h5Dz9j2JcU4fjP0fJKtGxVOdsCmWmSJhBK8MWGwxNPFYxA19XILv
	HbArB/Po5cxZ680Eeq/seG6n/sVyVAYJF1fbgHb6eEbaosgx47VPH88VvdLYEPP6
	RMatYNfwN53vFzBITGr+0stCKRF4D7axWCNkIYTtePEtUoVYOsmMXJVuTtRr0de6
	VEuowr8jrFC/VYNp0RPrP3CFzl/qw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvte8d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:27:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699DlT4c931717;
	Fri, 9 Oct 2026 14:27:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s3511yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:27:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699ER9eE25231956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 14:27:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D68B758057;
	Fri,  9 Oct 2026 14:27:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C8D458058;
	Fri,  9 Oct 2026 14:27:50 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 14:27:50 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [GIT PULL 0/6] KVM/vfio: Use file-based reference counting for KVM
Date: Fri,  9 Oct 2026 16:27:43 +0200
Message-ID: <20261009142749.186650-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: fE-ec00toE65cDEUXZwBAPHU7we-xpDd
X-Proofpoint-ORIG-GUID: 7UkiNhoBaumwZHpYVtwg7o9SqNL9P3tl
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac8f9ed cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=riMnk5uTvMUyhOgnS6gA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX4Q4exmzZukk+
 /Iim6bKGcQNfdx8l/5n86LSOdmPGfoiNbLxIGC1Z97B+/64YE73PU32VKfxI1ds24j49ehlkbMR
 +CBWPpkGTOEU/AxfBeP3qUC9frMePZc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX1RJn3hkGpD98
 GYnXQlHBq2FfCgykTHrbg4Q9sgaljGBE9X2MKYEuNQp2cTx7hO8iTlPIX+YExDQEGieLWOwE9Hl
 qQkbuO7fyaYmszb8zhlpt9ZWhlHFB0paBk+7tLX4mM6nxUdM4SkYXL4ycBovnWwTnkXdsUNMs+K
 4XoLtfTVakcuhh8mCoOGk/pxzLJ88bQvIJ05kq/CSoFgW9sM80HvTenSjfp0Vub8rpi6XhU1eEg
 1N6YlBEI7vbA4C4poYWBQTzLo18frwE8V/GC6fWEFJ/OIXMG9IMTF7IHDkQ2zg/CHBbF3mdHadk
 RcjDvXHS6B8YjQlwUM2zWc4bSIdumEm1Nj/I1pU2y220d36qFQMfik4M+Kx9uu7sX3ihAmv2djR
 /u4sz6XtU5CPkODWvSI/2wjI9flDL4mH6oJ5i/u2UbfMCV7R7wBXDU/F7KlLQEq0iojXM6Rlxrp
 8MW/r+oZ1ZaJYt4B9WA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090056


Paolo,

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-7.4-1

for you to fetch changes up to c22295d0d75f5590fdde5493cb90e2d50d5f508e:

  KVM: Remove unused file_is_kvm (2026-10-02 10:40:01 +0200)


The tag points to the vfio_file_reference branch of the kvms390 repo
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=vfio_file_reference



----------------------------------------------------------------
KVM/vfio: Use file-based reference counting for KVM

This series switches the KVM-VFIO interface and external consumers over to
standard file-based reference counting, eliminating all external KVM symbol
exports.

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

----------------------------------------------------------------
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
 drivers/vfio/device_cdev.c            |  2 +-
 drivers/vfio/group.c                  | 13 ++++++--
 drivers/vfio/vfio.h                   | 14 ++++-----
 drivers/vfio/vfio_main.c              | 57 +++++++++++------------------------
 include/linux/kvm_host.h              | 19 +++++++++++-
 include/linux/vfio.h                  |  5 ++-
 virt/kvm/kvm_main.c                   | 21 +++++++++----
 virt/kvm/vfio.c                       | 13 +++++---
 16 files changed, 132 insertions(+), 91 deletions(-)
