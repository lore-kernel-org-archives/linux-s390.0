Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC57C1ACED5;
	Mon, 15 Jun 2026 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526172; cv=none; b=n+6j0DRd37Mim3fsZehnXI/0y35GKN5taW0djTx9UL3TWYdtOqZS5RjknZXzqvB8av+eAGgB4mTurFHi9onT5r0eWINNj7rE8RyOMl2WWNPR4c4j6846Qoo8/ri8gqorERKvwJ7VDDelrIyz8f5gpqYj2pFy8vU1Qq+q2RfcBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526172; c=relaxed/simple;
	bh=nAOM6baoN4olbxj3COSHuY7+n1He5YSBZ5Nk1t8xy14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NIR/qceUIK91vf/z/UBezefQjqvE49hoNK+UWeWPBthN8raSM9dAaVt6w2oQzHWcE5fyCfjGdxfABkPV1ELry1mZ5T9GYx4Qy9cnR3EWpk+n1Ruy5xkkSMaoQ5sCHUeEfSdFnDak6M2CIYTQRcRHD3MRHp6VhnopiXBng466JA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EfY1WlOC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EfY1WlOC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAnvBJ2208566;
	Mon, 15 Jun 2026 12:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=09RZgQueogt7oA04rACXe/a7cxLhMD24pTjthKaftJ0=; b=EfY1WlOC
	rSP6nCllbfULgLBawjgog1z8tgrIYljqXQrwLrEdY+eakNPbY8B2AEs1RnGWQncL
	ySSeAe1pYrCIvWdIdlGuxSbxRGPOXglkcIFYcF7+NXzRzlzDJ9jB/nasO2V455dR
	tDdYhI+qGO0CjWBSQJRzArW8Pq62GwP34qnym1L0er1XXOrxqukPQiGWFuqW3xp2
	vdX4FlU0FBkEcrwVQACyj9efGxuI4HgU1BO4zIlWC6QVSEXDnh41c5afeMsWxPnH
	aEXIjfIhFqwY1aenLcJitwEjrptrwaR4RCqHMvItXy3gy3Mr595jX8wzR2oi8RUy
	HImG6wDZeRJo3Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm0dcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:22:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCJfwt021310;
	Mon, 15 Jun 2026 12:22:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvxkef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:22:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCMh2Q58851632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:22:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B477220043;
	Mon, 15 Jun 2026 12:22:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EF0320040;
	Mon, 15 Jun 2026 12:22:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jun 2026 12:22:43 +0000 (GMT)
Date: Mon, 15 Jun 2026 14:22:42 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.2 merge window
Message-ID: <20260615122242.535455Aa5-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX7hOru9gMht4h
 uaopsGd8zfnhkhEi/tFRm7KC6oOMGaE+/jIwwW6ZHOhu4h8f8h2VsmLJs/3ySt4XGYQBHHAsW84
 1kN2jItQoaERaaBw26IqqDExUoyF8Vs=
X-Proofpoint-GUID: VLJ_HM-tJTBbO-1jC0_MIwFHBONujRjW
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2fee98 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=IKAKOfZdGujBLnr_cGoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXznE4pFr7WoBp
 Ro10+M8HFBjXSEqK7PpGz4UYQLu/3y5v6TlNP3V8jqp3ScPGuDsoFrClW0xn8t3dB3Bzl+ZoaX8
 upk4KbmqlGVFI/4HZuXfLGdjfs+UE/MglfhxooEEAzjNveuFX4YxRAHiaOP+GrPfyZbkG6FwBG6
 16qDVklKFoZuNrJy+wBQjNvNCD/NIAU8fzP/6gOmvSkBPDKALjEGmQd+D3T3Sp62aWSECU3xwHw
 nYytHPwhs79CqDPRqhcGOZFuWWT7nH2P4qxLGgZeoMIyav62/lZ0qNc64gqUSCJ58DE2YjsYzGV
 5R4UNGmBZCSMS6iEIAebNnK3timor7Dn23/osbHOR8yFf8LMM+R0nGWZuekqEAYylX7XVVE+8nu
 zsxtCbSv8s0EBQKO+RomU7+6Bf8SHVUkvYm9wZlG+RBTw9Kc9UcPAIlX/ifsUhBV1+L9WjLboxQ
 k9YPN9ywr3CVj9CuUTw==
