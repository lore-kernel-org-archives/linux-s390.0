Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8EE10793
	for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706671730; cv=none; b=Zvv9okLOm8/9WkNHGKrREjk9DJ9ZhTYBkZ4BCd3IWmLrjNXHNduZV9exeEapXpe10uCq/7zCTxrNKzcMu08st8EdBarjC22vjbXImsBUiCdX0cbMIoSrlpCVQm1I1MjvtlnY34l5K00WdEo3VlETWL9njFkQbbuAHVNWZLhB/X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706671730; c=relaxed/simple;
	bh=yQ/eYdla+PPU4xd8dAVC1+5DW9+ZXc6YyYJNNjCMHug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvWS9IEhOQ+DkhUK7x8YCAv+75MZJpj1QGT4aDPD6kfy5cXL3KIIIbu4BqLYJvQJdG6ZzfzKA8Cp60a1w0QLwVNt3mwrG2lwntVs/nml3LWxQszEPBLpS0odCdwSxQ31QN3T34Wf3sZCflUmlUbPRXIPWTFyYsVqazRkp3q/Wrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MzbOe6YE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MzbOe6YE"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so2854a12.1
        for <linux-s390@vger.kernel.org>; Tue, 30 Jan 2024 19:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706671726; x=1707276526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMaeQ3oL3vIsw8IAljbZcrRIbWnWJagVMsJJWiw2xCg=;
        b=MzbOe6YE/o6bZ+asAglntw4oNqkY976YP4BwWmsLMslst6o0E9O+HFuviRWJsGe1wo
         MJDbpJZDI6lijW7qEOtVLT4onqpItMeEsothZCYxL8BGBnp0b0w/UCrggsFFIMqOSVLo
         cM2OReU7rqnFnMinnKXxOkQYCL4MGvFKfVSUQ4adU/LuDMrQagWJi57NsGop0bCzwwVD
         AvbGdfdmh1u86QTVzWb5G9/0Y1IOn2RgAj7JDRM50UzO9I4Vwa4tBYNri8H9QmXBrMt1
         bPHe0ci5Hucz0/xoUNN92gUTpo+i1gZp0iL8mR5p8OSDEapIHfDvKpH9+ISE5n4qUCRT
         HIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706671726; x=1707276526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMaeQ3oL3vIsw8IAljbZcrRIbWnWJagVMsJJWiw2xCg=;
        b=CZBosOI9vGSsutaqUbRcHxL/qhs4AD2llsiv7lgnzqaz+64V4BKbFIqEPcguajrQUu
         NFwAyDacjBU2phifZYH9xC96s57r+LI0lIqG2yXuOdMQ0d+kyRPlbxRwjoITPYDjhu06
         MmJCUFSa79AIW7nEVv8ySajKQ80w8U9UoLWIFsip2qtRHtKcPsr+oPKji9bSU+ZT3JWr
         /M2kIpePFi+7QB0M0XKxQ2tsSij0CLvAw9KbqZSIJQ+ykMVPwC3PWrlS8JemdfMXyjpt
         yBmedcweQViuWlCNgRRkmb9mSZR5xapiearTCG7TxA0Vg86hBbRnyaZ1c1jVUFuZpjq3
         Z3Gw==
X-Gm-Message-State: AOJu0YzgMPOuBFKcfQvRNenJ2JoGsyO8Ltwsm3ctNafUhJPiBZCWMZNY
	XtrnSyvDMnlwYGK8OaqB0DkTBYmGb13PnVRgkak9VIlIZsDoTM8sa0seW5Qs8xLClgzH3KXoJHG
	9uajdBm0BMZgs5qtSrIpMqHBnGgSeHqJwPTY176apkYugh9dYibHM
X-Google-Smtp-Source: AGHT+IE1afFuPkgFJnTjU9lwWGU9GDpyqxFFzYhgU/X8bfK9rPLvyTV6OV99NSfV6MIdBW9wmYlAH31tyBWJXhO4S5k=
X-Received: by 2002:a05:6402:30bb:b0:55f:8851:d03b with SMTP id
 df27-20020a05640230bb00b0055f8851d03bmr20873edb.5.1706671726058; Tue, 30 Jan
 2024 19:28:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-s390-vdso-drop-fpic-from-ldflags-v1-1-094ad104fc55@kernel.org>
