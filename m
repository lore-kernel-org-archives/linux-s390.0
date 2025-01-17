Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77A149C55;
	Fri, 17 Jan 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131633; cv=none; b=cVSWxblUXPvTBrhMldY0yRUYZ+XLtXWdoyKwoO0oe+YNVo65hmkQekExolUXsgDNthq3ynFrP5ZZm0onqSJ9hKGDsYzrXw+QuiOa+JYuJY8atMj6QmxY1ISI7zaNVL0jya0DY45snfXf8ItmaThTJa9HmX8coM/nEfCaGp33aSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131633; c=relaxed/simple;
	bh=UJSDDe4C/yxjy2F3wKQNlqosiqdKBBJiJou4Uy88Eeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP9UeIu8J3aOwrwZ2hc25jWSBiDssCVd31pKsSPMZ8dCyBanFm7T+2cUcNLlHBn3j76N+KzUMLlu5tg1YvngCU7wh9xH58H5INvjGWgGPOOqTlO9fwNVg3LfpN20k4kZVsZkVLvc71yjdGAOh7w0RDZLtp5sYqXEkXDYUcaTNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ELwRLsWL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ELwRLsWL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dOhk5H1hr/VU0cplGofQHk50OosVk4XUDMZzrQe3j5o=; b=ELwRLsWLLuvBAJy62Ql9QhRltR
	uHW0izmzs7l+G+91lh2ygKdUZSkwcxZ2AyfR6Eszz28sqWsjJfg4/mujpL/mwdnhlap/K8HMjVl/T
	3MOUWxo0axVnDVrXORvA0ZXjx3OY+0FQyJTeEN55CjvzP6+MyB5tjgStANFOIF5fmF/o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYpHw-005XCs-M7; Fri, 17 Jan 2025 17:33:40 +0100
Date: Fri, 17 Jan 2025 17:33:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: dust.li@linux.alibaba.com, Alexandra Winter <wintera@linux.ibm.com>,
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
Message-ID: <7dc80dfb-5a75-4638-9d44-d5a080ddb693@lunn.ch>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>
 <034e69fe-84b4-44f2-80d1-7c36ab4ee4c9@lunn.ch>
 <64df7d8ca3331be205171ddaf7090cae632b7768.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64df7d8ca3331be205171ddaf7090cae632b7768.camel@linux.ibm.com>

> Conceptually kind of but the existing s390 specific ISM device is a bit
> special. But let me start with some background. On s390 aka Mainframes
> OSs including Linux runs in so called logical partitions (LPARs) which
> are machine hypervisor VMs which use partitioned non-paging memory. The
> fact that memory is partitioned is important because this means LPARs
> can not share physical memory by mapping it.
> 
> Now at a high level an ISM device allows communication between two such
> Linux LPARs on the same machine. The device is discovered as a PCI
> device and allows Linux to take a buffer called a DMB map that in the
> IOMMU and generate a token specific to another LPAR which also sees an
> ISM device sharing the same virtual channel identifier (VCHID). This
> token can then be transferred out of band (e.g. as part of an extended
> TCP handshake in SMC-D) to that other system. With the token the other
> system can use its ISM device to securely (authenticated by the token,
> LPAR identity and the IOMMU mapping) write into the original systems
> DMB at throughput and latency similar to doing a memcpy() via a
> syscall.
> 
> On the implementation level the ISM device is actually a piece of
> firmware and the write to a remote DMB is a special case of our PCI
> Store Block instruction (no real MMIO on s390, instead there are
> special instructions). Sadly there are a few more quirks but in
> principle you can think of it as redirecting writes to a part of the
> ISM PCI devices' BAR to the DMB in the peer system if that makes sense.
> There's of course also a mechanism to cause an interrupt on the
> receiver as the write completes.

So the s390 details are interesting, but as you say, it is
special. Ideally, all the special should be hidden away inside the
driver.

So please take a step back. What is the abstract model?

Can the abstract model be mapped onto CLX? Could it be used with a GPU
vRAM? SoC with real shared memory between a pool of CPUs.

	Andrew