X-Proofpoint-ORIG-GUID: VLJ_HM-tJTBbO-1jC0_MIwFHBONujRjW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130

Hi Linus,

please pull s390 updates for 7.2 merge window.

Thanks,
Alexander Gordeev

The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-1

for you to fetch changes up to 37540b8c287fc817bdbd0c62bb75ad6eab0e5d03:

  s390: Revert support for DCACHE_WORD_ACCESS (2026-06-12 11:30:25 +0200)

----------------------------------------------------------------
s390 updates for 7.2 merge window

- Use CIO device online variable instead of the internal FSM state to
  determine device availability during purge operations

- Remove extra check of task_stack_page() because try_get_task_stack()
  already takes care of that when reading /proc/<pid>/wchan

- Allow user-space to use the new SCLP action qualifier 4 for to
  provide NVMe SMART log data to the platform.

- Send AP CHANGE uevents on successful bind and successful association
  to notify user-space about SE operations on AP queue devices

- Add an s390dbf kernel parameter to configure debug log levels and
  area sizes during early boot

- On arm64 the empty zero page is going to be mapped read-only.
  Do the same for s390 with an explicit set_memory_ro() call

- Improve s390-specific bcr_serialize() and cpu_relax() implementations

- Remove all unused variables to avoid allmodconfig W=1 build fails
  with latest clang-23

- Cleanup default Kconfig values for s390 selftests

- Add a s390-tod trace clock to allow comparing trace timestamps
  between different systems or virtual machines on s390

- Remove the s390 implementation of strlcat() in favor of the
  generic variant

- Make consistent the calling order between page_table_check_pte_clear()
  and secure page conversion across all code paths

- Rearrange some fields within AP and zcrypt structs to reduce
  memory consumption and unused holes

- Shorten GR_NUM and VX_NUM macros and move them to a separate header

- Replace __get_free_page() with kmalloc() in few sources

- Introduce an infrastructure for more efficient this_cpu operations.
  Eliminate conditional branches when PREEMPT_NONE is removed

- Enable Rust support

- Use z10 as minimum architecture level, similar to the boot code,
  to enforce a defined architecture level set

- Improve and convert various mem*() helper functions to C. For that
  add .noinstr.text section to avoid orphaned warnings from the linker

- Fix the function pointer type in __ret_from_fork() to correct
  the indirect call to match kernel thread return type of int

- Revert support for DCACHE_WORD_ACCESS to avoid an endless exception
  loop on read from donated Ultravisor pages at unaligned addresses

----------------------------------------------------------------
Alexander Gordeev (2):
      s390/mm: Make PTC and UV call order consistent
      Merge branch 'rust-for-s390' into features

Harald Freudenberger (3):
      s390/ap: Implement SE bind and associate uevents
      s390/ap/zcrypt: Rearrange fields within AP and zcrypt structs
      s390/ap: Fix locking issue in SE bind and associate sysfs functions

