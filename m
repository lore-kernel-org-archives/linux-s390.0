Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD5142E9D
	for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043050; cv=none; b=sBmXSKJJcxi7LV2GGUE0GmqCPZa1kf7Xf3m4U3tfQ8XZHeQYJEg+HLh2QXBLZyvNVooDajIOBltMrC6Qj+CRjS8ZZnhVaRMhmz7RyFzElpkXP2/8ZrUoNhTB58spzwFnhZEdLqQM/hh1WPEeuQVsbCsA3FIFH8/R4V+BIhyuSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043050; c=relaxed/simple;
	bh=wmPNf1tPTS1FEKpH/lAzR4g+Ek+a2/MNrQx1KRfjAwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3oJRU4xweAOOLk3mNmGipzRMJViOmxEOjCv4ftwN+KWdb8o/O2TaxiNEVEEpGicCmi1LZSVaAzkHXlc0ZKmvtt6lXehf3CGlnW9WiShHfNxghbI9hHJYzqZTBBgeYE0d3VvAOADSCHXTtlb20xiEqYbHKshmCjm4ORw9tDz/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RZFxghiL; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RZFxghiL"
Date: Wed, 11 Sep 2024 10:24:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726043047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1TI8bsOlziGCU+hlwwiFofGLl9oRjkXX9zj1uFoMWU=;
	b=RZFxghiLIKxKCgLnibfFH4ohiv33HX3hbHVAGyIE8JlT9bIGx4BVzkUhVwpdBmmzi5vbnx
	FXAdcQ+RcA1B0CKKjMtElVrxXAM+19onH2byFb5ATKCVdXi3TiCVL7kt+yNLzMeWmiseys
	DJ3Cud9yYsRK1+D+SAwjKYJhn87Te1Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, nrb@linux.ibm.com, atishp@rivosinc.com, 
	cade.richard@berkeley.edu, jamestiotio@gmail.com
Subject: Re: [kvm-unit-tests PATCH v2 3/4] configure: Support cross compiling
 with clang
Message-ID: <20240911-99a010a84e453f4362566c6b@orel>
References: <20240904105020.1179006-6-andrew.jones@linux.dev>
 <20240904105020.1179006-9-andrew.jones@linux.dev>
 <D430ZV4FP2GE.3B7VE2I37RPXX@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D430ZV4FP2GE.3B7VE2I37RPXX@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 11, 2024 at 10:24:34AM GMT, Nicholas Piggin wrote:
> On Wed Sep 4, 2024 at 8:50 PM AEST, Andrew Jones wrote:
> > When a user specifies the compiler with --cc assume it's already
> > fully named, even if the user also specifies a cross-prefix. This
> > allows clang to be selected for the compiler, which doesn't use
> > prefixes, but also still provide a cross prefix for binutils. If
> > a user needs a prefix on the compiler that they specify with --cc,
> > then they'll just have to specify it with the prefix prepended.
> 
> Makes sense.
> 
> > Also ensure user provided cflags are used when testing the compiler,
> > since the flags may drastically change behavior, such as the --target
> > flag for clang.
> 
> Could be a separate patch but no big deal.
> 
> >
> > With these changes it's possible to cross compile for riscv with
> > clang after configuring with
> >
> >  ./configure --arch=riscv64 --cc=clang --cflags='--target=riscv64' \
> >              --cross-prefix=riscv64-linux-gnu-
> 
> Nice. Perhaps add a recipe to README?

Sure.

> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
drew
