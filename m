Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375039E191;
	Thu, 30 Jul 2026 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454853; cv=none; b=HEDkhFPXqDcsGjzchI9/uYx35EE6I79SbKvHQgrhEpqSgfX92QNlYAYIZRN6zl9bFCvVDOn8eha95qPHUz8RUfXL8d/a4VYvTLyvnGArtwSlyp2ootKDqvvaE2s5JuoTZVmp3Gu+mcXibwqYXzagsP3IDWz8XUTi9O6OpkhCQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454853; c=relaxed/simple;
	bh=iBNd4K+O4tno7LXYELuL3uAd+WPSyAbldMr9oM3VMKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMjf/t3OZl9dO/BlkAqi+vPlj18C6pqqdITUvodLeCtfqZct/hV8POjtsnHr/sK3fJCbzSr2i1J/AJ2lb5RE6TNN06Cnw6FfrYvw9qUrvp+I1mRc8S0NSjmHTf/bEwr1leUtKzwYWoW7DFeYSnmcr32CIICOIYR0JAyeRDmMUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyY23R6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyY23R6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6901F000E9;
	Thu, 30 Jul 2026 23:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785454851;
	bh=H07kJpzbq3Hf65M0/NsKGMsxVsYpVDaw4sf2gDu2Lfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hyY23R6kNcDsGqR9CnHDy+2L2E9FpG5zbiakWGA3tnCJ82tnDU3ByK8Zjm63T7HEg
	 OxVwHmNkZasV6uTMtFSfkflWGZLwt2MuGDoOLlX+THF11XYNogFI9hcYQFq21tWSxB
	 IiON8mat8caB7+zC2Nhg4f3TDINAkWsV/RA0I5HwJUWE68XX3QqPJcUuvFtNZvw6fh
	 X1g0Xxon+6zuXREcdfLeiPjY3yEVpJBxzkQXKO5PfSpfyiri6VutrqgVvAUslbG+mW
	 STx5fJcMil6zy2QPnqemHt04IVBopGvpG88211PueeilEYvJblBasDbX6Rqj2pJvPL
	 Jxo89pbn2hlqw==
Date: Thu, 30 Jul 2026 16:40:50 -0700
From: Kees Cook <kees@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Dominik Steenken <dost@de.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Maxim Khmelevskii <max@linux.ibm.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, llvm@lists.linux.dev,
	bpf@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] s390: Add kCFI support
Message-ID: <202607301639.13BBC08@keescook>
References: <20260727140514.116501-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727140514.116501-1-hca@linux.ibm.com>

On Mon, Jul 27, 2026 at 04:05:07PM +0200, Heiko Carstens wrote:
> Add s390 kCFI support using the generic support provided by clang.

Awesome!

Is there anyone you know that might be able to review the GCC KCFI
series[1], perhaps with an eye towards providing the s390 back-end
implementation?

-Kees

[1] https://inbox.sourceware.org/gcc-patches/20260716005527.it.950-kees@kernel.org/

-- 
Kees Cook
