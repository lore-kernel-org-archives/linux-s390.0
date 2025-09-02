Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F1732F742;
	Tue,  2 Sep 2025 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803291; cv=none; b=P/EzWiZgRJa91SWVPQxFKrRS7tf9Be9l4DA/YybHbPiTP2egPaVerFNQfeuHfrfgZpzijP3mxXqei9aI0uGjo0AUaGfT7QcRYHqlfkiy0fASXvlmL0k3GQmKjfY7mYST+nDegqRaWZLYsEd7awQ5AUxbtEeJSLPIzHPkMMTtN/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803291; c=relaxed/simple;
	bh=ZOtrD0KP+Yh0ShEDS8gthyZ8FS3ncpf9YQ3jE+Cn4f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQKP1zmVWubh9oOij2RgLadaMKK6jci0Dy6u/i2Vhz+753N+OgXJhU3RPpRg4tLcy+JRx+dC435O+6oABvQSskqez9aL+jsdw5qgnuZwDCUkRsQ7z4WaIGHfl5eDDprcgHiqqI8C6s/ANa2mVlaKh8r3T9hUUxwWLWc1NtX93Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKtgqaEo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKtgqaEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86972C4CEED;
	Tue,  2 Sep 2025 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756803291;
	bh=ZOtrD0KP+Yh0ShEDS8gthyZ8FS3ncpf9YQ3jE+Cn4f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKtgqaEo57Csi7sLGjsyQqZ5/WDNEn2su5IZItSziGNrMElvNkuejjvtZv5gLeLIO
	 p88tISSJR8pGaTaHi3OtDu2zeT+isM7c4Sb9bGpHmi15FXZYDJzw/6t+iPZ2kV+8nP
	 rnaz0AUuzB6I6aLVgJ3lya111K8X3V5Pt6cFX4H644wEAOFszJsLlktFQg5MjyS7V/
	 dq54WT0IDu0NlvNqdU7sy5W5Y5w+Jjut/oI3GAwFSstkCwHHCkvPNB4Y3had9Vromu
	 ksJ+FFej1JLA2tA1RzYCrAQdHU+P0ouX5gyyYbwVudYVUnKXTDz1ofFJ6SI5Crgzqq
	 juGkgHueIKG3Q==
Date: Tue, 2 Sep 2025 09:54:45 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH net-next 2/2] net/smc: Improve log message for devices
 w/o pnetid
Message-ID: <20250902085445.GT15473@horms.kernel.org>
References: <20250901145842.1718373-1-wintera@linux.ibm.com>
 <20250901145842.1718373-3-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901145842.1718373-3-wintera@linux.ibm.com>

On Mon, Sep 01, 2025 at 04:58:42PM +0200, Alexandra Winter wrote:
> Explicitly state in the log message, when a device has no pnetid.
> "with pnetid" and "has pnetid" was misleading for devices without pnetid.
> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>