Heiko Carstens (30):
      s390/mm: Map empty zero pages read-only
      s390/barrier: Use alternative instead of ifdef for bcr_serialize()
      s390/processor: Remove duplicated cpu_relax() define
      s390/processor: Implement cpu_relax() with cpu serialization
      s390/appldata: Remove unused appldata_sysctl_header variable
      s390/debug: Remove s390dbf_sysctl_header variable
      s390/sclp: Remove unused sclp_vt220_buffered_chars variable
      s390/zcore: Removed unused variables
      s390/zcore: Use octal permission
      s390/string: Remove strlcat() implementation
      s390/fpu: Shorten GR_NUM / VX_NUM macros
      s390/fpu: Move GR_NUM / VX_NUM macros to separate header file
      s390/percpu: Infrastructure for more efficient this_cpu operations
      s390/percpu: Add missing do { } while (0) constructs
      s390/percpu: Use new percpu code section for arch_this_cpu_add()
      s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
      s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
      s390/percpu: Provide arch_this_cpu_read() implementation
      s390/percpu: Provide arch_this_cpu_write() implementation
      s390/purgatory: Enforce z10 minimum architecture level
      s390: Add .noinstr.text to boot and purgatory linker scripts
      s390/string: Add -ffreestanding compile option to string.o
      s390/string: Convert memmove() to C
      s390/string: Convert memset() to C
      s390/string: Convert memcpy() to C
      s390/string: Convert memset(16|32|64)() to C
      s390/memmove: Optimize backward copy case
      s390/tishift: Convert __ashlti3(), __ashrti3(), __lshrti3() to C
      s390/process: Fix kernel thread function pointer type
      s390: Revert support for DCACHE_WORD_ACCESS

Jan Polensky (6):
      s390/bug: Provide ARCH_WARN_ASM for Rust WARN/BUG support
      s390/jump_label: Implement ARCH_STATIC_BRANCH_JUMP_ASM and ARCH_STATIC_BRANCH_ASM macros
      rust/bindgen_parameters: Mark s390 types as opaque to prevent repr conflicts
      rust: helpers: Add memchr wrapper for string operations
      s390/cmpxchg: Fix KASAN stack-out-of-bounds in atomic helpers
      s390: Enable Rust support

Julian Braha (1):
      s390/Kconfig: Cleanup defaults for selftests

Maninder Singh (1):
      s390: Remove extra check of task_stack_page()

Mike Rapoport (Microsoft) (6):
      s390/con3270: Replace __get_free_page() with kmalloc()
      s390/dasd: Replace get_zeroed_page() with kzalloc()
      s390/hvc_iucv: Replace get_zeroed_page() with kzalloc()
      s390/qeth: Replace get_zeroed_page() with kzalloc()
      s390/trng: Replace __get_free_page() with kmalloc()
      s390/zcrypt: Replace get_zeroed_page() with kzalloc()

Niklas Schnelle (1):
      s390/sclp: Allow user-space to provide PCI reports for NVMe SMART data

Peter Oberparleiter (1):
      s390/debug: Add s390dbf kernel parameter

Sven Schnelle (1):
      s390/tracing: Add s390-tod clock

