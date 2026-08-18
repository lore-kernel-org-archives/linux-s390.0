Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D59377563;
	Tue, 18 Aug 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065551; cv=none; b=RdK/BNHjoKg5s91/19mnZh5cw/f1ZOAlIIoB3a3uGcn5mpAQAuSPLVROUCMjp7ipUOVQhzj6QWg9yDNvQ/NfUI3lukbOFpO9owlSuOA11NnU6MWsHOKl8Ek4g8vPy3Wyi+g3R83gAcv8Rzg6ZZaZHTJcZEhVs2u3WnMuYXwm2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065551; c=relaxed/simple;
	bh=I5BSN/AOu27H1Vf+VwRbA2iDQ/lzwz6LYE5epvERang=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VqQ4Uc1w0sZ90yC9wgaX8vykGBFZA3sbNboy9IdglTRk0CpnM0dA59oy5jr10C9gasdNahStsbDWrGR/oHk4vIXLhIkPEAazDINeCTBb5HXQxtzL2HASQsfDuycjJqYiA4TiKUriVx/7pFMyD14EqwcBDRUIUTUr2nAAeNVRenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIZE3xgt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIZE3xgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2009E1F000E9;
	Tue, 18 Aug 2026 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065549;
	bh=OaBi7ivC2IQZfdPyccyE16k6257sxCJPhV0hS7/suPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VIZE3xgtPeOz+a03GTl0WELz+ll3mIZk7/dJFHneHlfBuWAMb26jBL39E0cLnSFt7
	 bueOD33KEfN9nhdyybg4lebvExpIXLPnWHlmMRMcsG5kmEouTM3X062TeTTnzZ58ei
	 ELXmoFT4qcnZbO5XNK8EUQtalHcVVocQrh6CDc5g0QylXWAHpDY8z88K/Zz1X3Sbhq
	 ejflewDJvKDLDvfEfrPzlRELB874Wh9Nz2bNVjeKVIupF0goMP5Slh603zJhFzQaZ7
	 5XICAtGhVSyhEu12x0IQL2bbQui01tpMikjqPiFm9SvgnMVa6DbdHxm319+EKCtWDy
	 E4s3qHEkocNGg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 09/25] unwind_user/eh_frame: Add support for
 reading .eh_frame section
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-10-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-10-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:05:48 +0000
Message-Id: <20260818150549.2009E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] `DW_CFA_restore` incorrectly clears register rules instead of rest=
oring the CIE's initial rule.
- [High] Uninitialized usage of `fde->func_addr` when decoding an FDE's sta=
rt address via `DW_EH_PE_funcrel`.
- [High] The `eh_frame_cfi_context` struct is partially initialized, exposi=
ng uninitialized stack memory via `cfa_offset`.
- [Low] Incompatible pointer type passed to `read_uleb128()` in `DW_CFA_off=
set` instruction parsing.
--

--- Patch [9]: [RFC PATCH v1 09/25] unwind_user/eh_frame: Add support for r=
eading .eh_frame section ---
commit 7603506904ca3b69840f3790ec49f48b9d3d54fb
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Add support for reading .eh_frame section

