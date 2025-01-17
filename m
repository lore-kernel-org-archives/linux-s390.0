Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185F1802DD;
	Fri, 17 Jan 2025 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126153; cv=none; b=T/h7yWpHcDer0yzTN8eMrvFt3I9B87Acsw8rCmF/GoB7G6XuOgu6uEXKO40EtZVd1d96FlyUk+abzrNgy93ClS4p8NYh2b2hfe2/S/8hQvU5tFHAHJpwPl4k7k2gdJ+VVjV6X41ehFOh+g/o5h6X4pmA5i0frV6QxZLG5svLKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126153; c=relaxed/simple;
	bh=5u1aCDJRoRtopLSP7tLetQzvVTV/xaX23QH4DKxs73M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdKpr3KVbIH1PxL/SOP8/1ZPI+j9WS+Z06PeaxKM+a8gpOo65pnHt6FPZ3fccXs0zwxjhg55Vhg+62ZqUyvZ0cKKrNUVZH9TFDOwvRjAw3//Fd7Ezm2H6bjqjl1/84g9sGwF+cWKYiqqqR78tGV51S1MqGvH1XAou0qVcY+Vdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6VVR5Fr6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6VVR5Fr6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iDFUI3EKbWCHKQNh4orApe44umb7TTdO5o5W/rrOWG8=; b=6VVR5Fr6I4Ied2GfhbHGqzXEZs
	OzKLPhHrg/3J5WQ4t8QyK4oq9rr9yIPRNS3pNJeJblCumqWL2SC3HBu07W/8zy5g8ETyRuqdja7Np
	aCLwDKrK4Xda1qEQlaxZ+rf4qCONFN4k4mIvavSJOKLpt8zZrUCysVkZq58K0ix9LyHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYnrZ-005TVQ-DK; Fri, 17 Jan 2025 16:02:21 +0100
Date: Fri, 17 Jan 2025 16:02:21 +0100
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
Message-ID: <034e69fe-84b4-44f2-80d1-7c36ab4ee4c9@lunn.ch>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>

> One important point I see is that there is a bit of a misnomer in the
> existing ISM name in that our ISM device does in fact *not* share
> memory in the common sense of the "shared memory" wording.

Maybe this is the trap i fell into. So are you saying it is not a dual
port memory mapped into two CPUs physical address space? In another
email there was reference to shm. That would be a VMM equivalent, a
bunch of pages mapped into two processes address space.

This comes back to the lack of top level architecture documentation.
Outside reviewers such as i will have difficultly making useful
contributions, and seeing potential overlap and reuse with other
systems, without having a basic understanding of what you are talking
about.

	Andrew
