Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8B225D6;
	Mon, 19 May 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690051; cv=none; b=U0do8nkOk6nnJSW2aDpQ/ektjD+pLvPap9eXiIXooCavItZD7x24u38fSlCmKS9PNnbFRtIM/KU8w/DKYQSwp49+4LkObtUpJbdcIhKVWo+r/1Q83bMWt6XfiT1ny+Y7ZjykPzDoUr8WoiQ+VSMCZ00FHnIPEHuLLGNl5HTJKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690051; c=relaxed/simple;
	bh=9SmNWdQf8/ompwUiTzTLZj1+N5xmudbKnCSJF1O551w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxngVnHwDX+kDHD2BdiypQLmygC9cUAMHA8F6QAh43qI5YT8HvCx9W7kTonVGvEgzf8uhc1II9YO/msjEls4Bx6lncssKh99e5wYWhTiI4lfb28LApgrmH8HJXqwqTnEMxHAKVBumWeIYYbPIuutpidHWM/XILn1XU6Z9WsqRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjG8WdYc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjG8WdYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC84C4CEE4;
	Mon, 19 May 2025 21:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690050;
	bh=9SmNWdQf8/ompwUiTzTLZj1+N5xmudbKnCSJF1O551w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjG8WdYcTWN60BPWEhn0tLF4XFBjzusqZdbJGQQcg5dMI206SUolDFmlY8jlUsHaj
	 BK3WG9T7sIb6HxBbQY0Sq7sy8tmxbM+1jLIE2TXfGKwK3JaMYJX06L8eGUtlR4rv3z
	 oj2CPNRUfF8rZUsMabLaumo9Iu+ZyYLHQitJrDS2Hx3pYeepM3vUQwMX5t2mHmWaGC
	 a/pZEAA5Nmz9slcOWY2T02f1fuCynBhoX3YEgJEr/nPnnaez7zb6QV1MfwPdHE6lB9
	 HwcyqHh0MIowv26lFqjH0C0XmgKtpVGqdmC+PbJZ7q3Mjmng1F6YvbbpYwg7SYXhls
	 g7ewOyFvIJScw==
Date: Mon, 19 May 2025 18:27:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH v2] perf ftrace: Use process/session specific trace
 settings
Message-ID: <aCuiP0qB1WbMnPcb@x1>
References: <20250519145235.56006-1-tmricht@linux.ibm.com>
 <aCufoLXkMjjwGt0a@x1>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCufoLXkMjjwGt0a@x1>

On Mon, May 19, 2025 at 06:22:30PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 19, 2025 at 04:52:35PM +0200, Thomas Richter wrote:
> > V1 --> V2: Add Suggestion from Arnaldo Cavalho de Melo confirmed by
> >            Steven Rostedt. Use rmdir(../tracing/instances/dir) to stop
> > 	   process/session specific tracing and delete all 
> > 	   process/session specific setings.

Namhyung,

	I tested this and think it is working as advertised now and
followed the suggestions provided during review, are you ok with it?

Now it does:

root@number:~# perf trace -e open*,write,*dir perf ftrace latency -T schedule sleep 1
<SNIP>
   9.168 ( 3.540 ms): perf/76257 mkdir(pathname: "/sys/kernel/tracing/instances/perf-ftrace-nCYgxe", mode: IRWXU) = 0
    12.717 ( 0.007 ms): perf/76257 openat(dfd: CWD, filename: "/sys/kernel/tracing/instances/perf-ftrace-nCYgxe/tracing_on", flags: TRUNC|WRONLY) = 3
    12.725 ( 0.019 ms): perf/76257 write(fd: 3, buf: 0\10, count: 2)                                     = 2
    12.747 ( 0.002 ms): perf/76257 openat(dfd: CWD, filename: "/sys/kernel/tracing/instances/perf-ftrace-nCYgxe/current_tracer", flags: TRUNC|WRONLY) = 3
    12.749 ( 0.002 ms): perf/76257 write(fd: 3, buf: nop\10, count: 4)                                   = 4
    12.752 ( 0.003 ms): perf/76257 openat(dfd: CWD, filename: "/sys/kernel/tracing/instances/perf-ftrace-nCYgxe/set_ftrace_pid", flags: TRUNC|WRONLY) = 3
    12.756 ( 0.019 ms): perf/76257 write(fd: 3, buf:  \10, count: 2)                                     = 2
    12.784 ( 0.005 ms): perf/76257 openat(dfd: CWD, filename: "/sys/devices/system/cpu/online")          = 3
