Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207F3603E0;
	Wed, 22 Apr 2026 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875360; cv=none; b=iRnXjq0lw11aO7qXZf6adTcJcfVgkt0qK0nbWdFY41/wmPD042iqiSgjy7XJNVSzTxa9+vehFPim+GVzHQJ8dWQ10aw3LEI+Qif5FFRkih0frnLZ7G3QTtjxtmLuIXnWxX3iAFBH+ci9orYo1c8MhD5489NyY9YOPcA3ROh19Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875360; c=relaxed/simple;
	bh=cmc9mauvA3aZW+rH/TXOSPez9LM9/FwDPvupjFU3FIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SW4fkshS4MQkqxFCwj/GlTQxC9VUOoEmOpotXMV59QpBEeYb2+chVqMvfw6YFLXa5fT0cb/6+Ky6bR8n5W7r0ZyNdo5ke7g4Iw/zq3UJor4KQPGzIe3Wcr9gigc7njV/K4QwK/Uin0TVPW1KL2GXT4L+WYbooGzPngjRKVBG92U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QCeipMRK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QCeipMRK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGMHqw3291923;
	Wed, 22 Apr 2026 16:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=dCdMPOMaaGTwCiShvqCS0Swn+i8mAdMr3AiigKq+LmI=; b=QCeipMRK
	n1o0Znkw8l7vD/KrEVc7WYb9CSIrK05GmpnWwTlLZi1VskCy6bE9nMG7jfr0fMO4
	LL7WYvSIKng8qFXwjFj1JL2fOecbaQ7uvHjBcpzZ1OUSCEI3XQuZOgeuSji/aAg0
	LjW6MhrUjB5N3JoMQ01BlLt+EmHko+zDE6f6nCqs9j+HfLmGXSutP0AuUySyaVO7
	8BbvHcACsjDBRReXqLYfSy4GHvyIlT2yYRg7qco0PyO3JumytX9v5cQv0ZJywx0c
	a1wZ+GSAKKEdrj6toE1tCRMyTLdZBmO49H8KMXcLWQRcgGGvHOrfSfL+G1ZUyPLz
	4qGy8A/+PnBauQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrbv4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 16:29:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MGKJtZ007569;
	Wed, 22 Apr 2026 16:29:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyayak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 16:29:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MGTCgY29557362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 16:29:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 021D720040;
	Wed, 22 Apr 2026 16:29:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9242720043;
	Wed, 22 Apr 2026 16:29:11 +0000 (GMT)
Received: from localhost (unknown [9.111.26.192])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Apr 2026 16:29:11 +0000 (GMT)
Date: Wed, 22 Apr 2026 18:29:09 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 7.1 merge window
Message-ID: <ttdwlsl@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uyEjhWkDNZ6-UkAhE3v2rZ128v88jJeo
X-Proofpoint-ORIG-GUID: uyEjhWkDNZ6-UkAhE3v2rZ128v88jJeo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE1OCBTYWx0ZWRfXz8YSxET3hztC
 NTLUWKQFmOWQRHO11DPLPEKNBp7mP7UVNGaoT9REL0ODjXgYj4Dj7vPM+FgbU0N7DbCT/k5m4En
 Yt9nSkb1jcNPAOX6h0t7H5dzYegxTs/G0tUy6WLLjM4aFti65lLf3jA1n43jhv6utkepoNY1lFM
 Z3gTs8vY7iFtTvJ2fyRN0bqp0uoC2PBrJVvkFxyim+Uce4g/keIOzURu65GoMr334j3jNWDuHhn
 a3/ZSUuNBRXyIcgSU2MAg7+kbfVj1SWWrDbOueJrXmy4UMHZ5f3GHnEr3W8Q8qy0P22XwoZyHZ+
 7Yeo+F9qp0zI8vkEMA62OcEM2deP4ODbjSAjFTdpLqJohNKOng0dlY11zbJHMN5uWHP98ktI6xc
 PHZe76ybfE4GFmZhScmqjxMCBtEyt/ZPRa8xVV7vjUsnSQxpRMXCTXB0+Ni4FxgymB7OwGSMwb0
 wP/T9AGmRsvAN8ikoNA==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69e8f75d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=Z4Rwk6OoAAAA:8 a=ElOyZwc2PqmQcCvt6j8A:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220158

Hello Linus,

Please pull s390 changes for 7.1.

Adding s390 CONFIG_PAGE_TABLE_CHECK support touches common mm/ and the
pgtable headers of arm64, powerpc, riscv and x86 to pass mm_struct
into the pxx_user_accessible_page() callbacks. It has been reviewed-by
Andrew Morton:
https://lore.kernel.org/all/20260312135757.d65e8145d9d39e1ca5bc9666@linux-foundation.org/

Adding the PCI function UID as an arch-specific slot attribute
touches common PCI code to add an ARCH_PCI_SLOT_GROUPS hook in
drivers/pci/slot.c, and has been acked-by Bjorn Helgaas:
https://lore.kernel.org/all/20260408165737.GA295659@bhelgaas/

Thank you,
Vasily

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-1

