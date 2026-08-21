Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E71F12F8;
	Fri, 21 Aug 2026 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343069; cv=none; b=kn/f1HoGIKmZW1X6bJmUD84K8xjZc2iieJ1vpQj3GSY+8caYPiltXv0JwyN5FiPJ72LQvmr+hbje/9QbbWGjgu62crJTJ1wsru9obmd8kT9wyZOuUE/LOB1aiXRTw5WbWXgccwJEZ4QSH41EnK2KtmovHjlqR/n+4AMCqdfuR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343069; c=relaxed/simple;
	bh=XzdyC8szMQtUrQm7TrzHhJ37ecrVWKH9j2ShxVN2MwU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nwSyBAAOIlXxoNiK78dUgBGnVJJB6KfF3/y5FmxjWqkvY3o++0mJLxlJ1wT32vFIe57dAitWBvzw4fToP1VcknKX2JTDQExVubXJuiFw+3rqOzldSv5tw9cRVBUELWxGG/gAK9udJC/ndQt4WmH38bs6Ufiw84+KAzhMQusARGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdXPIgMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdXPIgMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0CB1F000E9;
	Fri, 21 Aug 2026 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343067;
	bh=hfXEQy/5pKsKTf3ZFxzQlft36pt4x3L+EAHL/wivqeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QdXPIgMF4BA8J7Fmbqa3QG8xvVIVk6mz++/9HeySDdR7tOBe66nVL6BcFb+zFZVsi
	 mjZkd1v8NSrJZ8jNeUR561a0pnvgScKDZoUaBk3ao/DSnL3Ct7UeKmfYHyODu5gMUc
	 JKNoa26DIGB5qeA1XaLi3saHpLQr77/eMu1z51l+z3tMpdw7yQv6pvPUPxSAEYmjMG
	 c/5CFcHiO5xBmI15Qb2APp4BcFoQho4UF2ys/aX8F6CasNv/hYKHv141KILyxyoXla
	 3No9G25mafv45FPIxxZm5fSMojidntR9ArNE2JdeHjYwtHmQFGzrEz4NNSgSefRVK1
	 zcz/2v0cKbWMw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 18/24] x86/uaccess: Add unsafe_copy_from_user()
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-19-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-19-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:11:07 +0000
Message-Id: <20260821201107.7F0CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Macro variable shadowing risk in `unsafe_copy_to_user` and `unsa=
fe_copy_from_user`.
--

--- Patch [18]: [RFC PATCH v2 18/24] x86/uaccess: Add unsafe_copy_from_user=
() implementation ---
commit 6d0ae2cda144449266a35cb0d45ee49364b75b97
Author: Josh Poimboeuf <jpoimboe@kernel.org>

x86/uaccess: Add unsafe_copy_from_user() implementation

This commit adds an x86 implementation of unsafe_copy_from_user() similar to
the existing unsafe_copy_to_user() macro. It also updates the existing
unsafe_copy_to_user() macro to use shorter internal variable names.

> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index 3a0dd3c2b233e..235886106f31e 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h

[ ... ]

> -#define unsafe_copy_to_user(_dst,_src,_len,label)			\
> -do {									\
> -	char __user *__ucu_dst =3D (_dst);				\
> -	const char *__ucu_src =3D (_src);					\
> -	size_t __ucu_len =3D (_len);					\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
> +#define unsafe_copy_to_user(_dst, _src, _len, label)				\
> +do {										\
> +	void __user *__dst =3D (_dst);						\
> +	const void *__src =3D (_src);						\
> +	size_t __len =3D (_len);							\

[Severity: Medium]
Could this macro change cause dangerous variable shadowing?

By renaming the internal variables from __ucu_dst to generic names like __d=
st,
__src, and __len, if a caller passes arguments with those exact names, the
macro will expand to something like void __user *__dst =3D (__dst);. This
results in self-initialization using uninitialized stack memory, which could
lead to arbitrary memory reads or writes when used with SMAP disabled.

> +	unsafe_copy_to_user_loop(__dst, __src, __len, u64, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u32, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u16, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u8,  label);		\
> +} while (0)
> +
> +#define unsafe_copy_from_user_loop(dst, src, len, type, label)			\
> +	while (len >=3D sizeof(type)) {						\
> +		unsafe_get_user(*(type *)(dst), (type __user *)(src), label);	\
> +		dst +=3D sizeof(type);						\
> +		src +=3D sizeof(type);						\
> +		len -=3D sizeof(type);						\
> +	}
> +
> +#define unsafe_copy_from_user(_dst, _src, _len, label)				\
> +do {										\
> +	void *__dst =3D (_dst);							\
> +	const void __user *__src =3D (_src);					\
> +	size_t __len =3D (_len);							\

[Severity: Medium]
Does this new macro suffer from the same variable shadowing risk?

Using generic internal names like __dst, __src, and __len might cause
accidental self-initialization if a caller happens to use the same variable
names for the arguments. Should we use more uniquely prefixed names here
similar to the old __ucu_dst?

> +	unsafe_copy_from_user_loop(__dst, __src, __len, u64, label);		\
> +	unsafe_copy_from_user_loop(__dst, __src, __len, u32, label);		\
> +	unsafe_copy_from_user_loop(__dst, __src, __len, u16, label);		\
> +	unsafe_copy_from_user_loop(__dst, __src, __len, u8,  label);		\
>  } while (0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D18
