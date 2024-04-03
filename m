Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4415359C
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168691; cv=none; b=WaU/uB0tQa8wb88FWu9ZDXv1k5Z2pclQyrDBICsJIt1aPdNQRuZXk/uTSamwtwNfOSnAQ4Fn+G2TQ1ks3TJgHtnXIX3p/lErJnrdnVchF2qbbwWS4NEQ68EvOYTqSrZD6GW/j8WmYdJXdISKyG3kcKYV0WWWVQGhQO4pE8l0LCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168691; c=relaxed/simple;
	bh=kb2AGKqeF/qglwiuUxGNqH/NwW+SlCPQ8B/AA25pDd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmwEX+qRl11Rv+JCZetIsfAEn7x9iixp4Zb+j9ZBNbWTvyRdbxc5H14Kj7zKV5ZHsEaytFhEHhCokHVMaMRKFrrImX+Tu9o/2+1ol0ne0TPk7PgRewVvezg94s8lrYy32c/CQaJZq03HFzUEK68k1Cdrj8GR7W/fXCjyTYPglFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F185C43394;
	Wed,  3 Apr 2024 18:24:45 +0000 (UTC)
Date: Wed, 3 Apr 2024 19:24:44 +0100
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
	surenb@google.com
Subject: Re: [PATCH 1/7] arm64: mm: cleanup __do_page_fault()
Message-ID: <Zg2e7FhLhCJDQzcY@arm.com>
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com>
 <20240402075142.196265-2-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402075142.196265-2-wangkefeng.wang@huawei.com>

On Tue, Apr 02, 2024 at 03:51:36PM +0800, Kefeng Wang wrote:
> The __do_page_fault() only check vma->flags and call handle_mm_fault(),
> and only called by do_page_fault(), let's squash it into do_page_fault()
> to cleanup code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
