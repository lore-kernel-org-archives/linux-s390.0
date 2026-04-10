Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F2346AC2
	for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835135; cv=pass; b=mI7428fSTYD0cNRkZmpArns9soqPL6HeDUR87eZ7eylmbHiS4FL4XzKIPd1EI+nYJKustUEVAw7z+3fHtzJIxt3LSun/t0jC5ZknbUI+E1PlePZsdbOYMARDaGVHAGS42ySWfKKeBR/+9BkEHWFScnPr/fmNU++MbbOy/o+WqTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835135; c=relaxed/simple;
	bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bebExFI3ORs/Ofw/HmQymKodmf8Ep7or3NjZq7L8zRvt0ZM0+WtB4fviVzFl+AP2j+6VO6yox0xQLgkwVVA/mM+2i2gYGQX/GqvJ7Rz/SkM0kNhRHQXUoWVaR9b8HxIvWqgN73X1ESz7Vjnq8uCMXECumDJfhv3kbFpdE8VCBV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=cs+zJ0r8; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="cs+zJ0r8"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c1a170a50so2014880c88.0
        for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2026 08:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775835131; cv=none;
        d=google.com; s=arc-20240605;
        b=NcZxjfwAlPWU7tTscELlNzSfZQ4NgE7Y30Y1mWtpZBIKCKY7LLq1ODoE7rMFkTb06b
         eGjea2WhcW91j1Zqs5DSTVfth2HqtR9n/YVr31g797zLi5jujBSgRr+Lm+cs1EdCMyKY
         ljFD5cqU/BSpXeIwnPUadCLFHW8M9DFpr49UnMWuArpQEdveYFR/B2y2b/xMpVc/Th4d
         ZRMBtYMiGpUMZ2zWfJTM2/9lUFGdBgrNzsFNHOuQa/gRg8U76P+gPF4Uv8faC/Bmqu+z
         pLaAoHooFwlPJjC61hdH5aEeuEa4fUmszDBGJouu20Fn5hgMS7xXOzNQYZn3icJGAtF+
         smLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        fh=/mv2uuNcbzrPNQ6OSemj1O9jOGqMusc90Gka1//n2hk=;
        b=louUGpX3oB38gHKb3fnGwpjZvkhsYK5KNUx3aYdkNfgfl5+bQQKTbp4ycHwkvtABK0
         rBvWd3o5nlhguEo+LYPdUniG+e0cZRhWfrM90/4ZGzpBBK2qtvOmaTUZZFf9/91XWz4y
         c11Jh7FiS+1igw8RDEwWLyD1EOtGSdHbMikVxu5Wic/NX+2qfkNGtlKlzGlXn4AXpjj/
         2fjTuOoos/cXGX4uCqYd+QaYlf5P8yIEUt7b+JtkzInn6kreIHTQJsY8z/dBRkp3AeZT
         o07mPz9+rkfaeNBSQuqEfuLt3Bws/9M/vbvinIC/ZBzhOF9Mi+gxsBBACouvRoGFgf80
         p43w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1775835131; x=1776439931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=cs+zJ0r8E1VxbeERL/6orYDfRzBNN0xV+FBDuuOmam2/EuHZ7scxaUctzZ3REo2LBr
         KdQSu4tLtUeUQ/Am7PGmtjXBLQ/7knpdVClf5erC+tpkhYxe59BfVvuW88STHDIDr49T
         TpKPrBeobAalm+DfnxseCj+mCeyPg4AFXq4Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835131; x=1776439931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=PUOaxUqj0SOqaA0Ha7muAFFJfTcqOoTF3CS0B4Y8Okh9GxldoR8o2ypNz5B3hYdtmc
         FwpktW8wQJaZRVLKhh/o21aMbTw8hGz65yqgbfpB65ixi3BlxwuUcvWbfIVPnIiKMi2g
         QdLZdI7JIZjZ+IDSR2Qcb7QHdDOBANXGY1oCH8bP27oU+F09BE5RS833BjENPOGVMlut
         bWrHdgc1897GQdi009IdlV2W6G25E2dmWXSORKiZ4zvDfHbJN389O9884USsP7g6GB3y
         zZwUf4Bq64DOy2ZESjDbrfwvyODpiK3xn2YqcOFOMCgP0s8LGz2OLZJeGkuzXIokUClW
         vFUA==
X-Forwarded-Encrypted: i=1; AJvYcCWdt3KtgLCfF7MzN45+tDDJ7rO0xKwMwnueQ7nDijJ0U5m5x8Xe6Yu0z8f3m1o9gzLsYkeoRNvXt0d7@vger.kernel.org
X-Gm-Message-State: AOJu0YwoA9R8V6FmVsOPteW7l2EDmMU7ZQHUMhqpQIJS+em5PqY3HmsD
	eFpOUab5UShCngmrog0bpzz1r35P52FJ92hCyZky93W0O2cjIrutD6u8Lfe2KSR7JI0M51Sy/8l
	Y2o104FlB8S+B+db791d6cQp91wXEMbhZgHh8N7tP0Q==
X-Gm-Gg: AeBDiev+/lh+hhdGojx8KoXeHiWbphn3NNJID7at51ZQOBZlTYyrPyYkeE3dTFtZbBR
	SYPzAbGgcmFhEYr0p5745wIqvKRvMcwUid25gFIp3AAU+VUh5icMhgYe5y9O6zx8J1nHLDCkYNI
	yedcugFBYWMn+NdA7A70VRGEvE7pPaguxw6iIq73zRBk6wnIQn109Cvwo00wZaAykK189XiAMNG
	5eBacZbq6PKZyP3g7OKwT63nnfcwt2gKJJbej9TjaE1BEivYOA0sE0zbyiumkFn6n+Ms0iKGgJB
	g+Oa
X-Received: by 2002:a05:7022:6097:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-12c34f069f8mr2159203c88.34.1775835130696; Fri, 10 Apr 2026
 08:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 11 Apr 2026 00:31:59 +0900
X-Gm-Features: AQROBzAnX-XEClLFV-qWYFUzCuq4P43sNZviESiWFI1yCPXm2VtVZ2QkaUGJoPY
Message-ID: <CAFr9PXk7qK8-2JWrrfgXHoS9JWTRL+WobLjmAesyCE9VLL8ZyQ@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, 10 Apr 2026 at 21:39, Thomas Gleixner <tglx@kernel.org> wrote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.

I have built and booted this on my Amiga 4000 and it apparently still
works so FWIW:

Tested-by: Daniel Palmer <daniel@thingy.jp>
