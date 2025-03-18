Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF420E716
	for <linux-s390@vger.kernel.org>; Tue, 18 Mar 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315841; cv=none; b=p0+IAjM4gu+jBUKSO+o+BeGW2+OLn3tYnsBTP0UUHlDNSMrQFMc2gX/pEApq8FuzHuM14hB8VMLy3SLYepOL8qTk1oxyOGzbkceHxfff6YCQ1uQ6neZariaM8drPkylQB+kyZYeQQCRblTnhb0rQjYQBahSyiZUq/w2En1XhopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315841; c=relaxed/simple;
	bh=4eT1odMzMnZPwJJSc0XgEk7lC+8F9q03wpNoipGla5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sULnNQOXxEn2DM53QFSbJAnvQZMy3/TToGKoLpFwwZ6v46KptGx3Hp/gKtoepGN6mSCrs1eA7XoEwt9fs7U5JeGa6IeOovKr/necoEVzJ/XgAFHvBnNtityJLULZHRV3gN73uKQDYV6xEA+9A76NsMlPyEM/Cg7yxgBBkmioOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltJeuoVh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltJeuoVh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2242ac37caeso169455ad.1
        for <linux-s390@vger.kernel.org>; Tue, 18 Mar 2025 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742315835; x=1742920635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2z69ehu9MYLofoS0JeQiQ0e/VE3ytjfb/z77xAUlFQ=;
        b=ltJeuoVh0zi4JNdzW9UUjzGPslste3/5VtDEvY1a6kUE35DkascYD+89tdH/vVkckq
         Dt/RB9zlcb1/AndZIK4am9uZjT2xXzDdtgI7I9GGrEhjuBiJJYepk8pPCT8WS6iKDA61
         a4og5lTkRpgwfwToUnwi3gH2YFEtY0SMikH2Z+EoQpOyvFHvBKFgDjjHTOHpp2r+Crmp
         tK8rvSh4L2cVOzQP6XsJzLWR2fAjnv5iAo4siLfwz5XmAowdyMhGZaHVdJc6DAxof9uJ
         TTfq37b1M/nHCU9H1PyF8X+vLDwTnkhX6K6n5Q+dal17VvTH3iE6pWCd/buwl1Iid2Nq
         4ZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315835; x=1742920635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2z69ehu9MYLofoS0JeQiQ0e/VE3ytjfb/z77xAUlFQ=;
        b=jUYWuAAp9XnC1YMCTbTY75TWhSP9xlNITZbYzaWGThlUIX+XWrpgXcfdOpxWHyhV9J
         gmypkCrlf4EBA84wA4dftR/u7taItAixoOxZBt4+XQVVFa+9yWBz3FpT0reCyy8fgixM
         O35y2HCgzmjl+tEz/xuHbQhbkNJQl1nJRV1xfh5KxwcZZAHKZrS7Kf/hnpOa7G9aYeF2
         lRvZb1bQLJROeibTVax5cc/llbGbZC1NKTzPOVJQ2qTkVs60QF/UyihCvDckKa5y//Ow
         PPoWqweDBEFdG8om2ltfiVoVHU+vUESOgvip7YHJEH5/o46nvjxPdzo6HyqFDIrl3vs8
         OP5A==
X-Forwarded-Encrypted: i=1; AJvYcCUAO0UlbYyc3zj8YEEZZXNoOp32okA3FcXoItzyl12DH4mR6XsaChrrJMsIydqbR9OF6DRKBYKHFEtR@vger.kernel.org
X-Gm-Message-State: AOJu0YxJnhyXc19VPyjS7OmEwmAmKOWf88FdrOTumMF7R0lrjHgwWpzu
	6cZATIEjdPKscLau0ZliLeasKWtp/cHhKBzmGS1NB3jl2MkclbG3ZindL0EaMI2Sng0mC4WlTLt
	ZVuNFdMjjNlN9a3xjdYgpZhWv2IinMVizv9KzAIR9GjQqGVH/nmso
X-Gm-Gg: ASbGncsahlU1cp1pwi1oXicKW9qMJpwF+ht0kCvKcYrqusxRIn3hOV4fEi5FYReRvI1
	csdWVs2FND2+BP2AQpMhdjK8CRujTesiHvZSfdocCsS4mDYXVubUnTEAeLdYiRSi0lKXxf3CkXQ
	FDDnmlhcU1t0QsOvGGZrlpCGqlKm4pK7GczDFuryol83mIoJr5uHa8eErBvub2gw==
