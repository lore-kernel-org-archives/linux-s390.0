Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44247C6CF
	for <linux-s390@vger.kernel.org>; Thu, 29 Feb 2024 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207651; cv=none; b=TgfDkWZ8B6eWnGiduKlFs2jVWve6EoUzd/TMPtxb9ByG2mjMWCVqJ6OC1XlhmVKvt1hHdnZ31yWqIYdbkRZX6V9zi9VKZbH4d489JKhdmrdx7wQ3HwDYR2QuFXDQi2nYnmMGYvw3+5HGAfsX6pR7QBVMKankYdmYFsNBdUJxxoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207651; c=relaxed/simple;
	bh=j2KohrJsAiMYdiWldZhwbb4HlZYHVmHHQtr4I7XkGBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5K9aHFCbM/aUeEPBtDfU7ht7D0Mv0m2dCBsjt/BvMY3Cwo2HUvLOzLfmTzbFDV1NhNuiuitJvRqsgIQmWVSZC0c3BkcDZqLONubKq39LhTME1/dVAbi7c+qWOpIjr3Q2QusMcRQXR7nAremYOIdYRmdnLlwgPnncIHCL+WIjRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UKQXxJUY; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UKQXxJUY"
Date: Thu, 29 Feb 2024 12:54:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709207648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRQFyPvY8FzfiTI6Lrcxrny9e2wWpcl8DCC9vctNmI8=;
	b=UKQXxJUYc46ZLK+ZyhJkOcUg7zV8d2domzB+H8mVZ5fSkRQ9UVh4pEC03ilpi6Xb7MFKCt
	TXem02Z9MWLkn7NyZKKbQKS5wTnaEdARZYCQQcFrDHMafZcQJ8iC3/XWQINP8o8AiqMfy6
	CmLGcFI9P8Bw9WDCPlaaL6IcbpCzg/w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, lvivier@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com
Subject: Re: [kvm-unit-tests PATCH 04/13] treewide: lib/stack: Make
 base_address arch specific
Message-ID: <20240229-edee610a9d15912f1f349ea0@orel>
References: <20240228150416.248948-15-andrew.jones@linux.dev>
 <20240228150416.248948-19-andrew.jones@linux.dev>
 <CZH98WKJY6NT.5D53XGR31X22@wheely>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZH98WKJY6NT.5D53XGR31X22@wheely>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 29, 2024 at 01:49:58PM +1000, Nicholas Piggin wrote:
> On Thu Feb 29, 2024 at 1:04 AM AEST, Andrew Jones wrote:
> > Calculating the offset of an address is image specific, which is
> > architecture specific. Until now, all architectures and architecture
> > configurations which select CONFIG_RELOC were able to subtract
> > _etext, but the EFI configuration of riscv cannot (it must subtract
> > ImageBase). Make this function architecture specific, since the
> > architecture's image layout already is.
> 
> arch_base_address()?

Yeah, I should have added that prefix.

> 
> How about a default implementation unlesss HAVE_ARCH_BASE_ADDRESS?

We have a default implementation for !CONFIG_RELOC, but if an arch
selects RELOC it must have an implementation of base_address(), so
I wouldn't introduce a HAVE_ARCH_BASE_ADDRESS type of config since
it would just always be selected when RELOC is selected. It occurred
to me after posting that I probably should have just made the current
base_address() implementation weak and then only introduced the new
riscv one. I'll do that for v2.

Thanks,
drew
