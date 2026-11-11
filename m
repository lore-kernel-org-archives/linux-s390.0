Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794382999;
	b=0okAwYTKDr78468a5yObIwuXdnGnvpv56VrWsyXztviBOpLVdk56t3VGKXN9MVPgNity
	 g5nO7ii7yQ/EsllpQVMRuxAz2yss9gV34JlXvhF/Aa2iwtUKEmVD2NDvc+aTCJQ8BtXEE
	 hj9FbkEfMQml3WIAsdx9cFZpgY1FEGLDMVbz4rikGdmylh712ukp3skxKovN5lZKebscZ
	 M7TrMDcAPRww48WtMg97WRlxqBx8YhjfU9p3Hg1T+YaGgxbcg49M+XgujGNMTRROMyPdV
	 UgC3HrsZ7qqf5ma4qaSpjMzDH7KGur3TRsDxLtDgvBOS5bEZCE4nt4OxBx89x61Z6yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=27U7oUdIa14bzFyO20wq2H7dyWDMznLD1QtfCXJzapQ=;
	b=fiQ2fboVLEA8G57j6piWXeo+oWMKmINNZnCZj5/A2vCiH74ExjVr0Fvs7mq0U0HTyFW8
	 FxvF8d+Wz2N57G+fXyX7EyVvCSMffzBTTVKxPpzBxKMrOv9EF5JgOE9X1tZd0AS3dlaQ7
	 3Es+Be9fSuMmSkxNCe57e3scC3rjGLfRcirBzCZTQtdewy3Z6tswsZrzWUFj4kupxEbW8
	 3kci98768Pe8LuvaGNy54ugh755GYBJHOEh3W6Vgr8auIYpQjLuwNF5EK/Y8jPVfj+Pp+
	 LhfrvqO8tFwqvfyqHBQhi3BWIxJ2mZXDrppH/9I+yeKzOpAoxJT+w0CfGtgZIg6tFQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5NQKG5D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5D606A32D
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 07:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDC5D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5NQKG5D
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b757029223so1832835a12.0
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 23:43:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794382997; cv=none;
        d=google.com; s=arc-20260327;
        b=oUFCw0mUbXzwPFq5zP60+dTkSSQXi6GBQvoCScuuC7JElojLwuyeYRS790LM6dqS3a
         0hhpXS1PQc03sBnml0NmpdkK6Ibnb5doxXIpzRqAUyLll6H9zJP9KwzSu8tZrqta9MKt
         /aRN39oCEQw1ZjA2+kTw0uQNIOvtbJQJdFp4tom0lMw9fsybfyBdwJIARLYtbcUkfYGg
         VdoYZTmrnAlZjWRuOClxIHPzxsCXLb+LsQAVAEPHAMBqD5InGwVdMpFw9Jt2Rrk272Mg
         xtgvTRmnu3Ulb5ESc0zEk5/7ehkQs6RoYpkSh6KS6oMfUkuncz2VrgU/FD4sXm5h3SXA
         /Jiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27U7oUdIa14bzFyO20wq2H7dyWDMznLD1QtfCXJzapQ=;
        fh=0GHdW8r31lfAmTCQSaYEhpOI1jMDFs8LAHmScbhWhok=;
        b=WoNGTxMBiAGG7VmJVsY1IIQ6amPf0Zx/0s8c2FtwuFwU435suw6JtYzgAPzD+q3/AK
         UILA0Hu6QRhxGoXJkbEQtFNiZrBjOL3VU72DvI6YwUzWR8UzSu9R9Sa9w7YcCxkXh1Na
         NrO9xlZhXEjkZzIek5UfNhiuXlqAhWjn4eD9e21uIh2WlF72dwvpMZRQzvjMr2I8gMGz
         UBAU0U3/sjyUuGs3/TwOicIXIBbD9TDn4+YT2BaleqDBBn104BWgWZ5iO0ThRDLWEdWI
         f9QoIpjlJf7Pphzui68QyRoh06LGkWjgRoLlyiFjKDGzdE36Rt0Oe4wwNbf2E9Kl6HF+
         MBhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794382997; x=1794987797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=27U7oUdIa14bzFyO20wq2H7dyWDMznLD1QtfCXJzapQ=;
        b=h5NQKG5DsH5k0QdRiJVJ86KtbHIpBxOZtiNveHnZG/t4JAkAZl11gGqvbZh2gbx+CZ
         U7R2l09uEN9Mz6txyG/VHZJvSvlNiFdQj+V+bgbOtkQgjiNZU0CA5FMY6smQ/+4XBAH3
         TyiknHwqbS9a1ikRyqP2U11AjltnFdJ0aJiSYxxvbDIdddHQa9rv+KTy80xEhAMzl3C+
         bIpY5WP4LhG5OSEIpLn1ynS3EgjFFWznVldcdS2uIAoKSyrP0PX27WalhA9H67xC1xsv
         oVv9D9PpI4KM5wKfG/3AUYQbehBCy8YKKKaBfMQR6O76UfhYBDJ2qQ9F1ZaCwVdZpUw3
         DTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794382997; x=1794987797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27U7oUdIa14bzFyO20wq2H7dyWDMznLD1QtfCXJzapQ=;
        b=qLk3FJ75uh54vSCrMSfr2NlUPPoWjMuNbqTDJG91UPN1G0NVcdPo/FcMIaxVLajxIE
         n0jPJMo8Q3GpCsGGORcDgvFYxBEX8AoNbocAulvtCNTTgp7ehpWhrOZfYrztVOHbcLSi
         wTXyrQ0q1txRp5Xed95Fsffc3kXdZaRq6cF9cwf2/qqKpfFAa5t/Cved1y3GO2FUMnJt
         WTyAFcPm2Zmg+U3M7uK5lj0xRwgh3ZbbvA/soKrZ3oVTevpbTIjikYymw75DKTjO4TXH
         svfawjOBsYftdcg/OIBEcsQRpgurmhC8rw1AbKQGJXRNdI6jHgldh5RUyYaL9LYpbBJe
         fjbg==
