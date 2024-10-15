Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591C22737B;
	Tue, 15 Oct 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996216; cv=none; b=F7HJJr5mH6AB5bHLFt1d3fAVVVS74NhVXL24gJEbUb7VjEWHmO/khy50Le/hyMTtKX0g3wwd0Q/tBkSTRIIWaoKr1ix57QDFtGwwWpAOclz7MlBGBRbv0dHzIYejSAphqqJrKdIVIqZZPqnDmt+Jhq28EoIQLMxeZZI8GvmfpK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996216; c=relaxed/simple;
	bh=ZWCT4unIYq1W+O/Exp2i0uU850ITh7TtCh0WjgfvWPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOveJ4cpbVZpDVnPP7ooneNs/w/vLCAVQtWMJoPjO86vxm1nIDbyXTwUcgTKHdS8Uoyhq0EUk9Kp18pYqLNHTnEl4dflMdWcWm3aKCqPaOSE0dHOtmtvXP/WrmwatyPMseKM1j54V7oyVttMjj5Cif/kkQWcGegq2XxG7SH6qAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1MOSedYY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1MOSedYY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6rv/qXF2AG45spLZJQ6/wQdvmVSl9SZj1joTX6hZAXo=; b=1MOSedYY8RngIWByac5zJZQct0
	IVCD7fNTSeie6xVaT1Vk5d9EQ7D45IBDlf/k5jBhWAeQjaR7AbpWVnGd7vkqmBmoJyWOAIZhdMfD3
	tK41N6gGPnmTjoXYSSbXd4a4u5XHTdh7abhKuTYwwNdeqsocTvCSkRU0R7T5rXDOTeRo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0gtc-00A1wn-FM; Tue, 15 Oct 2024 14:43:28 +0200
Date: Tue, 15 Oct 2024 14:43:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Richard Cochran <richardcochran@gmail.com>, linux-s390@vger.kernel.org,
	Yangbo Lu <yangbo.lu@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ptp: Add clock name to uevent
Message-ID: <c9c1c660-9278-426c-9290-b9b0cb76dcaf@lunn.ch>
References: <20241015084728.1833876-1-svens@linux.ibm.com>
 <20241015084728.1833876-3-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015084728.1833876-3-svens@linux.ibm.com>

>  
> +static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env);

No forward declarations please. Put the code in the correct order.

>  const struct class ptp_class = {
>  	.name = "ptp",
> -	.dev_groups = ptp_groups
> +	.dev_groups = ptp_groups,
> +	.dev_uevent = ptp_udev_uevent
>  };
>  
>  /* private globals */
> @@ -514,6 +516,13 @@ EXPORT_SYMBOL(ptp_cancel_worker_sync);
>  
>  /* module operations */
>  
> +static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
> +
> +	return add_uevent_var(env, "PTP_CLOCK_NAME=%s", ptp->info->name);
> +}

https://elixir.bootlin.com/linux/v6.11.3/source/include/linux/ptp_clock_kernel.h#L60

 * @name:      A short "friendly name" to identify the clock and to
 *             help distinguish PHY based devices from MAC based ones.
 *             The string is not meant to be a unique id.

If the name is not unique, you probably should not be using it for
udev naming.

	Andrew
