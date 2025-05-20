Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F4BE5E;
	Tue, 20 May 2025 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774699; cv=none; b=rFolH3+65iApjASc4IfphjgNFazoK619ZlhZausofvqgY+tm0XSUA1BZOCX68lDuqFarTpZ6ITgDiKykKettrnPgzpQpLd4pW3K19GpBGsT0lprX4IFqsunSYuXcEgGDQ+/kUzUt5xy5fXDmP6m+s1NMADMZEnvAT+nTDc5YtTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774699; c=relaxed/simple;
	bh=vjBOBT2RpUdaxCZk0wTsxRrqGDPLiEQBWGYV9BYr3W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/Rb+rE2+qHIyWP1bncvtLLST867CaKZMiRxT0G3XTu28Vx3fUJa+VJP/ILA/MttN6slTPMG9E8tABP7/idsfzZTIhCRkOTB7XNQkMwW7ELbNqiUqhpbHias9MPHZYQCb5i9jrC7TYc/iW4xTrg7ZFPkppKuPNVKKWJ7efl/ua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPnTrowE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPnTrowE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FEDC4CEE9;
	Tue, 20 May 2025 20:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747774696;
	bh=vjBOBT2RpUdaxCZk0wTsxRrqGDPLiEQBWGYV9BYr3W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPnTrowEu3n+/nxVmwYGOFqfG2CO/onOWj8MOS98sC15GSYCn2f8ZLb9x88c7aAop
	 GBKoyA1aTeC9eBco3aIg5nA+kPu4USUamTMVB9ahuX9GXU1KcYxF43dienJ1NC4HwU
	 q+pkc72LW1AA0R1z3JOqK1DxcF3ms4cY80GgTqkmpUGj/JRcXVwOEOheQjKay2FMsF
	 XRWEYh+GqedcnDqLKRtwRWYyC9UJKaYJL9dN+g9KSup/xFRJOUTXy1teJ8RMzx81t4
	 NLweQ4tcJmREm/Zzdq+byUBclkjMjjWGWxC7OpgsgPmuiTD8O6yzgyR2iJPYtZTptc
	 LmZXDXeqjc9VA==
Date: Tue, 20 May 2025 17:58:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH V3] perf ftrace: Use process/session specific trace
 settings
Message-ID: <aCzs4ZP1tIPkbD9N@x1>
References: <20250520093726.2009696-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520093726.2009696-1-tmricht@linux.ibm.com>

On Tue, May 20, 2025 at 11:37:26AM +0200, Thomas Richter wrote:
> V2 --> V3: Use Arnaldo's proposal for the commit message.
>            Add Namhyung's review comments.
> V1 --> V2: Add Suggestion from Arnaldo Cavalho de Melo confirmed by
>            Steven Rostedt. Use rmdir(../tracing/instances/dir) to stop
> 	   process/session specific tracing and delete all
> 	   process/session specific setings.

I added it to my branch, will do more tests later together with the
other patches in tmp.perf-tools-next and barring more reviewing comments
to address, push it out for testing in linux-next.

Thanks,

- Arnaldo
 
