Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6F37B00C
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557495; cv=none; b=ZNdhbGj4GZVBIfndg15SNMGzdPax6lgq/524svT6nJw4VKeYC+UZ7v6RXnYqqld+boe2zf4AtOAtEzHINJl0V1CCZdSyKg0Eg7hMAHSpfs+nsFYb/ogY28h+BR25J6p7wQlLhtgHTf8PDfHwx04Ykh9YcIJT8pZTrJN8gVsAWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557495; c=relaxed/simple;
	bh=yqIQ5vjGk/sDrkp8lJWm37GkbHfEMRJJwVau8SV71lE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IkgMUxjQuxClZbNEWvcr3CidlapWBjxfAt6JDlQIeEspp9QTOGrViqLEvLPnFngU2SL4OkMwKoK+xk6dsIopFiyVfKs9NWAh3mpJbqUGKhqgH4CBGaejHINgwy9kWcg/b+EtffPm4f6Nlhg22i3YvX14OGsqwhl3+EQhTnNw1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au1VcDT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au1VcDT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34F81F00A3A;
	Wed, 12 Aug 2026 17:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786557493;
	bh=Np+WMXaQI/iPcugMewW2CvATpwWleurikz/rGt1m5To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=au1VcDT4mSZBKVB6Ck2JmSZqOpBMbZo+y9NVK38JDo3OMBk+kHd4iw48eDfwq3xcu
	 mP3c4oEzHZz8pT9jGe/H/VPtB50yP2OcwiI0sFLyalglAsSKQF65XMbTNO4gMG7+Am
	 4j3Xgj6n4nIiOjlOevHkyxTpPeUDEDx6SuakoAFSGpghYLBVTl2Z0M9epNMx7YuXtc
	 smBpglZPkA2vqmpVSvttA+s3vd2o9AXtV0pNl3jS49A7dhsx2f2BTrx9Nv45RdkpfF
	 TLV6WP1/Z2yliLkZMUNnpWvCUuDQBSkIWhMTQkw8AJ9Fe9RaIze5+2ZNTYeFsEezxq
	 AXNYkq+xMnblg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/13] alpha: Remove alpha_ prefix from custom
 syscall entries
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812-tonyk-syscall_table-v5-12-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-12-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:58:12 +0000
Message-Id: <20260812175812.B34F81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `clone3` syscall entry in the syscall table specifies `__clone3=
`, which does not match the actual assembly entry point `__sys_clone3` gene=
rated by the `fork_like` macro, causing a linkage failure.
--

--- Patch [12]: [PATCH v5 12/13] alpha: Remove alpha_ prefix from custom sy=
scall entries ---
commit 849a21587e678cf6cc6690371a1a55c69f5ba4c5
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

alpha: Remove alpha_ prefix from custom syscall entries

This commit removes the alpha_ prefix from custom architecture-specific sys=
call
entry points and renames them to use the standard __sys_ prefix. This aligns
alpha with other architectures to make it easier to join the syscall tables.

> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index fcfd06529b12e..5ca044efa2084 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S
> @@ -863,9 +863,9 @@ ret_from_kernel_thread:
> =20
>  .macro	fork_like name
>  	.align	4
> -	.globl	alpha_\name
> -	.ent	alpha_\name
> -alpha_\name:
> +	.globl	__sys_\name
> +	.ent	__sys_\name
> +__sys_\name:

[ ... ]

> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 25180953c3c1a..34151d1653d69 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl

[ ... ]

> @@ -474,7 +474,7 @@
>  542	common	fsmount				sys_fsmount
>  543	common	fspick				sys_fspick
>  544	common	pidfd_open			sys_pidfd_open
> -545	common	clone3				alpha_clone3
> +545	common	clone3				__clone3

[Severity: Low]
Will this cause a linkage failure during the kernel build for the alpha
architecture due to an undefined symbol?

Because the fork_like macro in entry.S now prefixes entry points with
__sys_, the generated entry function for clone3 is __sys_clone3. Does this
table entry need to be updated to __sys_clone3 instead of __clone3 so that
it correctly resolves the assembly entry point?

>  546	common	close_range			sys_close_range
>  547	common	openat2				sys_openat2
>  548	common	pidfd_getfd			sys_pidfd_getfd

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D12
