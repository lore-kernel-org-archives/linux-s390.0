Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B0281503;
	Tue, 18 Aug 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065803; cv=none; b=fxGgkT6DHpnwuwcuRGPcvpX1ebN183QHRIli/K2IYJAmPW6AH2E2dYiugW9oyPyZdtu9yaZLWQqHLHjkdVaFwMqYVN4XikvQeqQbMRJwQ5ON/3+3QTiwltTkDFez1GxxoRjyIjd5ExqK98tPYk7jOkKtFDYQzoR4SlYRRDajDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065803; c=relaxed/simple;
	bh=Q2su2Nxr8Y3VSvuRd49YaOiptzC5bxF/Yfy+APYaay0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=goF213Sbp0ejfzjZ7xzJCNszwNVxogvgx0uWM489NH2TFchnzBmg/IscezS+yKmDGc538tTfsLRKG3wTGQMLcIlkjT686bOSqO1CnW7E4/T/KEjLIR9W7tAbwt99D8HcS2msrbem/MgjicPlmkzrgR9WvOiWshv2RVhB776YC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6PoHTvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6PoHTvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF21F00A3D;
	Tue, 18 Aug 2026 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065802;
	bh=k+Yix8K7f6KdlGapeomE80txZDKGc6Ki9b4YhH/0pSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I6PoHTvl6cNAg8Ourz14OftcvkscrmMs6SEO4VtRCFPj00mi1ioDuUAD5wYulnV2e
	 BP8wXXwWDpyBKh3LZYItVNbO9XgOIIrI4njL82fhFzeSEv4oDxwTM12iq4MvdqZAB7
	 5WoPkYQG2JO9BzjymF42Be2x4cjohpGWsvptZDBs23y56lcbdYJcZami+6Ft23nayx
	 9OcAK1aIV79G0k3Obmx/G6yQ4oVXpg2ZR5DBywjMiZC8geJF8J05axei+DfWmsi3dR
	 Yhrs0zLgQFjc4gyFgQkfe1qX9dYEPSsfLaRJn9BmM7JH3H5ko61mXMsuodYYXT0xH4
	 7x6Nln+F5T2Qw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 21/25] unwind_user/eh_frame/x86: Handle PLT
 expressions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260818144954.2320378-22-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-22-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:10:01 +0000
Message-Id: <20260818151001.88CF21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The x86 PLT CFA expression handler hardcodes 64-bit DWARF regist=
er numbers, breaking the claimed i386 support.
--

--- Patch [21]: [RFC PATCH v1 21/25] unwind_user/eh_frame/x86: Handle PLT e=
xpressions ---
commit 0609783d6303290732b67ec7492d3c753e51d51c
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame/x86: Handle PLT expressions

This commit adds x86-specific support for unwinding through GNU linker
generated PLT entries by handling the CFA expression found in .eh_frame.
It explicitly aims to enable this for both i386 and x86-64 binaries.

> diff --git a/arch/x86/include/asm/unwind_user_eh_frame.h b/arch/x86/inclu=
de/asm/unwind_user_eh_frame.h
> index fdccbda2fe4b1..8268eb1a0ff5a 100644
> --- a/arch/x86/include/asm/unwind_user_eh_frame.h
> +++ b/arch/x86/include/asm/unwind_user_eh_frame.h
[ ... ]
> +static inline int eh_frame_do_def_cfa_expression(const char *expr,
> +						 int size,
> +						 unsigned long ip,
> +						 struct eh_frame_reg_state *reg_state)
> +{
[ ... ]
> +		sp_reg =3D DW_OP_breg_register(sp_op);
> +		ip_reg =3D DW_OP_breg_register(ip_op);
> +		if (sp_reg !=3D EH_FRAME_REG_SP || ip_reg !=3D EH_FRAME_REG_RA)
> +			return -EOPNOTSUPP;

[Severity: Medium]
Does this unconditionally reject 32-bit i386 PLT expressions?

The commit message mentions enabling unwinding for both i386 and x86-64,
and the comment above notes the 32-bit DWARF registers 4 (ESP) and 8 (EIP).
However, this check requires the parsed DWARF register values to match
EH_FRAME_REG_SP (7) and EH_FRAME_REG_RA (16), which are exclusively the
x86-64 register mappings.=20

Will this cause valid i386 expressions to fail and return -EOPNOTSUPP?

While 32-bit eh_frame unwinding is currently disabled at a higher level
for x86-64 tasks, this logic appears to contradict the intended architectur=
al
support.

> +
> +		/* CFA =3D (SP + SP_offset) + (((IP & 0xf) >=3D N) << shift) */
> +		reg_state->cfa_rule =3D CFA_REG_OFFSET;
> +		reg_state->cfa_regnum =3D EH_FRAME_REG_SP;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D21
