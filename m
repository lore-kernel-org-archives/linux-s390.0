Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DB28134C;
	Thu,  4 Sep 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001548; cv=none; b=Rnl+Nel3kp0fUe+2fhGGRgqMJsuKtFT0nbE3dkpYceOwae4yf/Jz4ofpLv2jIDTGZc8C/sMLvF8DQLh7mZL187dtJoDPy9m39XVYuWYa35PFbVy0dWzW1fMT9F74JXMthphBhjusvY3aTim7bdeWKDp/x6qgZnhZeMZ6JKLxYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001548; c=relaxed/simple;
	bh=C9K3mATTMCVXm8B9iVeoBJs3jciX6IH4B2lYBh6u8NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPNCwv0lJE2gQMiFp6fdj3R0xTKvD/il5Q5d/+Z/bwmlAB26xTGaNIloHDSt1u1KGTyZBlDSJY++0pL2suUhOPDU1xGz2FmgNkdwUs1vD/y/e/89uCtqRKnAdQvpQ9juWnYdlIWazyrrtu6JBFfplaOjwMta2YqirqHD/LODjpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN/QyGpF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN/QyGpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C88C4CEF0;
	Thu,  4 Sep 2025 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757001548;
	bh=C9K3mATTMCVXm8B9iVeoBJs3jciX6IH4B2lYBh6u8NQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LN/QyGpFrWmbI8PW1MxG889LKdS4tEwBzCh2IRA6EmVHWwHykCdb5CObKfh+4+9M1
	 Z19z6WBd9t2ECgrMX97CcY2aHIpW9G3MGmtyvCvLs9WaS9rupfDPkvP72bPjnP6h9E
	 gzYXkBEbYIbkS7hhfQVXkK7gsqpOc5+u0+Bp5/4Hc/ZmQEcdrsnSNywcE1NP3O60/B
	 KRUMPHhXsOjB/B5JjlZX0VSTCMtguNtZSRi27szaQanR0pQ4HtUhyGbFM5GYCewWvK
	 NAkD+iwB859vkg/SOdLr5rMtcCRYu98ZnCNgXWQE0uGTvLzV+gydok+lfQLkU4f86+
	 rPb6agZCd2dwg==
Date: Thu, 4 Sep 2025 08:59:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li
 <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Aswin Karuvally <aswin@linux.ibm.com>,
 David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Mahanta
 Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen
 Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 1/2] s390/ism: Log module load/unload
Message-ID: <20250904085906.46d9bfe0@kernel.org>
In-Reply-To: <5177c2da-4158-4b12-996d-831ff1ab0708@linux.ibm.com>
References: <20250901145842.1718373-1-wintera@linux.ibm.com>
	<20250901145842.1718373-2-wintera@linux.ibm.com>
	<20250903164233.7b2750e8@kernel.org>
	<5177c2da-4158-4b12-996d-831ff1ab0708@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 09:16:27 +0200 Alexandra Winter wrote:
> On 04.09.25 01:42, Jakub Kicinski wrote:
> > On Mon,  1 Sep 2025 16:58:41 +0200 Alexandra Winter wrote:  
> >> Add log messages to visualize timeline of module loads and unloads.  
> > 
> > How deeply do you care about this patch ? I understand the benefit when
> > debugging "interface doesn't exist" issues with just logs at hand.
> > OTOH seeing a litany of "hello" messages on every boot from built-in
> > drivers, is rather annoying. Perhaps this being an s390 driver makes
> > it a bit of a special case..  
> 
> tl dr: I don't care very deeply
> 
> I think s390 users care a lot about debugability and are less concerned
> about log size. As you said, many other modules (on s390) have these
> 'hello' messages, so I kind of expected the ism module to show up as well.
> But if you want to reject it, we can live without it ;-)

Let me take only the second patch from the series, then. Thanks!
