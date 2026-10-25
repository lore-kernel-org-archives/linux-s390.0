Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792954058;
	b=UDj0TcLegPGIb+NSQdzEoX6ogJ/pr4JZ15juckc45Gny/W/8cpi3W0trsN9/eDJB4Ngi
	 Jhr9Lmp+8LR6vlb7k7cmB/BwQ4/rGJQhV/cB0hrZ1N2tqq+AzT7DUxzkT5pU2/DPc4lE9
	 ePqnxRa/woN6aaHN2BTtVXAMBVgWmp0QfyXR4mwJHgdX5afNC6xaVK3aIhknS5A0Gei5N
	 v8r6UpsfWHUF54jbkplGLB/wJxEuhLIcUjtNh8JBLhcXc3W2q2FE1P9ZFzN9KMsoYE5wk
	 0As0aK7GgXm3KlL6IhZ2JLAOym25oodAmg13NUYIWR0KX2eCItS1tfcZMpQutuIt4dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954058;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=5wnAqR12mDvQqCEE/MRBIlSMPEALxmmJZfIrTK2aMRo=;
	b=oI8t25y2n3uUEUo5oZcz1ZhwNch0Zer9U2KJIUcGZxFJQlg09c+k01KATCClZitp7nVe
	 QOpGuo43gqQs3bMRRJDQrc0EkmNQ/AmE9VzYDYqucXvSv2x/2i6lwiwrlZaagZ5mns35P
	 1sgk98K5TOOrhJEM5poHi15RL2TVjhq2ow9zLUove1SWVRZslP3kwxpDa47ltRSE+mcP8
	 J4LXWsvXDIIB+7wkS4snOpWPuollB6gV/R70FBmnrgnEhSSmIvSqQFZu2N1pZTAPw2FU1
	 9wX1ISusI8e6nAL2kKacaN4zU39t2QY1pRbAmN0WczqXPPHMJW4pKsscU2Td1YKfpOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6C08BAV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A60606A31B;
	Sun, 25 Oct 2026 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6C08BAV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2E91F01828;
	Sun, 25 Oct 2026 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792954057;
	bh=5wnAqR12mDvQqCEE/MRBIlSMPEALxmmJZfIrTK2aMRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J6C08BAV+F3iiWM9FlcPNqjRNGrOHJtPKNVu3OUcI7HqHZFW2bJf7N0c8G+JK3kuC
	 Q9nwKr5QZZOaBx04tv6bryafAtS3l8ddZSESLreLqFOuH9yUyY5YFa2WLyjKrfokOY
	 I5aQbn4Z7ktlYAGGiVhADA+Z2owm484BBGS0MXEu9+8SJ1Xd+9nopeImLHezCjmbsI
	 l+b9jyQmwALbi3HX0Fd2Od6jLx4uuOwo/I0r78SNRDtzRGmz0Z0w8l5bueq5IOCdWr
	 lyimjYWJ1aQUhpScd4g5pAdhgA9k8TZ3KLStW1ngSWF9YCMs/TnFJYzxEr+8kDEq+3
	 1F+kG3xlNHiHw==
Date: Sun, 25 Oct 2026 19:47:34 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <at5OxorR-UUIxlIe@pavilion.home>
References: <20261016095711.1364609-1-srikar@linux.ibm.com>
 <attjv8zOftf9Hlqe@localhost.localdomain>
 <20261023165434.GX2823843@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261023165434.GX2823843@noisy.programming.kicks-ass.net>

Le Fri, Oct 23, 2026 at 06:54:34PM +0200, Peter Zijlstra a écrit :
> On Fri, Oct 23, 2026 at 03:40:15PM +0200, Frederic Weisbecker wrote:
> > Le Fri, Oct 16, 2026 at 03:26:40PM +0530, Srikar Dronamraju a écrit :
> > > Commit 21641bd9a7a7 ("lazy tlb: fix hotplug exit race with
> > > MMU_LAZY_TLB_SHOOTDOWN") moved the handling previously performed by
> > > idle_task_exit() into the scheduler CPU hotplug path using
> > > sched_force_init_mm().
> > > 
> > > As a result, idle_task_exit() is now an empty stub and the remaining
> > > architecture call sites have no effect.
> > > 
> > > Remove the calls to idle_task_exit() and the now unused stub.
> > > 
> > > Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> > 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Excellent; less is more and all that. Shall I take this through the
> scheduler tree?

Yes please :-)

-- 
Frederic Weisbecker
SUSE Labs
