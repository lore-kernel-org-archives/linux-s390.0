Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387BE2253EE
	for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828409; cv=pass; b=IkplD6QhaXCEyubow3UduRa9M2u/l3WnZxJ77H9wXrKreR6+hbRp6++p4xr08enWKtoJZXb/yG9ne06tpXTcGe5gTe3zWcKa/4GBEik2FbEj4Dldg7SFyscxkashXpkPFsqwXBpcXJxR5mirtw9hdELp4+roqCac5ZFa5NL/a2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828409; c=relaxed/simple;
	bh=LSR04DrYd2CNPoGkLuzcgQfT1tMVn5ZfdEM6iihG19s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIMaxW8jLtbWR3hVjZbpmw3t3q6EFnzQIl75U4063oGC2Npyu5WWRqgkCa323/nH46BXYPOEvL+bXgpl860GxmzFEUxSxrV9wR6/kKcLzKIUmmblcnlWo2uMVSk/+loI0hm0EnG/jOb1IJ7VEb2FYBAjUwropQOqmGGR+aqNEzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXkk7MjG; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXkk7MjG"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-128e4d0cc48so9423212c88.1
        for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2026 06:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775828407; cv=none;
        d=google.com; s=arc-20240605;
        b=MqcstJceK6dXsRzZ6M5n90v1KMsCdtOQX3xJz+p6stUOm9cPW5O+lHpSjvXTF+SRwL
         i2P6alPcuo9ekFu2uNgrtjgBnuXv+3ogzobXQVvBSohHLM0p1+i5S6TdnrzmEC9tXlO6
         Zd104Dr+GRCjEjBtW6G8V056OFDS0+elAaDXvfvAnKq2ENpwGsP2yT8ChHkJWlSvSSYa
         ASENpL4X/j/MqTVSTP/HSWYYHcz5BUNQSTGUcqr7jambi4DzLHssCmyVjj48arBRBAW4
         KVDHiRabpJKDdi0QEt6aLQKEbF2IfYjo3BtfDxHqiDNNmiWXaTtu64uLYQkd+EMPB1NB
         YANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        fh=C6GWAQQCXlkTLwyE35wt9MT1oZAaA7WYr1czKuzsKys=;
        b=A/ZfWVViTJKeVN0u4vvubbFiD+g9C0IlDs+VzlM/rvsqgwTTZhcxTwvB46uhrOIytP
         xpdb6aKpYdsOlTW+ovvMdTcVXJqwuvHkvAlefZzU61X6scJEi2RvE9d6TRekoxQjOagU
         bUAq3zPgSHTzp+kQ7DRXGo0Pj1VtRSEhAINXv5loNI+158PtoQbqmSF5sAsjCu24y0s8
         +Wm1VDAClPA9zapRe8+Lqi26mtQpbgAgPBtFjHrX87Rv/sjs0Q67l5hF4QVIkFrKHoYH
         Vmn+oazD4C0R5+je8s+9e/1Tvb+NZP+ml8F91TltZWsOFjdxoUQmyjnx4rp0v3GkApz7
         eHnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775828407; x=1776433207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=WXkk7MjGsWCUHEg1iU7liVQxxmn76Z2Blc65Af4B1zix0M2rF8QfzApVNMifY6ss0I
         o28bXJ2WoZKKs4P+RMYVL7Cyz5rTozkqN1LFEZKxQrY0UWy/+P4MTVZ7JlV/GmTfYw7g
         BHdpmSI3dFIhezek0dIMEojwsl7VI9CpBDtWrVKxWRCyxE8FKu9tCx05MK1Z19mpDbLY
         UAmVUcxpvcLdZE3bWKkeviuFv+z6weHemrn+Q1dbNj19BdhmlV3lYWFxMcZ5yjPYSXjG
         1ICMvCFl+bVV4g0F5SiLzhG+oRaoJBenKb2hyA5tkvyV436rK7zq2Le6HAfSbviCkDzM
         W8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775828407; x=1776433207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=CgcU7biIzDFBrzZY9F2WfvCgQSSfUDicU2iWHwGXo4lzTntZZcUdyx2i5jz1huHC1g
         krnLRXsIUaP2zcMbVQAkCuIOC2HIfLtdEYFgiPBAQGxg0+Tk/ARJ9YlM/Cwtsb3Vm644
         H7y1ug1XV9pD+LdqklsgThN/9OwbYWEO3ermjO8jsDWYHrSkXy3nodHZCb9/kG+2EgUZ
         fcRXfAe/6fyGRu+AIZplmFCbHQDY1q2GgaD0CGlKGw4zijkQmRE7XTo6Bh/NCOn39x3V
         ptnkoaIpRps6cet/W0XG+cSsHGxeeXytAxpb2eHnbnAl2qIFpOtDMRPGOJiUB1rlApkW
         qYHg==
