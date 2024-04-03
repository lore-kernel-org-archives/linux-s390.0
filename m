Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9457154BE2
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177140; cv=none; b=P+hENDA/FLCPD4oTX7xTgGDFDmTnoSvEqyPKb+svUAAdZvCD+mMgdV6s54GEAnOCjDL1R9Mrdfb6IZve2Ovr+c0rWJ2jiV8H0sG9CEPcTJQwkaYbinn4qLgGNzORBFhlGxwT6PoJ7PlNNga66UAck6BzLwFZVBPolQs3kZn2rMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177140; c=relaxed/simple;
	bh=yNRma02riMpShZw5OlGNXboXuC4yjz6G1J9H55luJl0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fhnow+RAzRYEQiTrzFHo9N4/RfOqPkzYE4m0ntJXRZ8nrgm7dZATg9JuExUyblkxXjHjXxVlefQ8+OQ4OUgKb0BjAUhEU4dDBESFAkBrB5v47kb+BZLtGaN3yqCmeenkzlQinR00Sp+iHE3jWAGx63lO2WR7hIMO9DljaJ4NyuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WbDgetig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WbDgetig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8F4C433F1;
	Wed,  3 Apr 2024 20:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712177140;
	bh=yNRma02riMpShZw5OlGNXboXuC4yjz6G1J9H55luJl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WbDgetigVfP4aw5GQwkC4/+qzJgMfkCRZ/CwVfM+DoWhVsV2cSyKM+d0KjSYmohjG
	 D9MNWSGnvMyDqphojTexHK6yncBn+D75NAjadehGe185l4ywdlwBA4CRdqXEgUAQpQ
	 LFHfUu8b17Q+Go/GjBQs5pUYIY0N53InUiC/aUt8=
Date: Wed, 3 Apr 2024 13:45:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <surenb@google.com>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2 0/7] arch/mm/fault: accelerate pagefault when
 badaccess
Message-Id: <20240403134539.fde3a6c594f2d88409be30ed@linux-foundation.org>
In-Reply-To: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
References: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 16:37:58 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> After VMA lock-based page fault handling enabled, if bad access met
> under per-vma lock, it will fallback to mmap_lock-based handling,
> so it leads to unnessary mmap lock and vma find again. A test from
> lmbench shows 34% improve after this changes on arm64,
> 
>   lat_sig -P 1 prot lat_sig 0.29194 -> 0.19198
> 
> Only build test on other archs except arm64.

Thanks.  So we now want a bunch of architectures to runtime test this.  Do
we have a selftest in place which will adequately do this?