In-Reply-To: <20240130-s390-vdso-drop-fpic-from-ldflags-v1-1-094ad104fc55@kernel.org>
From: Fangrui Song <maskray@google.com>
Date: Tue, 30 Jan 2024 19:28:32 -0800
Message-ID: <CAFP8O3+73mVLzrfAE4mS3AQ9LGu+kmrq7s+_U2x+8sK3NP5Lxg@mail.gmail.com>
Subject: Re: [PATCH] s390: vDSO: Drop '-fPIC' from LDFLAGS
To: Nathan Chancellor <nathan@kernel.org>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, linux-s390@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:14=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> '-fPIC' as an option to the linker does not do what it seems like it
> should. With ld.bfd, it is treated as '-f PIC', which does not make
> sense based on the meaning of '-f':
>
>   -f SHLIB, --auxiliary SHLIB Auxiliary filter for shared object symbol t=
able
>
> When building with ld.lld (currently under review in a GitHub pull
> request), it just errors out because '-f' means nothing and neither does
> '-fPIC':
>
>   ld.lld: error: unknown argument '-fPIC'
>
> '-fPIC' was blindly copied from CFLAGS when the vDSO stopped being
> linked with '$(CC)', it should not be needed. Remove it to clear up the
> build failure with ld.lld.
>
> Fixes: 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link vDSO"=
)
> Link: https://github.com/llvm/llvm-project/pull/75643
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Hi all,
>
> The LLVM folks are working on SystemZ support in ld.lld and this issue
> came up from my initial testing. There are also some other issues that I
> have come across in testing that I note in the GitHub pull request
> linked above. If they seem like kernel issues, any expertise or help
> would be greatly appreciated towards getting this working.
>
> Cheers,
> Nathan
> ---
>  arch/s390/kernel/vdso32/Makefile | 2 +-
>  arch/s390/kernel/vdso64/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/M=
akefile
> index caec7db6f966..b12a274cbb47 100644
> --- a/arch/s390/kernel/vdso32/Makefile
> +++ b/arch/s390/kernel/vdso32/Makefile
> @@ -22,7 +22,7 @@ KBUILD_CFLAGS_32 :=3D $(filter-out -m64,$(KBUILD_CFLAGS=
))
>  KBUILD_CFLAGS_32 :=3D $(filter-out -mno-pic-data-is-text-relative,$(KBUI=
LD_CFLAGS_32))
>  KBUILD_CFLAGS_32 +=3D -m31 -fPIC -shared -fno-common -fno-builtin
>
> -LDFLAGS_vdso32.so.dbg +=3D -fPIC -shared -soname=3Dlinux-vdso32.so.1 \
> +LDFLAGS_vdso32.so.dbg +=3D -shared -soname=3Dlinux-vdso32.so.1 \
>         --hash-style=3Dboth --build-id=3Dsha1 -melf_s390 -T
>
>  $(targets:%=3D$(obj)/%.dbg): KBUILD_CFLAGS =3D $(KBUILD_CFLAGS_32)
> diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/M=
akefile
> index e3c9085f8fa7..caa4ebff8a19 100644
> --- a/arch/s390/kernel/vdso64/Makefile
> +++ b/arch/s390/kernel/vdso64/Makefile
> @@ -26,7 +26,7 @@ KBUILD_AFLAGS_64 +=3D -m64
>  KBUILD_CFLAGS_64 :=3D $(filter-out -m64,$(KBUILD_CFLAGS))
>  KBUILD_CFLAGS_64 :=3D $(filter-out -mno-pic-data-is-text-relative,$(KBUI=
LD_CFLAGS_64))
>  KBUILD_CFLAGS_64 +=3D -m64 -fPIC -fno-common -fno-builtin
> -ldflags-y :=3D -fPIC -shared -soname=3Dlinux-vdso64.so.1 \
> +ldflags-y :=3D -shared -soname=3Dlinux-vdso64.so.1 \
>              --hash-style=3Dboth --build-id=3Dsha1 -T
>
>  $(targets:%=3D$(obj)/%.dbg): KBUILD_CFLAGS =3D $(KBUILD_CFLAGS_64)
>
> ---
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> change-id: 20240130-s390-vdso-drop-fpic-from-ldflags-0338365b4bc5
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
>

Yeah, this is a problem of GNU ld using getopt_long with a
`required_argument` short option, and mixing one-dash and two-dash
long options...
There is also a grouped short option problem (-ts =3D> -t -s, -st =3D>
`unrecognized option '-st'`), which I managed to nudge Nick Clifton
into implementing a warning for common misused cases...

Reviewed-by: Fangrui Song <maskray@google.com>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
