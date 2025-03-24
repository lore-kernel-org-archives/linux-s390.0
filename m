Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D104918FDD8;
	Mon, 24 Mar 2025 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848335; cv=none; b=jOrQjoD5zb81rkB0hNikcXQmbE0Md84DRbKt+UkXAoiwsd13OLbohAnwwdfL7Uuv2Jsn0VccIlVwSXWA77x0n5nnY0FgSe2/S05ZhHfpwhC+HWwTJSZh8eQhvVlamkeDnU9/hqjRTKlG/FHeH02uz4QQkLd571FAL6NPxdkTu8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848335; c=relaxed/simple;
	bh=XVX8FQkr9SlsH8uzchlcuOqHLWzlLBEAPLfd9ELg3Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYV38IZiqHzqVGgjH+GVki4YwL6wkKtMjd5MCi9/h6B/mfE2p+r+ULRcJnx91b3wLtHlBlHbDEfaRosBD0EpsixNtGKtPwA/fn+VvKi7TWF2vvNW/LphDdS9ajZatzvlcrGztcxwZi22WNT2cgdv7+MkITyW+9rmudHtXCE57O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJthRY5f; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJthRY5f"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3014ae35534so7493533a91.0;
        Mon, 24 Mar 2025 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742848333; x=1743453133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XVX8FQkr9SlsH8uzchlcuOqHLWzlLBEAPLfd9ELg3Qc=;
        b=fJthRY5fo9QFxJr0KWL0rh0UtHB0APpVut5T9S4rUFzo953jgsOVR0LcTKQrSkMgk1
         MX6n9vXHt5L9tI13FBrD6pntfpgEBF2TsGHAUbYwdUT4URjqJzQOA36hTdpP5AnT8Qfe
         VYYsQtasZIsV+/UPMwsEfoUcVX4GSlHmDog5YdgH40cSe9Au7URvoObkUqyUoh+EFDhT
         uwHUMCoJnX/VVQikpXEtj4YGGDjdVf3cEfT1Lxblg0/FgKtPS5uKuA9bZ/euBaKjz6yw
         YT5cen+pMDK0FzGyi6OsveMmnQBghK1q6gHaLNYYTjrDa7w/ZpqGSzwTPhxJC4O4ryDN
         AF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742848333; x=1743453133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVX8FQkr9SlsH8uzchlcuOqHLWzlLBEAPLfd9ELg3Qc=;
        b=bFgGACjUvR3HT4r0YojSOheZ2GpXh9GstKQ+ZCk8dMRAE5r6J4q91ZQVLhl3FujpdP
         pmS99rtdztdyDGCGgWpFUBj8+0N77mu01Sz/Tih1W28LulBiBxlHAXJC/E2g9sl+hbUY
         CaQdtjeeYvgc3yfBqzSs9w8ami2nZIt2YoP/L3uEt8KBY49UNcavsTGVu60fwnPhyTM1
         xLrSjJKZJFYVXAc1e4znz6kXwwNcRlNKyiJMzsvJsmNpc/rpBlKxbwJK9KOz/aW9JGCn
         VGVrP0LN1jpH5LjmTXCoKw1N5//LJ7GUU2KaCZ9XxceuobRy4bTX1QPUBzo3vENPkcW8
         sheg==
X-Forwarded-Encrypted: i=1; AJvYcCVDQzDDhUYeq0pxGryEVOKX1xLMtEnbjjNz7naJITS6EDiJ5p+5ZVn9pwQ4z6QcraPSklnbVz3pPr9vwLr5ZX2I@vger.kernel.org, AJvYcCXhRGS+cgSrDWkXyi4Po/iwdOD6ZCRP351L92rkUtuNxdng/91nxbihPhEbhkLkmYY6IyMkyef2IsmmVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFKrogLSHBQvfDWVU/Uf6qjiAwkg89ruHumHAxyVStFicCYtO
	CLvfyktU45z8Q3J3n0oodNSzbpp9iHjEHanFY3v58suB/6O+SFzj
X-Gm-Gg: ASbGnctFRYE56AYmD/LTT88+3uhhkyWNdRG4+x5VVuiUVxNNuHHnBh7q8CPZiBHZTmr
	6+5DXEPa2CGW9/j/9BOTSEHOvw7AG3JaVwVErktc3TD+gYqOHZ59podr8l/1duv1LiAIty1IswA
	UItyNriiNNBn6Riuiw1NzNOOcuKEV2dl1XKK/mUuZNDbyyjfsbcqN/vxT8rFpLBXHZBocRrrLug
	ELeIxfXEI3ElcAMZiLlg0R7viy8vPlcu6DkpIKsOef7zd8TtORaHhn3NbrOVD/BZeCTuA07e649
	GwuVdy4clizVGpdby4CHE958hrGmwIQSvhmRIQ2KTAQLdtTcRGoeLJ64C+q524OrH9A9YPtOjKY
	rUF0=
X-Google-Smtp-Source: AGHT+IEl94P5ryl0oiQlFs0i4xhbZ49ukxG7UTpiDPwU1kFz3OhT5yzplFI/ngX8B0sL1UAEezKEUQ==
X-Received: by 2002:a17:90b:5105:b0:2ea:37b4:5373 with SMTP id 98e67ed59e1d1-3030fea47e8mr24740371a91.10.1742848332879;
        Mon, 24 Mar 2025 13:32:12 -0700 (PDT)
Received: from gmail.com (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a49bsm12690751a91.34.2025.03.24.13.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:32:12 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:32:09 -0700
From: Howard Chu <howardchu95@gmail.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, james.clark@linaro.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com
Subject: Re: [PATCH] perf trace: Fix wrong size to bpf_map__update_elem call
Message-ID: <Z-HBSReviPphH2LJ@gmail.com>
References: <20250324152756.3879571-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324152756.3879571-1-tmricht@linux.ibm.com>

On Mon, Mar 24, 2025 at 04:27:56PM +0100, Thomas Richter wrote:
> In linux-next
> commit c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
> causes the perf tests 100 126 to fail on s390:
>
> Output before:
>  # ./perf test 100
>  100: perf trace BTF general tests         : FAILED!

Arnaldo encountered similar failure, but I couldn't reproduce it, so the
fix was stalled.

>  #
>
> The root cause is the change from int to int16_t for the
> cpu maps. The size of the CPU key value pair changes from
> four bytes to two bytes. However a two byte key size is
> not supported for bpf_map__update_elem().
> Note: validate_map_op() in libbpf.c emits warning
>  libbpf: map '__augmented_syscalls__': \
>        unexpected key size 2 provided, expected 4
> when key size is set to int16_t.
>
> Therefore change to variable size back to 4 bytes for
> invocation of bpf_map__update_elem().

Makes sense, thank you so much for digging into this and fixing it.

>
> Output after:
>  # ./perf test 100
>  100: perf trace BTF general tests         : Ok
>  #
>
> Fixes: c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/builtin-trace.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 092c5f6404ba..464c97a11852 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4375,10 +4375,12 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>                * CPU the bpf-output event's file descriptor.
>                */
>               perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events.bpf_output->core.cpus) {
> +                     int mycpu = cpu.cpu;
> +
>                       bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
> -                                     &cpu.cpu, sizeof(int),
> +                                     &mycpu, sizeof(int),
>                                       xyarray__entry(trace->syscalls.events.bpf_output->core.fd,
> -                                                    cpu.cpu, 0),
> +                                                    mycpu, 0),
>                                       sizeof(__u32), BPF_ANY);
>               }
>       }
> --
> 2.48.1
>
>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
