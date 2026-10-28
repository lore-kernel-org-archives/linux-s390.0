Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214163;
	b=nAVdgo6GxcspWa6H3qj5KQJuwGoF75YnjafaYAiQYlKAsHT8HuVdLSYzVIY1KCID+6eD
	 JkND+bBdLA1baHgKD3GGCUrRjavBI+uZspT7mWHTVembcuubfFHrNbq15lx5F359/it6B
	 CxZYb4slH46DtPJWL1a89ZAarPrzjdzD/ZJ4XvkTtxWSrdLhIQ5DGtBywXtcUgGMrXN6P
	 ywgk0a5f67l1cR1kX6wtXfKluku3Pzfbd0Hz3hyRSX3BkoQ0q/akAeR1K9on7yF4Am/uT
	 2Q63bZQxgEOHVyMReOTIMIrMcPhIBI+GXMqqaMMabRWvPBkE3VcMeUn4y+D+AuMYwCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214163;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YGMMhhJbzgW/QzPBpPTTD30RztuRbfCJwa//1MZPoEw=;
	b=4z8npSAVoAynBFjo96uPwbyFG3ipqyhg4+LS99kroI+qlacsQ4quEmwJTVHUSqxgHqi0
	 d+NnYdJIfxSzodmhg+q89f/9xy+FetT2k0PvXX30Iw+DF7vSPPUqftxMaKnvgVeJ6t5jg
	 h8nsqsxhmOgFG6o8lldnI8NQPt/dmedTrz1nuDhmczEbqjzobAYzm9ZfCGQPOjoZKDJX2
	 TSOP4kFy1C0os/c9tiXHgb7UUyNpDDrshRgcJKkdsjPVF/lhZejlGUr2Mwhg3VW4V5Iez
	 bIN0t51A+0WCXhxZno7T7REB4dGuzkKE/2j4NeuUTuIcOyY1PThtOv2g9oo58oYk35w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+yeLqAF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489C606A31D;
	Wed, 28 Oct 2026 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+yeLqAF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF981F01828;
	Wed, 28 Oct 2026 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214162;
	bh=YGMMhhJbzgW/QzPBpPTTD30RztuRbfCJwa//1MZPoEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T+yeLqAFaIV5ugdB5NjhA61e12w1L+BSrYB7OFrpfAcIR2R3bvk8VTeuph4Z05PLq
	 lcmoQ2GTvN7w8itK8z23Fb7CvX7UrXcLfbyTBM3+olmVREQ8OYm4Vt9S2hUlYCCwvh
	 YoLN/FbwlRtpVeWgrBQUKtpCMq2aSk6BZ96fzAPA1Zh/BUv05xwNUJnUgjyW+0NxCu
	 MFHryYeChyS2NXG+hd5tU1QFjVZnyNZfQFjz6S4tMUSJw3XSKUGdfABAiPkqNVvbJb
	 9OHQv7qk/nx3jGBDgbUSjb7yK9vqoj5fsPWRjo8ypvHtUbGQp1971XrK08vO1X/XlJ
	 WlJINox/ORLVA==
Date: Wed, 28 Oct 2026 12:02:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/9] Compiler Attributes: Add __must_init macro
Message-ID: <20261028190233.GA669046@ax162>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-2-irogers@google.com>
 <202610281155.4D2AA663@keescook>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202610281155.4D2AA663@keescook>

On Wed, Oct 28, 2026 at 11:56:08AM -0700, Kees Cook wrote:
> On Tue, Oct 27, 2026 at 03:38:36PM -0700, Ian Rogers wrote:
> > Note that Clang does not yet diagnose file-scope objects declared
> > without any initializer (initializers at file scope that omit the field
> > are diagnosed), see https://github.com/llvm/llvm-project/issues/232483.
...
> As part of this, can you open a Clang bug for the lack of detecting
> global initializers? It'd be nice to get that fixed.

Is that this linked issue or a different one? Looks like you filed that
one and it got fixed in clang ToT about a week ago:

  https://github.com/llvm/llvm-project/commit/58936cb3678b4b5b96177f24cac3940b9a389fe3

-- 
Cheers,
Nathan
