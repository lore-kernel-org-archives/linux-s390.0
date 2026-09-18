Received: from mail-ej2-f24.google.com (mail-ej2-f24.google.com [74.125.228.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644424E73BC
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.152
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731393; cv=pass; b=ne0wCSqPozP0oXJd6hiClckLarD+XQZuib0A3xHiNd7KD4nGl+hu1Lu+xxxgVFq8rAyxn5XlBt/01Nq80Ok4IsjGic4OqHG88zWYVS7F1cdzgOn8kgWF06MNJZu9L9jt6wfqOzJFaSnZqMagu1ecB+dtbTzTlFVi0F9Tom/ffKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731393; c=relaxed/simple;
	bh=SM+WZSPeuzqNNHXbABDFo7m2xf8ZGs0pqFt1fmpcd8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzURpRmHo9N8/IY1aehin+5N+5b8bLUiZvFGAwCGQMPliKb0nf+5tDXvKO2+vXycpD6Jz8E2BSAZVrZd1rhXhS1I0+r4Pf7eLR2ZvWNrmdhCJQAKiMld4KdyzJdDpqP6qAHkE1/iNoW5HV4YBLSmL2TdQYHnrbCPTkqTKnq2ZhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB0WVjKQ; arc=pass smtp.client-ip=74.125.228.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB0WVjKQ"
Received: by mail-ej2-f24.google.com with SMTP id a640c23a62f3a-c29d33431c8so78097966b.2
        for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 04:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789731389; cv=none;
        d=google.com; s=arc-20260327;
        b=fPvsslGmKH6VVZtnnuLtmnedm9d5LaqtLlqecXrywpf9NKy6vy57t7Q90ShEyuQiDt
         IsICoa1j10GHxMJNcbsssrzLGRWcJRHrFx3OMtNwTtgTAkZ3j7HWL6QT8HPlryloVQyq
         aARQZa5U+i7RO9nPW2qcgT+zQ6uJ37aaLkNw6XSe+GL6Xju8+10G9VnT8NVf6xFRrBo3
         4+3AoMJYkHnC6d9hni1ygYZkF8UyHr3lsuOpXpVwT/6IS+tZCHTY+Zhj7asJhfAn99ZH
         U633035hVCEB957f3g1/xRQ6WQEvQLuUsRYZvhDq0jIuZTmIBD6erKv/njQfGtPx37eF
         G/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HGJXKehN7uzhcfBB0KBhZiEIw68JYp4Edf9oro8cdRI=;
        fh=L7f+yM3z+yi5iyNlmGnOVhSJ69jJLzfuKOmWjHz42zA=;
        b=Z+0TRjndxtEbw1e9ziT2oGEQLcGczWFTfmInHjnyeCCf6mw8/j1XBm9SNYWhsszeVP
         13RS9D7zVSl0yqUEA4iKcZCtPKORqYpl2rp6LzmatFLfLCMPjZM4steUfO23mhrxgc4N
         E7vGq5fVYcxtbRPf8T17vnLcsp9yOs8Be24vC8ltdD3i1jXfnBXGSRMSawTkNMBNC1BS
         CUcMfKvzwuH9ziZnDK0szlyGbB5G9MBGt8QP5mi2+KQBuF4+oD3kDlQokWsWMWe+XXwq
         WrrURVfvccfxUvp58NasuXFtJeaLL/4cyQExbna4fge6/hFZH+Ecr0DjvIVdy6pjEBpZ
         eq0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731389; x=1790336189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HGJXKehN7uzhcfBB0KBhZiEIw68JYp4Edf9oro8cdRI=;
        b=bB0WVjKQFWGFLevQSZ6+wAuVr10y9ueGPJi48P/WjBtC8HiA56X/7cJR6K9vGM0O1b
         LOn9zSnVnB030apqwbpqkCcB8mZ9LvTeNyV8wzjrAVeJPSwPqR0YbfMFFX7oInCp+PO6
         AUrKAP72yTipK6iFJN6rwwDKibX21Hd5VtDQi6St4RCUM1ANGs5FdA15ckkqr0pWqS1M
         dmYrup7gqfRT9F5Zzs0SSzWEO/OrwvnvxLERcm1vKAiyBn3OnaeDPBAat3WD9kx440C8
         44rBdCLqBzQhueA3Sxz9dP/Ix0BSHZ78Qw6u1mlZL+iOzeg6cyHhJb2ZDhy8cpR45RAX
         2B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731389; x=1790336189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGJXKehN7uzhcfBB0KBhZiEIw68JYp4Edf9oro8cdRI=;
        b=NOEhvcrPKCRKsEiFhV0xW81m7Cnoz67/6oGerONWG2jjBOjAeR8sqUKAOhivGPUu0T
         NabcFG6DI8e/fpx/5eQzrgMicnPev2aTHGXb9zIsLue4THbye2PE3+pkLBFucqjo7Elo
         2Cq9XY06c3SYraqTdabLTbEi1a2vlhje7p9Cvj2m6ESAguFseg3XnQX2PlMcJ8TvvefN
         fU4nPSGwU3e6O548EBoFszTuv3s5qU978G1TgzGBirgUEsq2ixqoJ46aU56XglkQKk7E
         K/ZpCyKbMPsmNprf4Wl6hoaXPmpbO7YJcUgmxE8mIew/rIy9kZt5aUzb93Z8VBxiJ5s8
         M82A==
X-Forwarded-Encrypted: i=1; AKwUvBwata42UdzhG7WHc2R5jDD73Zh+Guo5yY1v6/j0O/oN4dWlZ5TCcfw99e46cuiDiCv99KI7302abx7L@vger.kernel.org
X-Gm-Message-State: AFuF++kHHKFevsVvIz3QE3tqSfiH4vhJ+Pyfn9o1HRALlE5YJjRGsMXM
	7fqBRvEdM48IzYg/X01A3bB/FEOJBVdCVlenNVZCAVLyysxDWfPUM6B5s8Rupc1EZR7dOnngBDD
	nKiQIxibxbt2hwpTCdE0l8KgakRf8X5Y=
X-Gm-Gg: AYBFou20o2RNAA5R8zP4QlIQMtNpNjyT1YMiWH68MmTj+ZBHFTaOo6TdROcBuJvq0El
	CYpmqN86HzYB+4iY0VWhlwpMvqsG45vzAXfzSTULwcAl9d9Fq2c6EkinVW20AB8vjq5f0i2uJkk
	fdypUQnRCqgVhRo6Tc9o3LBaDunuEHDsv02/ZvLT/zu8U5Sv1Faq+v4LwVCilrnsUBQ2hSH1yfC
	GwecnJK8M2TcWmWehIIPqJiz789DuCqqfjlEIKdNYAqTJZdh4xX92W0xw9UffTDlJrAmsXkb86o
	NTjiVzpsHSG85p2Oc7d58CXsL60wOwQuwJhOyGbn0OUb1cdjqBZ9UqGoUWNxnQPqUCCo1j7cKak
	QMKqgKxii9il1BFCwWejuaQ1mmgUnJc3KdSc64sXqIQ==
X-Received: by 2002:a17:907:948f:b0:c29:5d41:dfe8 with SMTP id
 a640c23a62f3a-c2a1582698fmr217595066b.43.1789731389390; Fri, 18 Sep 2026
 04:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com> <20260917-tonyk-syscall_table-v7-11-f4cd8f8e3265@igalia.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-11-f4cd8f8e3265@igalia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 18 Sep 2026 13:36:17 +0200
X-Gm-Features: AcwNN1W0uIsrBudlRZeSpl5_CSJhjtWRK4S-OK-90sOk1QFHdqx3jezfZnvgjR0
Message-ID: <CA+=Fv5To=fUfD+9OtAcNJcaquBy+xv6oNUFES6sVwpOKzH8qgw@mail.gmail.com>
Subject: Re: [PATCH v7 11/13] alpha: Define entry point for
 set_mempolicy_home_node syscall
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-alpha@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	soc@lists.linux.dev, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Fri, Sep 18, 2026 at 1:47=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Instead of explicitly defining set_mempolicy_home_node as sys_ni_sycall i=
n
> the syscall table, define it as the real syscall entry point,
> sys_set_mempolicy_home_node. As per commit fdb7d9b7acd0 ("alpha: remove
> DISCONTIGMEM and NUMA"), alpha doesn't have NUMA support, so none of the
> mempolicy sycalls will ever be compiled for alpha, resulting in the
> COND_SYSCALL() fallback being used to result in the sys_ni_syscall.
>
> There's no function change here, but this step helps to unify the syscall
> tables and create a common table to rule them all.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 52e3538cc7df..8fc4701a6328 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -489,7 +489,7 @@
>  # 557 reserved for memfd_secret
>  558    common  process_mrelease                sys_process_mrelease
>  559    common  futex_waitv                     sys_futex_waitv
> -560    common  set_mempolicy_home_node         sys_ni_syscall
> +560    common  set_mempolicy_home_node         sys_set_mempolicy_home_no=
de
>  561    common  cachestat                       sys_cachestat
>  562    common  fchmodat2                       sys_fchmodat2
>  563    common  map_shadow_stack                sys_map_shadow_stack
>
> --
> 2.55.0
>
>

Looks good to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
