Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBECE19939D;
	Tue, 13 Aug 2024 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553018; cv=none; b=pYApqFzwLmfy3/pEq5hSfXSum7OxwfyCSkkp+MUj3C1vbWtxfiK0J80YObIeDgRlfhq2a9HVIh6Byz28WKldko8U5VjOhsZWvYDWs4L+edpvCG+34qoHfXNusvshyDPcrQOgIKqLpbqVpn/jEAVRvzkAJrK7K2L4pspoFnx48oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553018; c=relaxed/simple;
	bh=8SpAdCfcOGfPx/9MIc11is1FDD4tSCNpH/3NtkY6SEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWeEiHZ2J7Tr8kH7HZDQYR2o8i7cbdsGQAySvXVO5sfcHeXIa7Z/vQwJrQAjmMcVXenmSBoEMPAh5kYLXMitMhoBIwdrnH+3w4Jpe8KT3Y3cPddAeI8+91fZg9RdXBesE4cJTd20EwlmV5UXrsvhCzoRTvfi8VzNH+0C3+0jb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HOsphgAY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HOsphgAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9843BC4AF09;
	Tue, 13 Aug 2024 12:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723553017;
	bh=8SpAdCfcOGfPx/9MIc11is1FDD4tSCNpH/3NtkY6SEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOsphgAYSpeQ0o1oTt4xHEkcLPU5W8kW1vKYs6l7Kb/ugYmo6QCOCIQhF0q2Kb5Lp
	 pjaUurUjJw+lE1ccQRo3dcOQBgZy6oLXp0hu1FEeHmyCuiF6g5Xd6r8X4z2aYq02BM
	 pId3ctnXJ1w+Wdnp458rXbQwy9J+r9sAA2upZIUc=
Date: Tue, 13 Aug 2024 14:43:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alexandra Winter <wintera@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/iucv: Fix vargs handling in iucv_alloc_device()
Message-ID: <2024081319-patriarch-brutishly-653f@gregkh>
References: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
 <patch-2.thread-d8267b.git-d8267bded9e9.your-ad-here.call-01723545029-ext-2515@work.hours>
 <2024081331-bonnet-fiftieth-9a14@gregkh>
 <your-ad-here.call-01723549827-ext-8444@work.hours>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <your-ad-here.call-01723549827-ext-8444@work.hours>

On Tue, Aug 13, 2024 at 01:50:27PM +0200, Vasily Gorbik wrote:
> On Tue, Aug 13, 2024 at 12:52:19PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 13, 2024 at 12:42:37PM +0200, Vasily Gorbik wrote:
> > > From: Heiko Carstens <hca@linux.ibm.com>
> > > 
> > > iucv_alloc_device() gets a format string and a varying number of
> > > arguments. This is incorrectly forwarded by calling dev_set_name() with
> > > the format string and a va_list, while dev_set_name() expects also a
> > > varying number of arguments.
> > > 
> > > Fix this and call kobject_set_name_vargs() instead which expects a
> > > va_list parameter.
> > 
> > I don't understand, why can't dev_set_name() be called here?
> > 
> > Calling "raw" kobject functions is almost never the correct thing to be
> > doing, ESPECIALLY as you have a struct device here.
> 
> struct device *iucv_alloc_device(const struct attribute_group **attrs,
>                                  void *priv, const char *fmt, ...);
> 
> va_start(vargs, fmt); initializes vargs to point to the first argument after fmt.
> 
> __printf(2, 0) int kobject_set_name_vargs(struct kobject *kobj, const char *fmt, va_list vargs);
> 
> __printf(2, 3) int dev_set_name(struct device *dev, const char *name, ...);
> 
> dev_set_name is expecting to receive individual variable arguments
> directly (...), not a va_list.
> 
> The (...) in dev_set_name is meant to be expanded into individual
> arguments, but when you pass a va_list to it, this expansion doesn't
> happen. Instead, the va_list is just treated as a pointer or a single
> argument, leading to undefined or incorrect behavior.
> 
> So, would it be okay to reuse kobject_set_name_vargs() here, or would you propose
> introducing another helper just for this case? e.g.
> 
> int dev_set_name_vargs(struct device *dev, const char *fmt, va_list vargs)
> {
> ჻·······return kobject_set_name_vargs(&dev->kobj, fmt, vargs);
> }
> EXPORT_SYMBOL_GPL(dev_set_name_vargs)

This function makes more sense if you really want to do this.

But step back, why is this needed at all anyway?  No other subsystem or
driver needs/wants this, what makes this api so special?  Why not figure
out your name beforehand?

thanks,

greg k-h
