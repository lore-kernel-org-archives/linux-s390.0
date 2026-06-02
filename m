Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41740373C00
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419254; cv=pass; b=aN2kZmuy5y/+eFBn9aQ+g+2BZzz2tJHhWZhHMBxq+oG9mjhPBimE9QKDYaHcyUM+4JvB52LZHFgoaIk6/oxV/pBIXjR5oZaY4Z1dKL9N2PuIr6jR6P6JcA1LFsNMXoaGzpp4yWHe19VQLcaFc3hsbJtpkJUeoFoZipB97Phrf8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419254; c=relaxed/simple;
	bh=2w4NXTukq5ckCobRf/f5vq86E+/5WUfUOK2BJBCuErQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFysH5ixCLEEKtFsQnQPwvCDXaVpplJhIgujQABwVxpdFuMx5MGEDGSb5GlNoFu7470pWlmZl4q8uU4cgFHuF4+l7uFfeFVMBA+SKgEoW6rajHId6zKhnM+VfosTd/YAgyu2pXjnXAsr841dgYFOTRlxT7NHV47IkXMV43n4G3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQQeTUrj; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQQeTUrj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf2911f93cso5315ad.1
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 09:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780419251; cv=none;
        d=google.com; s=arc-20240605;
        b=OYZ9lqCaA0Hg2leR9cVHdK1QCuDEfAcfMpaN/PdrWEJIB/3tT5BCrgskZmYlk+sZvH
         LN7eBBIdhNFnUH19yfhcosmXOXHIWRQEZjAnnjcGV3TpAW6lDHJCjJfowo68oAzJBUhP
         U+Qgqopv9wUfXP2/DPxR2QVZaTMG2tFQN+8s3f3ueJybkMDP13/ZNM2FFuD+hkjm8fR7
         KnKsu4vaqldlN7ko7wGnoUig06dvJPtLbt8DdwYKtQSfvz8N9qxwu7ycycjAfGdGLXyY
         tFlEcE5hqDNqPIFtnX0ODKa9Yu6ZOJXZmvncjZDY6/Gg6GvYxDQ00r6WG5j8xEviDJS7
         jf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Immf037yMWY3bmYTlq+R68PCYR0rAVdJ40kWnGQwG8o=;
        fh=xaWFlDb/qfC2aQtFCa9dgvZ71ZzrowNSyTzLhRyTzOo=;
        b=IlNwGWXC1wCvKJ+ZLly7Bo4TcUhgo0x7lutjSktX0lGR0RrBGd7gFw1nCvVLc14Q1t
         ZpEr/VCG6cExoC2YCZUoCyskd68c5FFCo/ED0FmPKqVAZ3qmexdvLKnRE9uQiIAo1zs7
         fXl3vEvkdfkBmgv5uy00nyOnthFWqIZQrnLpZ8SOfxAYs3WMsbXae+vdgUC0k2Gmu74W
         PLj0+TuLqUlzMJ+MSTxD2lTgqTAseLPF6nDeMxbWZ0K4FVFZ61ERCnvlwxqCGXpv+vVv
         Xllk/l7gSz92nf57BrQerTZNmUn1GJ+aBYrz90wtohhkymLmNC8f7bVU5wG8mRQtCMJF
         UENQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780419251; x=1781024051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Immf037yMWY3bmYTlq+R68PCYR0rAVdJ40kWnGQwG8o=;
        b=bQQeTUrjCBukb77+2vnRXDS5+UTooJDR9O2CirSxLYhsQ/r0bPP1WU99vBSRMiTTke
         n4RKdopl/HOyQdaXF9XwoSPwKMJvsrnKMXSesLR4S0EEAX9WZahImu/cXr5IEdpwIn91
         8//Btvn/qOcaA1SZxfsS6cEOd+ZKhdaRmVfE8LdEKHTPz9Ra4oK2QUNeaiC7tr267IvW
         HyRLKwcVRLDQCZnt3I/EmHgZCynZNym9QsmwCTMZR3XL59rszkidzX8+QqsRWDYDIRpe
         zkjBU0yNOfRy33XVzew0tNpiuTknlrvx6Ok5Dnw6eUVsxiJvjZE0YP2LkrREI1fqhgjY
         +1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419251; x=1781024051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Immf037yMWY3bmYTlq+R68PCYR0rAVdJ40kWnGQwG8o=;
        b=ncuZYZGBKMT3pggrfw8I5hCiK0sz1K/kzNwSOtXY82BnpBf+qtRb7ihZFoIEh1jKAy
         3rhA1n0WHF7ziAkBB6JLs3/DcaSvsQtQ75i2VOfpBCTKG29N2qKKy+fZrf+zZ7aF5/FY
         N+mUoIpqr40h+oEHdFej2v1MImSbcosVs3Kpg9XanutDHqaTfq+E/A+JqeCSRxLr2IWE
         U4+NX8jKwzw6HBu8QPWUYyuygbTQOswkFKyS506ds7EzlivSZQn2l76P15KR8wkdO2xy
         +8OLjO5LvktGAn5/TDNgYLrtpdArOGke5umRSmzImcG4A0hxaC7LtqILoNFTp9KVQPym
         aL9w==
