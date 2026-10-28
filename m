Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213769;
	b=yUcLhdx4+LXW7m5fmI4Zfj10jBjZQpCQAXhNvYoEWladLBWn5dGqwOCHbbPvsE93aD2H
	 0bSjoRvxr5P010fdP1ICbvcCOyBL9J0wwSiJnKkuL6P9kNvVJliUxDmXvCp1fEx+jLRyw
	 RNO+95J76oedC88msG+GOOLxVZmcDuY++AMzJDkq4ATiz7cBcxcqkm7a9mm1deVFH7ShG
	 P7EUn4+Er0liDkC8gS+nCZ/pfn6TJ/nxn9YTUXjM/pv2cEF3X34GbGrWe8wXUC4DWCPGR
	 S/0EtsC/PfHi6fyneh6vxLW6vE3NHt23xHADsYUUC3jo3urDtYAFXK1+567c8IGGjJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213769;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=df/xPPyuiQPcm1AE1rSPxuyp5dlFq4Se196rhHrJoBM=;
	b=Xuc09XunVt1SMuqGBEIuIPxzno32wfx8JNOOfelAmCW4JPWSFQB4Pr23ZX0+4hYzbDyI
	 fGgPzHhU9CV95cv4TJiOb93TLy/fwOYEhFHU6mzqoqcqF62Zah8fSkX3awLWjqb7jikzL
	 wwHPe07Mm2YTQVXGM+e7hITVgeXxxEVvmjxyqntAoi0Eg81VNh0D+0u0lhd1vzWob/VtT
	 HQDAouXDHbvzHP1sTZUcOYqmnLc2wMVlEhlpd8RmUPR/VMWV2d37JNlduZ3+d6JDRwNR/
	 DFr2nNfSDiZgp9Qxh1IRQyzPTTOFwj4VCrQ/AtOYBS/5sbshRFfvBnBoiTGp0WnimgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+edzg6v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5838606A31C;
	Wed, 28 Oct 2026 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+edzg6v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D261F01828;
	Wed, 28 Oct 2026 18:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793213768;
	bh=df/xPPyuiQPcm1AE1rSPxuyp5dlFq4Se196rhHrJoBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K+edzg6vK4sYIgPI0EHAxslJmPd/aExnxCZkYatx9SKb8ztopQpN/Brte7D1uGHDc
	 +PWfIYIXj2TwEIjrIeT9aSjpQlU/qFISxxHuWsvH08dCGPPiD4L4rx5Tz6bxLuFRvY
	 RhA3+DjTqfNcnhfh/7faDIzX0CmFsTI2XpkHQ8+jhA2LaeatAD4sqfFj21cmIRpM5b
	 W2D2wH60j2ajxxUPUQIplNGc0FcQFY/hgWtTB/gjNx5LU362Hvl/ouMKfNIqzO8whL
	 EQwWzgrE3+OvEllJ5XwE13QwOyNwuhXlhNdKAwm9IJuUZrFACWCEqjTJXX2ww3Zp+t
	 0+IngOv7LotGw==
Date: Wed, 28 Oct 2026 11:56:08 -0700
From: Kees Cook <kees@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
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
Message-ID: <202610281155.4D2AA663@keescook>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-2-irogers@google.com>
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
In-Reply-To: <20261027223847.652884-2-irogers@google.com>

On Tue, Oct 27, 2026 at 03:38:36PM -0700, Ian Rogers wrote:
> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to indicate that a field must be initialized explicitly by the
> user when the object is constructed. When an aggregate initializer or
> uninitialized variable omits an annotated field, Clang emits a
> -Wuninitialized-explicit-init warning (enabled by default).
> 
> Add the __must_init macro to include/linux/compiler_attributes.h (which
> is included by include/linux/compiler_types.h and
> include/linux/compiler.h) so kernel structs with error-prone
> initialization (such as mandatory callbacks or cleanup handlers) can
> enforce explicit initialization at compile time, as discussed at the
> Linux Plumbers Conference. The shorter __must_init spelling, rather than
> the attribute's full name, keeps annotated struct members readable and
> was suggested by Greg Kroah-Hartman.
> 
> Note that Clang does not yet diagnose file-scope objects declared
> without any initializer (initializers at file scope that omit the field
> are diagnosed), see https://github.com/llvm/llvm-project/issues/232483.
> 
> Also teach Sphinx (Documentation/conf.py), kernel-doc
> (tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
> attribute macro.
> 
> Link: https://lpc.events/event/20/contributions/2392/
> Link: https://lore.kernel.org/lkml/2026101532-fantastic-deafness-e04c@gregkh/
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

As part of this, can you open a Clang bug for the lack of detecting
global initializers? It'd be nice to get that fixed.

-- 
Kees Cook
