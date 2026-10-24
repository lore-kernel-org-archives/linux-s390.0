Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858545;
	b=a8Xy/EtKXX7CBpX9dRADy9SKzRRlQGm4jfqB0R0ZYw//7eqaBEIKMCvY2iEw68mQTEsx
	 jPVO/cEDincRe3NBLTgmPjlse4Ax5TkLmbFREdrEdRQZ8oHbQwCvhBXCb6+zNcEPel5gH
	 LMqCynNL3CJLpfgkHWIwTG8wuFdf6Iy8kjHckiLWQRtq2HeVHYkKMLs5PzYapgcYRRKdp
	 +PceZKoF2jE4gDf/gRlKZkviD2dDdbKfg3xLOBRHi7ar6Sv0Pvh6HJFFiC1R6YGs2XHnU
	 26yECCig+tL5cpGRwTsi+HpJkUdGb8bj8pKWyf3mgdeAi/hFGJNJ3DgEX3csu837ezg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858545;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1aAtzlGxYWM7+dYn3q9vh6JwVo0joCuPSK3S3WTbmy8=;
	b=knqmezwnlYJ8hiXeuJUlQHLjjJuhnOIXbnQpI47LHb/2C0rMM3dg300YISEBzUkNPt/u
	 5hToPcG43I7KV4Ljvk+nWZgNeGI2iuuuOad64Y4N6/XdCWCW3B1fEx5whhfa9dSBlUY/a
	 UCp+Hqbyl51AeTInK9dLLRNmzj9UeLibH8SB9LCVUsUqgRbiCLeDveK0wI3AdoQYk143d
	 fvv7GrcCCqh8qE4DOF66wWjFGbmsElm465K2mHj1gc5zBpxCd2nDhUB2KnCriO37uF6yJ
	 64FvakzT+EhtG33druBYRZQ7JiY7aVyo5hpS4jkXqqsVieN83nyE2YHZ1ODGi5MJFUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TcoWB7fR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 10F3D606A326;
	Sat, 24 Oct 2026 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TcoWB7fR
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 154991F01825;
	Sat, 24 Oct 2026 16:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792858544;
	bh=1aAtzlGxYWM7+dYn3q9vh6JwVo0joCuPSK3S3WTbmy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TcoWB7fRRWMyLohC2lkFRvLSlqJ/GNvY0zQ9o27oZ8ZosabXpwOMiTRdlwoL5kr3a
	 yUmmz0BXuG1yjBRXMUKJEiU+Og28KE5C30wy38bQRaP2Tx3/UTOB89eiZldJWrZmNK
	 +MumTs86sALmhOjEZ1ifdJWwMItNntI3V9G4K16J3HWgF2H+4u/aoR6LWQY0h4yJHi
	 mHs3bC6JKkUBdBWMN7ip/3V0oHMVtfqbiXP5ag9nIfcp5hnK0B5y8Spv31pZEGf0hc
	 lXYTJxZ6dZz80yBqaMixsQi/WsN4Tp2i5OUbWvh5RTuzVVW2hecO3qUKrTSLL/yHCr
	 eZn59bFDckrbg==
Date: Sat, 24 Oct 2026 19:15:40 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Kees Cook <kees@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Anastasia Eskova <anastasia.eskova@ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/cert_store: Hold the keyring->sem while
 invalidating keys
Message-ID: <atzZrGdjJhrivcQ0@kernel.org>
References: <20261024144229.1546151-1-jarkko@kernel.org>
 <sashiko-outbox-183758@kernel.org>
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
In-Reply-To: <sashiko-outbox-183758@kernel.org>

On Sat, Oct 24, 2026 at 02:58:25PM +0000, sashiko-bot@kernel.org wrote: 
> include/linux/cleanup.h notes that goto-based cleanup and scope-based cleanup
> helpers should not be mixed within the same function. Could key_array also be
> declared with __free(kfree) = NULL so the out label and goto can be dropped,
> or should explicit down_read() and up_read() calls be used instead?

This was actually a "design choice" as it is out of scope for the bug
fix.

Br, Jarkko
