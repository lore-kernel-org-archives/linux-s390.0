Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B087D39FD9
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767776; cv=none; b=tn1/kEyOek0iKkX27N4U2KvOYZ/bI0h+f0Bm+LA4EsZ17u5Tml9gOYehUlVN6OElek+nUGtvWpV7uXZeu7ctSAtuIsK9sxYGcJw86yS3huiDHLboPC+2RoH64TZiHkDHR77sc7Tc/UPQaWtLdC/TIaF7jr+x2ODKyRAwHEAh2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767776; c=relaxed/simple;
	bh=gjSiK8CTGyxUV4ue2SLELJVXUbKrLqDBdkQPHJ0QUsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PCfvbnZmV+MNwzhNoMhYJ8paC9IskO81qiViCntlhEp9DNtyEafmjfBxeAPkEgo3Z9wctsnAJdxggKvctOUt1XmD6MfguPzAb4ONOxBfIMcVN40kEXoG0j12WrJHQoaCB2zbFza1G87glWRMxGvc5ovI9UUUQFNDfc2seeJHgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pbFs+D4g; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbFs+D4g"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ef37c3f773so1269624eec.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767773; x=1778372573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=updh4+8aajDrOCKk474Il/JqAI8pe3IBOIC1ocTfFvc=;
        b=pbFs+D4g2OVKwnk4HPjWPT36fxHSrlY351m1NGtIR8SA919xwLKvP1YEs1zFrNcFpb
         ZWGUZosSzHBPyyiKfjkeZrYPf8ws+e28LR625ZeyYyl0fUmwvjYWYt9c4ZV/LeOlnG2t
         k09C1s98RUtmR3u13PtdT+ErBMbx618uk9P7oKgwRmZKhVbllh3x3m4fd9WIXTT2vuWI
         kedsl+sTbW75teus8YLA3yWhXOXjqOKv0CM8Dwu82pTiB+ZaL+erH8O1Q4/63rmmowl4
         a7hygFd8a4UEvnsKqWJsbGTpOaLmi6tlM6ZSmmU0oOa945GglFMUc3xul6OQyl3zdbH1
         zEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767773; x=1778372573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=updh4+8aajDrOCKk474Il/JqAI8pe3IBOIC1ocTfFvc=;
        b=JMgp9seehSVIiyjZSXXZZQuhDGLAp2A6iQeXD/EhEiK26nemEex/J+u7lv3jJ/a/Rn
         XBPtYmDkXFr75qPqmeXSf2/CSKApovftrH+5dMFlSYPQdiAiu3NLnt5Rpk9IYbgx5xeB
         l9EpWFj4+KJs3LyLViJn2agF3MM9MX/ecKTLl39yvoGhyGneUVZK7HMz7gTGPIKaiYD6
         ur9qCt29SClvxQxffmr1XdxUUUhrQq2lssHQdFR1ISb+q5M67frGVsgc7JsxBAtGjD+a
         zsNAj6QaZufTABIz+XsuH0yewmRR4KKz69HNMiAnOYFrXJVsBADpH4JfewZ8VVaK7Wku
         bbFg==
X-Forwarded-Encrypted: i=1; AFNElJ9X0oJeglwSFx4w+Cbz78xwXhIvkOvSWCXOIPQqq0lRpx+jrUuJqQOIBFoGtH0JqyQ/nOITCX7lomDl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg7C/JJOZKdpUNZOmoDmAqdfxpqoojGqAjLy4RWa70UNRgHs3K
	WzvpJcgdovx0ypCTkeaqG7q/LS/wym4n4py9lUTKaIpRjg1C7PPdI/Iv5uR1VigEtpg+0NXcfhu
	l0M2jYrs0NQ==
