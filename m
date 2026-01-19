Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309C21A434
	for <linux-s390@vger.kernel.org>; Mon, 19 Jan 2026 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817184; cv=none; b=RvztoMnQ9zsA0EB5I9fGr9MAEYeWSzQJPjTXe8m256GAv1g3JYIU5rVR38kp4UGYBY/RVbvyMlbmjj2KFFiKbPbWB8ZjOiF06Ue+2TwMrUcZYaMWwgQkt/N5sVs1YAMKrHsk8/mhNMwJsw2W2jquddArKPn5EZAclRXjulvszW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817184; c=relaxed/simple;
	bh=1JkATqi5wAX+Tb/87K06CYv0cw7OmX176NC/mF093QE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIzwKgVVTfI3kcZbhmk3RwSl4wVhH+jjz2d78tF9pZcj3mBEtdUCo6t0+b7odufUUoJ9yma3WX37AETTPqHihQ0ydB940aK2tzOHA//G7KT5SVmvWyzc3STeQnaU1ovq5m5bL8a/NLAkE6TnM2oo0axHfrUXHFVncEjGAjvdZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNId2tL4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNId2tL4"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so21485345e9.0
        for <linux-s390@vger.kernel.org>; Mon, 19 Jan 2026 02:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768817181; x=1769421981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqVWadMkJ0xV7b+9+R2K7XfNBOxyor4uthrrFNDywHI=;
        b=GNId2tL4UUadX1eRxP+Jav/HOUdQyFp8nhdDul70ZA7S7Us41CtEWt9VRcJg4nKhdn
         uPxukOVDj0Wq0KtfC9SZxdVEksPnLerG0W07HYK9SPp4w7rDoTOO0ynmwMA4GlbOqIoP
         ZGaRp5oCLyQBRCAv9LX3KgM1apjp9JT9BvI6WcXt8+6ZC+jvsVLCqkr2nhzP0TCF9P1X
         LWsncDVpjX10Equ2qlufyi9LDiAx8gd9JVE1vchGqVXgksD2vFfFz3NELiV1IKRHk4XI
         l0ZPXxqbiwZ0uXOi3xYcbXzyuFWai5zF0SnyyFiyRVk5KAa31l1M6/1bREstapugS3hK
         FuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817181; x=1769421981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sqVWadMkJ0xV7b+9+R2K7XfNBOxyor4uthrrFNDywHI=;
        b=G0QXycVwiRL+hlZ3lL9HxJVXLpSmSSsDL4Bx7lc9gve7amo6J2wRoBzs9GtFeuMR9c
         +yFJkUtQqL6M4x49ueUMQLuu9y0ldHJXpGnQK+lkmDeriTaBY6s0R/Ud+hoefluJ533E
         5w9Ie65SYPWmb4/vxkcv5K/vpObJiKx3NPaxmJwrnbFGRA+tkbjCxZLu2zeen1yU3eZd
         YRYeDmhA3KPqC3bUxfQ7pFxhv+VOZBXI9ZslibDk4MdvKFfUyzdoReLjFmDp9hWldXzM
         Xj5n/SBIyQkIkOVrFD/cbHfSq4tXGSVvhZnFNDW+YEj9QYg36weao2xhbqSk9H0w10+0
         vwAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaCKaGbOXXzc1rQDocb0RCw0DQLxCDnsnMEZZ3yOqUal/tEP0mkAWwWBQ42Gd39VtOLEcP9AJ/lsik@vger.kernel.org
X-Gm-Message-State: AOJu0YwezG8RV58TLr8zOD/E5mFGMipD2mkhg6mKY9Pr1fw7dfaVAOms
	X93Yxg9d6sxzLv4MPLrF/Rj73dAIxWmbpU7XPKSP04WS0xVB5Q9BATsn
