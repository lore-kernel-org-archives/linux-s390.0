Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5481A3172;
	Tue, 28 Jul 2026 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200810; cv=none; b=iWkuYEk60yEExXM995N5BoExrvdHeo9nOMNcdmB0K4kedWKVV6+WHRbhaGg6eMxIHQT0XVQlkAnpw2+Qtu+I8e9oXxYu2XRMJLK4Xl1AwoW4ZLCIItoYWpK9yc8sfrgjxCiAHLVKjiJ89h21QLooGp+iOVORK+NhvMX39svurZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200810; c=relaxed/simple;
	bh=hsEJvIzg0mivL80m11vWrUA82WYhGxsQLthUIZn6kFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzv+G9UF5fFkgond0RAUvPFYQzzIE9Wyk6d460SuS9J0a40UsAUGJJyR3ACByIUm7ICF6NfvYGfLV++nEOoqtC5itHtQmz4z6XwypcFkRz9CLm5Hc4vDy5ceggjTRMJcrcNWpsiPrcrRO0nBj5LlEESx3dk5nt4d2lXb8rMS7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ/bA3OC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ/bA3OC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DAF1F00A3A;
	Tue, 28 Jul 2026 01:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200805;
	bh=hsEJvIzg0mivL80m11vWrUA82WYhGxsQLthUIZn6kFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BZ/bA3OCrgaMwnKUFoWMx+7sJRv1PToPmpAzBdenaz4JwHgpfYEjUPFcxu0ZW7zYX
	 EABLGl6lkMTgn1pWVUKyfSZY5I6t7oE5CaQax43nozLmG7FRxbF27eQrxLUh+YGR6L
	 B1qczacJ7pWoTx8s6jvIkBYKrdt4aI4xj8s4/Ar4qm8dCfscsqnRRi3Q5jHyLvFr9s
	 7BRn5GelHaxMie0ywya0nnQEI3oStEk3t7lKLjAfo7qwwmgtXi9FSfkvBPXn1Fv0y6
	 8kVGknt5ZbDl3/zubYkHyFbmY+VzABcxY66dHhOG/N40VR8OUhda40PPnPuA0XEqOQ
	 f/WkIA8bkibYQ==
Date: Mon, 27 Jul 2026 18:06:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aswin Karuvally <aswin@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>, arnd@arndb.de,
 stable@vger.kernel.org
Subject: Re: [PATCH net] s390/qeth: Check CAP_NET_ADMIN for private ioctls
Message-ID: <20260727180644.0e97582b@kernel.org>
In-Reply-To: <20260723140050.762991-1-aswin@linux.ibm.com>
References: <20260723140050.762991-1-aswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 16:00:50 +0200 Aswin Karuvally wrote:
> Gate the SIOCDEVPRIVATE ioctl commands SIOC_QETH_ADP_SET_SNMP_CONTROL,
> SIOC_QETH_GET_CARD_TYPE and SIOC_QETH_QUERY_OAT with CAP_NET_ADMIN
> capable check to ensure unprivileged users cannot invoke them.

No need to make this netns-aware, I assume?
