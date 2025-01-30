Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B4819;
	Thu, 30 Jan 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738243221; cv=none; b=kdMleavvUbld5ZxyxDan0EJGkr9iPf9vPi0Tq7R71HuZYvHlvTlGfGAItDAdTqNfLTjK+4xQFp5e6OYhtJY8XOhMOTkSQfA5A9BIJztaBwi6WzSOe342IHU+3YqfnWiX25HnS4GzvUR45d6r9HoggA9uvnJMIzmW5dQbh07CdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738243221; c=relaxed/simple;
	bh=7HEtd7Hsh4XGI6RYgB1QyLj5EIAhnBZjH/8lqqfyJeU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nntyIFzEv8OUcP1phGi4s9K6ittW0fq072V22RwhWYcNhWk9KPOZGrOWv8LSm+A+frPwpvr9zoMhZ0ay2stWH2WQMSoB0Oef1+EO9X04IS+cjw84Ev4fbOlpypEjRXzzcn0ChqzJtyMEK5BiGso528BlREG92pLdsDc4iHs0wBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rypqSQZH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rypqSQZH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U19J22031993;
	Thu, 30 Jan 2025 13:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=C1FjtkOsdzXrzFmPutO4QqgAUQIZbLSTewr09JEksPQ=; b=rypqSQZH
	3zCRg5Srje2I2HJd+dxSuM4xrCGX5dK7YqWOVuPg/fi130w1gVsE8I5KZ15FyyZ0
	YxziHlRpyXYpWYIqW7RyEKOd11qPRxBnwrBi+889onN9Sl3urZlMFiaGb+umrcBz
	O/UxsariGJwvTtMYrl8XNfLAazj+K5pwOxgN3G8Cy+/RU0+OPYOL6U0BE67ec2s1
	ctmSFdG9uP6CNCUEckUTlQUrOJdvFNRh+9nY5RUoFNXHraq0CmAb7i+dICvvyKVR
	jTiaDxa/p1n4gvBrihC9lv96B5ylVE6P7cW5F7Dlx7OxZDAB9h+xS1ag2EAkgyuL
	B1MhgtwIvyYXtA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fyg9aw3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 13:20:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50UCUR6I028093;
	Thu, 30 Jan 2025 13:20:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbskp7h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 13:20:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UDKDAV54198674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 13:20:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0194F200FC;
	Thu, 30 Jan 2025 13:20:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D09CB200FB;
	Thu, 30 Jan 2025 13:20:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jan 2025 13:20:12 +0000 (GMT)
Date: Thu, 30 Jan 2025 14:20:11 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 6.14 merge window
Message-ID: <Z5t8i_dUC6KbOO8P@tuxmaker.boeblingen.de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tkVDMRMlpCW-DwYgvlAX8Qx2HzQJYurP
X-Proofpoint-GUID: tkVDMRMlpCW-DwYgvlAX8Qx2HzQJYurP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501300101

Hi Linus,

please pull more s390 updates for the 6.14 merge window.

There is a trivial conflict that was resolved in linux-next [1] in:

  arch/s390/Kconfig

between commit:

  008071917dfc ("s390/crc32: expose CRC32 functions through lib")

