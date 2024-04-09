Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109D84D02
	for <linux-s390@vger.kernel.org>; Tue,  9 Apr 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661316; cv=none; b=gzDujLNjhc90KzPA+mLMH8GGQlCX5SlVTH6TKNmiQKEkonRb5qhL4dtM7MR5+S0Wa3QzZySSBcGFShZaLaDA69nHFWWkCuxSxEif8A9JjbpGSFZon48MBPrfxPoXvrWPW7WZQa6ZqsYdTxNwvrU2KHX6GHZHfwWM0SFAxdXzoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661316; c=relaxed/simple;
	bh=++hTOCRPz5YoxqYCSkwLvqB3M5X+cC6Ji1XngwxiU/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4mJZ70aXfZHK1TixnOPh5rWNTEWilckcBXuEfQ2cfkkFh3cvfkwPicGFXEyY3ycgbSFk+2BPkZgsYE2yiYr+98/7xpfghCtbDdRUMC8U78ysCj8+HQx9B82DfOA5WwKSkWhBGow53A6+fUv4L2dcV9eNKzoyMJ2UX0DvmWtZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57168C433F1;
	Tue,  9 Apr 2024 11:15:11 +0000 (UTC)
Date: Tue, 9 Apr 2024 12:15:09 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: akpm@linux-foundation.org, Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	surenb@google.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/7] arm64: mm: accelerate pagefault when
 VM_FAULT_BADACCESS
Message-ID: <ZhUjPZj5dij8JM9g@arm.com>
References: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
 <20240403083805.1818160-3-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403083805.1818160-3-wangkefeng.wang@huawei.com>

On Wed, Apr 03, 2024 at 04:38:00PM +0800, Kefeng Wang wrote:
> The vm_flags of vma already checked under per-VMA lock, if it is a
> bad access, directly set fault to VM_FAULT_BADACCESS and handle error,
> no need to retry with mmap_lock again, the latency time reduces 34% in
> 'lat_sig -P 1 prot lat_sig' from lmbench testcase.
> 
> Since the page faut is handled under per-VMA lock, count it as a vma lock
> event with VMA_LOCK_SUCCESS.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
