Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1643744D696;
	Wed,  6 May 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081334; cv=none; b=Nu+nrx1J866bjIv5hOA1LihfCkV9KLy7Ywpoj9Jic3kqpuyffBUmWYKPWm70PdyVzTjJ8YjUKzbKOAWySjg8K5/vi4XpYRVA/FlJV1BQn3nc3aLTdWb1oL3kaSqzoXQ2aqSxSl1xTPsR1MLAUbeWA5iZct+v/WkVj8IPm1slMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081334; c=relaxed/simple;
	bh=GIso8zzP6WAZvBCfiOiq2OM7xb6XbVZS+Ipq3OD55sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daFm5Njc+MRS5hQ+hDjtpXnJyKgsgCjc/VgwKVmI/fnqu67vVPZiX7dzxCrnpGjCnhz985jiExfLqArILUSS2pV/USEL4mK7inWHsH5fupgcP7U6Ck6hWaw2b3AQFuuzYaMM2y6Khc9Qgby4N1p6Y0aen1iGd8A03SGDIWg00+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BtEvq0hO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BtEvq0hO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C8961A00;
	Wed,  6 May 2026 08:28:47 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 471923F7B4;
	Wed,  6 May 2026 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778081332; bh=GIso8zzP6WAZvBCfiOiq2OM7xb6XbVZS+Ipq3OD55sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BtEvq0hOdFvxUgOxCi2MB69loUyTEabOCf0BaPHD2hMrEuCGOXgUv/70AUtuV964m
	 aeCZZ0B7oQV/nD37CLaFZFnrdPqAG/fEOiVGTZiVZHq9BhO/sTZCn86wqVIkBBfO8l
	 AuSF/N1qkMfY3ghKS4w3SHk8JlixjHj4Z6b+0hd0=
Date: Wed, 6 May 2026 16:28:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v4 2/8] arm64/runtime-const: Use
 aarch64_insn_patch_text_nosync() for patching
Message-ID: <afteLyir2cGUbEi_@arm.com>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
 <20260430094730.31624-3-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430094730.31624-3-kprateek.nayak@amd.com>

On Thu, Apr 30, 2026 at 09:47:24AM +0000, K Prateek Nayak wrote:
> The current scheme to directly patch the kernel text for runtime
> constants runs into the following issue with futex adapted to using
> runtime constants on arm64:
> 
>   Unable to handle kernel write to read-only memory at virtual address ...
> 
> The pc points to the *p assignment in the following call chain:
> 
>   futex_init()
>     runtime_const_init(shift, __futex_shift)
>       __runtime_fixup_shift()
>         *p = cpu_to_le32(insn);
> 
> which suggests that core_initcall() is too late to patch the kernel text
> directly unlike the "d_hash_shift" which is initialized during
> vfs_caches_init_early() before the protections are in place.
> 
> Use aarch64_insn_patch_text_nosync() to patch the runtime constants
> instead of doing it directly to allow runtime_const_init() slightly
> later into the boot.
> 
> Since aarch64_insn_patch_text_nosync() calls caches_clean_inval_pou()
> internally, __runtime_fixup_caches() ends up being redundant.
> runtime_const_init() are rare and the overheads of multiple calls to
> caches_clean_inval_pou() instead of batching them together should be
> negligible in practice.
> 
> The cpu_to_le32() conversion of instruction isn't necessary since it is
> handled later in the aarch64_insn_patch_text_nosync() call-chain:
> 
>   aarch64_insn_patch_text_nosync(addr, insn)
>     aarch64_insn_write(addr, insn)
>       __aarch64_insn_write(addr, cpu_to_le32(insn))
> 
> Sashiko noted that aarch64_insn_patch_text_nosync() does not expect a
> lm_alias() address and Catalin suggested it is safe to drop the
> lm_alias() for runtime patching since the kernel text is readable. The
> address passed to fixup function is interpreted as a __le32 and
> dereferenced as is to read the opcode at the patch site.
> 
> No functional changes are intended.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
