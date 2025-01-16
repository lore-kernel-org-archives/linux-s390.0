Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1513024A7EE;
	Thu, 16 Jan 2025 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058115; cv=none; b=N5Z/8vheXh0hspZVJfrMpwc/UEgITicLJd0gBXPl/4TTZMli7DZ5Gmcq4zn+BTpeVRIpxNM745kvYarF+PpMVE8Y1pRdwf6MiinSk4u9JHgSdVPNa8QeO635x7cwZENvlt18KdQ1OADMeVwl4y8zsaqKkv0sdfLTAGlf8uU1/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058115; c=relaxed/simple;
	bh=1Y7xY78VuEuSDHnLrcANVcfv6asWKHAjfj0vKGYSx1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja14UgpODoZOM8oz6q3YiVGFC/xuAyIWYVx7p+LJP8rS6YQyOHRrlLIwMDurAhWRXyTKj0qKO+kZrNr5EwypGqAbg/oYgc/4+Bh1ahpoHZNrz6pv/5iJ0RA1UZWFsb9om9RGXJ+sEXFTmpOQ4fWp6L+/QNMicjOXONaaNu1O3cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pvfAzbJu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pvfAzbJu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3A5jJ7OjfSb2aSIqIMcL4dOznCbAHUNHnn6oMc0ovuk=; b=pvfAzbJuvNhSXaB7hzRptra0vU
	FUbh0Gc76p8yl1Fhk8bQVwB4m/rovlIVYcQMNBZpCEAnDo/buMiR2DrMX4tA9sNQRgAGeRAfbDjLS
	uFa3+WxZ/FxcZBZyo4c988hA+6ry6IxOFFepENaw4Hv3BeNjkgpIVprUJh1n4ynueoEs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYWAA-005Dxm-J3; Thu, 16 Jan 2025 21:08:22 +0100
Date: Thu, 16 Jan 2025 21:08:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Julian Ruess <julianr@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 1/7] net/ism: Create net/ism
Message-ID: <e379f0dd-8ad0-4617-9b24-0fa4756d30ea@lunn.ch>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250115195527.2094320-2-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115195527.2094320-2-wintera@linux.ibm.com>

> +ISM (INTERNAL SHARED MEMORY)
> +M:	Alexandra Winter <wintera@linux.ibm.com>
> +L:	netdev@vger.kernel.org
> +S:	Supported
> +F:	include/linux/ism.h
> +F:	net/ism/

Is there any high level documentation about this?

A while back, TI was trying to upstream something for one of there
SoCs. It was a multi CPU system, with not all CPUs used for SMP, but
one or two kept for management and real time tasks, not even running
Linux. They had a block of shared memory used for communication
between the CPUs/OSes, along with rproc. They layered an ethernet
driver on top of this, with buffers for frames in the shared memory.

Could ISM be used for something like this?

	Andrew