<SNIP more ftrace setup using an instance>
  1943.702 ( 0.002 ms): perf/76257 write(fd: 1, buf: \10# statistics  (in usec)\10, count: 25)           = 25
  1943.707 ( 0.002 ms): perf/76257 write(fd: 1, buf:   total time:              10000, count: 35)        = 35
  1943.710 ( 0.003 ms): perf/76257 write(fd: 1, buf:     avg time:              10000, count: 35)        = 35
  1943.714 ( 0.003 ms): perf/76257 write(fd: 1, buf:     max time:              10000, count: 35)        = 35
  1943.718 ( 0.002 ms): perf/76257 write(fd: 1, buf:     min time:              10000, count: 35)        = 35
  1943.721 ( 0.001 ms): perf/76257 write(fd: 1, buf:        count:                   , count: 35)        = 35
  1943.729 (48.859 ms): perf/76257 rmdir(pathname: "/sys/kernel/tracing/instances/perf-ftrace-nCYgxe")   = 0
root@number:~# 

- Arnaldo

> > Executing perf ftrace commands ftrace, profile and latency
> > leave tracing disabled as can seen in this output:
> > 
> >  # echo 1 > /sys/kernel/debug/tracing/tracing_on
> >  # cat /sys/kernel/debug/tracing/tracing_on
> >  1
> >  # perf ftrace trace --graph-opts depth=5 sleep 0.1 > /dev/null
> >  # cat /sys/kernel/debug/tracing/tracing_on
> >  0
> >  #
> > 
> > The tracing_on file is not restored to its value before the command.
> > Fix this behavior and restore the trace setting to what
> > is was before the invocation of the command.
> 
> The above paragraph doesn't apply after you moved to instances, right?
> 
> I changed the commit log message to:
> 
> ----------------------
> perf ftrace: Use process/session specific trace settings
> 
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
> -----------
> 
> followed by the tags you provided, ok?
> 
> - Arnaldo
> 
> > On Fedora 41 and 42 tracing is turned on by default.
> > 
> > This patch use the .../tracing/instances/XXX subdirectory feature.
> > Each perf ftrace invocation creates its own session/process
> > specific subdirectory and does not change the global state
> > in the .../tracing directory itself.
> > 
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 105 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 91 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 7caa18d5ffc3..3faf96e7185e 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -38,6 +38,8 @@
> >  #include "util/units.h"
> >  #include "util/parse-sublevel-options.h"
> >  
> > +#include <sys/stat.h>
> > +
> >  #define DEFAULT_TRACER  "function_graph"
> >  
> >  static volatile sig_atomic_t workload_exec_errno;
> > @@ -45,6 +47,8 @@ static volatile sig_atomic_t done;
> >  
> >  static struct stats latency_stats;  /* for tracepoints */
> >  
> > +static char tracing_instance[PATH_MAX];	/* Trace instance directory */
> > +
> >  static void sig_handler(int sig __maybe_unused)
> >  {
> >  	done = true;
> > @@ -100,6 +104,34 @@ static bool is_ftrace_supported(void)
> >  	return supported;
> >  }
> >  
> > +/*
> > + * Wrapper to test if a file in directory .../tracing/instances/XXX
> > + * exists. If so return the .../tracing/instances/XXX file for use.
> > + * Otherwise the file exists only in directory .../tracing and
> > + * is applicable to all instances, for example file available_filter_functions.
> > + * Return that file name in this case.
> > + *
> > + * This functions works similar to get_tracing_file() and expects its caller
> > + * to free the returned file name.
> > + *
> > + * The global variable tracing_instance is set in init_tracing_instance()
> > + * called a the  beginning to a process specific tracing subdirectory.
> > + */
> > +static char *get_tracing_instance_file(const char *name)
> > +{
> > +	char *file;
> > +
> > +	if (asprintf(&file, "%s/%s", tracing_instance, name) < 0)
> > +		return NULL;
> > +
> > +	if (!access(file, F_OK))
> > +		return file;
> > +
> > +	put_tracing_file(file);
> > +	file = get_tracing_file(name);
> > +	return file;
> > +}
> > +
> >  static int __write_tracing_file(const char *name, const char *val, bool append)
> >  {
> >  	char *file;
> > @@ -109,7 +141,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
> >  	char errbuf[512];
> >  	char *val_copy;
> >  
> > -	file = get_tracing_file(name);
> > +	file = get_tracing_instance_file(name);
> >  	if (!file) {
> >  		pr_debug("cannot get tracing file: %s\n", name);
> >  		return -1;
> > @@ -167,7 +199,7 @@ static int read_tracing_file_to_stdout(const char *name)
> >  	int fd;
> >  	int ret = -1;
> >  
> > -	file = get_tracing_file(name);
> > +	file = get_tracing_instance_file(name);
> >  	if (!file) {
> >  		pr_debug("cannot get tracing file: %s\n", name);
> >  		return -1;
> > @@ -209,7 +241,7 @@ static int read_tracing_file_by_line(const char *name,
> >  	char *file;
> >  	FILE *fp;
> >  
> > -	file = get_tracing_file(name);
> > +	file = get_tracing_instance_file(name);
> >  	if (!file) {
> >  		pr_debug("cannot get tracing file: %s\n", name);
> >  		return -1;
> > @@ -299,6 +331,36 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
> >  	return 0;
> >  }
> >  
> > +/* Remove .../tracing/instances/XXX subdirectory created with
> > + * init_tracing_instance().
> > + */
> > +static void exit_tracing_instance(void)
> > +{
> > +	rmdir(tracing_instance);
> > +}
> > +
> > +/* Create subdirectory within .../tracing/instances/XXX to have session
> > + * or process specific setup. To delete this setup, simply remove the
> > + * subdirectory.
> > + */
> > +static int init_tracing_instance(void)
> > +{
> > +	char dirname[] = "instances/perf-ftrace-XXXXXX";
> > +	char *path;
> > +
> > +	path = get_tracing_file(dirname);
> > +	if (!path)
> > +		return -1;
> > +	strcpy(tracing_instance, path);
> > +	put_tracing_file(path);
> > +	path = mkdtemp(tracing_instance);
> > +	if (!path) {
> > +		pr_err("failed to create tracing/instances directory\n");
> > +		return -1;
> > +	}
> > +	return 0;
> > +}
> > +
> >  static int set_tracing_pid(struct perf_ftrace *ftrace)
> >  {
> >  	int i;
> > @@ -629,14 +691,19 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
> >  
> >  	select_tracer(ftrace);
> >  
> > +	if (init_tracing_instance() < 0) {
> > +		pr_err("failed to create tracing/instances\n");
> > +		goto out;
> > +	}
> > +
> >  	if (reset_tracing_files(ftrace) < 0) {
> >  		pr_err("failed to reset ftrace\n");
> > -		goto out;
> > +		goto out_reset;
> >  	}
> >  
> >  	/* reset ftrace buffer */
> >  	if (write_tracing_file("trace", "0") < 0)
> > -		goto out;
> > +		goto out_reset;
> >  
> >  	if (set_tracing_options(ftrace) < 0)
> >  		goto out_reset;
> > @@ -648,7 +715,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
> >  
> >  	setup_pager();
> >  
> > -	trace_file = get_tracing_file("trace_pipe");
> > +	trace_file = get_tracing_instance_file("trace_pipe");
> >  	if (!trace_file) {
> >  		pr_err("failed to open trace_pipe\n");
> >  		goto out_reset;
> > @@ -723,7 +790,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
> >  out_close_fd:
> >  	close(trace_fd);
> >  out_reset:
> > -	reset_tracing_files(ftrace);
> > +	exit_tracing_instance();
> >  out:
> >  	return (done && !workload_exec_errno) ? 0 : -1;
> >  }
> > @@ -924,6 +991,11 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
> >  	if (ftrace->target.use_bpf)
> >  		return perf_ftrace__latency_prepare_bpf(ftrace);
> >  
> > +	if (init_tracing_instance() < 0) {
> > +		pr_err("failed to create tracing/instances\n");
> > +		return -1;
> > +	}
> > +
> >  	if (reset_tracing_files(ftrace) < 0) {
> >  		pr_err("failed to reset ftrace\n");
> >  		return -1;
> > @@ -942,7 +1014,7 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
> >  		return -1;
> >  	}
> >  
> > -	trace_file = get_tracing_file("trace_pipe");
> > +	trace_file = get_tracing_instance_file("trace_pipe");
> >  	if (!trace_file) {
> >  		pr_err("failed to open trace_pipe\n");
> >  		return -1;
> > @@ -993,7 +1065,7 @@ static int cleanup_func_latency(struct perf_ftrace *ftrace)
> >  	if (ftrace->target.use_bpf)
> >  		return perf_ftrace__latency_cleanup_bpf(ftrace);
> >  
> > -	reset_tracing_files(ftrace);
> > +	exit_tracing_instance();
> >  	return 0;
> >  }
> >  
> > @@ -1304,17 +1376,22 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
> >  		goto out;
> >  	}
> >  
> > +	if (init_tracing_instance() < 0) {
> > +		pr_err("failed to create tracing/instances\n");
> > +		goto out;
> > +	}
> > +
> >  	if (reset_tracing_files(ftrace) < 0) {
> >  		pr_err("failed to reset ftrace\n");
> > -		goto out;
> > +		goto out_reset;
> >  	}
> >  
> >  	/* reset ftrace buffer */
> >  	if (write_tracing_file("trace", "0") < 0)
> > -		goto out;
> > +		goto out_reset;
> >  
> >  	if (set_tracing_options(ftrace) < 0)
> > -		return -1;
> > +		goto out_reset;
> >  
> >  	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
> >  		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
> > @@ -1323,7 +1400,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
> >  
> >  	setup_pager();
> >  
> > -	trace_file = get_tracing_file("trace_pipe");
> > +	trace_file = get_tracing_instance_file("trace_pipe");
> >  	if (!trace_file) {
> >  		pr_err("failed to open trace_pipe\n");
> >  		goto out_reset;
> > @@ -1385,7 +1462,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
> >  out_close_fd:
> >  	close(trace_fd);
> >  out_reset:
> > -	reset_tracing_files(ftrace);
> > +	exit_tracing_instance();
> >  out:
> >  	return (done && !workload_exec_errno) ? 0 : -1;
> >  }
> > -- 
> > 2.49.0
