Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792774483;
	b=vgIJn5Tghrwb4JIay72m0jhAyis7djvkqPBIT/2ONbyTl8GXaYNPpnVf5ysQ5MGqLyc8
	 f7Q+iZr1lM2ab6s1kR/AezDhrnt3Pr9ntitWx5hSUJ7CUWROdvUvnK2kbAnQnbsxdQFev
	 jsGMBIu/xEbDpiJQp4Ocify+4rATlBVw8aP9VNU+T5KThkj6Hyd8RJ2IdnQm0YOe/kB4R
	 a8IeEgTs3OZj9xP4eLi5ykZbo3RqGBbWR1QAg/QV9ylWAJwtfIVfe2Gfd9BkqXbkO1sKD
	 Ux0thNChDqTW1UmZYvqsX+dfEAZCp7Z3ohxT4Au2UVgBOllgZhm/U3UQEd4xRUMX8Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774483;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=pcT1nqswGvhjhJ6QI4zO5XNTRfIOEZo9dTuCxwHmQEQ=;
	b=OG39Qiy9ejhiOTmaTm1vAySlWGvOotiKJ1LYDBvd7444I+NkWqPsJGmrIcI4k4oTQOB2
	 ENUxZp/T7motJ2BAYxG6OSq0MfRwUzxKp8WXv7xwQjDlsgbQ8nizSfBvfk1m9rOl00nOs
	 befvo30KNOMh/ePf9ED37VxCu2LfvoL7j5wYfdhtVKuiS9JQY3v8Z/o8xbG0ZMJkQ7q55
	 Yjwbs1mbb46P0LjWlMb6ovXNUhQm8EoHcil+ojU3rZ81cTNAGTOYtuRLRYfz1Uki8fBN5
	 xmHcQzfo6rwynmn1qdBfb1fVQNRqnjpEqPPbTbiQpuYlfa233HTqnYbS6eV3QkV8elg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=UnEe6EVt;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DE606A31B;
	Fri, 23 Oct 2026 16:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF2DE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=UnEe6EVt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=pcT1nqswGvhjhJ6QI4zO5XNTRfIOEZo9dTuCxwHmQEQ=; b=UnEe6EVtKxffwjLF3eLQvD/QRC
	OYHwnUhoA9RikyKoyBO5MwHg3XpiNroyzCQJdB/spBGBilu3N+Adl6S/hZPWU6J3PfKjOhBk2bct0
	s01jfhZ66XungAM18MXMRSM9WQZf6LF2a5pvPTL2iQ490BqfCfH7WORfLWLc/8YTuMvdBgDKSrRvK
	d7ILi4kGsfbYrXIuZ2E8t1XAAGex7QEE9yXuVJ3P3CWFPrC71nqhqyv73WwzT1Y87Ca9oNsst114q
	tLdpzcwZnREAABLBGjx8ed1rOygIB2WJaL6MRiZ0URMwTtZHSD6kUAXIWYjLVirLrAo631SAM75VA
	LAXRk/dQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKIXL-0000000Cz7M-3hud;
	Fri, 23 Oct 2026 16:54:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E4C55300720; Fri, 23 Oct 2026 18:54:34 +0200 (CEST)
Date: Fri, 23 Oct 2026 18:54:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Kees Cook <kees@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Pengjie Zhang <zhangpengjie2@huawei.com>,
	Thierry Reding <treding@nvidia.com>, Xi Ruoyao <xry111@xry111.site>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Rong Bao <rong.bao@csmantle.top>, Hui Wang <hui.wang@canonical.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] sched/hotplug: Remove unused idle_task_exit
Message-ID: <20261023165434.GX2823843@noisy.programming.kicks-ass.net>
References: <20261016095711.1364609-1-srikar@linux.ibm.com>
 <attjv8zOftf9Hlqe@localhost.localdomain>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <attjv8zOftf9Hlqe@localhost.localdomain>

On Fri, Oct 23, 2026 at 03:40:15PM +0200, Frederic Weisbecker wrote:
> Le Fri, Oct 16, 2026 at 03:26:40PM +0530, Srikar Dronamraju a écrit :
> > Commit 21641bd9a7a7 ("lazy tlb: fix hotplug exit race with
> > MMU_LAZY_TLB_SHOOTDOWN") moved the handling previously performed by
> > idle_task_exit() into the scheduler CPU hotplug path using
> > sched_force_init_mm().
> > 
> > As a result, idle_task_exit() is now an empty stub and the remaining
> > architecture call sites have no effect.
> > 
> > Remove the calls to idle_task_exit() and the now unused stub.
> > 
> > Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Excellent; less is more and all that. Shall I take this through the
scheduler tree?
