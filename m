Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461386;
	b=c/AQ3/sY4Bbj4lzcmITfDWNVgxFkTkXtLZXIP745Iwkbpw+WQ6QwcnjOIpmcBn8UB2SM
	 s7ywgexufMgZ8PRdmwtKcVH/eleQfIkaMPj696X6+GgKZUE6aAXCbDUisFhqnDzUxGyKr
	 Nvg+x232G8KStFltNc8uHxLOKUiiMPoGH2ihyqUf/aBTUBkP9BtohOIXS+Ob4fd7BDmoS
	 G5VmGmPmgsonxYIxnAKkX9YJ5AsRzVMH0NxdPW6wKKJjtIAK9s7cC2ZCZnPfm41N0q/Z2
	 VIiF33vdf15uejY2yT+eJVYpocl4V9E8Hw+6pd9FMxX9wUH1N1YCYnwuDht3ae7BWYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461386;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=bht87HU90ydQuqNwMWxnyUlGx5v3MiB0Rcrd/VnWTho=;
	b=qPyNmurokI5zqSYgZBM7OQC8IXFX9230AEGZsk+ylxK0JfenQZQtbk3G6Wu7amG0yf7F
	 wlHd+blocqF3XnezwEk4RylyuY3pKGJzo8zyW4eH16fQd44MNod0p1lb/UV+YSfkKH62h
	 tMx9QAWHxz9/08yPhWY60auyj+WnsS0ZYaKlaleYTs7ujPTBvO4UqyMryO5/frd4hXYr2
	 xte6zD8BXgXaZEc/PPhRmk56Qp8h2tpjQFgI38fCg68C8ArIhvgSTizehQukV7HELtjWs
	 is7dORijhJb3mRP8rKpK5rtPZoT8eEflUvVGxhHpLDmOTL0J2s4V7TOGO+rbmXqr5Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	dkim=pass header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=Acw6sZ0+;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C754606A31A;
	Mon, 23 Nov 2026 19:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C754606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=Acw6sZ0+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bht87HU90ydQuqNwMWxnyUlGx5v3MiB0Rcrd/VnWTho=; t=1795461386; x=1796325386; 
	b=Acw6sZ0+cO2Ay2bPeImF8UCrD7k4IaKB9SkFD4k3A5bqiEOtsQdw8szhOcuZkKLpdpkI9tyvf/O
	sAjY509ctLaHfEO32Q72Z0RNxwhg/W+wzkyF9Swz3EU9/Ox873Jw/Tn7zUhX51YzAH2HXlUwaqsAl
	U9KpwFRhA+UUiEChXmxBg+FU59UhoW8Bj94hwC5PKtzDXdLt7WxCU2om/kkgwKjM6VCFxfd/pu5+e
	xv6OyjcQnSMzLg3dqX8W0y7648iYChADWoYkI3YREXuzE9nunpo+zrw6CZ6nJJig4j28x3uufHiJ1
	Mi0Dl39OpU8/32w/3/tytRNeMZjvxCeuO4RA==;
Received: from [49.207.211.146] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1xVZVX-006Xqr-OR;
	Mon, 23 Nov 2026 14:15:20 -0500
Date: Tue, 24 Nov 2026 00:45:01 +0530
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
Subject: Re: [PATCH 1/2] MAINTAINERS: add kernel/Kconfig.kexec to KEXEC
Message-ID: <awSQtauit5QObOPQ@csail.mit.edu>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
 <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>
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
In-Reply-To: <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>

On Thu, Nov 19, 2026 at 08:16:57AM +0200, Mike Rapoport (Microsoft) wrote:
> kernel/Kconfig.kexec is not matched by the KEXEC entry, so
> get_maintainer.pl does not report kexec maintainers for changes in that
> file.
> 
> Add it to the KEXEC entry.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>

In the spirit of finding any other misses in listing out relevant
files under the kexec and crash entries in MAINTAINERS, I found a few
other files that need to be added (unrelated to the Kconfig.kexec
which is the focus of your current patchset). I'm planning to send
a follow-up series to address that.

Regards,
Srivatsa
