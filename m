Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD271B86CF;
	Fri, 26 Jul 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003472; cv=none; b=TOr5EPhpWufEzKv8Z2a50LZV71lcM+rlp3jRReyD/E6hRa5AofXKGCsbhyeL0zJfIUZ0Ven3+A99xk/NY/or+Fh88E1mwtN8cPAYHnmqQUlBmZdzaNLM/8JTsOmHqtJzslZTCf2YShLjg4Zg57vzpP7TOsmd7uRLCvGAlse+DDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003472; c=relaxed/simple;
	bh=m94Gnu0+cQ/UnRtKqw0/DwecjPO8FUz7R3pX9OR8GkE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=kUoq866AbxVbdtq/KOwti32neDen2pbRN2V8Hnn07d8qu0eWa0do13Jm+2fHyhCTbJSp9HDJFvJMYUn/UZVrF7CFXEgkEQdDwdoPmF+CcikZL+yTglJFpR7jy5+/Q5HmXh1YLPChZLHuQRwJY6VFv/NfAr8i+islSH+L9rOY3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s2y8zC8D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s2y8zC8D"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q9MAYb012066;
	Fri, 26 Jul 2024 14:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=JN8gM5hqSOOU4zsShpolyYk8YQiJS54LpmLTQIvjPtg=; b=s2y8zC8DQwoH
	7Y4HVIrpOFwDg8hh2n4aQYIXljB7ekc3CVfEFTrflnycVlSLI+xtPkDXuruynYZ6
	/OUZlA0yaU/ZCLIR5qdWc//+erraZ51mL1msei6lfLZjPSjXjAN93+DdC+cuxLf1
	y82JxJu/KXl4ddQ5k9ahe0nmEQQtPN1OJ+ND60qWZtPfNfZc2pOU0ijMzzmpsHeJ
	ZcnxUiVlvNWNuS5y7Y99EcYsAxKRC2Ci/WwNSDy2adTVsSFfyHBT05GFtVaY4aSg
	qxfKthyr6oJ63HPsrRYuKcRRuTPzfahkzggN1bWSSfrEQN7xx6mXmvq7Wm0jaVV1
	/AzHHMF3nw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40m2kv1p76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 14:17:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46QEAF1s007105;
	Fri, 26 Jul 2024 14:17:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2pue3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 14:17:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46QEHaXb48759280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 14:17:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20FFD20043;
	Fri, 26 Jul 2024 14:17:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B446D20040;
	Fri, 26 Jul 2024 14:17:35 +0000 (GMT)
