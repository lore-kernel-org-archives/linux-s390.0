Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266038;
	b=TGVCwQiRqf9GwIpPHOifcJsA1Pqxp2Fo6L8O6VRVZLiS8Xiu1MMkPbrfEGpkodlQaCpX
	 Ae1sihLUvIv095SxA+nEu0mI0b3uNHL2ZeYEmYKN/JYiDjmj6Ciztp7VhgkAT4NMHy2ZK
	 q4A6IPwWMCBBSH5ojCA7PW0UMEyUQfFPALgN4t/dbLFLlw+UZA2p1YYWH0IXFaMXNAQw1
	 u2F50OZ5RBmKxlYSb54vKr6HlqPQxXFeQZrh55v1Y6Z0XWm7dcYfdIkyUwJRYulmTyqE8
	 6ThlVAK56k1447/P1e9anWTPHs2iRGkoimGvHIxyaKYhfA+AjKIAJpcTsLN1A6NxaWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266038;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IC6PJ/RZVkQgMpY8cIohbFHuIH5eqvjrcXnHJ1rI6uY=;
	b=dVx1Mde254U6AEyTJp8jzrvB1hxoZkq56bzGsIn8HS5tE2xuC3SP7uC9t19lCAL/kFz1
	 njCopDpWST6SxjdFU5W8mh4sdfnRTfQLDRV9lyeYJ3wsgoQ8IiE8Gaflq8Sk2oXx7sLf+
	 A+mNC8X1xFr9Pqqa9x+8ECtLB0C+RM9vrVGZJ5ilmAhqRbPNdZ0VzyLygMNvFvM0+53gO
	 CLr1UVnpQ14H5YX5R5dvye7huK6spJMslc4PW411KcR1CjUMjDUZekLDWrgCMA2MYAcaN
	 gAy0dyPNVuNI/HIBDbHbaskSPEK0PurFy8g9m/kFeNEsvDURlrWC1e9GDbba6EARqMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlRoaz+F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 28822606A31C;
	Mon,  9 Nov 2026 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlRoaz+F
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4C1421F0089F;
	Mon,  9 Nov 2026 23:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266037;
	bh=IC6PJ/RZVkQgMpY8cIohbFHuIH5eqvjrcXnHJ1rI6uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hlRoaz+FYhaKeQrUUn6debqh1nygeJvK3YQfYYgaklSvf1hUgfCsE8iQjuggGwFcc
	 KYVURUH0yM9BsgmDIqW3uU0UzCdMvV18zlqfWlkOHnuDW0Pc2XK/DmiG7YrXN1ZQSp
	 bhCRyX86WYQy/XhnBu0TJBVniqL+6QmmcyJmLpB3D0NtUv0zLxbIvBGst50YoqdNPZ
	 /JqY7UyAxhuYuIlIYOcKPEacHnUkpuj2MvLj+NSIxgclM23cy1tNfhxpsFWgvqOYZN
	 RLeMSKshTMTS1ktK8EFJCXJypWBcg6k1O0fWUIyrqgUCOb2unBxZjvV5K+mIMjLBPq
	 1wm79nHvLy0mQ==
Date: Tue, 10 Nov 2026 01:13:53 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna Schumaker <anna@kernel.org>,
	Bharath SM <bharathsm@microsoft.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	James Morris <jmorris@namei.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Paul Moore <paul@paul-moore.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Simon Horman <horms@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>, Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v5 06/12] KEYS: trusted: TEE: Synchronize session lifetime
Message-ID: <avJTsUib2ss8rzOG@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-7-jarkko@kernel.org>
 <sashiko-outbox-205732@kernel.org>
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
In-Reply-To: <sashiko-outbox-205732@kernel.org>

On Mon, Nov 09, 2026 at 10:28:27PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] KEYS: trusted: missing Fixes trailers for TEE lifetime and
>   init_trusted() fixes

It's kind of weird that this was the only relevant Sashiko response.

I went through all the others and they are "no issues" responses. Just
wanted to address this so that there is no misimpression that the patch
set would need another "Sashiko spin".

The issue above should not be considered a blocker for a review, and
is trivial to address.

Br, Jarkko
