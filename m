Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4F79DC7;
	Mon, 18 Nov 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944660; cv=none; b=Ppwon3F6BtD7kNtLuVN+v2TXAYf32jXZcZuloXVMyIx4A1ACvm/fKdCXPn4U1PBn0CHnffenA/WmMfRsyBCZmcRgK4IN+GbVDKIK0EZFAHlXR7iSfJaiDlfmbiViSZe6LbwtrcyVhLuJmCdoukpmq0eqQAiKL+mSyCliCrS9G5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944660; c=relaxed/simple;
	bh=6lfS5m0L5sAIIFt8Olzxk6U3G2hwwOEHH7gfpjErpxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp4plNKVW69dmXcnUB5sq+GyhnKVGKQqTHVYm3VdM8xMZKaG9UB1p28krZv5vnhmGW9LUGJUzU9nwXfQN2NDSQI+5Gs5NxqEOlySxIjPfk6MEHWy5t2j81Zsh6AnsfCDXH4daE2Ol8HYitC2feUxMuF5hF5B4LrEMQrjB2ElEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ckg/Vk0s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ckg/Vk0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FFCC4CECC;
	Mon, 18 Nov 2024 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731944659;
	bh=6lfS5m0L5sAIIFt8Olzxk6U3G2hwwOEHH7gfpjErpxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckg/Vk0sB0utTnyYclq9aYw8ZIt6rOgyYWigZJV+xIyZ90ZFurgr/jmJ0XITw4Hxs
	 AYQHlUUJAD6TBWqWhidg89x4ildm/+wSHYeDtX9m19PRqUo5UU06vKefhAg4xNjF4f
	 wGDEhxe1xbd6p5nHKb0MKlonT3X9I1Y90krxcnDY=
Date: Mon, 18 Nov 2024 16:22:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] sysfs: treewide: Remove spurious NULL in
 attribute_group definition
Message-ID: <2024111856-busboy-unglue-1022@gregkh>
References: <20241118-sysfs-const-attribute_group-fixes-v1-0-48e0b0ad8cba@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118-sysfs-const-attribute_group-fixes-v1-0-48e0b0ad8cba@weissschuh.net>

On Mon, Nov 18, 2024 at 04:02:46PM +0100, Thomas Weiﬂschuh wrote:
> Generated with the following coccinelle script:
> 
> virtual patch
> 
> 	@@
> 	identifier ag, pattrs;
> 	@@
> 
> 	  struct attribute_group ag = {
> 	    .attrs = pattrs,
> 	-   NULL
> 	  };
> 
> This series is meant to be applied through the driver-core tree.
> 
> See also:
> https://lore.kernel.org/lkml/71fe4030-d6a1-47da-b8a7-28b899187168@t-8ch.de/
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

All now applied, thanks!

greg k-h
