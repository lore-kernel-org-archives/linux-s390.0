Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC1E54B
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705194; cv=none; b=LLk/6IXH2C15fhdWpJoV2w15aTaIYg8GzGpSKiaTKNqM++K5bV4MWDUp+DzwEJLtXCUzcRSAkAYTeLqKsIMhDKihLKCJ9nkLplzd19/gycKPKvbXSaGYxYpHHSIHhTyBBQoYO+9sAnhXkUHWBKZ9ZSm9sgs4/Zq/9lUWFHMZbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705194; c=relaxed/simple;
	bh=GLBpfLkC56j41lYw7vpP3gbQ2zPxV/utnINLOeOltYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8I4UgBlIMBCrdph1OeLme5bz+w8zHRSvSeQnnlccKSVgonSKt1OYlR8xD8n8VeIGEfAnrauvRvLtKnh843z87jBS2Tx3SQxQ5gaJpN7G44jYMrED/WIXn+Bf0a4aCaQ8iKySJzzBACthxdVZoxaWcbhiSyrSZJzmyqj2EbglM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6l1v85s; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6l1v85s"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c726f4019so3650135c88.1
        for <linux-s390@vger.kernel.org>; Fri, 01 May 2026 23:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705192; x=1778309992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+joWV5lYUoK2hhGJu98qysVptkOu8cs8aXkN9dw07ro=;
        b=C6l1v85szwMKdLff6iRj/nyzZ6q85lN1ZNecjbIUIC7pv5QqDVQ8UAWUc16h4A+BPo
         zZ8iokI413D5CBBl7ZK/d9WMGL31hLO1og+B01wqMcC3O3QNWF9InF1zQIWByUPcPs44
         Ip9oBZHcr0DlIbdeNGe2BLpoHC+Sp0y/+/LxQmLE9RJamBLF2wiUa+ghbounfA8lzUCL
         ystkwVYODFHoPN3WJDZ5v68klGUQWr7Slsl0hsJKWaOlgyovBDeSTY8aye4aTqqyBs8R
         53V5d7HYkAq1Mtui3nZD/zWQsjJ3wJYTlLbsDnojqOHcvBzdPmzDPzuzFYxMWdQ08sGk
         PSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705192; x=1778309992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+joWV5lYUoK2hhGJu98qysVptkOu8cs8aXkN9dw07ro=;
        b=a38C0BBT3bofWyAexup+g3KXi7DXCg3DQs1Q1Nm/5d0OHo0q2DnxXWIMXTjmT5ayFE
         RhEmZNrrE2cOue/4G7lWag/wrdt3bMxtkAptL+tuQfScA2OTgTs0B9DC5DAlgnpG1ze4
         QpV5v8zd7h4QDrfqZaPOM1HDLKdeyuferS4jdo6dp7bWg6QQKpCfVpCrer25sNiHrWbK
         daaH3BY0dt3RFSS3oZvBnLNAWIlmFk2GCdaMZxUHExgxHBl4sOg1TZtUiGtdUo4mb3Hc
         bZQ12k2KfR0RO7sLqv9WEdL7yrNHOyamv6PK/KX4hw6WHGrbESdzdAQRCDPRNHjJmU5Y
         KRKw==
X-Forwarded-Encrypted: i=1; AFNElJ+uEcjOZg0CMv4kEk3OcfVU8cRLd2JaRKul8SvPv4uX3bioklwcDqmcq//EmVRMZHDISvCGfsFnilpe@vger.kernel.org
X-Gm-Message-State: AOJu0YweBFaaH2dJvMPT54E9UG94TFaxmi9zZ5Ky/bOa70MxDkCg3ya1
	PHCi3YfsmEQoqiiiBRPiw3cVeV3KHefXpAtZBE4ake8f8XwboUXrui6PQbvGtLOuaUQDw4Fu83u
	cfBAva0nvoQ==
X-Received: from dyctz24.prod.google.com ([2002:a05:7301:9f18:b0:2e6:f22b:f849])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2514:b0:12d:de3e:86b4
 with SMTP id a92af1059eb24-12dfd8419e8mr745879c88.36.1777705192124; Fri, 01
 May 2026 23:59:52 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:18 -0700
In-Reply-To: <20260409230620.4176210-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-1-irogers@google.com>
Subject: [PATCH v8 00/17] perf symbol/env: ELF machine clean up and lazy idle computation
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
  
Switch the idle computation to the point of use and lazily compute it,
rather than computing it for every symbol. The current only user is
`perf top`. At the point of use the perf_env is available and this can
be used to make sure the idle function computation is machine and
kernel version dependent.
  
