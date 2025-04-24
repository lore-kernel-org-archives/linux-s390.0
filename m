Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2311B040B
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531846; cv=none; b=UaDwizDKdUPNWA6x7kIcyooGYRhvOmZ3sP/34Doth2jHwZyPkX+Oe1HlXmc0G4KQXo4cyRjAU0ZNgPr/CR5l4EG5vGhz+s/o/B/DfSw5kNy9miuemGbzJJqWV9BklIB0VsRLYac/obC8L3fl47o49Ys6nbPvIaLDi28hZQQhGIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531846; c=relaxed/simple;
	bh=F/cy9qGnJBDdoAEPSSERWZIHq7qLgf/M0k7Ldr6L/6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHHp7mP9Whp0wostMPu8aaw3/SCGgnymzM9FwoP6Sebad4AnoeW+j8FG8EWeOheuPLhCQC+3hCy/V/jpM3B+JpnTEzi9htGOlTQRiTzL/hSXZJnaFJmefJVmrDrJIsZzkDWF6RmivmZDtGIJXlD2XGkFHDuQvCo/01iazOwHDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uen+WLSx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uen+WLSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745531843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpoZPfro0SHj9mPJ6mKU/fbkIbH6rl7Ujv7LCLlYPNY=;
	b=Uen+WLSxRqBmCBACU6UgZoXbPsvjR3FdjdJsT/baxVHYhj7vXpR20psFyg5EwTGAz9Plt3
	GdnozljDcmrlTAZLLXmBEPUMkeYkA0swareNLGOz+Fcxgtz445GHwsIhwsXT2PXaXvlBDy
	c+t84BYoLsmfYEWD7z9Pqrp6UBz/O7M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-ANvUBCODPyiZCSmfrGQGFg-1; Thu, 24 Apr 2025 17:57:21 -0400
X-MC-Unique: ANvUBCODPyiZCSmfrGQGFg-1
X-Mimecast-MFC-AGG-ID: ANvUBCODPyiZCSmfrGQGFg_1745531840
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso675857f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 14:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745531840; x=1746136640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpoZPfro0SHj9mPJ6mKU/fbkIbH6rl7Ujv7LCLlYPNY=;
        b=Kni4IzMMQkCUABzkNC/WGzla3oiR/uvzaz5JA8ePK3lz6hvz4dGgdKnfCJo8tmxrOo
         iKHq1+7TT3zz13nv+VwEAFU99g4FLlIFBD58DjjemJExRm5DcGitgKXunAJkJYrGdWOi
         2Z5w4m9RoWkGxkCWru/xe45uWZVV11ks7AIVYAfJqqYfWa9r1UfwNN/xkULIzs4cfwXr
         yz7IsDbBd0VcNesHPFS2Y+55mh5fbBsUlaLV1N7bw0XoBaVaRPT85SEnxmT/g7VqCF44
         gETDOLQ1bq+Iayjw1wiSWy/CiT8wy640oxkHuvlG3PElO5NlGLq/PdEbOp76hbRQU8bK
         ksHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpo56ckls3HvpzHmdQrU/UQLnl3WHRybNTbU4OpLbkEUKIrn+dAkidjBqijGVnjo8/6COyTJw+7fr7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2YVh+Skxoh8kzlmhkiEo6uQ2h6DjUppUVu1mS/iVO7scjv2OJ
	QCMiztFjY1mFpwPs4OrvbmlPMMwGiFR3lRwB7Cih14+UvDpIwW97m6sAXx2pUtGRMchjBp1zYfk
	JoktcupJzR0hNDDES2KgV9nTlKPyq/EXRVHfzK2Cft0My4JiR6JpLGGie9OpPJnS81Dgkl1+hHL
	rmef/HTo0JGIil1/RCK6OIqSQ5TKiMovtCrQ==