for you to fetch changes up to 8d7ea40011551c2ec915ee0260cae1c746c63156:

  s390/zcrypt: Fix warning about wrong kernel doc comment (2026-04-11 11:18:15 +0200)

----------------------------------------------------------------
s390 updates for 7.1 merge window

- Add support for CONFIG_PAGE_TABLE_CHECK and enable it in
  debug_defconfig. s390 can only tell user from kernel PTEs via the mm,
  so mm_struct is now passed into pxx_user_accessible_page() callbacks

- Expose the PCI function UID as an arch-specific slot attribute in
  sysfs so a function can be identified by its user-defined id while
  still in standby. Introduces a generic ARCH_PCI_SLOT_GROUPS hook in
  drivers/pci/slot.c

- Refresh s390 PCI documentation to reflect current behavior and cover
  previously undocumented sysfs attributes

- zcrypt device driver cleanup series: consistent field types, clearer
  variable naming, a kernel-doc warning fix, and a comment explaining
  the intentional synchronize_rcu() in pkey_handler_register()

- Provide an s390 arch_raw_cpu_ptr() that avoids the detour via
  get_lowcore() using alternatives, shrinking defconfig by ~27 kB

- Guard identity-base randomization with kaslr_enabled() so nokaslr
  keeps the identity mapping at 0 even with
  CONFIG_RANDOMIZE_IDENTITY_BASE=y

- Build S390_MODULES_SANITY_TEST as a module only by requiring
  KUNIT && m, since built-in would not exercise module loading

- Remove the permanently commented-out HMCDRV_DEV_CLASS create_class()
  code in the hmcdrv driver

- Drop stale ident_map_size extern conflicting with asm/page.h

----------------------------------------------------------------
Alexander Gordeev (2):
      s390/pgtable: Use set_pmd_bit() to invalidate PMD entry
      s390: Enable page table check for debug_defconfig

Harald Freudenberger (8):
      s390/zcrypt: Move inline function rng_type6cprb_msgx from header to code
      s390/zcrypt: Rework domain processing within zcrypt device driver
      s390/zcrypt: Make apfs a real unsigned int field
      s390/zcrypt: Rework MKVP fields and handling
      s390/zcrypt: Explicitly use a card variable in _zcrypt_send_cprb
      s390/zcrypt: Slight rework on the agent_id field
      s390/pkey: Add comment about synchronize_rcu() to pkey base
      s390/zcrypt: Fix warning about wrong kernel doc comment

Heiko Carstens (1):
      s390/percpu: Provide arch_raw_cpu_ptr()

Jori Koolstra (1):
      s390/hmcdrv: Remove commented out code

Niklas Schnelle (2):
      docs: s390/pci: Improve and update PCI documentation
      PCI: s390: Expose the UID as an arch specific PCI slot attribute

Tobias Huschle (2):
      mm/page_table_check: Pass mm_struct to pxx_user_accessible_page()
      s390/pgtable: Add s390 support for page table check

Vasily Gorbik (4):
      s390/setup: Drop stale ident_map_size declaration
      s390/Kconfig: Make modules sanity test a module-only option
      s390/boot: Respect kaslr_enabled() for identity randomization
      Merge branch 'page-table-check-support' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux into features

 Documentation/arch/s390/pci.rst              | 151 ++++++++++++++++++---------
 arch/arm64/include/asm/pgtable.h             |   6 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h |   2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  10 +-
 arch/powerpc/include/asm/nohash/pgtable.h    |   2 +-
 arch/powerpc/include/asm/pgtable.h           |   4 +-
 arch/riscv/include/asm/pgtable.h             |   6 +-
 arch/s390/Kconfig                            |   3 +-
 arch/s390/boot/startup.c                     |   3 +-
 arch/s390/configs/debug_defconfig            |   2 +
 arch/s390/include/asm/pci.h                  |   4 +
 arch/s390/include/asm/percpu.h               |  18 ++++
 arch/s390/include/asm/pgtable.h              |  60 +++++++++--
 arch/s390/include/asm/setup.h                |   1 -
 arch/s390/pci/pci_sysfs.c                    |  20 ++++
 arch/x86/include/asm/pgtable.h               |   6 +-
 drivers/pci/slot.c                           |  13 ++-
 drivers/s390/char/hmcdrv_dev.c               | 114 +-------------------
 drivers/s390/crypto/pkey_base.c              |   7 ++
 drivers/s390/crypto/pkey_cca.c               |  48 +++++----
 drivers/s390/crypto/zcrypt_api.c             |  40 +++----
 drivers/s390/crypto/zcrypt_ccamisc.c         |  28 +++--
 drivers/s390/crypto/zcrypt_ccamisc.h         |  24 ++---
 drivers/s390/crypto/zcrypt_cex4.c            | 110 +++++++++++--------
 drivers/s390/crypto/zcrypt_error.h           |  28 ++---
 drivers/s390/crypto/zcrypt_msgtype6.c        |  76 ++++++++++++--
 drivers/s390/crypto/zcrypt_msgtype6.h        |  55 +---------
 mm/page_table_check.c                        |  15 ++-
 28 files changed, 467 insertions(+), 389 deletions(-)
