Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3F38E11E
	for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335387; cv=none; b=BwiGRmtSHK3RUzxuZk8He0uOeVK6TfAi14Me8tVFoUm7vCVgIY9aJFj5TecuqVGdbs9RwAKXFbrKO0jzWOtfQsmYudc2N2Onl4t3sCOhj6kNTIGEkxHys+fFRTQtZpTIlrlPyjZ58wsiRlL3pEEGOT/UWbsFuD1vocOHQoxEjDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335387; c=relaxed/simple;
	bh=Il5EilNKbQmVM1qv4XgxLAe02Z9+zxydkwUqJc2BPRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXED1yRPyvhTcUQrnZVle1N2B7uRYIqyvx30FcuRnR5Qp94ii1kdWl3c5cTmUiFF4VmJRdPHsC8rKcZ6d0YMj9KlatOsXtZxJZKuIjuqJcEQP8iZM86bKpyZQ7PoWi0K/+gx94+ba5zthtDt0Ha6K9gkYH+AvOW8yaEXA3o+45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-471618e20a5so4028009b6e.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 03:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335381; x=1776940181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9HEDsaws+1AaPEcUyrGjtCss1Kv3jZQFAB8Oib7mmY=;
        b=V59BQ3ynIwHWIZflJODDcz8XJoBOonuOugkMYrqZ3tYwdk9EuSzunT8KGMc3/QsMzq
         lqeHPikFNLTkJ7lMu2Xsdn1VZKXcPXHj3QMiHI98GqCMou88flQcAfX8ExxbRNlLpL9N
         rHAWswKazRxxadChn9igktfqMq0TTY7aI+dnpfbSycDL46Xn6cmCi1x651q+maLWbS5D
         x8EJzdphloOMUI/SgCp9HWMqeYLCG5k4i7KRKqZINBzRXX3QW+gCpISdh36kXLSyaLX9
         cBBoXJQEOFdmld/uQlg4Fbl14XgN0s/3yVVx3T/QYhjupJh5juwpOqmDlqJnFXlc1Cr5
         Z2kw==
X-Forwarded-Encrypted: i=1; AFNElJ/m5UWIzPeML2mcpFV0qFOsZyiJCTTVAJcS+4e1JdO4d4oHU/RaQBdA0V+h+gtfnK+Eoj1ITe1W8C4K@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57Qxns3Aasxno+7xhR5O3ZQCZ5tPTbQkaUUHlAaUrCy87OoDy
	Xaa4WCOGU4SMieIq6LgPQacESJS8m3kLoveyIJfDlPyINrTiIlQKK/H/NkNT0hmf
X-Gm-Gg: AeBDietEUlzi00Ay4cjqJK6GDUwYv3/SLmpi85hRuZ+ihPKO99akga2h6f5tUM5iUql
	/A8amSVrMQ7ST0ZRLHC5QKZJdv8BLvLPj8li+RKhkkkLX1i1rMBNJtgYzeSyEgEyC5Jf7479/06
	n/lvsnz5lUxducZVgRhY+X5cPUXgGAENM0RDwE9akFDIMdg5RsJ9KCmbkNIZl2EtOWfVMQ5XRku
	4nRTxMLmOFg8fu6ZqhsTfNDJP442fmuIirOsEDiVnsLPKKUYLAQFm2EJzEmqkFJcq+3fu8I1w5V
	LQkp2Ni/3knDLMJj2vFZvxPY0Br2SCnMlSIU6rWtrqS5OYzBVHU27/5RtNNBkHLmwLjssqiAnAT
	u3QEBoypUHgc7WTPnlYfrhbcjhZZjgxMMKXbdyXzZNDb6f2IRQ5zRJAn9l8EkUxlhIBgTYOMp/Y
	IaWXuaDQQ+T+0mbyyuhCjYermVdIfWwcWiN0YDvGWOi3whR3x+J9qX1fwtdtNYj0sl5OT+KBw=
X-Received: by 2002:a54:4388:0:b0:467:1880:fff5 with SMTP id 5614622812f47-4789e91dc09mr10134564b6e.31.1776335380983;
        Thu, 16 Apr 2026 03:29:40 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42666b86f17sm3422901fac.4.2026.04.16.03.29.40
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 03:29:40 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbdcb85067so6553796a34.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 03:29:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ94it/SCp2Te7ACXU1SF56R/uzDbF3HLtQw3Yh5+6RorePChUz6oVVv2z/flAN34SuyDEPaXrcL5U7J@vger.kernel.org
X-Received: by 2002:a05:6102:c48:b0:608:cd24:354c with SMTP id
 ada2fe7eead31-609fe9b0d22mr11966750137.3.1776335071251; Thu, 16 Apr 2026
 03:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.794680738@kernel.org>
In-Reply-To: <20260410120318.794680738@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 12:24:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
X-Gm-Features: AQROBzDRGGELVSySTko37h6zEj8YoV3p6pwZDCVQUlUW6sZbw_W5mbJzFIh35nQ
Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
Subject: Re: [patch 18/38] lib/tests: Replace get_cycles() with ktime_get()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> get_cycles() is the historical access to a fine grained time source, but it
> is a suboptimal choice for two reasons:
>
>    - get_cycles() is not guaranteed to be supported and functional on all
>      systems/platforms. If not supported or not functional it returns 0,
>      which makes benchmarking moot.
>
>    - get_cycles() returns the raw counter value of whatever the
>      architecture platform provides. The original x86 Time Stamp Counter
>      (TSC) was despite its name tied to the actual CPU core frequency.
>      That's not longer the case. So the counter value is only meaningful
>      when the CPU operates at the same frequency as the TSC or the value is
>      adjusted to the actual CPU frequency. Other architectures and
>      platforms provide similar disjunct counters via get_cycles(), so the
>      result is operations per BOGO-cycles, which is not really meaningful.
>
> Use ktime_get() instead which provides nanosecond timestamps with the
> granularity of the underlying hardware counter, which is not different to
> the variety of get_cycles() implementations.
>
> This provides at least understandable metrics, i.e. operations/nanoseconds,
> and is available on all platforms. As with get_cycles() the result might
> have to be put into relation with the CPU operating frequency, but that's
> not any different.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Thanks for your patch!

> --- a/lib/interval_tree_test.c
> +++ b/lib/interval_tree_test.c
> @@ -65,13 +65,13 @@ static void init(void)
>  static int basic_check(void)
>  {
>         int i, j;
> -       cycles_t time1, time2, time;
> +       ktime_t time1, time2, time;
>
>         printk(KERN_ALERT "interval tree insert/remove");
>
>         init();
>
> -       time1 = get_cycles();
> +       time1 = ktime_get();
>
>         for (i = 0; i < perf_loops; i++) {
>                 for (j = 0; j < nnodes; j++)
> @@ -80,11 +80,11 @@ static int basic_check(void)
>                         interval_tree_remove(nodes + j, &root);
>         }
>
> -       time2 = get_cycles();
> +       time2 = ktime_get();
>         time = time2 - time1;
>
>         time = div_u64(time, perf_loops);
> -       printk(" -> %llu cycles\n", (unsigned long long)time);
> +       printk(" -> %llu nsecs\n", (unsigned long long)time);

While cycles_t was unsigned long or long long, ktime_t is always s64,
so "%lld", and the cast can be dropped (everywhere).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
