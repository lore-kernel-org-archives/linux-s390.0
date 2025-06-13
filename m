Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCBE1F37D4
	for <linux-s390@vger.kernel.org>; Fri, 13 Jun 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832582; cv=none; b=jR6ZQjYFfJ0odby9eH/wwRrjIBXUbGHn+DraSt10KV6jvZVw4m5ZKilODgJrR9E+G2+5tLQxZUUZYEXuMaNR9LQ+VBW+xftg0GCWH4Hg0XQuBdzCQXJMJQTGL9Z8nnd8eyrSqGY54J9imqTObp1ec/IjVCzFeuJgOE2Fpr1E8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832582; c=relaxed/simple;
	bh=6IDK3mFK3aUcD6DqmEoL/rBAW6jbXc5FxEXCTke0bD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRJZN4PHpFciT2WagpjjJ/8hs9wRInXU/SWCaYvZWTS334uqny3pIR/Q0Bvh9NjWiDc3Rhldk/cT8iMnNa2ZS+EQp+98+iNQdY71gq1htN7QVn+f2XZvR1OuzT0IAMT4LQOQXou/1UfM0DjPiGbDvx3TrYnZDZ2Hu6T9WwuL3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PI5Rveho; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PI5Rveho"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607873cc6c4so4726871a12.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Jun 2025 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1749832578; x=1750437378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=76g08zX1QgiOXgDWQ+4Q63FmolLqjqLzmJdnqen2jZI=;
        b=PI5RvehogUMvTtnZ9NT+nSQkeUjvDQn3WINLD3naZhlnHdHoiwzfw4PB8oyeNV7oDE
         VrHfQJGMeqLG/pNd3WOoWMrlR6AladBALeW/89jAhhvNPpu5dfKbt2xlyQEemCm0h6s4
         FDkroMjWJCWEClLaDHi+R/BMqAC4Nlc/tEs3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749832578; x=1750437378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76g08zX1QgiOXgDWQ+4Q63FmolLqjqLzmJdnqen2jZI=;
        b=hH2YkXABVUfXXP6/wpjn3/qCvPJLlxOwDob+gV0vAfkQ1S0ErD7X6rXaBd0i0aqkx9
         qqtG1XbOoNaRr2q7T262J1V1nxTgCHYe18SMYRtjcn8pFbR0SL/j+vtvYbiEHWXZgc4s
         gzZ4nnZn+j5Xt7u7YMEDVWeefcz9SeTgP0mHcfewRmYEhn1q/eCy3XXWMrksgk0ZMWVq
         1QdvWn4rTbNuTdFxoC76sHwrQG2Jt+nlRystiChLPdtRMLt4CueILEu0uCE+EzmtE0Ox
         VZOo/pKlWF21cawDjzCv7xDL9ZaDcb8fer/oWv9nhrTR0mfqJtbCtnbyiRBc+rGQPbWr
         sJJg==
X-Forwarded-Encrypted: i=1; AJvYcCU5WU6qVnmFr2v7Ry3YhUaIkHl71aeaiFmaekfRuotQI39/r7uuXo4LMEIHMIfQxQjT8qpUBT2NUEqV@vger.kernel.org
X-Gm-Message-State: AOJu0YyIVWodOwfxP0OTN7luJhsU48mo9xm9NDCDrUQLva5lqv2ApcPA
	ljAMHuHBAmgvnrFNh+1pLlXnUWYnAlRtZMBZgV0JuqEvY4GxGgRjeaPI+2JsZRM6pEkB0yA2VdT
	UALRjdDtNGQ==
X-Gm-Gg: ASbGncv32C8S0dYhrb/fybg6OkiS93JxW3RS7+d3NifSL1hCLF1G0eygFnsI0rTfIrS
	c/v4aRh4CI0yaW2PF/Dl6dE2i9iGNr8XLEPcTXGZ1lchszTuGjSO6QY2x16PjruVwgoll1fvhg/
	75PXxG8XX7NQSmVEf1vdLeBdCIf2yywvj8i2BMbBLYCwBADz88sNMEPdSokopB9DzU2x8MpHWLZ
	LT4WxVDbURFZBvpENE1VrowJJMurUqXqvrfcqjAOkMS59vWMc8mAIjS6LqzOB9TxweWVziNGzrT
	AaFPtJ1Pod+GKNSb5pD6I0y2x8CMSh11HEOhr0fktulPNrhkxdicJ021ZUjMkmXvTQfpocSrZEN
	BvSfoH9xUD1u1iUESv6VlU/0R4Bbs6w5garVS
