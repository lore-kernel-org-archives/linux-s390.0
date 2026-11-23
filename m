Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443495;
	b=PC9kQ6gtqQYa8STENio5qEV8YFXJbxBj6jVR/wY5cP0j2G3gsrdqox5HyArcU2h+Y09X
	 Ahi/tjXlNFCGaUrpzSfimYFEfX/ig4cwUgHIQk4RLhZEJtpGaf6u93GReUDmjHueJ72Zx
	 aLOpfROSlFE0DoyUO+S9GWqkmuilRxZUajMgtLeufd2iWIs+v+xXQnon7HSwcGw8talAv
	 iEwDJZT1XGvpNKFrU5FzJI3HBwK4ee988GaAygfdm3cPY+5L0292ou5ojyKhCbQxcJpRm
	 ualkeIkXO4GaGFzy0WxoJ0DTubUPWD9yT0qjASyRP3t4YwqpD99AdpZMvfhEPB1T7iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443495;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=x3gwmqRh26VyO7xHs1dG/mMfhRH/WgC3Su6DB/ad1WQ=;
	b=QbNakE8BttqK/nw5vbtMoARg9NbgIWUxRsTBlIrSoQgWsvsOW6vh4tfJKxFEnfHd7MJk
	 PnUb/cDSWgzewu/aiW4NULNFjVhT3AtVp/03pa+2RnHXjUik8pnFLZRuM5GsSwnie77Bo
	 j7VuXNE1YAdkrpMhDaBp0OYLcb+Q7ONVqaxz2ZGcDXobGoiipY292/Aoq30PL0gKGKBCJ
	 pllh+W8T2QShcofM67VGgBj292MxkiukiobSJH+8IU4TXsDOTdItdTT8ybUWEAJT9YCeO
	 GEdRfXaIpQ/cgydDgJx91bZwdtezebEYWHxPo78zOV2HZzQvTIDNQ3UlWQvl4onbp/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krS+w4Px;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 12EB0606A31E;
	Mon, 23 Nov 2026 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krS+w4Px
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 09E361F000C6;
	Mon, 23 Nov 2026 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795443494;
	bh=x3gwmqRh26VyO7xHs1dG/mMfhRH/WgC3Su6DB/ad1WQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=krS+w4PxELnsMndDJgxy9Jaiv62ASRBOqp7AZLGtglhouiRyxYn6ktLoqGEtZ60fF
	 zHPKfhxiQio+7eCfF7fJ85GAz88eOZGAg0f7NqRFj35nRRlV7LFhsHjy/aergpg3cZ
	 Yo2FdkFZVD8qMmD/jU9buhaR4EJdV/ZUHe21eBfg6ThSNOi+pjn/RHO2KjwLcCTtDS
	 VBfjblIHI5nCq0tdM+1c/DTycne3VzIwRB5QDuPvnuz09xNP6GFuxWXAPQF1MdxLFL
	 BTX92gQ5t8neoHWRPjHWsySTtCKAiZvdKEXLo8HFlBadfxbR7RSfxKmSW3cynpNPtC
	 f8E3gYDdyGmWA==
Date: Mon, 23 Nov 2026 16:18:11 +0200
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
Message-ID: <awRLI3Gg2auBPkhr@kernel.org>
References: <20261123102324.483917-1-hca@linux.ibm.com>
 <20261123102324.483917-2-hca@linux.ibm.com>
 <awRCtUt7_hHclKpe@kernel.org>
 <20261123141100.14793A9f-hca@linux.ibm.com>
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
In-Reply-To: <20261123141100.14793A9f-hca@linux.ibm.com>

On Mon, Nov 23, 2026 at 03:11:00PM +0100, Heiko Carstens wrote:
> On Mon, Nov 23, 2026 at 03:42:13PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Nov 23, 2026 at 11:23:23AM +0100, Heiko Carstens wrote:
> > > From: Anastasia Eskova <anastasia.eskova@ibm.com>
> > > 
> > > The keyring is linked into the user session keyring on allocation, but
> > > keyring_restrict() is only called after all certificates were added.
> > > Until then a possessor of the keyring can link arbitrary keys into it.
> > > If keyring_restrict() fails, the error is only logged and the keyring
> > > stays writable.
> > > 
> > > Allocate the keyring with a restriction which rejects all links, create
> > > the certificate keys with KEY_ALLOC_BYPASS_RESTRICTION and drop the late
> > > keyring_restrict() call.
> > > 
> > > Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> > > Signed-off-by: Anastasia Eskova <anastasia.eskova@ibm.com>
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > 
> > I think it is best for overall good that earliest possible release
> > for my intersecting changes is v4.7. I think that it is good to
> 
> I guess you meant to write 7.4?

Yes, 7.4 :-)

> 
> > do that architectural change but since it is a problem solved
> > there's no need to rush it in.
> 
> All the fixes are planned to hit upstream before 7.4 is released.
> 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Thanks a lot!

NP :-)

Br, Jarkko
