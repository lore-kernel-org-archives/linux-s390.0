Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CADD45C16;
	Thu, 27 Jun 2024 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719517346; cv=none; b=PLVnAykMjyLmdjr7JDFHauM0p2RRvLoyPieP6Dgg1bKl+ATC/KP9DhCGjPSKHT/05SfAOMHzWEUtr36+++G8qbDmh5sc2pzZFEeHjWN/vKuUw2cGEwUHNtv2PUzEh1Z6/LbLluxHoLkX3Gvhol/CH0eYHOFJ4BRyHhQNwkJvKmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719517346; c=relaxed/simple;
	bh=Yo/je769slaSS+fGwvza3ndvHET4etBlhfofMYZmKEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i91KkDSISTKHYYhDAs70ONulmBE1HZqS7aJiLZBp+DQhpxfOLskAYh27XVkl0hFyHntQhaO14CfzK+FGxZImKp0zV0P/VCig/r7UpAaFAOTobvqx1mcNYB0IxUkgCorHP2+4RG31bX6dibTt3JjsILuPBRMFCdopOZ2D98/vDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vUfML9jM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vUfML9jM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d+rD63IUzTKmeMdahZdyGD8HDohn/ne9796IMRSgbfU=; b=vUfML9jM6tDe+f3ShA+vWK3iWS
	7y3pDkU+BA3fJebjCtrhnOmK+MrkaIDuEyXSGCjyWTo7Ybvz8w3y5+756GpXlEseo2pyiTloEx8TU
	JOAJDmhdWyLuzf5GxRyVvxD5lql9oe7cwNjGhOM2DCdVecrvBL2fhw2QBDNnpFUWVeRY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMv0X-001CjP-JI; Thu, 27 Jun 2024 21:42:13 +0200
Date: Thu, 27 Jun 2024 21:42:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ma Ke <make24@iscas.ac.cn>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Christian =?iso-8859-1?Q?Borntr=E4ger?= <borntraeger@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [PATCH v2] s390/ism: Add check for dma_set_max_seg_size in
 ism_probe()
Message-ID: <e639c04e-ba84-43a0-b6e1-693cd1884798@lunn.ch>
References: <20240627021314.2976443-1-make24@iscas.ac.cn>
 <2c4ff078-a792-480e-971f-8bfeac07fac8@web.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4ff078-a792-480e-971f-8bfeac07fac8@web.de>

> B) Under which circumstances would you become interested to increase the application
>    of scope-based resource management here?
>    https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/cleanup.h#L8

Hi Markus

Please stop this. We have said a number of times, we don't want them
in existing code, at least not yet. Please come back in a couple of
years time once we know a bit more about how this helps/hinders.

      Andrew
