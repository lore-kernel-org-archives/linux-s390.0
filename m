Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638C345CD8
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296856; cv=none; b=d8P7npnsaDIuwsrKeLexf+4/czy35Pk/0ep4lnEue2TpzrdSwRbZLB999Sxi88TwVjuub6kdkF15QPZh7YNZafCpMQqskDLYmqiadMrE0akPFrvYQBGsLb7FuPuV4UB87safiOenFQgi7OTG3OUz5atFn0j9BWwyOnFM129dkmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296856; c=relaxed/simple;
	bh=FwHxGnDbziPy42LgFfGPImWYlGvqo9gh7tSXpzYkjgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lGqu2A6CXKTAY2PQxLdDYmFncklS3jgcRhcrcu1u0ZPbW+JiA4YiSeXn2uo+Hw1+7W08Ft25+yHOforM5Z+kE4951T4Vo9ZVYFbLfADhWrIwqqSv4XSiw0/sBnpaKP6OfZCJWD4ttorgkz5t15lEerbjHHbec4UiJrF0xGZLlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A6PBIsTU; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A6PBIsTU"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137dd5171feso1577470c88.1
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296854; x=1780901654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ETq/nZKmaaXSvCeX53sM97LlW7Wmwh6xei8MrSxj2M=;
        b=A6PBIsTUC+NA467FIHJh/TlL+FIiFGSo8wYNTQ2bfihkF3ebQTp+h+VgLuYGJdlORa
         rdQXAARdsbroMDVZZHLmQp7pHZyENEqpyCbqlbgt1kfOPyG0qQc6PcPjThT9qOHi217T
         gZYObpXIM95lgYzJDPbesTxo+4pnYxzkdV2WWe7sZb+y9JiM9XHu6C72ChietL0BUu0E
         k+S7zBmtLMHNtVlE0vBObInhkPbtrN+qoVzwLtUnfQNPpkEVdLglFwpuCVQlAeVPlsPp
         YS213XCx8BbEyRfep+Jub0tQIbMSXXYz6B3NKnmhEeluSWy5BxNOsWo80m6Tc0kF1Q6U
         7x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296854; x=1780901654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ETq/nZKmaaXSvCeX53sM97LlW7Wmwh6xei8MrSxj2M=;
        b=tIHkRC2qg8SIpt03oa/agh+80CY2BVXalU1Bq6U+qIRCVtc5MheFtGEdxCltb8lwK5
         vJ0A5qMmbHfBYyJkYPj2Mn9mygKcyaADTymIqgHxBBLAP+Xj5e2+r2c9FgcArKr239Bd
         aYfQSWDSOGXp1si3l7UHokBVWaw1KcDdSQBHePhOi256OAqxeX/djqrS5gxKPGqE6Q39
         HnSkH24VeDpFpMpkC/EAonXMiU34H2jcm0y0l5P0IZ0Efq5VstFakXNEpqAF/lmZAQC1
         BsDnXhjfTtCmHkB98lZzk6ZeCMbucX/iwg/3ghQMD0yvuWTkAVNV6Ca4Jf4V582j2P5I
         p86w==
X-Forwarded-Encrypted: i=1; AFNElJ+OEmTk1ibK6UtV55AGtZB8VokJA6B6DsmHDLKJDuC6tUgL2aQhR91ANGjZmv9nDxKTdpTkIXXKDFwF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XTw3L+3nzjPrqwPzeYANm+WSxFm3PeIQMCnKoc+cQZhVpjc0
	nsdaDno8HE0a7o5gTwjolTbjzMbXboToKLUR7w/FFo4a4g2SmHbXEkbsaKr+PMTOcwdLzn1dXDK
	rX2KjX9Uukg==
