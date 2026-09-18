Received: from mail-ej2-f23.google.com (mail-ej2-f23.google.com [74.125.228.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8014DAF8C
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728914; cv=pass; b=oTx4AbJ4yRYnFPniFucQo8zQ35nkypGUm/xRWp1zZKfPQ8CugjhCufjkXQ+dAkmKWMt/rMUKWbEtVItGvKkbHAvYXCrlPiAbBjhD/pDS1KWgBQgiLXKV7CyLzuD2s+wzVaDHj/kbESebQ0L3eFUbra3cuwXW+6z7qwazRyTtrTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728914; c=relaxed/simple;
	bh=0QFLY2cyWzIGxwHrQ7HwSGwbi9sjKL2DXLzkJTDdzU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fu4GVaylh+tWjWBlt4YUESGFYbhhrmrhJCxTztTea0QtyVbXSLUD5sCFok3wcof9JIP31q36SGAA6OL8DW/i9NgVBu10fXF0JwdUIonIc2yyJpjEZqwiAM5D6mD4o8vMeVYD0GV3TQerHrprOsTevWbLmHoHUT0yhO4VqTmjzfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Azd5WHFc; arc=pass smtp.client-ip=74.125.228.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Azd5WHFc"
Received: by mail-ej2-f23.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so74887266b.3
        for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 03:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789728907; cv=none;
        d=google.com; s=arc-20260327;
        b=ozU2J4BxtETONV6RVlEffKjVwH0UBhN/BbWo0Ot9X2EBbTUw7rnez6NmA8zYhkPGRC
         elW6PABAEXchYyKkF/IICQ2xfH0CfaHxkV7HCcafVV74w+vt3oRagus1RaOVgLpbke5+
         fXZWeAPapTgtIJBfLziAT/BB+MPQH0kSNM737w4vEoKpu8CaEGs3Q3gQJlW/jv6hSCLM
         tV9G8hsWLA//IJNKxfgBedPipRbmYL0H/Izcp6v6HwtUgwkCNVj5DQt6Zxr6flJriAWE
         mfD9GnMjUVcT+xaBDjXPcRR9wRkWdgp5s1mu1Nb/9k0Dt5YL1sCOmszNLAMzqrDtSH1M
         oAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c9KFaw0r3zy7as/jjFJHUlbx8sYj2YFXt4OlbArB54Y=;
        fh=8y1qvm0lX8sX+H0eZzyPifhQq/JizX/6L7wEXjoOBR0=;
        b=kwZ1l+0LBvHp0tNK9KI86fy7yuaDP0c4rcftlK2uaQtKMGcrbxMTGEo6Y7inDgP0H4
         DtyzgcRXDq7Bf61Lkm6fQteZwdoqdEWAZCgLx+1rOMnQqwFlmbRSOR+7XsOs6yEc844w
         LBQAq4463HiZNvMFM3gv6ltSJjAqSpb6UvxWnmM0PjdJvKOVboXVczfaEWOLfX0KLeJH
         a6Fm03Vr4qMicaYhjqt39abRBFMUshbecjbkV197tmShOfta0co1Vdi0XhnDVG6oFpxI
         O1A0a43Zr8c6HGd3ctJf3V7y2z35qg5kchBEDfVcpNFHBe3mL1FBLfmGfHDm8Ik4xEGV
         viDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789728907; x=1790333707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c9KFaw0r3zy7as/jjFJHUlbx8sYj2YFXt4OlbArB54Y=;
        b=Azd5WHFc1CvGiYQ9NCg17h0QdQDsKZ1Ic+0GnZXnWRlhTXCHeOt/YKAE0IjeF3RFdo
         mNUlVWWMNvpDH01goCjbtTfi0Wb0g8nlX2FBJGkeqtrHbz9vnW4fm/VQ+kdwbqCSZ1kS
         Oi45Tx85x94cXarLimXLqXpPwrB4/rntqcR3q5+hBllZwHtqJMygkg6UgyHurXqBPemO
         /iVmKyn8SWOHzkRG5ESZV9hfeq3LpxINZGbxIPaCg8OJ0I78rpaQ5l15M18yL2So4NA5
         NCr6l6shtfaJr+Hss/3rPX5iLi+JKMylFgMwfsDg7JxXyd3atCS1RasPfbddZyg9hr7T
         G/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789728907; x=1790333707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c9KFaw0r3zy7as/jjFJHUlbx8sYj2YFXt4OlbArB54Y=;
        b=MrFV2GT3Ud8s5nOG7HdkBLK9XVkIHvB8VTpKxUBFD8R+1rcLVeIycvoGw3TWKT/K9q
         Mqu1A397aSXf/msvCfMSnQg3TklBmAmJBdW5YOipqIdEhpn1SYnhv/m5IXCAylYV+WRW
         7VZDSjbk6oqtMYQHCM1kXRKlxGjLPhYv4SZa9SZ4kOAY7Yp1lGSUSlPzXi4dn3h8RpCc
         Etfkz+dJPEGhsbRVlYjvGOq46gYARXnJzNiyJQx7FdN0Lc2W+GzdYYMcQdXosI1Ci6yh
         JRbJwMIiNhvk1jpeB07uLdXcmrnZZhDY6rd9hiIFVUb1ky8ygHhSts7GxEjQAZljiz6j
         +wkA==
X-Forwarded-Encrypted: i=1; AKwUvByYBDDt5RSiJc5V+EM8Ipx6V78+ErR3yu3eKCYEP0xW4iw57K9MejGTC11/mnOPGDEDtNVQGvHdY4lY@vger.kernel.org
X-Gm-Message-State: AFuF++nIF5jamROOnBxMPmePE90RmGNPGKvKioPIClMW4CxKgDkXWhIh
	YcUO/GwwtlC97rE4RDNXtK9KjnjJ5I3AWyZiwMiJIAfX9a/pf1TGSVcxluZlXtKt4+rlkbja6xf
	Qxz511rIq/ER0PS0TM1vz28rkhLTDM6w=
X-Gm-Gg: AYBFou1ACLp/HbspyuMsacipxob60lAuRyPBTJDy7QdPR4mKv3DMX0bNJbQ1rx04YeO
	2C06oXnWi5QrXSO97b/rXMRL1fmuSbIJTugKmtCdvtZpVoNQ+zSwWR0hPW/AD6OWAI0mnUCBza2
	kfbQz56CTqU1PtQ4BrdHggHBBYT1eteZeYFNkD2HgwYpOGDX+GNJ2vvGu6FQ5F7U/aQoRj3kKAr
	CuobFdrajX2gV39sgM/ok10xtwNIDpnlawH+wC3PkDkHrqpW4rIX540XfHj++JKVf3osLzIQBpI
	42FI9xaGlFaqAUIA6hnuSvW0Z+yBwViYcClm9PLUamZwtXljufXv11ZeLCx5dQq4cVqXzjk/F+W
	TgDwneyWd4Has5OMviOcEVIH4+s1+aoNCa12nCwLhz2V29WiszaK8
X-Received: by 2002:a17:907:d0a:b0:c28:ec7c:27ae with SMTP id
 a640c23a62f3a-c2a15aecddfmr221737866b.25.1789728906928; Fri, 18 Sep 2026
 03:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com> <20260917-tonyk-syscall_table-v7-12-f4cd8f8e3265@igalia.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-12-f4cd8f8e3265@igalia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 18 Sep 2026 12:54:55 +0200
X-Gm-Features: AcwNN1XYBCc8XytQv7lpPsMdlPdL7ChQXyccU8FUv6otEOv13o1h6_2iRPXOShM
Message-ID: <CA+=Fv5Q+sOLmT0Wf3OGdKw=mBt_EoS8ZQDF3wwGrm2-2vnOYgg@mail.gmail.com>
Subject: Re: [PATCH v7 12/13] alpha: Remove alpha_ prefix from custom syscall entries
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

On Fri, Sep 18, 2026 at 1:48=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Some architectures need special entry points for some syscalls (like
> clone3). The current approach is, instead of having a special name like
> arch_syscall, to name if as __syscall. This is enough to different the
> common entry point to the architecture specific entry point.
>
> Change alpha special syscall entries to do the same. This makes easier to
> join the syscall tables. Leave alpha_syscall_zero because this syscall on=
ly
> exists in alpha anyway.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  arch/alpha/kernel/entry.S              | 8 ++++----
>  arch/alpha/kernel/syscalls/syscall.tbl | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index 9f2608de2544..8a85fcf117cb 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S
> @@ -879,9 +879,9 @@ ret_from_kernel_thread:
>
>  .macro fork_like name
>         .align  4
> -       .globl  alpha_\name
> -       .ent    alpha_\name
> -alpha_\name:
> +       .globl  __sys_\name
> +       .ent    __sys_\name
> +__sys_\name:
>         .prologue 0
>         bsr     $1, do_switch_stack
>         // NB: if anyone adds preemption, this block will need to be prot=
ected
> @@ -896,7 +896,7 @@ alpha_\name:
>         ldq     $26, 56($sp)
>         lda     $sp, SWITCH_STACK_SIZE($sp)
>         ret
> -.end   alpha_\name
> +.end   __sys_\name
>  .endm
>
>  fork_like fork
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 8fc4701a6328..a41276634923 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -9,7 +9,7 @@
>  #
>  0      common  osf_syscall                     alpha_syscall_zero
>  1      common  exit                            sys_exit
> -2      common  fork                            alpha_fork
> +2      common  fork                            __sys_fork
>  3      common  read                            sys_read
>  4      common  write                           sys_write
>  5      common  osf_old_open                    sys_ni_syscall
> @@ -72,7 +72,7 @@
>  63     common  getpgrp                         sys_getpgrp
>  64     common  getpagesize                     sys_getpagesize
>  65     common  osf_mremap                      sys_ni_syscall
> -66     common  vfork                           alpha_vfork
> +66     common  vfork                           __sys_vfork
>  67     common  stat                            sys_newstat
>  68     common  lstat                           sys_newlstat
>  69     common  osf_sbrk                        sys_ni_syscall
> @@ -242,7 +242,7 @@
>  309    common  get_kernel_syms                 sys_ni_syscall
>  310    common  syslog                          sys_syslog
>  311    common  reboot                          sys_reboot
> -312    common  clone                           alpha_clone
> +312    common  clone                           __sys_clone
>  313    common  uselib                          sys_uselib
>  314    common  mlock                           sys_mlock
>  315    common  munlock                         sys_munlock
> @@ -474,7 +474,7 @@
>  542    common  fsmount                         sys_fsmount
>  543    common  fspick                          sys_fspick
>  544    common  pidfd_open                      sys_pidfd_open
> -545    common  clone3                          alpha_clone3
> +545    common  clone3                          __clone3
>  546    common  close_range                     sys_close_range
>  547    common  openat2                         sys_openat2
>  548    common  pidfd_getfd                     sys_pidfd_getfd
>
> --
> 2.55.0
>
>

The fork_like macro now defines __sys_clone3, but the syscall table
entry is changed from alpha_clone3 to __clone3.

This should be __sys_clone3, like the other custom entry points.

I also confirmed this by building the tree at this patch, before applying
patch 13:

LD      .tmp_vmlinux1
alpha-unknown-linux-gnu-ld: arch/alpha/kernel/systbls.o:
in function `sys_call_table':
(.data+0x1108): undefined reference to `__clone3'

Patch 13 hides the issue because the common table uses __clone3 as the
ABI tag but correctly selects __sys_clone3 as the syscall entry point.

Magnus