X-Received: from dybcr21.prod.google.com ([2002:a05:7300:ac95:b0:2e2:2088:dca7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7c0b:b0:2ed:e14:42e8
 with SMTP id 5a478bee46e88-2efba7a98f3mr1797851eec.33.1777767772533; Sat, 02
 May 2026 17:22:52 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:30 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-1-irogers@google.com>
Subject: [PATCH v9 00/18] perf symbol/env: ELF machine clean up and lazy idle computation
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add a helper to perf_env to compute the e_machine if it is EM_NONE.
Derive the value from the arch string if available. Similarly derive
the arch string from the ELF machine if available, for
consistency. This means perf's arch (machine type) is no longer
determined by uname but set to match that of the perf ELF executable.

Migrate code away from strcmp on env->arch to using the e_machine
comparisons that are more accurate and not prone to uname and other
naming differences. While cleaning this up, also clean up the capstone
initialization code to cover more architectures and to set the big
endian flag based on ELF header information.

Switch the idle computation to the point of use and lazily compute it,
rather than computing it for every symbol. The current only user is
`perf top`. At the point of use the perf_env is available and this can
be used to make sure the idle function computation is machine and
kernel version dependent.

To avoid concurrent update issues with bitfields sharing a byte in
`struct symbol` switch to using C11 atomics.

v9:
 - Key changes in v9:
   - **C11 Atomics for `struct symbol`**: Dropped the global
     `symbol_bits_lock` introduced in v7/v8. Replaced unsafe bitfields
     with a thread-safe `_Atomic uint16_t flags` and lockless atomic
     helpers (e.g., `symbol__type()`, `symbol__set_inlined()`).
   - **Bi-endianness Support**: Added `*_endian` variants for `dso` and
     `thread` helpers to ensure Capstone correctly disassembles cross-endian
     binaries.
   - **Architecture Hardening**:
     - Fixed inverted SPARC logic in `perf_env__single_address_space()`.
     - Prioritized DSO architecture over global environment in
       `machine_or_dso_e_machine()`.
     - Fixed an uninitialized memory leak in `perf_env__e_machine()`.
     - Removed lossy `normalize_arch()` canonicalization in `process_arch()`.

 - Review Feedback Status:
   - **Addressed**: C11 atomics migration, bi-endianness, SPARC logic,
     DSO prioritization, and uninitialized memory fixes.
   - **Not Addressed / Dropped**:
     - Patch 15 OS Release: The concern regarding the `uname()` fallback
       during offline analysis was determined to be incorrect for these
       uninitialized states; the original lazy assumption is retained.
     - Patch 04/11: The `EM_AARCH64` fallbacks were dropped as the
       definition should come from dwarf-regs.h when necessary.

v8:
 - Address Sashiko AI review feedback for Patch 1:
   - Switch all code dependent on the arch string to use `e_machine`
     instead.
   - Update `machine__is` and `machine__normalized_is` to take
     `e_machine` integers instead of strings.
   - Refactor `arch_syscalls__strerrno_function` to take an `e_machine`.
   - Avoid premature caching of the host architecture in
     `perf_session__e_machine`.

v7:
 - Address better handling of strdup failures with arch in the
   header/env.
 - Address concurrent update issues in `struct symbol` bitfields by
   introducing a global lock for writes.

v6: Ensure arch is canonical by going to e_machine and back (Sashiko)
v5: Add perf_env os_release helper (Namhyung/Sashiko)
v4: Fix Sashiko issues where an array element wasn't sorted properly,
    the e_flags weren't returned properly, the idle type is change to
    a u8 rather than an enum value and the s390 version check for
    psw_idle is slightly reordered and tweaked.
v3: Properly set up the e_machine coming from the perf_env as reported
    by Honglei Wang.
v2: Some minor white space clean up.
v1: Initial release.

Ian Rogers (18):
  perf env: Add perf_env__e_machine helper and use in perf_env__arch
  perf tests topology: Switch env->arch use to env->e_machine
  perf env, dso, thread: Add _endian variants for e_machine helpers
  perf capstone: Determine architecture from e_machine
  perf print_insn: Use e_machine for fallback IP length check
  perf symbol: Avoid use of machine__is
  perf machine: Use perf_env e_machine rather than arch
  perf sample-raw: Use perf_env e_machine rather than arch
  perf sort: Use perf_env e_machine rather than arch
  perf arch common: Use perf_env e_machine rather than arch
  perf header: In print_pmu_caps use perf_env e_machine
  perf c2c: Use perf_env e_machine rather than arch
  perf lock-contention: Use perf_env e_machine rather than arch
  perf env: Refactor perf_env__arch_strerrno
  perf env: Remove unused perf_env__raw_arch
  perf env: Add helper to lazily compute the os_release
  perf symbol: Add setters for bitfields sharing a byte to avoid
    concurrent update issues
  perf symbol: Lazily compute idle

 tools/perf/arch/common.c                      |  62 ++--
 tools/perf/builtin-c2c.c                      |  40 +--
 tools/perf/builtin-inject.c                   |   6 +-
 tools/perf/builtin-kwork.c                    |   2 +-
 tools/perf/builtin-report.c                   |   2 +-
 tools/perf/builtin-sched.c                    |   4 +-
 tools/perf/builtin-top.c                      |   7 +-
 tools/perf/builtin-trace.c                    |   7 +-
 tools/perf/tests/symbols.c                    |   2 +-
 tools/perf/tests/topology.c                   |   8 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   2 +-
 tools/perf/trace/beauty/arch_errno_names.sh   |  40 ++-
 tools/perf/ui/browsers/annotate.c             |   2 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/util/annotate.c                    |   5 +-
 tools/perf/util/auxtrace.c                    |   6 +-
 tools/perf/util/callchain.c                   |   4 +-
 tools/perf/util/capstone.c                    | 129 +++++---
 tools/perf/util/data-convert-bt.c             |   2 +-
 tools/perf/util/dlfilter.c                    |   2 +-
 tools/perf/util/dso.c                         |  19 +-
 tools/perf/util/dso.h                         |  14 +-
 tools/perf/util/env.c                         | 295 ++++++++++++++----
 tools/perf/util/env.h                         |  12 +-
 tools/perf/util/evsel_fprintf.c               |   6 +-
 tools/perf/util/header.c                      |  58 ++--
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/lock-contention.c             |   6 +-
 tools/perf/util/machine.c                     |  27 +-
 tools/perf/util/machine.h                     |   2 -
 tools/perf/util/print_insn.c                  |  23 +-
 tools/perf/util/print_insn.h                  |   3 +
 tools/perf/util/probe-event.c                 |   4 +-
 tools/perf/util/sample-raw.c                  |  21 +-
 tools/perf/util/sample-raw.h                  |   6 +-
 .../util/scripting-engines/trace-event-perl.c |   2 +-
 .../scripting-engines/trace-event-python.c    |   4 +-
 tools/perf/util/session.c                     |  26 +-
 tools/perf/util/sort.c                        |  66 ++--
 tools/perf/util/srcline.c                     |  10 +-
 tools/perf/util/symbol-elf.c                  |   5 +-
 tools/perf/util/symbol.c                      | 208 ++++++++----
 tools/perf/util/symbol.h                      |  74 ++++-
 tools/perf/util/symbol_fprintf.c              |   4 +-
 tools/perf/util/thread.c                      |  22 +-
 tools/perf/util/thread.h                      |   8 +-
 46 files changed, 860 insertions(+), 403 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