X-Forwarded-Encrypted: i=1; AJvYcCUmQWa0Ls3Ng0z4E5XM7rWde0Duz58nFu/bgE/k0ec+SNPJ6Tr9X7YKMaY7+ygRo3h7PzKA07cny0hj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7jnicl3yBQo1KbhQn2tj/6KH824srnAWQVVxN1WpGg8cfuYgj
	QrLubGMbV3ccOOcrPQe6Aw2PF4E9fbNAxdjptqhbauSobj2udyyw5C01UYoF+XpPyX9RZcqqRDj
	4Yr+/CT1U3ELcSgZKvN/5fG9FLlehp83iHwkx+fJS
X-Gm-Gg: AeBDieuT/zooFuDTj4DLq7Wk8YjQAH4LJ1tvL3UlQsyse5tIwPUrPOOMvSoAIkFymXQ
	oC96BpEmXJxE8IJ5D87zUDdm1X8KWOwbXs0dVAWzyXM65a6kqu34RB73dkKWGACO23OF9Ag+1JB
	1+uDU+KBIW2Q7HdVbCvn1JofUY9wyf/OnIQJ5P717uf4bOMuVOWDgImLdb+Aqf8IzSBHPyTXvxG
	t22yKEs/0SHKkpY4Xqlko1Zq470/a65bEmxjmRaxNvEq9vhXYOD3ENu8X4m7ktv2bcSsR8yJz9v
	h+5fZU2bZgJw8pZ2CEmOh2u076ZVw5xbXuMyV7irTFNre4gZ
X-Received: by 2002:a05:7022:fa04:b0:12c:2ed4:62fa with SMTP id
 a92af1059eb24-12c34ef907emr1882312c88.32.1775828406651; Fri, 10 Apr 2026
 06:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.862164111@kernel.org>
In-Reply-To: <20260410120318.862164111@kernel.org>
From: Marco Elver <elver@google.com>
Date: Fri, 10 Apr 2026 15:39:30 +0200
X-Gm-Features: AQROBzBE-9UxDQG5mMJLgipEeL_Y5pwE-Y_PUrJGxDBLilqBu51b8lLzxdip708
Message-ID: <CANpmjNO1vsO1LT6xijhz3nsjQa+_A=9omfgOSz=aGn293-LqTg@mail.gmail.com>
Subject: Re: [patch 19/38] kcsan: Replace get_cycles() usage
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
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

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
>
> KCSAN uses get_cycles() for two purposes:
>
>   1) Seeding the random state with get_cycles() is a historical leftover.
>
>   2) The microbenchmark uses get_cycles(), which provides an unit less
>      counter value and is not guaranteed to be functional on all
>      systems/platforms.
>
> Use random_get_entropy() for seeding the random state and ktime_get() which
> is universaly functional and provides at least a comprehensible unit.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/kcsan/core.c    |    2 +-
>  kernel/kcsan/debugfs.c |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -798,7 +798,7 @@ void __init kcsan_init(void)
>         BUG_ON(!in_task());
>
>         for_each_possible_cpu(cpu)
> -               per_cpu(kcsan_rand_state, cpu) = (u32)get_cycles();
> +               per_cpu(kcsan_rand_state, cpu) = (u32)random_get_entropy();
>
>         /*
>          * We are in the init task, and no other tasks should be running;
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -58,7 +58,7 @@ static noinline void microbenchmark(unsi
>  {
>         const struct kcsan_ctx ctx_save = current->kcsan_ctx;
>         const bool was_enabled = READ_ONCE(kcsan_enabled);
> -       u64 cycles;
> +       ktime_t nsecs;
>
>         /* We may have been called from an atomic region; reset context. */
>         memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
> @@ -70,16 +70,16 @@ static noinline void microbenchmark(unsi
>
>         pr_info("%s begin | iters: %lu\n", __func__, iters);
>
> -       cycles = get_cycles();
> +       nsecs = ktime_get();
>         while (iters--) {
>                 unsigned long addr = iters & ((PAGE_SIZE << 8) - 1);
>                 int type = !(iters & 0x7f) ? KCSAN_ACCESS_ATOMIC :
>                                 (!(iters & 0xf) ? KCSAN_ACCESS_WRITE : 0);
>                 __kcsan_check_access((void *)addr, sizeof(long), type);
>         }
> -       cycles = get_cycles() - cycles;
> +       nsecs = ktime_get() - nsecs;
>
> -       pr_info("%s end   | cycles: %llu\n", __func__, cycles);
> +       pr_info("%s end   | nsecs: %llu\n", __func__, nsecs);
>
>         WRITE_ONCE(kcsan_enabled, was_enabled);
>         /* restore context */
>
