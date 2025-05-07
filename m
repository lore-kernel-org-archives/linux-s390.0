Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203C28C018
	for <linux-s390@vger.kernel.org>; Wed,  7 May 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637001; cv=none; b=RPB5EpxVnkZBxZMNaXoVBUJhiKG16sUWpYMzOOcpO7v2iDvRs3WfzHtboAZANI+PAEyvevCWnT9W0/FyMvPNsmUKMb5g6jqdqewO4S42GJinV5GvUSbCY+9QecLZHh2dddcZfi7E0QKp9POaIB6NFatZ6ltYMLjraAAHJhiYUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637001; c=relaxed/simple;
	bh=gNoNqejJTpaBc2iFQkEYth0mJCawNROFP9w7lkhILZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klk4xe1k55Ek6mjIGNTIc/QKx3BdZtf86dUBu1eWHPwP6K6Bgc/IsQi+vp9IwusygiFV0x+esujAa6BrwYy6cOllGLVqnDILj6x23q1YuC77fXIb+BNvxOT9FY1ruwodvWLUIFvINBaWI8FjGRZoYCdULWGETOYK60wa4wMMmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V6wxGd5l; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V6wxGd5l"
Date: Wed, 7 May 2025 18:56:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746636997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RqKe5S+kBJ5g+psmAnNRDncbPoduelQxWvprqMMN8Z0=;
	b=V6wxGd5lb06gQoaxfsbumMEc/Q5nPDxudOK3MIErovCU5r8uaDQVrtNYIVNLIglV/yEQ18
	lbnSOXsvJ4kaNeQ7VxExajSM+0ycBh4/Nu2k78IuUZv1jLqSf8vsY4KpITNz/pDEBw+O7I
	e9rURqI7OGGLmkoOnHfmne/5sCmIKvI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com, 
	pbonzini@redhat.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org, 
	oliver.upton@linux.dev, suzuki.poulose@arm.com, yuzenghui@huawei.com, joey.gouly@arm.com, 
	andre.przywara@arm.com
Subject: Re: [kvm-unit-tests PATCH v3 15/16] scripts: Add 'disabled_if' test
 definition parameter for kvmtool to use
Message-ID: <20250507-8159aa2cb83d6a5b44c810d3@orel>
References: <20250507151256.167769-1-alexandru.elisei@arm.com>
 <20250507151256.167769-16-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507151256.167769-16-alexandru.elisei@arm.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 07, 2025 at 04:12:55PM +0100, Alexandru Elisei wrote:
> The pci-test is qemu specific. Other tests perform migration, which
> isn't supported by kvmtool. In general, kvmtool is not as feature-rich
> as qemu, so add a new unittest parameter, 'disabled_if', that causes a
> test to be skipped if the condition evaluates to true.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> 
> This is what Drew said about the patch in the previous iteration [1]:
> 
> 'I like disabled_if because I like the lambda-like thing it's doing, but I
> wonder if it wouldn't be better to make TARGET a first class citizen by
> adding a 'targets' unittest parameter which allows listing all targets the
> test can run on [..]
> 
> If targets isn't present then the default is only qemu.'
> 
> Like I've said on the cover letter, I think making qemu the default (if
> 'targets' isn't specified in the test definition) will mean that new tests
> will not run with kvmtool. I was thinking something along the lines
> 'excluded_targets', with the default (when left unspecified) being that the
> tests run with all the vmms that the architecture support (or, to put it
> another way, no vmms are excluded).
> 
> Or we could go with 'targets' and say that when left empty it means 'all
> the vmms that the architecture supports' - though in my opinion this
> semantic is somewhat better conveyed with the name 'excluded_targets'.

excluded_targets sounds good, but disabled_if is growing on me. So, unless
you or others also prefer excluded_targets, then

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

Thanks,
drew