X-Google-Smtp-Source: AGHT+IHnSw39H849L234BIkDc47Eq7xhSFTxT3N4fuR1hmpWc455Btyp/vc6iE1Wb2xmRZNsrCL1ynYjk4f8BKIAoHA=
X-Received: by 2002:a17:903:228a:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-226357c807cmr2082025ad.15.1742315834907; Tue, 18 Mar 2025
 09:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318095132.1502654-1-tmricht@linux.ibm.com> <20250318095132.1502654-3-tmricht@linux.ibm.com>
In-Reply-To: <20250318095132.1502654-3-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Mar 2025 09:37:02 -0700
X-Gm-Features: AQ5f1JpT8DCKBYPXcNNrpUEYFo_khI7jP_G1lI4QozhZPAilFvW_a6UuYt0iing
Message-ID: <CAP-5=fXAhsDkQXVCvb5xrjLVpYG-typR23_NXwgwPDjaJS0pqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf/bench: Double free of dynamic allocated memory
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	acme@redhat.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:52=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On s390 z/VM the command 'perf bench internals pmu-scan'
> dumps core, as can be seen:
>
> Output before:
>  # ./perf bench internals pmu-scan
>  # Running 'internals/pmu-scan' benchmark:
>  Computing performance of sysfs PMU event scan for 100 times
>  perf: /root/linux/tools/include/linux/refcount.h:131:
>         refcount_sub_and_test: Assertion `!(new > val)' failed.
>  Aborted (core dumped)
>  #
>
> The root cause is in
>
> perf_pmus__scan()
> +--> perf_pmu__create_placeholder_core_pmu()
>      +--> cpu_map__online()
>
> cpu_map__online() has a static variable
>
>     static struct perf_cpu_map *online;
>
>     if (!online)
>         online =3D perf_cpu_map__new_online_cpus();
>
>     return online;
>
> which is allocated once when entered for the first time.
>
> However perf_pmu__create_placeholder_core_pmu() is actually called
> two times.
> First time:
>    run_pmu_scan()
>    +--> save_result()
>         +---> perf_pmus__scan_core()
>               +--> pmu_read_sysfs()
>                    +--> perf_pmu__create_placeholder_core_pmu()
>         ...
>         +--> perf_pmus__destroy()
>
> Second time:
>     run_pmu_scan()
>     +--> perf_pmus__scan()
>          +--> pmu_read_sysfs()
>               +--> perf_pmu__create_placeholder_core_pmu()
>         ...
>         +--> perf_pmus__destroy()
>
> The second time the already allocated memory pointed to by variable
> 'online' is returned. However in between the first and second call
> of perf_pmu__create_placeholder_core_pmu()
> function save_result() also frees all PMUs:
>
> save_result()
> +--> perf_pmus__destroy()
>      +--> perf_pmu__delete()
>           +--> perf_cpu_map__put()
>                +--> cpu_map__delete()
>
> cpu_map__delete() deletes the perf_cpu_map pointed to by variable
> online, but this static variable is not set to NULL. In the second
> invocation of perf_pmu__create_placeholder_core_pmu() the same
> memory locattion stored in variable online is returned.
>
> Later on run_pmu_scan() calls perf_pmus__destroy() again and then
> cpu_map__delete() frees the PMU "cpu->cpus" a second time causing
> the core dump.
>
> Avoid core dump and always allocate the online CPUs.
>
> Output after:
>  # ./perf bench internals pmu-scan
>  # Running 'internals/pmu-scan' benchmark:
>  Computing performance of sysfs PMU event scan for 100 times
>   Average core PMU scanning took: 7.970 usec (+- 0.147 usec)
>   Average PMU scanning took: 60.415 usec (+- 3.986 usec)
>  #
>
> Background: s390 z/VM system do not support PMUs for sampling and
> counting. In this case dummy events are created by the perf tool
> and the PMUs "tool" and "fake" are created and freed.
>
> Fixes: a0c41caebab2f ("perf pmu: Add CPU map for "cpu" PMUs")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>

Thanks Thomas, the proposed fix breaks address sanitizer as there are
missing puts on the freshly allocated cpu maps. I think a better fix
would be to "get" the cpu map to increment the reference count rather
than to keep re-reading the online CPUs. In either case we need the
puts on the user side.

Ian

> ---
>  tools/perf/util/cpumap.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 5c329ad614e9..ab9e7a266af9 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -691,12 +691,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *ma=
p, char *buf, size_t size)
>
>  struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
>  {
> -       static struct perf_cpu_map *online;
> -
> -       if (!online)
> -               online =3D perf_cpu_map__new_online_cpus(); /* from /sys/=
devices/system/cpu/online */
> -
> -       return online;
> +       return perf_cpu_map__new_online_cpus(); /* from /sys/devices/syst=
em/cpu/online */
>  }
>
>  bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_c=
pu_id *b)
> --
> 2.48.1
>
