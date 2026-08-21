Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487CE33B6F1;
	Fri, 21 Aug 2026 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343451; cv=none; b=bfJHJ44veSNzwV/x3Mq4t4ua4wpDcx6BAJwYsBl21rSg0910P9/cYvITlsrxT6P7XwRq2PjK0ZlneR8FkLXgyQ5Z9H+ALl5cIh7m+9y7bQ0rO9d1+VpLyVOSTcRp/Uu0dz8P0EXUyzwnXOOclCQX9rYyQLyEHX0cbn9boROG4eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343451; c=relaxed/simple;
	bh=iajGyT4+vc2zjWIyN2hTpCLLK/SPGlJwvJdHohEBBW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K130hFYZQPqdQmuYEhFPMT/ADVmekm7L3AeLXCCKs1HLM31dDHhZTFkm0C55i60QBSmA9fgcp5hni9m2lFJsWzK4MKhn6lVRqf+/WoE4SEi8fVFsRok0cgrzbW0ZhKu8bW1PSB2Z9KP2b2w2ZVLSMIxGWW+teJuULWvanm/Yg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyGYagxw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyGYagxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3351F000E9;
	Fri, 21 Aug 2026 20:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343449;
	bh=k+xCCO7L6vhPicMuM7S294gMFTEzcKn693T6m0vEl0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MyGYagxwuMFlv5Dp8ij9rvunjFUyJNmnOQlbTGuuLvgs43SDt2S21w9ws8r3Rzjlx
	 q4fP8L68VJzTxS0vPOg+usQMSzv2eK16AulJ/dCs6g6WdbNMcIg4UEDaPxadCUe+HS
	 6dKFb8BTdTjxqtIzDQv1FuxxVlQ0l0+F5scex2HkaZg6hZv2o8sP75KLCkVH/Oab/h
	 rSMyWx59uQKorAzJYlV8Tlm4vRSz31S/IbLGCraDEu9sT6GefFaO7Rgga7BBxWkBEF
	 AwWq3GpgHNxmtCDhQ7WyJXGj4DadG/tchMvxx6olN3pOloOFU7xSh7vF/Oy4i1bWD9
	 OEouUwE4zHcMw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 20/24] unwind_user/eh_frame/x86: Handle PLT
 expressions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-trace-kernel@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-21-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-21-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:17:29 +0000
Message-Id: <20260821201729.9E3351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch claims to support i386 PLT unwinding but fundamentally=
 breaks it by hardcoding x86-64 DWARF register macros.
--

--- Patch [20]: [RFC PATCH v2 20/24] unwind_user/eh_frame/x86: Handle PLT e=
xpressions ---
commit 75d2af7b6df62f61cc44905f96f37d91b80e466a
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame/x86: Handle PLT expressions

This commit adds x86-specific support for handling the CFA expression
found in GNU linker generated .eh_frame for PLT. It intends to enable
unwinding through GNU linker generated PLT entries on both i386 and
x86-64.

> diff --git a/arch/x86/include/asm/unwind_user_eh_frame.h b/arch/x86/inclu=
de/asm/unwind_user_eh_frame.h
> index fdccbda2fe4b1..8268eb1a0ff5a 100644
> --- a/arch/x86/include/asm/unwind_user_eh_frame.h
> +++ b/arch/x86/include/asm/unwind_user_eh_frame.h
[ ... ]
> @@ -15,7 +17,71 @@
>  #define EH_FRAME_MIN_DATA_ALIGN -8
>  #define EH_FRAME_MAX_DATA_ALIGN -1
> =20
> -#endif
> +#endif /* CONFIG_X86_64 */
[ ... ]
> +static inline int eh_frame_do_def_cfa_expression(const char *expr,
> +						 int size,
> +						 unsigned long ip,
> +						 struct eh_frame_reg_state *reg_state)
> +{
[ ... ]
> +		if (!DW_OP_is_breg(sp_op) || !DW_OP_is_breg(ip_op))
> +			return -EOPNOTSUPP;
> +
> +		sp_reg =3D DW_OP_breg_register(sp_op);
> +		ip_reg =3D DW_OP_breg_register(ip_op);
> +		if (sp_reg !=3D EH_FRAME_REG_SP || ip_reg !=3D EH_FRAME_REG_RA)
> +			return -EOPNOTSUPP;

[Severity: Medium]
The commit message mentions enabling unwinding for both i386 and x86-64,
but does this check inadvertently break i386 support?

EH_FRAME_REG_SP and EH_FRAME_REG_RA are defined under CONFIG_X86_64 and
correspond to x86-64 DWARF register numbers (7 and 16). For i386, the DWARF
register numbers are different (ESP is 4, EIP is 8).

When unwinding an i386 PLT expression, such as for a 32-bit compat process
running under a 64-bit kernel, will this check unconditionally reject the
expression and return -EOPNOTSUPP because 4 does not equal 7?

Also, if this code is compiled natively for 32-bit, would this cause a build
failure because the EH_FRAME_REG_SP and EH_FRAME_REG_RA macros are not
defined outside of the CONFIG_X86_64 block?

> +
> +		/* CFA =3D (SP + SP_offset) + (((IP & 0xf) >=3D N) << shift) */
> +		reg_state->cfa_rule =3D CFA_REG_OFFSET;
> +		reg_state->cfa_regnum =3D EH_FRAME_REG_SP;
> +		reg_state->cfa_offset =3D sp_offset + (((ip & 15) >=3D n) << shift);
> +		return 0;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D20
