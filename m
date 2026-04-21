Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA437BE86;
	Tue, 21 Apr 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789048; cv=none; b=mKdRL8+AXNnZoeFZPEESU47OM3/kHL3eAyBh9D+tF263x+01Bnfhu3nIsXnSwlkochl3gg8XDtK0m+xQusm30CQ77ZfxE/mFiaXke5Hdrx1PD/t+nARHLjbNrSwmhERebIk3QKrdQfCJj8KJ37U15G53z5fpiZCmwjRA7hgEYjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789048; c=relaxed/simple;
	bh=VzGK/dXrA7ojghsrFE2F96/S3UgIjsZpS/dVecJp254=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tldjWkoCxO6rUW9G5gk4SfUKqix9FvtMW5rxRA8QAeTbsuH1XmTfgvrt0q7DwDAcneuBxvPUwfqSjCASPmXi2msNMUUTaOuDxNE9Q1yhu46cTarKY+FS/a7IFZ2Me04OQPxYoyu4x3/8LxiCDqZei6u5MJ0J3B33lxXhsY8nNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifSDKENu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifSDKENu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E49C2BCB3;
	Tue, 21 Apr 2026 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776789048;
	bh=VzGK/dXrA7ojghsrFE2F96/S3UgIjsZpS/dVecJp254=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifSDKENuCWAnxtER9mUmihPc5LqIZzxeC349pMForbSoFWmnsUqRZi/ZGzdbmCWPM
	 78I5v9XDiJO9ilE2Sh0uQIuWLCAblamwpIH4da6rES6hL6OtnDhHQIkpYXqRRhA3Rw
	 5ZQVMhdpohMOeiyYCbJuoSx7A8a8Dq/U6CUQCFAK7wfnnIZ9ej5OefMENFBep5V3+O
	 /mk1l/olwAt8Mq6qx9dKubhfzpk0MPJArW1u+l/59aiXUXX8CO8f3eeEBS+DMbKdnv
	 kAMBa0gfxZZmkq7FF9UREqBtoLCXsa0xEng3NwqcJTUSi41aEaXjue6e3IdabNgXdp
	 R+HcNuo51YkrA==
Date: Tue, 21 Apr 2026 09:30:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH] perf callchain: Handle multiple address spaces
Message-ID: <aeemNo-8_RByiwvP@google.com>
References: <20260414124241.490185-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414124241.490185-1-tmricht@linux.ibm.com>

Hello,

On Tue, Apr 14, 2026 at 02:42:41PM +0200, Thomas Richter wrote:
> perf test 'perf inject to convert DWARF callchains to regular ones'
> fails on s390. It was introduced with
> commit 92ea788d2af4 ("perf inject: Add --convert-callchain option")
> 
> The failure comes the difference in output. Without the inject script to
> convert DWARF the callchains is:
>  # ./perf record -F 999 --call-graph dwarf -- perf test -w noploop
>  # ./perf report -i perf.data --stdio --no-children -q \
> 					 --percent-limit=1 > /tmp/111
>  # cat /tmp/111
>     99.30%  perf-noploop  perf               [.] noploop
>             |
>             ---noploop
>                run_workload (inlined)
>                cmd_test
>                run_builtin (inlined)
>                handle_internal_command
>                run_argv (inlined)
>                main
>                __libc_start_call_main
>                __libc_start_main_impl (inlined)
>                _start
>  #
> 
> With the inject script step the output is:
>  # ./perf inject -i perf.data --convert-callchain -o /tmp/perf-inject-1.out
>  # ./perf report -i /tmp/perf-inject-1.out --stdio --no-children -q \
> 		--percent-limit=1 > /tmp/222
>  # cat /tmp/222
>     99.40%  perf-noploop  perf               [.] noploop
>             |
>             ---noploop
>                run_workload (inlined)
>                cmd_test
>                run_builtin (inlined)
>                handle_internal_command
>                run_argv (inlined)
>                main
>                _start
>  # diff /tmp/111 /tmp/222
>  1c1
>  <     99.30%  perf-noploop  perf               [.] noploop
>  ---
>  >     99.40%  perf-noploop  perf               [.] noploop
>  10,11d9
>  <                __libc_start_call_main
>  <                __libc_start_main_impl (inlined)
>  #
> 
> The difference are the symbols __libc_start_call_main and
> __libc_start_main_impl.
> 
> On x86_64, kernel and user space share a single virtual address space,
> with the kernel mapped to the upper end of memory. The instruction
> pointer value alone is sufficient to distinguish between user space
> and kernel space addresses. This is not true for s390, which uses
> separate address spaces for user and kernel. The same virtual address
> can be valid in both address spaces, so the instruction pointer value
> alone cannot determine whether an address belongs to the kernel or
> user space. Instead, perf must rely on the cpumode metadata derived
> from the processor status word (PSW) at sample time.
> 
> In function perf_event__convert_sample_callchain() the first part
> copies a kernel callchain and context entries, if any.
> It then appends additional entries ignoring the address space
> architecture. Taking that into account, the symbols at addresses
> 
>    0x3ff970348cb __libc_start_call_main
>    0x3ff970349c5 __libc_start_main_impl
> 
> (located after the kernel address space on s390) are now included.
> 
> Output before:
>  # ./perf test 83
>  83: perf inject to convert DWARF callchains to regular ones : FAILED!
> 
> Output after:
>  # ./perf test 83
>  83: perf inject to convert DWARF callchains to regular ones : Ok
> 
> Question to Namhyung:
> In function perf_event__convert_sample_callchain() just before the
> for() loop this patch modifies, the kernel callchain is copied,
> see this comment and the next 5 lines:
>    /* copy kernel callchain and context entries */ 
> Then why is machine__kernel_ip() needed in the for() loop, when
> the kernel entries have been copied just before the loop?

IIRC I wanted to make sure to have PERF_CONTEXT_* part in the raw
callchains.

> 
> Note: This patch was tested on x86_64 virtual machine and succeeded.
> 
> Fixes: 92ea788d2af4 ("perf inject: Add --convert-callchain option")
> Cc: Namhyung Kim <namhyung@kernel.org>
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/arch/common.c    | 4 +++-
>  tools/perf/builtin-inject.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 21836f70f231..ad0cab830a4d 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -237,5 +237,7 @@ int perf_env__lookup_objdump(struct perf_env *env, char **path)
>   */
>  bool perf_env__single_address_space(struct perf_env *env)
>  {
> -	return strcmp(perf_env__arch(env), "sparc");
> +	const char *arch = perf_env__arch(env);
> +
> +	return strcmp(arch, "s390") && strcmp(arch, "sparc");
>  }
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index f174bc69cec4..6ab20df358c4 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -438,7 +438,8 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
>  
>  	node = cursor->first;
>  	for (k = 0; k < cursor->nr && i < PERF_MAX_STACK_DEPTH; k++) {
> -		if (machine__kernel_ip(machine, node->ip))
> +		if (machine->single_address_space &&
> +		    machine__kernel_ip(machine, node->ip))
>  			/* kernel IPs were added already */;
>  		else if (node->ms.sym && node->ms.sym->inlined)
>  			/* we can't handle inlined callchains */;
> -- 
> 2.53.0
> 
