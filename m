Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D451D3D524C
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413926; cv=none; b=J3g8F05T44tiRKNs2tuC0RWZXrJPIQO2e4H/DgNGGaHbl6azy705E6zW/rG6+IdEuTVL7ipYOLqsye0GxSBffzDk7iGv7eWwHKeoIlCOVm9yrIA26F2YeHfJ7bHL7lTfNF34MAP4YlnjoS1j7s8ArfyeCRpXlF3ThWDONSX7l8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413926; c=relaxed/simple;
	bh=Tex6wSJ1ttT77SS74L03/2HwidCzgsEaoOXl0lQWIHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lzMEO4bSU8Nm3QiClB6+S+q5yGQIBbaMohfAtCo2vV08+gN5N2J3pcOX+o+y9J7J7Mm6UN3ousO1Z2YreuH6Zn6BDgjLwCYXErUNEYnL64KKM+or8rTXhWKkZOyQ1+I429Bzdp9/gmwW782B/9CAjZNqQCO6RzPZs/I8F1LFy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhZ6qfVo; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhZ6qfVo"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304efad654dso6247609eec.1
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413924; x=1781018724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn6oBFiuaPluJCiGweFSRrSqGXwZ42XjhKUDVMlkfYw=;
        b=JhZ6qfVoosVf7W34UjqcfWTvDvTg0w4C0rarzVj5Ng1dKlsrPEedB7dSicJJ0Xr7ZG
         uA6VEivXQWVxPjpLe7o2n//sYtHXtYG8QDaOS+yyCyiqUjfMg21RNjADfayBJWVeCeC8
         lAOxtU/S9frkTfra9WBQc6qlVUTSsc8HfyysTaRyDhsq2ju7X1MVzO2SuWSItX4DltER
         Uu2CyFWEMv2n9sl/E1P8VHRpMSulWsK5j8e5rCor00AjQd1yVCjVCEvrMnnQHhkMQRDM
         LMawMN6HVx9SA0yn1SJ4DxGiOAE7blzqqzItcg1w+f0DEFs6NsjblKmii/bk2CKCKoW5
         sH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413924; x=1781018724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn6oBFiuaPluJCiGweFSRrSqGXwZ42XjhKUDVMlkfYw=;
        b=PHQXnrzORbAiMWz44iszBIUgJ6dzOSsmj4XzLvWbF2kUIPYjjrv2y0q7/diJYi91Dh
         B6uTDq3BDeEmtf/uX5ICwguhOMEs0OMGVBweH2XJgDm+LbIUtuZyul/4YxXj9z2gk1+d
         hqtlleBrTNRPdkgkeVULXXrk8hBNzwwc2JH+LoUHJgmyYcKyoXABFTyiemDlFU/DacI+
         kyH4PctSnbRjDLCcU1+juHUTS0eJfXgZ+GyeBgxzLsHaTujwq1KOxkkdSQ9Tok1iAL8r
         t4FHw+ZQFpt0YW+tP2JIVrpXlR1EvE8mT93iO/xZJuY6NFI59uEdL72S3+wCQj1qjgwF
         Mwiw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ryajt+9IKzfZlBaX5e0AnRVMxeiU22JQ1gDZp6R+6xBJq4lQ2HSal++FAwY5f42YLZnFZnXW3H5O5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5De057YjadTvTjEPHJFlva5nW73s4cit4e0uqYQlFHA50FhQr
	zdD3h7Gwzqtu6N9sTNtXV7ZwM18vJ+zzMC7d4hmEYqkXz7hfpZVRAogAs8Jgh/wIzs2kNMq7jsY
	Uh3KakSs2UA==
X-Received: from dyce13.prod.google.com ([2002:a05:7300:724d:b0:2d7:e13b:ef99])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1284:b0:2c5:50fe:c795
 with SMTP id 5a478bee46e88-304fa722d9fmr7665240eec.29.1780413923763; Tue, 02
 Jun 2026 08:25:23 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:24:57 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-1-irogers@google.com>
