Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8D2D061C
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077971; cv=none; b=DLToh9lKPl/kMi8HNUPIttdmTbN3UjbutNNKaoJY/AtFgpycenJ+2jyxPzTqH/1si6jtO690Hka3cClNEaArEvFdkAr/Z9OSwm8KsYoFw+EpPb1UYivpas3VEJhoaOSoNYJAclrTpFUeKJWeLLUa2SZtPum8FEFKSCmQ501A+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077971; c=relaxed/simple;
	bh=xr8eXnWaNp6efc10d3bOzfywWosla41ciQSXIJuWAug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mry9OJ/MWBgRE8GWIJtzoJOrEbVNw0or3U7LBlCyPoEPvqtHUkkyzuPsvCcWfHvK8InIHig0oFBapxOrXve5pA9anpKybrc8eLQro/b/RrKZfanAr5bpWwf4k8POl2AOOVh1LXHRYvLpViZ4RGQa7AqO7dQNQsyR3qIhnQGnjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3QvO2bq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3QvO2bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF411F000E9;
	Tue, 18 Aug 2026 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787077969;
	bh=m5n2s9Y2IhjMcqPnIDP0eDCTurfEC9Ukl7TEIVm9c+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J3QvO2bqC8phLH/U6mZu+7NLlcyEHBMSNUO6ccPtTTaFoGH4aIVTdl4j+cn0xx3ZD
	 RGE7186nMHjBHkdBvwmXxy8IcaaHvNnd/y3HtYnZEY/V0wrbIwYEoy2P90YCPFt7Pv
	 tJutgnapb3TjfnFZp+dEWFkxHM1xeEhgHN4aizoYeABNeCt58nLG3lxfSQuuTqs9Rg
	 JArzeJ6441xGIv1ykE5L+77fxXqP/FSjZsefIuegr9cL4pSyTkpSNHRQi0QAb6oLM8
	 /MKWyHqNGn8l/AdN6DF8GMQCje1UxM+tyNqnYZhYGswS1gPixCk6BIYXdAFWzj0wGs
	 dTYAoFscGOC9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rseq: Out-of-line rseq_exit_user_update() for KMSAN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260818181328.2963038-1-iii@linux.ibm.com>
References: <20260818181328.2963038-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 18:32:49 +0000
Message-Id: <20260818183249.5EF411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KMSAN false positive in `__rseq_grant_slice_extension` due to miss=
ing out-of-line wrapper in `noinstr` context.
--

--- Patch [1]: [PATCH] rseq: Out-of-line rseq_exit_user_update() for KMSAN =
---
commit 34d84b6249995289ac0487f7b7677244a859e66c
Author: Ilya Leoshkevich <iii@linux.ibm.com>

rseq: Out-of-line rseq_exit_user_update() for KMSAN

This patch fixes a KMSAN false positive on s390x caused by
rseq_exit_user_update() being inlined into a noinstr context, which leaves
KMSAN shadow memory uninitialized for stack variables. It resolves the
false positive by out-of-lining rseq_exit_user_update() and compiling it
with KMSAN instrumentation.

> diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
> index 31ce349ed42ce..defe1900e041a 100644
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -596,7 +596,8 @@ static rseq_inline bool rseq_update_usr(struct task_s=
truct *t, struct pt_regs *r
>   * tells the caller to loop back into exit_to_user_mode_loop(). The rseq
>   * slow path there will handle the failure.
>   */
> -static __always_inline bool rseq_exit_user_update(struct pt_regs *regs, =
struct task_struct *t)
> +static __always_inline bool rseq_exit_user_update_inline(struct pt_regs =
*regs,
> +							 struct task_struct *t)
>  {

[Severity: High]
This isn't a regression introduced by this patch, but
__rseq_grant_slice_extension() appears to have the same KMSAN false
positive.

In include/linux/rseq_entry.h:__rseq_grant_slice_extension():

	struct rseq_slice_ctrl usr_ctrl;
	...
		unsafe_get_user(usr_ctrl.all, &rseq->slice_ctrl.all, efault);
		if (likely(!(usr_ctrl.request)))
			return false;

		/* Grant the slice extention */
		usr_ctrl.request =3D 0;
		usr_ctrl.granted =3D 1;
		unsafe_put_user(usr_ctrl.all, &rseq->slice_ctrl.all, efault);

Because __rseq_grant_slice_extension() is unconditionally __always_inline,
it gets inlined into the noinstr function irqentry_exit(). The
unsafe_get_user() call reads into the local stack variable usr_ctrl, but
KMSAN's instrumentation is disabled here, leaving the shadow memory
uninitialized.

When unsafe_put_user() is called with usr_ctrl.all, it invokes
instrument_put_user() which explicitly calls kmsan_copy_to_user(). This
evaluates the shadow memory of usr_ctrl.all, sees it as uninitialized,
and produces a false positive.

Should __rseq_grant_slice_extension() also be out-of-lined similar to
how this patch handles rseq_exit_user_update() to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818181328.2963=
038-1-iii@linux.ibm.com?part=3D1
