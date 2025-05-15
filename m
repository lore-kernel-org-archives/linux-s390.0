Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3F21ADA4;
	Thu, 15 May 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747325460; cv=none; b=fbUUHow/VvQYryVSxU6pmO2pFvN6gMkGQxoiaAD7Oxg6oLeyZ+wuVRW0iPj6LhbB5fXaE8V3QpVNyB8F5SImDXFxJnLGUkXHxr/0MOFo7wj3Dje0VqcQrHZLWgUDVvQ7Ef96XC98uIUoAcM1y+gvAwkPaaL9XMx2oe13BfWmBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747325460; c=relaxed/simple;
	bh=Zs+kT9HDfhVkzbH18VsQ2/h6ip1U/R/ygxgJShA10d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDpMgy9tR1gTuHKYdooL+O+K1veOxvSLU+HBmBTB09chuhTXOi44q+6qNaFD19pimh+qH+TxHwq0nksudgTMFImtXIfDWA68BfmE3OeGbDtIg+8bBUMq5u5hptrkO5XuXiggVnZgDv2efU3thFhwH6IVsSwtbLhodTEkuwrFKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOtk7DTM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOtk7DTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AA3C4CEE7;
	Thu, 15 May 2025 16:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747325459;
	bh=Zs+kT9HDfhVkzbH18VsQ2/h6ip1U/R/ygxgJShA10d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOtk7DTMkK2nZtL92Utb0ccQSvWIX05QfUbJFPaXZIqAwaPNdxfUsKijAWFvDMRbz
	 a4Z8sNY8QO/0pEa77u2UY7RS+eXomKrS3FuG7IZDI6W7Ab5Is54RxFpL0HhqMgi+1p
	 MqW3YehlRUV4FKK3xiJdILFQpZVuLkofbtAV6ZUkjRpN1cO11P6DN5oC/9nUzpaRLJ
	 6+fx9c/pangyH8bWwwRHZGLr007WLJlhbTzhmB3d4pf9LuSUL5U1LkhI0jrI7xHJHj
	 UwpgnnGmghE9vJk1l8OuZqW/MIpjf1XTD7G/zCeKqYzHTIHldl6CxvTZxXxWjysHur
	 m5ZR+PEizyMWw==
Date: Thu, 15 May 2025 13:10:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH] perf ftrace: Restore to original trace settings on exit
Message-ID: <aCYSEMrXIwptT0d6@x1>
References: <20250515063407.3025338-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515063407.3025338-1-tmricht@linux.ibm.com>

On Thu, May 15, 2025 at 08:34:07AM +0200, Thomas Richter wrote:
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
 
> The tracing_on file is not restored to its value before the command.
> Fix this behavior and restore the trace setting to what
> is was before the invocation of the command.
> On Fedora 41 and 42 tracing is turned on by default.

This looks fragile as it takes a snapshot in time of what are the files
in some particular directory to save them and then restore it at the
end.

The tool may at some point in the future go and touch other (added in
the future) files in that directory, etc.

I _think_ that instead we should move to use some "session mode" ftrace,
which I _think_ is already available for quite some time, i.e. instead
of touching the global ftrace files (which probably are there for
historical reasons), we should use, lemme find the reference...

I think the keyword to lookup is /sys/kernel/debug/tracing/instances/

Ian did a lot of work on having 'perf test' run shell tests in parallel,
so we need to think about ways of allowing for that by not touching
global state.

tldr; great idea, avoid global state.

- Arnaldo
 
