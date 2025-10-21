Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15C3451C7
	for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062226; cv=none; b=mhJolVu1gy0oPSssFngCas3cqo5JSftNf/J8n6oOelJZCt6BZVMMYbHXyNYO5LSbVZSWby22EmKLVSp/VVKOZE6uJmoFMKGgj+AwWBJZcCFP3lyQjFgM/FHZ1MpQTq3dMUcLuk+cJaKAUthLKyjb4t8Pz7SzkmIE+DoNX2T+L0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062226; c=relaxed/simple;
	bh=lViBcaKLu+UAiDt1Nf19hKosCzWDWEUaKqiaIlkaqqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBZ5JFkuHtv4jT/LBxHD3ZkC7x9aozSETirVC7ruziyIrHI62ZzliAKAqTbsujmTP61bHjPRY8wp4qBQAJYfUf0oL2gNDVJbTn6gZBh0eqRi5CYHOzxr4wWHpGGIhpfT9MyPpi6DKN5jYCFWT66m3+BI7q9OIp5nzJeUIwt2l+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LXRsRX97; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LXRsRX97"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so720426666b.2
        for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761062222; x=1761667022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0cSMAwFRMJRxsYANvmyJeRZmZI2zdPSEESzl/tT500=;
        b=LXRsRX97xBSxqwW5CSr8Ry7ePUTyQExc9uE2tAbTLUP1xL3AksnAHszrEEehbuYJV9
         qDYLnCkfvNKaqyDjY2jDrtpgVmWWiVZN9onsUrJZQiwzswkRYbxC8XFNKLS8Olm33MSK
         U12nM8FAspj3Zw2Tff7Me0zxj/1ribQ/191MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062222; x=1761667022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0cSMAwFRMJRxsYANvmyJeRZmZI2zdPSEESzl/tT500=;
        b=UoIQV2SGhDPCMKb3WLav4aTii4G9GbDaFIhNqsxSw5CcFC373ELjbkwj2BxrArMjQ/
         CkH+iALOQ030Aet55w0eYp1fiDuZso9zxi/62MOKIh+0YkRAmcEtMvKh/lptZzDR1xRY
         VPMSvXg32PHeaVXqxL8I9s0LpI3GFUXol69HsMPKK+FwO8iaGrvlJQzDEIk/9yEiHk6A
         K67G25BKKL5Z5hCCvgy8AkHMppn6h4+01JiJfZm9I/4P4cxG2W2rnwbcYGluwW3RrFoz
         gtZYDhZw9nPS+H0ke4ZxlZv5hmRBTYIG7Z8jdXT8oPC1EO/GhAh6vcA3d0MWJw0n4hsB
         AjWg==
X-Forwarded-Encrypted: i=1; AJvYcCW4jJkmeQKhIlrpedWHw4p/UDl+cEtCiXlrXHyxtxrAvKRnRJpDBHZnBH3uVvU+g1u+noTe/1+gNCCC@vger.kernel.org
X-Gm-Message-State: AOJu0YzeEGCx3bCIjcVyU4wT5Tt02WjhgKVfS3OoBmpdR/Lgqzwzq4SD
	wc+CM1VK+uHxGGShyVYkLl8eYIVmX/hRF3nTLs9TQHRgzPDAhYy74DW+YxB7dux2QCu5yhOie0x
	/UhiodapOdA==
X-Gm-Gg: ASbGncvzgYnwY532HnJOf8SqX+hF1zN8rZj4DZUvLrz3iUm56CreCq+64jKTc+WLK8F
	CslQrf7lxg/YeKoCvvxeIBkZGU0mPAyFcovCH6IJjqRhOuSpvSwoPBqUU64vVN/viEefu0tHUHo
	waJDBcxf1MQYB/hTM+rAZy1Q2cXIlNQz6v2doo6LH1v5N/nG8tyTVQaKns0HvQQ9L0JHBXzB6zA
	Q/aLPAH9d+2wW5Y/h+fMJh3OjdacKS3d20/zWc/iE5u/l/TlYIJWnFZHExj6Ys/b7RNBj5QRa+k
	YX67GjuE7VA6+SSSWCZA1UKkmlgX0TxjcNsSHjdfQFS4VxicLIEzV91ilhGzSpYLjB+5LS0Epug
	K3mFJ81C9RBlpZ1qfJMf9P7aKMvyowfXTyefvGqYO0qus9MVkuFefVxQV0YDeJ+Xp+WtRZJknSw
	bsllI3jyGfKA08a2L5pVDFSkfyhQRfvo0AXQy0BQQJlK8l4ujanCWuzjZQhrMW0hG5e4NdfuI=
X-Google-Smtp-Source: AGHT+IGNjPovttTp6uNv4EyFR1pG8INmBRUC1RmN2sELfq+KrrQkQ+xme92TG+fTYAv2Osz65Lum2w==
X-Received: by 2002:a17:907:7f0b:b0:b5b:360c:e8d5 with SMTP id a640c23a62f3a-b64764e2ffamr1746620466b.47.1761062221757;
        Tue, 21 Oct 2025 08:57:01 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e896f904sm1128923366b.35.2025.10.21.08.57.01
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:57:01 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so6830453a12.2
        for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 08:57:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkiEyxBrH9qwYUwAaU9Imh1RfhQDfI+U9vH3oB6hIGjgSmcL5eyswhkoM+o2Ou6UiVo5N9WNIyjTZh@vger.kernel.org
X-Received: by 2002:a05:6402:518e:b0:63c:4da1:9a10 with SMTP id
 4fb4d7f45d1cf-63c4da19c97mr11628470a12.31.1761061904052; Tue, 21 Oct 2025
 08:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017085938.150569636@linutronix.de> <20251017093030.253004391@linutronix.de>
 <20251020192859.640d7f0a@pumpkin> <877bwoz5sp.ffs@tglx> <CAHk-=wgE-dAHPzrZ7RxwZNdqw8u-5w1HGQUWAWQ0rMDCJORfCw@mail.gmail.com>
 <871pmwz2a3.ffs@tglx>
In-Reply-To: <871pmwz2a3.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 05:51:26 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj3VgQAwUjfM_6f5O5gFr4kXBma2q5m8PLarRCnA8R49w@mail.gmail.com>
X-Gm-Features: AS18NWAG7YIQvZWdpCHOlvhJ3OJWyOrD174ntZFm1lwB34kJVwOkBypjHYnGjQo
Message-ID: <CAHk-=wj3VgQAwUjfM_6f5O5gFr4kXBma2q5m8PLarRCnA8R49w@mail.gmail.com>
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access regions
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Laight <david.laight.linux@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 05:46, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Oct 21 2025 at 05:06, Linus Torvalds wrote:
> >
> > We could still change it since there aren't that many users, but I'm
> > not sure what would be a better name...
>
> I couldn't come up with something sensible for the architecture side.
>
> But for the scope guards I think the simple scoped_user_$MODE_access()
> is fine as for the usage site it's just a user access, no?

Ack.

               Linus
