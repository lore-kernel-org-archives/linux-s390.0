Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145012;
	b=eeBhq9jq9xq0ALAs1r01Pio58+fjqpLuFULfrv/J3RUHAzcWxtLxyJi/wbtmjLj+2TT0
	 FyjowMl7cMuFNy2NvFDDDMDT1/FYyhdlx+KnTbHdYN1P8omdj4Dlf0GHS+zI5iIHGMGaF
	 Wx/l26gcPKHKj/q9twF73q+rU7VX5ShS94Xgto0AffjqOZ0hdMm09U88Z9fq1O1lXkTyR
	 aPyLgO5JVsqPsIPTVSw8JgSGSq0loVwrbUn9NxQBCiOZitJc8p49X03vYa6V6Pnp6+9di
	 T3pSIVc/vQbqP3Arob2rHMJnW6iUkY2fhd84pRVRr+B+BMM70eowm/rS8qo4dPj4kYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145012;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=37NnudEHjZq4Av4L2T2koAHLqyLqevjQ4rPmRfS/2qA=;
	b=HCDGUwOO4m/wWV9Q62YG8dGXnB114DkYdsBc1R+cj82j7JQtU9U72ssPKEaRzSbqn5Ri
	 gAUrjG56FE+Cog7cbFhupCB8AaRXfPfynmhqFnU4ylzPYfOfs99GnkTx/QSnqPTo6ONwT
	 wNBYxBN8UEF9IKWAGQog6cSp7GD9bfLxyXqB5YCX3gHwhLusE3gGPoAF2HC+/Qkin3nuZ
	 pfQL3dwvxVbkT7GWizj2YX1t2U0kv2WCJG6vBrsgZ9jfsmdKihnQuY18OFrUSfEbzdaqX
	 oEWsXWvRGdvglJ+QgMUyhG1o+6y/o2Wv4HJ5iJG2ZakjkKYILvEUYgg0ZAjVnBgYWWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlKKkW+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1F0DA606A32A;
	Sun,  8 Nov 2026 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlKKkW+P
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 144B01F008A1;
	Sun,  8 Nov 2026 13:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794145011;
	bh=37NnudEHjZq4Av4L2T2koAHLqyLqevjQ4rPmRfS/2qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YlKKkW+Pc78i9c6cZvzovKkwyys0UF0ycjxrHafwOrZhslB7xJCRu9AQbXcInxZoq
	 NegMmCiiL2w6pCw2Cd7twb9dez/AzyrKPMkTnipIR1MDsenZCGde0RZAQVdTrVsOQU
	 aLfQiVRdLpFdf1EcWo5Rj4rCbWlCWOJ10iJogh4WRwkEeSABc7Xb0O1vM1fakF1Udz
	 WJToMowISADFAruXULgRsvvv99/SOU9SHxxioMskObLya6kFh0AbgNFd7DLDQ3f39v
	 y7fxY/k1OcNWkyupK/unPAwJqNhUTUEwGAHe7FbDB5o6xLr+Qq7Y5uHF6QJh82+f1v
	 RN7k3oXZ1xhbA==
Date: Sun, 8 Nov 2026 15:36:47 +0200
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
Subject: Re: [PATCH v4 10/11] KEYS: Remove key_type_dead
Message-ID: <avB677TOB0uWl2WP@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-11-jarkko@kernel.org>
 <sashiko-outbox-203769@kernel.org>
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
In-Reply-To: <sashiko-outbox-203769@kernel.org>

On Sun, Nov 08, 2026 at 01:16:25PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Medium] keys: broken garbage collection timer calculation in
>   key_garbage_collector() [1]
> --
> 
> commit 685cce051d4099c4b86015bc6b82bcd593f0652f
> Author: Jarkko Sakkinen <jarkko@kernel.org>
> 
> KEYS: Remove key_type_dead
> 
> This commit removes key_type_dead and its three-phase keytype reaping logic
> from the key garbage collector and unregister_key_type().

I'll go through 6, 8 and 10 in detail, so no need for further reviews
for this version of the patch set.

Br, Jarkko
