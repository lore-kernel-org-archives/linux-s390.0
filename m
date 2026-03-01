Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27C312826
	for <linux-s390@vger.kernel.org>; Sun,  1 Mar 2026 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772395781; cv=none; b=sFUFLcbTItxJrnPo7Ulm9zVAdIq4zOWuYoSvUxjXdCmO/eXfBf22J4lzFUJeU4EYzHLXDy5fctmH9S3e92mecv7rl4FJX2wUZcOE9rEk/bAGLAJLEWZK08X350ragOKQr9h6vEwSGNjgNBNcn4j7Pg3zN13U+/fl2W7FfVGZbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772395781; c=relaxed/simple;
	bh=Cx3qgkZ6V+eyMfb2glkDNNNfa4NrrGdL5+nlIhh5YNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUiNjJt8ddQ4TY1K6+TWI/RHsxoJrr2JhGiwspOonXpNxh3Ogfuog+ybKXNzP3C9uqPU5B94cRv9AtZg5MdQY+TOptxhE9Fetp0KOojffw0gkk2NMBuf1/VTGBb09LWMC6kZLHc3M4mAiA7d+Xi9u5G/igJSbou+eNmHC0tOk5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R/TZ6LGx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R/TZ6LGx"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65b9d8d6b7dso6125572a12.2
        for <linux-s390@vger.kernel.org>; Sun, 01 Mar 2026 12:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772395778; x=1773000578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jB/XXPWSS4Vb7E8KI5vsQ0OyjX/VbHAJPkU3Kvm8KQ=;
        b=R/TZ6LGxkcJaCaom9tLTCACGtRFkxe/NvSUs6PFD8A27jYsY8hBKvD7eDxlf+KkRME
         AfKXQbrh6BO29hYwHHmv/AjpgpbWa4onPZmCQm1yNXkqX2AqZUmF+KKh3JJQdRmr5TE6
         as4H3oOhawL/tVRRsUmh3obsesObcRFDJggvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772395778; x=1773000578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jB/XXPWSS4Vb7E8KI5vsQ0OyjX/VbHAJPkU3Kvm8KQ=;
        b=UebVwesQ0ybymPpQvgCfN1xbAQJkIc9a9ioINpqx4IGf8L0sxHG35F4SO4mLzWjprW
         zjUylhgMH1haFzykH0l+i1fHms0P47n+4H29SupFtaJZEnUvX4rS7uLRNBloieLyEL2l
         7FfoNd7rCAs8SFZhSRQ/sSNKjl/kkdrWXQzBdWzwh3rJCFZLuuT5C5/jNAR8S4QgTwBP
         Bwke4gbP11l6ENXpX2nCua9Rl2PgbpJHIb3SJsX4605ZDWf/YOEybhRnMwg0ZQMIkN6v
         C+NZnhdxS4btFB41BcNj5UY2WR9FSU5tXCNVSThrgxEm/ANpfzfAy34OG0FJf8royYii
         PvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5imCPz1XLf9oi3QHr7g578YFYzpkqlA//1Y5+XPte/KKEKtoVnNWNC+HFX78nhL0+qpEH1PIehBtl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4k4P6tLeLrjK4e6VAz41rzoNC0swf1WLJ+bvo2bBKdZzTQuA
	FgxXndb7NJudKvszlI3LmYt/m8zHmf8zL8prbVOKuyIf8e0EKTFLw6MBcwzJXqYM0NCImHg00ob
	xlM7t9wMQ6Q==
X-Gm-Gg: ATEYQzzBCaszUj/AQvfo0pZ0hd4iQxdZaSGmi14NxrTpkQX6ZQt/TVQ6v1Dr2ARs/kz
	bqlu3NxDa11khWMf7ivGW5C5LoJwIHPMYpIpEiDf5CkykPW4taxFSWzhRrl7805PJTDl50Ct4bl
	y4kv0hLkkGgxK/lbgLau09CLEnD1o034cFdGB242EnctazKG0jGda1Vw2afNGx7Zk1AdGLl/Cxv
	ZGgM4b9wGhwZUJtJHF6a7ruSrAk4CBvx3zCB3+Z/eDi4eqbPm65ARivMlxKNHDv7XzGv/XnLf22
	dY0YIE+gt0i4N1zbGkfl6JekYFORFUIPV1Q/5onEN5b7RHNXXy21kmHDQDmFqoxQNvRhRVphSre
	6l+KkxkTBRqUvEOE8009gib97hD2/dubtHn22dhXytYQQdCKDXCm9jQnGKgkEYIgrdPRnTlRQQx
	HWhPgtkzFdcPZyzYQ+gbDWMpdBfI/6skMuv/NJUVVv01Izv1G9hqdI2jNZO1CQofTFcwibZd9Z
X-Received: by 2002:a17:906:3611:b0:b93:5ef5:9059 with SMTP id a640c23a62f3a-b9376568db7mr429734766b.45.1772395777663;
        Sun, 01 Mar 2026 12:09:37 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b93987b9f73sm180724066b.47.2026.03.01.12.09.37
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 12:09:37 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b934fdced05so495409766b.3
        for <linux-s390@vger.kernel.org>; Sun, 01 Mar 2026 12:09:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU57g08R245P0P2BAmL0NzlCoUDGaYMq+OFlchoqGFpMtExVpbBC7N4c+mfAWDsKnfZgQsmaL8xQ14I@vger.kernel.org
X-Received: by 2002:a17:907:3f1d:b0:b93:5405:9260 with SMTP id
 a640c23a62f3a-b937c64ef77mr572433266b.30.1772395284743; Sun, 01 Mar 2026
 12:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
In-Reply-To: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Mar 2026 12:01:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
X-Gm-Features: AaiRm51s3eNxZj_25SK_rlwxCS0TV1EUyjNISFnudmurbAezRL6om8RwkB99_8Y
Message-ID: <CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
Subject: Re: [PATCH] uaccess: Fix build of scoped user access with const pointer
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel test robot <lkp@intel.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Mar 2026 at 11:34, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> -       for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
> +       for (void __user *_tmpptr = (void __user *)                                     \
> +                                   __scoped_user_access_begin(mode, uptr, size, elbl); \

Why are you casting this return value? Wouldn't it be a lot better to
just make the types be the CORRECT ones?

I didn't test this, so maybe I'm missing something, but why isn't that
just doing

        for (auto _tmpptr = __scoped_user_access_begin(mode, uptr,
size, elbl);         \

instead? No cast, just a "use the right type automatically".

That macro actually does something similar just a few lines later, in
that the innermost loop uses

         for (const typeof(uptr) uptr = _tmpptr; !done; done = true)

which picks up the type automatically from the argument (and then it
uses the argument both for the type and name, which is horrendously
confusing, but that's a separate thing).

Does that simple "auto" approach break something else?

                   Linus
