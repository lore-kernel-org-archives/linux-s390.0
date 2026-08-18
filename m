Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A68360ED0;
	Tue, 18 Aug 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065689; cv=none; b=Z2iSZrGVw8T8P0WOhHzsY2SPkDYZfjJ9GnqzKMEaCTsKK+3tIPMqSSLEm0/k1A3m0Bd0ecQU3Z236iHwIc4FO+CPFMjSPI4pjA5rd9i+EKYH70j06UGLSRytu6ZB7CN2cZT7D14Fl9pHJY6PQEo3J42AglDDNKy8C8J1+p9rSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065689; c=relaxed/simple;
	bh=k8dBNQnXGxbZemY4W5x091+BPkI56ZYHqje3kvIuFpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ljV9ivpGiFfbIcLbyr3CMEM+gvZZ3qKw5wP5oZUXv3Jipk/pOQXerLokuFK/yjw/M8NkGpkAWZlVW3k+ANvG5DUX965twkykTrYExni79G6MOGoktBCsWpTGNAe6CXosVi0UcSo4g82i0iYxQ7mq6NIygniEDshC71O9r/c7Afo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjaEbw8+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjaEbw8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D4B1F00A3D;
	Tue, 18 Aug 2026 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065687;
	bh=Vye30xoHx5a8MqmaTMQWoZPcOWzDoMoZQs2u7yMysSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mjaEbw8+ZzGQZqf2p9Cwnz6745sFNrLqvlEg31WK7bxSTREwkWkytt0GZtWGo2riB
	 5MK3tYw7RWZDpZMfUUE3Jeic8Ss7JO7Ynbsp4zjE/raLglD/8h9TDA6CSLSpVJ/aMi
	 2Nmmq7qX7V9OFiSGpKbdR4vRuzJhFwzRLlocrE3m25DGWRdlcUx1I0vh8l/q+rB9vh
	 DDezGgn49HUqKXrh4qF7tDaxZRw5QgHsLcBfVPVI3wEUj+z76QzyyAFTekLETbzY9h
	 ORPf7PlClAWRAXQu88jaS2RhpGJuEyB+ldU8MoD6N/ibrNIalsN5wggb9AQjOUJzvp
	 4uI/wsPhBviRA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 19/25] x86/uaccess: Add unsafe_copy_from_user()
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-trace-kernel@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-20-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-20-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:08:06 +0000
Message-Id: <20260818150807.39D4B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `unsafe_copy_to_user` and `unsafe_copy_from_user` macros use=
 dangerously common local variable names (`__dst`, `__src`, `__len`) which =
can silently shadow caller variables.
--

--- Patch [19]: [RFC PATCH v1 19/25] x86/uaccess: Add unsafe_copy_from_user=
() implementation ---
commit 83e5aa488f68698873050ec00671487d755924f5
Author: Josh Poimboeuf <jpoimboe@kernel.org>

x86/uaccess: Add unsafe_copy_from_user() implementation

This commit adds an x86 implementation of unsafe_copy_from_user() similar to
the existing unsafe_copy_to_user(). It also updates the local variables in
the unsafe_copy_to_user() macro.

> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
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
Could these generic variable names (__dst, __src, __len) silently shadow
variables in the caller's scope?

If a caller passes a variable named __len as the _len argument, the macro
will expand to size_t __len =3D (__len);.=20

This declares a new block-scoped variable and initializes it with its own
uninitialized garbage value from the stack. The copy loop would then use th=
is
uninitialized length, potentially resulting in an out-of-bounds memory copy.

Does it make sense to retain a unique prefix like the previous __ucu_ varia=
ble
names to prevent macro shadowing?

> +	unsafe_copy_to_user_loop(__dst, __src, __len, u64, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u32, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u16, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u8,  label);		\
> +} while (0)

[ ... ]

> +#define unsafe_copy_from_user(_dst, _src, _len, label)				\
> +do {										\
> +	void *__dst =3D (_dst);							\
> +	const void __user *__src =3D (_src);					\
> +	size_t __len =3D (_len);							\

[Severity: Medium]
Similarly, does the new unsafe_copy_from_user() macro share the same
shadowing vulnerability?

> +	unsafe_copy_from_user_loop(__dst, __src, __len, u64, label);		\
> +	unsafe_copy_from_user_loop(__dst, __src, __len, u32, label);		\
> +	unsafe_copy_from_user_loop(__dst, __src, __len, u16, label);		\
> +	unsafe_copy_from_user_loop(__dst, __src, __len, u8,  label);		\
>  } while (0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D19
