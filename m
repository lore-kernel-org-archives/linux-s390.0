Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2337F315
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202131; cv=none; b=DCo1ZeJRW68afNemn65n/jIW7gw35+EHMKVC01OisVTj6+mhfBwDFtCtMQwLT+c6J7nwf4n6/4psHtmVB7wjhngCTVWXioFPo8gjmsDgEvXyXZnnu4dZrPDenCyYZxpmdyQd4WKEstVQmARcTzIOXlx3EyCe3qQJxbQjmxzKI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202131; c=relaxed/simple;
	bh=TYmP22qyf6TRDXveCND8MspkQJFeICg3i40QyLWffow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X9avc729J3bqWl2cYC2tR88racPxLFefTNgCg6SkWS4cffjMmkyAIo37u0ZNW/S1Qcs5CdP6il7dIwvqVOpDze7vGzixuWz18UzhdYJ9+P2ITmiv0G3g1UKTYnNp1kCrDMnK81r5L2c4Ao/WxBFnVGQikNVi/qp3XYH9Ktn8d/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGGuBT9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGGuBT9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627D91F00A3D;
	Mon, 31 Aug 2026 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788202129;
	bh=dCrFySpzZPxIt6PjXwrT9Cl6YdXgG9RY+9ukaJ6TK/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MGGuBT9S0+slRxQOYbewab7SL8mJGB+ReDWNKMZSCI7+/YwVvkM4uOrj4+JlfHRFZ
	 a9DeQ3sRQgERWpkQmDa/Sz4fmktb3kC4oxtL8liGXPzVDnADU9L1Dy1h+8CFklx6di
	 QAD5lr6WPFG1Zk6LAVEY9diVtMf4cpISxAhBfOY1Oxx8EDv87CheFBGfnOyRlzn839
	 zFIin/KLcoA2geD33/KJXK/0jcSsgk6R9/5NMHEEbQHIrF0JqqZwgsiEPF6dxI08L6
	 jbyvAwbWeweDQZzHacb6XhuodMDsg/sm71djwHO1uvyoLcaAbL59YFrUoyyGatlk3T
	 yhxuiGGqNpQ7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kmsan: fix false warnings in return_address on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aleksei Nikiforov" <aleksei.nikiforov@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831152811.3817938-2-aleksei.nikiforov@linux.ibm.com>
References: <20260831152811.3817938-2-aleksei.nikiforov@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:48:48 +0000
Message-Id: <20260831184849.627D91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Brittle backtrace logic in return_address_noinstr dependent on u=
npredictable compiler stack frame allocation.

Pre-existing issues:
- [High] Preexisting off-by-one error in return_address() resolution on s39=
0x.
--

commit 6db102bd4515b51f9b3acc19ab3e650b460d0d09
Author: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>

kmsan: fix false warnings in return_address on s390

This commit fixes false KMSAN warnings in the s390 return_address logic
by marking a wrapper function as noinstr. It manually accounts for the
additional wrapper function's stack frame by incrementing the backtrace
depth.

> diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrac=
e.h
> index 692c484ec1630..9a9f7f2f2c369 100644
> --- a/arch/s390/include/asm/ftrace.h
> +++ b/arch/s390/include/asm/ftrace.h
> @@ -23,7 +23,13 @@ static __always_inline unsigned long return_address(un=
signed int n)
>  	} while (--n);
>  	return sf->gprs[8];

[Severity: High]
This isn't a bug introduced by this patch, but is this preexisting
off-by-one behavior correct when resolving caller IPs?

On s390x, a function's prologue saves its registers, including the return
address, into its caller's stack frame at gprs[8]. In return_address, when
n=3D1, the loop executes exactly once, advancing the stack frame pointer to
the immediate caller's frame. It then returns its gprs[8].

Because of the stack frame layout, this yields the instruction pointer of
the immediate caller (CALLER_ADDR0) instead of the parent caller. To
correctly return the parent caller (CALLER_ADDR1), shouldn't the loop
advance n+1 times? Lockdep and tracing paths rely on differentiating
CALLER_ADDR0 from CALLER_ADDR1, and this currently causes CALLER_ADDR1 to
evaluate to the exact same instruction pointer as CALLER_ADDR0.

>  }
> +
> +#ifdef CONFIG_KMSAN
> +unsigned long return_address_noinstr(unsigned int n);
> +#define ftrace_return_address(n) return_address_noinstr(n)
> +#else
>  #define ftrace_return_address(n) return_address(n)
> +#endif
> =20
>  void ftrace_caller(void);

[ ... ]

> diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
> index 18520d3330581..db458050d8bf3 100644
> --- a/arch/s390/kernel/stacktrace.c
> +++ b/arch/s390/kernel/stacktrace.c
> @@ -146,3 +146,11 @@ void arch_stack_walk_user(stack_trace_consume_fn con=
sume_entry, void *cookie,
>  {
>  	arch_stack_walk_user_common(consume_entry, cookie, NULL, regs, false);
>  }
> +
> +#ifdef CONFIG_KMSAN
> +noinstr unsigned long return_address_noinstr(unsigned int n)
> +{
> +	/* Add 1 to account for call of uninlined function return_address_noins=
tr */
> +	return return_address(n+1);

[Severity: Medium]
Is it guaranteed that the compiler will allocate a stack frame for this
function?

This wrapper is a noinstr leaf function that only calls the
__always_inline return_address function. If the compiler optimizes it
as a standard leaf function without a stack frame, current_frame_address
inside return_address will yield the caller's stack frame instead.

If that happens, the manual +1 adjustment here will skip an extra frame
unintentionally. Does the compiler consistently allocate a stack frame
here due to sanitizer flags forcing frame pointers, or is this backtrace
logic vulnerable to unpredictable compiler heuristics?

> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831152811.3817=
938-2-aleksei.nikiforov@linux.ibm.com?part=3D1
