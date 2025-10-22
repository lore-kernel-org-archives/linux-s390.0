Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B1734D90F
	for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146652; cv=none; b=nnkTa8Tssk0U7P5YAoZQ/M2BRlzOqOrY87F7fqkOu3w5fnNqkiTq4LrsaAhy+DrEyEbyntQUTBjL01AnNVpfwHWuWmuZK16+HNOBo9TJUvib6e6ouOTaBYfFEe3tAVbAGTlpZe1zbF5WOttJHRCUtRZyC2jakcatMPc47luAzhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146652; c=relaxed/simple;
	bh=OXIiWMPtiN+YU2NFW0i5Rjml45gOXITGkMIHm2eAIu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIYlIZhJyWrWfWMWVHZ4ZbQWySN4ugheiht1wAE/pgIB3ONBkEgFTHxiVFIqpiSt+u1YZWP6marvUffaPZ4F16nRWx/pMqvzccAf/Gczf3gZWjrrhfS1I9MAyC/ZQw2sbLRvTwNgefOiiC5KUdAacLN6dnu7RRlsd3WGKdTMsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PHGkPHxp; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PHGkPHxp"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so9152229a12.0
        for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761146648; x=1761751448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8Ks3283lFKT/3or/kKLaFk/rSeUKOKq+L7qyJbrS/M=;
        b=PHGkPHxpYyHV9UlS7F82vXq6HmeeMw8rJY0TvQ7XS6GydAhCu4MYTygbCe81EGsN4g
         4ZjF+5mwNzZ0cUCPVru3cwm/V7toHk54odNrFTREErbd6ZpVis/BiZctiaDOIgzs8k0e
         ptJ8UA2Nlt+aQpN4l7i2A3OLhvjghSNWGckDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146648; x=1761751448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8Ks3283lFKT/3or/kKLaFk/rSeUKOKq+L7qyJbrS/M=;
        b=HPKIagYaLbsJCFPEC7yEK7v9wtO59GvjTmnschpdE99Tzl2bOPq5SNc/PdrhfLTu43
         E6vArjng259D4aoE9OaKjoq5eKEeV5S0PNsMWfFAdGLQ+RHksxZOrPrLD96iFItdYv3F
         pAOpv17q33DJ54o8GS14nvnQxkGNKmDco2ZIiCBC+yV1KzSRTMsz07R2qyLP7rnquMeh
         qbW0ppQ01A3DzKDc737zXEf+e+Q45gL+SFzdmzYlzhomzeICDk+x0MelvvCXFZWQwRD/
         p27sJciTTPrglDTclbT282l4UaN3xJpbP1D6Q4ZDJoo1Oe2K7h1oNV3clmqlwCPeGjIn
         17Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWDdF/oHVNWuanY+Ak6ZVSvwHvapij3Snsi1ThXU9n5Fqf5LMLuRa7T4PDf1U3vWcaU8hI29ey9afws@vger.kernel.org
X-Gm-Message-State: AOJu0YzrwKzUDpiN3+a6zdjkhA5/+Bh40y3+EMFWIycV5ABjE5LGQUaj
	gLuGTZjHtbE9lWC8rZpVfY3lX2LrI5R3fCrnhSof4tOJpj+TGUk1IXYpIqkMdewrAzVOtJIbgmJ
	HjUsTTdI=
X-Gm-Gg: ASbGncvr8JxhY4aYozrjv/ZzgP/pmhl/wMQAzB7aJ8ORUc2TdhYkFuW4wxNod/NzjJH
	qsz6sD8h0s/Fk8o4Z25EkTGHEzvjvaQiHPiTdvU5fBW/F22Qf2FEl6POttBJA4FR0gySoX9J6e1
	lUFph9E2ytkZOdDxw0PGUrVeW2zvrGwV5m0kGApZGDbDL0xxdmoV5XFQlYVAriLyFgvofuicty0
	8sNYzOUsCmI8gVoLr9Cm4WOCj/5BLaz2y8+M/nxklKwfIqF2zQU2cBAJ8tOXtFYEVlNqKZ0jg68
	ELduSy9drubE5Wk++P5W3n48AcegPQ26CxSxlIX1Ek9nJ6n/GLCk9xXx39gBn+fiV2X0TBD71js
	ahbPukRkYDSN39lyyYV2Q9qgzTYcm0uRlXBuPgi9oVxw6ks90j9IkO5JCWaOsngSZWHKLuUBUCI
	DIOh8v7HzrMuvkoyStFbsoCqbqyRyeEumTOgTkB49d0r3H+19kSzg/3ej7Z9hE
X-Google-Smtp-Source: AGHT+IHP1Zncg27QyCOiO1VRLH4j2NABWid/63BvVuQX0nCOv+3WIqo73V3NEop6NoCaC0/IK/Lrag==
X-Received: by 2002:a17:907:bb49:b0:b4b:4f7:7a51 with SMTP id a640c23a62f3a-b6475706fc2mr2605008466b.62.1761146647917;
        Wed, 22 Oct 2025 08:24:07 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914fasm1345064666b.20.2025.10.22.08.24.07
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:24:07 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so12688346a12.1
        for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 08:24:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBVK15eokZUQAmdx5dQKsF4LKKFaAvKFdPXHieT5EYLxmrH9AuYIrcTpbYH+UvTn9EefZuw3Ou6suY@vger.kernel.org
X-Received: by 2002:a17:906:c144:b0:b04:48b5:6e8a with SMTP id
 a640c23a62f3a-b6472d5d715mr2448051866b.7.1761146216891; Wed, 22 Oct 2025
 08:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022102427.400699796@linutronix.de> <20251022103112.478876605@linutronix.de>
In-Reply-To: <20251022103112.478876605@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Oct 2025 05:16:40 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com>
X-Gm-Features: AS18NWAqLsXEY6bsEV3yJ0KWUZmBC6kMtZXzbsnMf3ubAyGEsrR55YgMKptZqjM
Message-ID: <CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com>
Subject: Re: [patch V4 10/12] futex: Convert to scoped user access
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 02:49, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Replace the open coded implementation with the new get/put_user_scoped()
> helpers.

Well, "scoped" here makes no sense in the name, since it isn't scoped
in any way, it just uses the scoped helpers.

I also wonder if we should just get rid of the futex_get/put_value()
macros entirely. I did those masked user access things them long ago
because that code used "__get_user()" and "__put_user()", and I was
removing those helpers and making it match the pattern elsewhere, but
I do wonder if there is any advantage left to them all.

On x86, just using "get_user()" and "put_user()" should work fine now.
Yes, they check the address, but these days *those* helpers use that
masked user address trick too, so there is no real cost to it.

The only cost would be the out-of-line function call, I think. Maybe
that is a sufficiently big cost here.

             Linus