X-Google-Smtp-Source: AGHT+IF2FBQMa9k3Pte/6yd5biYKqmt3/8SKhDzYjl5pT2tvfnskkxfuE9SBsx1+EdXH7q/FjuKIfw==
X-Received: by 2002:a05:6402:34ca:b0:608:199e:df25 with SMTP id 4fb4d7f45d1cf-608c6de00a7mr1425748a12.2.1749832578296;
        Fri, 13 Jun 2025 09:36:18 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48faf6asm1416342a12.31.2025.06.13.09.36.16
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 09:36:16 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607873cc6c4so4726790a12.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Jun 2025 09:36:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlFoup7rO4eQ9W2vCjT4gT2XYjz1UD/g909kwW5ua0/umahKP4qpLjoqp2/aNhHbjwGnpsBhl8UOfO@vger.kernel.org
X-Received: by 2002:a05:6402:35cd:b0:602:427c:452b with SMTP id
 4fb4d7f45d1cf-608ce49d897mr365341a12.3.1749832576184; Fri, 13 Jun 2025
 09:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611020923.1482701-8-ebiggers@kernel.org> <aEjo6YZn59m5FnZ_@gondor.apana.org.au>
 <20250611033957.GA1484147@sol> <aEj8J3ZIYEFp_XT4@gondor.apana.org.au>
 <20250611035842.GB1484147@sol> <20250613053624.GA163131@sol>
 <aEu5cyDOMcKteW_b@gondor.apana.org.au> <20250613055439.GB163131@sol>
 <CAMj1kXEDCRfCgvtuhRc+a=m1kVt-zkcCqi_=_WOFTmt4Hz2gGg@mail.gmail.com> <aEvjrhkLnB_GEKnV@gondor.apana.org.au>
In-Reply-To: <aEvjrhkLnB_GEKnV@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Jun 2025 09:35:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiewoOfhK=NVQT2uf+29Kngv9F9J6ObJRFUKi6n-=B06g@mail.gmail.com>
X-Gm-Features: AX0GCFu7lGsyyFJqLRh6z7a562txhJJOyTpVqIIzlie72BRGPF0wH2A3ccvLGV0
Message-ID: <CAHk-=wiewoOfhK=NVQT2uf+29Kngv9F9J6ObJRFUKi6n-=B06g@mail.gmail.com>
Subject: Re: [PATCH 07/16] crypto: sha512 - replace sha512_generic with
 wrapper around SHA-512 library
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, 
	Jason@zx2c4.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2025 at 01:39, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> First of all the export format is being made consistent so that
> any hardware hash can switch over to a software fallback after
> it has started, e.g., in the event of a memory allocation failure.

Can we please instead aim to *simplify* the crypto thing?

Just say that hw accelerators that have this kind of issue shouldn't
be used. At all. And certainly not be catered to by generic code.

The whole hw acceleration is very dubious to begin with unless it's
directly tied to the source (or destination) of the data in the first
place, so that there isn't extra data movement.

And if there are any software fallbacks, that "dubious to begin with"
pretty much becomes "entirely pointless".

If the point is that there are existing stupid hw drivers that already
do that fallback internally, then please just *keep* that kind of
idiocy and workarounds in the drivers.

It's actually *better* to have a broken garbage hardware driver - that
you can easily just disable on its own - than having a broken garbage
generic crypto layer that people just don't want to use at all because
it's such a ess.

This whole "make the mess that is the crypto layer EVEN MORE OF A
MESS" model of development is completely broken in my opinion.

There's a reason people prefer to have just the sw library without any
of the indirection or complexity of the crypto layer.

           Linus
