Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B675213E6D;
	Tue,  4 Feb 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679985; cv=none; b=iG/XgdoPxJXjB8uUUbFCykD+KcRx9x7BmnUticJhflVJG3RkA6sPQ6EDQ9pyNwGNY02db8WNiea7EXoUem0wUXA8aETw3Rb/8hn2rHh5atgh2HW6FmyGVkU3CJg0/+3UMK53Wujqapffs8VovWw1pgYLOdk/fA51Cp9yWBqdKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679985; c=relaxed/simple;
	bh=5GlRqCCgL38eGq3w5B1EVvtJfT68wKhuqhLDhkNIORY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLE8O43N/UzNPRaOa/YTE3zsChEPhHPZv5vDPYdlRRJJBna+1GmOfjF0dOy5bQexxWMYYJeoj0YfsUWLxN4BqqZG5rznvOqaRI/Am6+Fp0IoEc0969jFeGypbE1r0pdTnkdRrT0YjydIEQ4BwCzvM9bFgaHOoIBBFy/O9vpPz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOlIVxya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOlIVxya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C15C4CEDF;
	Tue,  4 Feb 2025 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738679984;
	bh=5GlRqCCgL38eGq3w5B1EVvtJfT68wKhuqhLDhkNIORY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOlIVxyaBLo+lHYsH10tybJKfOnt5svziBQJzF1nxY03A7XXA8vsvp5Vo5t9w67eD
	 zpZZce1FAgN6VAkh7/zWZAWmDNvzJRIvJTD+ew0LnIN5GuSygaXPcVNgyJXYHjLl2d
	 d6KsSI04BUt4Am9PXlyp1XfnC7rtYBX8JSjKhbirAtuvgqEiFtQdhSqh2DulXdz5Zo
	 6roYft+8AQlBd7nCImtST0+fGVRXiUHvuibaR9Yndql5XPGYQLXR8l6PFbbs+1a4fv
	 5RB1BXPXOOpyOUccUlkfIRgjtoo99XTBiYSAVkwFpeGbn6fJHdZ2VrDT5KHcz5RByP
	 1w0bWdrXdVBZg==
Date: Tue, 4 Feb 2025 14:39:38 +0000
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aswin Karuvally <aswin@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH net-next] s390/net: Remove LCS driver
Message-ID: <20250204143938.GE234677@kernel.org>
References: <20250204103135.1619097-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204103135.1619097-1-wintera@linux.ibm.com>

On Tue, Feb 04, 2025 at 11:31:35AM +0100, Alexandra Winter wrote:
> From: Aswin Karuvally <aswin@linux.ibm.com>
> 
> The original Open Systems Adapter (OSA) was introduced by IBM in the
> mid-90s. These were then superseded by OSA-Express in 1999 which used
> Queued Direct IO to greatly improve throughput. The newer cards
> retained the older, slower non-QDIO (OSE) modes for compatibility with
> older systems. In Linux, the lcs driver was responsible for cards
> operating in the older OSE mode and the qeth driver was introduced to
> allow the OSA-Express cards to operate in the newer QDIO (OSD) mode.
> 
> For an S390 machine from 1998 or later, there is no reason to use the
> OSE mode and lcs driver as all OSA cards since 1999 provide the faster
> OSD mode. As a result, it's been years since we have heard of a
> customer configuration involving the lcs driver.
> 
> This patch removes the lcs driver. The technology it supports has been
> obsolete for past 25+ years and is irrelevant for current use cases.
> 
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  Documentation/arch/s390/driver-model.rst |    2 +-
>  arch/s390/include/asm/irq.h              |    1 -
>  arch/s390/kernel/irq.c                   |    1 -
>  drivers/s390/net/Kconfig                 |   11 +-
>  drivers/s390/net/Makefile                |    1 -
>  drivers/s390/net/lcs.c                   | 2385 ----------------------
>  drivers/s390/net/lcs.h                   |  342 ----
>  7 files changed, 2 insertions(+), 2741 deletions(-)
>  delete mode 100644 drivers/s390/net/lcs.c
>  delete mode 100644 drivers/s390/net/lcs.h

Less is more :)

Reviewed-by: Simon Horman <horms@kernel.org>


