Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98B9394;
	Fri, 21 Jun 2024 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929619; cv=none; b=qTP6SZ3a49qXgYyZDFjLkgAZ93ViFC3A2ont1a2kUboJnThYDHRHgIBEUBFYai0MrDm3Hq3UxJTi4dG8fXSf4mUewDIpzc0jA9RPEUtVNoO2B7fyQ/amd5beoOt9Sj9r8X2LVFBeW8rEODuHnNjlIkR8KIDUjHDxMxlAHCe9HsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929619; c=relaxed/simple;
	bh=PaxLGI0rkqcDvcLlN0DCJfATWbJnAvAWy2pPCyB4CJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhzi1TFwmNxNjqSMI2xQ97izTUtso8jfoEcQuJVnRy2yyqPDt+7DTvMZEaoWg4j5q6G0L9AOggatWw/pc3PMIaLGqNJuPuCzP29fFLMgYrP7ZudPEGuhJjagTsD7kAQs1QDrUAvtkB1hqfobZt/NbvpstTY0DGb6BO7fAf6rGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pJ6slaBz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pJ6slaBz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L0OAQK018979;
	Fri, 21 Jun 2024 00:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=f+9pzbH54LbTBRr6pc8icwWBlweOhXihEdfbWvp
	llXU=; b=pJ6slaBzwQWLI8I8e8MQ7baDBBZTYHUCxk8TQIcBgLnB5uoZpGVSdMq
	KpMWVy8ht6phExbd3U0/cnrOjpHOlpkIR/g3uFUPsIoj5ygJapqGIvsa4hBxw7yb
	KDoPOGnzmZFMjoY6OVE1AmyvHQ5sSRw+19IzEoPGzzB5ZdDYdmy8rk4DkixjRRdP
	AfyEcencnC28nt1cRXLAnOc19kLSSW5o4/oiKRiWEU6dsJZnSBmOhU0rw5gm2h3L
	+qadIsBVf+gtYUxvJP2BGXNFb07cR0mb8LymYm8xw57E79kKBoRWuS5svyPdO/es
	Fc0PRNztAJ5EQCh5oBgVMqJrleFGg/Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c06ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:27 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0QQwa022515;
	Fri, 21 Jun 2024 00:26:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c06y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0LbS4025654;
	Fri, 21 Jun 2024 00:26:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrqv2nk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0QKTE48562568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 005352004B;
	Fri, 21 Jun 2024 00:26:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C01BB20043;
	Fri, 21 Jun 2024 00:26:18 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:18 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v6 00/39] kmsan: Enable on s390
Date: Fri, 21 Jun 2024 02:24:34 +0200
Message-ID: <20240621002616.40684-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NGnA0wB8e_HKang9Cd7fUkLp0kysg8ni
X-Proofpoint-GUID: vHoH39FNKmVCDU_CEqJaR3sUi3DJzSJe
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

v5: https://lore.kernel.org/lkml/20240619154530.163232-1-iii@linux.ibm.com/
v5 -> v6: Include KMSAN vmalloc metadata areas in page table dump.
          Fix doc comments; use KMSAN_WARN_ON (Alexander P.).
          Patches that need review:
          - [PATCH 16/39] kmsan: Expose KMSAN_WARN_ON()
          - [PATCH 32/39] s390/ptdump: Add KMSAN page markers

v4: https://lore.kernel.org/lkml/20240613153924.961511-1-iii@linux.ibm.com/
v4 -> v5: Fix the __memset() build issue.
          Change the attribute #defines to lowercase in order to match
          the existing code style.
          Fix the kmsan_virt_addr_valid() implementation to avoid
          recursion in debug builds, like it's done on x86_64 - dropped
          R-bs, please take another look.
          Add kmsan_disable_current()/kmsan_enable_current() doc;
          Fix the poisoned memchr_inv() value in a different way;
          Add the missing linux/instrumented.h #include;
          (Alexander P.).
          Patches that need review:
          - [PATCH 12/37] kmsan: Introduce memset_no_sanitize_memory()
          - [PATCH 13/37] kmsan: Support SLAB_POISON
          - [PATCH 17/37] mm: slub: Disable KMSAN when checking the padding bytes
          - [PATCH 36/37] s390/kmsan: Implement the architecture-specific functions

