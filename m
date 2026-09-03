Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C06C4D90B4;
	Thu,  3 Sep 2026 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448974; cv=none; b=LlE/iaJa0Dck9KnSR0Du6CF6l10se6X916qsn2DRM69cnEps4uTRqMrSC85KjqT1P/BQ0WPhl7HlekydGR6tr9nmFthKppE7fHL7dmwdu/EV7L/TxQNLrIEyG+ugGetrsuAgKbvxexyfIspHsAzvUcDq5+qWCmGWqsEd8Nf8EME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448974; c=relaxed/simple;
	bh=nnx1EfT6SwqqGELd4rFK/vdFpOex6T61iq96BysZz1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jvi0FRdA+SyosQbu/4k0cbi34+yfCILa/vRriXVjhTAZdnr0DrdzZooJtT6a2OUqepV/TZa0r2lp/SQyBicGfq9xwf34jeookTWNvdJIL9cEEBQeI9nwGXKiO1MTlW8k0vJJZEukvfbZVj3sMyJUJDQhVcaLWSzhq2vzdTeom4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcnC1dpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcnC1dpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCA21F000E9;
	Thu,  3 Sep 2026 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448972;
	bh=21cCXr0X2DjsXESFCscBUyGKzZA8PXymS9EiSyFzEzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dcnC1dpcEalabik8BQ3D4008MOsKQYZw4KTmO+x2pG3UdYeRSt86vsn/OPMgCysKQ
	 veQOLx0QPyKpz7EKh3P/ueR7krMrR5QJ9FUreobY6Z3vU2ZoS4oeoSjuDUyudVkHnM
	 WQIKrBbtgacdOycs6v3IgsDp5XwGDsB7YU7ssVtbr3nJQBomoly9aHVGO0ac1ki9OC
	 0dJxqgL2tAiIIX2Nc2uYVivZG76xWSwDgzK1o+20OvKQVzUyiO2pcbssQko/zNKPft
	 DhBQYTrl3um7OoaGSKffw0nn3yOHw+PHsC0XzdCSMJ9KWEr6hLXSl+wjJtbhxevFLA
	 4CNLzjdI00hGw==
Date: Thu, 3 Sep 2026 18:22:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: s390: replace page allocator calls with
 kzalloc()
Message-ID: <apmQxu1QYcvTyVtS@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
 <20260902130612.41500808@p-imbrenda>
 <apghz4XAgv0ro15t@kernel.org>
 <20260902165315.06996af6@p-imbrenda>
 <apkqHLgg7nqBiYW7@kernel.org>
 <20260903150852.518d6cdc@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903150852.518d6cdc@p-imbrenda>

On Thu, Sep 03, 2026 at 03:08:52PM +0200, Claudio Imbrenda wrote:
> > 
> > The only place where __free(kfree) is completely safe is handle_sthyi().
> > 
> > In all the other functions using __free(kfree) creates a mix of of goto
> > and cleanup helpers and cleanup docs advise against mixing them:
> > 
> > https://docs.kernel.org/core-api/cleanup.html
> > 
> > The cleanup paths are quite involved in these functions so using
> 
> it looked trivial when I gave it a cursory glance, hence the reason of
> my original request, but... 
> 
> > __free(kfree) there is really not trivial.
> 
> ... yeah, it's actually not trivial at all.
> 
> 
> maybe refactor the first patch, and leave the rest as it is :)

Yeah, that's what I've been thinking too.
And leave the rest to s390 kvm experts :)

-- 
Sincerely yours,
Mike.
