Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9721422A8;
	Fri, 17 Jan 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126627; cv=none; b=obcYnHBi1CivnyF7zbZ71MAMoKEAaDfgmnp0QXbFrLhNSNcGr+//HgqtguNG4ZTDu4Rt3rW8mDUrzYalFQFH6CaCu5K6GBlq3C97FP+CTOM6x1egPGtCGkG3I3nJxb6vVAvSGCnzYNfhgGhlre0+VPGpDk/7iZSFoGwSnkh/B0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126627; c=relaxed/simple;
	bh=/F1NSaZSaoh3iZrteHw4vFeMNr4B8Gk9P2RaO1Q38Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0JFW96m4w8aAP2XYDA4XwGHq6A/Y/kPu/nwvuMMOG7CIoaAOb4GstQA0yheTGRSwUud3r+8o5Ru67OMmD1jLJGtdOPCLNuoPYuNS9wilLK2jbgTlinoJzxKpeaVOKVklgp5rRL+wzHsGZb9owAsK7xZystxhrZptHxTXQTbppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hQff27DG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hQff27DG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yauV8prAIYm9rGO6ViqfmekcH2CfXwo7qVm4duZxONs=; b=hQff27DGqU9tGK9FOpN2SWfq6a
	4HBudKQltQnE1+wbePuVGrpv9W9S2kctnhTEZK4w2X4CfjxwgXVEfOwDMwWZZuLeLS6x0WYjS7DkI
	bWD3Cf72P8iOU9DmXx71bpBbpKlNx6CpSjIOU5x0VZLqMfTjo7pKDRV5oDton9ZWYZH0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYnzG-005TdA-8M; Fri, 17 Jan 2025 16:10:18 +0100
Date: Fri, 17 Jan 2025 16:10:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: dust.li@linux.alibaba.com, Julian Ruess <julianr@linux.ibm.com>,
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
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 0/7] Provide an ism layer
Message-ID: <3e97f471-69fd-42bd-acf4-64201eaf6994@lunn.ch>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <80330f0e-d769-4251-be2f-a2b5adb12ef2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80330f0e-d769-4251-be2f-a2b5adb12ef2@linux.ibm.com>

On Fri, Jan 17, 2025 at 02:00:55PM +0100, Alexandra Winter wrote:
> 
> 
> On 17.01.25 03:13, Dust Li wrote:
> >>>> Modular Approach: I've made the ism_loopback an independent kernel
> >>>> module since dynamic enable/disable functionality is not yet supported
> >>>> in SMC. Using insmod and rmmod for module management could provide the
> >>>> flexibility needed in practical scenarios.
> >>
> >> With this proposal ism_loopback is just another ism device and SMC-D will
> >> handle removal just like ism_client.remove(ism_dev) of other ism devices.
> >>
> >> But I understand that net/smc/ism_loopback.c today does not provide enable/disable,
> >> which is a big disadvantage, I agree. The ism layer is prepared for dynamic
> >> removal by ism_dev_unregister(). In case of this RFC that would only happen
> >> in case of rmmod ism. Which should be improved.
> >> One way to do that would be a separate ism_loopback kernel module, like you say.
> >> Today ism_loopback is only 10k LOC, so I'd be fine with leaving it in the ism module.
> >> I also think it is a great way for testing any ISM client, so it has benefit for
> >> anybody using the ism module.
> >> Another way would be e.g. an 'enable' entry in the sysfs of the loopback device.
> >> (Once we agree if and how to represent ism devices in genera in sysfs).
> > This works for me as well. I think it would be better to implement this
> > within the common ISM layer, rather than duplicating the code in each
> > device. Similar to how it's done in netdevice.
> > 
> > Best regards,
> > Dust
> 
> 
> Is there a specific example for enable/disable in the netdevice code, you have in mind?
> Or do you mean in general how netdevice provides a common layer?
> Yes, everything that is common for all devices should be provided by the network layer.

Again, lack of basic understanding.... but why is it not a network
device? Network devices are not just Ethernet. We also have CAN, SLIP,
FDDI, etc.

	Andrew
