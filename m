Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB183B3BE9;
	Fri,  3 Jul 2026 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070796; cv=none; b=UaYmeMYFafyna1IWBfVjBS3wrVhgqfPEl2V8CHNdDvM3VPLQz/z5OVSUCBlkHTydP2ONnjwOu3yso4FUA2BOe9GtPNE3xffA4NRXxlwzp34jFcIfP92IgNDjqB6opa8uPblwE5jbiqe5XJMVD5CNeiwkT5Tmv/UkC6QPaUpBM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070796; c=relaxed/simple;
	bh=XKVidnSNN3InnpyZdVJSXMV5TalS8iCBJQsbAHe4kT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeAsE6HOixfA4hCymk7/PtiEEyn7jEXv8Bl2DghMAXuFMdZtFCqEzTTcJeeSvLiiMeV4PLk1EB6eff0dcWWv/vxythH9pgM6NbMGfalU2Ho4WcB/PEtthu83oLopp+bKDYasK2jBiQasd5i99Su2wUyRmikDxXVzVJeILVqcUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jbJkBVOT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jbJkBVOT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MPQJV7b7kJxx5txnyZHmL5S4FKlfiNVgVgnkVZMZ+6g=; b=jbJkBVOT/shtiot9Fc2pimpU1C
	HwNC+VKHJMncmc41AF6pUNHHSHoEGiATR5ncPKDf0gGLbv+67XpsMWxpomqvnEWns2uuBP/NddLZt
	steywxZ4WKc2RcW1NM+uxAnQdAAw132ojGrke1r7Pofyl1JkngSK/ZT8m/vnNnUJ/rn4JTxBKp4i0
	U/ASGh0yXX0fXF6pY9FpYaAqDi7txgXPudLUNWL3sk5/nxO8P6rEIu7ZbmelZsUVKfX0VljoEPfZm
	Xs/7RlQubEXJnZR7hTst9g4bBclCh3APcrjBGKulmX625kzp3ZyHOw+tSbkdVvEtqZOW0J1c9UbOk
	HiJJGH8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfa9Z-0000000A4v3-364Y;
	Fri, 03 Jul 2026 09:25:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7451030035C; Fri, 03 Jul 2026 11:25:44 +0200 (CEST)
Date: Fri, 3 Jul 2026 11:25:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
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
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Zong Li <zong.li@sifive.com>, Nam Cao <namcao@linutronix.de>,
	Deepak Gupta <debug@rivosinc.com>,
	Lukas Gerlach <lukas.gerlach@cispa.de>,
	Rui Qi <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
Message-ID: <20260703092544.GB651302@noisy.programming.kicks-ass.net>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
 <87h5mhnjsr.ffs@fw13>
 <yt9dwlvca8rn.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dwlvca8rn.fsf@linux.ibm.com>

On Fri, Jul 03, 2026 at 08:26:36AM +0200, Sven Schnelle wrote:

> The difference between x86 and s390 is that on s390, regs->gprs[2] is
> used for both the syscall number and the syscall return value.
> That was a design mistake early in the begin about 25 years ago, but
> it's ABI now, so it cannot be changed.
> 
> When seccomp decides to skip a syscall, it write a return value into
> regs->gprs[2]. When syscall_enter_from_user_mode_work() returns, it
> returns this number. If it's negative all is good - the 'if (likely(nr <
> NR_syscalls))' conditiion would just catch it and skip the syscall.

You do have regs->orig_gpr2; I didn't fully track its usage, but can't
you treat that as the syscall nr and always consider regs->gprs[2] as the
return value?
