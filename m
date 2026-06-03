Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC43839A9;
	Wed,  3 Jun 2026 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465193; cv=none; b=KntoknkuYGupFIxH6PLVCaaspKusayqJm4oYYTpL7cQUEgrhfrxbPH7drCZorwvgsU2fyZP0IjvlXyw1SjrtvtRMExfkuQwajiXt9aHIryrLmyLgdd81nLo/W0mAAiKUA/2DZS5jxo8RyCDiHc+7dXR8ZAbJwDBvswVjkTZmbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465193; c=relaxed/simple;
	bh=Xv0Bh9zmVnA165mmd9s21qAuD+GLppUtHPaQh4bgims=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVw5l2sIgfS4oBtwxRizP6yl3ote1HTQ5qqysvAlQ4G3jM62MHeMRv0rfwALM0L0XX880R3onSyf8xci7GY3zTibu2hTvJ9e7KnulreCp07OOCg8ogXzm4Z6o0prGUM0Miiw6hhKZGjQky6Nr7rvK2PFGX3Y0lQvvL84LdUGMts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XryxbLKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XryxbLKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D651F00893;
	Wed,  3 Jun 2026 05:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780465191;
	bh=8ttNaYP3v97S1r8yk4Km7SZmsiR+Mww5Q9fHrJlGwjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XryxbLKp81RJCBx/ORRuDZaeB6RJzzqROXVpPZm3BSv32gfjYT52vujVmpy198eLP
	 +0+7YabSpCv3fqYwl1dgwm0+CsVojc7Cuuo0TqoCdZUuj2aFYHQdDhQjRvcoBgDVve
	 raBHH9AEJMl3ixzM2jHC0kM84ZUEpdwdI3RDOS7j5kyPm9ZLaQ/walrgUi8ecdYreh
	 zJLvGgJv5Q+LSH9gJwy4SpXWv9NmWNuVhAjs8p8430/2+i09665g9J9K17F2tY7D9Q
	 PqTMnJ4D9o3LLsPGrUnU05Hd7Q8LtwQFYFUcT0f/4DgAcdslMsPIn9n5MfFOu4ThY9
	 SC77f5GFo8PgQ==
Date: Tue, 2 Jun 2026 22:39:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	hca@linux.ibm.com, jameshongleiwang@126.com, japo@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-s390@vger.kernel.org, sumanthk@linux.ibm.com,
	tmricht@linux.ibm.com
Subject: Re: [PATCH v12 00/19] perf: Use e_machine and lazily compute symbols
Message-ID: <ah--Jc0PMT7Y7Z18@z2>
References: <20260602062452.2583619-1-irogers@google.com>
 <20260602152516.2831152-1-irogers@google.com>
 <CAP-5=fWtc0xHfCeXfcPUkmWtHZO4EUriDrqovr5nXzb0GvSWxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWtc0xHfCeXfcPUkmWtHZO4EUriDrqovr5nXzb0GvSWxw@mail.gmail.com>

Hi Ian,