X-Gm-Gg: ASbGncvIlv5XuO/0UvoiMsjxqCo1C29LuZiwwwh0YVxZtoKb9Zsh1WpgWLFZyx5AV0G
	+g5hJbChddW7z2Isp9WdoubxI/EAhWUKmKe91zshKS9esVP7vwWzVxwfjNoGJgsgUb5I=
X-Received: by 2002:a05:6000:420f:b0:39f:b604:4691 with SMTP id ffacd0b85a97d-3a06cfad4demr3613302f8f.58.1745531840421;
        Thu, 24 Apr 2025 14:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeKzKsojxPFQjf2qyPC/jLCrBU0TIGuJgSXSwemHUuTZespuYvxujkus4uQUh01e60jmTuxs45QJiRsX3qQ8A=
X-Received: by 2002:a05:6000:420f:b0:39f:b604:4691 with SMTP id
 ffacd0b85a97d-3a06cfad4demr3613274f8f.58.1745531839898; Thu, 24 Apr 2025
 14:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
 <20250303-vdso-clock-v1-8-c1b5c69a166f@linutronix.de> <aApGPAoctq_eoE2g@t14ultra>
 <20250424173908-ffca1ea2-e292-4df3-9391-24bfdaab33e7@linutronix.de>
In-Reply-To: <20250424173908-ffca1ea2-e292-4df3-9391-24bfdaab33e7@linutronix.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 24 Apr 2025 23:57:02 +0200
X-Gm-Features: ATxdqUEI0uDThPwtIXkgDnYksB6HJCT6szRwp_ZXnbL9vPXmguxH9v8pzuTDM2Y
Message-ID: <CAASaF6xsMOWkhPrzKQWNz5SXaROSpxzFVBz+MOA-MNiEBty7gQ@mail.gmail.com>
Subject: Re: [PATCH 08/19] vdso/gettimeofday: Prepare do_hres_timens() for
 introduction of struct vdso_clock
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
	Nam Cao <namcao@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 5:49=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Thu, Apr 24, 2025 at 04:10:04PM +0200, Jan Stancek wrote:
> > On Mon, Mar 03, 2025 at 12:11:10PM +0100, Thomas Wei=C3=9Fschuh wrote:
> > > From: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > >
> > > To support multiple PTP clocks, the VDSO data structure needs to be
> > > reworked. All clock specific data will end up in struct vdso_clock an=
d in
> > > struct vdso_time_data there will be array of it. By now, vdso_clock i=
s
> > > simply a define which maps vdso_clock to vdso_time_data.
> > >
> > > Prepare for the rework of these structures by adding struct vdso_cloc=
k
> > > pointer argument to do_hres_timens(), and replace the struct vdso_tim=
e_data
> > > pointer with the new pointer arugment whenever applicable.
> > >
> > > No functional change.
> > >
> > > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de=
>
> > > ---
> > > lib/vdso/gettimeofday.c | 35 ++++++++++++++++++-----------------
> > > 1 file changed, 18 insertions(+), 17 deletions(-)
> > >
> >
> > starting with this patch, I'm seeing user-space crashes when using cloc=
k_gettime():
> >   BAD  -> 83a2a6b8cfc5 vdso/gettimeofday: Prepare do_hres_timens() for =
introduction of struct vdso_clock
> >   GOOD -> 64c3613ce31a vdso/gettimeofday: Prepare do_hres() for introdu=
ction of struct vdso_clock
> >
> > It appears to be unique to aarch64 with 64k pages, and can be reproduce=
d with
> > LTP clock_gettime03 [1]:
> >   command: clock_gettime03   tst_kconfig.c:88: TINFO: Parsing kernel co=
nfig '/lib/modules/6.15.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+6=
4k/build/.config'
> >   tst_test.c:1903: TINFO: LTP version: 20250130-231-gd02c2aea3
> >   tst_test.c:1907: TINFO: Tested kernel: 6.15.0-0.rc3.20250423gitbc3372=
351d0c.30.eln147.aarch64+64k #1 SMP PREEMPT_DYNAMIC Wed Apr 23 23:23:54 UTC=
 2025 aarch64
