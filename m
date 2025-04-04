Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31C1917CD;
	Fri,  4 Apr 2025 23:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743810887; cv=none; b=R8oHX53hhQKzEQr6bPi7D3LN4boDnctjtjSLYg2AJdJ17rZXuw3MQLN3y/w4fvZ2UyLzfprREj/G/Q+S1Xddllsg+8JzxfuugFmM07B7g4HO0cBnQYw6MJDhhmJZxDfbMMww/09ofY4FIEruLQ8LVnFCOxkzMBdeDCkzz/LVp54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743810887; c=relaxed/simple;
	bh=pER3aUoDgAqA2+VVwE0Vofm3FT0WcT6/M8BsxGqxujE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QIEmhOLzEBghvsBxazzdbcZsVsBb1VttCfFgWbdaCcrwCutXMTrmKEuuil7nE4+1mkNQ0PEuftwPWbhgslOLaRxiv/mnfj23Db9uHu2Bd1zk+O/34UtZcN+QoChhj/Z3hjAUamb4CirFv4//UzHx67xQAYh0sC52g/Bo8//IVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AqwPLZms; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AqwPLZms"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534KaFQK017550;
	Fri, 4 Apr 2025 23:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=8pwM63EqW2WvsEd44FnIL5x8/UkpAY1JzF2h/xpHxtM=; b=AqwPLZms
	LPC6Chn5tauOVu9vt1FbuCl24TL/K6TXYXRwSWmBpL2sfoXVMabg/mOGHF3ie3Pb
	ddYiIioqga0eV2nLCztJwHQVr050EcmTYMVBLzZs9U0UmK4FkixUiwwSBCaSGzc0
	Ipr74UHNOkWL6V70VQ+1SW9+c/xHfi+pIQRq61ZGWkeRtdcR/oPz8tarUK669YSK
	kxf1111dKj/wZX41T9TNWFqHrHw/j7RIOR59F1hL6pvg4ws7OzD5hEDyBBCicsXs
	APJ6pLCkxDTTiQKXUJyziBi9kraBB1mS+JKtaETQmsqDVYq1CZ2WdkxaVyKF2upc
	4le/PWZKjVALKg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45tpkq8mar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 23:54:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 534NZU11001877;
	Fri, 4 Apr 2025 23:54:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45t2ch5d1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 23:54:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 534Nsd0136831728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Apr 2025 23:54:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7F1620043;
	Fri,  4 Apr 2025 23:54:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73ED520040;
	Fri,  4 Apr 2025 23:54:38 +0000 (GMT)
Received: from localhost (unknown [9.171.53.112])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Apr 2025 23:54:38 +0000 (GMT)
Date: Sat, 5 Apr 2025 01:54:36 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.15 merge window
Message-ID: <your-ad-here.call-01743810876-ext-9359@work.hours>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RytKj4lsZh2pV_K-ocq_Q5SDeXdf1YF-
X-Proofpoint-GUID: RytKj4lsZh2pV_K-ocq_Q5SDeXdf1YF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_10,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=839 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504040162

Hello Linus,

please pull a few more s390 fixes and cleanups for the 6.15 merge window.

Thank you,
Vasily

The following changes since commit f90f2145b2804c0166126a6c8fbf51d695917df3:

  Merge tag 's390-6.15-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2025-03-29 11:59:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.15-2

for you to fetch changes up to d33d729afcc8ad2148d99f9bc499b33fd0c0d73b:

  s390/vfio-ap: Fix no AP queue sharing allowed message written to kernel log (2025-04-01 16:24:22 +0200)

----------------------------------------------------------------
more s390 updates for 6.15 merge window

- Fix machine check handler _CIF_MCCK_GUEST bit setting by adding the
  missing base register for relocated lowcore address

- Fix build failure on older linkers by conditionally adding the -no-pie
  linker option only when it is supported

- Fix inaccurate kernel messages in vfio-ap by providing descriptive
  error notifications for AP queue sharing violations

- Fix PCI isolation logic by ensuring non-VF devices correctly return
  false in zpci_bus_is_isolated_vf()

- Fix PCI DMA range map setup by using dma_direct_set_offset() to add a
  proper sentinel element, preventing potential overruns and translation
  errors

- Cleanup header dependency problems with asm-offsets.c

- Add fault info for unexpected low-address protection faults in user mode

- Add support for HOTPLUG_SMT, replacing the arch-specific "nosmt"
  handling with common code handling

- Use bitop functions to implement CPU flag helper functions to ensure
  that bits cannot get lost if modified in different contexts on a CPU

- Remove unused machine_flags for the lowcore

----------------------------------------------------------------
Anthony Krowiak (1):
      s390/vfio-ap: Fix no AP queue sharing allowed message written to kernel log

Heiko Carstens (7):
      s390/lowcore: Remove unused machine_flags
      s390/kvm: Split kvm_host header file
      s390/asm-offsets: Include ftrace_regs.h instead of ftrace.h
      s390/asm-offsets: Remove ASM_OFFSETS_C
      s390/processor: Use bitop functions for cpu flag helper functions
      s390/smp: Add support for HOTPLUG_SMT
      s390/mm: Dump fault info in case of low address protection fault

Niklas Schnelle (2):
      s390/pci: Fix zpci_bus_is_isolated_vf() for non-VFs
      s390/pci: Fix dev.dma_range_map missing sentinel element

Sumanth Korikkar (1):
      s390: Fix linker error when -no-pie option is unavailable

Sven Schnelle (1):
      s390/entry: Fix setting _CIF_MCCK_GUEST with lowcore relocation

 Documentation/admin-guide/kernel-parameters.txt |   4 +-
 arch/s390/Kconfig                               |   1 +
 arch/s390/Makefile                              |   2 +-
 arch/s390/include/asm/kvm_host.h                | 339 +----------------------
 arch/s390/include/asm/kvm_host_types.h          | 348 ++++++++++++++++++++++++
 arch/s390/include/asm/lowcore.h                 |   4 +-
 arch/s390/include/asm/processor.h               |  19 +-
 arch/s390/include/asm/thread_info.h             |   3 -
 arch/s390/include/asm/topology.h                |   6 +
 arch/s390/kernel/asm-offsets.c                  |   7 +-
 arch/s390/kernel/dumpstack.c                    |   1 +
 arch/s390/kernel/early.c                        |   1 +
 arch/s390/kernel/entry.S                        |   2 +-
 arch/s390/kernel/setup.c                        |   1 -
 arch/s390/kernel/smp.c                          |   9 +-
 arch/s390/kernel/stacktrace.c                   |   1 +
 arch/s390/mm/fault.c                            |   1 +
 arch/s390/mm/pfault.c                           |   1 +
 arch/s390/pci/pci_bus.c                         |  27 +-
 drivers/s390/crypto/vfio_ap_ops.c               |  72 +++--
 20 files changed, 437 insertions(+), 412 deletions(-)
 create mode 100644 arch/s390/include/asm/kvm_host_types.h
