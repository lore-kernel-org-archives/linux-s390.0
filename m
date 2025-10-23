Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F55824A3
	for <linux-s390@vger.kernel.org>; Thu, 23 Oct 2025 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252401; cv=none; b=h+v6Pxu6DNeYguUDvCkH14PYFsMbsXnGHlyel8Z1r3SQZLIg1FaPM7jPnRMw1NCd+E595f4qE44ukeAz84Zj/QXLHUvW6MFsvK19/zZ4O+U/RPrii3PXz+TkRTaw1ax/VcBnbvkLzUcqzknDXAmP+h+A4RPCz5mwm7mtxKi94kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252401; c=relaxed/simple;
	bh=QlMqgB/DvSdM8KR3jSVQV/jC7s7437edyH5mR3uXaKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuuyRRTfpKGbCvKn6lNn0JgK1kGCCuRNFEyGKTdb94uS1xoWrzQtC463Tz+rpeJ5kqJU9Y6OXT2zt1mQArk03y3HbcZT9tpGHxFFeP4MCTgg5TqhACriK1T0b/gOqrfLT2ZnjmrHg12WnQHFf6jERjDnYWkgpYWW9TPdpUheqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fT//CmHy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fT//CmHy"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33d28dbced5so1694572a91.2
        for <linux-s390@vger.kernel.org>; Thu, 23 Oct 2025 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761252399; x=1761857199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd5j7WCGmo+xLbyRE05r0rLbjZefkRPui0eHRBgXG1Y=;
        b=fT//CmHyWUTS89WvZ/zL5+KwIT2VEzZLo+cGkH4DVRgS0hn3148eJrikBO8hPYMZ+h
         Fd+wZM96AFYk7rlqzKiF6hw1i7mtKqXO1QzIzwG0wm7gta6HyHhtav9nzBLv5Tt+a18m
         CdI7pJRN+nNPpgMSYQmJcjz74A50EoKIrYHBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252399; x=1761857199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cd5j7WCGmo+xLbyRE05r0rLbjZefkRPui0eHRBgXG1Y=;
        b=nnNBhv1PJjRxLB0czMiCGuH4oRk+zpxerV5DENbk9SY7Efxar/w8C9hLGx2jN2Qjz5
         KvNmZOMTKbHK2AlC5pG+tVBv4czro34CgaKf9vJOuW1shtWcQ8+trIT02pEMf8vyXDJi
         ed+Upi/gYmhtm0zhZo+IT2ikvutW/JmBpuLwr3THi39zhmrDXxo0tvM10az4lnrlLEq9
         qnLff+Ww0OrFL73BoUTn2k2xKXMPRr42/rQJ1PtZT+FEwhPQHlIa/699uEQfiKaZ0d5P
         ldyRgGnUKM3rxvDla5CjyH8pifJmnegxmrG9LuAdSokYMAUEP2p5qWtKTKIsdVYACsxD
         qixQ==
X-Forwarded-Encrypted: i=1; AJvYcCWicJYpH+JR9AMxXcppZXUTshQ/cLukwYmSlBY3jjU5ciYzCAUgr0i7Ltt9vac1on3vZ/2EsvlNB4fQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77ZaLgCvSwXMipX1nLaOTGqz7lRx2DAm5BxVFUw9VY3iwviFZ
	FzYU/gKTDVAvb+cN3rEVSgJCr6BCT8Da7w8jVnHtPDQdKkv9HD95Uz1UIH2CC6FPJwIvP1OKFJY
	4piM=
