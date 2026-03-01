Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F636A017
	for <linux-s390@vger.kernel.org>; Sun,  1 Mar 2026 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772403401; cv=none; b=CpfiTr0Czqn3cpFov/oEBTUOFifGTy6JEHoDSxwRUHUKu1eSQgBdpt6tMr4AorLBsE1F720ZLeZsa5jdOuVxPankMH/v/xPqk5dHfthL8J8H+E1v3OrSpjCDPzpGlKwHp05TwHHhEd6mPcxwSvXqocWh6WJFBsri9QBPfeFcRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772403401; c=relaxed/simple;
	bh=jN4N1QaNMsASRJ5nI5g5Xxi3W8X39f5t/UYZx/nnQwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKL052dJVq1HGu9GBwGr619YRSSP5dREzly8GoOwQmAtvjP2KWwsfNPDkELQzcoM8F4MD4L3Nvw8gLghq2kktJLDddU3WMH7sWRgOYFW+JvqWQa1lD7wvDBbRSsnslETSxODG9RZg5AlTl8FC//QRq0nz9/+WkOYmjNhne/Q9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+zl3912; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+zl3912"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-437711e9195so2899986f8f.1
        for <linux-s390@vger.kernel.org>; Sun, 01 Mar 2026 14:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772403398; x=1773008198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIl/dHV642tMqRZscE3Zjz5R/EkJp5KZJrPHqY8MUl4=;
        b=W+zl3912b0zVCeZU0RDnp9c/Dtefju7bomYh4IPZxIEHwnAfgj4uEM2DvT3+gCKv8z
         eqHEEmkIMC/NtYWMsrm3JOUiYp4Ep7iAh6ZK1HcnUWJsLEX8CL/u3AjKSObBU9TT0n7e
         Q4knzsKstEbkkt8KFiRSzZSkscMW0YY3IW4hQWD7Lrm6rVbGst43AR5HeY6lBvF8qiH3
         2ESUeNC7zSJVc6xUYrtXzNIYK/9zqdLreujMyxsWyJFxzUIe8zsMviDdCM0YG7PFe3TW
         PFgXpJEC4e7VCEktbDFngyXnVY5zZh3IkXitpzHp5f3Mfpa5yBCHs7+t+uKWXntn2bHA
         sDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772403398; x=1773008198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIl/dHV642tMqRZscE3Zjz5R/EkJp5KZJrPHqY8MUl4=;
        b=Yn9HtwIsQQ24Ousy/e2vhocLsTfG6LuKUhw+qVwfjU7egpBLm3Dghm2MdLVcw/7NtG
         L0RqQSZTW3ONPFnOS8s+HEffgFfVjOauSc3oK26M/iEof7qIZwIl9V7kmdf+vmQWLjBu
         zMxDIEA9GBMHVYSpekN2aHkTXpx3I/WqpsKUYZnxAdDUuNbXvRKgbwdw0psuQchgmCnZ
         hVQ7bp/ImVuVeym3nQ+rqeZpgaihHRUEdSejhyrAQhOEeoG1lkj+KsUax/AlGlrqMVLo
         vFLPahWwh6O2SQ2elHNcfpQ54VLPVqlIrFIu8KHiH4iXuwKlnBj5R+pGc9Nfym6V0cgD
         Gg8w==
X-Forwarded-Encrypted: i=1; AJvYcCXM01uCUIRouoHzgbOpLDhfhcaQZve0JsOaRmwDE0TmZqICN2LvKglRclUpEUKOG0VDxDK9lpm43Wnt@vger.kernel.org
X-Gm-Message-State: AOJu0YxJa+/pKYbWSeJOU4YIjVCxtz8W06YHtYOO2DnQRu7Pb8yD7eCq
	Je1O2WEy5+EofPFFjzUKcvymlBfS/nINpdp3efdX01eoxd4/bEPz3HOE
X-Gm-Gg: ATEYQzyoeZNwX2CNb4rAYy4exk3+NuJLIVKgZyT0k/eSlddKCFk/fr4NFA6rprQkVe+
	QtFH15U+IaT1nS4bC0SUTtVJx/JEgmLZP5T1CDzZjuQCYZ5HKVU8tFiKcKFEYrbLXK8EI+RcrVl
	uBgGN/yBBsmc9vVblqyqVqvQqUNdcv1wDzBqaOqHSCIC0B7+UTIC53xDna/+govGvkvO+EVJx3I
	ktJRc6GTd4s3VqBzHfpPeD1m4mNZ0zGmVwrbtdQyFmgrtAD5SEz7+dLaHTnYLxFcy3KIV0AyOYp
	yeoGt36cxjes52Glt77NnxXJUcL2b4tFCJhluL+KtLO6LHyqxL6FdX8zjh4faXajtPTlxkaJfyr
	hIu758NzKTjC5wyI82CJqWF7w+DESAlhufdfg69mIb0Uw++w9+UjEbhxIY3BJIx45RPFh+Ap1TP
	ymo3YfTOVoExEzOqwUlNQy+j2JlSuxEbr4N3gdLykbo5B4KO6uM1gGHTkEZcTWwmkJ
X-Received: by 2002:a05:600c:4444:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-483c9c323d8mr157846385e9.34.1772403398069;
        Sun, 01 Mar 2026 14:16:38 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b3cc2e65sm6649234f8f.2.2026.03.01.14.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 14:16:37 -0800 (PST)
Date: Sun, 1 Mar 2026 22:16:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Andre Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] uaccess: Fix build of scoped user access with const
 pointer
Message-ID: <20260301221636.0efa722c@pumpkin>
In-Reply-To: <CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
References: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
	<CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Mar 2026 12:01:08 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

I also added to compiler.h :

+/*
+ * Sometimes a #define needs to declare a variable that is scoped
+ * to the statement that follows without having mismatched {}.
+ *	with (int x = expression) {
+ *		statements
+ *	}
+ * is the same as:
+ *	{
+ *		int x = expression;
+ *		statements
+ *	}
+ * but lets it all be hidden from the call site, eg:
+ *	frobnicate(args) {
+ *		statements
+ *	} 
+ * Only a single variable can be defined, and_with() allows extra ones
+ * without adding an additional outer loop.
+ *
+ * The controlled scope can be terminated using break, continue or goto.
+ */
+#define with(declaration) \
+	for (bool _with_done = false; !_with_done; _with_done = true)	\
+		and_with (declaration)
+#define and_with(declaration) \
+	for (declaration; !_with_done; _with_done = true)
+

So that you get:
#define __scoped_user_access(mode, uptr, size, elbl)					\
	with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl)) \
		and_with (CLASS(user_##mode##_access, scope)(_tmpptr))			\
		/* Force modified pointer usage within the scope */			\
		and_with (const auto uptr = _tmpptr)

The next patch did:
-		and_with (const typeof(uptr) uptr = _tmpptr)
+		__diag_push() __diag_ignore_all("-Wshadow", "uptr is readonly copy")	\
+		and_with (const typeof(uptr) uptr = _tmpptr)				\
+		__diag_pop()

I'll update (to use auto as above) and resend.

	David
