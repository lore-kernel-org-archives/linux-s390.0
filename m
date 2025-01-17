Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5467F156C71;
	Fri, 17 Jan 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126419; cv=none; b=ubZ5l/xgxJfPm6aZAvewCKaWEo/0jrqzo8PozGLeO0JvdiyRr0WZooNlnCwK8vUEuKTUbI5LgR7IJdaxsPwgIvnw6NZ9qK0epCsY4MsdtVuV36jN9hHmdKnXuuk4jMzLgDABv9FbvvZRzRNzUmMZYP6GZMpyGqursWcf/9jGVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126419; c=relaxed/simple;
	bh=V/jljJ92FxXGxEejIrpoLJEytqN9OqM0ZWGJVqz/W/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxxJzzZYRJFWf/b9m4YYghW/X3kNl2NdAdqeRKbvFps8AhbwHiRYzyS5mbUPXscSKavUCXDsK6Fjut3jt27VMvDql4TC6id+KA31K66H5c0edmpJp9DAqDKnafGY37YN75qWzkiSNs8zm4b8yZo3AhIIz67rE5BN/ScywrzKA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1bNBx3BY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1bNBx3BY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f/7B8QXVLdoy3vXDwG+sIXdp24zEyCWlmu0MCmPkur4=; b=1bNBx3BY8SZrYIcJCdWBAq1zK+
	ASBOgp+ETm2oVs3ZEBZfUNkFcxGNQ8w5fg42sm9nZLyKionRcqgzXUsJobczc/NXKv2P4MiNxmOGB
	a80D+RD9jISGneChHLmlPj+LTdOMU3yC/KfMH6ogUiV2OvIfP8RKGVQxlEcoKCVweNL8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYnvv-005TZF-6q; Fri, 17 Jan 2025 16:06:51 +0100
Date: Fri, 17 Jan 2025 16:06:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Julian Ruess <julianr@linux.ibm.com>, dust.li@linux.alibaba.com,
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
Message-ID: <221565b5-f603-43a1-a326-3f6c568684b8@lunn.ch>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>

> With this proposal ism_loopback is just another ism device and SMC-D will
> handle removal just like ism_client.remove(ism_dev) of other ism devices.

In Linux terminology, a device is something which has a struct device,
and a device lives on some sort of bus, even if it is a virtual
bus. Will ISM devices properly fit into the Linux device driver model?

	Andrew
