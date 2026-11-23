Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443645;
	b=hY1CTs9AxAb/2rIDs4ZWIpN9CTzXiRg4Cffsf6opGgjfAd2O4DINP21ktz/PjzFhp1rU
	 wTgWILxXxy3dZVWw2nok1HNX4ErJ3DW6QGwC74zSbeKJY9e9SFS4W7WnLDXpfnqOBDXv7
	 bGlOlZ5a2X/IBDNMbVyS7VrnPcdIO2tPD+Bn0RouGbA/HCsNgDY3MlIBXqXzJ9AUsyN7l
	 vV6OhPlWhtRBAAtDYHqbCoenT7naT5rn4eSInJDmE98u/fHXShFA0aHkgrX8oit/B1ch3
	 Ljr5BtrIPVAio4LVdXIEnS4x8uY3KP2bIFQsiXJ5DWjhQ4h9hoDOTrpuhiDqJlsGd3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443645;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=891emcHDptht6+E/cEaR0YmtfNaOVq60bbaJQA3+6Lg=;
	b=2OudlovUGPpq8DhE0dBUdkirGNJJ61l9hvD2Osya0FYh4Qy2bpDTo/wnnir/61OgqEoN
	 a8wTFsBWTnSELDXmDeFfBHCxmJvTi1Gr0CokUgVHKCR8v4Tkq8z/+s2dn8rcQhNXRo80W
	 AlQEAU9owIkC869kiI0AWCz4ECCX7gfU1I8WX5vw1X+UbE3jG5scyagdhe7DY2q1y328R
	 D4IQpxxOH/599ekoCwVCMkMVsa0e0euqeXa87ERwHPA1IL68vZkxK9bliaLqFY+uFpUkF
	 jwkNpiPj9NKcRX1x3N2yyrjwbWpfnN+i2/4ggkA3vH+OKMQmDgNjgWApLp5bb3K6cxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJK3Bu4l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D9117606A31F;
	Mon, 23 Nov 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJK3Bu4l
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A077F1F000E0;
	Mon, 23 Nov 2026 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795443645;
	bh=891emcHDptht6+E/cEaR0YmtfNaOVq60bbaJQA3+6Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jJK3Bu4lOrlUmvvMPjPPal4QlG+SWUvQRTrHxaLgaBNZIivOwOCaiW6VwUKgpPEWl
	 B3WIyOY2dhDDDkTQiz3YzfD3UDWht9ZqtOragtDgUp1j4NJlfFFAsGNcORQSuxfTNH
	 V1SdNKn1bCo4wgkyPjHFovw+WtwpTH4NM6ykPYpIrj4n3cc/Mv02fVK/GMrITsMh5O
	 kSoA71JK4pnn86EDZqZXDssKbAISSgrc+wjH/g++N21wu9CgHJAyLupLgxhLHhGzgO
	 NuznP25ANLFALtzjQ4jrIYbFclMJy/vOEySD8YUIP3EsitSCFHGXisNI1z9XZXhuni
	 NBBwdp544Oong==
Date: Mon, 23 Nov 2026 16:20:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/cert_store: Allocate keyring with link
 restriction
Message-ID: <awRLuXqtUwPGAe_q@kernel.org>
References: <20261123102324.483917-1-hca@linux.ibm.com>
 <20261123102324.483917-2-hca@linux.ibm.com>
 <awRCtUt7_hHclKpe@kernel.org>
 <20261123141100.14793A9f-hca@linux.ibm.com>
 <awRLI3Gg2auBPkhr@kernel.org>
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
In-Reply-To: <awRLI3Gg2auBPkhr@kernel.org>

On Mon, Nov 23, 2026 at 04:18:15PM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 23, 2026 at 03:11:00PM +0100, Heiko Carstens wrote:
> > On Mon, Nov 23, 2026 at 03:42:13PM +0200, Jarkko Sakkinen wrote:
> > > On Mon, Nov 23, 2026 at 11:23:23AM +0100, Heiko Carstens wrote:
> > > > From: Anastasia Eskova <anastasia.eskova@ibm.com>
> > > > 
> > > > The keyring is linked into the user session keyring on allocation, but
> > > > keyring_restrict() is only called after all certificates were added.
> > > > Until then a possessor of the keyring can link arbitrary keys into it.
> > > > If keyring_restrict() fails, the error is only logged and the keyring
> > > > stays writable.
> > > > 
> > > > Allocate the keyring with a restriction which rejects all links, create
> > > > the certificate keys with KEY_ALLOC_BYPASS_RESTRICTION and drop the late
> > > > keyring_restrict() call.
> > > > 
> > > > Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> > > > Signed-off-by: Anastasia Eskova <anastasia.eskova@ibm.com>
> > > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > > 
> > > I think it is best for overall good that earliest possible release
> > > for my intersecting changes is v4.7. I think that it is good to
> > 
> > I guess you meant to write 7.4?
> 
> Yes, 7.4 :-)

I'll open code this fully.

My plan for keyrings is:

1. v7.5: assoc_array to rhashtable migration.
2. v7.6: make keys to bind key type's LKM.

This went all wrong but anyway. Both are architectural overturns so I
think it is better to stage them like this.

Br, Jarkko