X-Forwarded-Encrypted: i=1; AL+hErHycE50q9Dqgu3+F6gqLbssijaoXXYM6Hzpwv7mAGfpn9T0bUW41lxGsnMbC7u4a6ZRxfVrZZHB+nD4@vger.kernel.org
X-Gm-Message-State: APuU4Z9lBU2WRan5wdsKYMpPP7SA6PCX/LOePHS+bjbRkf7kCuhwdSJw
	nWt15cT8j9N9maxYDNrrINkkukv4u5KXa8oHQ0H1A7EcgxSb7TgwUlaglh3T/4tJmIuao77WNBD
	v0AB1vAHyj5VkTMCDRbazBEz38HuKvkA=
X-Gm-Gg: AYBFou1DA7Ge7kjkfmPjWv7XFPhKMSL4JMbIrAIb7SvvUKmx7pYOjI0VkQ+i9M7sgsv
	C/S00iz/kRdjZZpecbHOyQb0xZPibQGRVCPyqxi8mf6h6tHVqgvh6VZ4xw560DF2XqcVCvLcz6D
	qnZk32ocjJuUZkJ7g0kfqvS5S23luuqTTGZOld2fK9r8BWc2tC5eTQPPnB3cpDd3lL/sAqZv1sg
	C9F82kiAosqrsU/bHjjOQn5khg1HNwinfV6QWoO+8wRD1/YE9PZMcjkIk6UxSMAm+1A9h9Fc4IR
	ghVID1WHyGULmLucMOKafXEKYtou6jTVQ1/glgB8GpF3WD2wVzHSobHU6mDslFqAQ+o2lAYR74/
	iVZp7T4UfR0+CuEIyxCfpWT8XS2FAkgxCs/Qwp1ebhR5i0dier2ZSLMFFnm8GiG8zrqyAiw==
X-Received: by 2002:aa7:c1c4:0:b0:6b5:90b9:e1f4 with SMTP id
 4fb4d7f45d1cf-6b7773edf4bmr819135a12.15.1794382997169; Tue, 10 Nov 2026
 23:43:17 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com> <20261105-tonyk-syscall_table-v9-11-8d1275885d9c@igalia.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-11-8d1275885d9c@igalia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 11 Nov 2026 08:43:04 +0100
X-Gm-Features: AclHuK-WWcZzAuRTugYoSHBXz8aDMS8vLzO87BtuVYEGxCZ10b0uUmgcqCUEPe8
Message-ID: <CA+=Fv5Tm4-DV9KEKxO11ta84EvqigB-KDemhOML1hx9zoxx0cA@mail.gmail.com>
Subject: Re: [PATCH v9 11/15] alpha: Remove alpha_ prefix from custom syscall entries
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-alpha@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	soc@lists.linux.dev, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9

On Thu, Nov 5, 2026 at 9:26=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
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
> Changes from v7:
> - Fix __clone3 entry
> ---
>  arch/alpha/kernel/entry.S              | 8 ++++----
>  arch/alpha/kernel/syscalls/syscall.tbl | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index 790389a15c3c..25d05f45512d 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S
> @@ -729,9 +729,9 @@ ret_from_kernel_thread:
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
> @@ -746,7 +746,7 @@ alpha_\name:
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
> index 8fc4701a6328..59eb066a40bf 100644
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
> +545    common  clone3                          __sys__clone3
>  546    common  close_range                     sys_close_range
>  547    common  openat2                         sys_openat2
>  548    common  pidfd_getfd                     sys_pidfd_getfd
>
> --
> 2.56.0
>
>

This conflicts with my Alpha for-next:

  https://git.kernel.org/pub/scm/linux/kernel/git/lindholm/alpha.git
  branch: for-next

Commit d38895ba9330 ("alpha: dispatch system calls from C") removes
the fork_like assembly wrappers and changes the table entries to
sys_fork, sys_vfork, sys_clone and sys_clone3.

Consequently, this rename is no longer needed when integrating your
series on top of that branch. I skipped this patch for my integration
test and retained those existing entries.

My for-next is registered with linux-next, so this is an interaction
we should account for when the trees are combined.

Thanks,
Magnus