To avoid concurrent update issues with bitfields sharing a byte in
`struct symbol` due to the lazy computation, introduce a global lock
for updates to these fields and use setter functions. The reads remain
lockless.
  
v8:
 - Address Sashiko AI review feedback for Patch 1:
   - Switch all code dependent on the arch string to use `e_machine`
     instead (e.g., in `perf c2c`, `perf lock-contention`, `perf
     header`, `perf arch common`, `tests/topology.c`,
     `perf_env__init_kernel_mode`).
   - Update `machine__is` and `machine__normalized_is` to take
     `e_machine` integers instead of strings.
   - Refactor `arch_syscalls__strerrno_function` (generated via
     `arch_errno_names.sh`) to take an `e_machine` instead of an arch
     string.
   - Avoid premature caching of the host architecture in
     `perf_session__e_machine` by using a non-caching helper when
     threads are not yet available.
  
v7:
 - Address better handling of strdup failures with arch in the
   header/env.
 - Address concurrent update issues in `struct symbol` bitfields by
   introducing a global lock for writes.
https://lore.kernel.org/linux-perf-users/20260501182021.3651851-1-irogers@google.com/

v6: Ensure arch is canonical by going to e_machine and back (Sashiko)
https://lore.kernel.org/linux-perf-users/20260409230620.4176210-1-irogers@google.com/
  
v5: Add perf_env os_release helper (Namhyung/Sashiko)
https://lore.kernel.org/lkml/20260406170905.2614260-1-irogers@google.com/
  
v4: Fix Sashiko issues where an array element wasn't sorted properly,
    the e_flags weren't returned properly, the idle type is change to
    a u8 rather than an enum value and the s390 version check for
    psw_idle is slightly reordered and tweaked.
https://lore.kernel.org/lkml/20260327045025.2276517-1-irogers@google.com/
  
v3: Properly set up the e_machine coming from the perf_env as reported
    by Honglei Wang.
https://lore.kernel.org/lkml/20260326174521.1829203-1-irogers@google.com/
  
v2: Some minor white space clean up:
https://lore.kernel.org/lkml/20260325161836.1029457-1-irogers@google.com/
  
v1: https://lore.kernel.org/lkml/20260302234343.564937-1-irogers@google.com/

Ian Rogers (17):
  perf env: Add perf_env__e_machine helper and use in perf_env__arch
  perf tests topology: Switch env->arch use to env->e_machine
  perf capstone: Determine architecture from e_machine
  perf print_insn: Use e_machine for fallback IP length check
  perf machine: Use perf_env e_machine rather than arch
  perf sample-raw: Use perf_env e_machine rather than arch
  perf sort: Use perf_env e_machine rather than arch
  perf symbol: Avoid use of machine__is
  perf arch common: Use perf_env e_machine rather than arch
  perf header: In print_pmu_caps use perf_env e_machine
  perf c2c: Use perf_env e_machine rather than arch
  perf lock-contention: Use perf_env e_machine rather than arch
  perf env: Refactor perf_env__arch_strerrno
  perf env: Remove unused perf_env__raw_arch
  perf env: Add helper to lazily compute the os_release
  perf symbol: Add setters for bitfields sharing a byte to avoid
    concurrent update issues
  perf symbol: Lazily compute idle and use a global lock for updates

 tools/perf/arch/common.c                    |  55 ++--
 tools/perf/builtin-c2c.c                    |   2 +-
 tools/perf/builtin-kwork.c                  |   2 +-
 tools/perf/builtin-sched.c                  |   2 +-
 tools/perf/builtin-trace.c                  |   5 +-
 tools/perf/tests/topology.c                 |   8 +-
 tools/perf/trace/beauty/arch_errno_names.sh |  40 ++-
 tools/perf/util/annotate.c                  |   2 +-
 tools/perf/util/capstone.c                  | 115 +++++---
 tools/perf/util/data-convert-bt.c           |   2 +-
 tools/perf/util/env.c                       | 283 +++++++++++++++-----
 tools/perf/util/env.h                       |  11 +-
 tools/perf/util/header.c                    |  70 +++--
 tools/perf/util/lock-contention.c           |   6 +-
 tools/perf/util/machine.c                   |  25 +-
 tools/perf/util/machine.h                   |   2 -
 tools/perf/util/print_insn.c                |   8 +-
 tools/perf/util/sample-raw.c                |  18 +-
 tools/perf/util/session.c                   |  26 +-
 tools/perf/util/sort.c                      |  12 +-
 tools/perf/util/symbol-elf.c                |   2 +-
 tools/perf/util/symbol.c                    | 163 +++++++----
 tools/perf/util/symbol.h                    |  17 +-
 23 files changed, 612 insertions(+), 264 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

