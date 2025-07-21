Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116420E71C;
	Mon, 21 Jul 2025 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091787; cv=none; b=gsmPE7prKOf9DjdGvdvuNGj8JDhDWBiJGO38ncQayZ3UwrduQ17P1MK1x30Q+p7CojxRhAlaQxZnoWmdKft8ibEWOQAeZ3hrCKqZ1DEJ6U3CtQ46Mb9cmFlwo7KhTuDtQ7LJg/AxL6v+D+H/b3/53k0LJKvXmPScGLZqjNsw0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091787; c=relaxed/simple;
	bh=Zd7hDLGDNQaGB73auAur4qnLMLuyfBETAW2PxNXW6ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDgT6FOEJxAmXOTvpUPQ71iL1IPtMvcbUWJ7mJRRKK4XAzy+TJI+CdkuCdb17iGt1yVqObjgulw+BXZhu2yTj5uH13VOIaCqINYobNpCGxH2UZzcuZ0LrbRaXy8GhhtFnhoYqkUbM7i7Q2yq29i0Y+vx/khOTCsJ5DjOV0ncwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mso03xDB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mso03xDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD1DC4CEED;
	Mon, 21 Jul 2025 09:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753091787;
	bh=Zd7hDLGDNQaGB73auAur4qnLMLuyfBETAW2PxNXW6ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mso03xDBoI8keg0R8yYWYvb2974vQ9K3sP857POnCHr9tR64d+vrnl81gF1vIPJfo
	 Q8cgbXLwXmjIJ9mIxOq42X5T8DzIZ1+fpx1rGwzaQaUZtSknUXQGOiNmjv07e9NgxA
	 WqUVTpGx3Et+G6sOjGT/vtC3aDKYiaGyYmXwyDssDcnuG7keIs6IgPGstUY9d1yWul
	 UfvDp7D0GH9thC/Wuw2DDAUSvBR+N2qzijabyjpvEs0jO2KdoH99NIUxjZwglgIM3H
	 XNIyiPn/83lWv4ENRNij0PggEIxa9QZOO+S5IX7X4Rcrutbk0TNBKEsWrUkhdRI6xJ
	 B0vThDBnujOag==
Date: Mon, 21 Jul 2025 10:56:21 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sebastian Ott <sebott@linux.ibm.com>,
	Ursula Braun <ubraun@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aliaksei Makarau <Aliaksei.Makarau@ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/ism: fix concurrency management in ism_cmd()
Message-ID: <20250721095621.GB2459@horms.kernel.org>
References: <20250720211110.1962169-1-pasic@linux.ibm.com>
 <6b09d374-528a-4a6d-a6c6-2be840e8a52b-agordeev@linux.ibm.com>
 <af7298f5-08a0-4492-834d-a348144c909e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7298f5-08a0-4492-834d-a348144c909e@linux.ibm.com>

On Mon, Jul 21, 2025 at 10:17:30AM +0200, Alexandra Winter wrote:
> 
> 
> On 21.07.25 09:30, Alexander Gordeev wrote:
> > On Sun, Jul 20, 2025 at 11:11:09PM +0200, Halil Pasic wrote:
> > 
> > Hi Halil,
> > 
> > ...
> >> @@ -129,7 +129,9 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
> >>  {
> >>  	struct ism_req_hdr *req = cmd;
> >>  	struct ism_resp_hdr *resp = cmd;
> >> +	unsigned long flags;
> >>  
> >> +	spin_lock_irqsave(&ism->cmd_lock, flags);
> > 
> > I only found smcd_handle_irq() scheduling a tasklet, but no commands issued.
> > Do we really need disable interrupts?
> 
> You are right in current code, the interrupt and event handlers of ism and smcd
> never issue a control command that calls ism_cmd().
> OTOH, future ism clients could do that.
> The control commands are not part of the data path, but of connection establish.
> So I don't really expect a performance impact.
> I have it on my ToDo list, to change this to threaded interrupts in the future.
> So no strong opinion on my side.
> Simple spin_lock is fine with me.

I would suggest using spin_lock() if it is sufficient.

I think it is generally assumed that the minimal locking primitive is used
given the context code is executed in.  And we can it can always be updated
if the contexts in which this code executes subsequently changes.

IOW, I'm suggesting avoiding confusion if someone looks over this code.

...
