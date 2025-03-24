Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2B19E98A
	for <linux-s390@vger.kernel.org>; Mon, 24 Mar 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830713; cv=none; b=k0KgJJ6f5dRDLhTvUk5sMkMy8TyVJcJeJwjd73Cqh+dXLclcmv6AfLJDhs5LXCXUlFYy+slF5neW7bp4A3gzCYzqIpInhptSlEcjS69PNEJe6c2Fx04YV0YM9NNNSNMlvTVqBbLjicCEmUkULGJe7WafTRgJL/BWLnrYoOO9EeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830713; c=relaxed/simple;
	bh=7tFPKr5B28kVVnB/cruAoC3a2L3PVQkAdc77QpKuC8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyySWwqzhfvO4Jy6cTFah+/RZ5zG9U3VnmRfB4J82f4ZrI4SRamc6adxOhJCiwJ3YXpSaqkPyCCqkRWSekyIlfS8TqNiiC5GkxquIJd+/aMYeQq4q7NgmkhXOIpNFIUXcgCaj8kEfhs9wBylnEWt8pugPKylM5nSqoCSRT5QBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PW6GnF/9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PW6GnF/9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2264c9d0295so451305ad.0
        for <linux-s390@vger.kernel.org>; Mon, 24 Mar 2025 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742830711; x=1743435511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COkzJxkZqJhvzNHBGE3D9fP9/TE+wWSTDgVE4d1zPOc=;
        b=PW6GnF/9JHS+fPzLvw8tXKTUATOwRF5vOzd+BUXCA0Sw7b6WNE7RJM/xxv5U0K7y22
         4akE++r0y+kO7FpbrqauoaNLHK/TUkxeiEvjwiyM0Sj0q8plGRJDLcHcimOC91voaZUl
         WGaqj4puHEtr9xCgf4hgWeJaFvUWwM9MfQdQQCMw96engae+fusVvzFmb9t0CZ2PN2uB
         6KkoSgfgjAFeMi0Oe8zQ6nXNoDZ2JCRVNeIL2Ql94DEwDEOHe5+k1rLwdUQLdQePsnSc
         VnOJg/5O105T8+9qTzXpcsGEaPCAChXCaMaIBHy5jj7gfBb+iIZybRmzxs7vZKovzEzw
         tg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742830711; x=1743435511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COkzJxkZqJhvzNHBGE3D9fP9/TE+wWSTDgVE4d1zPOc=;
        b=pOhrG65YQYRpRVIiiD9VI+XsInq6YH/agitwlnh/t/VOF/lhSdYhRKDOkKur+HLBYd
         h3MuiYDuzACFZozNWdAKEfzR7ozheNQ4cTHwnRjToCitkz0ojNDFSm4LakWNb0cSBWF7
         Z9C83TSBZyjxUU0DQ4zYdBjBFQX7xqYwbYfoRJfoEF/qy7cfQjfvrlNXg2oMZhT2UVZ4
         Pd5mYoyju4Hm+o6gYIs7/+xZHQFhDEq+cepO1LeeEZrmXieOpPexW5ePf8yvsX/6H71x
         nLA2kCzhx0MYk0Ra7/ufOi0T9iGwSQGA3lIeF32KGqtoCsfCZbZu5VTvaHMvxO7JDZ9q
         CA6w==
X-Forwarded-Encrypted: i=1; AJvYcCWuDiJ4mxPUvpIVODJykdrqo1Te7vH66tgojhnJvCDC3Wu7Vd7+08NweT4f+pohvASUygRPk0+TGIL8@vger.kernel.org
X-Gm-Message-State: AOJu0YwIXZObpBrZlbDIzmXpn5s2jeNbldY0IvjxT0+kBgRFUFKXJlOG
	+wbfrrtbDI1Nl2VszVFmyZjs6AiAuBY52vQs1urYTgieqZ15r2uXxbdDVDe+lBGqZ38Bjr/dIfc
	j1FxpxRM+9KvmExBZHZV4+DD0MWIy2K+EOvcr
X-Gm-Gg: ASbGncsiCcdy2hqhDicublA1CJZBghxzhQUDkt7C9LYieBYe6k203ekMWyTtLYbWevD
	JSlDqjxyhWFba8KWyWx9ZZ3EpJ30r1ZmSvBrUdgM0sUc+k3BFM7EvIP+tnkVkgI+LAMEERDFt50
	XoSJLOttPk3VJH6ctkW9bUZh3UWyBo+CWZFEzPHvT0kgQc8ML7hLFjNhA=
X-Google-Smtp-Source: AGHT+IGC6OhQhLhblQDXlW7T4oZnxNtKmyg52BRRYG7Eecnu7rJEDTmRZl6hO4pMB5TJ2eza8MtiCvnCoiAvt74Vtu0=
X-Received: by 2002:a17:902:d50b:b0:223:7f8f:439b with SMTP id
 d9443c01a7336-22799f85804mr3222075ad.29.1742830710575; Mon, 24 Mar 2025
 08:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324152756.3879571-1-tmricht@linux.ibm.com>
In-Reply-To: <20250324152756.3879571-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Mar 2025 08:38:19 -0700
X-Gm-Features: AQ5f1JoRuG3A3vNzieof0Dx0hE6xP7IbfvSZ9Sgmli56VVBGPS-QMQOikuNcZEc
Message-ID: <CAP-5=fXPgoocDSRxzYpkzcLsPwKsp9b80b1KPDWv-obkmiX-fA@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix wrong size to bpf_map__update_elem call
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	james.clark@linaro.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:28=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> In linux-next
> commit c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
> causes the perf tests 100 126 to fail on s390:
>
> Output before:
>  # ./perf test 100
>  100: perf trace BTF general tests         : FAILED!
>  #
>
> The root cause is the change from int to int16_t for the
> cpu maps. The size of the CPU key value pair changes from
> four bytes to two bytes. However a two byte key size is
> not supported for bpf_map__update_elem().

Nice catch!

> Note: validate_map_op() in libbpf.c emits warning
>  libbpf: map '__augmented_syscalls__': \
>          unexpected key size 2 provided, expected 4
> when key size is set to int16_t.

Wow, weird.

> Therefore change to variable size back to 4 bytes for
> invocation of bpf_map__update_elem().
>
> Output after:
>  # ./perf test 100
>  100: perf trace BTF general tests         : Ok
>  #
>
> Fixes: c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/builtin-trace.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 092c5f6404ba..464c97a11852 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4375,10 +4375,12 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
>                  * CPU the bpf-output event's file descriptor.
>                  */
>                 perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events=
.bpf_output->core.cpus) {
> +                       int mycpu =3D cpu.cpu;
> +
>                         bpf_map__update_elem(trace->skel->maps.__augmente=
d_syscalls__,
> -                                       &cpu.cpu, sizeof(int),
> +                                       &mycpu, sizeof(int),

nit: It is usually preferred to do "sizeof(mycpu)" to avoid the
problems like the one this fix is fixing. And I'm blamed for the bad
code in:
5e6da6be3082 perf trace: Migrate BPF augmentation to use a skeleton

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the fixes!
Ian

>                                         xyarray__entry(trace->syscalls.ev=
ents.bpf_output->core.fd,
> -                                                      cpu.cpu, 0),
> +                                                      mycpu, 0),
>                                         sizeof(__u32), BPF_ANY);
>                 }
>         }
> --
> 2.48.1
>
