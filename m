Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7729125AE
	for <linux-s390@vger.kernel.org>; Tue, 13 Feb 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707802398; cv=none; b=Gq+P4a/FvD2G4i7tP2TfKz4GzWH48/B2kYBoegldwEdfBUZGNBY7SASjppu6L+N8n3i8nraWh88ZDocF7lhBFttyEhaj6lQtDvSx7ELeB1cQS63XQIXfgh2DpxhN+07UZgfP+dq64D3E0Qd4XTV37b23o+8fqzIxDShdG7b1V6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707802398; c=relaxed/simple;
	bh=02Q8SrULMcBSD7ttAGWmB8PIKrympbUDiwhvHFHIOIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgskWD6qIYiYM6rCLzAizQ4e1Gv2UlpujPMZvi1Mq9vT4W8P36LrWjSVXBnCZJFdI0Wl88ObEJHr8Npmm8eIftUt0TxRXUfMKi4jRgapZBZHumafEuDNnoTwHDNEgHtxqzvmJT6U8PhRkeHkp9QYg+isUUsa6BCJ5YimCx7yHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQGKXsIQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQGKXsIQ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56101dee221so4238a12.1
        for <linux-s390@vger.kernel.org>; Mon, 12 Feb 2024 21:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707802394; x=1708407194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XETlmfsLFShyCAFBnC+zhCwZVHqHy0Tkff4Gvlg5js4=;
        b=lQGKXsIQ1ODfP1giCizNWaMgDJ2MeF6EKFMjgd+fRG25TmE5aA6dM1EaWrSN6Lu6hS
         QLZJt97QDQBUGfqS+mDYBkoM4mpeSPaUn2nHKpmgyYT5QO31qXZ1tN71gokhv/DYX3F+
         il91Qt5vADjlSyWNaQiq5fhOT2uhCpDlCz9kP54xoEVkB6u7RjaoUH0LhXYo+byImY7V
         IyiydKkhtJEDi30I9pG8HvZPuPnNKpsahQHQ4+y8LyZZiz1whnvIHdF93OvePqmVw7uh
         kl/Cmqg0thcx3e5cZzOyIkIV8u+iNiQVuaffRqhJgyZv7ZmHgAIGcjjX0fpiPQGk+P01
         SBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707802394; x=1708407194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XETlmfsLFShyCAFBnC+zhCwZVHqHy0Tkff4Gvlg5js4=;
        b=jPDD4LhSCIWjPjWb/7nMMEf+idXASW5fahwHyE7MDAGbX0isH0BPzegfHp7Cs7nEf4
         aCzSRR6mz2qHMhWdEs8NVkCNSbdpGWTJZ/ZO5A1mHwb5l32LyOQhHPxDnlc0L1GSBG+M
         6lM4BC14bUzOWBXL8aJoOyGELkpSxfvit1yf5vtMRJdeLJs38W3TkhSmYBoGoWZ0lID5
         7jAH61P7A3GtS11gDwR441CwgkNDkroWDkDe9CfaZ9EnjUF1znSba4G/dyPTfjI8SGob
         fB899bwXfK5BYvdiKx/QtS7Wupu4d0saHkVPthbFkxPC/rvU9gv7Gn75/15odCGv9tfc
         FU8g==
X-Gm-Message-State: AOJu0Yw8jKsmhpYNB8CloECZPbGsgnTU96mHNWwa7vwdzuB7iw7n+1WX
	0hZdE3V+efQtbvZGVhD10L6aNlLlqgU17EC3grtnXnd2Ag4l3/EvrjnFBFME7hgu3kfSylZDn7C
	Mj/clLiKg285oH5gZk1JLXNLBXKyMGkIma+Th
X-Google-Smtp-Source: AGHT+IGZwj4j5QHgqbf9M6ktVVQXLrk8Drh5qXX7tCSAml5AXcdIY2mAHCO3BaKHjRfwXHDOxgMo1HGswGGrIk/pIvc=
X-Received: by 2002:a50:f615:0:b0:561:d84d:f6ce with SMTP id
 c21-20020a50f615000000b00561d84df6cemr80706edn.6.1707802393936; Mon, 12 Feb
 2024 21:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org> <20240207-s390-lld-and-orphan-warn-v1-7-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-7-8a665b3346ab@kernel.org>
From: Fangrui Song <maskray@google.com>
Date: Mon, 12 Feb 2024 21:33:02 -0800
Message-ID: <CAFP8O3KuJRuDFC3M=4DS2SVjzo-gcKzNYVAPLmsexnjEifOuZw@mail.gmail.com>
Subject: Re: [PATCH 07/11] s390/boot: vmlinux.lds.S: Handle DWARF debug sections
To: Nathan Chancellor <nathan@kernel.org>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ndesaulniers@google.com, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:15=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> When building with CONFIG_LD_ORPHAN_WARN after selecting
> CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are several series of warnings for
> each file in arch/s390/boot due to the boot linker script not handling
> the DWARF debug sections:
>
>   s390-linux-ld: warning: orphan section `.debug_line' from `arch/s390/bo=
ot/head.o' being placed in section `.debug_line'
>   s390-linux-ld: warning: orphan section `.debug_info' from `arch/s390/bo=
ot/head.o' being placed in section `.debug_info'
>   s390-linux-ld: warning: orphan section `.debug_abbrev' from `arch/s390/=
boot/head.o' being placed in section `.debug_abbrev'
>   s390-linux-ld: warning: orphan section `.debug_aranges' from `arch/s390=
/boot/head.o' being placed in section `.debug_aranges'
>   s390-linux-ld: warning: orphan section `.debug_str' from `arch/s390/boo=
t/head.o' being placed in section `.debug_str'
>
> include/asm-generic/vmlinux.lds.h has a macro for DWARF debug sections
> named DWARF_DEBUG, use it to clear up the warnings.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/s390/boot/vmlinux.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
> index ff8c62d84f98..83af17bfe630 100644
> --- a/arch/s390/boot/vmlinux.lds.S
> +++ b/arch/s390/boot/vmlinux.lds.S
> @@ -122,6 +122,8 @@ SECTIONS
>         }
>         _end =3D .;
>
> +       DWARF_DEBUG
> +
>         /*
>          * Sections that should stay zero sized, which is safer to
>          * explicitly check instead of blindly discarding.
>
> --
> 2.43.0
>

Reviewed-by: Fangrui Song <maskray@google.com>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
