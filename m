Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F127BF7E
	for <linux-s390@vger.kernel.org>; Sun, 15 Jun 2025 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750016272; cv=none; b=rkq1Nq8yNtmYzQ0Ja8K2EJ4JHiIeuPnuwXfJScaIyfP2PQXqjwuYLYvFyMJOqD/8Mmh/Kk6LxegR/2Qy0FTME6noEP3QShZHj2Ifo27psB2iQ4ELix/yrZcTmjFL0VzGsqVpSg/diZWqFiJi07+eTqaVdMuqGr2CW+uy6db9CsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750016272; c=relaxed/simple;
	bh=+DdLJhNZpkF0mq6V6riPNHi40jkfNk/Fbp6sB9glqNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L71IYCoq0SKhqqmflUv1ues12EfuGNvy9/nv0eKSfLOUMGeLLvA2bzaj5PfmnhtWauKXSaTqZ2xwaDzVSoY9KbxP0dkc6XEQwTnNuazYrXjmSZG7y2xuASkdyPCfQUKzmetCPoElhtCNCl3RKJ41N7YH5aFW8xR/XqQaQpM+NGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c8k8Up/t; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c8k8Up/t"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade48b24c97so593779366b.2
        for <linux-s390@vger.kernel.org>; Sun, 15 Jun 2025 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750016269; x=1750621069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Bm1Ypz9xIQ9oSWoxmBY5SZFvMd6ktsJLpK/MNzMMqc=;
        b=c8k8Up/tiz4aXR6K1YEqgwC9qLgz5A6bed0NQQE42yDNEHhDQ9PvbziX4DzA2hFR/j
         XlADT6OlvnsnFTBBKrLfsC7JZ3rMHFOs/IqrSv9hFKAKbvOG8T2AxS3F7onFrPMqYufW
         rkvlGPdOflISO6xrtCgfiKQ2np68g06VukUIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750016269; x=1750621069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Bm1Ypz9xIQ9oSWoxmBY5SZFvMd6ktsJLpK/MNzMMqc=;
        b=XoDeiXA4t2ihi6KxzYGBKA89DJA7Pk+i0FknDkcBFf8dP1bKtAAK31HYgsp9O2HHC3
         HZ/NHvOntruG9GJeZ/ibQ+0+Y2Amgh4aJaFozHD0oDB5TI+cDhvUvOMl/E5nG6rwmz1F
         vGmZ3Pee7AFrp6zQ0ZiidWE6zleAYZ3QPbfA+KljqLXLwGQ1STpH3fGIIm8XWK8W91Gw
         +KTLPgt6QZtFaqYbAaIJOtGzG0UyLfRElQH7K9vlCzTLGxYbzNE/2bIcvCSgZQdtqqLy
         7qoSO1XrM9fWggMS/KHWsKq/MmYkftZbZkaJ4jOo63zNgRIOfQ85gsE8RbEHvPaJTFdK
         MAtA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0DWDmVqvkOzdTLyk0Ub5kMGUbh+oKAdXVWjRIEOwTOnqeMkkauHrGYL2JuS83AaVkLAjuxz4vsUx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/GMahRcw1NxlcE3QXqpYoDjluTNBz+FHDP+Md/YEO4bv8MW8k
	r4MmOzDn521fYcrHUg1Wf7yBjiy9BGT+5fAUlw64iLxMyDZ8xI1FoUkCCKER+UCp15PqSed9p9j
	zSyoO95s=
X-Gm-Gg: ASbGncthjuppFUoMhYmL8IYdOjJnedYEDsQSZkfvPrGllf0EFFzXCNcakLn1qvCI0zv
	sIy/C6dIrlFPSOr3uSE5uK+NrZjXwejuC9EpeShU7DKd5twOCFRfqsO16IgxeSU1+i3zhWK+TY2
	HK+4At0lIoPy/1MsnuayY/IJBPRJKaBu2UNuqnvoazQJymPud2zvGxLBzn1lyo87lum8cR8+bD/
	WH4R+YuCxmjVCz8HThKLQRHAPUMrq0JaSM/44ao5xN4VG1MjZVG1GdJzQhxm1aJLa7A15k1MtCo
	5d+cW/RvSS4I7tweRrw8tDNnyLe2kWE/vz/eZ9/g2CT51Tg1aPcHzHxN0i3xmNYcUkX1/Kmqg9n
	hGGzsrBBJ22nutnWzHOut8xh9BA0hQRXdoRJJqV9aOKQVshk=
