Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DEB3D3B3;
	Thu, 23 Oct 2025 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761256172; cv=none; b=q4mKNpU7e+csDdZNpQkTI/cRA7C3wIKMPVmHBR3n9t0ylJlwLUsQvD3yeZtU1HHzxR9crZN2cvN09UMX7G2V79W1wyterP5rKti7EN+1nU8YUbwYaO4cUX4gCQQXMTNjzNEymMXD8WVIGmhHiw4xCdBt+jNMNQMaCBIkdC8tDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761256172; c=relaxed/simple;
	bh=wDOxZQ8Gop+DTsDQM7SH+b6uxnF3XzCxIS2tKokpfFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaaGmDeunzssidxxdPrDce5iy9vNMwLeKIZ/bcOtGCBMfkznk6CxPCPHElDOScwcZgLc3mDKdmdt8GSTHECKx4CBYo2amZGIax4F6ZnD5o5GbBM5tmauQSFLPOIjCah+ka0JzXGNystCTAA34ET6HqrAjWpxSZualNx+F0Hthv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPmTyuxl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPmTyuxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3497C4CEE7;
	Thu, 23 Oct 2025 21:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761256171;
	bh=wDOxZQ8Gop+DTsDQM7SH+b6uxnF3XzCxIS2tKokpfFg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QPmTyuxl02zrQspR5uGrnQeccVO45UOA4owzzMLQJwGs43ybPd3uIvMjJGb0SFn5K
	 06832/EyWH+OqgCGy6UZ5+BsGqbqTUHX6m3+F7rtiN/dH0MMnx0af/u6QUt1HWeqCm
	 HgFJ+2RnK+UuKRr00+qn7pVqguu/LxuneHw/ZALHHmdmMg/471yBbYC9EGqXmHGybC
	 Bsd4L+hVefcU9Ho83bsFBprNIOdSr4nQXuvtQOjTi5px84JkcVLqHc1teiCpLxTgP7
	 XRE0oNnK5WCnLjZ8qV7x9cYj+6fX3AWhRR3gFCD/zQfXiCnhjaYywKIzx//hdhxfIa
	 JkoilvtdwE8Iw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E87C9CE0928; Thu, 23 Oct 2025 14:49:30 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:49:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Chant <achant@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Francesco Valla <francesco@valla.it>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] init/main.c: Wrap long kernel cmdline when printing
 to logs
Message-ID: <0f93e380-09e1-4440-b514-1964cf38ccc1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>

