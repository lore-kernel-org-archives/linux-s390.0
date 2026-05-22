Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E832860F;
	Fri, 22 May 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779465313; cv=none; b=M+dBq83F2e+bN6gqSdhnmcXztrSDjGdwxqRJf/kgKh0w+zEUzrbzJSwF/dA8yTuowc0kjqxAaKPgn8qDkcfWRIUeseq9yShIPdzqrinzaTJPAWW1+XgAQau5P1YAaOQZQg36Dn0vWNWD72IYjeoj5PrcNpCBHFY+a5qxUCUlzVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779465313; c=relaxed/simple;
	bh=2vUOQX28fcWPAdZyJSyPy5BiasfePVXr0r8Ywc70B/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKy+2JzMxnvbc/7UOPpyhI7BoIf/8VxVwS+BRkGecK97Mpq4tLspiwaq5yEQk2u9pg9nBk3W8vmbrFb1FrwPc2DZU+TQfR0kLuU6p9cp9jrH6y+0+ICFMbn//piBr3+ThEFqu+jVbQheYiJaRWU3qfk59FPQuh5tZsnjzqUjGNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XcwX1EPY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XcwX1EPY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=FhSkrdaLm6vSv+HMGEdqTeJFHr/z5Gin43///DqwEX8=; b=XcwX1EPYmTlkZZ0lzOl6z8rpM5
	ls2yZCQAO3dIJ13HGmAEe0MFe2+j3L2xIc61NPHjKxNMIC5L9XvvZ47BIx3GOa3pugcgpLOc4Xy7N
	cNZ7pzONQd13hLeNjmAZhMtd1Ob6QlqUuQOFtDhsfb/ISwQuFfmlb2Vmg8Yzas9hXhF9beQSUe3t9
	iJ3wy6tUhgR8e1JLsHsM00GLpdtoGETGTYhzjE/orfOLR50Q38Zm20Ko5NjpSBhPmH2e3uAjzTGFH
	4atV4KqRnwkSarxB3iJco5Sb4/VPZ8QIPuYq8APEgP0CMXprw0gIFZhHa1cQ6g9542CjR5XGpV8V+
	X36Vs+wQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQSDH-004lxA-0X;
	Fri, 22 May 2026 15:55:03 +0000
Date: Fri, 22 May 2026 08:54:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, 
	Aswin Karuvally <aswin@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] s390/ism: Drop superflous zeros in
 pci_device_id array
Message-ID: <ahB7_10zHxM2HQWG@gmail.com>
References: <20260522153010.777081-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522153010.777081-2-u.kleine-koenig@baylibre.com>
X-Debian-User: leitao

On Fri, May 22, 2026 at 05:30:09PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Subject: [PATCH v1 net-next] s390/ism: Drop superflous zeros in pci_device_id array

Nit: s/superflous/superfluous/ ?

> The .driver_data member of the struct pci_device_id array were
> initialized by a list expressions to zero without making use of that
> value. In this case it's better to not specify a value at all and let
> the compiler fill in the zeros. Same for the list terminator that can
> better be completely empty.
> 
> This patch doesn't introduce changes to the compiled array.

True. For a `static const` aggregate, omitted members are
zero-initialized per C99 6.7.8, so dropping the trailing `, 0` and
collapsing `{ 0, }` to `{ }` is a no-op at the object level.

> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