X-Received: from dlbrl28.prod.google.com ([2002:a05:7022:f51c:b0:136:f641:ccf5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:238c:b0:136:60e7:53b
 with SMTP id a92af1059eb24-137d402694cmr3531604c88.1.1780296853157; Sun, 31
 May 2026 23:54:13 -0700 (PDT)
Date: Sun, 31 May 2026 23:53:49 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-1-irogers@google.com>
Subject: [PATCH v10 00/18] Add perf_env__e_machine and migrate arch string
 comparisons to e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
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

v10:
 - Key changes in v10:
   - **Memory Safety & Robustness Hardening**: Added explicit `machine` NULL-pointer
     checks in `dso__load()` and `thread` guards in `thread__e_machine_endian()`
     to guarantee segmentation fault protection during out-of-tree Make builds, OOMs,
     or orphaned map group trace loadings.
   - **Mixed-Bitness Platform Resilience**: Fully overhauled `is_native_compatible()`
     to be environment-bitness-aware. This ensures 32-bit hosts correctly utilize
     cross-compiler objdump lookups when analyzing 64-bit traces sharing identical
     ELF machine constants (`EM_RISCV`).
   - **Live Session Architecture Mappings**: Redesigned `perf_env__init_kernel_mode()`
     to query runtime `uname(&uts)` and map live `env->arch` states dynamically,
     removing fragile hardcoded allowlists and guaranteeing correct 64-bit classifications
     for `riscv64`, `mips64`, and `parisc64`. Integrated bitness-aware 64-bit string
     overrides for these shared enums inside `perf_env__arch()`.
   - **Compiler Optimization Suffix Support**: Replaced strict `strcmp()` logic with an
     asymmetric compiler-suffix-aware prefix helper `match_x86_idle_routine()` to safely
     allowlist hot idle run-loops containing `.constprop.*` or `.isra.*` extensions while
     shielding against active hotplug/management functions dropping.
   - **Spectre-mitigated Handler & Cross-Architecture Fallbacks**: Restored the missing
     `intel_idle_ibrs` Spectre mitigation idle handler to the allowlist. Configured
     `symbol__is_idle()` to safely fall back to reading `dso__e_machine()` if the environment
     context is missing, preserving cross-architecture offline trace evaluations.
   - **Out-of-tree (`O=`) Make Builds Compatibility**: Refactored generated API translation
     units and Make Build dependency rules to eliminate `-Wunused-function` and
     `-Wmissing-prototypes` errors under strict `WERROR=1` out-of-tree build parameters.

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

 tools/perf/arch/common.c                      |  92 +++--
 tools/perf/builtin-c2c.c                      |  40 +-
 tools/perf/builtin-inject.c                   |   2 +-
 tools/perf/builtin-kwork.c                    |   2 +-
 tools/perf/builtin-report.c                   |   2 +-
 tools/perf/builtin-sched.c                    |   4 +-
 tools/perf/builtin-top.c                      |   6 +-
 tools/perf/builtin-trace.c                    |   7 +-
 tools/perf/tests/symbols.c                    |   2 +-
 tools/perf/tests/topology.c                   |   8 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   2 +-
 tools/perf/trace/beauty/Build                 |   1 +
 tools/perf/trace/beauty/arch_errno_names.sh   |  41 +-
 tools/perf/ui/browsers/annotate.c             |   2 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/util/annotate.c                    |   5 +-
 tools/perf/util/auxtrace.c                    |   6 +-
 tools/perf/util/callchain.c                   |   4 +-
 tools/perf/util/capstone.c                    | 132 ++++---
 tools/perf/util/data-convert-bt.c             |   2 +-
 tools/perf/util/data-convert-json.c           |   6 +-
 tools/perf/util/dlfilter.c                    |   2 +-
 tools/perf/util/dso.c                         |  19 +-
 tools/perf/util/dso.h                         |  14 +-
 tools/perf/util/env.c                         | 370 ++++++++++++++----
 tools/perf/util/env.h                         |  13 +-
 tools/perf/util/evsel_fprintf.c               |   6 +-
 tools/perf/util/header.c                      |  55 ++-
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/libdw.c                       |   2 +-
 tools/perf/util/lock-contention.c             |   6 +-
 tools/perf/util/machine.c                     |  37 +-
 tools/perf/util/machine.h                     |   2 -
 tools/perf/util/print_insn.c                  |  23 +-
 tools/perf/util/print_insn.h                  |   2 +
 tools/perf/util/probe-event.c                 |   4 +-
 tools/perf/util/sample-raw.c                  |  21 +-
 tools/perf/util/sample-raw.h                  |   6 +-
 .../util/scripting-engines/trace-event-perl.c |   2 +-
 .../scripting-engines/trace-event-python.c    |   4 +-
 tools/perf/util/session.c                     |  26 +-
 tools/perf/util/sort.c                        |  66 ++--
 tools/perf/util/srcline.c                     |  10 +-
 tools/perf/util/symbol-elf.c                  |   5 +-
 tools/perf/util/symbol.c                      | 235 ++++++++---
 tools/perf/util/symbol.h                      |  80 +++-
 tools/perf/util/symbol_fprintf.c              |   4 +-
 tools/perf/util/thread.c                      |  54 ++-
 tools/perf/util/thread.h                      |  23 +-
 49 files changed, 1048 insertions(+), 415 deletions(-)

-- 
2.54.0.823.g6e5bcc1fc9-goog