X-Google-Smtp-Source: AGHT+IELjaeCh4zk0YG4w7ZyRDQCu+pUe0qCsVushrEJZY2dpqlg11AR0rXf2LooCHlPaVxFCzhiLQ==
X-Received: by 2002:a17:907:3c94:b0:ad8:8efe:31fd with SMTP id a640c23a62f3a-adfad4bfc4bmr620832766b.52.1750016268921;
        Sun, 15 Jun 2025 12:37:48 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608f8e20459sm2495510a12.37.2025.06.15.12.37.46
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jun 2025 12:37:48 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-606ddbda275so7500992a12.1
        for <linux-s390@vger.kernel.org>; Sun, 15 Jun 2025 12:37:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzjt9rpKyVmpqhjCbBR9ZBOhZZxUWYICBJ6tyzWVpvRSR7GpG2dGKKaPMMqqkHWin2z9m6CajVr2T8@vger.kernel.org
X-Received: by 2002:a05:6402:50cc:b0:5f3:26bb:8858 with SMTP id
 4fb4d7f45d1cf-608d09a2d16mr6285703a12.34.1750016266135; Sun, 15 Jun 2025
 12:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEjo6YZn59m5FnZ_@gondor.apana.org.au> <20250611033957.GA1484147@sol>
 <aEj8J3ZIYEFp_XT4@gondor.apana.org.au> <20250611035842.GB1484147@sol>
 <20250613053624.GA163131@sol> <aEu5cyDOMcKteW_b@gondor.apana.org.au>
 <20250613055439.GB163131@sol> <aEvmmr0huGGd2Psv@gondor.apana.org.au>
 <20250615031807.GA81869@sol> <CAMj1kXGd93Kg0Vs8ExLhK=fxhRBASU9sOPfgYUogv+rwVqgUsg@mail.gmail.com>
 <20250615184638.GA1480@sol>
In-Reply-To: <20250615184638.GA1480@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Jun 2025 12:37:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAh0fnfm-LomMWDV=OGhCHCp0C_7xZASE_8pZ3ZP0CXg@mail.gmail.com>
X-Gm-Features: AX0GCFsirgA8Ga0u26X0ToUgNd-a86j5gL8Na8fIUJo1Hy2_joO0gogaJwm_iSM
Message-ID: <CAHk-=wiAh0fnfm-LomMWDV=OGhCHCp0C_7xZASE_8pZ3ZP0CXg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ahash - Stop legacy tfms from using the set_virt
 fallback path
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, Jason@zx2c4.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Jun 2025 at 11:47, Eric Biggers <ebiggers@kernel.org> wrote:
>
> So yes, QCE seems to have only one queue, and even that one queue is *much*
> slower than just using the CPU.  It's even slower than the generic C code.

Honestly, I have *NEVER* seen an external crypto accelerator that is
worth using unless it's integrated with the target IO.

Now, it's not my area of expertise either, so there may well be some
random case that I haven't heard about, but the only sensible use-case
I'm aware of is when the network card just does all the offloading and
just does the whole SSL thing (or IPsec or whatever, but if you care
about performance you'd be better off using wireguard and doing it all
on the CPU anyway)

And even then, people tend to not be happy with the results, because
the hardware is too inflexible or too rare.

(Replace "network card" with "disk controller" if that's your thing -
the basic idea is the same: it's worthwhile if it's done natively by
the IO target, not done by some third party accelerator - and while
I'm convinced encryption on the disk controller makes sense, I'm not
sure I'd actually *trust* it from a real cryptographic standpoint if
you really care about it, because some of those are most definitely
black boxes with the trust model seemingly being based on the "Trust
me, Bro" approach to security).

The other case is the "key is physically separate and isn't even under
kernel control at all", but then it's never about performance in the
first place (ie security keys etc).

Even if the hardware crypto engine is fast - and as you see, no they
aren't - any possible performance is absolutely killed by lack of
caches and the IO overhead.

This seems to also be pretty much true of async SMP crypto on the CPU
as well.  You can get better benchmarks by offloading the crypto to
other CPU's, but I'm not convinced it's actually a good trade-off in
reality. The cost of scheduling and just all the overhead of
synchronization is very very real, and the benchmarks where it looks
good tend to be the "we do nothing else, and we don't actually touch
the data anyway, it's just purely about pointless benchmarking".

Just the set-up costs for doing things asynchronously can be higher
than the cost of just doing the operation itself.

             Linus