X-Gm-Gg: AY/fxX5W3zQRDMMdAsqCRtVYbqfD0/wVklgYZkxjmG+dy5UvmwX6JA2LbuuGcYY3ELV
	AdDs28k+/lmxe3NPJUAUBJNyrzr0Z9Kv3TtLsUtT6FPR4kAKzzRcjRbYq4cz7eCqAJfmhtBGgAm
	iDLh3al2oxq0kK+nLaSYiuyI2FtqUAKxEkPpyJW9dRwQsSdpPWerqFb520BjAPcmlkAxpSMgdO2
	EHGdFYcqZ5yrL5XREeG+ZdGEl5lhU9kvmuH/WgZIk0i3yzYKPwvTJoycC9RhU+xHs+ycKCPK29w
	7wR+DN3+jk1O2H1a4y0tdVGuPFXmrmYqzjH1p/ul/8G74TyC26QDPeeh+UteFFR4gERpClwQkqd
	3g0t4M4NyKtnODAd/ab8CTp15CpA3h9LOd7MihX4hYtSGdLK+knDxPWRjW8/iNoEefueZ4R/xS1
	e8UrYciNT3EDGk1W++fjfRFP8oUsEMIulc/s++oZ22Zs8M2W0TFduk
X-Received: by 2002:a05:600c:5285:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-4801e33c1e1mr121349185e9.21.1768817181059;
        Mon, 19 Jan 2026 02:06:21 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e80c477sm213350375e9.0.2026.01.19.02.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:06:20 -0800 (PST)
Date: Mon, 19 Jan 2026 10:06:19 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260119100619.479bcff3@pumpkin>
In-Reply-To: <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
	<20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Jan 2026 08:40:27 +0100
Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:

> The value of __BITS_PER_LONG from architecture-specific logic should
> always match the generic one if that is available. It should also match
> the actual C type 'long'.
>=20
> Mismatches can happen for example when building the compat vDSO. Either
> during the compilation, see commit 9a6d3ff10f7f ("arm64: uapi: Provide
> correct __BITS_PER_LONG for the compat vDSO"), or when running sparse
> when mismatched CHECKFLAGS are inherited from the kernel build.
>=20
> Add some consistency checks which detect such issues early and clearly.
> The tests are added to the UAPI header to make sure it is also used when
> building the vDSO as that is not supposed to use regular kernel headers.
>=20
> The kernel-interal BITS_PER_LONG is not checked as it is derived from
> CONFIG_64BIT and therefore breaks for the compat vDSO. See the similar,
> deactivated check in include/asm-generic/bitsperlong.h.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/uapi/asm-generic/bitsperlong.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-ge=
neric/bitsperlong.h
> index fadb3f857f28..9d762097ae0c 100644
> --- a/include/uapi/asm-generic/bitsperlong.h
> +++ b/include/uapi/asm-generic/bitsperlong.h
> @@ -28,4 +28,18 @@
>  #define __BITS_PER_LONG_LONG 64
>  #endif
> =20
> +/* Consistency checks */
> +#ifdef __KERNEL__
> +#if defined(__CHAR_BIT__) && defined(__SIZEOF_LONG__)
> +#if __BITS_PER_LONG !=3D (__CHAR_BIT__ * __SIZEOF_LONG__)
> +#error Inconsistent word size. Check uapi/asm/bitsperlong.h
> +#endif
> +#endif
> +
> +#ifndef __ASSEMBLER__
> +_Static_assert(sizeof(long) * 8 =3D=3D __BITS_PER_LONG,
> +	       "Inconsistent word size. Check uapi/asm/bitsperlong.h");

nak...

You can't assume the compiler has _Static_assert().
All the ones that do probably define __SIZEOF_LONG__.
You could use something 'old-school' like:
typedef char __inconsistent_long_size[1 - 2 * (sizeof(long) * 8 !=3D __BITS=
_PER_LONG))];

	David

> +#endif
> +#endif /* __KERNEL__ */
> +
>  #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
>=20

