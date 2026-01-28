Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F437106B
	for <linux-s390@vger.kernel.org>; Wed, 28 Jan 2026 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769625180; cv=none; b=tdCtUUDKoOZgzRVHxtUbEw3SSe6VXTq96Es2+BIJVBJTV07pCROkgsiibtgrZdtoahnVbdgVjJW267dvxuHD8P+phya9ZxoBLr9KeiIbPZW51fSqkFzOArvrVvU9FRgQNhAERJx0Dmrd8/x//mksSPr0/Nb0doS51jBJjQUaUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769625180; c=relaxed/simple;
	bh=OBdwcZUm6PgM3WhIEW36ryu3bfpAIHNKO61eL0eZiMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2T3KAnguUQl9PRfACba1HH6kKvxqKbsFbA+eJXiyZ1PJwBnH9Ng8kAUeyWQPJGOL3ox0zWZQWptbkvAxkZ+WfpmToU+Yp63W2mMq0PmTeJk0QDgonYjc+AsO07NXxeqoyrRx1IrfVZEl/Ce2/qvlOjGo5uKL93XlyQTsgfR71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdFmsbnx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdFmsbnx"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-432da746749so145597f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 28 Jan 2026 10:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769625174; x=1770229974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfg6UdscjkpEoTOhSlRT2LAj46aYr5XBfZJkEddMCkI=;
        b=BdFmsbnxp8k31MlUlHep/s4Q0Dg3v5+tAMK33xoJ3jXeqMes8g07JjqsqflIEEhqnO
         sG1937uKP2JY8EUJPxIA6IQfHaLhjTtCJyaxwMQZAmC6EloPPEI660WDXqdSPhZKZ590
         0jbATOwvxyKb32EhkWI9EMXeX2Qs3RUwwFa0iiAqCx6Bc0vzVcUNkMrjQ/AgWNkcmc1n
         o22rWj5tKI/50uBN9Vjj5v6lgsS4gtAfT4NE6IehsVva4vY1AlWbDKWcrKtrUzmPqsHe
         C491oGNXnow2Up8aRmzQ1D1SnJtNmf7GIrRYdXTQYCNi573RM0xCnlhL5wB7MrWzWZua
         uPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769625174; x=1770229974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kfg6UdscjkpEoTOhSlRT2LAj46aYr5XBfZJkEddMCkI=;
        b=NEv8P458Jg4EAPHrd1GHAyLOyPiVSR1fq+hG5e68rINZOEWUnkUbL/0AQOdWVXGWVu
         iaGE285fx/nAOyDRc/wHbmzAJfrptJerAVxjLTUsJ1Gp3K30sK9HvUH6fTc/FquNAepn
         2RjVvhT+FTOKfZq9cYd32pUYcYPCduQFzX/rDKUik4JB15JZc7S3dgH1tSIa1zpOGZRF
         Id7gJOEL9g9y6siSkA/o7fGBE1qr2LkrsG5SuD70PX4qFhqlz1PMPnGjXvqr0UInWukn
         ZKKJtL5KDiwYDnf8u9bexR4TadnC9/QEoH/qRhk1NCouKNp2ut0MT8GFJwMnPxPVly50
         OO7g==
X-Forwarded-Encrypted: i=1; AJvYcCW3AzisAjpAYMtRXic8UEyIbGrVOs60tA92vbx0cn+xpRmjwN3IWkxMJwSorP+DJa8VkpW4SVHEfQ2B@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqVpydm/2ObEpOONjiWx3yFbTJ5DPvQOnSyqRpruxzPyIei4D
	q3UKuNvdMslpQzfNZW6Vq6/O+g5zUgQa0NcSnvIGjuGZ4aLUZNZz+wgI
