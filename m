Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB134F85B7
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977351; cv=pass; b=LZj4gxRZbXn9qWXYU5pHJuNRxNEDJ/nBJr+PdW6FiCaPrdXYmdF5wGTXeXNjxzwi4ein/nFV4foxGNBQ9yaTMgw9nvCIWVP9Yoav8dE6Ina/VQwo02gJgESZ4RqUKJa4hNg60MuGwgxC9KXqQrzgI57SouiLmuefz+xMb9Rxi8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977351; c=relaxed/simple;
	bh=Bm8IXeZCCjjHRHqufoiH0uSm7tIaA4fZ4x02DGLBDgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVqB/6xHHNjf60I7D//KsjbOpZQMAidfRy69frq+P1Vt2GnPVhecm7l2GEqJA/WKfpMCgb4lNg5a37CtJIS0VUVoIeMrQTZ5T1Q/QjJZ4HtztPdcRomuZIQjN8ziRJ5sobc/muY+ECoPnUyoODPG5I+dBKQslKOKL6R7rbGj5mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkAqllS7; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkAqllS7"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3550dd02c9cso313371eec.0
        for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 04:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791977348; cv=none;
        d=google.com; s=arc-20260327;
        b=FvKU59FTWYOTGR98xK5KqOdp4HUi4wR3ZfGOkTyD7sv30Z16uhaQjDmFT4etFNNVwq
         dwDds+nDWAo7UzVi0Q3IWaeRIkoYyInMfjy5tEHEu7IwZpX66OWIkoEhvPOz1H0h801d
         1PEfvRfMctvjqnLrJcFf8CGAmRDvX1CJ+YMKoQOF9OLQNvL1rUCSyCBdHf5IWZhsJCcg
         SqzYtkt+jlyPuV+995cB6wo+crRj57WilJX6lgb1Je3/e4dXwWmTokLhYrKZFS/qv1jz
         sX61oI+L2HatQcfEJ+yN2v/74AkhTzHD2h6Jyt17ApfikZJZbQ+2EJZ5ttqlCm3puSVs
         yQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        fh=sKP+3U5Ywa1y9yW0qWPQQvN4TuRkULX2BHiaM9wNHLw=;
        b=I5fYv8H+wTSHfOxPCufNoTYf2scKacPmIHop96KHgG427b40Xk/JOdafAiiAcXp8fc
         vLBJncfnC9Im6pJ/sk3+lrEEBoLIihJy963J2+qiE82HjBpZkQRhINGn4IaiCy/6YMZc
         DfpyR28G1Kl6kw6IBzwaE6jJfHTWnwBDXl1VYErbUyDGn3tzL5QiMSEd+bopzIHxrvKV
         0MelgfII1cbKqDP3bPD7Fnw2mr2U0wa1tNxIOQ+NozmoEqrZwdHkltuFWnySBDknU6H3
         1pbYfd22/B4m0BPRCztHP5/ORHicV601ZD+Lsz4etJRbUPSLcNLgVV66SYufe4PFVwEa
         lM5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791977348; x=1792582148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=EkAqllS7uOOZxDGJ4I1yKdIi3WQSBbyUhPsWLoVzgJERDBlfP0X9cEpWzjyHAR90JC
         Z1zW2YqVc7X46XPiuAerNf9mNnAJ0uUF6PLz0rzePzi7U1lf5J9vz/gZr1IuRwk27MI/
         4/D886vhZESIUjDPJZRvHbQYWiiMvCS3NjhX5siJV1JzVFlBVMBE4d5Q1ZOlRDw5uGo0
         qEQHzjWEYvo+agj8c1xw4Nkq2SVQg9Ys3jvU8s3NkIQ4fYLQcX3kMyght8wz2N51o7tV
         AXXBZTinlSID6wvgzNqIrr0dJv5ZGB14N23uEZXq5jf7doeVho73k08XFK/CJX/hTW5i
         pPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791977348; x=1792582148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=kJ6VbNeTOg+a1d51qmULJF4EukwM5EHp7AXiusck9FrCKutVTlxQZ5hT9sG7LY/nGo
         eJP9Ud3xzpJ9iQhG0I6Lz1l+MTUbKCQ+rdNZTn3kPUhjefWts2TG7gBWe6RR1M8VkaEj
         wJeMmaf55Wi7+XTMg9oNw2j4ZhLDEtIOQ4snXBfjq5Qz6wFmQw9MbgIGlCoW20xG8EW0
         6SSntbHrhtxk/cw2/RFDK7TN5R+yVQTYWNSy+JVVLaLLr/IGjB+9wYZhFtz4A6j40f5Q
         BXwatqdoqAMuPrfV3fc/Cex1T7GLcGfq5L6ctv2uLObZytbmGo8sIfCN6i7lT5SlsXhI
         AujA==
