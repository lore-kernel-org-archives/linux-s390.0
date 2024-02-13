Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8E1173F
	for <linux-s390@vger.kernel.org>; Tue, 13 Feb 2024 05:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707801531; cv=none; b=L/DTOdP/kk0jDMEBZczh09HHOy8E9YIAfUA4JDOxSJbi1Tm5DHz0/nRGuPth32j7ZWw5i/zwqSZfTmMbICodgd/kCyNYioNH8RLIbA1oU4gWG+nYsGXWslmmBQ3TrGNlHEy/NHW/7rUjcE0r3ftVDOSaNpT5nsR82ZYB0tXSiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707801531; c=relaxed/simple;
	bh=eiQTgF1UiR8Q+fk0Adp4OuUfIL1afzXcdoTxy37Yy5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzYYmB7WORJhCacFXYW5qnHvGqhLi5WeddTQWpjA3Vgeh0bfZvs+UHQQHJNgR24c9bg7DQ1on6z6U79ZSXviRLcNG9RPb7FpDaom3j5b0M6BYVD7w/X9n35qnAGEX6Q9ao6BueBbjLO8wfonF2Ugcn0CpEYAX6dFRSofe8aSUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDe9oxXI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDe9oxXI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-410cf70a057so22515e9.0
        for <linux-s390@vger.kernel.org>; Mon, 12 Feb 2024 21:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707801527; x=1708406327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghVxi5tVAq5eNnLPMygpM8GWrTrZsdJ/UPlOsCNOXcM=;
        b=KDe9oxXIL1+dgew9sVRcq0lGImY+/x6DZ4Ho4p6GvDxwBTuTavN0BznCYJIpLO+m8j
         RO7yITROgsdwsM6rnmcph/+n5csiQgidkfLLM76VlPwmkyauiXx22q+A/nil/Kl3GvCx
         Gu1iuQKgoURB3te03YegbnarHNSkiu78+tMIGktghh8Zaau8z90Y3J4DtPSwKVaibwQ1
         XjooOJsvrs19m6O4d1rJh+grLJ9Zef+x51r1+hdMIWAfu9F3fcQyEumDe76MqMkHAl0z
         Gx46Bm/JLra7P5ZIepO2y+m4zEcrSHY0cOrWF8hbd2FrT8duaMlP80bYPuPTfQ00XDTR
         6s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707801527; x=1708406327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghVxi5tVAq5eNnLPMygpM8GWrTrZsdJ/UPlOsCNOXcM=;
        b=tV9ca+NRAICLOS4iuFiDL5i8DRm+pS0zB+2xx/DxsO655PjIUtHm2WYec0VI3Z2Vv8
         9hYqlETF9fXgMfpSBiWdq+60psVZ8M5yv1shbDP//9ShQ5OzRzekbDt6RjpEtBY0BA8X
         qvcgxQ80TXilM/Z5NYpOivHBAmigHHvP1ogAiaCvKgsNJtx+bhk6XDtchRc65700kO7K
         wgar6yPTpIId9e4h9aSUVCVtggg+z3cdqycnBooGr5D9gimPIwYX1Uwcg0YwbblW+kYr
         e0BOBhmFe35V9aQ/2zzDw8J2M95wrwNC1zXTeoJFXB4gj2bAhOcdrDoAomjfs+OkMwub
         D93g==
X-Forwarded-Encrypted: i=1; AJvYcCX8HcS5+Ny/RF1dwbOBx5XgbA2GMvCM/WLShNw2kx/4sfIhJHf9OTD+K9pZyXPUR1ZgpMKNMxspIf4BaXbgF6KqdMpnf1ucWC+Y7A==
X-Gm-Message-State: AOJu0Yz9r9cioXGlTVQYVhn/15DetpjKntuL8xsz5F+MklOSdDMZwzg9
	zyLZTqSIm9fISP7tXmSJ19L2gzkczxEWN/ThkI8dn+Y1TV3GNTzoDxlOFIaHg8V40w+/IVxHMe0
	t68cRRWixf5HWCoMPa61XgEg2FP3GZAhFqTIg
X-Google-Smtp-Source: AGHT+IGIk9vgIyNEuPvEQWVSn9DTVK8z4lhSQ+F7yHiGndjDMSMn8pMG1+J6wBdEBW/Ugy8gdDTVKttr2XXSPJJzZys=
X-Received: by 2002:a05:600c:3d8e:b0:410:87e5:42da with SMTP id
 bi14-20020a05600c3d8e00b0041087e542damr61264wmb.2.1707801527358; Mon, 12 Feb
 2024 21:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org> <20240207-s390-lld-and-orphan-warn-v1-6-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-6-8a665b3346ab@kernel.org>
From: Fangrui Song <maskray@google.com>
Date: Mon, 12 Feb 2024 21:18:34 -0800
Message-ID: <CAFP8O3+L6Jpgktk50UBKg_SodH-DTAW2syZueUqxdZsxrOT3bg@mail.gmail.com>
Subject: Re: [PATCH 06/11] s390/boot: vmlinux.lds.S: Handle '.rela' sections
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
> CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are several warnings from
> arch/s390/boot/head.o due to the unhandled presence of '.rela' sections:
>
>   s390-linux-ld: warning: orphan section `.rela.iplt' from `arch/s390/boo=
t/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.head.text' from `arch/s39=
0/boot/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.got' from `arch/s390/boot=
/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.data' from `arch/s390/boo=
t/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.data.rel.ro' from `arch/s=
390/boot/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.iplt' from `arch/s390/boo=
t/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.head.text' from `arch/s39=
0/boot/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.got' from `arch/s390/boot=
/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.data' from `arch/s390/boo=
t/head.o' being placed in section `.rela.dyn'
>   s390-linux-ld: warning: orphan section `.rela.data.rel.ro' from `arch/s=
390/boot/head.o' being placed in section `.rela.dyn'
>
> These sections are unneeded for the decompressor and they are not
> emitted in the binary currently. In a manner similar to other
> architectures, coalesce the sections into '.rela.dyn' and ensure it is
> zero sized, which is a safe/tested approach versus full discard.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/s390/boot/vmlinux.lds.S | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
> index 2f0bc05664ed..ff8c62d84f98 100644
> --- a/arch/s390/boot/vmlinux.lds.S
> +++ b/arch/s390/boot/vmlinux.lds.S
> @@ -137,6 +137,10 @@ SECTIONS
>                 *(.igot .igot.plt)
>         }
>         ASSERT(SIZEOF(.plt) =3D=3D 0, "Unexpected run-time procedure link=
ages detected!")
> +       .rela.dyn : {
> +               *(.rela.*) *(.rela_*)
> +       }
> +       ASSERT(SIZEOF(.rela.dyn) =3D=3D 0, "Unexpected run-time relocatio=
ns (.rela) detected!")
>
>         /* Sections to be discarded */
>         /DISCARD/ : {
>
> --
> 2.43.0
>

Commit 5354e84598f264793265cc99b4be2a2295826c86 ("x86/build: Add
asserts for unwanted sections")
specifies `*(.rela.*) *(.rela_*)` but it's not clear why `.rela_*` is
included. We only need .rela.* (see also ld.bfd --verbose)

This patch LGTM with this changed.

--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