v3: https://lore.kernel.org/lkml/20231213233605.661251-1-iii@linux.ibm.com/
v3 -> v4: Rebase.
          Elaborate why ftrace_ops_list_func() change is needed on
          x64_64 (Steven).
          Add a comment to the DFLTCC patch (Alexander P.).
          Simplify diag224();
          Improve __arch_local_irq_attributes style;
          Use IS_ENABLED(CONFIG_KMSAN) for vmalloc area (Heiko).
          Align vmalloc area on _SEGMENT_SIZE (Alexander G.).

v2: https://lore.kernel.org/lkml/20231121220155.1217090-1-iii@linux.ibm.com/
v2 -> v3: Drop kmsan_memmove_metadata() and strlcpy() patches;
          Remove kmsan_get_metadata() stub;
          Move kmsan_enable_current() and kmsan_disable_current() to
          include/linux/kmsan.h, explain why a counter is needed;
          Drop the memset_no_sanitize_memory() patch;
          Use __memset() in the SLAB_POISON patch;
          Add kmsan-checks.h to the DFLTCC patch;
          Add recursion check to the arch_kmsan_get_meta_or_null()
          patch (Alexander P.).

          Fix inline + __no_kmsan_checks issues.
          New patch for s390/irqflags, that resolves a lockdep warning.
          New patch for s390/diag, that resolves a false positive when
          running on an LPAR.
          New patch for STCCTM, same as above.
          New patch for check_bytes_and_report() that resolves a false
          positive that occurs even on Intel.

v1: https://lore.kernel.org/lkml/20231115203401.2495875-1-iii@linux.ibm.com/
v1 -> v2: Add comments, sort #includes, introduce
          memset_no_sanitize_memory() and use it to avoid unpoisoning
          of redzones, change vmalloc alignment to _REGION3_SIZE, add
          R-bs (Alexander P.).

          Fix building
          [PATCH 28/33] s390/string: Add KMSAN support
          with FORTIFY_SOURCE.
          Reported-by: kernel test robot <lkp@intel.com>
          Closes: https://lore.kernel.org/oe-kbuild-all/202311170550.bSBo44ix-lkp@intel.com/

Hi,

This series provides the minimal support for Kernel Memory Sanitizer on
s390. Kernel Memory Sanitizer is clang-only instrumentation for finding
accesses to uninitialized memory. The clang support for s390 has already
been merged [1].

With this series, I can successfully boot s390 defconfig and
debug_defconfig with kmsan.panic=1. The tool found one real
s390-specific bug (fixed in master).

Best regards,
Ilya

[1] https://reviews.llvm.org/D148596

