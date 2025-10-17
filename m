Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18B2BE03B;
	Fri, 17 Oct 2025 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699560; cv=none; b=UkkKQ2XH7CFHWz4QsgJuUMiPFuKoWSBZjfPgZ8cmRjUqCb7FgLUeboVZdLL61nCuBgmIFZQP21/TAUvXunmcCCIzmLdHzt8emlrJHc1fHDkpU0QQYKbALgYmqIucyOPSzlFAyBtw8muJAHnlqwt2QYnobV6yyGXaGJ8fioUTeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699560; c=relaxed/simple;
	bh=ZJRNtWf19pvirCFPUL3XMbI/hRPSYGK1zeWUsFa4CIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/U1I58AzUB8tYoMK7HTg9pJ8g4XlUT8p+nZeWc0hqk+8VhHoOpkfDpAvxa7W8kj4klzIctFweVsPSxt1eeQY7XpApRnZ+3SfY6BGE0U48pVlU7VAMk42OH5udLo7LzWcjGFewlfdt/fza5F1HQPWM4SijfhL4OKlMyQ+STrnEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dwf9SVgx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=26gxJBd+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dwf9SVgx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="26gxJBd+"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760699551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8r7krmsVbg9LZSGZHAhgtzNazujSLkD3B3g7V5NcBwY=;
	b=dwf9SVgx1Zm1Pjequ3PR4+DL9xU+zQkUKo/qkUoLgcEfT5hWjmoO+A9ILNUIdfH3PCBjcm
	kjHuIgzpSkUwpYij4l2LrTCRzQ2kOF14XCm2thcKmeyb4xvWKLv4pS9XDX+TSJMhsmM3xZ
	uJd47j3quh7ZP3eF0SSZHcrgy0w23wDuwgQVoKuxn37DVakJ9pvBRscWEovVvfQBQMLfzo
	ZDoCCebSSI7JLCizkNXDwjf37GRsNaYiN4YTYgmYyBOmkYv+luhDR3r613BYkEG6UQ4xEp
	iYq38/MAPfL1wPgY02WJkbXSgs57Re0RYgWYpTOXPn8w5sJohJ8UT9mds3BzsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760699551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8r7krmsVbg9LZSGZHAhgtzNazujSLkD3B3g7V5NcBwY=;
	b=26gxJBd+HlY8L8NbIT72iVZHqcHJxgQgi0oCm2WnVTtFtLjxOCcaf7Awkdf4HoaO1nfGV0
	R6vqEwqGMtDc68AQ==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, kernel test robot
 <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Linus Torvalds
 <torvalds@linux-foundation.org>, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>
Subject: Re: [patch V3 12/12] select: Convert to scoped masked user access
In-Reply-To: <20251017103554.GY4067720@noisy.programming.kicks-ass.net>
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.570048808@linutronix.de>
 <20251017103554.GY4067720@noisy.programming.kicks-ass.net>
Date: Fri, 17 Oct 2025 13:12:29 +0200
Message-ID: <874irx234y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 17 2025 at 12:35, Peter Zijlstra wrote:
> On Fri, Oct 17, 2025 at 12:09:18PM +0200, Thomas Gleixner wrote:
>> -		unsafe_get_user(to->p, &from->p, Efault);
>> -		unsafe_get_user(to->size, &from->size, Efault);
>> -		user_read_access_end();
>> +		scoped_masked_user_rw_access(from, Efault) {
>
> Should this not be: scoped_masked_user_read_access() ?

Of course. The wonders of copy & pasta ....
