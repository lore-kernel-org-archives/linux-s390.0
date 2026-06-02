Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082FB3A1688
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381514; cv=none; b=HVaLMjmDWtiuktb26/QRnnj8KPG5hzWM52k1YJHv1vspFEwccqI4RfmSi2otRxit2jZOYtzdJ4vCZPS98zDctyztbisUMl3r9qZBwH5Be4tNP0gW8moN+dkIIjFEFbKAu7xQs/COb4JVosCYX6Zkoj1AlCoVkfjXXtqg1KiMwpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381514; c=relaxed/simple;
	bh=ls/a16/9kkwWh4rcY4t2f8K83FrbX0uy7pf5C7QEl8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pdmf/d1SEKdMGtSRSEj/Os9Fg0APtw8fc3GsbZdv6BkK8lBXUXvG1OcyQAEwcpbNDxlsaYDCm7yM0qVd2/vnrtrpV+6ZnFxJDSO3CoZ+I5qb4DPmo/en7dOlHoa+uXxcBV+CUDg5zf2Kwliim1fyermmIvQ1y+7CaKutSqh/q3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DdEhKlsU; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DdEhKlsU"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e4636205so11429444eec.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381512; x=1780986312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSs0lxs5tWpCXOTJYEbOGCXvCdsQxavMqgrmSBXw2c0=;
        b=DdEhKlsUZbEoTQbhhHwhGgExBrdnpr9tATrT+v95HMs/AOzgccce01hqO5g3jVk3oo
         d4xQmQAtBBWLejK4kMhfug939mLR5zGvPezhQDAnN00sKeVLd2WMJhGxo9Rok2R5pKOg
         HfM32xPkHrnDvADgbLVuLxfilGx37lzJzVYyQ2xEi1luLjUI2bLuPiSRNPUxenDvRW01
         gZUYKfbi5Ox0w7gKS56qAYissV7Y8qMjQct28PeftbxEKyx0q2pKzFOnOqGDDbyqqYs/
         IAfWE0EbOzdmc+eG5hSfmdiJUgVWEqvXU/4v8XKl97zQJ99x/WiU4VX+HqD3Lopr5Mo6
         i7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381512; x=1780986312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSs0lxs5tWpCXOTJYEbOGCXvCdsQxavMqgrmSBXw2c0=;
        b=goYCNwCDCs0p6KqVufSeiTucC09JzK1C3BmF93wl84Or3jTCwYqwx83kXRDJD4gOEf
         XbyMIT/7XUSJnbejHWe8j29HzKE3+o4y+h7rurUVAUclXYeGeTzM7aM9QSBNvUwI6j8H
         j34hsFTK5fj4JqwPabvCzBNj7MZFrg/zs/ydzEnjAyM6zxGGfSMCu6xSQSgEOS0ZYIlm
         MkFrRy148n7pQt0uLqtXAUTlt8pEa8rxLLfpObGrbDcLxn9ue1PGpaZ9QvSJ+SAQXH6s
         79HEZMbbvPDSRkh28sqh6rWv+0q6HcgAhYuBVcWY9J3y9RHH6Q4I6CMwn0U1vThaZvbS
         XSwg==
X-Forwarded-Encrypted: i=1; AFNElJ+HdrQGyMUqzTbzLCUxsr7JnD5rKp6/KB81yJLLqFVpk9WGa3UGnb225xLGi4i3x1J8s1X8qnzukwKP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0E4EtVEv9pzfAqLksS4c5fg4E7DL5mfzcef2IHlr1BpLHVRzr
	bUAH0WIFtIY3WaVApjOru7vJxyNbM46PFrn7t8HC1YovSJ3m0TjiEoyLF0Hl+HncHaMl+d1Mn7F
	UrfsmpMzdKg==
X-Received: from dycng22.prod.google.com ([2002:a05:7300:ce16:b0:304:eb26:b10c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e12a:b0:304:6ee5:634a
 with SMTP id 5a478bee46e88-304fa52bae9mr6265320eec.1.1780381511918; Mon, 01
 Jun 2026 23:25:11 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:32 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-1-irogers@google.com>
Subject: [PATCH v11 00/19] perf: Use e_machine and lazily compute symbols
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

Introduce a mutex in perf_env to safely protect lazy metadata setup,
such as os_release or e_machine resolution, preventing concurrent
initialization data races and memory leaks during multi-threaded
profiling or symbol loading.

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
 tools/perf/util/env.c                         | 374 ++++++++++++++----
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
 tools/perf/util/sort.c                        |  66 ++--
 tools/perf/util/srcline.c                     |  10 +-
 tools/perf/util/symbol-elf.c                  |   5 +-
 tools/perf/util/symbol.c                      | 238 ++++++++---
 tools/perf/util/symbol.h                      |  80 +++-
 tools/perf/util/symbol_fprintf.c              |   4 +-
 tools/perf/util/thread.c                      |  58 ++-
 tools/perf/util/thread.h                      |  23 +-
 49 files changed, 1064 insertions(+), 420 deletions(-)

-- 
2.54.0.929.g9b7fa37559-goog

