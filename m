Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B169463;
	Mon,  4 May 2026 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777858557; cv=none; b=NnS6xES9G5Ky5SZbWEimyLLG/l424ktb6fLadqMDkoMSnrWKAQJVFLl0lheCYatpYUpxHBYaBjvr15zkYo+B5ZgZiDTRNau4TdHmW8iWyaLU5+brRyYapdUybrYHnoN01ScATBBmFEDNlIWVzZdRebfXKUGpD7A9T/1velXrCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777858557; c=relaxed/simple;
	bh=J57fHkcb2sTUOlg5JZBSV2Xsnk+sg+ZgcJ4agOn9+NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XM9rSXzZ9sptF7F/I56tXusFqGKOJtMWST9E8W62ADVIguEirz43G/CzEunv5BTmbT9U+GRy2/0Lss9TlLyslGtZeK6T07bqxqAUfvTIDatXWmBQZcCUpNB7xvoYdRABUjqmuxnSN/+5fKxjunoDxvputY3woQyTjlCrTrWdYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0t+UqOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0t+UqOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CF3C2BCB4;
	Mon,  4 May 2026 01:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777858557;
	bh=J57fHkcb2sTUOlg5JZBSV2Xsnk+sg+ZgcJ4agOn9+NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0t+UqOJk9sHUhivwwdzGhTJ4hN/dRVo8eudMiLIGTZwEFwzdm6RiIwUkoNu4Ypbv
	 b6AapNh/60taYLm1VumX95nIlTV3zXQeXOCwW7Zb15n63C0mVgbUNNeaOQUv70f6fT
	 1gC8wS15dxQAQWeOPvWZf+XpRWPkzuuvpjUDJcNL3QBakFvbtbiunYfzaa0p+GI/Cl
	 5juOSbhzhEc4elKga+GhrvUisG8n0tvg7ROmkgp48cdeQLMopIU3GJr/NnT6ZoMBeP
	 prPNWBiNtijzht4XYQIxTd1hCB1iHZjQ74sZ8dttm6+69C3/xVbLjwKcVBE0QHNDzM
	 gauEFWm3K1wTQ==
Date: Sun, 3 May 2026 18:35:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, tmricht@linux.ibm.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, hca@linux.ibm.com, jameshongleiwang@126.com,
	japo@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
	sumanthk@linux.ibm.com
Subject: Re: [PATCH v9 01/18] perf env: Add perf_env__e_machine helper and
 use in perf_env__arch
Message-ID: <aff3-2H-zvRKULwl@z2>
References: <20260502065935.291960-1-irogers@google.com>
 <20260503002248.1040791-1-irogers@google.com>
 <20260503002248.1040791-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260503002248.1040791-2-irogers@google.com>

On Sat, May 02, 2026 at 05:22:31PM -0700, Ian Rogers wrote:
> Add a helper that lazily computes the e_machine and falls back to
> EM_HOST. Use the perf_env's arch to compute the e_machine if
> available. Use a binary search for some efficiency in this, but handle
> somewhat complex duplicate rules. Switch perf_env__arch to be derived
> the e_machine for consistency. This switches arch from being uname
> derived to matching that of the perf binary (via EM_HOST). Update
> session to use the helper, which may mean using EM_HOST when no
> threads are available. This also updates the perf data file header
> that gets the e_machine/e_flags from the session.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f30e48eb3fc3..f1ae61392cce 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -379,21 +379,28 @@ static int write_osrelease(struct feat_fd *ff,
>  	return do_write_string(ff, uts.release);
>  }
>  
> -static int write_arch(struct feat_fd *ff,
> -		      struct evlist *evlist __maybe_unused)
> +static int write_arch(struct feat_fd *ff, struct evlist *evlist)
>  {
>  	struct utsname uts;
> -	int ret;
> +	const char *arch = NULL;
>  
> -	ret = uname(&uts);
> -	if (ret < 0)
> -		return -1;
> +	if (evlist->session) {
> +		/* Force the computation in the perf_env of the e_machine of the threads. */
> +		perf_session__e_machine(evlist->session, /*e_flags=*/NULL);
> +		arch = perf_env__arch(perf_session__env(evlist->session));
> +	}
>  
> -	return do_write_string(ff, uts.machine);
> +	if (!arch) {
> +		int ret = uname(&uts);
> +
> +		if (ret < 0)
> +			return -1;
> +		arch = uts.machine;
> +	}
> +	return do_write_string(ff, arch);
>  }
>  
> -static int write_e_machine(struct feat_fd *ff,
> -			   struct evlist *evlist __maybe_unused)
> +static int write_e_machine(struct feat_fd *ff, struct evlist *evlist)
>  {
>  	/* e_machine expanded from 16 to 32-bits for alignment. */
>  	uint32_t e_flags;
> @@ -2684,10 +2691,18 @@ static int process_##__feat(struct feat_fd *ff, void *data __maybe_unused) \
>  FEAT_PROCESS_STR_FUN(hostname, hostname);
>  FEAT_PROCESS_STR_FUN(osrelease, os_release);
>  FEAT_PROCESS_STR_FUN(version, version);
> -FEAT_PROCESS_STR_FUN(arch, arch);
>  FEAT_PROCESS_STR_FUN(cpudesc, cpu_desc);
>  FEAT_PROCESS_STR_FUN(cpuid, cpuid);
>  
> +static int process_arch(struct feat_fd *ff, void *data __maybe_unused)
> +{
> +	free(ff->ph->env.arch);
> +	ff->ph->env.arch = do_read_string(ff);
> +	if (!ff->ph->env.arch)
> +		return -ENOMEM;
> +	return 0;
> +}

Isn't it same as FEAT_PROCESS_STR_FUN()?


> +
>  static int process_e_machine(struct feat_fd *ff, void *data __maybe_unused)
>  {
>  	int ret;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index fe0de2a0277f..3e64db2d27c2 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -3023,14 +3023,19 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
>  		return EM_HOST;
>  	}
>  
> +	/*
> +	 * Is the env caching an e_machine? If not we want to compute from the
> +	 * more accurate threads.
> +	 */
>  	env = perf_session__env(session);
> -	if (env && env->e_machine != EM_NONE) {
> -		if (e_flags)
> -			*e_flags = env->e_flags;
> -
> -		return env->e_machine;
> -	}
> +	if (env && env->e_machine != EM_NONE)
> +		return perf_env__e_machine(env, e_flags);
>  
> +	/*
> +	 * Compute from threads, note this is more accurate than
> +	 * perf_env__e_machine that falls back on EM_HOST and doesn't consider
> +	 * mixed 32-bit and 64-bit threads.
> +	 */

I'm curious if it's always better.  If EM_HOST is 64-bit and the first
thread in a session happens to be 32-bit.  Then resulting e_machine
would be 32- bit, right?  Is that what we want?

Thanks,
Namhyung


>  	machines__for_each_thread(&session->machines,
>  				  perf_session__e_machine_cb,
>  				  &args);
> @@ -3048,10 +3053,9 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
>  
>  	/*
>  	 * Couldn't determine from the perf_env or current set of
> -	 * threads. Default to the host.
> +	 * threads. Potentially use logic that uses the arch string otherwise
> +	 * default to the host. Don't cache in the perf_env in case later
> +	 * threads indicate a better ELF machine type.
>  	 */
> -	if (e_flags)
> -		*e_flags = EF_HOST;
> -
> -	return EM_HOST;
> +	return perf_env__e_machine_nocache(env, e_flags);
>  }
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
