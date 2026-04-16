Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087353A6B75
	for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338858; cv=none; b=XeeAqPnrMk/1a5IxNavF5/qIimcUrpUmOm8Na1EHxqGbatKiTyOZOWp2w6kPS21L/FNfccROpIv5dHxyAZj84Es2myuCzXpwf6ojI121QeNYuzBMJml7kEAqBQUc9H1BRkCZVOgEQgFwtRY2S0WPunHeE4Y1apSEwpv1DQWh6cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338858; c=relaxed/simple;
	bh=FSgVIzpnraycKQsxAztrNgNSM9On/XU1ftEj+pCL/gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWow7EkB8CWlJ/mlws0tqXleh3aPT3XqzekESzFvdPHP4Pxe8MXx5ChPPH5R6yTZaytGZaESV6VGyQHXhqF9030zrZ+sgy95LJQsOM7wg0d2wXstlyxsmdMhU2hWbrl6SIR3vFarMqAcRBaodxy6hkrsJJ5TrNbDKjSJ7maCDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbdcb85067so6590230a34.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 04:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338855; x=1776943655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AptjVPQ97g683jPGYCmYUacoTRTAG/3/TQY5t1TSdkk=;
        b=akOOokqhZXQaErAfvgup08bYRFd6p3Ql4wn3Jgb7k71F3nT7jsAeSLHgDZqAAojECC
         HeLLGnZ32+NI1z9Op85VG/mCWYTg7N4bhu6UwlZD5rc+VHXU6ZWVMIznFD55pQ2zVRiY
         9gEbJsRvWpeNEZe1kaSf/UeNwzEXEddYl4IPGryAhTkfEIpXFDQXXI+z9JVcbfasrJPD
         T/NFYHgsIJjmABs56cunsDtixSML+ZPHAWGd7Ir2ngbYupW9vUYyLi/tdnVhQNJW/dxB
         FipvCYaswklxjxaV8J4O0H7DlStuqnlWD38VkWCKjZt/pig51nnx9grh+JzzeH3eUZ/+
         QOCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8tq4dJe8AuaxvG7yTbgAcOJs4h8oLMee8wlnOYPkJ2crLWPxLuWInx/B3FlCCjaynqJO90VHpymvP6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy5DfQOz2GEOp5FhyXwsaDkHgOtd9akdcH54XzG6PR0yEx402I
	wBAAUfaQok22ThF7EVc2oGnBNowkkUDZW9HPpHI0OMre62pe4ECaB2EHNfzHhkRz
X-Gm-Gg: AeBDiesa1bAVhAbg1MiMITjwtnx+a/rHrlL+3p9zBc6hcKxpMlVbQcoQFUnyPJmYK6T
	4zLGc/3KQafc041y58gOvEaxygWWIyrAb8X+fwUAzwwmd18slnrfDmE2BgEA/kHHtRc34Hminro
	XqylGwiR562PsUZjmhOr1SPqjEFKhj+e5AmISZb7/m+lVwG5d9HAbAJnuoqtX6FF2cRGK4eBHcK
	PHlN2AWlh19fbjsz07IP9qQnppvzQyiFc9bhnwlsode23azmJ5e1PWU1yEP0tW57X02CRx/k22M
	i2gnLG4pguZ40Y8SebqfFudXaZL/KDECRnTfcuvLYH5budQVKI8ClVfYRU/GhPjj6tM8Xe2p2/9
	8IwqDMl3J3bBe2hJm1dR+y5JiP3U98zFc1lJp9GfT6YjRvic+9hI5bMr2x7TKGs9kEeTO4BxS2u
	a4dTi/UieHyPBPWaxzarj/CYAAYKASnKxl5zwTCzOLKQO3VgZwJ4rowekyZ6LP4D7yukOS0rhKu
	ug=
X-Received: by 2002:a05:6820:1f07:b0:67e:160c:36ab with SMTP id 006d021491bc7-68be6624f57mr12655399eaf.26.1776338854818;
        Thu, 16 Apr 2026 04:27:34 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6932b3745afsm2322664eaf.4.2026.04.16.04.27.34
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:27:34 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-47952229034so2874391b6e.3
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2026 04:27:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9UhmnCOYJkQqJei0AUkZvY4ixbBYWyW9tKaiD4ki4j+T0EB3iJFl9R8ValKZVQKtAjl99Q3Uqlr7zq@vger.kernel.org
X-Received: by 2002:a05:6122:788:b0:56f:1ed6:1d29 with SMTP id
 71dfb90a1353d-56f3bca6059mr11244615e0c.9.1776338533353; Thu, 16 Apr 2026
 04:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120317.910770161@kernel.org>
In-Reply-To: <20260410120317.910770161@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
X-Gm-Features: AQROBzBwwjc8yd10cT00Tu5Dl2qrCYQStWr3Lcobhh8coMrpPeCH9vhBSNokYJk
Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
Subject: Re: [patch 05/38] treewide: Remove CLOCK_TICK_RATE
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
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
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:18, Thomas Gleixner <tglx@kernel.org> wrote:
> This has been scheduled for removal more than a decade ago and the comments
> related to it have been dutifully ignored. The last dependencies are gone.
>
> Remove it along with various now empty asm/timex.h files.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h       |   15 ---------------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