On Thu, Oct 23, 2025 at 11:33:05AM -0700, Douglas Anderson wrote:
> The kernel cmdline length is allowed to be longer than what printk can
> handle. When this happens the cmdline that's printed to the kernel
> ring buffer at bootup is cutoff and some kernel cmdline options are
> "hidden" from the logs. This undercuts the usefulness of the log
> message.
> 
> Specifically, grepping for COMMAND_LINE_SIZE shows that 2048 is common
> and some architectures even define it as 4096. s390 allows a
> CONFIG-based maximum up to 1MB (though it's not expected that anyone
> will go over the default max of 4096 [1]).
> 
> The maximum message pr_notice() seems to be able to handle (based on
> experiment) is 1021 characters. This appears to be based on the
> current value of PRINTKRB_RECORD_MAX as 1024 and the fact that
> pr_notice() spends 2 characters on the loglevel prefix and we have a
> '\n' at the end.
> 
> While it would be possible to increase the limits of printk() (and
> therefore pr_notice()) somewhat, it doesn't appear possible to
> increase it enough to fully include a 2048-character cmdline without
> breaking userspace. Specifically on at least two tested userspaces
> (ChromeOS plus the Debian-based distro I'm typing this message on) the
> `dmesg` tool reads lines from `/dev/kmsg` in 2047-byte chunks. As per
> `Documentation/ABI/testing/dev-kmsg`:

Thank you again!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

>   Every read() from the opened device node receives one record
>   of the kernel's printk buffer.
>   ...
>   Messages in the record ring buffer get overwritten as whole,
>   there are never partial messages received by read().
> 
> We simply can't fit a 2048-byte cmdline plus the "Kernel command
> line:" prefix plus info about time/log_level/etc in a 2047-byte read.
> 
> The above means that if we want to avoid the truncation we need to do
> some type of wrapping of the cmdline when printing.
> 
> Add wrapping to the printout of the kernel command line. By default,
> the wrapping is set to 1021 characters to avoid breaking anyone, but
> allow wrapping to be set lower by a Kconfig knob
> "CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN". Any tools that are correctly
> parsing the cmdline today (because it is less than 1021 characters)
> will see no difference in their behavior. The format of wrapped output
> is designed to be matched by anyone using "grep" to search for the
> cmdline and also to be easy for tools to handle. Anyone who is sure
> their tools (if any) handle the wrapped format can choose a lower
> wrapping value and have prettier output.
> 
> Setting CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN to -1 fully disables the
> wrapping logic. This means that long command lines will be truncated
> again, but this config could be set if command lines are expected to
> be long and userspace is known not to handle parsing logs with the
> wrapping.
> 
> Wrapping is based on spaces, ignoring quotes. All lines are prefixed
> with "Kernel command line: " and lines that are not the last line have
> a " \" suffix added to them. The prefix and suffix count towards the
> line length for wrapping purposes. The ideal length will be exceeded
> if no appropriate place to wrap is found.
> 
> The wrapping function added here is fairly generic and could be made a
> library function (somewhat like print_hex_dump()) if it's needed
> elsewhere in the kernel. However, having printk() directly incorporate
> this wrapping would be unlikely to be a good idea since it would break
> printouts into more than one record without any obvious common line
> prefix to tie lines together. It would also be extra overhead when, in
> general, kernel log message should simply be kept smaller than 1021
> bytes. For some discussion on this topic, see responses to the v1
> posting of this patch [2].
> 
> [1] https://lore.kernel.org/r/20251021131633.26700Dd6-hca@linux.ibm.com
> [2] https://lore.kernel.org/r/CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> - v1 link: https://lore.kernel.org/r/20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid
> - v2 link: https://lore.kernel.org/r/20251021173939.v2.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid
> 
> NOTE: I _didn't_ add any "max characters printed" to try to handle
> someone on s390 having an absurdly long cmdline after the discussoin
> in v1. If someone truly puts a giant cmdline then it will all be
> printed out to dmesg. If this truly turns out to be a problem for
> someone then it's easy to add a maximum at a later time.
> 
> Changes in v3:
> - Allow setting config to -1 to disable logging.
> - Handle case where prefix len >= wrap len, which just means wrap ASAP.
> - Update Kconfig description to talk about -1 and be more detailed.
> 
> Changes in v2:
> - Much longer commit message after discussion in v1.
> 
>  init/Kconfig | 18 ++++++++++
>  init/main.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index cab3ad28ca49..1e7e82a90813 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1512,6 +1512,24 @@ config BOOT_CONFIG_EMBED_FILE
>  	  This bootconfig will be used if there is no initrd or no other
>  	  bootconfig in the initrd.
>  
> +config CMDLINE_LOG_WRAP_IDEAL_LEN
> +	int "Length to try to wrap the cmdline when logged at boot"
> +	default 1021
> +	range -1 1021
> +	help
> +	  At boot time, the kernel command line is logged to the console.
> +	  The log message will start with the prefix "Kernel command line: ".
> +	  The log message will attempt to be wrapped (split into multiple log
> +	  messages) at spaces based on CMDLINE_LOG_WRAP_IDEAL_LEN characters.
> +	  If wrapping happens, each log message will start with the prefix and
> +	  all but the last message will end with " \". Messages may exceed the
> +	  ideal length if a place to wrap isn't found before the specified
> +	  number of characters.
> +
> +	  A value of -1 disables wrapping, though be warned that the maximum
> +	  length of a log message (1021 characters) may cause the cmdline to
> +	  be truncated.
> +
>  config INITRAMFS_PRESERVE_MTIME
>  	bool "Preserve cpio archive mtimes in initramfs"
>  	depends on BLK_DEV_INITRD
> diff --git a/init/main.c b/init/main.c
> index 07a3116811c5..2c0bdc95ae4e 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -906,6 +906,100 @@ static void __init early_numa_node_init(void)
>  #endif
>  }
>  
> +#define KERNEL_CMDLINE_PREFIX		"Kernel command line: "
> +#define KERNEL_CMDLINE_PREFIX_LEN	(sizeof(KERNEL_CMDLINE_PREFIX) - 1)
> +#define KERNEL_CMDLINE_CONTINUATION	" \\"
> +#define KERNEL_CMDLINE_CONTINUATION_LEN	(sizeof(KERNEL_CMDLINE_CONTINUATION) - 1)
> +
> +#define MIN_CMDLINE_LOG_WRAP_IDEAL_LEN	(KERNEL_CMDLINE_PREFIX_LEN + \
> +					 KERNEL_CMDLINE_CONTINUATION_LEN)
> +#define CMDLINE_LOG_WRAP_IDEAL_LEN	(CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN > \
> +					 MIN_CMDLINE_LOG_WRAP_IDEAL_LEN ? \
> +					 CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN : \
> +					 MIN_CMDLINE_LOG_WRAP_IDEAL_LEN)
> +
> +#define IDEAL_CMDLINE_LEN		(CMDLINE_LOG_WRAP_IDEAL_LEN - KERNEL_CMDLINE_PREFIX_LEN)
> +#define IDEAL_CMDLINE_SPLIT_LEN		(IDEAL_CMDLINE_LEN - KERNEL_CMDLINE_CONTINUATION_LEN)
> +
> +/**
> + * print_kernel_cmdline() - Print the kernel cmdline with wrapping.
> + * @cmdline: The cmdline to print.
> + *
> + * Print the kernel command line, trying to wrap based on the Kconfig knob
> + * CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN.
> + *
> + * Wrapping is based on spaces, ignoring quotes. All lines are prefixed
> + * with "Kernel command line: " and lines that are not the last line have
> + * a " \" suffix added to them. The prefix and suffix count towards the
> + * line length for wrapping purposes. The ideal length will be exceeded
> + * if no appropriate place to wrap is found.
> + *
> + * Example output if CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN is 40:
> + *   Kernel command line: loglevel=7 \
> + *   Kernel command line: init=/sbin/init \
> + *   Kernel command line: root=PARTUUID=8c3efc1a-768b-6642-8d0c-89eb782f19f0/PARTNROFF=1 \
> + *   Kernel command line: rootwait ro \
> + *   Kernel command line: my_quoted_arg="The \
> + *   Kernel command line: quick brown fox \
> + *   Kernel command line: jumps over the \
> + *   Kernel command line: lazy dog."
> + */
> +static void print_kernel_cmdline(const char *cmdline)
> +{
> +	size_t len;
> +
> +	/* Config option of -1 disables wrapping */
> +	if (CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN < 0) {
> +		pr_notice("%s%s\n", KERNEL_CMDLINE_PREFIX, cmdline);
> +		return;
> +	}
> +
> +	len = strlen(cmdline);
> +	while (len > IDEAL_CMDLINE_LEN) {
> +		const char *first_space;
> +		const char *prev_cutoff;
> +		const char *cutoff;
> +		int to_print;
> +		size_t used;
> +
> +		/* Find the last ' ' that wouldn't make the line too long */
> +		prev_cutoff = NULL;
> +		cutoff = cmdline;
> +		while (true) {
> +			cutoff = strchr(cutoff + 1, ' ');
> +			if (!cutoff || cutoff - cmdline > IDEAL_CMDLINE_SPLIT_LEN)
> +				break;
> +			prev_cutoff = cutoff;
> +		}
> +		if (prev_cutoff)
> +			cutoff = prev_cutoff;
> +		else if (!cutoff)
> +			break;
> +
> +		/* Find the beginning and end of the string of spaces */
> +		first_space = cutoff;
> +		while (first_space > cmdline && first_space[-1] == ' ')
> +			first_space--;
> +		to_print = first_space - cmdline;
> +		while (*cutoff == ' ')
> +			cutoff++;
> +		used = cutoff - cmdline;
> +
> +		/* If the whole string is used, break and do the final printout */
> +		if (len == used)
> +			break;
> +
> +		if (to_print)
> +			pr_notice("%s%.*s%s\n", KERNEL_CMDLINE_PREFIX,
> +				  to_print, cmdline, KERNEL_CMDLINE_CONTINUATION);
> +
> +		len -= used;
> +		cmdline += used;
> +	}
> +	if (len)
> +		pr_notice("%s%s\n", KERNEL_CMDLINE_PREFIX, cmdline);
> +}
> +
>  asmlinkage __visible __init __no_sanitize_address __noreturn __no_stack_protector
>  void start_kernel(void)
>  {
> @@ -942,7 +1036,7 @@ void start_kernel(void)
>  	early_numa_node_init();
>  	boot_cpu_hotplug_init();
>  
> -	pr_notice("Kernel command line: %s\n", saved_command_line);
> +	print_kernel_cmdline(saved_command_line);
>  	/* parameters may set static keys */
>  	parse_early_param();
>  	after_dashes = parse_args("Booting kernel",
> -- 
> 2.51.1.821.gb6fe4d2222-goog
> 