Ilya Leoshkevich (39):
  ftrace: Unpoison ftrace_regs in ftrace_ops_list_func()
  kmsan: Make the tests compatible with kmsan.panic=1
  kmsan: Disable KMSAN when DEFERRED_STRUCT_PAGE_INIT is enabled
  kmsan: Increase the maximum store size to 4096
  kmsan: Fix is_bad_asm_addr() on arches with overlapping address spaces
  kmsan: Fix kmsan_copy_to_user() on arches with overlapping address
    spaces
  kmsan: Remove a useless assignment from
    kmsan_vmap_pages_range_noflush()
  kmsan: Remove an x86-specific #include from kmsan.h
  kmsan: Expose kmsan_get_metadata()
  kmsan: Export panic_on_kmsan
  kmsan: Allow disabling KMSAN checks for the current task
  kmsan: Introduce memset_no_sanitize_memory()
  kmsan: Support SLAB_POISON
  kmsan: Use ALIGN_DOWN() in kmsan_get_metadata()
  kmsan: Do not round up pg_data_t size
  kmsan: Expose KMSAN_WARN_ON()
  mm: slub: Let KMSAN access metadata
  mm: slub: Disable KMSAN when checking the padding bytes
  mm: kfence: Disable KMSAN when checking the canary
  lib/zlib: Unpoison DFLTCC output buffers
  kmsan: Accept ranges starting with 0 on s390
  s390/boot: Turn off KMSAN
  s390: Use a larger stack for KMSAN
  s390/boot: Add the KMSAN runtime stub
  s390/checksum: Add a KMSAN check
  s390/cpacf: Unpoison the results of cpacf_trng()
  s390/cpumf: Unpoison STCCTM output buffer
  s390/diag: Unpoison diag224() output buffer
  s390/ftrace: Unpoison ftrace_regs in kprobe_ftrace_handler()
  s390/irqflags: Do not instrument arch_local_irq_*() with KMSAN
  s390/mm: Define KMSAN metadata for vmalloc and modules
  s390/ptdump: Add KMSAN page markers
  s390/string: Add KMSAN support
  s390/traps: Unpoison the kernel_stack_overflow()'s pt_regs
  s390/uaccess: Add KMSAN support to put_user() and get_user()
  s390/uaccess: Add the missing linux/instrumented.h #include
  s390/unwind: Disable KMSAN checks
  s390/kmsan: Implement the architecture-specific functions
  kmsan: Enable on s390

 Documentation/dev-tools/kmsan.rst   |  11 ++-
 arch/s390/Kconfig                   |   1 +
 arch/s390/Makefile                  |   2 +-
 arch/s390/boot/Makefile             |   3 +
 arch/s390/boot/kmsan.c              |   6 ++
 arch/s390/boot/startup.c            |   7 ++
 arch/s390/boot/string.c             |  16 ++++
 arch/s390/include/asm/checksum.h    |   2 +
 arch/s390/include/asm/cpacf.h       |   3 +
 arch/s390/include/asm/cpu_mf.h      |   6 ++
 arch/s390/include/asm/irqflags.h    |  17 ++++-
 arch/s390/include/asm/kmsan.h       |  59 +++++++++++++++
 arch/s390/include/asm/pgtable.h     |  12 +++
 arch/s390/include/asm/string.h      |  20 +++--
 arch/s390/include/asm/thread_info.h |   2 +-
 arch/s390/include/asm/uaccess.h     | 112 ++++++++++++++++++++--------
 arch/s390/kernel/diag.c             |  10 ++-
 arch/s390/kernel/ftrace.c           |   2 +
 arch/s390/kernel/traps.c            |   6 ++
 arch/s390/kernel/unwind_bc.c        |   4 +
 arch/s390/mm/dump_pagetables.c      |  30 ++++++++
 drivers/s390/char/sclp.c            |   2 +-
 include/linux/kmsan.h               |  76 +++++++++++++++++++
 include/linux/kmsan_types.h         |   2 +-
 kernel/trace/ftrace.c               |   1 +
 lib/zlib_dfltcc/dfltcc.h            |   1 +
 lib/zlib_dfltcc/dfltcc_util.h       |  28 +++++++
 mm/Kconfig                          |   1 +
 mm/kfence/core.c                    |  11 ++-
 mm/kmsan/core.c                     |   1 -
 mm/kmsan/hooks.c                    |  23 ++++--
 mm/kmsan/init.c                     |   7 +-
 mm/kmsan/instrumentation.c          |  11 +--
 mm/kmsan/kmsan.h                    |  33 ++------
 mm/kmsan/kmsan_test.c               |   5 ++
 mm/kmsan/report.c                   |   8 +-
 mm/kmsan/shadow.c                   |   9 +--
 mm/slub.c                           |  33 ++++++--
 tools/objtool/check.c               |   2 +
 39 files changed, 475 insertions(+), 110 deletions(-)
 create mode 100644 arch/s390/boot/kmsan.c
 create mode 100644 arch/s390/include/asm/kmsan.h

-- 
2.45.1

