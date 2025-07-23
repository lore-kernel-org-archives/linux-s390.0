Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D892E9EB0;
	Wed, 23 Jul 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279818; cv=none; b=momixngSZEFp/2SVjZWZcqRcshcTW8cRNxpk5j9RofqaDwO+E5EQR5k6i7AGbq+Tjtu32h2kXiW41trfjZDhTrEE2dLWV4u6TqtpxZishyg0TlF+eBpILR9/uLBddBftCvFfCuCXa8KGzHSYoNhu8CQU+npsYpKGcIAAzA60w3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279818; c=relaxed/simple;
	bh=OPmCOUzLa0r7HyBI3CEMPKIRnUQyt+8lt651VJBZ6pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFzLF2cKFVto0g+aoI19VaNDn83/Xmwpb8yryZvtMiv/2T786iCkEUDP28Qq+vaF4zgd49V7ca6LxSHo8/sh9q9V/6UlDHrPYbjsh1bSMqSfofH538nq9wbMbOC8QmXTh4FZXKZDba2fFAbUicy/l26j318xRoknnweuA5D9p/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzjUwdy7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzjUwdy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49F9C4CEE7;
	Wed, 23 Jul 2025 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753279816;
	bh=OPmCOUzLa0r7HyBI3CEMPKIRnUQyt+8lt651VJBZ6pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzjUwdy7IW7z1YdpnwQQlIGqt1XwBvhrF6D3enBtAhXZAtUITGLps8I4WDkamoRTy
	 b/COlduTYWT0ZW5kP8b8u1myxkzomIYmFcBbhrrcQAjGef11ktjQK8P3qujDC2PZxo
	 W8ehL1nTgTBQsE5MibYqkWFPVwFaMrIBWVk3Did2KJ2Uw1zxZELnUkRU6Ns6aHgU8W
	 mVSYqWT20blUxjDwczuwaVtLk5oSa9n6Q78/Y3duV5uGYV4XS5eQoDIJu/bQcYLpcz
	 C/s9aYdhF2qOW71E24hRQwOBacXV6n22VtdkmbnfZzkXpHUleUIqm6F6v8NslVo8Sy
	 8bQe0Kpdt8MvQ==
Date: Wed, 23 Jul 2025 15:10:11 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Aliaksei Makarau <Aliaksei.Makarau@ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: Re: [PATCH net v2] s390/ism: fix concurrency management in ism_cmd()
Message-ID: <20250723141011.GB2459@horms.kernel.org>
References: <20250722161817.1298473-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722161817.1298473-1-wintera@linux.ibm.com>

On Tue, Jul 22, 2025 at 06:18:17PM +0200, Alexandra Winter wrote:
> From: Halil Pasic <pasic@linux.ibm.com>
> 
> The s390x ISM device data sheet clearly states that only one
> request-response sequence is allowable per ISM function at any point in
> time.  Unfortunately as of today the s390/ism driver in Linux does not
> honor that requirement. This patch aims to rectify that.
> 
> This problem was discovered based on Aliaksei's bug report which states
> that for certain workloads the ISM functions end up entering error state
> (with PEC 2 as seen from the logs) after a while and as a consequence
> connections handled by the respective function break, and for future
> connection requests the ISM device is not considered -- given it is in a
> dysfunctional state. During further debugging PEC 3A was observed as
> well.
> 
> A kernel message like
> [ 1211.244319] zpci: 061a:00:00.0: Event 0x2 reports an error for PCI function 0x61a
> is a reliable indicator of the stated function entering error state
> with PEC 2. Let me also point out that a kernel message like
> [ 1211.244325] zpci: 061a:00:00.0: The ism driver bound to the device does not support error recovery
> is a reliable indicator that the ISM function won't be auto-recovered
> because the ISM driver currently lacks support for it.
> 
> On a technical level, without this synchronization, commands (inputs to
> the FW) may be partially or fully overwritten (corrupted) by another CPU
> trying to issue commands on the same function. There is hard evidence that
> this can lead to DMB token values being used as DMB IOVAs, leading to
> PEC 2 PCI events indicating invalid DMA. But this is only one of the
> failure modes imaginable. In theory even completely losing one command
> and executing another one twice and then trying to interpret the outputs
> as if the command we intended to execute was actually executed and not
> the other one is also possible.  Frankly, I don't feel confident about
> providing an exhaustive list of possible consequences.
> 
> Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared memory")
> Reported-by: Aliaksei Makarau <Aliaksei.Makarau@ibm.com>
> Tested-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Tested-by: Aliaksei Makarau <Aliaksei.Makarau@ibm.com>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

