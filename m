Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBFA409608;
	Fri, 24 Jul 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903692; cv=none; b=G20J3YbSfxyHitszpx7RGcE8EvAu1hKtnXuR8ATMclrigIswB4PnnJn0O8IRNaG2apBsqi41eK469yEUSgjTKJ0WYu6BJmgIZULTsdjhbloU5WwYcAmd31sloJbEzjWrn5+pRXyeDONpMMZkdr4SNDZJdTwQ53DQQAM6ZQh5Uk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903692; c=relaxed/simple;
	bh=4lmCq4LbPbYv2k3pYEf/I1/+tzhXtJJrywGHxdp5yTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QjWCNwHGkzrjqvqMnWEQ+mSFiVw3J7XHS7LP01XaIgyRr/FWfLmhCCvXgb/J+mzVMgDZqnaudMLgZNGF7fJ3c8iZ63nyqidtEqqPcfCg3vUc/dH7J0526Eo0H3bEcANWgkSxk+zTMJdquixG38iEgu6b/bgtaI7OYROIfCHdFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsFUUbU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsFUUbU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08831F000E9;
	Fri, 24 Jul 2026 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784903689;
	bh=GBDBmg2CPKEg5YjNZKmb5/bmQDSejvsj9LvkjzBS8wk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VsFUUbU4nQzm9RNoaqPMN6v1ucDGBQspbq7FVvPXMo2A0+A6yNxTEc4N5wr2cFeIk
	 c31bU+N7w5HRAH/VzmomHE/x7gu0P0RaFMBldclvCSAvx+lGEVVIE9Ssz8LcwRhWjT
	 X2BKcewpWMFDf8Kb6PAgat/qZ+d8LOJI/GwzzbivDDbNv9FNDmJIli9CrDG4hgoNcz
	 8Tiu94JOIMOdFj+7eZRjwuVhsHO8pcLvvJh1y5k/sxd8b0dX/Gtn+FflF4XsRP+nnW
	 KVi8ayW4D2QaJ6AmSUQWjg5vKNXezLw+OeCkMWu7kZIOACJtPbRXdueZ+S6nA3zBJz
	 wvnH00k72u1RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] s390/bpf: Add kCFI support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: bpf@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260724141318.1037434-7-hca@linux.ibm.com>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
 <20260724141318.1037434-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:34:48 +0000
Message-Id: <20260724143448.C08831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] BPF line info offsets are shifted by 4 bytes due to double-count=
ing the CFI hash size in `bpf_prog_fill_jited_linfo()`.
--

--- Patch [6]: [PATCH 6/6] s390/bpf: Add kCFI support ---
commit 07d29b72daf2643a639d32a0ab6a9b913adcfbc6
Author: Heiko Carstens <hca@linux.ibm.com>

s390/bpf: Add kCFI support

This patch adds kCFI (Kernel Control Flow Integrity) support for BPF progra=
ms=20
on the s390 architecture. It emits a CFI hash before the BPF program=20
instructions and adjusts the function pointer and lengths to account for=20
this prefix.

> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 31749c0362ca2..74642e0b4ee19 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c

[ ... ]

> @@ -2401,9 +2417,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
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
>  		bpf_prog_fill_jited_linfo(fp, jit.addrs + 1);

[Severity: Medium]
Does this double-count the CFI offset when calculating the JIT line info?

Looking at bpf_int_jit_compile(), the emit_kcfi() call during the prologue=
=20
generation advances jit.prg by 4 bytes. This means the offsets stored in=20
jit.addrs already include the CFI hash size.

However, when we pass these offsets to bpf_prog_fill_jited_linfo(), it=20
uses fp->bpf_func as the base address to resolve the final instruction=20
pointers:

kernel/bpf/core.c:bpf_prog_fill_jited_linfo() {
    ...
    for (i =3D 1; i < nr_linfo && linfo[i].insn_off < insn_end; i++)
        jited_linfo[i] =3D prog->bpf_func +
            insn_to_jit_off[linfo[i].insn_off - insn_start - 1];
}

Since fp->bpf_func has already been shifted forward by cfi_get_offset(),=20
adding the unadjusted jit.addrs offsets might shift the resulting line info=
=20
by 4 bytes, which could break source line mapping in userspace tools.

Should jit.addrs be adjusted to subtract cfi_get_offset() before filling=20
the line info, or should the original base pointer be passed instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141318.1037=
434-1-hca@linux.ibm.com?part=3D6
