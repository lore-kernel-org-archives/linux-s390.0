Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683C1FA267
	for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875261; cv=none; b=Q9p/3boV6ulgtZho/cPMSkWtJv7bozGBFOhc6p5X/Tbp1LGosJ9fOVCwzy7ImYZjTvJXcg+kFhPheVrf2Lz6Drj/VRu275UI13FjuD9Lsqt2Eu/9KBWHY3ZvedH/NNjjcecWaoX6GOR4kbE3VIIwBjMeHBSoE1LIkrJwiuX67/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875261; c=relaxed/simple;
	bh=RHEhXVP3YVzdMdHFgU/JZ+Hv1pf/FZEQT1bSdBQkrSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFH3GZRWS+hXHbqWcXiyZf4t3naH2nKJtPW0SYlWm0j695oszW/WcvYs1ZF2QIPNRjxVtGbaMmQ3xQ6fKhjrAfo1ae8fMZSslAtohmvJfHyeW7aZTxeMf3YLcQLBrLYgaHoK5hsoLJeHZ8ajHydXa0g5H0uXcpmoAIkEienzNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C27D12FC;
	Tue, 14 Jan 2025 09:21:27 -0800 (PST)
Received: from arm.com (e134078.arm.com [10.32.102.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6FEA3F673;
	Tue, 14 Jan 2025 09:20:55 -0800 (PST)
Date: Tue, 14 Jan 2025 17:20:52 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com,
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com,
	david@redhat.com, pbonzini@redhat.com, kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, vladimir.murzin@arm.com
Subject: Re: [kvm-unit-tests PATCH v1 5/5] configure: arm64: Make 'max' the
 default for --processor
Message-ID: <Z4ac9BcP2iHldv/L@arm.com>
References: <20250110135848.35465-1-alexandru.elisei@arm.com>
 <20250110135848.35465-6-alexandru.elisei@arm.com>
 <20250113-f6e1c55d5200410161aa61b5@orel>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-f6e1c55d5200410161aa61b5@orel>

Hi Drew,

On Mon, Jan 13, 2025 at 04:29:21PM +0100, Andrew Jones wrote:
> On Fri, Jan 10, 2025 at 01:58:48PM +0000, Alexandru Elisei wrote:
> > Newer architecture features are supported by qemu TCG on newer CPUs. When
> > writing a test for such architecture features, it is necessary to pass the
> > correct -cpu argument to qemu. Make it easier on users and test authors
> > alike by making 'max' the default value for --processor. The 'max' CPU
> > model contains all the features of the cortex-a57 CPU (the old default), so
> > no regression should be possible.
> > 
> > A side effect is that, by default, the compiler will not receive a -mcpu
> > argument for compiling the code. The expectation is that this is fine,
> > since support for -mcpu=$PROCESSOR has only been added for arm64 in the
> > last commit.
> > 
> > The default for arm (cortex-a15) has been kept unchanged, because passing
> > --processor=max will cause compilation to break. If the user wants the qemu
> > CPU model to be 'max', the user will also have to supply a suitable compile
> > CPU target via --cflags=-mcpu=<cpu> configure option.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  configure | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/configure b/configure
> > index 46964d36a7d8..3ab0ec208e10 100755
> > --- a/configure
> > +++ b/configure
> > @@ -14,7 +14,7 @@ function get_default_processor()
> >          default_processor="cortex-a15"
> >          ;;
> >      "arm64" | "aarch64")
> > -        default_processor="cortex-a57"
> > +        default_processor="max"
> >          ;;
> >      *)
> >          default_processor=$arch
> > -- 
> > 2.47.1
> >
> 
> Another reason to introduce a new parameter (qemu_cpu) is that we can also
> change arm32 to 'max', reducing divergence between arm32 and arm64.

That sounds very sensible, I'll do that for the next iteration.

Thanks,
Alex
