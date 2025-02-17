Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D788479;
	Mon, 17 Feb 2025 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800273; cv=none; b=ibVer01m0B6dw04E45KdMLS6AtgSOpyXEK3aTzTmxhv0tcq0IcXh94P74QvrjSFASyUVNWcLAxdQ1VwNROMIZPwNQZubApQnuCMgsh4ZuwLBYxjJw3fUZLTsdhoYMwGUt+g/gHUaWF1iLqv5NeeJS/2jyQSn/H1VTSiNe2zMPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800273; c=relaxed/simple;
	bh=hzvwmczawiNcYezaSHbg9guijYcgcBnSKKfTinPfYuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFu3ypzDM9yrDhQXQuNK5qPd6tCz7LxhIr6GtGGaDlULukFYFxGlkYqhinJcn4vwA60ZPCiX/WfDnIxm+1KcyK+pLlOKTgcEjFIDu8DEwD9q6uvgnGEusq1hP9VhItIhFm+6oEd1keQj+5ZAv6LW5tus7O2OaauOaqv48DvBIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SACtIMR2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SACtIMR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8514EC4CED1;
	Mon, 17 Feb 2025 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800273;
	bh=hzvwmczawiNcYezaSHbg9guijYcgcBnSKKfTinPfYuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SACtIMR2KT7GPqvw3gkSdxrD2LEWQM6T1+2+pXBJZMs96axEsl4unCQhzywtseVnX
	 tFCvr2Mv3KzUSkyIL2bdMBN2xkkSR2XnhW7HFe1XGShdNE2V6k+1ub2WWfe25/Pj/T
	 4Ga6+nL+whhGEkJkqiNc7/9F+xRUQov2RCVJEuqdeG8fcen4h3LyL6vMToj/6uKkrf
	 mQpnzQdWwWj1q19uk/BTwnQ5o1g06tsbE1tfxspU2GwiFA5uxRG5C1etQf/Kais3mf
	 6o+CFu3CXv9W4HGpTarO14Umo0qhGvwHmSm1pZa0E5KcCCCyRyHyAwljsjjdEZj12L
	 RFVq7PnH3VBQQ==
Date: Mon, 17 Feb 2025 13:51:07 +0000
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Julian Ruess <julianr@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>
Subject: Re: [PATCH net] s390/ism: add release function for struct device
Message-ID: <20250217135107.GL1615191@kernel.org>
References: <20250214120137.563409-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214120137.563409-1-wintera@linux.ibm.com>

On Fri, Feb 14, 2025 at 01:01:37PM +0100, Alexandra Winter wrote:
> From: Julian Ruess <julianr@linux.ibm.com>
> 
> According to device_release() in /drivers/base/core.c,
> a device without a release function is a broken device
> and must be fixed.
> 
> The current code directly frees the device after calling device_add()
> without waiting for other kernel parts to release their references.
> Thus, a reference could still be held to a struct device,
> e.g., by sysfs, leading to potential use-after-free
> issues if a proper release function is not set.
> 
> Fixes: 8c81ba20349d ("net/smc: De-tangle ism and smc device initialization")
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

