Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3A21B1AA
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562897; cv=none; b=ernVsVZnipvfBWG1BBp7tGA7rH13hQVidm12QGkMbwnxEu140xha7GkjrgABFPPl8g7Glyxb33G9m0CtX4qYK2OrC7y1FXZdbyO/3X+ekYy2FQfcuAU4c6nUToPz9gGcgQkfVEelAlHPUXdPfz5fmXkz0hm+QoJYPVhO6FX0Dak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562897; c=relaxed/simple;
	bh=mQ2X3C83MrQ+ifFd0cXmKRdvIysb8KwRrZHJnS3dFHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klOxVdle7GIRLGXn24G2QWTtfB5YRKU88st5ErBhMeLYwlZq9pUOv6LQNDukT2yIlBhe8ZnP5LKFBbUmgy2xl0Oa1UrtD41mklwgnDEJg3kOdKWylndv0rHXrUVgK6D1Oee7UxyeYbIhVkElEh3FEhEM7Xei6BtU5yNoa5osORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XQs+StU8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XQs+StU8"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so236782866b.0
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 16:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748562892; x=1749167692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VCpgeKXbWpRtz3XeS2MBk7nO0oA3f7brSdzLdQTvzhc=;
        b=XQs+StU8IF5aBXMDzuyK2yS1d/Bk5+iNxCmULKpVIg1HW0cD7a0hgFJODEGSYiXueZ
         PPJh02pqRliwbkAT0TNEUGYmhfGFxPKPvdritgJoP0Wx/dYK0UfNeW+Jwq2cxbdvplPH
         2CAc8FG4lQHQWHxj70do4tMGYmODmabgmKXkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562892; x=1749167692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCpgeKXbWpRtz3XeS2MBk7nO0oA3f7brSdzLdQTvzhc=;
        b=q1hCIyXwoV7aJKhbZwzMrmRjT70f1sB3E0cpKqtv+ZRDFkT6QdqcxZSgYCBkuj05Y6
         odxZXoUjz/jLKkJGEXbcCfPY+N2nUawqP2JygrspMNEPKa83qOugcfuKetYXBEgpqlaj
         0AK1x2JGnbCbn5TiVN//+IDL6D0p9OWBed7ycAgWK7D7BSzJ+thZph6oLIq3av1A6MuI
         URTrQB7RN96MWRfjVRoD7/Yoj9exsZwm6T/aS33iems539KQgU8FqxLx8PWzAFFquOyc
         jjIkLtc4o0uAEF+nWeO9maOtOl1Cwc1NUye/q08/DXRY+M7eCqEycCHvPZ1LoOugOxvA
         m1IA==
X-Forwarded-Encrypted: i=1; AJvYcCVm9RA3W56dQcU+zpy8g0zP68bTy0DReyyK8RhVw7ruv6iVl+Uo5AqGrZ71di/Y27/t6kmQY1fazZ01@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPzV+9x3GmiY9kYdQmMQfEXxUQIFbr5l4jb3gG/JxwZZCRUdJ
	k/M9EuSeJgb6VZhAYWsDR0GByO8YCQhwN239bf0OXxHWCAVDMj7jp2rVbp1OwDw96CMrrg4qwUw
	uQE11l7o=
X-Gm-Gg: ASbGnctVf97NqQ7ak0Sj1c7Z6YgUspcsdwPeZzuLPUmlEVBtwZLxpZguBaJhRzs4FbZ
	F2NQcvQXxqwGgwLWsKH3QMBVJEdpcGsvVg2+SqkiqwwzJ3GvD7XH4oBOJm9I+Okq/0Rse96iuFe
	8B9IJvKP/LTsdKZl/GryLV6AxM+OJrgZtCjEbfDO4T7PDes7KcD68XY9t7bvXhM+VcbWzUYNzjE
	9+ntsU5izt6w0kkGVLigMBMc5dpMHZ/IovhvM5wB6Vk89glwFltwfUQWqlB71IgCr+9rWLkxlXk
	WtQru5d2owmu7sJxeFndp4yKPIdBmavpNWo25u5fU5kZvJ+cPhwb8E6Vr/y0+0NtVITU/T9S1qf
	ScKujM2XvwWBhiyXrxg7aZr14yRV9G82qj5SK
X-Google-Smtp-Source: AGHT+IFO2CObr47QTUXZgLm9Y/itG3W0Lx63pRZnh0u3H0WHIMDGl8rjgFJkwpp4YtFsLGcpJyYIWw==
X-Received: by 2002:a17:907:9693:b0:ad9:85d3:e141 with SMTP id a640c23a62f3a-adb324321damr113027266b.53.1748562892590;
        Thu, 29 May 2025 16:54:52 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb32e347fasm53509966b.168.2025.05.29.16.54.51
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 16:54:51 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6049431b409so2425100a12.3
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 16:54:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/6gd+ighJwg6b1pMtOYs+3YspOaQVyEzioo6h33aPunRqL5kmcZusNM92crL5EhZTiST5b96pJHRw@vger.kernel.org
X-Received: by 2002:a05:6402:35c6:b0:5f8:357e:bb1 with SMTP id
 4fb4d7f45d1cf-6056e1597eamr926476a12.22.1748562890813; Thu, 29 May 2025
 16:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428170040.423825-1-ebiggers@kernel.org> <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com> <20250529173702.GA3840196@google.com>
 <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com> <20250529211639.GD23614@sol>
In-Reply-To: <20250529211639.GD23614@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 May 2025 16:54:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>
X-Gm-Features: AX0GCFuuQZJkBnHy-mtAufGSUKbxBrKrMtOhVAT8ZxGCHwWeq3lbFPW0g13cPtE
Message-ID: <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library instead
 of shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 May 2025 at 14:16, Eric Biggers <ebiggers@kernel.org> wrote:
>
> So using crc32c() + ext4 + x86 as an example (but SHA-256 would be very
> similar), the current behavior is that ext4.ko depends on the crc32c_arch()
> symbol.

Yes, I think that's a good example.

I think it's an example of something that "works", but it certainly is
a bit hacky.

Wouldn't it be nicer if just plain "crc32c()" did the right thing,
instead of users having to do strange hacks just to get the optimized
version that they are looking for?

> Does any of the infrastructure to handle "this symbol is in multiple modules and
> they must be loaded in this particular order" actually exist, though?

Hmm. I was sure we already did that for other things, but looking
around, I'm not finding any cases.

Or rather, I _am_ finding cases where we export the same symbol from
different code, but all the ones I found were being careful to not be
active at the same time.

I really thought we had cases where depending on which module you
loaded you got different implementations, but it looks like it either
was some historical thing that no longer exists - or that I need to go
take my meds.

> IMO this sounds questionable compared to just using static keys and/or branches,
> which we'd need anyway to support the non-modular case.

I really wish the non-modular case used static calls, not static keys
like it does now.

In fact, that should work even for modular users.

Of course, not all architectures actually do the optimized thing, and
the generic fallback uses indirect calls through a function pointer,
but hey, if an architecture didn't bother with the rewriting code that
is fixable - if the architecture maintainer cares.

(On some architectures, indirect calls are not noticeably slower than
direct calls - because you have to load the address from some global
pointer area anyway - so not having the rewriting can be a "we don't
need it" thing)

               Linus
