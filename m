Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A2396B68;
	Fri, 21 Aug 2026 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343539; cv=none; b=g5MbSrx4OBytRV9IsuR6Qb1h8LQ65Oca36OpprJPb8MvFM+FEzT9lmqX2NWWh2lliOccpmgpaJWZZbpwua+esyyYOUwOJFAJQBrphoQ0t3mixdQRnuu5x0Cd2H6rSry5SXe5cXR3YNYsx7iHGblR0Vt/C1XBwFx/Yww3gKh1fIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343539; c=relaxed/simple;
	bh=8yZEyxapgmB01v9Ae5J4Z7oDLAweI+XMfcSwhzlUW5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S9PLhMbBSiijLIVwFBSQ3Z7AocqN1gTPAgBWgDMlOOLTnae5yip+QJz4OZPvZrpSnfoJ6iqPertmX6ypCqZyX1gKXW9srVWsd1Ql57TtbAxVgVdIoBeRfGgwG95d3UvZwPmMFx8QISuPzSA8/iO83GmkOOPd1CQMogfP9FpN58A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMtmexZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMtmexZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706821F000E9;
	Fri, 21 Aug 2026 20:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343536;
	bh=IuEwlOoOYniV6mSsiQC1T3qKIxjhdj28RuIO3pz53K8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cMtmexZMDoge7yPAsGxNC1wrUVws7uRwlWYC0m01YH6rrQQrKFi9uObBeAZ0ZzeWP
	 sHYCOP0+SlMK3svXI/qOKbqUrJTgTerzC7H2lutQuGjUcxEpglX2dNa/IuUzP9fitX
	 CQ67tMn+wgjfIlg0epdpvbrbTYymY+IrSJ0k0GB3Ft6BOm28sx20CXjiPwCPdiKYZk
	 t1KLPLEeA1epf5n7I++jDEDRtYAyxKZdxA6IwROEqd3sw4d65AOdeF/8jlYqUOLXpr
	 qQpPvQ2nefMFEBZAUF7jX4ZZUi5rp3Mr72i6tA5ZxWy15wlR0M+rO4E6M4DOkO+kIt
	 lMhnJOf07wyhQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 17/24] unwind_user/eh_frame: Add support for
 DWARF expressions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-18-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-18-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:18:56 +0000
Message-Id: <20260821201856.706821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unaligned stack buffer passed to unsafe_copy_from_user() causes und=
efined behavior
--

--- Patch [17]: [RFC PATCH v2 17/24] unwind_user/eh_frame: Add support for =
DWARF expressions ---
commit 38e0b8657cdb2bd1e95dd3bc74b1aa71e0063c9a
Author: Jens Remus <jremus@linux.ibm.com>

    unwind_user/eh_frame: Add support for DWARF expressions
   =20
    Enable architectures to handle DWARF expressions in DWARF CFI
    instructions DW_CFA_def_cfa_expression, DW_CFA_expression, and
    DW_CFA_val_expression. Limit the maximum expression length to a
    reasonable size, while enabling architectures to override the
    limit.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index d185187b0c34e..a98804dbe5886 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c
> @@ -803,6 +772,27 @@ static __always_inline int __do_cfi_insn(struct eh_f=
rame_section *sec,
>  			break;
>  		}
> =20
> +		case DW_CFA_def_cfa_expression: {
> +			unsigned long expr_len;
> +			char expr[EH_FRAME_MAX_EXPRESSION_LENGTH];
> +
> +			ret =3D read_uleb128(&cur, end, &expr_len);
> +			if (ret)
> +				return ret;
> +
> +			if (cur + expr_len < cur || cur + expr_len > end)
> +				return -EINVAL;
> +
> +			if (expr_len > sizeof(expr))
> +				return -EOPNOTSUPP;
> +			unsafe_copy_from_user(&expr, (void __user *)cur, expr_len, Efault);

[Severity: Low]
Does this unaligned stack buffer passed to unsafe_copy_from_user() cause
undefined behavior?

Passing a 1-byte aligned char array to unsafe_copy_from_user() violates C
alignment rules. In architecture-specific implementations, the macro
explicitly casts the destination pointer to larger integer types (e.g.,
u64 *) to perform optimized word-sized memory assignments. Dereferencing
an unaligned pointer is Undefined Behavior in C.

While x86 hardware gracefully handles unaligned memory accesses, the
compiler's optimizer is legally allowed to assume u64 * is 8-byte aligned
and could emit trapping instructions. Furthermore, if this generic .eh_frame
code is later enabled on architectures with strict hardware alignment
enforcement, it will immediately trigger alignment exceptions.

Could this buffer be declared with __aligned(8) or as an array of u64?

> +			ret =3D eh_frame_do_def_cfa_expression(expr, expr_len, target_ip, &ct=
x->state);
> +			if (ret)
> +				return ret;
> +			cur +=3D expr_len;
> +			break;
> +		}
> +

[ ... ]

> @@ -970,12 +960,22 @@ static __always_inline int __do_cfi_insn(struct eh_=
frame_section *sec,
>  			if (ret)
>  				return ret;
> =20
> -			if (cur + expr_len > end)
> +			if (cur + expr_len < cur || cur + expr_len > end)
>  				return -EINVAL;
> =20
> -			if (reg =3D=3D EH_FRAME_REG_SP || reg =3D=3D EH_FRAME_REG_FP || reg =
=3D=3D EH_FRAME_REG_RA)
> -				return -EOPNOTSUPP;
> +			if (reg =3D=3D EH_FRAME_REG_SP || reg =3D=3D EH_FRAME_REG_FP || reg =
=3D=3D EH_FRAME_REG_RA) {
> +				char expr[EH_FRAME_MAX_EXPRESSION_LENGTH];
> =20
> +				if (expr_len > sizeof(expr))
> +					return -EOPNOTSUPP;
> +				unsafe_copy_from_user(&expr, (void __user *)cur, expr_len, Efault);

[Severity: Low]
Is this the same alignment issue as above?

Could this buffer also be declared with __aligned(8) or as an array of u64?

> +				if (opcode =3D=3D DW_CFA_expression)
> +					ret =3D eh_frame_do_expression(reg, expr, expr_len, target_ip, &ctx=
->state);
> +				else
> +					ret =3D eh_frame_do_val_expression(reg, expr, expr_len, target_ip, =
&ctx->state);
> +				if (ret)
> +					return ret;
> +			}
>  			cur +=3D expr_len;
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D17