X-Forwarded-Encrypted: i=1; AFNElJ/rE6ukCCUhWZ591R6cKM2toZvqrbZ9JHRtmeN7C3YialVg0gpPkWiMIm3wLsm2P2abP54h8iejqM7I@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPDDDgjzW6tRYZTJ0VdwJFjFHxJukVyUH9exKb8S3DFFCBXS0
	HF2fQxMmCgsFUWZDpMqjAwvYszyDGIU2GI5/YJZmihnKcjathTXu7WYphwAEnTdX5wov+B8uJ2F
	ZU0ZVgPoW/H7TCaVr17LqnUvWqevueX8indDU+sce
X-Gm-Gg: Acq92OE8iy1Ej9mXapkq/4tiKOpYgVAj3KlWBb8f3ciF8mYwQJl/715ln3oRcyf4wKB
	WR0MASK3w8YkuNPJ+6iW5icqusfiieagCI/PJr/unao6PvCZhYCauw+Q92J2eFSGQvwOO9o/HYC
	QLj1ZUXIbW7GpRjp7EVYWugSJfXXgQ/JStuHgFw2nlXQYgYmzrFYW9SYnQ2lBENy8wowCU1lcqz
	WG9Dfc40eXi/xAlsM4AG7dIWrih774P/5kO8ps0zsc4pC+Ne1/Bw2/rJc6FwlKgUeld/9Y9jI1d
	BJoqSTDVfrfeibLuN8vHE6NRLX2D1M2UUnta60V5wxH8YRGGlDdyYQOI4yA=
X-Received: by 2002:a17:902:ecc3:b0:2c0:bf57:8746 with SMTP id
 d9443c01a7336-2c10eb100e7mr3521915ad.18.1780419250852; Tue, 02 Jun 2026
 09:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jun 2026 09:53:59 -0700
X-Gm-Features: AVHnY4JxpTAWoaKW7TN9u2Gp-5-dknXBRdSSDax8MAQ6G8yz2ciVwr9NCHDqDt0
Message-ID: <CAP-5=fWtc0xHfCeXfcPUkmWtHZO4EUriDrqovr5nXzb0GvSWxw@mail.gmail.com>
Subject: Re: [PATCH v12 00/19] perf: Use e_machine and lazily compute symbols
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 8:25=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> Add a helper to perf_env to compute the e_machine if it is EM_NONE.
> Derive the value from the arch string if available. Similarly derive
> the arch string from the ELF machine if available, for consistency.
> This means perf's arch (machine type) is no longer determined by uname
> but set to match that of the perf ELF executable.
>
> Migrate code away from strcmp on env->arch to using the e_machine
> comparisons that are more accurate and not prone to uname and other
> naming differences. While cleaning this up, also clean up the
> capstone initialization code to cover more architectures and to set
> the big endian flag based on ELF header information.
>
> Refactor perf_env__arch_strerrno to take an e_machine instead of an
> architecture string, removing the HAVE_LIBTRACEEVENT dependency
> entirely and making it unconditionally available. The generated errno
> table includes fallback definitions for newer ELF machine constants to
> ensure compatibility with older host glibc versions.
>
> Introduce a mutex in perf_env to safely protect lazy metadata setup,
> such as os_release or e_machine resolution, preventing concurrent
> initialization data races and memory leaks during multi-threaded
> profiling or symbol loading. Properly initialize stack-allocated
> perf_env instances to ensure safe mutex destruction.
>
> Switch the idle computation to the point of use and lazily compute it,
> rather than computing it for every symbol. The current only user is
> `perf top`. At the point of use the perf_env is available and this can
> be used to make sure the idle function computation correctly accounts
> for architecture-specific and kernel-version-specific patterns.
> To prevent concurrent updates to shared symbol bitfield flags, migrate
> bitfield variables in struct symbol to C11 atomic flags.

So I think this series is at the point where Sashiko [1] is giving
warnings only for out-of-scope things and pre-existing conditions. I
will give a detailed explanation below, but I'd appreciate help moving
this forward with human review and submission. Thanks!

> Ian Rogers (19):
>   perf env: Add perf_env__e_machine helper and use in perf_env__arch

1 critical 2 high issues.
The issues relate to existing data races, the inaccurate arch string,
and normalizing the arch string stored in the data file. The existing
data races don't bite us currently due to the single threaded nature
of most of perf - multithreading is on the TODO list. The arch string
is inaccurate and the e_machine in newer perf.data files resolves
this. If we were using the arch string without the e_machine then the
concerns over its use are valid, but this series is trying to remove
the use of the arch string and strongly prefer the e_machine.

>   perf tests topology: Switch env->arch use to env->e_machine

No regressions.

>   perf env, dso, thread: Add _endian variants for e_machine helpers

1 high issue for a potential pre-existing SEGV if a thread lacks maps.
Let's hope that doesn't happen, the example given assumes a
multithreaded environment and multi-threading is on the TODO list.

