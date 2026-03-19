Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2127A462;
	Thu, 19 Mar 2026 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928578; cv=none; b=QdJX4Yw6Zcl5KXBMzQ7kuMevSaBuWCPXbsEyk5fk67IKEwMzTk9vF82oV50iuKOhM5dIwzYTnzkKQWnHvHJUFDvqgpC0fuI9T7AwOLE16mrnf/ERdkuIaEisYUJBKBEXxIAn7Ihld8UGzD5Bg7R+AJho6jDs/xcGtgULKMpC9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928578; c=relaxed/simple;
	bh=kmC9X9e1+aC88eZ970o5/ADKNmuX/bTenxkucFXc6Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGbWgEBZukiTfkKtav1I3gb3kDdACmyhBULBZjk6zMP5g2LH7Y/Ka+jiOcDeVE2Bqw1NIsTLCoh47ZdN1cY93PFsSRTYQJlwhJ1rICqvUv8GVU6h6R42T9MNMorm4lZzJfNhEj29SVcFZTJyPlNh5oM+qasogkQEGBT1Ubs1JTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KzyRrgMd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KzyRrgMd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MtMXm2cz6rDotgwWtpH1+MWFu1U1GKVcfoONVmXnkpE=; b=KzyRrgMdKlittS/CJM3wwYn69g
	buNaYw1n/kjCcE56/jy5ai1dGKY47ZskL5mWvADYmCO9lXsH6KoPwRb2y57i70HbW0m8zlImIWn8j
	8tuFXsiyzjd1LK2ux+xsfz3ZDqNxR2kjFM0xMS8Tsc+f8pjQwqRrMyAesSEFEicRdV9RR2JGrr+G7
	FQpxQC97nvtyz0BA89qbyOhId2S7z3CrsGsjUi2uUOb2rUHigGP9pCIQcRa/tjE31gXLCupeBUMzg
	HZWTany89eF4bRI7LV+7nj6J2uni9InpojY2KuM6j6Pr7+bYh3siy4BqNaHfIUNKjXr/xP7kJnGRz
	YbbVaaDA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3DrC-0000000DcTm-0u3o;
	Thu, 19 Mar 2026 13:56:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3422030029E; Thu, 19 Mar 2026 14:56:12 +0100 (CET)
Date: Thu, 19 Mar 2026 14:56:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/9] s390: Improve this_cpu operations
Message-ID: <20260319135612.GI3738786@noisy.programming.kicks-ass.net>
References: <20260319120503.4046659-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319120503.4046659-1-hca@linux.ibm.com>

On Thu, Mar 19, 2026 at 01:04:54PM +0100, Heiko Carstens wrote:
> v2:
> 
> - Add proper PERCPU_PTR cast to most patches to avoid tons of sparse
>   warnings
> 
> - Add missing __packed attribute to insn structure [Sashiko [2]]
> 
> - Fix inverted if condition [Sashiko [2]]
> 
> - Add missing user_mode() check [Sashiko [2]]
> 
> - Move percpu_entry() call in front of irqentry_enter() call in all
>   entry paths to avoid that potential this_cpu() operations overwrite
>   the not-yet saved percpu code section indicator  [Sashiko [2]]

Would it make sense to add arch hooks to irqentry_{enter,exit}() ?