On Tue, Jun 02, 2026 at 09:53:59AM -0700, Ian Rogers wrote:
> On Tue, Jun 2, 2026 at 8:25 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Add a helper to perf_env to compute the e_machine if it is EM_NONE.
> > Derive the value from the arch string if available. Similarly derive
> > the arch string from the ELF machine if available, for consistency.
> > This means perf's arch (machine type) is no longer determined by uname
> > but set to match that of the perf ELF executable.
> >
> > Migrate code away from strcmp on env->arch to using the e_machine
> > comparisons that are more accurate and not prone to uname and other
> > naming differences. While cleaning this up, also clean up the
> > capstone initialization code to cover more architectures and to set
> > the big endian flag based on ELF header information.
> >
> > Refactor perf_env__arch_strerrno to take an e_machine instead of an
> > architecture string, removing the HAVE_LIBTRACEEVENT dependency
> > entirely and making it unconditionally available. The generated errno
> > table includes fallback definitions for newer ELF machine constants to
> > ensure compatibility with older host glibc versions.
> >
> > Introduce a mutex in perf_env to safely protect lazy metadata setup,
> > such as os_release or e_machine resolution, preventing concurrent
> > initialization data races and memory leaks during multi-threaded
> > profiling or symbol loading. Properly initialize stack-allocated
> > perf_env instances to ensure safe mutex destruction.
> >
> > Switch the idle computation to the point of use and lazily compute it,
> > rather than computing it for every symbol. The current only user is
> > `perf top`. At the point of use the perf_env is available and this can
> > be used to make sure the idle function computation correctly accounts
> > for architecture-specific and kernel-version-specific patterns.
> > To prevent concurrent updates to shared symbol bitfield flags, migrate
> > bitfield variables in struct symbol to C11 atomic flags.
> 
> So I think this series is at the point where Sashiko [1] is giving
> warnings only for out-of-scope things and pre-existing conditions. I
> will give a detailed explanation below, but I'd appreciate help moving
> this forward with human review and submission. Thanks!
> 
> > Ian Rogers (19):
> >   perf env: Add perf_env__e_machine helper and use in perf_env__arch
> 
> 1 critical 2 high issues.
> The issues relate to existing data races, the inaccurate arch string,
> and normalizing the arch string stored in the data file. The existing
> data races don't bite us currently due to the single threaded nature
> of most of perf - multithreading is on the TODO list. The arch string
> is inaccurate and the e_machine in newer perf.data files resolves
> this. If we were using the arch string without the e_machine then the
> concerns over its use are valid, but this series is trying to remove
> the use of the arch string and strongly prefer the e_machine.
> 
> >   perf tests topology: Switch env->arch use to env->e_machine
> 
> No regressions.
> 
> >   perf env, dso, thread: Add _endian variants for e_machine helpers
> 
> 1 high issue for a potential pre-existing SEGV if a thread lacks maps.
> Let's hope that doesn't happen, the example given assumes a
> multithreaded environment and multi-threading is on the TODO list.
> 
> >   perf capstone: Determine architecture from e_machine
> 
> 1 low issue. A flag only present in capstone 4.0 is used. As capstone
> 4.0 was released in 2018, let's just assume the flag is there rather
> than adding yet more complexity.
> 
> >   perf print_insn: Use e_machine for fallback IP length check
> 
> No regressions.
> 
> >   perf symbol: Avoid use of machine__is
> 
> 1 high issue. Concerns over pre-existing cross-platform analysis
> problems. Cross-platform analysis fully working is on the TODO list.
> 
> >   perf machine: Use perf_env e_machine rather than arch
> >   perf sample-raw: Use perf_env e_machine rather than arch
> >   perf sort: Use perf_env e_machine rather than arch
> >   perf arch common: Use perf_env e_machine rather than arch
> >   perf header: In print_pmu_caps use perf_env e_machine
> >   perf c2c: Use perf_env e_machine rather than arch
> >   perf lock-contention: Use perf_env e_machine rather than arch
> >   perf env: Refactor perf_env__arch_strerrno
> >   perf env: Remove unused perf_env__raw_arch
> 
> No regressions x9.
> 
> >   perf env: Add mutex to protect lazy environment initialization
> 
> 1 medium issue requesting more locking on more bits of perf_env.
> Multi-threading is on the TODO list and let's stop the feature creep
> here.
> 
> >   perf env: Add helper to lazily compute the os_release
> 
> 1 high issue. Concern over a perf data issue in pipe mode. Addressing
> this would require a fairly major overhail of perf data, so let's add
> fixing to the TODO list.
> 
> >   perf symbol: Add setters for bitfields sharing a byte to avoid
> >     concurrent update issues
> >   perf symbol: Lazily compute idle
> 
> No regressions x2.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