>   perf capstone: Determine architecture from e_machine

1 low issue. A flag only present in capstone 4.0 is used. As capstone
4.0 was released in 2018, let's just assume the flag is there rather
than adding yet more complexity.

>   perf print_insn: Use e_machine for fallback IP length check

No regressions.

>   perf symbol: Avoid use of machine__is

1 high issue. Concerns over pre-existing cross-platform analysis
problems. Cross-platform analysis fully working is on the TODO list.

>   perf machine: Use perf_env e_machine rather than arch
>   perf sample-raw: Use perf_env e_machine rather than arch
>   perf sort: Use perf_env e_machine rather than arch
>   perf arch common: Use perf_env e_machine rather than arch
>   perf header: In print_pmu_caps use perf_env e_machine
>   perf c2c: Use perf_env e_machine rather than arch
>   perf lock-contention: Use perf_env e_machine rather than arch
>   perf env: Refactor perf_env__arch_strerrno
>   perf env: Remove unused perf_env__raw_arch

No regressions x9.

>   perf env: Add mutex to protect lazy environment initialization

1 medium issue requesting more locking on more bits of perf_env.
Multi-threading is on the TODO list and let's stop the feature creep
here.

>   perf env: Add helper to lazily compute the os_release

1 high issue. Concern over a perf data issue in pipe mode. Addressing
this would require a fairly major overhail of perf data, so let's add
fixing to the TODO list.

>   perf symbol: Add setters for bitfields sharing a byte to avoid
>     concurrent update issues
>   perf symbol: Lazily compute idle

No regressions x2.

Thanks,
Ian

[1] https://sashiko.dev/#/patchset/20260602152516.2831152-1-irogers%40googl=
e.com

>
>  tools/perf/arch/common.c                      |  92 +++--
>  tools/perf/builtin-c2c.c                      |  40 +-
>  tools/perf/builtin-inject.c                   |  10 +-
>  tools/perf/builtin-kwork.c                    |   2 +-
>  tools/perf/builtin-report.c                   |   2 +-
>  tools/perf/builtin-sched.c                    |   4 +-
>  tools/perf/builtin-top.c                      |   7 +-
>  tools/perf/builtin-trace.c                    |   7 +-
>  tools/perf/tests/symbols.c                    |   2 +-
>  tools/perf/tests/topology.c                   |   8 +-
>  tools/perf/tests/vmlinux-kallsyms.c           |   2 +-
>  tools/perf/trace/beauty/Build                 |   1 +
>  tools/perf/trace/beauty/arch_errno_names.sh   |  53 ++-
>  tools/perf/ui/browsers/annotate.c             |   2 +-
>  tools/perf/ui/browsers/map.c                  |   4 +-
>  tools/perf/util/annotate.c                    |   5 +-
>  tools/perf/util/auxtrace.c                    |   6 +-
>  tools/perf/util/callchain.c                   |   4 +-
>  tools/perf/util/capstone.c                    | 132 ++++--
>  tools/perf/util/data-convert-bt.c             |   2 +-
>  tools/perf/util/data-convert-json.c           |   6 +-
>  tools/perf/util/dlfilter.c                    |   2 +-
>  tools/perf/util/dso.c                         |  19 +-
>  tools/perf/util/dso.h                         |  14 +-
>  tools/perf/util/env.c                         | 376 ++++++++++++++----
>  tools/perf/util/env.h                         |  14 +-
>  tools/perf/util/evsel_fprintf.c               |   6 +-
>  tools/perf/util/header.c                      |  55 ++-
>  tools/perf/util/intel-pt.c                    |   2 +-
>  tools/perf/util/libdw.c                       |   2 +-
>  tools/perf/util/lock-contention.c             |   6 +-
>  tools/perf/util/machine.c                     |  37 +-
>  tools/perf/util/machine.h                     |   2 -
>  tools/perf/util/print_insn.c                  |  23 +-
>  tools/perf/util/print_insn.h                  |   2 +
>  tools/perf/util/probe-event.c                 |   4 +-
>  tools/perf/util/sample-raw.c                  |  21 +-
>  tools/perf/util/sample-raw.h                  |   6 +-
>  .../util/scripting-engines/trace-event-perl.c |   2 +-
>  .../scripting-engines/trace-event-python.c    |   4 +-
>  tools/perf/util/session.c                     |  26 +-
>  tools/perf/util/sort.c                        |  66 +--
>  tools/perf/util/srcline.c                     |  10 +-
>  tools/perf/util/symbol-elf.c                  |   5 +-
>  tools/perf/util/symbol.c                      | 238 ++++++++---
>  tools/perf/util/symbol.h                      |  80 +++-
>  tools/perf/util/symbol_fprintf.c              |   4 +-
>  tools/perf/util/thread.c                      |  58 ++-
>  tools/perf/util/thread.h                      |  23 +-
>  49 files changed, 1078 insertions(+), 420 deletions(-)
>
> --
> 2.54.0.929.g9b7fa37559-goog
>
