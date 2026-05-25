Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472A39B484;
	Mon, 25 May 2026 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690102; cv=none; b=qZulDSlvyL4Be0gWebfGflFTTDUiRhgV69FCgpusuubwouHwC1FvnHHqC3oXkbasu+q90VgmxMIGmdRNg32W4CwlIsYG5Gn6MQeKGKe2798jYI1tjZGwBmfdVygloEFGlrD8BOL2l3LA51yHvPORMvwrzqlHvWcLb/8yVW0Ve0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690102; c=relaxed/simple;
	bh=QJTZQygwTy0lLL8W987LoEiMdtcM3DrC/jHdk30EsAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nbqvO+5pUSFK8j3TXLT7IaR16Jabh4FS55xIlhe/tzetCtEvB7fnVu/IGm15KoOALpjDwu+li2aNQUSn/KKOI2JMsBu1vzTWVd3mRmjn4PtREcltmZBpjQA45QJxoFu4lKmG19aS2h7YchXE8k/S0j0D26izZg3eGiA1jH4z3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q6R84yEr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q6R84yEr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=u6zKl9qnP1hXczaaMGz7ilm2seNJlSk+ObSn3+7a228=; b=Q6R84yErpMKmdghfAxPpEVTgXs
	ab/TkoPdqEtIzV6x3bBxmGJncObuVgjtqyQ3gNdFNG7yuHe/rbMaJ9RTuh67b+OtVcjSgxaoFJqtu
	1JTv/UhhwKAx7NuDaTobbogBSpwp/o3B8QyfRc2zXsT1KKKOKTQBkH0iFe6c/ih8/dA55uwpt+90X
	rXNsdb8u+fnhCutZOpwEGp8lVBVrANCGsgxoMPw6o1m7tG2857HRKojm+UcY/083Kxg9Zp3zguAfx
	qDlrtsDt2bUnvzFtsdd0976FboRKYNUjH4s9GYpquer8CePhq5I/ekgdAyMdXyKVPCkK5+XMzmMv8
	pw6UUTaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROgv-0000000GPAI-3Bil;
	Mon, 25 May 2026 06:21:33 +0000
Date: Sun, 24 May 2026 23:21:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
	mripard@kernel.org, sumit.semwal@linaro.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <ahPqbfH54R3JJyaV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522225853.878411-1-tjmercier@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> module") the system dma-buf heaps can be built as a module. The
> system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> but those functions are not exported on powerpc. This can result in a
> build error like:

I'd much rather revert the above commit.  Yes, x86 has exported these
since 2017, but that's a really bad idea, and we should fix it instead
of spreading the export.

Setting memory decrypted is a dangerous operations and should only
be available to core code.  We should have various allocators for
decrypted code, but not export the functionality to random code.

