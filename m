Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07441D227;
	Tue, 18 Aug 2026 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065851; cv=none; b=Puq3WAGi6WgB75fLAC8kCgeLcWHJi89k8pB7ztQUOBmVR+dE/RWhJKhTMjGZFsrFP1aDLpJyzo2PucGjP5gCUGeWiCj9VQxTR6U2LKtIORxnOJBvCh+hwyNBWSYCTJ6QBjscSDm8rOecIDwPKrmdiWdvMOFGpO7mH8OqyapUjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065851; c=relaxed/simple;
	bh=zX+fHpditpJpJfK86Ae8ZhH+ZF9L0c7h9+KAZnV6Txo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W7RlTdneSR3xbbk/lUMzPUAvN1sgcjqQuTjpPehqt8KFxiSI9vBYP4uq/eEqswNWJINQIakEuu4CgWkjE0HcudPktPa8bKujhcaf/xD6kM1wGf5dMBukBnm40YXGBiW+g7D6wRgk/eVypaITIiKpB4/PncGdASB9vCiGL9AtSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHgOz7eb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHgOz7eb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B1C1F00A3D;
	Tue, 18 Aug 2026 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065848;
	bh=2vO7coWKE851girAxm6kV3HdKf6E1BtSXpZFeyodU7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHgOz7ebggPA2gybUhcEgPtLd4J6RAq6tZ3GWP9NDerk20MxV2s3SWaNgEfKfxTDi
	 Lfm1Kji8gpsbBJ3MUOCWxoD3lo9NBfDzDk3tqcvWaI8rAUxvIWAQjWPodiQVYqAFQ4
	 wg2ERrAKK7AaJkeToO6agpXqzGNZtzetD+0zRiYnadOaPTmMRhggzkCYk3jD1qHW9g
	 8M2jCckhwOKIYYYTN1Im/rNJcjG/KyU9RgWH2LQwiz1kmfQEWvbZ5rxmrEAf5tWt8+
	 L3frvdi0fLQPwG2qSVXbHzqi3Ozq6g4PH932o7Rp4hOQyxYbCfVXdpgBmmGrLGTueM
	 lB4i73wc9q/EA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 22/25] unwind_user/eh_frame/x86: Handle DRAP
 expressions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-23-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-23-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:10:47 +0000
Message-Id: <20260818151047.92B1C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Inner DRAP frames fail to unwind due to `state->topmost` restricti=
on on `UNWIND_USER_RULE_REG_OFFSET_DEREF`.
--

--- Patch [22]: [RFC PATCH v1 22/25] unwind_user/eh_frame/x86: Handle DRAP =
expressions ---
commit a2eefb14435ba994b91a768aaf44090977190c84
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame/x86: Handle DRAP expressions

GCC uses DRAP (Dynamic Realign Argument Pointer) when the stack needs
to be dynamically realigned. This patch adds x86-specific handling for
the CFA and FP DWARF expressions patterns used to describe how to unwind
through such frames.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index 19e2bc96ddbc2..49e8a3e8d794a 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c
[ ... ]
> @@ -1206,6 +1231,16 @@ static __always_inline int __find_frame_row(struct=
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

[Severity: High]
Will this rule cause unwinding to fail for inner stack frames?

When an inner stack frame requires DRAP evaluation, the unwinder evaluates
UNWIND_USER_RULE_REG_OFFSET_DEREF in kernel/unwind/user.c:unwind_user_next_=
common()
like this:

	if (!state->topmost || unwind_user_get_reg(&fp, frame->fp.regnum))
		return -EINVAL;

Since inner frames are not topmost, this check will return -EINVAL and
abort the unwinding process. Could this truncate backtraces that pass
through dynamically realigned stack frames?

> +		frame->fp.regnum =3D ctx.state.reg_regnum[FP_IDX];
> +		frame->fp.offset =3D ctx.state.reg_offset[FP_IDX];
> +		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D22
