Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB09426EC5;
	Wed,  1 Jul 2026 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903704; cv=none; b=kHlQz+iGK4jCCeSrLPaZvugmyIVYPkI01oiB6AwQBG83wzlyUSOMVdaTTTDmS+AYc9scLdSwgf1/0Zk8z7LOAZtqaaHdp1OkSzQV2MPTuAApoRiMrIutQ1nP5TzU02lCIHQ6T9BPkuE/otIdD22v5jpFjjtNV5cONzzpNGGcPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903704; c=relaxed/simple;
	bh=eCF91Tc3YJCTjHiwvkn18MC+frdIp0tyv/SZaByYOQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzFOznfY2pJNX+0Qez+axOkMno4XoHpn5JnwhzA41ZwTGy/jcy3dJfhpZd2BiGFS+swz3HTpiFDdzxT1urD+llbE9XYtZ3MU4N2bup7VIK+lYCTLX6N3ReDzB44h1fCcHnJ7XpQoy1/DpPf8lvdGYjcjCc0O8Q+ejFnYsix0CLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3HifUbZ2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LJJCbaRz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3HifUbZ2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LJJCbaRz"
Date: Wed, 1 Jul 2026 13:01:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782903701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNxVJGEMAXRCpSTfvSk7rdKi0pYQo3rQCK08bwqgoOk=;
	b=3HifUbZ21ScKQtWF6SIw5j3fCUEdR+xRpgI6ZiVs3+DcPllGZA8Ji94V+XUdwDrNcM/7ij
	+H8qYhqLmRVhTFU9Xbty5DTZ8XxGKDqRxQxL1vTqr6BEMw6zmurDnk/JsaoKxSXYAcjN1F
	6Uzt7JsgKFkfst0NWwo8OmJzzjDn+oVuzb9b+HlGgbTb3HddAJsW7TEB+3Wy+xPQgTAZW4
	rSQ74uPNXSFR1hJkaQBX03oVNJspPKuqg0v9yXuMEiJZy1/UuO/gMZkPv3oZJ8hom+tEGH
	PvfGbzUklh8YNbdEj41qDzenKHO+aXOoCmp6dRiLzh0hagRlV5ggtMdszJWLcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782903701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNxVJGEMAXRCpSTfvSk7rdKi0pYQo3rQCK08bwqgoOk=;
	b=LJJCbaRz0pqf6PD4GbhO2SME6PRZyX4Kho1+qmiOyaUmczMK9UnqGhmiZqX5vxb5Za35B/
	Y1Mq4Y/RXRZ4NvBg==
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
Subject: Re: [PATCH v5 8/8] futex: Use runtime constants for __futex_hash()
 hot path
Message-ID: <20260701110139.z8WokGYM@linutronix.de>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
 <20260701075714.GP48970@noisy.programming.kicks-ass.net>
 <20260701084150.GNOeboLw@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260701084150.GNOeboLw@linutronix.de>

On 2026-07-01 10:41:55 [+0200], To Peter Zijlstra wrote:
> This makes it go away at no extra price but yeah let me boot a big box
> and see.

as-is:
|$ ./perf bench futex hash -f 1 -t 1 -r 10 -b 0
| # Running 'futex/hash' benchmark:
| Run summary [PID 3588]: 1 threads, each operating on 1 [private] futexes =
for 10 secs.
|=20
| [thread  0] futex: 0x5555e5ad4740 [ 6449632 ops/sec ]
|=20
| Averaged 6449632 operations/sec (+- 0,00%), total secs =3D 10
| Futex hashing: global hash

roughly that area, repeated runs usually change the last three digits.
Patched:

| $ ./perf bench futex hash -f 1 -t 1 -r 10 -b 0
| # Running 'futex/hash' benchmark:
| Run summary [PID 2375]: 1 threads, each operating on 1 [private] futexes =
for 10 secs.
|
| [thread  0] futex: 0x5585ddebd740 [ 6532004 ops/sec ]
|
| Averaged 6532004 operations/sec (+- 0,00%), total secs =3D 10
| Futex hashing: global hash

for private hash there is change within the noise area for -b 8192.

So we have here +1.28% ops/sec. Not ground breaking, not bad either.

With more threads:
| $ ./perf bench futex hash  -r 30 -b 0
| # Running 'futex/hash' benchmark:
| Run summary [PID 2424]: 144 threads, each operating on 1024 [private] fut=
exes for 30 secs.
|=20
| [thread  0] futexes: 0x556f3a3387c0 ... 0x556f3a3397bc [ 2104422 ops/sec ]
=E2=80=A6
| [thread 143] futexes: 0x556f3a3d9660 ... 0x556f3a3da65c [ 2105480 ops/sec=
 ]
|=20
| Averaged 2111486 operations/sec (+- 0,03%), total secs =3D 30
| Futex hashing: global hash

To:

| $ ./perf bench futex hash  -r 30 -b 0         =20
| # Running 'futex/hash' benchmark:                                        =
                     =20
| Run summary [PID 2723]: 144 threads, each operating on 1024 [private] fut=
exes for 30 secs.
|
|[thread  0] futexes: 0x560a09e487c0 ... 0x560a09e497bc [ 2135688 ops/sec ]
=E2=80=A6
|[thread 143] futexes: 0x560a09ee9660 ... 0x560a09eea65c [ 2137668 ops/sec ]
|
| Averaged 2139685 operations/sec (+- 0,03%), total secs =3D 30
| Futex hashing: global hash

+1.34%. Again, not ground breaking but still visible. And the memory
savings.

That is btw, 7.2-rc1 on a Intel(R) Xeon(R) CPU E7-8890 v3 (4 NUMA
nodes).

Sebastian
