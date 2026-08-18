Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383DC5B5AB;
	Tue, 18 Aug 2026 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066020; cv=none; b=YlCbGOgEiGpA2Mq9iYF9KoM04wxgPsBUt/m8iaVXOivD6C9i4cnMgDDEAjuYAqcPCVfETKZwE0cGtdYDOu6RobaAZA2nZynkKUPayU6h1OVZzJ8keL9qPkmwKB8lIurZFnxEdLhe2iXEveN0MuKurwkyUlOSt/d46hPZhsvOL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066020; c=relaxed/simple;
	bh=sAugGaIhPeZSbXa/Q3FUpKFED/TIYhwK7VM/B5b5g0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bznY9dZdjvxSghwEMDLWO0Qe96hE0hVWl6/hCS61MCqZ986tSpPsHTl3Y5eGJR6Y2wsHNVaMGRx9RTH7cHqzaAxZBNhqJLaRQlYulHjFqbAkrukLYiBHcgt7exEi6evWJ6rwovSyoYXoKcGwN6x+34lApEP73SGOZjTNKRNV2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbiXpF+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbiXpF+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757DE1F000E9;
	Tue, 18 Aug 2026 15:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066018;
	bh=jSQ6xgTGJyi+ZNwUoh5Hu+u+Ny+3pXVR7BWkIJTIUMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kbiXpF+ufBxJuwgoX4WWcDcdbiX20vJUIm3TdJuHwqyZEJdNUF+eQbY7iB7GTPWd0
	 EXz5UphsdzbiADPzwLzTukvNiTTi95bodD9owI2hfx2jaFHwMj9dVILY+JT5wi4drk
	 LgWktxr6r8a+cAlP/Alwp+yRBC4oPxkVNlmtavG/wxJszn557t5Zx2uxZYME6DxwCe
	 qpi3HHRDoCfjWQNlZ0BJRhE8PZwB73NvPft4lajVjuYzT47begIWqjTGVJp1T+2bri
	 jtB/1NLuQpm1VarO3zBKWD1c7p/2bzKGBSDST1WnvPazvtmQffTjt5WoCB8bQhtING
	 RrGVF6cy+9pyw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 18/25] unwind_user/eh_frame: Add support for
 DWARF expressions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-19-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-19-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:13:38 +0000
Message-Id: <20260818151338.757DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Using `unsafe_copy_from_user` inside a `scoped_user_read_acces=
s_size` block prematurely clears the AC flag on x86, causing subsequent use=
r memory accesses to trigger a fatal Page Fault (kernel panic).
- [High] Integer overflow in the DWARF expression bounds check allows an in=
finite parsing loop in kernel space.
- [High] The `cfa_offset` field of the CFI context state is passed to the u=
nwinder uninitialized if a malformed CFI program starts with a `DW_CFA_def_=
cfa_register` instruction.
- [Medium] Calling an out-of-line function within a UACCESS region violates=
 objtool's safe execution rules.
--

--- Patch [18]: [RFC PATCH v1 18/25] unwind_user/eh_frame: Add support for =
DWARF expressions ---
commit 8c411d17e9c2d4af2ed33eb236e117fc360ae4f2
Author: Jens Remus <jremus@linux.ibm.com>
Subject: unwind_user/eh_frame: Add support for DWARF expressions

This commit enables architectures to handle DWARF expressions in DWARF CFI
instructions. It limits the maximum expression length to a reasonable size
and provides inline stubs for architectures to override.

