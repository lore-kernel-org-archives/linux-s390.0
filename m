Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6B3282F1F;
	Fri, 21 Aug 2026 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343369; cv=none; b=f4UTTM8z7nnnLc42mwFKEtAGVPqRk5RWDcNoH+xO3aPluGBdYnsCvywFshQqOS0wRptEv+bMpLoteHkIp62CrL6z3PYNpVAa+6GvrSbF9MGK1t04uvND3BI7C8/sCQ+n66dQm/E9N34OVGdGDM/Ujrkip+Ygca66E05vjiE/COw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343369; c=relaxed/simple;
	bh=e3ZAU0F3Mc6BPxM+83i335n/M6z/Rmm1L3d3iRUAJT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=glgw60aqta4YD0GOiD+NI8mb9l6cGCI1dqMH1+oiU/NZdicPnUuPoFqGBhoTiDEuXVGlj2A9iPiHm26ybKqLxBd6BTTWCa7UeDDcwuS54GYsaz3NDK6x41eNGmBou/umimfGLkMA2hhWAqDbsVZaN7Fr+bgzT0ioAcjr1WgI8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG5C0wLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG5C0wLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3901C1F000E9;
	Fri, 21 Aug 2026 20:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343367;
	bh=EdAhBp9w2Ej27Iki9I0k++exk0ZXGDqLBd3rrt25Ilg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QG5C0wLBnqwJ0afrVAn+C1wifheYUE8E101bJapkRHcOkzzUXyDHY5Y1/xpOwvT2x
	 lYVFtS3CRnjYOIyTIbAx96ds9jCp9ucLnB3s1KnvLa39m2ARPFLz6DbcNAwQD/eHW8
	 nLiJI7ZI4znK4FCsG/9mo4gapqxbvo9ZULqC2gyi0zbhUu6LDaXsd13tJK1lrmJO92
	 F0nPI9isyudmIjR+7LwkJsrewKqDoCzESHhcxCwHyk9ZC+FbpsJ6R1x6vD41DX7cuD
	 tpiAiy5KrD2KjdKVFCdeofotOLp7iGOaAKOcPo+r9wiSC8tZN0YicSP1tJ54IGagsB
	 q16e5O8bPXAGw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 19/24] unwind_user/eh_frame/x86: Enable eh_frame
 unwinding on x86
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260821195259.2688377-20-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-20-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:16:06 +0000
Message-Id: <20260821201607.3901C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Enabling `.eh_frame` unwinding on x86_64 breaks user stack traces =
for 32-bit compat binaries due to incorrect error handling in the generic u=
nwind loop.
--

--- Patch [19]: [RFC PATCH v2 19/24] unwind_user/eh_frame/x86: Enable eh_fr=
ame unwinding on x86 ---
commit 26326eedb731dafef6946d5d887c188233f39043
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame/x86: Enable eh_frame unwinding on x86

This patch enables .eh_frame user stack unwinding for x86-64 by selecting
HAVE_UNWIND_USER_EH_FRAME and providing the necessary register accessors.

> diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/un=
wind_user.h
> index c96645c824d1b..df1966bcb0f6e 100644
> --- a/arch/x86/include/asm/unwind_user.h
> +++ b/arch/x86/include/asm/unwind_user.h

[ ... ]

> @@ -15,6 +16,45 @@ static inline int unwind_user_word_size(struct pt_regs=
 *regs)
>  	return user_64bit_mode(regs) ? 8 : 4;
>  }
> =20
> +#ifdef CONFIG_X86_64
> +
> +static inline int unwind_user_get_reg(unsigned long *val, unsigned int r=
egnum)
> +{
> +	struct pt_regs *regs =3D task_pt_regs(current);
> +
> +	/* TODO: eh_frame is currently limited to x86-64 */
> +	if (!user_64bit_mode(regs))
> +		return -EINVAL;

[Severity: High]
Does returning -EINVAL here break the stack trace fallback mechanism for
32-bit compat tasks?

In kernel/unwind/user.c:unwind_user_next(), the generic unwinder only
continues to the next method (like the frame pointer unwinder) if it receiv=
es
-ENOENT:

kernel/unwind/user.c:unwind_user_next() {
...
        case UNWIND_USER_TYPE_EH_FRAME:
                switch (unwind_user_next_eh_frame(state)) {
                case 0:
                        return 0;
                case -ENOENT:
                        continue;       /* Try next method. */
                default:
                        state->done =3D true;
                }
                break;
...
}

By returning -EINVAL for 32-bit tasks, the unwinder hits the default case a=
nd
aborts entirely by setting state->done =3D true. This truncates the user st=
ack
trace instead of safely falling back to the FP unwinder.

Would returning -ENOENT be more appropriate here when the current task is
not 64-bit to ensure the fallback pipeline continues correctly?

> +
> +	switch (regnum) {
> +	/* DWARF register numbers 0..15 */
> +	case  0: *val =3D regs->ax; break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D19