Vineeth Vijayan (1):
      s390/cio: Purge based on the cdev's online status

 Documentation/arch/s390/s390dbf.rst     |  30 ++++
 Documentation/rust/arch-support.rst     |   1 +
 Documentation/trace/ftrace.rst          |   4 +
 arch/s390/Kconfig                       |  11 +-
 arch/s390/Makefile                      |  28 ++--
 arch/s390/appldata/appldata_base.c      |   3 +-
 arch/s390/boot/Makefile                 |   7 +-
 arch/s390/boot/mem.S                    |   2 -
 arch/s390/boot/string.c                 |   6 +-
 arch/s390/boot/vmlinux.lds.S            |   1 +
 arch/s390/include/asm/asm-extable.h     |   4 -
 arch/s390/include/asm/asm-prototypes.h  |   4 -
 arch/s390/include/asm/barrier.h         |  12 +-
 arch/s390/include/asm/bug.h             |  12 ++
 arch/s390/include/asm/cmpxchg.h         |   8 +-
 arch/s390/include/asm/debug.h           |   1 +
 arch/s390/include/asm/entry-percpu.h    |  80 +++++++++++
 arch/s390/include/asm/fpu-insn-asm.h    | 176 +----------------------
 arch/s390/include/asm/fpu-insn.h        |   1 +
 arch/s390/include/asm/insn-common-asm.h |  53 +++++++
 arch/s390/include/asm/jump_label.h      |  33 +++--
 arch/s390/include/asm/lowcore.h         |   3 +-
 arch/s390/include/asm/percpu.h          | 246 +++++++++++++++++++++++++++-----
 arch/s390/include/asm/pgtable.h         |  39 +++--
 arch/s390/include/asm/processor.h       |   3 +-
 arch/s390/include/asm/ptrace.h          |   2 +
 arch/s390/include/asm/sclp.h            |   1 +
 arch/s390/include/asm/string.h          |   2 -
 arch/s390/include/asm/trace_clock.h     |  13 ++
 arch/s390/include/asm/vdso/processor.h  |   4 +-
 arch/s390/include/asm/word-at-a-time.h  |  22 ---
 arch/s390/kernel/Makefile               |   1 +
 arch/s390/kernel/debug.c                | 129 ++++++++++++++---
 arch/s390/kernel/irq.c                  |  24 +++-
 arch/s390/kernel/nmi.c                  |   5 +
 arch/s390/kernel/process.c              |   5 +-
 arch/s390/kernel/trace_clock.c          |  12 ++
 arch/s390/kernel/traps.c                |   5 +
 arch/s390/kernel/vmlinux.lds.S          |   7 +
 arch/s390/lib/Makefile                  |   6 +-
 arch/s390/lib/mem.S                     | 192 -------------------------
 arch/s390/lib/string.c                  | 236 ++++++++++++++++++++++++++----
 arch/s390/lib/tishift.S                 |  63 --------
 arch/s390/lib/tishift.c                 |  64 +++++++++
 arch/s390/lib/tishift.h                 |   9 ++
 arch/s390/mm/extable.c                  |  18 ---
 arch/s390/mm/init.c                     |   2 +
 arch/s390/purgatory/Makefile            |   9 +-
 arch/s390/purgatory/purgatory.lds.S     |   1 +
 drivers/char/hw_random/s390-trng.c      |   5 +-
 drivers/s390/block/dasd_eckd.c          |   8 +-
 drivers/s390/block/dasd_eer.c           |   4 +-
 drivers/s390/char/con3270.c             |   8 +-
 drivers/s390/char/sclp_pci.c            |   1 +
 drivers/s390/char/sclp_vt220.c          |   4 -
 drivers/s390/char/zcore.c               |   8 +-
 drivers/s390/cio/device.c               |   2 +-
 drivers/s390/crypto/ap_bus.c            |  17 +++
 drivers/s390/crypto/ap_bus.h            |  23 +--
 drivers/s390/crypto/ap_queue.c          |  42 +++---
 drivers/s390/crypto/zcrypt_api.c        |   6 +-
 drivers/s390/crypto/zcrypt_api.h        |  15 +-
 drivers/s390/crypto/zcrypt_ccamisc.h    |  22 +--
 drivers/s390/crypto/zcrypt_ep11misc.h   |  10 +-
 drivers/s390/net/qeth_core_main.c       |   8 +-
 drivers/tty/hvc/hvc_iucv.c              |   6 +-
 rust/Makefile                           |   3 +
 rust/bindgen_parameters                 |   7 +
 rust/helpers/helpers.c                  |   1 +
 rust/helpers/string.c                   |   8 ++
 scripts/generate_rust_target.rs         |   2 +
 scripts/min-tool-version.sh             |   6 +-
 72 files changed, 1074 insertions(+), 742 deletions(-)
 delete mode 100644 arch/s390/boot/mem.S
 create mode 100644 arch/s390/include/asm/entry-percpu.h
 create mode 100644 arch/s390/include/asm/insn-common-asm.h
 create mode 100644 arch/s390/include/asm/trace_clock.h
 create mode 100644 arch/s390/kernel/trace_clock.c
 delete mode 100644 arch/s390/lib/mem.S
 delete mode 100644 arch/s390/lib/tishift.S
 create mode 100644 arch/s390/lib/tishift.c
 create mode 100644 arch/s390/lib/tishift.h
 create mode 100644 rust/helpers/string.c
