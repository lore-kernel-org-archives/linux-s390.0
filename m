Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5810F9;
	Mon, 20 Jan 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388909; cv=none; b=r9WZ7u7Ztxnyo2B9HZXV37EFE8qSq6bXm0E2lOGsfpG0Rq7FzSYK68NWblERIB1xMHUUuBzi+8zjM1Ua85l1NpnZ+dqFHD10+yNUqMBhl1VHPj+AHqFxQlGmCTk5sIowt4Mfco6Gdlzu95Yr19eoitoZb1xilqxo/LsQKgQVTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388909; c=relaxed/simple;
	bh=UR4Bih85a2jdnU4n6dul2sZaQ2ERsFDGz5mqZm1PMuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqNiEVhFqdBBzPDWG438mdFcPm8pcNPBbGCqwKfaL+NfGOfPMXfIjgFoUX1JBdsUUqoWMNWjPHTmkJgzrYkaQTlT3JZopQv8Kxckdr1nJOB1O1olsjpSEmY3KF6bt98ttEnE68Ph68E5KrhTgkyRUTrJEMwMbYVAwbxA80lC4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L07h00EX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L07h00EX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C8/Aj255QI30aAuGyxj1N78/QVFPNCXL6IHmkVlSxOs=; b=L07h00EXYjBSPEuT+1PUeRImds
	CHhWFuTm7wslawIBr/KCYIufXXWCrapRKtjMnUpiYH3YoIuvxsBNr5XbuPgAkk95M0eafa89Ts1mZ
	HppokOp/vaLnPH5Uouwb3itBUgR4u0CmI2Ww6FG4yPNBMoULSyAUdynMV1IfzzIT8g48=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZuDS-006NWa-3a; Mon, 20 Jan 2025 17:01:30 +0100
Date: Mon, 20 Jan 2025 17:01:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: dust.li@linux.alibaba.com, Niklas Schnelle <schnelle@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 0/7] Provide an ism layer
Message-ID: <13a42088-8409-4603-83d7-4afbfc609f65@lunn.ch>
References: <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>
 <034e69fe-84b4-44f2-80d1-7c36ab4ee4c9@lunn.ch>
 <64df7d8ca3331be205171ddaf7090cae632b7768.camel@linux.ibm.com>
 <7dc80dfb-5a75-4638-9d44-d5a080ddb693@lunn.ch>
 <c2eb6fd7e9a786749d70a17266a04fb50dbd5bb8.camel@linux.ibm.com>
 <85d94131-6c2b-41bd-ad93-c0e7c24801db@lunn.ch>
 <20250120062112.GL89233@linux.alibaba.com>
 <7fc92a63-0017-4d59-bdaf-8976bf8dcee1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fc92a63-0017-4d59-bdaf-8976bf8dcee1@linux.ibm.com>

> What is central to ISM is the DMB (Direct Memory Buffer). The concept
> that there is a DMB dedicated to one writer and one reader. It is owned
> by the reader and only this writer can write at any offset into the DMB
> (Fabric controlled). (Reader can technically read/write as well).
> 
> So for the client API I think the core functions are
> - move_data(*data, target_dmb_token, offset) - called by the sending
> client, to move data at some offset into a DMB.

Missing a length, but otherwise this looks O.K.

> - receive_signal(dmb_token, some_signal_info) - called by the ism layer
> to signal the client, that this DMB needs handling. (currently called
> handle_irq)

So there is no indication where in the DMB there is new content?

And when you say "This DMB" does that imply there are multiple DMB
shared between two peers?

Maybe i have the wrong idea about a DMB. I was thinking of maybe 64K
to a few Mega bytes of memory, in a memory which could truly be shared
by CPUs. But maybe a DMB is just a 4K Page, and you have lots of them?
If you are 'faking' a shared memory with DMA, they can be anywhere in
the address space where the DMA engine can access them.

> I would not want to abstract that to a message based API, because then
> we need queues etc and are almost at a net_device. All that is not
> needed for ism, because DMBs are dedicated to a single writer (who has
> the responsibility).

But i assume there are "protocols" above this. You talked about
running a TTY over this. That should be standardized, so everybody
implements TTYs in exactly the same way. 

> > One thing we cannot hide, however, is whether the operation is zero-copy
> > or copy. This distinction is important because we can reuse the data at
> > different times in copy mode and zero-copy mode.

This needs more explanation. Are you talking about putting data into
the DMB, or moving the DMB to the peer?

If you have a DMA engine
moving stuff around, the data can be anywhere the DMA engine can
access. But if you have a true shared memory, ideally you want to
avoid copying into it.

Then you have the API used by your protocol drivers above. For a TTY
running at 9600 baud, a copy into the DMB does not matter. But if you
are talking about a network protocol stack on top, your copy from user
space to kernel space probably wants to go direct into the DMB. So
maybe your API also needs to include allocating/freeing DMBs in an
abstract way so it can hide the difference between true shared memory,
and kernel memory which can be DMAed?

	Andrew

