Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98CD320CCC;
	Wed,  1 Jul 2026 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922663; cv=none; b=jdVLfgl0ageWHTl9S/NQqunkjw2iCNfQRg+pM7DZS0laKT9M3QM1bt8rjTeGM2XqzxDpC6knDnCBqWwDGozEdqOtL8Nm5B9h3vcKqXg8ZQJqX5OSvuah8J/RFJzn/vk0FSyR9YxYx5R9lS5jI1vJ7y2z3KQh47zDw+DAwrfqy+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922663; c=relaxed/simple;
	bh=28yaKk7mLPJhVQQx6WKD3FN+YK7zA5MH9cuQEl4rjoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7ckJG9OaSlFINt3shxobiPNdGUKBzk1pANzXMUIOCIUyPzcRK6JwUiKzzws1AOk591WOBCcGNMcDXn0WSr7/jCiYLTLALYKYVm4sEzEhVBQ2j7ItNMNb6O52WHQkqqeRVoR+q70A0oACKvNMaAacnlN8RpV7Y34EumGu2VdHpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EsVOyL/O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qFYc53sa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EsVOyL/O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qFYc53sa"
Date: Wed, 1 Jul 2026 18:17:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782922658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2lRSuF/an/7YC+KLWyfsyxeZeo/jAhgGQaxohFrdhc=;
	b=EsVOyL/O4PkbWArMdz+v6gZguCvGG9j7x/3IOQgfmssmAyzbqbf3Dwnmp6iiWjIQLh8IAK
	JRAGYLysl4sguhM8CiL52IwItjrsA45kJA1HxJerrdKce1yFKscd6hUfBDk8kRLLBMASP9
	HAaDRaeyfaUrcTEpWpEuetEq4glZT0vuVbB1uLjbuxzlPtCFN1uTxxJMQUwfqVd4rBfF4R
	wCJsPf0rmhs1B6MbHjJUE4G4tH6Wt9Gtq6+Gm8frjT4c8E48ygPJmbA5oLD59dsCa1kUWd
	30TWjA4Jl5hk3kMLudqnPwPZBzaW22VoMTwcgpgNZPMUp1ROWvJNyZ1aXCKRQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782922658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2lRSuF/an/7YC+KLWyfsyxeZeo/jAhgGQaxohFrdhc=;
	b=qFYc53saNm3tZyv7Mrg+WEORV4WZSIwyhGD1WLYh9NkQnExpQvcYwwIZIB8tgYMjlnnAMr
	VNvK+45twjg6TcDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Huth <thuth@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jisheng Zhang <jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] futex: Optimise the size check get_futex_key()
Message-ID: <20260701161736.xYYizA0e@linutronix.de>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
 <20260701075714.GP48970@noisy.programming.kicks-ass.net>
 <20260701084150.GNOeboLw@linutronix.de>
 <38239f40-1673-469f-baa3-4a343d2aa4c3@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38239f40-1673-469f-baa3-4a343d2aa4c3@amd.com>

The futex address must be naturally aligned and this is checked via
"address % size" where `address' is the supplied address and `size' is
the expected size of futex. It is guaranteed that `size' is power of two
but the compiler does not see it and creates here a `div' operation
(x86, arm, gcc-15).

We can take advantage of the pow2 property and rewrite it as
"address & (size-1)".

As per testing, the command
|perf bench futex hash -f 1 -b 16384 -t 1 -r 30

improved from
| [thread  0] futex: 0x5619f931f740 [ 7001583 ops/sec ]
to
| [thread  0] futex: 0x55da173e5740 [ 7376137 ops/sec ]

or by 5.3%

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Could someone verify this, please? The 5% look a bit high. This is on
top of the series (but not worsen by the series).

 kernel/futex/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 179b26e9c9341..2b00ab510e7d2 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -520,7 +520,7 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 	 * The futex address must be "naturally" aligned.
 	 */
 	key->both.offset = address % PAGE_SIZE;
-	if (unlikely((address % size) != 0))
+	if (unlikely((address & (size-1)) != 0))
 		return -EINVAL;
 	address -= key->both.offset;
 
-- 
2.53.0