Subject: [PATCH v12 00/19] perf: Use e_machine and lazily compute symbols
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add a helper to perf_env to compute the e_machine if it is EM_NONE.
Derive the value from the arch string if available. Similarly derive
the arch string from the ELF machine if available, for consistency.
This means perf's arch (machine type) is no longer determined by uname
but set to match that of the perf ELF executable.

Migrate code away from strcmp on env->arch to using the e_machine
comparisons that are more accurate and not prone to uname and other
naming differences. While cleaning this up, also clean up the
capstone initialization code to cover more architectures and to set
the big endian flag based on ELF header information.

Refactor perf_env__arch_strerrno to take an e_machine instead of an
architecture string, removing the HAVE_LIBTRACEEVENT dependency
entirely and making it unconditionally available. The generated errno
table includes fallback definitions for newer ELF machine constants to
ensure compatibility with older host glibc versions.

Introduce a mutex in perf_env to safely protect lazy metadata setup,
such as os_release or e_machine resolution, preventing concurrent
initialization data races and memory leaks during multi-threaded
profiling or symbol loading. Properly initialize stack-allocated
perf_env instances to ensure safe mutex destruction.

Switch the idle computation to the point of use and lazily compute it,
rather than computing it for every symbol. The current only user is
`perf top`. At the point of use the perf_env is available and this can
be used to make sure the idle function computation correctly accounts
for architecture-specific and kernel-version-specific patterns.
To prevent concurrent updates to shared symbol bitfield flags, migrate
bitfield variables in struct symbol to C11 atomic flags.

Ian Rogers (19):
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
  perf env: Add mutex to protect lazy environment initialization
  perf env: Add helper to lazily compute the os_release
  perf symbol: Add setters for bitfields sharing a byte to avoid
    concurrent update issues
  perf symbol: Lazily compute idle

 tools/perf/arch/common.c                      |  92 +++--
 tools/perf/builtin-c2c.c                      |  40 +-
 tools/perf/builtin-inject.c                   |  10 +-
 tools/perf/builtin-kwork.c                    |   2 +-
 tools/perf/builtin-report.c                   |   2 +-
 tools/perf/builtin-sched.c                    |   4 +-
 tools/perf/builtin-top.c                      |   7 +-
 tools/perf/builtin-trace.c                    |   7 +-
 tools/perf/tests/symbols.c                    |   2 +-
 tools/perf/tests/topology.c                   |   8 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   2 +-
 tools/perf/trace/beauty/Build                 |   1 +
 tools/perf/trace/beauty/arch_errno_names.sh   |  53 ++-
 tools/perf/ui/browsers/annotate.c             |   2 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/util/annotate.c                    |   5 +-
 tools/perf/util/auxtrace.c                    |   6 +-
 tools/perf/util/callchain.c                   |   4 +-
 tools/perf/util/capstone.c                    | 132 ++++--
 tools/perf/util/data-convert-bt.c             |   2 +-
 tools/perf/util/data-convert-json.c           |   6 +-
 tools/perf/util/dlfilter.c                    |   2 +-
 tools/perf/util/dso.c                         |  19 +-
 tools/perf/util/dso.h                         |  14 +-
 tools/perf/util/env.c                         | 376 ++++++++++++++----
 tools/perf/util/env.h                         |  14 +-
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
 tools/perf/util/sort.c                        |  66 +--
 tools/perf/util/srcline.c                     |  10 +-
 tools/perf/util/symbol-elf.c                  |   5 +-
 tools/perf/util/symbol.c                      | 238 ++++++++---
 tools/perf/util/symbol.h                      |  80 +++-
 tools/perf/util/symbol_fprintf.c              |   4 +-
 tools/perf/util/thread.c                      |  58 ++-
 tools/perf/util/thread.h                      |  23 +-
 49 files changed, 1078 insertions(+), 420 deletions(-)

-- 
2.54.0.929.g9b7fa37559-goog

