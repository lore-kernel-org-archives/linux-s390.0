Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBD2F56;
	Sat,  1 Mar 2025 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787981; cv=none; b=ZJSiLW0mw7TCj6ejkRFJ5dRooK1Il6hU8yXbxrHFPaU8UQZMWTGtnxbSiNd5dHXYPB0AMMH1F+r1ZpaEuBBoFiBFcZEGAs/0FbzYx5GTh9H8HQMCPGs7e5V5mSVzZzxRFke/pN44PE9TwVUCTlbINkyT4W6urCMtDvKC+Qj8B6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787981; c=relaxed/simple;
	bh=Z3A7/rpc5BUBrXAJwq7DKAz8PCU08h3SYsMUlwDbyxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnGs9SI+5vWY/xR295wIRhFBSWEtQ3ACSP0TBJ16DlAujiCE+sdQjz3WIxraDtuuM9eGgd6T1Ymbw3o81+nGvnHhBaO4gl4SEyrhAJyEihMZgWwy8rU23mmKZhJFZMncP01KfCdN819sTc6K4e0Ql+oEfZyI7xQS1qbHZsygV74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouyXZ+R/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouyXZ+R/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD74AC4CED6;
	Sat,  1 Mar 2025 00:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740787981;
	bh=Z3A7/rpc5BUBrXAJwq7DKAz8PCU08h3SYsMUlwDbyxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ouyXZ+R/g0s0kTBPgLUFyyGBFM+6bqwf8koqkMq5O1RcvWKXKU/Lz25cUoenI+Gn1
	 KmTaEcd5jV7FX/e7I28OC39WingIEFsNEoK0W0CyzKHLCJSVU9smD6xdDd6qnz5Px6
	 7IlTqmTGzxys99zNrFGagzR9pTlUajbWVbkmDWTzuxvZdBOeTKGWhQs6NhncmhRzgk
	 x/1g9czHQ6378SQqdsvwsbZByASz7SdvS/ScJunDnweFRGJEa5EBzEg+7FKoJvweFI
	 HO3hXbwToc4pd0PEmiISOiNKYj8/mih3rNMEQPt6IJ6o8wI3TbNSf+OAWxYyPmlh1F
	 j3Qx0ZYDa/2pA==
Date: Fri, 28 Feb 2025 16:12:59 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com
Subject: Re: [PATCH] perf/test: Skip leader sampling for s390
Message-ID: <Z8JRC2oSs8i53t_s@google.com>
References: <20250228062241.303309-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228062241.303309-1-tmricht@linux.ibm.com>

Hello,

On Fri, Feb 28, 2025 at 07:22:41AM +0100, Thomas Richter wrote:
> In tree linux-next
> the perf test case 114 'perf record tests' has a subtest
> named 'Basic leader sampling test' which always fails on s390.
> Root cause is this invocation
> 
>  # perf record -vv -e '{cycles,cycles}:Su' -- perf test -w brstack
> 
>  ...
>  In the debug output the following 2 event are installed:
> 
>  ------------------------------------------------------------
>  perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   disabled                         1
>   exclude_kernel                   1
>   exclude_hv                       1
>   freq                             1
>   sample_id_all                    1
>  ------------------------------------------------------------
>  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>  ------------------------------------------------------------
>  perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   exclude_kernel                   1
>   exclude_hv                       1
>   sample_id_all                    1
>  ------------------------------------------------------------
>  sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8 = 6
>  ...
> 
> The first event is the group leader and is installed as sampling event.
> The secound one is group member and is installed as counting event.
> 
> Namhyung Kim confirms this observation:
> > Yep, the syntax '{event1,event2}:S' is for group leader sampling which
> > reduces the overhead of PMU interrupts.  The idea is that those events
> > are scheduled together so sampling is enabled only for the leader
> > (usually the first) event and it reads counts from the member events
> > using PERF_SAMPLE_READ.
> >
> > So they should have the same counts if it uses the same events in a
> > group.
> 
> However this does not work on s390. s390 has one dedicated sampling PMU
> which supports only one event. A different PMU is used for counting.
> Both run concurrently using different setups and frequencies.
> 
> On s390x a sampling event is setup using a preset trigger and a large
> buffer. The hardware
>  - writes a samples (64 bytes) into this buffer
>    when a given number of CPU instructions has been executed.
>  - and triggers an interrupt when the buffer gets full.
> The trigger has just a few possible values.
> 
> On s390x the counting event cycles is used to read out the numer of
> CPU cycles executed.
> 
> On s390 above invocation created 2 events executed on 2 different
> PMU and the result are diffent values from two independently running
> PMUs which do not match in a consistent and reliably as on Intel:
> 
>  # ./perf record  -e '{cycles,cycles}:Su' -- perf test -w brstack
>    ...
>  # ./perf script
>    perf 2799437 92568.845118:  5508000 cycles:  3ffbcb898b6 do_lookup_x+0x196
>    perf 2799437 92568.845119:  1377000 cycles:  3ffbcb898b6 do_lookup_x+0x196
>    perf 2799437 92568.845120:  4131000 cycles:  3ffbcb897e8 do_lookup_x+0xc8
>    perf 2799437 92568.845121:  1377000 cycles:  3ffbcb8a37c _dl_lookup_symbol
>    perf 2799437 92568.845122:  1377000 cycles:  3ffbcb89558 check_match+0x18
>    perf 2799437 92568.845123:  2754000 cycles:  3ffbcb89b2a do_lookup_x+0x40a
>    perf 2799437 92568.845124:  1377000 cycles:  3ffbcb89b1e do_lookup_x+0x3fe
> 
> As can be seen the result match very often but not all the time
> make this test on s390 failing very, very often.
> 
> This patch bypasses this test on s390.
> 
> Output before:
>  # ./perf test 114
>  114: perf record tests                       : FAILED!
>  #
> 
> Output after:
>  # ./perf test 114
>  114: perf record tests                       : Ok
>  #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Thanks for the fix.  I think Ian saw the same problem on other archs
too.  Maybe we need to enable it on supported archs only.

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/record.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index ba8d873d3ca7..98b69820bc5f 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -231,6 +231,12 @@ test_cgroup() {
>  
>  test_leader_sampling() {
>    echo "Basic leader sampling test"
> +  if [ "$(uname -m)" = s390x ]
> +  then
> +    echo "Leader sampling skipped"
> +    ((skipped+=1))
> +    return
> +  fi
>    if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
>      perf test -w brstack 2> /dev/null
>    then
> -- 
> 2.45.2
> 
