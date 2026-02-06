Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27CDE56A;
	Fri,  6 Feb 2026 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770414111; cv=none; b=QvfF3GAr+chcVda+R7lVV0A8TtItPuTcvM+72a4iGKzrvljtgthHXgRXb5NxTB7hFl28WhaUpgmysGnDe8qeuD+LL2OlAqM8H3ex7sjGxXcL+ZqmoDfUKaUrsiODNcFuy9ygwNuIbd1/AAzzI/E5hMzWp24vXkmdYOP0/LoEbe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770414111; c=relaxed/simple;
	bh=AtlbjLihUSF1rF9S5oKMg7a3NWtvDMM3zeP9lG6qKzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7NhU9PWikK862YxgSv/laC3wdAhKkwnAtJoiRehDoW+P3FiwKpGFZWB4WYBMU87j1oxSXMy6HzZZD6mXHoNL4IwEKTiZrP7FCNCFafjPgFw7R6/dj/0/rlCHW/X2wDBzwMyAqluVMAbo8WDZ5c+d5Jpkb1H0n0w9sXutUjqb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9+CuQV2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9+CuQV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5881C116C6;
	Fri,  6 Feb 2026 21:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770414110;
	bh=AtlbjLihUSF1rF9S5oKMg7a3NWtvDMM3zeP9lG6qKzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9+CuQV2POmTqabibD56Fhk6l+xnaG1V0Y73+9m8gCg0CdnGd4ZAgxaaW9ywq3++r
	 wLg/RZ+/ngAX8CV9LnRAtBgiZxh+ifvX4Xq+FXCA3RwNl9lZlM/xsU33WgsxqnWbfs
	 P/01zBY7/RQGFqrAJMlfcO82z05q4nsEyDMXowBgdsTuJnbKdE9ZsSoAx5HjXjltO1
	 bmDdSzAzwwttYOmiDg0K4L8tnGy5M23wiDioLzbYigdRqVugmfNtMQCBa+hxF6vENm
	 eTNs7L6f17uNas/ip4a0Vrqu+7IJTO6VB57q4bGHgJBP4wWdnusbbMyGjUvtppbNdm
	 chv66UHDAzT9g==
Date: Fri, 6 Feb 2026 18:41:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH] perf/test: Fix test case Leader sampling on s390.
Message-ID: <aYZgGlh3e84ZrUNQ@x1>
References: <20251128091139.1309755-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128091139.1309755-1-tmricht@linux.ibm.com>

On Fri, Nov 28, 2025 at 10:11:39AM +0100, Thomas Richter wrote:
> The subtest 'Leader sampling' some time fails on s390.
> - for z/VM guest: Disable the test for z/VM guest. There is no
>   CPU Measurement facility to run the test successfully.
> - for LPAR: Use correct event names.

This one fell thru the cracks, still applies cleanly and the extra logic
affects only s390, applying to perf-tools-next,

- Arnaldo
 
