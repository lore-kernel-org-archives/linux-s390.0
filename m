Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B0239E79;
	Sat, 31 Jan 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769893893; cv=none; b=IB1t6X9kgsZyGvEz71TZeozoWWxyWakHVB/k9UEGQ/8igB+p0cSBf03Vhzdcsu8UFk1X2UPQRi8OrbwHhjIT8+P9svp3DsS7R1a6ewVM6rSH8QoYi2/B9hzn6FWm7nhyxeRo98LMR9ZSabdzPZrydiFgrNPel6OoJmyjxEnPp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769893893; c=relaxed/simple;
	bh=ZmumTbCrYT1hQwjIqNBI5dJ3+Tbzc2Y1urg6lmvFMf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrjVmmytH7AXSyvi/FSo/t805C7rRGfc6XLVtoLV3MqGh1B/weZXVdkX/FXkqXA72pOXNTsnPadxrF1nJXhp7XggCwvhwuzPyoRcI24Xa9TAg1me4wm0oYnrkj0ph2e10yfvbEnkfrPIxGpcEM0b3Ql+cNKXAQZPj8qJLAY6apU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkcaNEBV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkcaNEBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813E4C116D0;
	Sat, 31 Jan 2026 21:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769893892;
	bh=ZmumTbCrYT1hQwjIqNBI5dJ3+Tbzc2Y1urg6lmvFMf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AkcaNEBVGUjZQcywaG27We4ef05UleeONxr40wrNdOdDk/iMRlfWjgB5Baykdm+ef
	 Yo+AlLqTuNyRX6wB8vzaq9ZRuqo+jLS9cMoWGvcOv7t8E8LNFO6BVld7Wjb/L9aRry
	 aHH4xYceNbUIf9r/sabiVurdyPBg+RCrnVzfG4NzmpOKuBskjTbJ8l8anV2B3d9Ttp
	 m1msRvu53zhuXuGSBV9KvcvGSkY6v4JUJ4p+7M32+4bMxi+rtLbMpVItA7TwSXKe0L
	 X8/JHMQL0H97pfdBYS+iYfGYkhmTHItDjmaF7/oOPVg40rDZEM7gDMrfN6iPkcF6jG
	 dP8kI0bsxJC8Q==
Date: Sat, 31 Jan 2026 13:11:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next] net/iucv: clean up iucv kernel-doc warnings
Message-ID: <20260131131131.0d854805@kernel.org>
In-Reply-To: <20260130054759.1301608-1-rdunlap@infradead.org>
References: <20260130054759.1301608-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 21:47:59 -0800 Randy Dunlap wrote:
>  /**
> - * __iucv_message_receive
> + * __iucv_message_receive - Terminates an IUCV path.

AI code review complains this is odd wording since the main body
describes reception not termination.

>   * @path: address of iucv path structure
>   * @msg: address of iucv msg structure
>   * @flags: flags that affect how the message is received (IUCV_IPBUFLST)
> @@ -374,7 +363,7 @@ int __iucv_message_receive(struct iucv_p
>  			   size_t *residual);
>  
>  /**
> - * iucv_message_reject
> + * iucv_message_reject - Refuses a specified message
>   * @path: address of iucv path structure
>   * @msg: address of iucv msg structure
>   *
> @@ -387,7 +376,7 @@ int __iucv_message_receive(struct iucv_p
>  int iucv_message_reject(struct iucv_path *path, struct iucv_message *msg);
>  
>  /**
> - * iucv_message_reply
> + * iucv_message_reply - Refuses a specified message

Same here, refuses or replies?

>   * @path: address of iucv path structure
>   * @msg: address of iucv msg structure
>   * @flags: how the reply is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)

In general -- Could we possibly delete the duplicated kdocs in 
the header. As clearly shown by this patch it's double the work
and kernel-doc will be able to find the definition wherever it is.
Kernel coding guide recommends kdoc next to definition.
-- 
pw-bot: cr
