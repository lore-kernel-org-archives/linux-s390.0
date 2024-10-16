Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AEF13632B;
	Wed, 16 Oct 2024 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042068; cv=none; b=ZkN+Ym8no6Om/l80rwlUuAvXCVLkUhnLlPofkjRD9kylnzpV4qxheRMVmMW5H80I/k/rMgUefrdCr/Q3P9JdMEN6hCif9HHgHZroRXf2OCZroPS193gyl1S6CChiHfoX8YbISTGCmTwHE7H3v4YdJ5W3lwWyfpLHrXo8AKSrcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042068; c=relaxed/simple;
	bh=Cmi7H9V9VGdz64hSNvGG6duqcLzErqYGRncbYzcIjg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTA1iTesqunjNSce6y1ZEgMLj6YF1cHYBDi7n1qISaFaCVIrJZKgP6N+VKHjtIop4ZqQctdukbcgghcVuj/xbAAoJCC0JF2dbwzD3uXSVZpeZpFRWwwf6YDELQuuSGywZQds3lYO3JvVhBX2xD9g/OOGFPj7R47XA2CzTT0SGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7aDj+b3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7aDj+b3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E109BC4CEC6;
	Wed, 16 Oct 2024 01:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729042068;
	bh=Cmi7H9V9VGdz64hSNvGG6duqcLzErqYGRncbYzcIjg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T7aDj+b3/khJP1b01LdQ99VnP2zWT9+2JZhn6kJnBwH8qf7DjQSPgdZoqV1sqy93t
	 J0CJgH5knT3Nq7/1Sh7WWr4D2Ira0aUDpMxnr+gVdBic3VJfbzzouGofDullCf5y1l
	 mw7ZkQEd9xIww1jbTiyQe03iH7RavR2yEaMF9+288K4F+0wHpoq89BrNmdKqEPTiK+
	 64/mDeyn1jqXrUouic6fi0bGM7+L6EFKNQle3Kkagbj1qaqxLj7qHMHKOz05L/SExu
	 v1CuCl7Qt8FYKo6IhDPXfOTlcF7ZHh4sR86qu5j5pJPwOa7nOCCtSqRf6WJ3j9ZxVq
	 Oojou3JcuPf7Q==
Date: Tue, 15 Oct 2024 18:27:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re:
Message-ID: <20241015182746.664c0608@kernel.org>
In-Reply-To: <cover.1729031472.git.danielyangkang@gmail.com>
References: <cover.1729031472.git.danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 15:48:03 -0700 Daniel Yang wrote:
> Subject: 
> Date: Tue, 15 Oct 2024 15:48:03 -0700
> X-Mailer: git-send-email 2.39.2
> 
> Date: Tue, 15 Oct 2024 15:31:12 -0700
> Subject: [PATCH v3 0/2 RESEND] resolve gtp possible deadlock warning

This is garbled as well. 

Before you repost please make sure you take a look at:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pw-bot: cr
