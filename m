Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF90347BBD;
	Wed, 12 Aug 2026 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786506867; cv=none; b=Bi3xFflcsIQ70F0cOpXndxpBUoFwpfaT9GWMriFo/X8kJkK6sPK/YDJdjBaQMwvwugIb4vGid0jSsA6B8d3+MTTNPezvUwEuFbl7Spfv9GM9ByZTXF4K1HwsC6gnUk8/fyi4CAsGuHvQFxwkx6ax2BqYLdC2UIZVV952rNtefUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786506867; c=relaxed/simple;
	bh=F4EWO4JIvsqQHphpsZ2MrVDf71DIvss2MYn0Ml431K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv32ppkAXfRPm/HIvML5cfVYId8JWBH8DYeXGYyw3rZa+90YB2JI8mSGTcCZ1Fpb6gnjydjHX5AYhNl0rqyUDDvvqjiFOv+xtP27SdE65fEceN3TiwPICi2UiQYOhMvgAyMh0cw90OBTZbcxDNwJfZHF8aSIqdUbsNJNSBU5OjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EU7rFHFT; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EU7rFHFT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786506861; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=F4EWO4JIvsqQHphpsZ2MrVDf71DIvss2MYn0Ml431K4=;
	b=EU7rFHFTrPkdYdaZ4eRNdpGw0Gup6bMiEEoznviiAfUZyFNkmNepd5ZYJJWljU3bc9bwanYlJ7m4svZ6U9rj0yrxS0aGx2SnHwAbQymJ1KJedNmAs9CImIGPu8T/k5K282b1aL6pceod289m1QzSCHzrbDWt8NRd2OpQ/LugTnc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X8qJ2yl_1786506860;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X8qJ2yl_1786506860 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 11:54:21 +0800
Date: Wed, 12 Aug 2026 11:54:20 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, stable@vger.kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net/dibs: Correct freeing of dmb_clientid_arr
Message-ID: <anvubJLzPJX2N9-u@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260810111432.2334900-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810111432.2334900-1-wintera@linux.ibm.com>

On 2026-08-10 13:14:32, Alexandra Winter wrote:
>A dibs device interrupt handler can be active after dibs_dev_del() and
>may still access dmb_clientid_arr. (UAF)
>
>In case of a failure in dibs_dev_add() being called by dibs_lo_dev_probe()
>dmb_clientid_arr is freed twice (double free).
>
>Free dmb_clientid_arr in dibs_dev_release() after last reference is gone.
>Note that allocating in dibs_dev_add() instead of dibs_dev_alloc() is ok
>for now, because no dmbs can be registered before dibs_dev_add().
>
>Fixes: cc21191b584c ("dibs: Move data path to dibs layer")
>Cc: stable@vger.kernel.org
>Co-developed-by: Hidayath Khan <hidayath@linux.ibm.com>
>Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

