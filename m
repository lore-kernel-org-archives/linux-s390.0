Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3897F357CE1;
	Thu,  2 Jul 2026 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989780; cv=none; b=i51rc7sSCV7acyfXDeE5Mp4AoQ1PwgTN28MmoSDh2q4Jmaf6LuynhFE6lXafnZVqaHnFThCbdCXBxn81PqUgfrFxO6rMb8bWvsdQyo5dobWTUoTJMvdYCFNJwcsRlmdEoy+jhoWzvM/BeSdZDN9NtC7CmxNswwprL11fylmGkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989780; c=relaxed/simple;
	bh=WIcjYfoWn6gcmd0f9zDPpY6wy1Eu6WkQW0J8BHM4Zdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEZv6oVOyXUHQtq/smNbLSgzaGvwJ/XZDu2ow3qnIyfZhdpR3Kh/00rkxcB/Po8dpCjKNQQ9NcbkkAeqpnu9GZzAcPMljPWPSVw1xdU+89JavO718ED7M9us3hUbNJDt9F2ui4xtRwhciQAa56/DWH5fq9Os9yQn+lqZKnrtnOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4TVhvdqA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sH6bVU2F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4TVhvdqA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sH6bVU2F"
Date: Thu, 2 Jul 2026 12:56:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782989777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixPQhnXgf4TKhclNNixfZQM7k/+d5gcWfCG3ObKKmF0=;
	b=4TVhvdqAIOEciydZhtWWTSBcjaeQ7Q4Nw9cuTHhL5opET36YUxZTwm3tFIMjXOSyivMsdt
	e0nVvs6ZVME8To/TkXXaWt9vu/ln7SPpBWx1P7HA4t0Pa7TQR7NzLgcvsS4YnG+QFfuA2k
	jsYLqaHd7uofGl1j45DFi+maomvGsdRErti9RqvI/7AcnlWEQPSWjCnZQX5zJ/p4BY96ey
	QuN0X4JZNXCH04yMHGSmEnv7E0fqOXkibVit8kf41tnXjZi3Uwslp69Trx+GBHyxL0CpUD
	9fxWC9NFlot4OKOHjeJwpm0BfXn01F53jFXoGwwFb35RESO/ccPB7phTFYI+aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782989777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixPQhnXgf4TKhclNNixfZQM7k/+d5gcWfCG3ObKKmF0=;
	b=sH6bVU2F/pVuBlU067fDQEXZV5D8/UVBZNrA5jq3yQM1YprNUp9catTpYWYg5/RKz98OuW
	P0HauLhefLtPWAAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH] futex: Optimise the size check get_futex_key()
Message-ID: <20260702105615.PiYhQ9Rt@linutronix.de>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
 <20260701075714.GP48970@noisy.programming.kicks-ass.net>
 <20260701084150.GNOeboLw@linutronix.de>
 <38239f40-1673-469f-baa3-4a343d2aa4c3@amd.com>
 <20260701161736.xYYizA0e@linutronix.de>
 <20260702085921.GD49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702085921.GD49951@noisy.programming.kicks-ass.net>

On 2026-07-02 10:59:21 [+0200], Peter Zijlstra wrote:
> > Could someone verify this, please? The 5% look a bit high. This is on
> > top of the series (but not worsen by the series).
> 
> Bah, I tried to reproduce and couldn't. Then I noticed I did a clang
> build and that is in fact clever enough to do this optimization itself.
> 
> /me tries again with a GCC build.
> 
> pre:  [thread  0] futex: 0x561f14430680 [ 9021408 ops/sec ]
> post: [thread  0] futex: 0x55feadbbb680 [ 8977527 ops/sec ]
> 
> (and this seems to be well inside the error threshold of this test).
> 
> So I see the GCC build do the DIV, and no longer with his patch applied,
> but for some reason I cannot get the runtime performance to actually
> improve much of anything on my system.

I did open https://gcc.gnu.org/bugzilla/show_bug.cgi?id=126078 for the
div.

My .config is the debian distro on the 4 node big iron. [ in case it
it has so much overhead elsewhere that this place a bigger role].

"perf top" showed this as 6% or something and red in the function. After
the removal it did not show up.

Sebastian
