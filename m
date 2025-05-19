Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDDA22B8A9;
	Mon, 19 May 2025 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689750; cv=none; b=q8Sm2g4djrvhxwnp71s9Mpo0t7pbtkTtS+8sMyDJwCV6KzihozbiHX75wqzrtgQeAPJ/ABDML0+Um1ApOnSogZyj9KtoJ/Wd27L3y/bmFmfLWxbrrbEn+9E88QZ2CV8z6OAvplxzPMrPrdYRX8/ja3qwJPQigaDGHBNTCXTvork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689750; c=relaxed/simple;
	bh=J0BlCamg5o6rjixyQoVYTi6MUMronxaa7LD88b00Oz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsCN5To9mllNNwjfivm+lq23yZtDL2tKY088DeqprUSButukJcEHaM1izaALBO6+XMLC4wuPqZEhX+wfElAEZ8A8BWWYrmpx886wEm9uD221nH+dxKvlVgvCDUIbRjJOIeK3Bgt1rO2uu3Skqm6R26RCQXqqk1+Cr3Y8wGozo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxko3O6M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxko3O6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3CAC4CEE9;
	Mon, 19 May 2025 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689749;
	bh=J0BlCamg5o6rjixyQoVYTi6MUMronxaa7LD88b00Oz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gxko3O6MFzH1MF+E9CFihuydLjsb6AZM2vNDWfVjuBFZJpVBgCGA4hqI5eQJ8ixRD
	 VZNprab2t5YXQhWlEeyf8rAW72rb7mnaps+q30mp/X4bwv5o+/0grr+j+SGI0ipcR6
	 vue1lBdSsQtOvz4C2tJg+D9hxowig2Bjs9iOXIq/5GCP7MvO31Td0TxwiF5h2rXS6m
	 Rf0TA1WLr9l4yaAg/Qh3BaeGxClCDzYyLBf8OLWOY3k/+nXUPEcfs3qWF21AFPPPGE
	 ReIquJGGND2s/dlLR+qKJZNNOVtTeldwxBYXcEmghec01sxDGdeDJVk2FjI7D3e/g7
	 F6v5luShInlSQ==
Date: Mon, 19 May 2025 18:22:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH v2] perf ftrace: Use process/session specific trace
 settings
Message-ID: <aCufoLXkMjjwGt0a@x1>
References: <20250519145235.56006-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519145235.56006-1-tmricht@linux.ibm.com>

On Mon, May 19, 2025 at 04:52:35PM +0200, Thomas Richter wrote:
> V1 --> V2: Add Suggestion from Arnaldo Cavalho de Melo confirmed by
>            Steven Rostedt. Use rmdir(../tracing/instances/dir) to stop
> 	   process/session specific tracing and delete all 
> 	   process/session specific setings.
> 
> Executing perf ftrace commands ftrace, profile and latency
> leave tracing disabled as can seen in this output:
> 
>  # echo 1 > /sys/kernel/debug/tracing/tracing_on
>  # cat /sys/kernel/debug/tracing/tracing_on
>  1
>  # perf ftrace trace --graph-opts depth=5 sleep 0.1 > /dev/null
>  # cat /sys/kernel/debug/tracing/tracing_on
>  0
>  #
> 
> The tracing_on file is not restored to its value before the command.
> Fix this behavior and restore the trace setting to what
> is was before the invocation of the command.

The above paragraph doesn't apply after you moved to instances, right?

I changed the commit log message to:

----------------------
perf ftrace: Use process/session specific trace settings

Executing 'perf ftrace' commands 'ftrace', 'profile' and 'latency' leave
tracing disabled as can seen in this output:

 # echo 1 > /sys/kernel/debug/tracing/tracing_on
 # cat /sys/kernel/debug/tracing/tracing_on
 1
 # perf ftrace trace --graph-opts depth=5 sleep 0.1 > /dev/null
 # cat /sys/kernel/debug/tracing/tracing_on
 0
 #

The 'tracing_on' file is not restored to its value before the command.

To fix that this patch uses the .../tracing/instances/XXX subdirectory
feature.

Each 'perf ftrace' invocation creates its own session/process
specific subdirectory and does not change the global state
in the .../tracing directory itself.

Use rmdir(../tracing/instances/dir) to stop process/session specific
tracing and delete all process/session specific setings.

-----------

followed by the tags you provided, ok?

- Arnaldo

