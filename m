Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931365;
	b=iRpT4ZdYB2HUrnls5r6PwCsYM5sCk4FxSnbZxRG7xST0SxQlAOBRjR+lSP6vY1gdM9QA
	 7sW2L/WT9XHCCWnZLLMzs6vcr5rh3jyN2qJPO0rjdPngWLoJOCpzzQFXD5r9RRuqi/ehX
	 QOGUGPoENlZFRvWYg7vUHT3BgkA8PhfaV1+n1N3O4nzmRaEtStIQ+uDJExDCk9HBAW/8g
	 HYZ4VSWIQqdkjoU6x7ZZCKkO8stT3rSc1Gj3/eNpoAqT7MHNhU9am+KVYRvETbY0OJcpr
	 IWLq/2sITL3JMdGrVz3kgnMtIECHTsV6a1js0CQw5KSkD5gmqT1WrBPywmDOkwoM4XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931365;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=x1XCWZUxSl9gP0yTlkGsvGx8zAXyc7acck71IN0yVjs=;
	b=keYDxU0hrrZT9qdaBDR0vugAcVJq5dG2FfK0VpkXRNojDx9u5mqlHrSennAPMTRu5q0t
	 g1THO2aNeBertunpzF5KW9f0hfGBc6k4D7/Y2XabsAR9/7nNtHC05OHG04M6ruxwWLHcH
	 HlArySIdn/pfxgHwm8PWmL2qiwmjuK9gh41MhsFVtMTcRuhb2XUjRHf6K+g27xe5rKi3F
	 Sz/GHxbdCgL+JTbvn8K6MvAQEdyAI/+YJd/PgYDBsMj86+lUwwdjaNbijbMK1/7MyRFFI
	 0LN0NYujvZ7mpSYP3JAg7+miODWJ1unpaSok02Ra8/7FhI0m5wIIYrPlcaohKuLiUDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QypBV5r7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EE4C7606A32A;
	Tue, 17 Nov 2026 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QypBV5r7
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 46EAE1F000C4;
	Tue, 17 Nov 2026 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794931364;
	bh=x1XCWZUxSl9gP0yTlkGsvGx8zAXyc7acck71IN0yVjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QypBV5r73DBlhKtZIJkk66rTFckwtx+Ys9jYnV4aMMYO/moRLyfo72vCH91WLskiy
	 DLnlL3ztn8u2RPxIwrlaYckNe5O7nUHQuXy2A9m53rHOk7hUqHj5KzFiN7/LabIx2m
	 chwNH1QXqVtW2zEZ0FbrMJEISTdve8+Ob1Sdfvn8MWIR75NBhX8//0Gcce2xwz+uYE
	 8F7bcxCzHxPNkURf7DywzV+nAaS4oxmT7KTe9+gXXzXgNfe+9NQ5mk3hGFB691Oq5x
	 jGLnuzQhLDc+z1KWP212JbZn1l+mEuBDvjyeZ1hZezbwll6UqWAVxaMaJsfHdXEdDO
	 /0mle8V9ruICQ==
Date: Tue, 17 Nov 2026 18:02:40 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 12/15] s390/cert_store: Validate hash length in
 check_certificate_valid()
Message-ID: <avx6oPmGG74iHR8n@kernel.org>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-13-hca@linux.ibm.com>
 <avtZGgO0DtD8Vn9Y@kernel.org>
 <20261117154604.32016Eb8-hca@linux.ibm.com>
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
In-Reply-To: <20261117154604.32016Eb8-hca@linux.ibm.com>

On Tue, Nov 17, 2026 at 04:46:04PM +0100, Heiko Carstens wrote:
> On Mon, Nov 16, 2026 at 09:27:22PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Nov 16, 2026 at 03:35:31PM +0100, Heiko Carstens wrote:
> > > Validate that vc_hash_length is SHA256_DIGEST_SIZE before checking the
> > > hash and use sizeof(hash) in memcmp(). This avoids an out-of-bounds
> > > read if vc_hash_length is incorrect.
> > > 
> > > Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > > ---
> > >  arch/s390/kernel/cert_store.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> ...
> 
> > I'll stop here :-)
> 
> Thanks for taking the time to review most of this series! So, I guess we will
> end up with this series going upstream via the s390 tree. This will result
> with a larger merge conflict with your "keyring_gc" branch, but that can be
> solved of course.
> 
> Is this the way we should proceed?

Fixes come first, so I'll just resolve whatever comes up.

Be, Jarkko
