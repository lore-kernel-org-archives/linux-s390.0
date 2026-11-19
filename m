Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074095;
	b=2P2O/S7/ReQwg2UXb+2wxLf1q0tthWtiBfrZauA2nOynrthCD4t4lYfIhG+ZpgONJOOI
	 LHke/wb5XlmOJ9OjPSSObV+ZoOSY1k5QqDlaVcqmrNxk5cteu6nHYOuAHlQdO1zSMsNSy
	 GcEQ5286LDnYp0D4N1ccEzZnyLfbgkE1lz+RzHYGFBURKGPMBPFIt3YAhA/MTyE9VqBwA
	 SbIRoaa17oLtlyAUOVpi+DmxBRHLlb5BNiq1KD29POC5D+OTHqYt8QsfQeib80AW487Lt
	 mOaB6KFcPunidOK6gnCNrpb/yLOgoC9ceN1/QLzYGpL5U8ElVEYQFCJVNwaAvbX5cWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074095;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hNd5MCBb+RwQDRLrwFjdA5miwBKz7JlHYmdVmb0QLqo=;
	b=0eZWjtJZrz1HNmT8aO3leDhYEZXTQZqraMOITI25NNsmOZRSnxuFvKl0jXcchh8FLg40
	 roEU17CVmVCdeG3AVfslBw2v3dFwTxGUjEOcu6WQZIl+jBQAaFVhUa1FBOt7R9qSQESBS
	 SpbIkhwL+jj2OcIETlz3L8Oj4LO8wtGrYbhVvRaIKmE0DF3qcDXQR/lvBPJpvb8Et2gp8
	 NYIOPKkAsaFnO5wDaLS9Jkx69IOCjyrKUoKaJCLN7lT3ocNQI6fbV4s9GIsbuNgPN6uel
	 ru+QfVIryM2synSHPgJ4hKRqw022s45E35nQ1+8RlTyX+OZ7LkSWuxOecXa1VnoLkbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jRpAWJeD;
	arc=none smtp.remote-ip=91.218.175.157
Received: from mta0.migadu.com (out-157.mta0.migadu.com [91.218.175.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD02606A324
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 07:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD02606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jRpAWJeD
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6tO+X4PnRnD+Jk0uYi9e+cJ5+jxuZiQPrphEOsBPyUs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795074090; v=1; x=1795678890;
 b=jRpAWJeDfhzRjp0tMgYsPxG27OVP/tOWcJ/LQhjQ73YyguUVzBJIk9e6igo5ThSrN/dX9FMW
 bZra7IUn8I/rAqXJ0NlITYqlsau1cJMj9jUX1QQPXNjf97NVYMKnp1K1+v+f+gbq9xnGbaFV9/k
 QXdNQC1HwUPojy675ONU9hn0=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id f0d3d04c8dc3375f;
	Thu, 19 Nov 2026 07:41:30 +0000
X-Mizu-Trace-ID: f0d3d04c8dc3375f
X-Migadu-Flow: FLOW_OUT
Date: Thu, 19 Nov 2026 15:41:24 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
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
Message-ID: <av6oJBDv2fAaWSog@fedora>
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

On 11/19/26 at 08:16am, Mike Rapoport (Microsoft) wrote:
> kernel/Kconfig.kexec is not matched by the KEXEC entry, so
> get_maintainer.pl does not report kexec maintainers for changes in that
> file.
> 
> Add it to the KEXEC entry.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Baoquan He <baoquan.he@linux.dev>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d738990161bd0..c61a1f0ad330e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14782,6 +14782,7 @@ W:	http://kernel.org/pub/linux/utils/kernel/kexec/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>  F:	include/linux/kexec.h
>  F:	include/uapi/linux/kexec.h
> +F:	kernel/Kconfig.kexec
>  F:	kernel/kexec*
>  
>  KEXEC HANDOVER (KHO)
> 
> -- 
> 2.53.0
> 
