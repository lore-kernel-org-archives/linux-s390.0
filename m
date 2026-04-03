Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809B1B4224;
	Fri,  3 Apr 2026 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182569; cv=none; b=PBLGDnfJoG0HHyy+4PmDbpcE9R3X2xmkCPfC1uq8LfwXIijnJUJ8SCmr5pVYHsha49kyXbN40AUKyhBn96YxIwgnjL3Y1N37Ta0reVX2IRVVPmx/TerTYn8GKng3+zUfZRV6bcW+mpnJHVOG+y3A9gYNg3exBVVH5AZWzC/ELlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182569; c=relaxed/simple;
	bh=yp+6fV6LjA97ggh7/Hv9mCcAirW7EhodxKHAD+gOirU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+utq2CKjLTSyyK4KDTBD3l3ufPgDadrjMT95UyecWQbzvi3WtsNLbpphKUVKa5iSLefhKUHiqHhWdctgEDOMLxJOKWFiTR8LfL3EInjXVjZi1OvZsSS/wj1vkPagFJtlNDBfCsMxzyS9smfjV1bIU+LMLdjw3nAFajfcRXnJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiR9hs6N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiR9hs6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798BBC116C6;
	Fri,  3 Apr 2026 02:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775182568;
	bh=yp+6fV6LjA97ggh7/Hv9mCcAirW7EhodxKHAD+gOirU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AiR9hs6Nz5ij9z3cWbM52eKB2lpnCpg3IxoDIN97QT6vxvG/FrxNtgwPmCpsDYJew
	 f58dsTFShsSjHpqv7Q83EtyVLeqlT2kQC2nO+kuz6DXb81Ul4VlmFppA4sQ2hP8glt
	 K9O821dDThUpc7x7GXPHSMFIanhEBiApp7suNkQ0jsmi/2J9Ll7des7eLsSKCp2CXW
	 vGwQze0+V72o5cxCMcbhpHGNRyUw2QFopNEZziuNW5ieQN+zjH/E76VzmHnWG6K70L
	 zNOXOkXyeDlze/mgK1VDS0sIaS0S01ktV6HEOp5N10QrLo4e5oKaAegmafAQhibsV6
	 i1h9Nz+K9DbNw==
Date: Thu, 2 Apr 2026 19:16:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH v2 3/3] perf addr2line: Remove global variable
 addr2line_timeout_ms
Message-ID: <ac8i53NUoxVMVecp@google.com>
References: <20260402080159.2028733-1-tmricht@linux.ibm.com>
 <20260402080159.2028733-4-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402080159.2028733-4-tmricht@linux.ibm.com>

On Thu, Apr 02, 2026 at 10:01:59AM +0200, Thomas Richter wrote:
> Remove global variable addr2line_timeout_ms and add is as member
> to symbol_conf structure. Update the documentation for perf config
> file.
> 
> Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implementations")

I don't think this fixes anything.


> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-config.txt | 6 ++++++
>  tools/perf/util/addr2line.c              | 8 ++++----
>  tools/perf/util/addr2line.h              | 2 --
>  tools/perf/util/config.c                 | 3 +--
>  tools/perf/util/symbol_conf.h            | 1 +
>  5 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 642d1c490d9e..efc15b6db7e2 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -206,6 +206,12 @@ colors.*::
>  		Default values are 'white', 'blue'.
>  
>  core.*::
> +	addr2line-disable-warn::
> +		When set to 1 disable all warnings from 'addr2line' output.
> +		Default setting is 0 to show these warnings.
> +	addr2line-timeout::
> +		Sets a timeout (in milliseconds) for parsing 'addr2line'
> +		output.  The default timeout is 500ms.

It should be 5000ms or 5s.


>  	core.proc-map-timeout::
>  		Sets a timeout (in milliseconds) for parsing /proc/<pid>/maps files.
>  		Can be overridden by the --proc-map-timeout option on supported
> diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
> index e9f084db0802..1b7f66ece570 100644
> --- a/tools/perf/util/addr2line.c
> +++ b/tools/perf/util/addr2line.c
> @@ -18,9 +18,6 @@
>  
>  #define MAX_INLINE_NEST 1024
>  
> -/* If addr2line doesn't return data for 5 seconds then timeout. */
> -int addr2line_timeout_ms = 5 * 1000;
> -
>  static int filename_split(char *filename, unsigned int *line_nr)
>  {
>  	char *sep;
> @@ -87,6 +84,9 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
>  		return NULL;
>  	}
>  
> +	if (!symbol_conf.addr2line_timeout_ms)
> +		symbol_conf.addr2line_timeout_ms = 5 * 1000;

As I said before, you can put it in the util/symbol.c.

Thanks,
Namhyung

> +
>  	return a2l;
>  }
>  
> @@ -335,7 +335,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>  		goto out;
>  	}
>  	io__init(&io, a2l->out, buf, sizeof(buf));
> -	io.timeout_ms = addr2line_timeout_ms;
> +	io.timeout_ms = symbol_conf.addr2line_timeout_ms;
>  	switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, addr, /*first=*/true,
>  				      &record_function, &record_filename, &record_line_nr)) {
>  	case -1:
> diff --git a/tools/perf/util/addr2line.h b/tools/perf/util/addr2line.h
> index d35a47ba8dab..75989a92f16b 100644
> --- a/tools/perf/util/addr2line.h
> +++ b/tools/perf/util/addr2line.h
> @@ -8,8 +8,6 @@ struct dso;
>  struct inline_node;
>  struct symbol;
>  
> -extern int addr2line_timeout_ms;
> -
>  int cmd__addr2line(const char *dso_name, u64 addr,
>  		   char **file, unsigned int *line_nr,
>  		   struct dso *dso,
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 31541e03aab7..573b3a3f5999 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -19,7 +19,6 @@
>  #include "util/hist.h"  /* perf_hist_config */
>  #include "util/stat.h"  /* perf_stat__set_big_num */
>  #include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
> -#include "util/addr2line.h"  /* addr2line_timeout_ms */
>  #include "srcline.h"
>  #include "build-id.h"
>  #include "debug.h"
> @@ -459,7 +458,7 @@ static int perf_default_core_config(const char *var, const char *value)
>  		proc_map_timeout = strtoul(value, NULL, 10);
>  
>  	if (!strcmp(var, "core.addr2line-timeout"))
> -		addr2line_timeout_ms = strtoul(value, NULL, 10);
> +		symbol_conf.addr2line_timeout_ms = strtoul(value, NULL, 10);
>  
>  	if (!strcmp(var, "core.addr2line-disable-warn"))
>  		symbol_conf.addr2line_disable_warn = strtoul(value, NULL, 10);
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index 21a1f096d4f0..6cd454d7c98e 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -80,6 +80,7 @@ struct symbol_conf {
>  			*bt_stop_list_str;
>  	const char		*addr2line_path;
>  	enum a2l_style	addr2line_style[MAX_A2L_STYLE];
> +	int             addr2line_timeout_ms;
>  	unsigned long	time_quantum;
>         struct strlist	*dso_list,
>  			*comm_list,
> -- 
> 2.53.0
> 