> diff --git a/include/linux/unwind_user_eh_frame_types.h b/include/linux/u=
nwind_user_eh_frame_types.h
> new file mode 100644
> --- /dev/null
> +++ b/include/linux/unwind_user_eh_frame_types.h
> @@ -0,0 +1,37 @@
[ ... ]
> +struct eh_frame_reg_state {
> +	/* CFA recovery rule */
> +	enum eh_frame_cfa_rule cfa_rule;
> +	unsigned long cfa_regnum;
> +	long cfa_offset;

[Severity: High]
What ensures cfa_offset is initialized when processing CFI programs?

When struct eh_frame_cfi_context ctx is allocated on the kernel stack in
__do_cfi_program(), its state.cfa_rule is initialized, but state.cfa_offset
is not.

If a user-supplied .eh_frame begins with DW_CFA_def_cfa_register, it sets
ctx.state.cfa_rule =3D CFA_REG_OFFSET but leaves cfa_offset untouched.

When __find_frame_row() executes, it verifies cfa_rule =3D=3D CFA_REG_OFFSET
and unconditionally reads the uninitialized kernel stack memory. Could this
cause the unwinder to use unpredictable values for the CFA offset?

> +
> +	/* FP and RA recovery rules (SP uses implicit recovery) */
> +	enum eh_frame_reg_rule reg_rule[NR_REGS];
> +	unsigned long reg_regnum[NR_REGS];
> +	long reg_offset[NR_REGS];
> +};

[ ... ]

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c
[ ... ]
> @@ -839,6 +808,27 @@ static __always_inline int __do_cfi_insn(struct eh_f=
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
> +			if (cur + expr_len > end)

[Severity: High]
Can the pointer arithmetic wrap around if expr_len is maliciously large?

Since expr_len is parsed from untrusted user input as an unsigned long, a
large value could overflow cur + expr_len and wrap to a small value,
bypassing this check against end.

If this occurs, the parsing loop would advance cur by the overflowed
expr_len, moving cur backwards. Would this lead to an infinite parsing loop
and a hard lockup?

> +				return -EINVAL;
> +
> +			if (expr_len > sizeof(expr))
> +				return -EOPNOTSUPP;
> +			unsafe_copy_from_user(&expr, (void __user *)cur, expr_len, Efault);

[Severity: Critical]
Might unsafe_copy_from_user() improperly toggle SMAP during expression
parsing?

Because this parsing runs inside a scoped_user_read_access_size block,
calling unsafe_copy_from_user() on x86 defaults to __copy_from_user(),
which executes its own stac() and clac() instructions.

The inner clac() instruction clears the AC flag prematurely, ending the
UACCESS region while the outer block assumes it is still open.

When the loop continues to parse the next instruction using
UNSAFE_GET_USER_INC, it will attempt a direct user memory read with the AC
flag cleared. Will this result in a fatal page fault?

> +			ret =3D eh_frame_do_def_cfa_expression(expr, expr_len, target_ip, &ct=
x->state);

[Severity: Medium]
Is it safe to call an architecture hook inside a UACCESS region?

If an architecture overrides eh_frame_do_def_cfa_expression() with an
out-of-line external function, it will trigger objtool's 'call to XXX()
with UACCESS enabled' warning.

Executing arbitrary functions with the AC flag set is strictly forbidden
on x86 to prevent SMAP bypasses.

> +			if (ret)
> +				return ret;
> +			cur +=3D expr_len;
> +			break;
> +		}

[ ... ]

> @@ -1005,9 +995,19 @@ static __always_inline int __do_cfi_insn(struct eh_=
frame_section *sec,
>  			if (cur + expr_len > end)
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

[Severity: Critical]
Does this copy run into the same SMAP clearing issue as mentioned above?

Calling unsafe_copy_from_user() here will also execute a clac() instruction
and clear the AC flag, causing subsequent user memory accesses to trigger a
fatal page fault.

> +				if (opcode =3D=3D DW_CFA_expression)
> +					ret =3D eh_frame_do_expression(reg, expr, expr_len, target_ip, &ctx=
->state);
> +				else
> +					ret =3D eh_frame_do_val_expression(reg, expr, expr_len, target_ip, =
&ctx->state);

[Severity: Medium]
Could these hooks also cause objtool UACCESS warnings?

Similar to eh_frame_do_def_cfa_expression(), overriding these with external
functions could lead to executing arbitrary code with the AC flag set.

> +				if (ret)
> +					return ret;
> +			}
>  			cur +=3D expr_len;
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D18