X-Forwarded-Encrypted: i=1; AKwUvBwFZP3oX+F7xfd6tVLwf4utNOefQRO6HOJYc2Gtzgf/s0us/nJfE8ej2Wrhqw3XNOTfsU7Q2+QkDCHj@vger.kernel.org
X-Gm-Message-State: AFq9FYJdKFgRTX30e6U5L2LJp5UiCxH0mgXpcEWPwn4CVXOU5/mU8c/C
	smIyodZf3gAhxWKZD1QR41Xbff/vSjVsYXvlD2aGF0DfRWrOrurdfkDPkFI3K8tlfozwwmCB2WL
	IAhdKMYZnpKLnNENVKh7p3v8CByZuT8o=
X-Gm-Gg: AYBFou3XlwZetOVggevbcEwD1z9ETYF52/xIRJy/G/+S1BWPu2+6XV7I5lQtw4wWHUZ
	YhjrAVXJ15wX/L60KAr+M2gubJ1DumbHltWO+0CA4xeXnmL5KINZwa6lPqT/3aTyX4hgduNuu/U
	5Kz18RpfVzxtjZFwtHphdXMAgJgku//m059FG+du3Zu+JuaJ5bfqRwkYv7omH8uzpOTaxwn+RVx
	ESKa3yCfsTh3o/5F70dPqlaOmN/YeanMjA2vcISqJv1QIaO2svMR4Rtd9npJFnrmPoXVcL0EopQ
	O71R/irICNjs0EgqjCIICmSqoexiCdzFhPd3o0tv6u6eFqhdARe9YWVt0/U2oQGP+/yrBa6A63m
	4uv6Mm3frBLnv6/gUnOI5e1FYyF3P8aRvewsnA5R+Mn6ra5HxAz0aRkhA/JvMnPiUZCbXldEGT9
	M8EZlQNkFwydr6s2pYFk2yMgmdZEh7seezvzfG5MAwgXeHY2oAcFY=
X-Received: by 2002:a05:693c:6215:b0:35b:cb8a:8ce7 with SMTP id
 5a478bee46e88-35bcb8a919dmr14326600eec.1.1791977347656; Wed, 14 Oct 2026
 04:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
In-Reply-To: <20261013223946.1836757-2-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 13:28:55 +0200
X-Gm-Features: AclHuK8qVHO7HVQy6LgzcUgjYcQf3EimC6SJcN58PVqcWVdOf6T45eXZNeTLsEY
Message-ID: <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> +/*
> + * Optional: not supported by gcc
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#require-ex=
plicit-initialization
> + */
> +#if __has_attribute(__require_explicit_initialization__)
> +# define __require_explicit_initialization __attribute__((__require_expl=
icit_initialization__))
> +#else
> +# define __require_explicit_initialization
> +#endif

The LPC slides mention Clang 14+, but from a quick test in Compiler
Explorer and a `git log --grep` on the LLVM repository to confirm, it
seems the attribute was introduced in Clang 20+, no?

If that is correct, then it is not available in all LLVM versions we
support (LLVM 17+), so we should add:

     * Optional: only supported since clang >=3D 20.0

With that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
