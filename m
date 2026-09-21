Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA64A0156
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007317; cv=none; b=Pb465ubqPuSHJxYlM9pWde+4z2cK8DDD+Q9JAVB3TNRHm1ZgAp4PmFQNouPsFfQdvOVKJqoGGJGFWD+IniQtcOooNIoVMUjVPNVaVVxfrLnJh4zmKakMFcx0t2IdubR9vR7lFDP6HLCDb4KgJf4N1zhjngb+oXwu1FGH1XokpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007317; c=relaxed/simple;
	bh=ELvDNsEUg5uUqq+TRizv15ZyqFFfDxhxuy3UUh0Ppw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cHHbVfJb9vi2xveSA1QPQnMABeEBP9Uqd5adqbmTH+IhN+Jll4gwg928ryQqEq8WDN119VR3y4HduB1UCbU9Ypx/1Vo7C8N+/UZX/lbDjdqnpDquZlKNuwR6DjkhJ+cPwGk2MXdfawy8kj9LBUhXXTytfjPtC0WRUkLjJ4AMBjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGw3rJvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGw3rJvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882DD1F000FF;
	Mon, 21 Sep 2026 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007300;
	bh=uHAQ9ekjSwRFujEVbKlKmsDAbGk4+p8funRv8xFa6kY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dGw3rJvEa3uI49mSsNPTY+JcfJv0c2tUVuQjSIwIwJLaN58X7DLVLL/UNt4vKDuxL
	 D3m1Lw3MtgmaI5OAJ2+a2qQQ6Y33oY3S7KBex+x6kJsaFqXAvrkvmUlwWipfBXTfx2
	 AnW0OzEUhz6oei87HxoKwlIV4AIemfsTbDayN8rMaFfOqADkWypbAuTjRKkJekHFOh
	 XXvtn3vlEXxWK04w8muCqqhxk5olWBGdUrZ9q3fYHKg0YsKJnbW5BP76ST/JqTcTg2
	 eunfHNzX/ioKO88veaXsBV7HQHY3VOOWAt7RCmFiRwo2GnCx7x7gsd3n/XhPvds4OJ
	 Y472fexYr/E5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/11] s390/percpu: Let MVIY_PERCPU() calculate
 alternative displacement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260921155806.2447506-5-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <20260921155806.2447506-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:15:00 +0000
Message-Id: <20260921161500.882DD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] s390/percpu: incomplete refactoring in arch_raw_cpu_ptr()
--

commit 7a99372f1f5c810f33cd0d340f3c23eb3cf46f5f
Author: Heiko Carstens <hca@linux.ibm.com>

s390/percpu: Let MVIY_PERCPU() calculate alternative displacement

This commit updates the percpu inline assemblies to calculate the alternati=
ve
lowcore displacement directly within the assembly string using LC_ALT_ADDR.
This removes the need to repeatedly pass the same alternative displacement
values as constraints, making the code more readable.

> diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percp=
u.h
> index 9888b38dedab2..3bc448c4c2dd7 100644
> --- a/arch/s390/include/asm/percpu.h
> +++ b/arch/s390/include/asm/percpu.h
[ ... ]
> -#define AG_ALT(disp, dispalt, reg)						\
> -	ALTERNATIVE("	ag	" reg ", " disp	   "(%%r0)\n",			\
> -		    "	ag	" reg ", " dispalt "(%%r0)\n",			\
> +#define AG_ALT(disp, reg)							\
> +	ALTERNATIVE("	ag	" reg ", " disp			"(%%r0)\n",	\
> +		    "	ag	" reg ", " disp "+" LC_ALT_ADDR "(%%r0)\n",	\
>  		    ALT_FEATURE(MFEATURE_LOWCORE))

[Severity: Low]
Does this refactoring miss arch_raw_cpu_ptr() which is defined earlier in
the same file?

Looking at arch_raw_cpu_ptr(), it still uses an ALTERNATIVE block that pass=
es
LOWCORE_ALT_ADDRESS manually:

arch/s390/include/asm/percpu.h:arch_raw_cpu_ptr()
	asm_inline volatile(
	ALTERNATIVE("ag		%[__ptr__],%[offzero](%%r0)\n",
		    "ag		%[__ptr__],%[offalt](%%r0)\n",
		    ALT_FEATURE(MFEATURE_LOWCORE))
	: [__ptr__] "+d" (tcp_ptr__)
	: [offzero] "i" (lc_percpu),
	  [offalt] "i" (lc_percpu + LOWCORE_ALT_ADDRESS),

Could this be updated to use the new LC_ALT_ADDR calculation strategy for
consistency?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921155806.2447=
506-1-hca@linux.ibm.com?part=3D4