from your tree and commit:

  3bcc8a1af581 ("s390/sclp: Initialize sclp subsystem via arch_cpu_finalize=
_init()")

from the s390 tree:

diff --cc arch/s390/Kconfig
index 6e9545d8b0c7,f49ca2b485f6..000000000000
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@@ -72,7 -78,7 +78,8 @@@ config S39
  	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
  	select ARCH_ENABLE_MEMORY_HOTREMOVE
  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
+ 	select ARCH_HAS_CPU_FINALIZE_INIT
 +	select ARCH_HAS_CRC32
  	select ARCH_HAS_CURRENT_STACK_POINTER
  	select ARCH_HAS_DEBUG_VIRTUAL
  	select ARCH_HAS_DEBUG_VM_PGTABLE


1. https://lore.kernel.org/linux-next/20250129115932.7950d88d@canb.auug.org.au/

Thanks,
Alexander

The following changes since commit 26701574cee6777f867f89b4a5c667817e1ee0dd:

  s390/futex: Fix FUTEX_OP_ANDN implementation (2025-01-15 17:12:31 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.14-2

for you to fetch changes up to 87f017d0792befa83722b99cb21f9c8f574cd71d:

  s390/vmlogrdr: Use array instead of string initializer (2025-01-29 13:44:21 +0100)

----------------------------------------------------------------
more s390 updates for 6.14 merge window

- The rework that uncoupled physical and virtual address spaces
  inadvertently prevented KASAN shadow mappings from using large
  pages. Restore large page mappings for KASAN shadows

- Add decompressor routine physmem_alloc() that may fail,
  unlike physmem_alloc_or_die(). This allows callers to
  implement fallback paths

- Allow falling back from large pages to smaller pages (1MB or
  4KB) if the allocation of 2GB pages in the decompressor can
  not be fulfilled

- Add to the decompressor boot print support of "%%" format
  string, width and padding hadnling, length modifiers and
  decimal conversion specifiers

- Add to the decompressor message severity levels similar to
  kernel ones. Support command-line options that control
  console output verbosity

- Replaces boot_printk() calls with appropriate loglevel-
  specific helpers such as boot_emerg(), boot_warn(), and
  boot_debug().

- Collect all boot messages into a ring buffer independent
  of the current log level. This is particularly useful for
  early crash analysis

- If 'earlyprintk' command line parameter is not specified, store
  decompressor boot messages in a ring buffer to be printed later
  by the kernel, once the console driver is registered

- Add 'bootdebug' command line parameter to enable printing of
  decompressor debug messages when needed. That parameters allows
  message supressing and filtering

- Dump boot messages on a decompressor crash, but only if
  'bootdebug' command line parameter is enabled

- When CONFIG_PRINTK_TIME is enabled, add timestamps to boot
  messages in the same format as regular printk()

- Dump physical memory tracking information on boot:
  online ranges, reserved areas and vmem allocations

- Dump virtual memory layout and randomization details

- Improve decompression error reporting and dump the message
  ring buffer in case the boot failed and system halted

- Add an exception handler which handles exceptions when FPU
  control register is attempted to be set to an invalid value.
  Remove '.fixup' section as result of this change

- Use 'A', 'O', and 'R' inline assembly format flags, which
  allows recent Clang compilers to generate better FPU code

- Rework uaccess code so it reads better and generates more
  efficient code

- Cleanup futex inline assembly code

- Disable KMSAN instrumention for futex inline assemblies, which
  contain dereferenced user pointers. Otherwise, shadows for the
  user pointers would be accessed

- PFs which are not initially configured but in standby create
  only a single-function PCI domain. If they are configured later
  on, sibling PFs and their child VFs will not be added to their
  PCI domain breaking SR-IOV expectations. Fix that by allowing
  initially configured but in standby PFs create multi-function
  PCI domains

- Add '-std=gnu11' to decompressor and purgatory CFLAGS to avoid
  compile errors caused by kernel's own definitions of 'bool',
  'false', and 'true' conflicting with the C23 reserved keywords

- Fix sclp subsystem failure when a sclp console is not present

- Fix misuse of non-NULL terminated strings in vmlogrdr driver

- Various other small improvements, cleanups and fixes

----------------------------------------------------------------
Heiko Carstens (24):
      s390/fpu: Add fpc exception handler / remove fixup section again
      s390/extable: Replace open-coded sfpc inline assembly with fpu_sfpc()
      s390: Rename GCC_ASM_FLAG_OUTPUT_BROKEN to CC_ASM_FLAG_OUTPUT_BROKEN
      s390: Introduce CC_HAS_ASM_AOR_FORMAT_FLAGS Kconfig option
      s390/fpu: Use CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS instead of CONFIG_CC_IS_CLANG
      s390/extable: Rename EX_TABLE_UA_STORE to EX_TABLE_UA_FAULT
      s390/uaccess: Implement __get_kernel_nofault()/__put_kernel_nofault() with mvc
      s390/uaccess: Use asm goto for __mvc_kernel_nofault()
      s390/uaccess: Move put_user() / __put_user() close to put_user() asm code
      s390/uaccess: Remove __put_user_fn()/__get_user_fn() wrappers
      s390/uaccess: Cleanup noinstr __put_user()/__get_user() inline assembly constraints
      s390/uaccess: Replace EX_TABLE_UA_LOAD_MEM exception handling
      s390/uaccess: Remove usage of the oac specifier
      s390/uaccess: Use asm goto for put_user()/get_user()
      s390/uaccess: Remove INLINE_COPY_FROM_USER and INLINE_COPY_TO_USER
      s390/futex: Generate futex atomic op functions
      s390/futex: Cleanup futex_atomic_cmpxchg_inatomic()
      s390/uaccess: Rename get_put_user_noinstr_attributes to uaccess_kmsan_or_inline
      s390/futex: Avoid KMSAN instrumention for user pointers
      s390/bitops: Use correct constraint for arch_test_bit() inline assembly
      s390/tools: Use array instead of string initializer
      s390/sclp: Initialize sclp subsystem via arch_cpu_finalize_init()
      s390/vmlogrdr: Use internal_name for error messages
      s390/vmlogrdr: Use array instead of string initializer

Nathan Chancellor (1):
      s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS

Niklas Schnelle (1):
      s390/pci: Fix SR-IOV for PFs initially in standby

Vasily Gorbik (27):
      s390/mm: Allow large pages for KASAN shadow mapping
      s390/boot: Rename physmem_alloc_top_down() to physmem_alloc_or_die()
      s390/boot: Add physmem_alloc()
      s390/boot: Allow KASAN mapping to fallback to small pages
      s390/boot: Add %% support to boot_printk()
      s390/boot: Add length modifiers to boot_printk()
      s390/boot: Add field width and padding handling to boot_printk()
      s390/boot: Add decimal conversion specifiers to boot_printk()
      s390/boot: Add support for boot messages loglevels
      s390/boot: Replace boot_printk() with loglevel-specific helpers
      s390/boot: Use decimal format specifiers in boot messages
      s390/boot: Introduce ring buffer for boot messages
      s390/boot: Make boot_printk() return int
      s390/boot: Defer boot messages when earlyprintk is not enabled
      s390/boot: Add bootdebug option to control debug messages
      s390/boot: Add prefix filtering to bootdebug messages
      s390/boot: Dump message ring buffer on crash with bootdebug
      s390/boot: Add timestamps to early boot messages
      s390: Use pr_info for "KernelAddressSanitizer initialized" message
      s390/boot: Add physmem tracking debug support
      s390/boot: Move command line parsing earlier
      s390/boot: Add vmem debugging support
      s390/boot: Add startup debugging support
      s390/boot: Improve decompression error reporting
      s390: Optimize __pa/__va when RANDOMIZE_IDENTITY_BASE is off
      s390/ipl_report: Remove unused 'size' variable
      s390/vmem: Fix null-pointer-arithmetic warning in vmem_map_init()

 arch/s390/Kconfig                    |   9 +-
 arch/s390/Makefile                   |   2 +-
 arch/s390/boot/als.c                 |  10 +-
 arch/s390/boot/boot.h                |  26 +-
 arch/s390/boot/decompressor.c        |  12 +-
 arch/s390/boot/ipl_parm.c            |  20 +-
 arch/s390/boot/ipl_report.c          |   3 +-
 arch/s390/boot/kaslr.c               |   4 +-
 arch/s390/boot/pgm_check_info.c      |  53 ++--
 arch/s390/boot/physmem_info.c        | 103 +++++--
 arch/s390/boot/printk.c              | 224 ++++++++++++--
 arch/s390/boot/startup.c             |  47 ++-
 arch/s390/boot/vmem.c                | 135 +++++++--
 arch/s390/include/asm/asm-extable.h  |  14 +-
 arch/s390/include/asm/asm.h          |   2 +-
 arch/s390/include/asm/bitops.h       |   2 +-
 arch/s390/include/asm/boot_data.h    |  51 ++++
 arch/s390/include/asm/fpu-insn.h     | 199 ++++++-------
 arch/s390/include/asm/futex.h        | 107 ++++---
 arch/s390/include/asm/page.h         |   4 +
 arch/s390/include/asm/physmem_info.h |   4 +-
 arch/s390/include/asm/sclp.h         |   1 +
 arch/s390/include/asm/uaccess.h      | 562 +++++++++++++++++++----------------
 arch/s390/kernel/early.c             |   3 +-
 arch/s390/kernel/setup.c             |  37 ++-
 arch/s390/kernel/vmlinux.lds.S       |   1 -
 arch/s390/lib/uaccess.c              |  90 ------
 arch/s390/mm/extable.c               |  30 +-
 arch/s390/mm/vmem.c                  |   2 +-
 arch/s390/pci/pci_bus.c              |   1 -
 arch/s390/purgatory/Makefile         |   2 +-
 arch/s390/tools/gen_opcode_table.c   |  27 +-
 drivers/s390/char/sclp.c             |  12 +-
 drivers/s390/char/vmlogrdr.c         |   8 +-
 34 files changed, 1124 insertions(+), 683 deletions(-)
