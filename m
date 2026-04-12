Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B037C91E
	for <linux-s390@vger.kernel.org>; Sun, 12 Apr 2026 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776000188; cv=pass; b=EXNtmkqaDY0XHZ7qm9V8IcjhrXMi3DqIVjXGavTPtK2pbp07VPjOIiE5+7GhWLgcDi6kzma0vBYNaQMXjtbmiF0X0IDCvfJf8tXtkjVXw5UWQXV85+KQnEz226/ioFXEessUlg3h+Xq6J3RehdLcVEvWz8Y6MHBRm+5AKq6zBbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776000188; c=relaxed/simple;
	bh=1p6x7PvyQL+5PGqdAnx23TY8v0cVXdqCOnUZdmPD2Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3G1bkxJCBx6Jzb5/KUJVDWxGskEy49ReyW5OARjycUHa9TI+PRt+rVvwFGsDxrvbZgS59LspWYDk/aKxaBwsZqxUvCTT8TCDoY7Pq36P2OmcP+RrWmDqyDxYz72spiDMJYXbhu777txFnUsdbkqdDRC6QRHrJh1TvRqg1W35pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dccArJm9; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dccArJm9"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so546931666b.1
        for <linux-s390@vger.kernel.org>; Sun, 12 Apr 2026 06:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776000183; cv=none;
        d=google.com; s=arc-20240605;
        b=QPbng1+SKEnoIz6hif4rvlflVdthHJy1v5lSBCNgCNSav4ikL45mUv2HffkYVDQ7xJ
         AJkXOK4piIzTsm4xPra9DY9dsu5q5qWgLz0DLbSqXVCGvPQlXSrVZEyt42tXZ109vNzR
         vAvDJJbhfSQghmoFU6geLrTtOxNNGLpU1lZL0j2TJhXOqFhZqL5FsDE53QQXIu+22Rb6
         DZhrwrX3MNMpsK/LGX6ZUpM5LGBMEIsydTOTT52Jz5ZVDtRLAEf3A6462bWC6cj1oip1
         Bk2LzTFu5eB4pGGYrGYdzswY0UvHsagfwYxCXljsuCfeHLZoySEPg6pNHXeE+eIwr7ao
         YDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        fh=NQJUZkN+z5PMMNsoqK83NbMpXWhaCo34jP38no4N3+s=;
        b=k00+obuhauTV9UF4HzVpepUKbBg91d43C2SlL0+BbP1lEwVkwQLt/KufGxhk+1cvEm
         ROnYIKwgJPcL7Z5R8z0R3G2iMCAZwuJ8nhFV3ocDGYZYR0JP8PdnFl2wOVWapqvTiKtJ
         GuyDup6mwDsM5ZZepFUSFFbn47XSZfyi6QUyVfKERfvakeL7XlBKACUdCMTIMmHEMM9x
         Qa+J7nyPfjgdHZbk2yel3CjOCTuGhR5yEfEdolcWhKBHFamOdF7sWaJwM+6sT+Fn8njp
         nT23XWXUcbGE4v+xub2rr9VY7XhIKbcKl62N3TQJYBYAd/HuoShmg7iAI2lP+NYiL41s
         b25w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776000183; x=1776604983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=dccArJm9v6h9Fdk8lDGNWZnQG14AQ9ZokHDnv7DAL1GW0R6BDoMR0waR0wHnO++sNY
         YJPJSDf/Eo4Jqw4GQ8Gz/T/rsLkNap5uTZ+EpwANfeQ1dFGXyG88+fN/49+h4JvC9C7c
         2+asFn0yzVsL4n2hJqrH+GINWtCINsNrMCDz6yHqeLWKks0EsNy7ssNes4vhdFLCd+tg
         k2Ys2/EuxonOOeyCkSNs/L20e6zSdmHhXIY25hzHxXat+VjZowRiCo0VNk9bdjlPvxYt
         DV9owUMCQ8VWv/4Ldm8HtUCj9QQlhYJyZr8JnJBv87EbzYIfO7KpnQu2sRPezsHrfV9J
         1U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776000183; x=1776604983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=LmTqmHXO3cmNOnyDBVCQ90spU3UrWbiWSFtNhPIHte7EWf8S1Ouy3JnHuLwfagfb41
         YKHLOqoenc5EV01/kOfCVmNd1kDl6zYS9lMYEH2DvJN75uciQIv6wZljqSZeQ9xtn0s6
         L+/kn8VgWEcFZIaRahws68eUE7KqhSRTJAl4kLjmxUZz9eN7p0kfpukj1Qx1yKD8HbzY
         Q68E3Tg24ZdqRDS0XY/FaieA77nBnCJCUd7L+xMrbsWhdgvqLpWUYq8clQoGaHvySp7u
         ObuDvgG0uasS9yBEc0IvOBQAgJ9NzIExujo7eKqernADPLppkuarRhjM+0zrItB5pKLl
         vAvg==
X-Forwarded-Encrypted: i=1; AJvYcCVkugWxjqOxZUAgjYVbIOLIv4Fdt21bSs96o3OVpt36QRdL5WtcYnYZ3YawIkvUaee9qD1GNBIEpEwH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/baOido5YQaV6+i2cPdG2JGda9F1FBlC8fyb2bJshLKsNxIs1
	adqnX/y8AUYraEV5JJw8qErCpIJWs9Vmm5HutpB6vh1e315nb295Tteb0OSXOia5cqk6yVBd9Qh
	AlL8HE09PNk3s42bVDJrtDU4hKmh7+TU=
X-Gm-Gg: AeBDietf21Ypdm4JmqSFMZ8bYP4YCJqt0dvV92WymEZXLHBP86oIETVd6ZaZFYXTAuj
	GVnGoeB4JwfhMRxPdvEeV4sFZG33P2UpE3zVG+rJ3ai7E2mpkwkN4LaxFQ15ITxf6uCstd/fVB4
	DEDrW66r+UEmf1uHJcdsN7JBtw+yQfrw3UnKtjdQZApj/wYJbPmve+AwCO4X+10BQlKt/SnTzAs
	OO010SGvQuhUxryb6Z6VtOX9XVVr5Lpr6c/xg2Q9hUK4B/fY7FoLE+pQwtwhB/HaeUrU4de9SiF
	V5LrGA+UQjtI35HiYVCz3LK3yWo7QUJ8S51TV9j2
X-Received: by 2002:a17:907:e113:b0:b9c:6ef1:ed18 with SMTP id
 a640c23a62f3a-b9d727aa4fdmr352963766b.25.1776000183133; Sun, 12 Apr 2026
 06:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.131582521@kernel.org>
In-Reply-To: <20260410120319.131582521@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 12 Apr 2026 15:22:51 +0200
X-Gm-Features: AQROBzAeMsaeSVePCJ__tEd4f2rWAY6MixXzp_fii2b8vyUpLt4xjSbtYzENFaw
Message-ID: <CA+=Fv5S68wZQapeaYTspOfsuGk=nBj60sx-ojHBSqrxV59Q+ZA@mail.gmail.com>
Subject: Re: [patch 23/38] alpha: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, 
	iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 2:36=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch alpha over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/Kconfig              |    1 +
>  arch/alpha/include/asm/random.h |   14 ++++++++++++++
>  arch/alpha/include/asm/timex.h  |   26 --------------------------
>  3 files changed, 15 insertions(+), 26 deletions(-)

Hi,

The Alpha side looks fine to me.

I've applied this patch on top of v7.0-rc7, built a kernel successfully,
boot-tested it on an Alpha UP2000+ (SMP) without issues.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
