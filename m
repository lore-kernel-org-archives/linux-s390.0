Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8146279C8;
	Thu, 22 Aug 2024 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286888; cv=none; b=CXSplVgDLklLN47kX152kF0eOySxzRoyY9dnYbS9utQmNjWMSWt7HHUlwNmxvt0hFhPT3xey+a+jrI369nNof3WR9glEvE6i4V+VQgFmicP8pqELF6aWQkTleUzzAWFcCZiy21sZ40NLE5B5PIBT+DGsHt5ykYmCLD7G9CQ4kyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286888; c=relaxed/simple;
	bh=z0MwXQp4y7bwyZlf91g5b0DXFNIRThj4x0L/3nU5et8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSqy+RdXQXf6bS8L6oscRYEq7t6WBRJfkO1/rHBB/pSLHg0v3zztr4DMdQQ8SqyVZ9vytY3pcW+ZNUIKsw8dSWQj4YR0uYwfRj7sEPnO3PM0c8wlN3Z8EA3xXDWzQduad3Xi5To3aSmUhn1nk3QXtryWMKxDyDpIJ9lH+lPnl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcdscVhF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcdscVhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826D4C32781;
	Thu, 22 Aug 2024 00:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724286888;
	bh=z0MwXQp4y7bwyZlf91g5b0DXFNIRThj4x0L/3nU5et8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZcdscVhFX1vAoCM2y+Jw+iqSpd+X3g3pYpKsWGAi3F2jnHu43Tj88pHNP+HzQgqZM
	 9XyxEoZHp3gEa4gt76D++nvDby2uWxit7krtDk3BhXdyt3v6JIruslEE3SVJYXndKX
	 nzyc9Xva56IlrLOcqBGfvGc42N2fWsJc0bf1vUjTi54azSAZ1zDZgKtIHZ+VbCxbcW
	 14Shd+ieY4dw8MRvYzRBu18bP1+pkgskGkkFuGOCn9XWH7+UNF6h8YUcmBjRrrH7aO
	 u8QGa8+mimCXSxrcSu+XVQnz1l0GKqpZVVS8BhgjipB06Gmjh3qfDSg8Wc0YuciwPd
	 VHRQOIgMzyEeA==
Date: Wed, 21 Aug 2024 17:34:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, <netdev@vger.kernel.org>,
 David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, <linux-s390@vger.kernel.org>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thorsten
 Winkler <twinkler@linux.ibm.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net v2] s390/iucv: Fix vargs handling in
 iucv_alloc_device()
Message-ID: <20240821173446.6f515d26@kernel.org>
In-Reply-To: <5e5bb753-9d6b-4e6f-8b02-ffa2cae1a4f7@intel.com>
References: <20240820084528.2396537-1-wintera@linux.ibm.com>
	<5e5bb753-9d6b-4e6f-8b02-ffa2cae1a4f7@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 13:51:06 +0200 Przemek Kitszel wrote:
> > +	rc = dev_set_name(dev, buf);  
> 
> would be good to pass "%s" as fmt to dev_set_name()

Sounds like a good idea
-- 
pw-bot: cr
