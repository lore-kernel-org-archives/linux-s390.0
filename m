Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4E19A288;
	Tue, 13 Aug 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546342; cv=none; b=F4SGvxOInh+tyM0d76c3K6cTCG4TwI810w0Ts8LqeCPhbU+poAodkzCNOdwNCnfK+TrNVWzVYRqm4eQBGNJJcqRGfuNQGIgo0+qEeCsTOBxf0w8FqGgUZg3CkZV/GXiF+ZkUaNbV7moukZwuCn9mtPmpSTOHQh0bIwOxtUL4rV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546342; c=relaxed/simple;
	bh=gbRjCyS9Mj5FwV06RkuYCeTtKVigXVOnoW8CteIpMcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVoLFcDPIA1Cz3uYKHmbjkvtX0jBNCFmhxv7ZOmtQW21npUGbck6/dqS45PWAcsmZfxf41IvG4tJDNXqa53yuhdu0tQ+NPmH+8MhSSU1SB+gKg77BqkWiBCkTiTOMmngN8pZZkkaXt9T9tkUpjgvP7ZumMpYfedfFgnOYUZyRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WyYqUWeC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WyYqUWeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5B0C4AF0B;
	Tue, 13 Aug 2024 10:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723546342;
	bh=gbRjCyS9Mj5FwV06RkuYCeTtKVigXVOnoW8CteIpMcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WyYqUWeCQ1pA3HCg2rrn7tr7k9c20JMN+PucK+924UXnvCjHQPY/1OLgb6x8tvdkH
	 LGNfxVFOQ/xJtJLKUM6c6BnOyz98WPcxGwdg/gN9Z39N3WmLV47CHJlR7S+MGCdBkz
	 cduXsEGP0fXhnS6y3MtO9AlQJeUBOxef7ZEOlk7A=
Date: Tue, 13 Aug 2024 12:52:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alexandra Winter <wintera@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/iucv: Fix vargs handling in iucv_alloc_device()
Message-ID: <2024081331-bonnet-fiftieth-9a14@gregkh>
References: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
 <patch-2.thread-d8267b.git-d8267bded9e9.your-ad-here.call-01723545029-ext-2515@work.hours>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch-2.thread-d8267b.git-d8267bded9e9.your-ad-here.call-01723545029-ext-2515@work.hours>

On Tue, Aug 13, 2024 at 12:42:37PM +0200, Vasily Gorbik wrote:
> From: Heiko Carstens <hca@linux.ibm.com>
> 
> iucv_alloc_device() gets a format string and a varying number of
> arguments. This is incorrectly forwarded by calling dev_set_name() with
> the format string and a va_list, while dev_set_name() expects also a
> varying number of arguments.
> 
> Fix this and call kobject_set_name_vargs() instead which expects a
> va_list parameter.

I don't understand, why can't dev_set_name() be called here?

Calling "raw" kobject functions is almost never the correct thing to be
doing, ESPECIALLY as you have a struct device here.

thanks,

greg k-h
