Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5622512FF;
	Fri, 27 Feb 2026 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202301; cv=none; b=HcHZW442/CZwG3mUTd5XfyKTNdWAzeUNre2GA8q+Ahfa3FbmOdCfV4W+K3pXvMAbp7kES7PJYfnzDFo04BXYSRz9xTA3wMyEPZpx1VoHy8Lz+72RqhHif7CLsZZ0/G96cXfMjQuaP2QRuv2VOwLWy3/jPBJINT/rV5lvwRbyoiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202301; c=relaxed/simple;
	bh=/p/64cG0qA9cMUBvNd7UIvkQU4I//dh8aa8imOA5Tlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAPQ9G1Z8jWMtce7ja/t7SazAVfUIEiwwlVP32OcTPUpRmFGpV3l2g5pcM2iMWRbnGE1dvGbj6QPCZe1Xdtrgl3QkBP0b+Eb6yR4tx18jKFt9iGa0DtIr2wnrF2YNLrEUbrOdY+TtAmzLMt8g2+sp1xrhss3qUhc6Iw94YtQqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eFgHsKQ+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eFgHsKQ+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o6ZWpyn/MjJkdaBZy6gODZpYyrBchUC+wEMbuu42Faw=; b=eFgHsKQ+KSgZZob+IdOva2FCfE
	kLQjynnpuGU37l8q2Oi/PRPjQ5ANV8aqZ1ql627/w7R7dhGHjJAqpZlmjkYgUTFUlaqfdZCnysmcA
	X8aSt8kWlfzbJ6Q+KFAEOlFWxBInredcuLjvKEmm3mdeIdVWoNW5XaYUDovc2UCVv+jNoAYbJ46Wr
	TLjSa0l/5GVtAhjpu+lf/7hmyNebW/a2EXlmnh8o2dFWjpIwJBXmfaJOheM6GEY15qbGiougaX/pz
	QYsT1e9dM5SR/w2q7Vak/puzsLgBTmqQI6E5yqjKXdW03Bwtf06v9pLFpT6HnW17WZQAoCyDsY2v9
	KcHYLOHg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvym0-00000004hAM-2M1y;
	Fri, 27 Feb 2026 14:24:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6FDB4300CDE; Fri, 27 Feb 2026 15:24:55 +0100 (CET)
Date: Fri, 27 Feb 2026 15:24:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/25] xor: assert that xor_blocks is not called from
 interrupt context
Message-ID: <20260227142455.GG1282955@noisy.programming.kicks-ass.net>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-2-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:13AM -0800, Christoph Hellwig wrote:
> Most of the optimized xor_blocks versions require FPU/vector registers,
> which generally are not supported in interrupt context.
> 
> Both callers already are in user context, so enforce this at the highest
> level.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  crypto/xor.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/crypto/xor.c b/crypto/xor.c
> index f39621a57bb3..864f3604e867 100644
> --- a/crypto/xor.c
> +++ b/crypto/xor.c
> @@ -28,6 +28,8 @@ xor_blocks(unsigned int src_count, unsigned int bytes, void *dest, void **srcs)
>  {
>  	unsigned long *p1, *p2, *p3, *p4;
>  
> +	WARN_ON_ONCE(in_interrupt());

Your changelog makes it sound like you want:

	WARN_ON_ONCE(!in_task());

But perhaps something like so:

	lockdep_assert_preempt_enabled();

Would do? That ensures we are in preemptible context, which is much the
same. That also ensures the cost of this assertion is only paid on debug
kernels.


>  	p1 = (unsigned long *) srcs[0];
>  	if (src_count == 1) {
>  		active_template->do_2(bytes, dest, p1);
> -- 
> 2.47.3
> 