> The root cause is function reset_tracing_files() which
> writes zero (0) into file tracing_on.
> 
> Read tracing files on start of the program and
> restore these values just before exit.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  tools/perf/builtin-ftrace.c | 226 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 226 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 7caa18d5ffc3..11ead75fe0f7 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -299,6 +299,228 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>  	return 0;
>  }
>  
> +static int read_tracing_file(const char *name, char *buf, size_t size)
> +{
> +	int ret = -1;
> +	char *file;
> +	int fd;
> +
> +	file = get_tracing_file(name);
> +	if (!file) {
> +		pr_debug("cannot get tracing file: %s\n", name);
> +		return -1;
> +	}
> +
> +	fd = open(file, O_RDONLY);
> +	if (fd < 0) {
> +		pr_debug("cannot open tracing file: %s: %s\n",
> +			 name, str_error_r(errno, buf, size));
> +		goto out;
> +	}
> +
> +	/* read contents to stdout */
> +	while (true) {
> +		int n = read(fd, buf, size);
> +
> +		if (n == 0)
> +			break;
> +		else if (n < 0)
> +			goto out_close;
> +		buf += n;
> +		size -= n;
> +	}
> +	ret = 0;
> +
> +out_close:
> +	close(fd);
> +out:
> +	put_tracing_file(file);
> +	return ret;
> +}
> +
> +static int read_tracing_option_file(const char *name, char *val, size_t size)
> +{
> +	char *file;
> +	int ret;
> +
> +	if (asprintf(&file, "options/%s", name) < 0)
> +		return -1;
> +
> +	ret = read_tracing_file(file, val, size);
> +	free(file);
> +	return ret;
> +}
> +
> +/*
> + * Save the initial trace file setting to restore them after the tests.
> + * This ensures the setting are the same as before the invocation
> + * of the program.
> + */
> +static struct trace_file_list {		/* List of tracing files */
> +	const char *filename;		/* File name */
> +	char *contents;			/* Contents to restore */
> +	int (*read_fct)(const char *fn, char *buf, size_t buf_sz);		/* Read function */
> +	int (*write_fct)(const char *fn, const char *buf);		/* Write function */
> +} trace_file_list[] = {
> +	[0] = {
> +		.filename = "tracing_on",
> +		.read_fct = read_tracing_file,
> +		.write_fct = write_tracing_file,
> +	},
> +	[1] = {
> +		.filename = "current_tracer",
> +		.read_fct = read_tracing_file,
> +		.write_fct = write_tracing_file,
> +	},
> +	[2] = {
> +		.filename = "set_ftrace_pid",
> +		.read_fct = read_tracing_file,
> +		.write_fct = write_tracing_file,
> +	},
> +	[3] = {
> +		.write_fct = write_tracing_file,
> +		.read_fct = read_tracing_file,
> +		.filename = "max_graph_depth",
> +	},
> +	[4] = {
> +		.filename = "tracing_thresh",
> +		.read_fct = read_tracing_file,
> +		.write_fct = write_tracing_file,
> +	},
> +	[5] = {
> +		.filename = "tracing_cpumask",
> +		.read_fct = read_tracing_file,
> +		.write_fct = write_tracing_file,
> +	},
> +	[6] = {
> +		.filename = "set_ftrace_filter",
> +		.read_fct = read_tracing_file,
> +		.write_fct = write_tracing_file,
> +	},
> +	[7] = {
> +		.filename = "set_ftrace_notrace",
> +		.read_fct = read_tracing_file,
> +		.write_fct = write_tracing_file,
> +	},
> +	[8] = {
> +		.filename = "set_graph_function",
> +		.read_fct = read_tracing_file,
> +		.write_fct = write_tracing_file,
> +	},
> +	[9] = {
> +		.filename = "set_graph_notrace",
> +		.read_fct = read_tracing_file,
> +		.write_fct = write_tracing_file,
> +	},
> +			/* Files in .../options/ directory */
> +	[10] = {
> +		.filename = "function-fork",
> +		.read_fct = read_tracing_option_file,
> +		.write_fct = write_tracing_option_file,
> +	},
> +	[11] = {
> +		.filename = "func_stack_trace",
> +		.read_fct = read_tracing_option_file,
> +		.write_fct = write_tracing_option_file,
> +	},
> +	[12] = {
> +		.filename = "sleep-time",
> +		.read_fct = read_tracing_option_file,
> +		.write_fct = write_tracing_option_file,
> +	},
> +	[13] = {
> +		.filename = "funcgraph-irqs",
> +		.read_fct = read_tracing_option_file,
> +		.write_fct = write_tracing_option_file,
> +	},
> +	[14] = {
> +		.filename = "funcgraph-proc",
> +		.read_fct = read_tracing_option_file,
> +		.write_fct = write_tracing_option_file,
> +	},
> +	[15] = {
> +		.filename = "funcgraph-abstime",
> +		.read_fct = read_tracing_option_file,
> +		.write_fct = write_tracing_option_file,
> +	},
> +	[16] = {
> +		.filename = "funcgraph-tail",
> +		.read_fct = read_tracing_option_file,
> +		.write_fct = write_tracing_option_file,
> +	},
> +	[17] = {
> +		.filename = "latency-format",
> +		.read_fct = read_tracing_option_file,
> +		.write_fct = write_tracing_option_file,
> +	},
> +	[18] = {
> +		.filename = "irq-info",
> +		.read_fct = read_tracing_option_file,
> +		.write_fct = write_tracing_option_file,
> +	},
> +};
> +
> +static void free_tracing_content(void)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(trace_file_list); ++i)
> +		zfree(&trace_file_list[i].contents);
> +}
> +
> +/*
> + * Return a copy of the input string.
> + * Remove a trailing newline. It will be appended in the write
> + * function when values are restored before program termination.
> + * Change "no pid" or comment sign '#' at the beginning and replace it
> + * by an empty string. This resets to the default behavior indicated
> + * by the output. Those strings are not accepted as file input.
> + */
> +static char *copy_tracing_file(char *buf)
> +{
> +	char *c = strrchr(buf, '\n');
> +
> +	if (c)
> +		*c = '\0';
> +	if (*buf == '#' || !strncmp(buf, "no pid", 6))
> +		*buf = '\0';
> +	return strdup(buf);
> +}
> +
> +static int save_tracing_files(void)
> +{
> +	char buf[4096];
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(trace_file_list); ++i) {
> +		struct trace_file_list *tp = &trace_file_list[i];
> +
> +		memset(buf, 0, sizeof(buf));
> +		if ((*tp->read_fct)(tp->filename, buf, sizeof(buf)) < 0)
> +			goto out;
> +		tp->contents = copy_tracing_file(buf);
> +		if (!tp->contents)
> +			goto out;
> +	}
> +	return 0;
> +
> +out:
> +	free_tracing_content();
> +	return -1;
> +}
> +
> +static void restore_tracing_files(void)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(trace_file_list); ++i) {
> +		struct trace_file_list *tp = &trace_file_list[i];
> +
> +		(*tp->write_fct)(tp->filename, tp->contents);
> +	}
> +	free_tracing_content();
> +}
> +
>  static int set_tracing_pid(struct perf_ftrace *ftrace)
>  {
>  	int i;
> @@ -1687,6 +1909,9 @@ int cmd_ftrace(int argc, const char **argv)
>  	};
>  	enum perf_ftrace_subcommand subcmd = PERF_FTRACE_NONE;
>  
> +	if (save_tracing_files())
> +		return -1;
> +
>  	INIT_LIST_HEAD(&ftrace.filters);
>  	INIT_LIST_HEAD(&ftrace.notrace);
>  	INIT_LIST_HEAD(&ftrace.graph_funcs);
> @@ -1839,5 +2064,6 @@ int cmd_ftrace(int argc, const char **argv)
>  	delete_filter_func(&ftrace.graph_funcs);
>  	delete_filter_func(&ftrace.nograph_funcs);
>  
> +	restore_tracing_files();
>  	return ret;
>  }
> -- 
> 2.49.0