> On Fedora 41 and 42 tracing is turned on by default.
> 
> This patch use the .../tracing/instances/XXX subdirectory feature.
> Each perf ftrace invocation creates its own session/process
> specific subdirectory and does not change the global state
> in the .../tracing directory itself.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  tools/perf/builtin-ftrace.c | 105 +++++++++++++++++++++++++++++++-----
>  1 file changed, 91 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 7caa18d5ffc3..3faf96e7185e 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -38,6 +38,8 @@
>  #include "util/units.h"
>  #include "util/parse-sublevel-options.h"
>  
> +#include <sys/stat.h>
> +
>  #define DEFAULT_TRACER  "function_graph"
>  
>  static volatile sig_atomic_t workload_exec_errno;
> @@ -45,6 +47,8 @@ static volatile sig_atomic_t done;
>  
>  static struct stats latency_stats;  /* for tracepoints */
>  
> +static char tracing_instance[PATH_MAX];	/* Trace instance directory */
> +
>  static void sig_handler(int sig __maybe_unused)
>  {
>  	done = true;
> @@ -100,6 +104,34 @@ static bool is_ftrace_supported(void)
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
> + * called a the  beginning to a process specific tracing subdirectory.
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
> +	put_tracing_file(file);
> +	file = get_tracing_file(name);
> +	return file;
> +}
> +
>  static int __write_tracing_file(const char *name, const char *val, bool append)
>  {
>  	char *file;
> @@ -109,7 +141,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
>  	char errbuf[512];
>  	char *val_copy;
>  
> -	file = get_tracing_file(name);
> +	file = get_tracing_instance_file(name);
>  	if (!file) {
>  		pr_debug("cannot get tracing file: %s\n", name);
>  		return -1;
> @@ -167,7 +199,7 @@ static int read_tracing_file_to_stdout(const char *name)
>  	int fd;
>  	int ret = -1;
>  
> -	file = get_tracing_file(name);
> +	file = get_tracing_instance_file(name);
>  	if (!file) {
>  		pr_debug("cannot get tracing file: %s\n", name);
>  		return -1;
> @@ -209,7 +241,7 @@ static int read_tracing_file_by_line(const char *name,
>  	char *file;
>  	FILE *fp;
>  
> -	file = get_tracing_file(name);
> +	file = get_tracing_instance_file(name);
>  	if (!file) {
>  		pr_debug("cannot get tracing file: %s\n", name);
>  		return -1;
> @@ -299,6 +331,36 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>  	return 0;
>  }
>  
> +/* Remove .../tracing/instances/XXX subdirectory created with
> + * init_tracing_instance().
> + */
> +static void exit_tracing_instance(void)
> +{
> +	rmdir(tracing_instance);
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
> +		return -1;
> +	strcpy(tracing_instance, path);
> +	put_tracing_file(path);
> +	path = mkdtemp(tracing_instance);
> +	if (!path) {
> +		pr_err("failed to create tracing/instances directory\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  static int set_tracing_pid(struct perf_ftrace *ftrace)
>  {
>  	int i;
> @@ -629,14 +691,19 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  
>  	select_tracer(ftrace);
>  
> +	if (init_tracing_instance() < 0) {
> +		pr_err("failed to create tracing/instances\n");
> +		goto out;
> +	}
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
> @@ -924,6 +991,11 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
>  	if (ftrace->target.use_bpf)
>  		return perf_ftrace__latency_prepare_bpf(ftrace);
>  
> +	if (init_tracing_instance() < 0) {
> +		pr_err("failed to create tracing/instances\n");
> +		return -1;
> +	}
> +
>  	if (reset_tracing_files(ftrace) < 0) {
>  		pr_err("failed to reset ftrace\n");
>  		return -1;
> @@ -942,7 +1014,7 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
>  		return -1;
>  	}
>  
> -	trace_file = get_tracing_file("trace_pipe");
> +	trace_file = get_tracing_instance_file("trace_pipe");
>  	if (!trace_file) {
>  		pr_err("failed to open trace_pipe\n");
>  		return -1;
> @@ -993,7 +1065,7 @@ static int cleanup_func_latency(struct perf_ftrace *ftrace)
>  	if (ftrace->target.use_bpf)
>  		return perf_ftrace__latency_cleanup_bpf(ftrace);
>  
> -	reset_tracing_files(ftrace);
> +	exit_tracing_instance();
>  	return 0;
>  }
>  
> @@ -1304,17 +1376,22 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
>  		goto out;
>  	}
>  
> +	if (init_tracing_instance() < 0) {
> +		pr_err("failed to create tracing/instances\n");
> +		goto out;
> +	}
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
> @@ -1323,7 +1400,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
>  
>  	setup_pager();
>  
> -	trace_file = get_tracing_file("trace_pipe");
> +	trace_file = get_tracing_instance_file("trace_pipe");
>  	if (!trace_file) {
>  		pr_err("failed to open trace_pipe\n");
>  		goto out_reset;
> @@ -1385,7 +1462,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
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
