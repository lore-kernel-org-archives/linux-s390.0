Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762818;
	b=IxfyoiofYocD74fQOtCLqP82TNbU63LhcIHJl8V0ozcPnAlME4ARZmJdSsvRLt8eO1lH
	 cmxbhDG1xUUZZkS2yAeYKePkx46WeZpLI+uXwGMrqzjq9/oHsiCovyTToaJdeFpkvsqe1
	 SNnHcc4TLe773EY9C9WqN9RWTxqHIUIymY1awXryJbnf1suyVlrYFcvwRX+9NZFpjKQb6
	 o8FuyANXSxE7DOMJFLZpIQQgSciuuDNEFgWOhPVViIogda4CGJaZGkLgcOnFDGu9TZzpN
	 6wIH+PvlcgoSbAgLiUmPA4RVGN6MgqPQSHOpKO+YkWPGvfLJL2Nq9Yx5CWJ21/7hOwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762818;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=JSne534GRKySd/hPuhXIpMo4L1wNZz0o43yKbATYUSM=;
	b=UuZ8ZZRHDNwlMgjC7zzj4fg6VdMwrmDGGA6zv8JI2UHo/Cko79qd1GVu9evyXMgoed//
	 LGtNZT61xJJ0rtEMu9OC9J7bW4zJIaj0imtQn0fqKAmZd10+wMjwLnUVnOPJQqZniaRkR
	 bdYqLMEoCo7ofeWsGP7QFcHWq2oezYK8oV20az+Fks1APndJVaBflDVs5OFsDO6S9n+yS
	 29UBurtm5K8a3qWSQwWvSxvbmV19pcJue2EfvK3HCOzS9zIIsSBVLrDL9FKy8dPUvOeIC
	 0W4zaqHhoKjx8xAUlKwiyENKyLEW8HsTxd5ON2AZSH/E/Mwk9FsoJeFkI1l6tmkm1Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsxhMa+8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4386606A31F;
	Fri, 23 Oct 2026 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsxhMa+8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9E21F01825;
	Fri, 23 Oct 2026 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792762817;
	bh=JSne534GRKySd/hPuhXIpMo4L1wNZz0o43yKbATYUSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MsxhMa+8RyiwJgrd29IwYvMrh1cHDsIzj8ShYsSP8l3MGgb0rGCLCUvRTv9kIxkte
	 t0VZKOUDGbmY6X4T3Gw7XtuUlrbLQGSBSRtT6ZMxixd1345kiDmZsRdQw7kjtVNwhX
	 yVbf1NZHIaJc+XOjIrrRoMJoY5ZgjxbvwdTadswH0wxvmeq8QB3Wt1/eZLhikw2cTA
	 a4/kqD8BG6/dlzLTUoTX8d7Y9YqGUyp6Uqr631ey4In10G1wo1cW7k33IEWmejIFHk
	 TOrqQvWrfH3PSsVDJzFucUAbvMtcO8eK/CiO0FoaiTl0NATRKo3vw3g+XN+zdK7puQ
	 Ev7oA1CQstKaQ==
Date: Fri, 23 Oct 2026 15:40:15 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <attjv8zOftf9Hlqe@localhost.localdomain>
References: <20261016095711.1364609-1-srikar@linux.ibm.com>
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
In-Reply-To: <20261016095711.1364609-1-srikar@linux.ibm.com>

Le Fri, Oct 16, 2026 at 03:26:40PM +0530, Srikar Dronamraju a écrit :
> Commit 21641bd9a7a7 ("lazy tlb: fix hotplug exit race with
> MMU_LAZY_TLB_SHOOTDOWN") moved the handling previously performed by
> idle_task_exit() into the scheduler CPU hotplug path using
> sched_force_init_mm().
> 
> As a result, idle_task_exit() is now an empty stub and the remaining
> architecture call sites have no effect.
> 
> Remove the calls to idle_task_exit() and the now unused stub.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