This patch adds an eh_frame_find interface to parse DWARF Call Frame
Information from the .eh_frame section for unwinding user space stacks. It
reads Common Information Entries, Frame Description Entries, and evaluates
DWARF CFI instructions to restore registers.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c
[ ... ]
>  static __always_inline int read_encoded_pointer(struct eh_frame_section =
*sec,
> +                                               struct eh_frame_fde *fde,
>                                                 unsigned long *addr,
>                                                 unsigned long end,
>                                                 u8 encoding,
>                                                 unsigned long *value)
>  {
[ ... ]
> +	case DW_EH_PE_funcrel:
> +		if (!fde)
> +			return -EINVAL;
> +		result =3D fde->func_addr;
> +		break;
[ ... ]
> +static __always_inline int __read_fde(struct eh_frame_section *sec,
> +				      unsigned long fde_addr,
> +				      struct eh_frame_fde *fde)
> +{
[ ... ]
> +	scoped_user_read_access_size(fde_ptr, 4 + length, Efault) {
> +		/* Read PC begin (function start address) */
> +		ret =3D read_encoded_pointer(sec, fde, &cur, end, fde->cie.fde_addr_en=
c, &func_addr);

[Severity: High]
Does this code use an uninitialized value for the function address?

If the user-space eh_frame section specifies the DW_EH_PE_funcrel
encoding for fde_addr_enc, read_encoded_pointer() will attempt to evaluate
fde->func_addr.

However, fde->func_addr is not populated until the end of __read_fde(),
after the function address has already been parsed. Could this allow a
crafted eh_frame to use uninitialized kernel stack memory in its
address calculation?

> +		if (ret)
> +			return ret;
> +		if (func_addr < sec->text_start || func_addr >=3D sec->text_end)
> +			return -EINVAL;
[ ... ]
> +	fde->func_addr		=3D func_addr;
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
> +	case DW_CFA_offset: {
> +		u8 reg =3D DW_CFA_operand(opcode);
> +		long offset;
> +		int idx;
> +
> +		ret =3D read_uleb128(&cur, end, &offset);

[Severity: Low]
Is the offset variable the correct type here?

The read_uleb128() function expects a pointer to an unsigned long, but
offset is defined as a signed long. This creates an incompatible pointer
type warning during the build.

> +		if (ret)
> +			return ret;
> +		offset *=3D fde->cie.data_align;
[ ... ]
> +	case DW_CFA_restore: {
> +		u8 reg =3D DW_CFA_operand(opcode);
> +		int idx;
> +
> +		idx =3D reg_to_index(reg);
> +		if (idx >=3D 0)
> +			ctx->state.reg_rule[idx] =3D REG_UNDEFINED_IMPLICIT;
> +		break;
> +	}

[Severity: High]
Does this instruction handler violate the DWARF specification?

The DWARF standard requires DW_CFA_restore to change the rule for the
indicated register back to the rule assigned by the initial instructions in
the CIE. By unconditionally setting it to REG_UNDEFINED_IMPLICIT instead
of restoring the CIE initial rule, this could corrupt the register recovery
state and cause unwinding to fail.

[ ... ]
> +		case DW_CFA_def_cfa_register: {
> +			unsigned long reg;
> +
> +			ret =3D read_uleb128(&cur, end, &reg);
> +			if (ret)
> +				return ret;
> +
> +			ctx->state.cfa_rule =3D CFA_REG_OFFSET;
> +			ctx->state.cfa_regnum =3D reg;
> +			break;
> +		}
[ ... ]
> +static __always_inline int __find_frame_row(struct eh_frame_section *sec,
> +					    struct eh_frame_fde *fde,
> +					    unsigned long ip,
> +					    struct unwind_user_frame *frame)
> +{
> +	struct eh_frame_cfi_context ctx;
> +	int ret;
> +
> +	/* TODO: Signal frame - not supported yet */
> +	if (fde->cie.signal_frame)
> +		return -EOPNOTSUPP;
> +
> +	ret =3D __do_cfi_program(sec, fde, ip, &ctx);

[Severity: High]
Can this leak kernel stack memory?

The eh_frame_cfi_context ctx structure is allocated on the stack without
being zero-initialized. In __do_cfi_program(), some fields are manually
initialized, but cfa_offset is omitted.

If an attacker provides a crafted eh_frame using DW_CFA_def_cfa_register
as the first state-modifying instruction, it changes cfa_rule to
CFA_REG_OFFSET without setting cfa_offset. The uninitialized kernel stack
garbage in ctx.state.cfa_offset is then subsequently copied into
frame->cfa.offset, allowing it to be used as an offset to read memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D9
