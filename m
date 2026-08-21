Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0E1E0E14;
	Fri, 21 Aug 2026 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343380; cv=none; b=ZAxcR5MMS5d3iII+uMtmQ96UX664MJy/KLauIHyw28/0tJhxS437tuBKu7zPlMl/Ms5dKAy1jG1JXj+tTjNXeiHU4z5nrTbUJRHBNtLX5gbhqL+FH6IajD1glFoLV6xfSx6bnZglZIj8XTmtwtVUe5o0Oy96DaP0ySEk0hYLBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343380; c=relaxed/simple;
	bh=/ZIERIeYPDh+Xja8EXvtD+Rsu85BAMmFRRShDZgUJSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MrbM/6TknGh//JuoCEsvV8khhvNurCQo8O78KUHOmGszsU59LJGkPsAq9Z5cqVau6Jmo1MwoZh5uytni2slmEsW2HwL8/f2HID70uH7evXwSa3uASizK1Mh8pB7rDv9lt4rssuBEoD531AbCH3tSiTAx+izqLTkRKH2GGNT565k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq/h2MxJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq/h2MxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBA21F000E9;
	Fri, 21 Aug 2026 20:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343378;
	bh=ql5PCDEcATupvKT5XDH7ZD46d1cbbutva9ciN9AHX5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tq/h2MxJY1mQvtR9210PZT9aMw0xdFjBYx6AUanwG0E6VxsXs2lXOhtEOFGlHhMJr
	 GKg4ONaygK5UToywRtUbNjU8BP03s9t9bRLI4AqXr2IU2mpUNLd1KzPkYR/G1DFqqE
	 0WLhizLCWSRdjt1Snye8a4tKEovueOF7wbvmn1LuLOWDuRJXmGE3j5uvi1oL77COKE
	 YtMkmwEqssaspWWcfiuQGMBHABjCOFybZ7WKCwxa+SBQaf+V+Jxo55sEWh2k7ntrui
	 teAbYrUgLv8tZB/MZH5lEX7u79fQ4n4iyj78X/iVyiA22EJwDgAsUanq+2bx+iI39q
	 lPxNCF4+TI5Ig==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/24] unwind_user/eh_frame: Add support for
 reading .eh_frame section
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260821195259.2688377-10-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-10-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:16:18 +0000
Message-Id: <20260821201618.6DBA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] DW_CFA_restore and DW_CFA_restore_extended fail to restore the com=
plete register rule state (offset and register number).
- [High] Bypass of pointer masking mitigation inside scoped_user_read_acces=
s_size blocks leading to a Spectre V1 vulnerability.
- [Medium] Integer overflow during instruction pointer advancement in DW_CF=
A_advance_loc4.
--

--- Patch [9]: [RFC PATCH v2 09/24] unwind_user/eh_frame: Add support for r=
eading .eh_frame section ---
commit cd03be3d9017de830eb9301ff0da6dd6d08e69be
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Add support for reading .eh_frame section
   =20
In preparation for using .eh_frame to unwind user space stacks, add an
eh_frame_find() interface for finding the .eh_frame[_hdr] information
associated with a given text address.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index 8cf19c5298fde..21f40805b417f 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c

[ ... ]

> +static __always_inline int __read_cie(struct eh_frame_section *sec,
> +				      unsigned long cie_addr,
> +				      struct eh_frame_cie *cie)
> +{
> +	void __user *cie_ptr =3D (void __user *)cie_addr;
> +	unsigned long cur =3D cie_addr, end;

[ ... ]

> +	scoped_user_read_access_size(cie_ptr, 4 + length, Efault) {
> +		/* Read CIE_ID (must be 0 for CIE; FDE otherwise) */
> +		UNSAFE_GET_USER_INC(cie_id, cur, end, Efault);

[Severity: High]
Are we bypassing the pointer masking mitigation here?=20

The scoped_user_read_access_size() macro shadows the passed pointer (cie_pt=
r)
with a masked version to prevent speculative kernel accesses. However, the
memory read via UNSAFE_GET_USER_INC() uses the separate unmasked cur variab=
le.

Could this allow speculative out-of-bounds reads to access kernel memory?

> +		if (cie_id !=3D EH_FRAME_CIE_ID)
> +			return -EINVAL;

[ ... ]

> +static __always_inline int __read_fde(struct eh_frame_section *sec,
> +				      unsigned long fde_addr,
> +				      struct eh_frame_fde *fde)
> +{
> +	void __user *fde_ptr =3D (void __user *)fde_addr;
> +	unsigned long cur =3D fde_addr, end;

[ ... ]

> +	scoped_user_read_access_size(fde_ptr, 4 + length, Efault) {
> +		/* Read CIE pointer (offset from current position) */
> +		UNSAFE_GET_USER_INC(cie_offset, cur, end, Efault);

[Severity: High]
Is this susceptible to the same pointer masking bypass as __read_cie()?

The unmasked cur variable is being used here instead of the masked fde_ptr.

> +		cie_addr =3D cur - 4 - cie_offset;
> +		if (cie_addr + EH_FRAME_CIE_MIN_LENGTH > fde_addr)
> +			return -EINVAL;
> +		if (cie_addr < sec->eh_frame_start)
> +			return -EINVAL;
> +	}

[ ... ]

> +static __always_inline int __do_cfi_insn(struct eh_frame_section *sec,
> +					 struct eh_frame_fde *fde,
> +					 unsigned long *cur_ptr,
> +					 unsigned long end,
> +					 unsigned long *ip_ptr,
> +					 unsigned long target_ip,
> +					 struct eh_frame_cfi_context *ctx)
> +{

[ ... ]

> +	case DW_CFA_restore: {
> +		u8 reg =3D DW_CFA_operand(opcode);
> +		int idx;
> +
> +		if (ctx->cie)
> +			return -EINVAL;
> +
> +		idx =3D reg_to_index(reg);
> +		if (idx >=3D 0)
> +			ctx->state.reg_rule[idx] =3D ctx->cie_state.reg_rule[idx];
> +		break;
> +	}

[Severity: High]
Does this properly restore the complete register state?

It appears only the rule type is restored from ctx->cie_state, but the
offset (reg_offset) and register number (reg_regnum) are not restored and
will remain at their previously modified values.

[ ... ]

> +		case DW_CFA_advance_loc4: {
> +			unsigned long offset;
> +			u32 delta;
> +
> +			UNSAFE_GET_USER_INC(delta, cur, end, Efault);
> +			offset =3D delta * fde->cie.code_align;

[Severity: Medium]
Can this calculation overflow?

The multiplication of delta (a u32) and fde->cie.code_align (an unsigned in=
t)
evaluates as a 32-bit unsigned integer before being assigned to the 64-bit
unsigned long offset.

If the product exceeds 32 bits, the high bits would be truncated, which mig=
ht
cause the unwinder to desync from the actual PC.

> +			ip +=3D offset;
> +			break;
> +		}

[ ... ]

> +		case DW_CFA_restore_extended: {
> +			unsigned long reg;
> +			int idx;
> +
> +			if (ctx->cie)
> +				return -EINVAL;
> +
> +			ret =3D read_uleb128(&cur, end, &reg);
> +			if (ret)
> +				return ret;
> +
> +			idx =3D reg_to_index(reg);
> +			if (idx >=3D 0)
> +				ctx->state.reg_rule[idx] =3D ctx->cie_state.reg_rule[idx];
> +			break;
> +		}

[Severity: High]
This seems to have the same register state restoration issue as DW_CFA_rest=
ore.
Should reg_offset and reg_regnum also be restored here alongside the rule t=
ype?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D9