X-Gm-Gg: AZuq6aJ0bYbWfnHVkM6j5t7z8pc/aT04p/BVrvF73bytXSYJ19JZAz/hYRwYpKCDIR6
	RHcUxOxH1FjGLOSjQQtm6mJ0XweWz8IBJDz8wgKvtNScA29KaO2ndvtCF6yexgWRiydRFjmMu8A
	rj4jz+QB/Qs91oLxDXixTCCCHdjKg2Z78YX32GHI1bFE0t3CgYtuP9LeadeoORk53zg8Lfa0mRG
	GZ2kGTmR+zu+ynMSqoLUSX03+Qm0JDn9xYGc/yP0VXvk/R757ucSMxg6EmDM2S+SmTUr0EOcGUD
	r6rT/Vaq6nvh9tTqiX3VFc91bCvw3ap5S+Qf+QvLbd4/BYv3LLudYF44xg9uFDTDYGbk3JJnbh8
	C0jL3iUsGkSeSHkIOJhN/nqh/qPSnPZzyEPeXqOUmEZcRMX7WTP6uN3HNb1CkdgruPjRJPKZJqU
	oS/jXw8Mp4oxOUn+MIRn74GOkrn0XH20z3bCDyCmJOyk53eMb7xXLP
X-Received: by 2002:a05:6000:3113:b0:435:9241:37c2 with SMTP id ffacd0b85a97d-435dd01e23fmr8152542f8f.9.1769625174058;
        Wed, 28 Jan 2026 10:32:54 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce64sm9165906f8f.26.2026.01.28.10.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:32:53 -0800 (PST)
Date: Wed, 28 Jan 2026 18:32:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland
 <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton
 <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 2/3] prandom: Add __always_inline version of
 prandom_u32_state()
Message-ID: <20260128183251.7177c345@pumpkin>
In-Reply-To: <670c2b78-02e2-4617-80d9-3c896077f02a@arm.com>
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
	<20260119130122.1283821-3-ryan.roberts@arm.com>
	<aXpArjZ1QQowshnA@zx2c4.com>
	<670c2b78-02e2-4617-80d9-3c896077f02a@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 17:33:19 +0000
Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 28/01/2026 17:00, Jason A. Donenfeld wrote:
> > On Mon, Jan 19, 2026 at 01:01:09PM +0000, Ryan Roberts wrote:  
> >> We will shortly use prandom_u32_state() to implement kstack offset
> >> randomization and some arches need to call it from non-instrumentable
> >> context. So let's implement prandom_u32_state() as an out-of-line
> >> wrapper around a new __always_inline prandom_u32_state_inline(). kstack
> >> offset randomization will use this new version.
> >>
> >> Acked-by: Mark Rutland <mark.rutland@arm.com>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  include/linux/prandom.h | 20 ++++++++++++++++++++
> >>  lib/random32.c          |  8 +-------
> >>  2 files changed, 21 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/linux/prandom.h b/include/linux/prandom.h
> >> index ff7dcc3fa105..801188680a29 100644
> >> --- a/include/linux/prandom.h
> >> +++ b/include/linux/prandom.h
> >> @@ -17,6 +17,26 @@ struct rnd_state {
> >>  	__u32 s1, s2, s3, s4;
> >>  };
> >>  
> >> +/**
> >> + * prandom_u32_state_inline - seeded pseudo-random number generator.
> >> + * @state: pointer to state structure holding seeded state.
> >> + *
> >> + * This is used for pseudo-randomness with no outside seeding.
> >> + * For more random results, use get_random_u32().
> >> + * For use only where the out-of-line version, prandom_u32_state(), cannot be
> >> + * used (e.g. noinstr code).

If you are going to respin:
		(e.g. noinst or performance critical code).

	David

> >> + */
> >> +static __always_inline u32 prandom_u32_state_inline(struct rnd_state *state)  
> > 
> > This is pretty bikesheddy and I'm not really entirely convinced that my
> > intuition is correct here, but I thought I should at least ask. Do you
> > think this would be better called __prandom_u32_state(), where the "__"
> > is kind of a, "don't use this directly unless you know what you're doing
> > because it's sort of internal"? It seems like either we make this inline
> > for everybody, or if there's a good reason for having most users use the
> > non-inline version, then we should be careful that new users don't use
> > the inline version. I was thinking the __ would help with that.  
> 
> I'm certainly happy to do that, if that's your preference. I have to respin this
> anyway, given the noinstr issue.
> 
> > 
> > Jason  
> 

