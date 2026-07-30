Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD639F16B
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405909; cv=none; b=NHP38/Z6PPuy+nMZa0B68em7Z89YikWFbApzku5swya1yM2n7hQiS0VK7ZmvG5l+WN7wisnawKQBQpJuzeXgMfYI8er57Vqij7Kph84GXopUU9DpU7is5JJdTCwKSz41IK5QbjB8kS3qNG604A/GSLnCivu8sOCWkMRd3vscRCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405909; c=relaxed/simple;
	bh=+NLs2tfEQ9EO26Njxu/sBxBLVz3Rn7EMRnNfneluQS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t8WtM3uWNJwvvCuz7aXV0yLROFxtoKQCxfdzQfqtW2Q+WYju8PPsFGrKv9nw8ZEUq9c0+s7xWoQOLLckrC7lXQtv+HDpB+KvVHuZfOFkNZoc0rpNYXk+115c8nyhVd/yQB8WNBBcEQUUPqn1lfplafqHvPr4sSY2e3TEbbVefhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQmcJ6bX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQmcJ6bX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916EC1F000E9;
	Thu, 30 Jul 2026 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785405907;
	bh=UV57H2dHlGsQ8GJv6ULZumHM734AiHBm6SwTA4C6R0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IQmcJ6bXC3FKX8tp9y5/Ur0Vq33CxRZ5E1S9TR1xEeHn3zb+4CJZt2VukVhstCclQ
	 9kizFsuIiS0sECwT/8r7jzr7tiKL1GvxDOyBntujIyGoxHfUWwzdzeHXGPGXQfXtpn
	 vg1dG+n4/TO55SKYL84lzrNKUoaazqMmdQzq7NtLx2oxT0eFb5PNpBJ37GuYz4GIWH
	 acItObJ2lA7slMoereS7HqobtH/wDChphLslGY3Mi9ZUqME2tRrTr4LHXdCq3AWaIg
	 w3TfZJ78/Fif1oUMTvdXrQNNYsgy6fElA+8soInWw0i3jUGQc7kXqknHPRycv4n6Pz
	 EcfZvnCtF/WTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] s390: Implement arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260730-arch_do_panic-v3-2-d5401e683cdb@linux.ibm.com>
References: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com>
 <20260730-arch_do_panic-v3-2-d5401e683cdb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:05:07 +0000
Message-Id: <20260730100507.916EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `pr_warn()` call in `on_panic_store()` is missing a terminat=
ing newline (`\n`), which will cause garbled console output.
- [Low] The file `arch/s390/kernel/ipl.c` does not include `<linux/panic.h>=
`, leading to a missing prototype compiler warning for `arch_do_panic()`.
--

--- Patch [2]: [PATCH v3 2/3] s390: Implement arch_do_panic ---
commit fa5fa116f1eec4d70650b8cf3a838d2dff72e007
Author: Mete Durlu <meted@linux.ibm.com>

s390: Implement arch_do_panic

This commit replaces the s390 custom panic notifier handler with the
arch_do_panic() hook. This reordering allows the user-specified
panic_timeout value to be evaluated correctly in common code. The timeout
now takes precedence over user-defined on_panic behavior.

> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 3c346b02ceb95..6a5fa9213450f 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -2111,11 +2111,15 @@ static ssize_t on_panic_store(struct kobject *kob=
j,
>  			      struct kobj_attribute *attr,
>  			      const char *buf, size_t len)
>  {
> +	if (panic_timeout) {
> +		pr_warn("on_panic action will be ignored in favor of panic timeout (pa=
nic=3D%d)",
> +			panic_timeout);

[Severity: Medium]
Will this result in garbled console output since there is no terminating
newline in the format string? Because printk does not automatically append
a newline, the next message printed to the kernel log might be appended to
this same line.

> +	}
>  	return set_trigger(buf, &on_panic_trigger, len);
>  }
>  static struct kobj_attribute on_panic_attr =3D __ATTR_RW(on_panic);
> =20
> -static void do_panic(void)
> +void arch_do_panic(void)

[Severity: Low]
Does this trigger a missing prototype compiler warning? The global function
arch_do_panic() is defined here to override the weak definition, but its
declaration is in linux/panic.h which does not seem to be included in this
file.

>  {
>  	lgr_info_log();
>  	on_panic_trigger.action->fn(&on_panic_trigger);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-arch_do_pa=
nic-v3-0-d5401e683cdb@linux.ibm.com?part=3D2
