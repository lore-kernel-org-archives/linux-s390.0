Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229D13AB29B;
	Tue, 18 Aug 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065490; cv=none; b=T2iRnEJ4eFnVHFZ7FgFg/tI4alyuWgXYnQor/KlyT3uzSRu6oBjkflTbMH4heT4+C2uJRXViYHbRCEGmbh3vMemqPfB+feFlMjhigHdAVYDWaMl9r3ZRN30gKOOfxAawSsoP0zgowUaxlTJaX2IQxyVvxDRzOvi6Yo6RLIBfuag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065490; c=relaxed/simple;
	bh=1BzNKcbbcepmesek0QI71kLqo2+YIAUD1qp5BCX25zI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o9hZ7YaddZmZcsR/Pdr7XHBJHURVL+pquDDoSCppWMquNMjUGhSvi/sFCdrB2x3FoEWgSOepKIuj3QJOlwRX0TowGxSc44FwZlMNOOXwhHtmYAOuECz0JwcUztQH9gG3OuQXyGIElhBemfW7g6kRb+s6CHRqz7MmeGlut65bBuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKncKgjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKncKgjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B4C1F000E9;
	Tue, 18 Aug 2026 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065488;
	bh=/ep3Ar0ZJMu+2IS9/3XIdiG5Oo8SRtJVQTJ/TFaG5ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YKncKgjVSRXipJ31WkuBdagPEje+jWooTxmwkFKCvrFDxlClWRw7HnuzAOTsHhNgw
	 q5Y3C9iz95CaH4P96DEI+YXr2N04DvdFRsicMiymHH9uZKIAVErdmM/koQSGcQy+E6
	 77QxkRhlYiU4dbLw85sNO2nQMOhjoUU/6YLSR/cM5FNAX6a8uGVHfNDD1ilCJXgVt8
	 5oQBFM5pmUlP//YxCZueWw9boxXRzmX3TyenY4/TpURhL9UgfWUNIwEMaOQjn/5Gvn
	 iamQybsspGDOFCHxaBddNbZkhuzdHgY3WJ532+4d0wWutEgO53lOaFdAPUzx5pdP4M
	 R4fgynJYJ77NQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 17/25] unwind_user/eh_frame: Ignore
 DW_CFA_GNU_args_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260818144954.2320378-18-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-18-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:04:47 +0000
Message-Id: <20260818150448.31B4C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An integer overflow when evaluating `cur + expr_len` bypasses boun=
ds checks, allowing an attacker to move the instruction pointer backward an=
d trap the kernel in an infinite loop.
- [High] The CFI interpreter loop does not impose a maximum execution limit=
, allowing an attacker to stall the CPU by providing a maliciously crafted,=
 highly padded sequence of CFI instructions.
--

--- Patch [17]: [RFC PATCH v1 17/25] unwind_user/eh_frame: Ignore DW_CFA_GN=
U_args_size ---
commit e1c2b0ab16134f39bfe2a1cb074739516466f777
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Ignore DW_CFA_GNU_args_size

This commit updates the unwind mechanism to safely ignore the
DW_CFA_GNU_args_size DWARF instruction. This instruction is used by GCC
to track exception handling stack sizes, but is not needed for kernel
stack tracing.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index ac288cec8021f..64176242b7d8f 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c
[ ... ]
> @@ -1012,6 +1012,17 @@ static __always_inline int __do_cfi_insn(struct eh=
_frame_section *sec,
>  			break;
>  		}
> =20
> +		case DW_CFA_GNU_args_size: {
> +			unsigned long args_size;
> +
> +			ret =3D read_uleb128(&cur, end, &args_size);
> +			if (ret)
> +				return ret;
> +
> +			/* Ignore DW_CFA_GNU_args_size */
> +			break;
> +		}
> +
>  		case DW_CFA_remember_state:
>  			if (ctx->stack_depth >=3D EH_FRAME_MAX_STATE_STACK)
>  				return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does this code allow an integer overflow
when evaluating cur + expr_len?

kernel/unwind/eh_frame.c:__do_cfi_insn() {
    ...
		case DW_CFA_val_expression: {
			unsigned long reg, expr_len;

			ret =3D read_uleb128(&cur, end, &reg);
			if (ret)
				return ret;
			ret =3D read_uleb128(&cur, end, &expr_len);
			if (ret)
				return ret;

			if (cur + expr_len > end)
				return -EINVAL;
    ...
}

If a maliciously crafted .eh_frame section provides an extremely large
expr_len value, cur + expr_len can wrap around to a value less than end.
This bypasses the bounds check, and when the instruction pointer cur is
updated via cur +=3D expr_len, it moves backwards.

Since the unwinder operates on user-supplied call frame information, can
this trap the kernel in an uninterruptible infinite loop and cause a local
denial of service?


[Severity: High]
This is a pre-existing issue, but is it possible for this loop to run witho=
ut
an execution limit?

kernel/unwind/eh_frame.c:__do_cfi_program() {
    ...
		cur =3D fde->cfi_insn_start;
		while (cur < fde->cfi_insn_end && ip <=3D target_ip) {
			ret =3D __do_cfi_insn(sec, fde, &cur, fde->cfi_insn_end, &ip, target_ip,=
 ctx);
			if (ret)
				return ret;
		}
    ...
}

If a local attacker maps a maximally sized frame description entry filled
with DW_CFA_nop instructions, the kernel will sequentially process billions
of instructions without yielding or aborting.

Since this can run in non-preemptible or non-maskable interrupt contexts
during stack unwinding, can this stall the processor and trigger a
watchdog panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D17
