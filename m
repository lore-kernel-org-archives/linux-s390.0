Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3C2FA0C7;
	Fri,  3 Apr 2026 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182329; cv=none; b=Plj/IgAq6pL5m3XqS9/HPg8dFZC1OYCKtO98p1twpxPezDpSZEccejyHLiI86K+wcSNFATgcVB8AsAmdCPS00C2ugkvrhW+rAQXLOJwGOVy+nj77kn56YyhtH6OOajfboRhSfiC3LrDxlTZmKjJTx0Sk1ixT6tdovbqRoK8qqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182329; c=relaxed/simple;
	bh=HpYnR1HfYGXOiuHH25b6LHjVw9JscjEDFTTJ9SI9BsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC8YuGihhYS2XeN11IkWdwW7qfyYyhk3T8PVJs/ZrMrrs32dYYfVUHD2bdJNkX44zp45k6r708n6YAkunbxBPYqHzTvCPdsmEAS1z9qt2f0Wk1jBkB6tjHOxuOXK1waFDfodqwiHbl7NeSddAefEWYmA9sbRkpjqh0phg6iWiic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=claMy4yo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="claMy4yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2176C116C6;
	Fri,  3 Apr 2026 02:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775182329;
	bh=HpYnR1HfYGXOiuHH25b6LHjVw9JscjEDFTTJ9SI9BsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=claMy4yo72SK9OD57lTs+yuZexJjGRu+xQx/2zIrXkT6KGCHgTgfQ3uo6cOcxFBQJ
	 3THjoE+9U7iZVeQ+FEPGZLEVakFikHDsUfkyU2nRubTfO7Id+xw2njJY3oglTniH6h
	 SMonPyKo9jS7Cdgh8spzuYGzxppYs4dS1iMhwoIAtADfbCmPQzTPwAnwQVXnp2rFg/
	 bEJKvi4fFTTps8i0tkymYjUai0Sal/uqq7JrGmLG+oRGruuxYeFBKo4lE6ejKQ30Ow
	 eTEhGr4DSW+hrEVU4b2V90BZgKuO3zhi8yYeD2Gjze6iRccKS1+DKgz9FDxPkhPLLd
	 wpevxP3K7+jjg==
Date: Thu, 2 Apr 2026 19:12:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH v2 2/3] perf config: Make
 symbol_conf::addr2line_disable_warn configurable
Message-ID: <ac8h9ypRe4nHUu5q@google.com>
References: <20260402080159.2028733-1-tmricht@linux.ibm.com>
 <20260402080159.2028733-3-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402080159.2028733-3-tmricht@linux.ibm.com>

On Thu, Apr 02, 2026 at 10:01:58AM +0200, Thomas Richter wrote:
> Make symbol_conf::addr2line_disable_warn configurable by reading
> the perfconfig file. Use section core and addr2line-disable-warn =
> value.

I think it's better to have it under "report" or something.  But it
seems we already have one in the "core" section.

> 
> Example:
>  # perf config -l
>  core.addr2line-timeout=500
>  core.addr2line-disable-warn=1
>  #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/config.c | 3 +++
>  1 file changed, 3 insertions(+)

It'd be great if you add documentation in the same change.

> 
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 0452fbc6c085..31541e03aab7 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -461,6 +461,9 @@ static int perf_default_core_config(const char *var, const char *value)
>  	if (!strcmp(var, "core.addr2line-timeout"))
>  		addr2line_timeout_ms = strtoul(value, NULL, 10);
>  
> +	if (!strcmp(var, "core.addr2line-disable-warn"))
> +		symbol_conf.addr2line_disable_warn = strtoul(value, NULL, 10);

As it's boolean, better to use perf_config_bool() instead of strtoul()
so that it can accept "true" or "yes" as well as numbers.

Thanks,
Namhyung

> +
>  	/* Add other config variables here. */
>  	return 0;
>  }
> -- 
> 2.53.0
> 