> >   tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.0-0=
.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+64k/build/.config'
> >   tst_test.c:1720: TINFO: Overall timeout per run is 0h 05m 24s
> >   clock_gettime03.c:121: TINFO: Testing variant: vDSO or syscall with l=
ibc spec
> >   clock_gettime03.c:76: TPASS: Offset (CLOCK_MONOTONIC) is correct 1000=
0ms
> >   clock_gettime03.c:86: TPASS: Offset (CLOCK_MONOTONIC) is correct 0ms
> >   clock_gettime03.c:76: TPASS: Offset (CLOCK_BOOTTIME) is correct 10000=
ms
> >   clock_gettime03.c:86: TPASS: Offset (CLOCK_BOOTTIME) is correct 0ms
> >   clock_gettime03.c:76: TPASS: Offset (CLOCK_MONOTONIC) is correct -100=
00ms
> >   clock_gettime03.c:86: TPASS: Offset (CLOCK_MONOTONIC) is correct 0ms
> >   clock_gettime03.c:76: TPASS: Offset (CLOCK_BOOTTIME) is correct -1000=
0ms
> >   clock_gettime03.c:86: TPASS: Offset (CLOCK_BOOTTIME) is correct 0ms
> >   tst_test.c:438: TBROK: Child (233649) killed by signal SIGSEGV
> >
> > or with:
> > --------------------- 8< ----------------------
> > #define _GNU_SOURCE
> > #include <sched.h>
> > #include <time.h>
> > #include <unistd.h>                                                    =
                                                                           =
                                                                           =
                #include <sys/wait.h>
> >
> > int main(void)
> > {
> >         struct timespec tp;
> >         pid_t child;
> >         int status;
> >
> >         unshare(CLONE_NEWTIME);
> >
> >         child =3D fork();
> >         if (child =3D=3D 0) {
> >                 clock_gettime(CLOCK_MONOTONIC_RAW, &tp);
> >         }
> >
> >         wait(&status);
> >         return status;
> > }
> >
> > # ./a.out ; echo $?
> > 139
> > --------------------- >8 ----------------------
> >
> > RPMs and configs can be found at Fedora koji, latest build is at [2] (l=
ook for kernel-64k).
>
> Hi Jan,
>
> Thanks for the great error report.
>
> Can you try the following change (on top of v6.15-rc1, should also work w=
ith current master)?
>
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index 93ef801a97ef..867ce53cca94 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -85,14 +85,18 @@ static __always_inline
>  int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_=
clock *vcns,
>                    clockid_t clk, struct __kernel_timespec *ts)
>  {
> -       const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data=
(vdns);
>         const struct timens_offset *offs =3D &vcns->offset[clk];
> -       const struct vdso_clock *vc =3D vd->clock_data;
> +       const struct vdso_time_data *vd;
> +       const struct vdso_clock *vc;
>         const struct vdso_timestamp *vdso_ts;
>         u64 cycles, ns;
>         u32 seq;
>         s64 sec;
>
> +       vd =3D vdns - (clk =3D=3D CLOCK_MONOTONIC_RAW ? CS_RAW : CS_HRES_=
COARSE);
> +       vd =3D __arch_get_vdso_u_timens_data(vd);
> +       vc =3D vd->clock_data;
> +
>         if (clk !=3D CLOCK_MONOTONIC_RAW)
>                 vc =3D &vc[CS_HRES_COARSE];
>         else
>
>
> I'll do some proper testing tomorrow.

That does seem to work for the 2 reproducers I have.
But why is this change needed? Isn't 'vdns' here equal to 'vdso_u_time_data=
'?

>
>
> Thomas
>
> > [1] https://github.com/linux-test-project/ltp/blob/master/testcases/ker=
nel/syscalls/clock_gettime/clock_gettime03.c
> > [2] https://koji.fedoraproject.org/koji/buildinfo?buildID=3D2704401
>

