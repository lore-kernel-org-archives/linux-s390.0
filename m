Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461599;
	b=VwvO6LTfrCX7L/ZiGrRUUOGLT0AkQybZ4ufSxUCAkZEsjNPa88NL/BOf/PwzgNTvaK8k
	 c/c1oTzcOD7C+MDhg+cbzWQjUV5aErkSQUfyaCLRUDT7Cvim57fbPja2dWwNcLDF5cW44
	 iDTrf3zMVykOl6ljolYES3cBKNC3C564tyXyt+XdE+6Xvec953eyIio1wzVJDt5WNVdL8
	 mOXbyjy3V+hjJx2vSID3mTV5pm42ML3lvCHGfCRPq2oatFjznXn7U9QRhiAgGTVSPCe+e
	 pmtjxnak6MF15ytIM567hhUMECeDAjZb6mBTT592hIGwOo1diB4ARuCRD4k1UPAureg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461599;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=YbFSS6dJsC7jMPW/wNXp8H44yQ2FcFRYnsa9hFAzYJM=;
	b=QZbJJKXe3Oohb5FQ8y8RW9+KopFLsctbP7y2sLghS2tqmbpBjZp3gsJFuDFd9NZJ1Jx8
	 fSZH52SBK4iUP2ZE8d2ICHNGYWqllGGa0bvLYvNjMQ9I1YIT1VjvWnmBY164c5uJ6vAiv
	 fcjX70QzXZyavb+vNqKDFxPS9uFUPluVPeSRI2hrTu/yHzPVwCumeeIPgWU8dVYB4hi+q
	 suz7IUXayVvVjODwtYkOOBS0GDV6cwLSJk2R8Bft250URolVx5UDm6Q6H3kaGPnPGWj2T
	 oYLlZCZj37WlapDkUhjKh8LNq+xaC8dLn12l0Bok+q/xmfwNoop/oAyqyalWsWIxudQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	dkim=pass header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=z5VxCKWt;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED53606A31A;
	Mon, 23 Nov 2026 19:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED53606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=z5VxCKWt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YbFSS6dJsC7jMPW/wNXp8H44yQ2FcFRYnsa9hFAzYJM=; t=1795461598; x=1796325598; 
	b=z5VxCKWtGCXsqdV3G5o7mzM4/ElDJ0LDR2Uaw/We/hWQ6iZt0YL4OYPh+Cfu5RskK5qKXCk+6QS
	sVOri+nUP4EPq5EIxrf+sUiOxqdYh+rQUuFSDYJFC6T0R3fhk9pfS+gKa+w+vEM2aObWZ3N92YcbP
	jygaybtAIrkA/tPUQAc/jssn7+k+dbjp/OEFRu8OFG91CPNHwd9JEXvcBcrN5dQDqZjzfUVicdWPQ
	outbdoCcrMPdCPurg9cXjt6p83wI5fIgDwJFJ1ltq1qdad51JLZymQiHopsGxOhhCvTtsO3kkCcOC
	FdZcgi8zYN0H1yr4vffjNaznGmIkzETpAyzw==;
Received: from [49.207.211.146] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1xVZZR-006Yni-DK;
	Mon, 23 Nov 2026 14:19:21 -0500
Date: Tue, 24 Nov 2026 00:49:07 +0530
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Paul Walmsley <pjw@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in
 Kconfig.kexec
Message-ID: <awSRq5Cn84BHelio@csail.mit.edu>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
 <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>

On Thu, Nov 19, 2026 at 08:16:58AM +0200, Mike Rapoport (Microsoft) wrote:
> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
> 
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
> 
> Selection conditions are preserved, so there is no functional change.
> 
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed each code movement for correctness and also reasoned through
why the ARCH_SELECTS_* entries were left untouched in this series (as
they don't yield any consolidation benefits towards Kconfig.kexec).

Reviewed-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>

Regards,
Srivatsa