Received: from localhost (unknown [9.171.57.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 26 Jul 2024 14:17:35 +0000 (GMT)
Date: Fri, 26 Jul 2024 16:17:34 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.11 merge window
Message-ID: <your-ad-here.call-01722003454-ext-3193@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xLlS1AqWO2kchdTP9WCVLDwnLFeDZqiu
X-Proofpoint-ORIG-GUID: xLlS1AqWO2kchdTP9WCVLDwnLFeDZqiu
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_11,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407260091

Hello Linus,

please pull more s390 updates for 6.11 merge window.

Thank you,
Vasily

The following changes since commit 66ebbdfdeb093e097399b1883390079cd4c3022b:

  Merge tag 'irq-msi-2024-07-22' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2024-07-22 14:02:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.11-2

for you to fetch changes up to 6dc2e98d5f1de162d1777aee97e59d75d70d07c5:

  s390: Remove protvirt and kvm config guards for uv code (2024-07-23 16:02:33 +0200)

----------------------------------------------------------------
more s390 updates for 6.11 merge window

- Fix KMSAN build breakage caused by the conflict between s390 and
  mm-stable trees

- Add KMSAN page markers for ptdump

- Add runtime constant support

- Fix __pa/__va for modules under non-GPL licenses by exporting necessary
  vm_layout struct with EXPORT_SYMBOL to prevent linkage problems

- Fix an endless loop in the CF_DIAG event stop in the CPU Measurement
  Counter Facility code when the counter set size is zero

- Remove the PROTECTED_VIRTUALIZATION_GUEST config option and enable
  its functionality by default

- Support allocation of multiple MSI interrupts per device and improve
  logging of architecture-specific limitations

- Add support for lowcore relocation as a debugging feature to catch
  all null ptr dereferences in the kernel address space, improving
  detection beyond the current implementation's limited write access
  protection

- Clean up and rework CPU alternatives to allow for callbacks and early
  patching for the lowcore relocation

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/boot: Do not assume the decompressor range is reserved

Gerd Bayer (2):
      s390/pci: Refactor arch_setup_msi_irqs()
      s390/pci: Allow allocation of more than 1 MSI interrupt

Heiko Carstens (11):
      s390: Add runtime constant support
      s390/alternatives: Use consistent naming
      s390/alternatives: Merge both alternative header files
      s390/alternatives: Move text sync functions
      s390/uaccess: Make s390_kernel_write() usable for decompressor
      s390/alternatives: Rework to allow for callbacks
      s390/nospec: Push down alternative handling
      s390/alternatives: Remove alternative facility list
      s390/nmi: Simplify ptregs setup
      s390/entry: Move SIE indicator flag to thread info
      s390/atomic_ops: Disable flag outputs constraint for GCC versions below 14.2.0

Ilya Leoshkevich (2):
      s390/kmsan: Fix merge conflict with get_lowcore() introduction
      s390/ptdump: Add KMSAN page markers

Janosch Frank (1):
      s390: Remove protvirt and kvm config guards for uv code

Sven Schnelle (20):
      s390/smp: Handle restart interrupt on ipl cpu
      s390/smp: Switch pcpu_devices to percpu
      s390: Move CIF flags to struct pcpu
      s390/alternatives: Remove noaltinstr option
      s390/alternatives: Allow early alternative patching in decompressor
      s390: Add infrastructure to patch lowcore accesses
      s390/head64: Make startup code ready for lowcore relocation
      s390/entry: Make __sie64a() ready for lowcore relocation
      s390/entry: Add base register to MBEAR macro
      s390/entry: Add base register to SIEEXIT macro
      s390/entry: Add base register to CHECK_VMAP_STACK/CHECK_STACK macro
      s390/entry: Make pgm_check_handler() ready for lowcore relocation
      s390/entry: Make int handlers ready for lowcore relocation
      s390/entry: Make mchk_int_handler() ready for lowcore relocation
      s390/entry: Make restart_int_handler() ready for lowcore relocation
      s390/entry: Make __switch_to() ready for lowcore relocation
      s390/entry: Make ret_from_fork() ready for lowcore relocation
      s390/entry: Make system_call() ready for lowcore relocation
      s390/kdump: Make kdump ready for lowcore relocation
      s390/boot: Add cmdline option to relocate lowcore

Thomas Richter (1):
      s390/cpum_cf: Fix endless loop in CF_DIAG event stop

Vasily Gorbik (1):
      s390/setup: Fix __pa/__va for modules under non-GPL licenses

 Documentation/admin-guide/kernel-parameters.txt |   3 -
 arch/s390/Kconfig                               |  11 --
 arch/s390/boot/Makefile                         |   3 +-
 arch/s390/boot/alternative.c                    |   3 +
 arch/s390/boot/boot.h                           |   4 +
 arch/s390/boot/ipl_parm.c                       |   3 +
 arch/s390/boot/startup.c                        |  14 +-
 arch/s390/boot/uv.c                             |   8 -
 arch/s390/boot/uv.h                             |  13 --
 arch/s390/boot/vmem.c                           |  11 +-
 arch/s390/configs/debug_defconfig               |   1 -
 arch/s390/configs/defconfig                     |   1 -
 arch/s390/include/asm/abs_lowcore.h             |   8 +
 arch/s390/include/asm/alternative-asm.h         |  57 ------
 arch/s390/include/asm/alternative.h             | 154 +++++++++++++--
 arch/s390/include/asm/atomic_ops.h              |   3 +-
 arch/s390/include/asm/facility.h                |   1 -
 arch/s390/include/asm/kmsan.h                   |   6 +-
 arch/s390/include/asm/lowcore.h                 |  32 ++-
 arch/s390/include/asm/nospec-branch.h           |   9 +
 arch/s390/include/asm/page.h                    |   2 -
 arch/s390/include/asm/processor.h               |  30 ++-
 arch/s390/include/asm/runtime-const.h           |  77 ++++++++
 arch/s390/include/asm/smp.h                     |   1 -
 arch/s390/include/asm/spinlock.h                |   2 +-
 arch/s390/include/asm/thread_info.h             |   1 +
 arch/s390/include/asm/uaccess.h                 |   9 +-
 arch/s390/include/asm/uv.h                      |  32 ---
 arch/s390/kernel/Makefile                       |   3 +-
 arch/s390/kernel/abs_lowcore.c                  |   1 +
 arch/s390/kernel/alternative.c                  |  75 +++----
 arch/s390/kernel/alternative.h                  |   0
 arch/s390/kernel/asm-offsets.c                  |   5 +-
 arch/s390/kernel/early.c                        |   9 +-
 arch/s390/kernel/entry.S                        | 251 +++++++++++++-----------
 arch/s390/kernel/head64.S                       |   8 +-
 arch/s390/kernel/ipl.c                          |   2 +-
 arch/s390/kernel/machine_kexec.c                |   2 +-
 arch/s390/kernel/nospec-branch.c                |  16 +-
 arch/s390/kernel/nospec-sysfs.c                 |   2 +-
 arch/s390/kernel/perf_cpum_cf.c                 |  14 +-
 arch/s390/kernel/processor.c                    |  20 +-
 arch/s390/kernel/reipl.S                        |  26 ++-
 arch/s390/kernel/setup.c                        |   7 +-
 arch/s390/kernel/smp.c                          | 141 ++++++-------
 arch/s390/kernel/uv.c                           |  35 ++--
 arch/s390/kernel/vmlinux.lds.S                  |   5 +
 arch/s390/lib/spinlock.c                        |   4 +-
 arch/s390/mm/dump_pagetables.c                  |  30 +++
 arch/s390/mm/maccess.c                          |   4 +-
 arch/s390/pci/pci_irq.c                         | 110 +++++++----
 drivers/s390/char/Kconfig                       |   2 +-
 52 files changed, 746 insertions(+), 525 deletions(-)
 create mode 100644 arch/s390/boot/alternative.c
 delete mode 100644 arch/s390/include/asm/alternative-asm.h
 create mode 100644 arch/s390/include/asm/runtime-const.h
 create mode 100644 arch/s390/kernel/alternative.h
