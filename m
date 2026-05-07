Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA93A1A3C;
	Thu,  7 May 2026 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165407; cv=none; b=lI4t1o1YhCjckZJ5FxH1T0oWKuQ4vSnbGycgNOOJU48MqzzlaqOtto7fMT9KP0Yb/Nj65tzAsS3bVmy+qnSu+WB0kZU/a+wG91q9Zyrswy1dHXS4h4H1N6cEBEUX0wWeiCmckhiPVz1ZNnEQFxOJfGl23yloh4HLwA5HsuBgYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165407; c=relaxed/simple;
	bh=l0KGYLpdxLhw7WTTlvr/n2u2L8fe5I5o5+W38kE/HTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5YXySct6Cl2K6XyCnLJLNCX8Gfqf96YWBIP4omZLjVJPNb26XqEyA6iTaNpwneBM9mUhboDuaygyGxFv8hlIx+vF8gTVRLt6drUlglpJO3lU3tSkTDgvhBlEmhvHUEio7JsJ/rGiC7grfrYKG7J5Uezjsbhz2rbLmsg2/PH3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PlUhEh3R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PlUhEh3R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZDSgrR0/vRpqzM+ZA2HdGKfYknA4Yh81qdD+FHmfMuQ=; b=PlUhEh3RVu83gso6RTpsy0ytdb
	s9WHFc8ZpIFbeIHsXQdKoPkVkEA6hEuCiMfhg9LjymYcIK0vdw4c/ziep+F6wvY6cEdBJ7JeRatO+
	BTIOXLh5vOXUnU1mVI/B1Yr9wdtvtqmQl634DKdhmceaSzbwjNKJQjCwjY9z9c9MbSvfIgs2dCryz
	yu0R45il9OCc8aUW+uBed2UyZBt+zatkC33ajoPLlgRniQCrAFKyZ5cZwBM0c3UlEVlYeiaNqdHEm
	66GBtOHpGnPHLPNMr18pOrhb3dl6YcO0l06QoqgWuQFCtG+xKE0ORnXH6FWpUqp+ebxJjIhSior4E
	G8OYj+JQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL034-00000002xeJ-0G62;
	Thu, 07 May 2026 14:49:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 072D5300882; Thu, 07 May 2026 16:49:57 +0200 (CEST)
Date: Thu, 7 May 2026 16:49:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
	Douglas Freimuth <freimuth@linux.ibm.com>,
	borntraeger@linux.ibm.com, imbrenda@linux.ibm.com,
	frankja@linux.ibm.com, david@kernel.org, gor@linux.ibm.com,
	agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] KVM: s390: Change the fi->lock to a raw_spinlock
 for RT case
Message-ID: <20260507144956.GK3126523@noisy.programming.kicks-ass.net>
References: <20260505173728.160562-1-freimuth@linux.ibm.com>
 <20260505173728.160562-4-freimuth@linux.ibm.com>
 <20260506045734.11230A02-hca@linux.ibm.com>
 <d39c54bc-1984-490c-9457-5eff63edef56@linux.ibm.com>
 <20260507095630.10395Aa0-hca@linux.ibm.com>
 <191a1272-1f8c-4a67-a01d-abfdb89fcaf5@linux.ibm.com>
 <20260507144549.10395C64-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507144549.10395C64-hca@linux.ibm.com>

On Thu, May 07, 2026 at 04:45:49PM +0200, Heiko Carstens wrote:

> So... after having given this a second thought: we do not have
> PROVE_RAW_LOCK_NESTING enabled in our debug_defconfig (either we missed it,
> or somebody (cough) thought it is not relevant for s390). That said, I
> believe we should enable it, fix all fallout and also make sure that new
> code does not generate any lockdep splats with PROVE_RAW_LOCK_NESTING
> enabled.
> 
> Rationale: even though it is not relevant for s390, we also change common
> code; and by ignoring PROVE_RAW_LOCK_NESTING we might cause problems for
> other architectures by introducing incorrect nesting of locks in common
> code. So yes, your thinking is correct.
> 
> Peter, I just added you to cc, so you can correct me if I'm entirely wrong.

Makes sense to me; thanks for doing so!