> A detailed analysis follows here:
> Now to the debugging and investigation:
> 1. With command
>        perf record -e '{cycles,cycles}:S' -- ....
>    the first cycles event starts sampling.
>    On s390 this sets up sampling with a frequency of 4000 Hz.
>    This translates to hardware sample rate of 1377000 instructions per
>    micro-second to meet a frequency of 4000 HZ.
> 
> 2. With first event cycles now sampling into a hardware buffer, an
>    interrupt is triggered each time a sampling buffer gets full.
>    The interrupt handler is then invoked and debug output shows the
>    processing of samples.  The size of one hardware sample is 32 bytes.
>    With an interrupt triggered when the hardware buffer page of 4KB
>    gets full, the interrupt handler processes 128 samples.
>    (This is taken from s390 specific fast debug data gathering)
>    2025-11-07 14:35:51.977248  000003ffe013cbfa \
> 	   perf_event_count_update event->count 0x0 count 0x1502e8
>    2025-11-07 14:35:51.977248  000003ffe013cbfa \
> 	   perf_event_count_update event->count 0x1502e8 count 0x1502e8
>    2025-11-07 14:35:51.977248  000003ffe013cbfa \
> 	   perf_event_count_update event->count 0x2a05d0 count 0x1502e8
>    2025-11-07 14:35:51.977252  000003ffe013cbfa \
> 	   perf_event_count_update event->count 0x3f08b8 count 0x1502e8
>    2025-11-07 14:35:51.977252  000003ffe013cbfa \
> 	   perf_event_count_update event->count 0x540ba0 count 0x1502e8
>    2025-11-07 14:35:51.977253  000003ffe013cbfa \
> 	   perf_event_count_update event->count 0x690e88 count 0x1502e8
>    2025-11-07 14:35:51.977254  000003ffe013cbfa \
> 	   perf_event_count_update event->count 0x7e1170 count 0x1502e8
>    2025-11-07 14:35:51.977254  000003ffe013cbfa \
> 	   perf_event_count_update event->count 0x931458 count 0x1502e8
>    2025-11-07 14:35:51.977254  000003ffe013cbfa \
> 	   perf_event_count_update event->count 0xa81740 count 0x1502e8
> 
> 3. The value is constantly increasing by the number of instructions
>    executed to generate a sample entry.  This is the first line of the
>    pairs of lines. count 0x1502e8 --> 1377000
> 
>    # perf script | grep 1377000 | wc -l
>    214
>    # perf script | wc -l
>    428
>    #
>    That is 428 lines in total, and half of the lines contain value
>    1377000.
> 
> 4. The second event cycles is opened against the counting PMU, which
>    is an independent PMU and is not interrupt driven.  Once enabled it
>    runs in the background and keeps running, incrementing silently
>    about 400+ counters. The counter values are read via assembly
>    instructions.
> 
>    This second counter PMU's read call back function is called when the
>    interrupt handler of the sampling facility processes each sample. The
>    function call sequence is:
> 
>    perf_event_overflow()
>    +--> __perf_event_overflow()
>         +--> __perf_event_output()
>                +--> perf_output_sample()
>                     +--> perf_output_read()
>                          +--> perf_output_read_group()
> 	                          for_each_sibling_event(sub, leader) {
> 		values[n++] = perf_event_count(sub, self);
> 		printk("%s sub %p values %#lx\n", __func__, sub, values[n-1]);
> 			          }
> 
>    The last function perf_event_count() is invoked on the second event
>    cylces *on* the counting PMU. An added printk statement shows the
>    following lines in the dmesg output:
> 
>    # dmesg|grep perf_output_read_group |head -10
>    [  332.368620] perf_output_read_group sub 00000000d80b7c1f values 0x3a80917 (1)
>    [  332.368624] perf_output_read_group sub 00000000d80b7c1f values 0x3a86c7f (2)
>    [  332.368627] perf_output_read_group sub 00000000d80b7c1f values 0x3a89c15 (3)
>    [  332.368629] perf_output_read_group sub 00000000d80b7c1f values 0x3a8c895 (4)
>    [  332.368631] perf_output_read_group sub 00000000d80b7c1f values 0x3a8f569 (5)
>    [  332.368633] perf_output_read_group sub 00000000d80b7c1f values 0x3a9204b
>    [  332.368635] perf_output_read_group sub 00000000d80b7c1f values 0x3a94790
>    [  332.368637] perf_output_read_group sub 00000000d80b7c1f values 0x3a9704b
>    [  332.368638] perf_output_read_group sub 00000000d80b7c1f values 0x3a99888
>    #
> 
>    This correlates with the output of
>    # perf report -D | grep 'id 00000000000000'|head -10
>    ..... id 0000000000000006, value 00000000001502e8, lost 0
>    ..... id 000000000000000e, value 0000000003a80917, lost 0 --> line (1) above
>    ..... id 0000000000000006, value 00000000002a05d0, lost 0
>    ..... id 000000000000000e, value 0000000003a86c7f, lost 0 --> line (2) above
>    ..... id 0000000000000006, value 00000000003f08b8, lost 0
>    ..... id 000000000000000e, value 0000000003a89c15, lost 0 --> line (3) above
>    ..... id 0000000000000006, value 0000000000540ba0, lost 0
>    ..... id 000000000000000e, value 0000000003a8c895, lost 0 --> line (4) above
>    ..... id 0000000000000006, value 0000000000690e88, lost 0
>    ..... id 000000000000000e, value 0000000003a8f569, lost 0 --> line (5) above
> 
> Summary:
> - Above command starts the CPU sampling facility, with runs interrupt
>   driven when a 4KB page is full. An interrupt processes the 128 samples
>   and calls eventually perf_output_read_group() for each sample to save it
>   in the event's ring buffer.
> 
> - At that time the CPU counting facility is invoked to read the value of
>   the event cycles. This value is saved as the second value in the
>   sample_read structure.
> 
> - The first and odd lines in the perf script output displays the period
>   value between 2 samples being created by hardware. It is the number
>   of instructions executes before the hardware writes a sample.
> 
> - The second and even lines in the perf script output displays the number
>   of CPU cycles needed to process each sample and save it in the event's
>   ring buffer.
> These 2 different values can never be identical on s390.
> 
> Since event leader sampling is not possible on s390 the perf tool will
> return EOPNOTSUPP soon. Perpare the test case for that.
> 
> Suggested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  tools/perf/tests/shell/record.sh | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 0f5841c479e7..46b96d565680 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -260,7 +260,21 @@ test_uid() {
>  
>  test_leader_sampling() {
>    echo "Basic leader sampling test"
> -  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
> +  events="{cycles,cycles}:Su"
> +  [ $(uname -m) = "s390x" ] && {
> +    [ ! -d /sys/devices/cpum_sf ] && {
> +      echo "No CPUMF [Skipped record]"
> +      return
> +    }
> +    events="{cpum_sf/SF_CYCLES_BASIC/,cycles}:Su"
> +    perf record -o "${perfdata}" -e "$events" -- perf test -w brstack 2> /dev/null
> +    # Perf grouping might be unsupported, depends on version.
> +    [ "$?" -ne 0 ] && {
> +      echo "Grouping not support [Skipped record]"
> +      return
> +    }
> +  }
> +  if ! perf record -o "${perfdata}" -e "$events" -- \
>      perf test -w brstack 2> /dev/null
>    then
>      echo "Leader sampling [Failed record]"
> -- 
> 2.52.0
