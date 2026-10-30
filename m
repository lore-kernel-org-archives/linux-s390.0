Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385049;
	b=muapRm1UW6usFltoQwhRp7mwjbhYI2PqH9JVzR+N9NeD3ElpH+uZY1cmRox4MN0IHaen
	 k1kzBTDRKKy1yKU3E3u55N7SzFiH5UU2zQnhxdnJWq2FEfH3dLEp3GR2EBbKQkxwHug2I
	 U71KWOHHLaRyl5kr/LlzHrluW1Om41UiOFFttKv9jvhbgUPYVhVkZG39B9bexVPRxTQVu
	 RcXY07HMeKOM0q30lZPiFAIOriEfD25TZqMD6lda1dqTmuiwQV61qHA5jCwGpm3EuRSlY
	 OU6pixBy7NFZ5590DfSaNBit7BSo6IfsV6ezd8vWWxAOKiiXUJr6+zF4JY+iTm4Zl3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385049;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ymmdwc5PEMgv61WbZEAXoHrjiG+5VIZ10E632soWGCc=;
	b=e7SAedFEReOX8ABSAKdqb1d4tlqabu7d1pbog9qTO9PMrmgbJutX7co64P3v/9yhO21g
	 q9D4b2adVXHFzDdWpCURYuadmtza5A6hEYlquG2SzXGCQZbFzM3IiktiAHGLp6p9BOAds
	 j2dRwqWAomvy0nd/+ivbY6H143ilBFlodeYqH3+UcHNgx4EMGcGCf/fZeXY1hld4N1Sdt
	 6wjoQCttZJD8CX4suqI5RMKIdDUZdB4s4L7vvgux6icn2gqwT2mMKe8eMztSadwyphvtk
	 oiWS0fxMnBhopr//51N85kUYauyGDd3Z3shLXEhzvTWSNB9iZvgZPjY3GkFbVsjwuNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd5mnlMY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC2606A31A;
	Fri, 30 Oct 2026 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd5mnlMY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365561F000C1;
	Fri, 30 Oct 2026 18:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793385048;
	bh=Ymmdwc5PEMgv61WbZEAXoHrjiG+5VIZ10E632soWGCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bd5mnlMYQl798ipBazvCyuBvEJ+dWQPwsnUhVWLaW7b1vz5ZxxwwDFJAXipNxVYkZ
	 1YMHg32fNUCuoVzm2HCBW3ov7kG+JMaBOx03FaMytt2PrrA5GHA2Tvi5hKn/EfloYP
	 2beONBCAOHLRlOst0mi76+aNgfLm6mIii3Lr5Fvstx8lw6wGj/SrTAbdVuY0LzPwAU
	 bCJanwYpvATD+HqFWKlmHWzxbYzpj5FiFEot/sqUcaxCu2/PrJulmkzTYLC6de+Ext
	 aaZWpT6UFdWy/d0gaseRtXTvi4oQtl70vUfG4Wb6sIpH14qDGlI1q3EhfXbEG7UOrn
	 +aykTDKlAEfuQ==
Date: Fri, 30 Oct 2026 11:30:48 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
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
Message-ID: <202610301130.FEF31E7F@keescook>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-2-irogers@google.com>
 <202610281155.4D2AA663@keescook>
 <20261028190233.GA669046@ax162>
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
In-Reply-To: <20261028190233.GA669046@ax162>

On Wed, Oct 28, 2026 at 12:02:33PM -0700, Nathan Chancellor wrote:
> On Wed, Oct 28, 2026 at 11:56:08AM -0700, Kees Cook wrote:
> > On Tue, Oct 27, 2026 at 03:38:36PM -0700, Ian Rogers wrote:
> > > Note that Clang does not yet diagnose file-scope objects declared
> > > without any initializer (initializers at file scope that omit the field
> > > are diagnosed), see https://github.com/llvm/llvm-project/issues/232483.
> ...
> > As part of this, can you open a Clang bug for the lack of detecting
> > global initializers? It'd be nice to get that fixed.
> 
> Is that this linked issue or a different one? Looks like you filed that
> one and it got fixed in clang ToT about a week ago:
> 
>   https://github.com/llvm/llvm-project/commit/58936cb3678b4b5b96177f24cac3940b9a389fe3

Oh! Hah, it moved so fast I missed it. Great!

-- 
Kees Cook