> Executing 'perf ftrace' commands 'ftrace', 'profile' and 'latency' leave
> tracing disabled as can seen in this output:
> 
>  # echo 1 > /sys/kernel/debug/tracing/tracing_on
>  # cat /sys/kernel/debug/tracing/tracing_on
>  1
>  # perf ftrace trace --graph-opts depth=5 sleep 0.1 > /dev/null
>  # cat /sys/kernel/debug/tracing/tracing_on
>  0
>  #
> 
> The 'tracing_on' file is not restored to its value before the command.
> 
> To fix that this patch uses the .../tracing/instances/XXX subdirectory
> feature.
> 
> Each 'perf ftrace' invocation creates its own session/process
> specific subdirectory and does not change the global state
> in the .../tracing directory itself.
> 
> Use rmdir(../tracing/instances/dir) to stop process/session specific
> tracing and delete all process/session specific setings.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  tools/perf/builtin-ftrace.c | 101 +++++++++++++++++++++++++++++++-----
>  1 file changed, 87 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 7caa18d5ffc3..bba36ebc2aa7 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -19,6 +19,7 @@
>  #include <ctype.h>
>  #include <linux/capability.h>
>  #include <linux/string.h>
> +#include <sys/stat.h>
>  
>  #include "debug.h"
>  #include <subcmd/pager.h>
> @@ -45,6 +46,8 @@ static volatile sig_atomic_t done;
>  
>  static struct stats latency_stats;  /* for tracepoints */
>  
> +static char tracing_instance[PATH_MAX];	/* Trace instance directory */
> +
>  static void sig_handler(int sig __maybe_unused)
>  {
>  	done = true;
> @@ -100,6 +103,34 @@ static bool is_ftrace_supported(void)
>  	return supported;
>  }
>  
> +/*
> + * Wrapper to test if a file in directory .../tracing/instances/XXX
> + * exists. If so return the .../tracing/instances/XXX file for use.
> + * Otherwise the file exists only in directory .../tracing and
> + * is applicable to all instances, for example file available_filter_functions.
> + * Return that file name in this case.
> + *
> + * This functions works similar to get_tracing_file() and expects its caller
> + * to free the returned file name.
> + *
> + * The global variable tracing_instance is set in init_tracing_instance()
> + * called at the  beginning to a process specific tracing subdirectory.
> + */
> +static char *get_tracing_instance_file(const char *name)
> +{
> +	char *file;
> +
> +	if (asprintf(&file, "%s/%s", tracing_instance, name) < 0)
> +		return NULL;
> +
> +	if (!access(file, F_OK))
> +		return file;
> +
> +	free(file);
> +	file = get_tracing_file(name);
> +	return file;
> +}
> +
>  static int __write_tracing_file(const char *name, const char *val, bool append)
>  {
>  	char *file;
> @@ -109,7 +140,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
>  	char errbuf[512];
>  	char *val_copy;
>  
> -	file = get_tracing_file(name);
> +	file = get_tracing_instance_file(name);
>  	if (!file) {
>  		pr_debug("cannot get tracing file: %s\n", name);
>  		return -1;
> @@ -167,7 +198,7 @@ static int read_tracing_file_to_stdout(const char *name)
>  	int fd;
>  	int ret = -1;
>  
> -	file = get_tracing_file(name);
> +	file = get_tracing_instance_file(name);
>  	if (!file) {
>  		pr_debug("cannot get tracing file: %s\n", name);
>  		return -1;
> @@ -209,7 +240,7 @@ static int read_tracing_file_by_line(const char *name,
>  	char *file;
>  	FILE *fp;
>  
> -	file = get_tracing_file(name);
> +	file = get_tracing_instance_file(name);
>  	if (!file) {
>  		pr_debug("cannot get tracing file: %s\n", name);
>  		return -1;
> @@ -299,6 +330,39 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>  	return 0;
>  }
>  
> +/* Remove .../tracing/instances/XXX subdirectory created with
> + * init_tracing_instance().
> + */
> +static void exit_tracing_instance(void)
> +{
> +	if (rmdir(tracing_instance))
> +		pr_err("failed to delete tracing/instances directory\n");
> +}
> +
> +/* Create subdirectory within .../tracing/instances/XXX to have session
> + * or process specific setup. To delete this setup, simply remove the
> + * subdirectory.
> + */
> +static int init_tracing_instance(void)
> +{
> +	char dirname[] = "instances/perf-ftrace-XXXXXX";
> +	char *path;
> +
> +	path = get_tracing_file(dirname);
> +	if (!path)
> +		goto error;
> +	strncpy(tracing_instance, path, sizeof(tracing_instance) - 1);
> +	put_tracing_file(path);
> +	path = mkdtemp(tracing_instance);
> +	if (!path)
> +		goto error;
> +	return 0;
> +
> +error:
> +	pr_err("failed to create tracing/instances directory\n");
> +	return -1;
> +}
> +
>  static int set_tracing_pid(struct perf_ftrace *ftrace)
>  {
>  	int i;
> @@ -629,14 +693,17 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  
>  	select_tracer(ftrace);
>  
> +	if (init_tracing_instance() < 0)
> +		goto out;
> +
>  	if (reset_tracing_files(ftrace) < 0) {
>  		pr_err("failed to reset ftrace\n");
> -		goto out;
> +		goto out_reset;
>  	}
>  
>  	/* reset ftrace buffer */
>  	if (write_tracing_file("trace", "0") < 0)
> -		goto out;
> +		goto out_reset;
>  
>  	if (set_tracing_options(ftrace) < 0)
>  		goto out_reset;
> @@ -648,7 +715,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  
>  	setup_pager();
>  
> -	trace_file = get_tracing_file("trace_pipe");
> +	trace_file = get_tracing_instance_file("trace_pipe");
>  	if (!trace_file) {
>  		pr_err("failed to open trace_pipe\n");
>  		goto out_reset;
> @@ -723,7 +790,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  out_close_fd:
>  	close(trace_fd);
>  out_reset:
> -	reset_tracing_files(ftrace);
> +	exit_tracing_instance();
>  out:
>  	return (done && !workload_exec_errno) ? 0 : -1;
>  }
> @@ -924,6 +991,9 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
>  	if (ftrace->target.use_bpf)
>  		return perf_ftrace__latency_prepare_bpf(ftrace);
>  
> +	if (init_tracing_instance() < 0)
> +		return -1;
> +
>  	if (reset_tracing_files(ftrace) < 0) {
>  		pr_err("failed to reset ftrace\n");
>  		return -1;
> @@ -942,7 +1012,7 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
>  		return -1;
>  	}
>  
> -	trace_file = get_tracing_file("trace_pipe");
> +	trace_file = get_tracing_instance_file("trace_pipe");
>  	if (!trace_file) {
>  		pr_err("failed to open trace_pipe\n");
>  		return -1;
> @@ -993,7 +1063,7 @@ static int cleanup_func_latency(struct perf_ftrace *ftrace)
>  	if (ftrace->target.use_bpf)
>  		return perf_ftrace__latency_cleanup_bpf(ftrace);
>  
> -	reset_tracing_files(ftrace);
> +	exit_tracing_instance();
>  	return 0;
>  }
>  
> @@ -1304,17 +1374,20 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
>  		goto out;
>  	}
>  
> +	if (init_tracing_instance() < 0)
> +		goto out;
> +
>  	if (reset_tracing_files(ftrace) < 0) {
>  		pr_err("failed to reset ftrace\n");
> -		goto out;
> +		goto out_reset;
>  	}
>  
>  	/* reset ftrace buffer */
>  	if (write_tracing_file("trace", "0") < 0)
> -		goto out;
> +		goto out_reset;
>  
>  	if (set_tracing_options(ftrace) < 0)
> -		return -1;
> +		goto out_reset;
>  
>  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
>  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
> @@ -1323,7 +1396,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
>  
>  	setup_pager();
>  
> -	trace_file = get_tracing_file("trace_pipe");
> +	trace_file = get_tracing_instance_file("trace_pipe");
>  	if (!trace_file) {
>  		pr_err("failed to open trace_pipe\n");
>  		goto out_reset;
> @@ -1385,7 +1458,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
>  out_close_fd:
>  	close(trace_fd);
>  out_reset:
> -	reset_tracing_files(ftrace);
> +	exit_tracing_instance();
>  out:
>  	return (done && !workload_exec_errno) ? 0 : -1;
>  }
> -- 
> 2.49.0
> 
