Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2E381EA2;
	Fri, 21 Aug 2026 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343312; cv=none; b=oo0iVlgUAtGG/Gupu5LLoHMIRFPJwiZfrH3+z/CHwRRHe6EKKCi0xLXRYYdTOrdEFx7wywAYPc/tSOiWi1jC8D7Q6KP6bdvVHUZfrtN7VCD/RF1hBn7hhFvb3qu2X9lrstR5Cj6kFp5waNr9MC/RZwF0rqXbydewIYNM38OmXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343312; c=relaxed/simple;
	bh=vTAW6aePFHznFWM51eOCvF8SOTdWSFCLGk6LGyeMb0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qro7cj6+zRN3rO5WJeeG33kp3ujKYgO+2nK3e5VZ3TRb3R+iT7c6bvxL8Zp1hwFmPZGv+3hrTa/a+xvcQ4bjfQoJGIYnVXfedDqy0kvuO8NhZABg6CRgshLC+h8tI7eValY8JA8SL0koDbLvAOrxLT4uMMlDp/6toXVS0pMn7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da9dUjtL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da9dUjtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4285E1F000E9;
	Fri, 21 Aug 2026 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343310;
	bh=XEhmYloVQMvizsPafldvM98GumTbyJkKEZLAw0ngVVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=da9dUjtLSeQXD0CUwBfKPOk2ro2Zkb7yY7Tm5FAvqObhOcA76AZdK9rvPHHLgHaUE
	 iYr4VEPsa1/NyU7J9a51dASH9b1qPg8bmrZR3wWap62Zmvmkbr1m7Bl+5MlOOl+pgp
	 nejmHeJHTCXyQgXqncxUHZI4EmrOCWmMwS7o72QH/xQVAlZc+4BRfnKNTeARDYYI4D
	 xWjcF8K7vSvOpY8uyDAUU0txRg2SbC5eCHyx3e1LPsHDpdNgkcFa6yGGW7TsF5/e8u
	 Nn6j4QyKcAi2+sEK+IEXe3lLu35X4v9CdsW7MsdpaX1NkG7kG6Uu5KNxQLBE1jF2l7
	 3aRl9bkt2ping==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 21/24] unwind_user/eh_frame/x86: Handle DRAP
 expressions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260821195259.2688377-22-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-22-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:15:09 +0000
Message-Id: <20260821201510.4285E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added DRAP DWARF expression handling for the Frame Poi=
nter (FP) uses a generic register rule that unconditionally fails for non-t=
opmost frames, causing premature stack trace truncation.
--

--- Patch [21]: [RFC PATCH v2 21/24] unwind_user/eh_frame/x86: Handle DRAP =
expressions ---
commit a27cd1aa620d26189650492016f14beeb35a7207
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame/x86: Handle DRAP expressions

This commit adds x86-specific handling for DRAP CFA and FP expressions.
It supports unwinding through frames with dynamically realigned stacks by
parsing the corresponding DWARF expressions.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c

[ ... ]

> @@ -1184,6 +1209,16 @@ static __always_inline int __find_frame_row(struct=
 eh_frame_section *sec,
>  		frame->fp.regnum =3D ctx.state.reg_regnum[FP_IDX];
>  		frame->fp.offset =3D 0;
>  		break;
> +	case REG_REGISTER_OFFSET_DEREF:
> +		if (ctx.state.reg_regnum[FP_IDX] > UINT_MAX)
> +			return -EINVAL;
> +		if (ctx.state.reg_offset[FP_IDX] < INT_MIN ||
> +		    ctx.state.reg_offset[FP_IDX] > INT_MAX)
> +			return -EOPNOTSUPP;
> +		frame->fp.rule =3D UNWIND_USER_RULE_REG_OFFSET_DEREF;
> +		frame->fp.regnum =3D ctx.state.reg_regnum[FP_IDX];
> +		frame->fp.offset =3D ctx.state.reg_offset[FP_IDX];
> +		break;

[Severity: Medium]
Will this generic register rule cause stack trace truncation for non-topmost
frames?

Looking at unwind_user_next_common(), UNWIND_USER_RULE_REG_OFFSET_DEREF is
unconditionally rejected unless it's the topmost frame:

kernel/unwind/user.c:unwind_user_next_common() {
    ...
    case UNWIND_USER_RULE_REG_OFFSET_DEREF:
        if (!state->topmost || unwind_user_get_reg(&fp, frame->fp.regnum))
            return -EINVAL;
    ...
}

Because EH_FRAME_REG_FP is tracked across frames, could this use a dedicated
FP rule to avoid aborting the stack trace when encountering a DRAP frame th=
at
isn't the innermost frame?

>  	default:
>  		return -EINVAL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D21
