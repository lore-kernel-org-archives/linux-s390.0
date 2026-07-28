Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FFF187346
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785217044; cv=none; b=mcUO2RSRoZzu879KIo1mZcsmEw3aP/Pbkfpm8OgSN5NMtYr2O59e620I2WA3aVPmuvoP5Q9svBYr45bBpkgqHeQsHJOHmba1XwEdICL9WnT0H+Ezl2rbSloxVvxr2FhnTaLawdBukC+8q+AWo3xt9zSKBa4ol5h2AACnMJVlB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785217044; c=relaxed/simple;
	bh=PDZJMbDZia2aBYkvmvdJdco0bSagaU3D72rDbUFNZqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a7sFhzLm0fNDufpmBG1jpdYMW+lj7wdCQBRwWp4qvCOMZrABPGSZJnp42kEGJR+TQNQkuxDfg7+FjYlEp2mqnuZlVVQmJNNdgde7+CN8MxsJeD/Ts3icYrs97eufOxDAI1h30chZTh1grGiwqSYPYk/5tTP1XkISYiuUSNUFDRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODo7NGfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODo7NGfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832811F000E9;
	Tue, 28 Jul 2026 05:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785217042;
	bh=yrRc1EKTxQR1e7wj0jR59yB3oyPb5OOC4+h3KdfjGPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ODo7NGfmGjmKYP0XkMwLh82JP/VgFMP9g+oK8rHyhXrF04L0A+0vmL7Z00lKkipIn
	 8l6e2KUvrvksQ9Wyac/DePJqdOT3HLqLmZEBsavYmDcUbzutF1h9Os2uSv8OCNakC6
	 un1dMexzPwkbUiR7dG9AVIC2vgdHU2PTo8YwgyYutN7p5oemv6Fj+0bO3KCemdPrlU
	 mmAt/Z1toiIMlrcG71NxjczlLeF3xK0tF+sulb78uqAXcG98kJe6Ek5rvmDrWSIVuO
	 jBdhLF2mlGHB5NBmsbL4uRYTsF8zmVXt2ub+Q2x3Iobau9oACZaFQJ95RjX4Sj+Kwq
	 u91wn+XmAQzjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/8] x86/runtime-const: Introduce
 runtime_const_mask_32()
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728052540.4728-2-kprateek.nayak@amd.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-2-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:37:22 +0000
Message-Id: <20260728053722.832811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit introduces `runtime_const_mask_32` for x86 but omits =
a generic fallback in `include/asm-generic/runtime-const.h`.
--

--- Patch [1]: [PATCH v6 1/8] x86/runtime-const: Introduce runtime_const_ma=
sk_32() ---
commit 664c491c817106934caf3b46117ff57570227576
Author: Peter Zijlstra <peterz@infradead.org>

x86/runtime-const: Introduce runtime_const_mask_32()

This commit introduces the runtime_const_mask_32() macro for the x86
architecture to optimize the mask operation in the futex hash computation
hot path. It also adds the __runtime_fixup_mask() helper to support
this functionality.

Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.ki=
cks-ass.net

> diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/=
runtime-const.h
> index 4cd94fdcb45e2..b13f7036c1c9b 100644
> --- a/arch/x86/include/asm/runtime-const.h
> +++ b/arch/x86/include/asm/runtime-const.h
[ ... ]
> @@ -41,6 +41,15 @@
>  		:"+r" (__ret));					\
>  	__ret; })
> =20
> +#define runtime_const_mask_32(val, sym) ({			\
> +	typeof(0u+(val)) __ret =3D (val);				\
> +	asm_inline("and $0x12345678, %k0\n1:\n"				\
> +		   ".pushsection runtime_mask_" #sym ",\"a\"\n\t"\
> +		   ".long 1b - 4 - .\n"				\
> +		   ".popsection"				\
> +		   : "+r" (__ret));				\
> +	__ret; })
> +

[Severity: Medium]
Will this cause a build regression on non-x86 architectures when the generic
code starts using runtime_const_mask_32()?

The commit message mentions this will be used by the futex hash computation=
 in
a subsequent commit. However, there doesn't appear to be a generic fallback
for this macro in include/asm-generic/runtime-const.h.

Without a generic fallback, it seems architectures that don't support or
haven't yet implemented runtime constants would fail to compile once the
generic futex code uses this macro.

Should a fallback like the following be introduced in
include/asm-generic/runtime-const.h alongside this x86 implementation to
maintain cross-architecture compatibility and strict bisectability?

#define runtime_const_mask_32(val, sym) ((val) & (sym))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728052540.4728=
-1-kprateek.nayak@amd.com?part=3D1
