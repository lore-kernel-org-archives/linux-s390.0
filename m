Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A2149DFD;
	Thu, 13 Jun 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293214; cv=none; b=NWfGk6y7Rqh62ZhjTxt/cGWtYBoTqzR/zjcONlgcH1g+hrq3WkQUwLj+scNpqEszFiaPmNC6r6Ai6SOLPyQ4YSQ0ddIggSHaP6TfFL9+ZWs2hePMt5Xgg8ByFZUEnhcoasFr/R8v/ExLpEi5FlDXDcFdunUZ5a/qnfCigHUUdjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293214; c=relaxed/simple;
	bh=hd8sbg8tGqz1COtgGdWuFQfBNCggANb8Dl36KHM1HXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aG0VFZtZmmx6slk8JcCLHilZaixTlT+XzYMhXl8Qbnly2CdyDszFL5fZMooJ7oKhlL8KeCXxoUKZ0QOnJiicSis2qoUqATmvaAPPTgMLwFSmuOvU2OvUJJ3qMmTgpXBhHOsYvESqmeHpOT4mUs81YRgOQmSWKreb5/M6S4EdoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H2sbdGrW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H2sbdGrW"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DFPivk001998;
	Thu, 13 Jun 2024 15:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=gbdYbORHBggEAMihYZ79uciBWOZ8cFup1GK6fqg
	EVTE=; b=H2sbdGrWufioShsVoXmKMKYBAxxY9MI+Uy9Y9negvRX9423bbSSeoXX
	VrnDB2ZSboL4Uem8EVlfbvPpnCJmA5YTljvv5QWeJ/wJNh1iVzi+Pmd8H4521hKk
	ws2ygfpQYTCle6273BJnNQdm9uDfXc7ieU5HCdXyI/0a9qs3wus/Xqi8YJrk+rQW
	DPcYd8II1QV7rafacfFFSDViulA+9BoWpTXSCkF2gABfSRr07/QDirP15hJlUXxD
	NhjCAp1iyiphMnBYiqEUMH8FTA2LaE9IifuP3ETMGdjTgLujjMR2k8Cthrm29TYz
	G6eOcJrDCV6BYJ6e1DdBqa10A/o8zGw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqq4rt36b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:40 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DFddrD026714;
	Thu, 13 Jun 2024 15:39:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqq4rt365-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DELP7M008731;
	Thu, 13 Jun 2024 15:39:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn4b3rk01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DFdX3C33292934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:39:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E24412006A;
	Thu, 13 Jun 2024 15:39:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60CDD20065;
	Thu, 13 Jun 2024 15:39:32 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 15:39:32 +0000 (GMT)
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
Subject: [PATCH v4 00/35] kmsan: Enable on s390
Date: Thu, 13 Jun 2024 17:34:02 +0200
Message-ID: <20240613153924.961511-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qnmHc0KAbWUlA4xk_JpMbkaaf2iKvy9B
X-Proofpoint-GUID: yJiNbIz8eZt6EvVuayS5N8D-uKmwJYPf
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
 definitions=2024-06-13_08,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130109

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

Ilya Leoshkevich (35):
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
  kmsan: Support SLAB_POISON
  kmsan: Use ALIGN_DOWN() in kmsan_get_metadata()
  kmsan: Do not round up pg_data_t size
  mm: slub: Let KMSAN access metadata
  mm: slub: Unpoison the memchr_inv() return value
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
  s390/string: Add KMSAN support
  s390/traps: Unpoison the kernel_stack_overflow()'s pt_regs
  s390/uaccess: Add KMSAN support to put_user() and get_user()
  s390/unwind: Disable KMSAN checks
  s390: Implement the architecture-specific KMSAN functions
  kmsan: Enable on s390

 Documentation/dev-tools/kmsan.rst   |   4 +-
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
 arch/s390/include/asm/kmsan.h       |  43 +++++++++++
 arch/s390/include/asm/pgtable.h     |   8 ++
 arch/s390/include/asm/string.h      |  20 +++--
 arch/s390/include/asm/thread_info.h |   2 +-
 arch/s390/include/asm/uaccess.h     | 111 ++++++++++++++++++++--------
 arch/s390/kernel/diag.c             |  10 ++-
 arch/s390/kernel/ftrace.c           |   2 +
 arch/s390/kernel/traps.c            |   6 ++
 arch/s390/kernel/unwind_bc.c        |   4 +
 drivers/s390/char/sclp.c            |   2 +-
 include/linux/kmsan.h               |  33 +++++++++
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
 mm/kmsan/kmsan.h                    |   9 +--
 mm/kmsan/kmsan_test.c               |   5 ++
 mm/kmsan/report.c                   |   8 +-
 mm/kmsan/shadow.c                   |   9 +--
 mm/slub.c                           |  17 ++++-
 tools/objtool/check.c               |   2 +
 38 files changed, 361 insertions(+), 83 deletions(-)
 create mode 100644 arch/s390/boot/kmsan.c
 create mode 100644 arch/s390/include/asm/kmsan.h

-- 
2.45.1