X-Gm-Gg: ASbGncuM2yG0AvMKBh0hU+Kpi/CZwGYSIglbXXS3hOGy2lRDAcUsy/Cy/4us6Ubi9L4
	Pt6iweKIoRetsaKF5fNdIUfG2bktjss5e/SsZw7/ngWoPPtjEgt/QDdzjLDowZuzZvSfoPtLMKz
	WQz9McRWvoY+IVH//mSP/MXUqH3o7wGl6xRgUMIiUvI9X1+yhJn4d4E1lXXnGb5cmkVTHMUCBgT
	6cgdnZKQ+dsODMjW8cRjuhQpWMiuYzStJ2JO4uzidYvCPvCwhebXr9zM6xsS1YDIRCery1SVia4
	fytPyDVf0Xozq8GC3tTatsckwUgI6xPJiGo14WwsPm7pBQdA1XyHQdodjhhBZQy+8Sbn0YLMpE6
	zki0nLQZCQPbu5eI1IaJs2nYvNzaWeJPSKDi/jf3WRKBa9Xzvce1WNDL8CdjiOPsmubCpqjCA/G
	8vNcXXDeyjul8DQJhtb1VowTTuKIQmC8R2pDI23wkVrVg=
X-Google-Smtp-Source: AGHT+IHp/LA/W4OJMhTJ2uDRgbXAFEq5gIGbmbUzS3ehLSIbXvDNJLDy2zjSnDybk6KPZ7974LcwnA==
X-Received: by 2002:a17:902:f64a:b0:292:40d8:70a7 with SMTP id d9443c01a7336-29240d870ebmr273721365ad.54.1761252399113;
        Thu, 23 Oct 2025 13:46:39 -0700 (PDT)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc12a8sm32669585ad.57.2025.10.23.13.46.38
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 13:46:38 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eec33b737so17758965ad.1
        for <linux-s390@vger.kernel.org>; Thu, 23 Oct 2025 13:46:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUueVkYiYO7PcuRohZhvGW1aGas69S86c6pO3QrTh/N8o1720rJeG24eiL9HHgsbqaOmp8iQb3fY66G@vger.kernel.org
X-Received: by 2002:a17:903:3d0c:b0:267:af07:6526 with SMTP id
 d9443c01a7336-290cb65c541mr337299685ad.55.1761252397871; Thu, 23 Oct 2025
 13:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <20251023123709.e6517087325a3a53221029d9@linux-foundation.org>
In-Reply-To: <20251023123709.e6517087325a3a53221029d9@linux-foundation.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 23 Oct 2025 13:46:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VRz1tPLUUvpodCjYdtFxzHzyOwg1=3eHqpSMESnfNuFA@mail.gmail.com>
X-Gm-Features: AS18NWAE14eSsiojjZQmHOO46K0MXeyhEUGAiOPE-8PYVL0YziEtjCg4rJf3wqo
Message-ID: <CAD=FV=VRz1tPLUUvpodCjYdtFxzHzyOwg1=3eHqpSMESnfNuFA@mail.gmail.com>
Subject: Re: [PATCH v3] init/main.c: Wrap long kernel cmdline when printing to logs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Andrew Chant <achant@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <hca@linux.ibm.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 23, 2025 at 12:37=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 23 Oct 2025 11:33:05 -0700 Douglas Anderson <dianders@chromium.or=
g> wrote:
>
> >
> > Add wrapping to the printout of the kernel command line.
> >
>
> Spose so.
>
> >
> >
> >  init/Kconfig | 18 ++++++++++
> >  init/main.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 113 insertions(+), 1 deletion(-)
>
> It seems like a lot of fuss for a small problem.  But this:
>
> --- a/init/main.c~init-mainc-wrap-long-kernel-cmdline-when-printing-to-lo=
gs-fix
> +++ a/init/main.c
> @@ -944,7 +944,7 @@ static void __init early_numa_node_init(
>   *   Kernel command line: jumps over the \
>   *   Kernel command line: lazy dog."
>   */
> -static void print_kernel_cmdline(const char *cmdline)
> +static void __init print_kernel_cmdline(const char *cmdline)
>  {
>         size_t len;
>
> _
>
> will make it a whole lot more palatable, no?

Yes, thanks! ...and I saw you added a followup patch that does that.
FWIW, I'm fine w/ keeping your patch as a separate one or I'm happy to
fold it into my patch and post it with whatever attribution you
specify. Just let me know.

If you want to keep your patch separate, feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...to it.


-Doug
