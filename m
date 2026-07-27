Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23581417D9B;
	Mon, 27 Jul 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163652; cv=none; b=XwnGXJ9xFnlUgaeGw7QiGlnGJkCapWh4gXtcKOO4vEvkTj68MlPLeof+SdmllR7sZLTVpekxwy/ju45WwFK6gOJAhtuQPz1L6KipuQiTbRpfTlnlcscz9S8KkZpGbPbbHIrhrh1SRCtzQ5LkZd2G0z0jGTpJA9hXdRqDB2JTfxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163652; c=relaxed/simple;
	bh=Hd/AHfSTzHHiAtU+zH+SrI35lxZjDlN+3DNALcPdAvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CYlYNw07OXAwTZblcuK6avjDzJnARPej0F83C1YO9Uewp2d9Ac5iACKlndqrWWf8ZyOWZeHzTrqb/fyv2u9FsHv6k0Xsq7Jmp0/J0zIvaMhuCKRRLxZPNfRXpZwjQu9Plx7l//+et2J/nPbz3fWneMT6oZJjub2rmrhub3JF7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnCJeQUj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnCJeQUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E141F000E9;
	Mon, 27 Jul 2026 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163650;
	bh=Gh+keKc1CwrdfFwv0W4nZGeYEitzShQF3Yp066ZV4qk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fnCJeQUjr3fjNcZSW2d5wASdSCYp38pfiKcySGkgMKL+LqU3+Xha9IuEcaSAE/Aru
	 5ulXHWA2qQ6n02kePW//Q6Egnmb3qYq3d7Nvkj3LVIc+6DtkouAFxIB8f/4e0i/mA3
	 DBFr/aHcX+dh9Tll8NHxgyM0X6GJPSbxLb0yyeLjLv02X7R4ZKiHEgsV8qGX//eBsq
	 E/PT8co9xgMf0logP+MOnGmwcBhPyPgfWaFANk3ZW05aIsbbI662K6Bu43khztoJT8
	 rc1jysSc8mcVMGDF2UUxCYgevpaCv9srz7OJmUHGXtrXDcUiLb1jaHBh10fupClBLL
	 7RHjTpR9P8Utw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] s390/bpf: Add kCFI support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260727140514.116501-6-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
 <20260727140514.116501-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:47:30 +0000
Message-Id: <20260727144730.68E141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The s390 BPF JIT leaks `s390_jit_data` and its associated `jit.add=
rs` array when JIT compilation fails during a multi-subprogram compilation.
--

--- Patch [5]: [PATCH v2 5/6] s390/bpf: Add kCFI support ---
commit 90cf9cf344f10dd1f477562c9b9f57c7b89998a9
Author: Heiko Carstens <hca@linux.ibm.com>

s390/bpf: Add kCFI support

This commit adds kCFI support for BPF on the s390 architecture, mirroring
the existing arm64 implementation.

> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c

[ ... ]

> @@ -2401,11 +2417,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_v=
erifier_env *env, struct bpf_pr
>  		jit_data->ctx =3D jit;
>  		jit_data->pass =3D pass;
>  	}
> -	fp->bpf_func =3D (void *) jit.prg_buf;
> +	fp->bpf_func =3D (void *)jit.prg_buf + cfi_get_offset();
>  	fp->jited =3D 1;
> -	fp->jited_len =3D jit.size;
> +	fp->jited_len =3D jit.size - cfi_get_offset();
> =20
>  	if (!fp->is_func || extra_pass) {
> +		for (int i =3D 0; i < fp->len; i++)
> +			jit.addrs[i] -=3D cfi_get_offset();
>  		bpf_prog_fill_jited_linfo(fp, jit.addrs + 1);
>  free_addrs:
>  		kvfree(jit.addrs);

[Severity: High]
This is a pre-existing issue, but does this code leak jit_data and jit.addrs
when JIT compilation fails during a multi-subprogram compilation?

When extra_pass is false and fp->is_func is true in bpf_int_jit_compile(),
the function skips the block above and returns without freeing jit.addrs
and jit_data.

These resources rely on bpf_jit_free() for cleanup on error paths, such as
when a subsequent subprogram fails to JIT. However, since s390 does not
implement a custom bpf_jit_free(), the generic version in kernel/bpf/core.c
is called. This generic function only frees the binary header and leaves
fp->aux->jit_data behind.

Could this be repeatedly triggered by a user loading a multi-subprogram BPF
object that fails during JIT, potentially leading to resource exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727140514.1165=
01-1-hca@linux.ibm.com?part=3D5
