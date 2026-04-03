Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20462FD69A;
	Fri,  3 Apr 2026 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182086; cv=none; b=alMqpR4DeID+2kTJfp8qLGyC2kAJwUTpyw+TffsiLLvAeThgAEzNAmH6DamFnYdh9oTEzCu+JEmuoVY0XWWIIe6q6cfIFc9KUeGz9pMa1BuHX8kmKCaJ73mbD3X5cFdImycQ7doZD1+sm716QXSfcRoM8VdyN+pEIxV+LoSdW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182086; c=relaxed/simple;
	bh=e6xYX0ruKxI7Mf87Cpbl+MMKz0ZgWoxJXzls1DuwW38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfd+dQKcE9EykYiN56hCIgqqzHsk1k9s+UhMA6td4fFsbPb2H9K0b0qUS+oq/aVnrtcDa4vOnWVjMNBz309us+6njb7El1F1Oo6X3CrkpV+m65fwg4ulNwXKbDqch2ptnGlBldEjARZuE8c7LApdYPbChj8+6XjihgB5rqZAS3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLupUNT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLupUNT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77F1C116C6;
	Fri,  3 Apr 2026 02:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775182086;
	bh=e6xYX0ruKxI7Mf87Cpbl+MMKz0ZgWoxJXzls1DuwW38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLupUNT+Bx24XbbKUhx0bZaVq18W5Xi8zv3z73fNoPQSo0Eil8lofqPDqsbmFaGlr
	 9eTUlEa0hKsvQvXnnRw3ZpPX69NSHI71QKYHjjICMDHV/Nv1wLkK47cyROHyA+O0kq
	 rm91iL6tx+6Nf1tVCwif1X89V8ny+sWpHE2PD3y6GPXsjBgafLFTHnKiHuRvUeHGGu
	 tJ0YeJWfqYhVYRJRiOAR+jJ2gEoSm47O38f6/dste1yzZviRd/XTughb6BuHd5/+b8
	 FIl5HYV21tN2zOaLQooIVNA8ylwDtXtnWZLbv8LyeZ842bpUc9YN2hLrfvRMekJx9d
	 /28fXmBjoqm9w==
Date: Thu, 2 Apr 2026 19:08:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH v2 1/3] perf config: Rename
 symbol_conf::disable_add2line_warn
Message-ID: <ac8hBOjxhiX-VtCl@google.com>
References: <20260402080159.2028733-1-tmricht@linux.ibm.com>
 <20260402080159.2028733-2-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402080159.2028733-2-tmricht@linux.ibm.com>

On Thu, Apr 02, 2026 at 10:01:57AM +0200, Thomas Richter wrote:
> Rename member symbol_conf::disable_add2line_warn to
> symbol_conf::addr2line_disable_warn to make it consistent with other
> addr2line_xxx constants.
> No functional change.
> 
> Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implementations")

I'm not sure if we want it for typo fixes.

Thanks,
Namhyung


> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-diff.c     |  4 ++--
>  tools/perf/util/addr2line.c   | 12 ++++++------
>  tools/perf/util/block-info.c  |  2 +-
>  tools/perf/util/libbfd.c      |  2 +-
>  tools/perf/util/symbol_conf.h |  2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 69069926dd0b..35d599d5c9fa 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1352,7 +1352,7 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
>  	/*
>  	 * Avoid printing the warning "addr2line_init failed for ..."
>  	 */
> -	symbol_conf.disable_add2line_warn = true;
> +	symbol_conf.addr2line_disable_warn = true;
>  
>  	bi = block_he->block_info;
>  
> @@ -1986,7 +1986,7 @@ int cmd_diff(int argc, const char **argv)
>  
>  	if (compute == COMPUTE_STREAM) {
>  		symbol_conf.show_branchflag_count = true;
> -		symbol_conf.disable_add2line_warn = true;
> +		symbol_conf.addr2line_disable_warn = true;
>  		callchain_param.mode = CHAIN_FLAT;
>  		callchain_param.key = CCKEY_SRCLINE;
>  		callchain_param.branch_callstack = 1;
> diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
> index 31c0391fffa3..e9f084db0802 100644
> --- a/tools/perf/util/addr2line.c
> +++ b/tools/perf/util/addr2line.c
> @@ -123,7 +123,7 @@ static enum cmd_a2l_style cmd_addr2line_configure(struct child_process *a2l, con
>  			lines = 3;
>  			pr_debug3("Detected binutils addr2line style\n");
>  		} else {
> -			if (!symbol_conf.disable_add2line_warn) {
> +			if (!symbol_conf.addr2line_disable_warn) {
>  				char *output = NULL;
>  				size_t output_len;
>  
> @@ -310,7 +310,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>  	}
>  
>  	if (a2l == NULL) {
> -		if (!symbol_conf.disable_add2line_warn)
> +		if (!symbol_conf.addr2line_disable_warn)
>  			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
>  		goto out;
>  	}
> @@ -330,7 +330,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>  	len = snprintf(buf, sizeof(buf), "%016"PRIx64"\n,\n", addr);
>  	written = len > 0 ? write(a2l->in, buf, len) : -1;
>  	if (written != len) {
> -		if (!symbol_conf.disable_add2line_warn)
> +		if (!symbol_conf.addr2line_disable_warn)
>  			pr_warning("%s %s: could not send request\n", __func__, dso_name);
>  		goto out;
>  	}
> @@ -339,7 +339,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>  	switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, addr, /*first=*/true,
>  				      &record_function, &record_filename, &record_line_nr)) {
>  	case -1:
> -		if (!symbol_conf.disable_add2line_warn)
> +		if (!symbol_conf.addr2line_disable_warn)
>  			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
>  		goto out;
>  	case 0:
> @@ -355,7 +355,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>  					      /*addr=*/1, /*first=*/true,
>  					      NULL, NULL, NULL)) {
>  		case -1:
> -			if (!symbol_conf.disable_add2line_warn)
> +			if (!symbol_conf.addr2line_disable_warn)
>  				pr_warning("%s %s: could not read sentinel record\n",
>  					   __func__, dso_name);
>  			break;
> @@ -363,7 +363,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>  			/* The sentinel as expected. */
>  			break;
>  		default:
> -			if (!symbol_conf.disable_add2line_warn)
> +			if (!symbol_conf.addr2line_disable_warn)
>  				pr_warning("%s %s: unexpected record instead of sentinel",
>  					   __func__, dso_name);
>  			break;
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index 649392bee7ed..8d3a9a661f26 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -303,7 +303,7 @@ static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  	char buf[128];
>  	char *start_line, *end_line;
>  
> -	symbol_conf.disable_add2line_warn = true;
> +	symbol_conf.addr2line_disable_warn = true;
>  
>  	start_line = map__srcline(he->ms.map, bi->sym->start + bi->start,
>  				  he->ms.sym);
> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index 63ea3fb53e77..c1c12308cc12 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -233,7 +233,7 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
>  	}
>  
>  	if (a2l == NULL) {
> -		if (!symbol_conf.disable_add2line_warn)
> +		if (!symbol_conf.addr2line_disable_warn)
>  			pr_warning("addr2line_init failed for %s\n", dso_name);
>  		return 0;
>  	}
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index ac1b444a8fd8..21a1f096d4f0 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -51,7 +51,7 @@ struct symbol_conf {
>  			report_block,
>  			report_individual_block,
>  			inline_name,
> -			disable_add2line_warn,
> +			addr2line_disable_warn,
>  			no_buildid_mmap2,
>  			guest_code,
>  			lazy_load_kernel_maps,
> -- 
> 2.53.0
> 
