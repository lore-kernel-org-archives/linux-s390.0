Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0F1EF1D;
	Wed, 14 Aug 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646908; cv=none; b=YWx+pdCoW99D5JJZbZZPjcuPZHyierpeJQoNBy2XKiXDjOFNy/CY28BVGYTf5qU+1V/+59Qt6CHSdPvLwE/FvnnfL4a0vdJwmxx2OEWVRreKwYDC97XHH3Wme4nqTBIIwRxFSyX+vtgzKUqByFXPlyGwOS/vjLTRGjf3kGFDpjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646908; c=relaxed/simple;
	bh=Giw0IEnl5GXiD5BZ5wCG5vcSvTKJkiZtA5K98l8WfXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hvw9A2KnzTeUfjH2eGncVf5UVbFKMpg+Wey9lFkjAYn06PvvdNHNeU42Admn+v5TGzuuyIGlBHPeGoi8CNlZ55SOpwOEayMMPjhn2J0KuT4d2cHy08uIc5HFyWse3UsB90vmeLZoF6KChzpqd2WBcEcGlnFI8kHQXJLMJbTrz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imE5GaRh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imE5GaRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658E7C116B1;
	Wed, 14 Aug 2024 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723646907;
	bh=Giw0IEnl5GXiD5BZ5wCG5vcSvTKJkiZtA5K98l8WfXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=imE5GaRh7KGIBv2yIlSn1BHzQEdTMJq7MLtr3kmGFUnByzBIsFBuJyj6cqe4El+ZO
	 stwanMBsv1Ian6d6yPxJfKGMaOqCMSgEgp5hVI4sS783gSEBIJm54KlFvd5vZXXvj7
	 zfnNaZ1QnRVPxGClICZlomA4Gi+zEIhE20NjMBHuhqE0BTeu2UIkaS7zm0JIkViK0B
	 4sVNj4TvIqcdsBN0yuKdd/MRqM82fxOPWqU1oPeZCdURRXB+IgxvTo5SOdMusHaMbQ
	 hUKK94QBQUpQp9POQbLpE+LUYrk6Aq5WjKFjIyELhKfPA5xrjYXLNmFJj4Elghz9Xi
	 9FfvDUwqPdSNw==
Date: Wed, 14 Aug 2024 07:48:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Ido Schimmel <idosch@idosch.org>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, danieller@nvidia.com
Subject: Re: [PATCH net-next v2 1/2] net/smc: introduce statistics for
 allocated ringbufs of link group
Message-ID: <20240814074826.38f211e9@kernel.org>
In-Reply-To: <586beba2-a632-4fe3-9fb5-e118af384204@linux.alibaba.com>
References: <20240807075939.57882-1-guwen@linux.alibaba.com>
	<20240807075939.57882-2-guwen@linux.alibaba.com>
	<20240812174144.1a6c2c7a@kernel.org>
	<b3e8c9b9-f708-4906-b010-b76d38db1fb1@linux.alibaba.com>
	<20240813074042.14e20842@kernel.org>
	<Zrt4LGFh7kMwGczb@shredder.mtl.com>
	<586beba2-a632-4fe3-9fb5-e118af384204@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 11:12:41 +0800 Wen Gu wrote:
> > Danielle added one to libmnl:
> > 
> > https://git.netfilter.org/libmnl/commit/?id=102942be401a99943b2c68981b238dadfa788f2d
> > 
> > Intention is to use it in ethtool once it appears in a released version
> > of libmnl.  
> 
> Thanks, that is a good example.

FWIW - technically the kernel version of a uint / sint are only either
32b or 64b, because smaller types get padded to 4bytes in netlink
messages, anyway. But doesn't hurt for the get. For the put make sure
you don't narrow down too much.
