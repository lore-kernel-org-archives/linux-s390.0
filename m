Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBE52652A2;
	Tue, 18 Nov 2025 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431107; cv=none; b=itwvu4ZYd9HPs0a5NPIanfjnRQeeE5YDfPMEUdVfWxUbXjMByd91PlQ14YxD1Bm0Dph+NJwGtuTQ7B6dF+cTl/OIlpG7fZTaeWAlz/KABoMUbYEI2/FQKsMuVENSqPC9xlCgUJXS6T+sxAPOdtT70gna9/D/DoNvC0tOQ3NxGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431107; c=relaxed/simple;
	bh=r6QPg0wMUWeATYfOKgcGAJtZgZx5E5n3Akj4ZMKDXGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUwRjiXTjvX4/mSJDnhNniWeLESvsOmKkkf+JG/xJibhuHFRouJlfZednmARkGTpA4HuCqy4J0Sc8pcOaVmhl3zvJ6r41Su/wM+EDgA3dzIcJ6wEqlaFLEhIT+xHb2oy2IxX3RBh6wWZvwoST3EihEZsMoIkTooXJ5Xkn3gjz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYJ7BCru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYJ7BCru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F85C19423;
	Tue, 18 Nov 2025 01:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763431106;
	bh=r6QPg0wMUWeATYfOKgcGAJtZgZx5E5n3Akj4ZMKDXGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYJ7BCruKHK2MunApovm69H88xFsqKezYIASBPY+38PhGHZImKU4NyEMqaweRQxRl
	 US1eB8aslFXOITa95rvnfBppkkSf7a+s+C1HQ30FbMno+NiWnDtIvqRYikAigv35/M
	 0BK1v4sklX64F/uDZPk4GdcpRUX7V8ZFOcZxXs6U8btX42AHzV57ksL9VFtzytl/Z0
	 8uSyjX9MCgiGObmOyvUdurrvfT2Yc+nXfA1ZFYMAD+mwMb8WI+rmjfVsy410JnzGvx
	 Zu9dZmkeUSgIXNThrDUaF5BhGilQS81lqh4LXnMMtzTwethO5kMezBRCFG3q08Jj9v
	 PgE2XIgC08+pw==
Date: Mon, 17 Nov 2025 17:58:23 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
Message-ID: <aRvSv03cqarM5dY9@google.com>
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251117124359.75604-1-tmricht@linux.ibm.com>

Hello,

On Mon, Nov 17, 2025 at 01:43:59PM +0100, Thomas Richter wrote:
> The following test case fails on linux-next repo:
> 
>  ❯ uname -a
>  Linux s83lp47.lnxne.boe 6.18.0-20251116.rc5.git0.0f2995693867.63.\
>       fc42.s390x+next #1 SMP Sun Nov 16 20:05:28 CET 2025 s390x GNU/Linux
> 
>  # perf test -Fv 109
>  --- start ---
>  Checking if vmlinux BTF exists
>  Testing perf trace's string augmentation
>  Testing perf trace's buffer augmentation
>  Buffer augmentation test failed, output:
>  buffer content
>  echo/23281 write(1, buffer conten, 15, "") = 15
>  ---- end ----
>  109: perf trace BTF general tests            : FAILED!
>  #
> 
> The root case is a changed output format on linux-next.
> There is an addional "" string as forth parameter in the write()
> line. Here is the detailed output on linux-repo.
> Please note that this depends on the kernel and not on the perf tool.

Thanks for the report.  Do you know what the 4th arg is?  It'd be nice
if you can dump the contents of the event format which is
/sys/kernel/tracing/events/syscalls/sys_enter_write/format.

Thanks,
Namhyung

> 
> Output on linux next kernel:
>  # uname -a
>  Linux f43 6.18.0-rc5-next-20251114tmr-n #1 SMP PREEMPT_DYNAMIC ...
>  # perf config trace.show_arg_names=false trace.show_duration=false \
> 	trace.show_timestamp=false trace.args_alignment=0
>  # ./perf trace --sort-events -e write --max-events=1 \
> 	-- echo 'buffer content' 1>/dev/null
>  echo/7676 write(1, buffer content\10, 15, "") = 15
>  #
> 
> Output on linux kernel:
>  # uname -a
>  Linux b3560002.lnxne.boe 6.18.0-rc5m-perf #6 ....
>  # perf config trace.show_arg_names=false trace.show_duration=false \
> 	trace.show_timestamp=false trace.args_alignment=0
>  # ./perf trace --sort-events -e write --max-events=1 \
> 	-- echo 'buffer content' 1>/dev/null
>  echo/36932 write(1, buffer content\10, 15) = 15
>  #
> 
> Add the optional forth parameter in the extented regular expression to
> accept both output formats.
> 
> Output after:
>  # ./perf test -Fv 'perf trace BTF general tests'
>  --- start ---
>  Checking if vmlinux BTF exists
>  Testing perf trace's string augmentation
>  Testing perf trace's buffer augmentation
>  Testing perf trace's struct augmentation
>  ---- end ----
>  115: perf trace BTF general tests            : Ok
>  #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> index ef2da806be6b..9cd6180062d8 100755
> --- a/tools/perf/tests/shell/trace_btf_general.sh
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -39,7 +39,7 @@ trace_test_buffer() {
>    echo "Testing perf trace's buffer augmentation"
>    # echo will insert a newline (\10) at the end of the buffer
>    output="$(perf trace --sort-events -e write --max-events=1 -- echo "${buffer}" 2>&1)"
> -  if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
> +  if ! echo "$output" | grep -qE "^echo/[0-9]+ write\([0-9]+, ${buffer}\\\\10, [0-9]+(, ..)?\) += +[0-9]+$"
>    then
>      printf "Buffer augmentation test failed, output:\n$output\n"
>      err=1
> -- 
> 2.51.1
> 
