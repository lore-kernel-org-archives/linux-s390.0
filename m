Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B0199FAD;
	Wed,  9 Oct 2024 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482795; cv=none; b=f+bV24BbafB7Z64SbD5ROXoY9g/kSa9JerCM+e/OE8XaE5CqyXHxL+UxbUrU/dV/FCaVeCtc9csBRyCK4k0y1ccwh2jt82JpOYxrXtiTtY7S4wgF3mfG2tsm//SiGMbCS4EqfRsuTYfrwmtX3rD1WAtSRtSI+kR335kJxuesqxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482795; c=relaxed/simple;
	bh=64h8af/u+44riv89TdZ9plDkPX2tmcm4LKFGvyXjzqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLa7pt9M7ZDk+rtTu0jfYdmNR+O0xETtG8ycOqxYtSnRXC5s9YMeOvSbZ+aVZFB2RPAjFnw7aBpe8zOu0zclAudZK6sWhsW/AVINS+4R75TyI6RLofPEt0xdrRqmtm8ppqwHrhdq3BJmqXSoBcGcBtBxCRJ9NN6zhdtski1hQXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZMRnf1Ql; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZMRnf1Ql"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=O82NaCwclJ0qjBoh2UASSw3aUHeepsmvNIQtsk4ya8k=; b=ZMRnf1QlHcGl0SFhWvdpCa8V2f
	KQAEyAqn+jxn7F2/p7MhfKQytADH4c6eK9i6bWY+eFDtIYa/NjemYJ4dzFLfccMbQn3OIzBGigPKb
	GEGXAjEvRAXU/SXrUqEsh9rVxfZxHhklqlliiP4iZMqu5e73X9wU825KnsuxetnH0kpa3LChmzLUk
	dJW0nx59LYpvp2zyGWL5RX8loXjHciSNtpNHa97NT6phH9iunjtbYKUlfSzrsmZMho/DS0zTSzVtq
	KURfSP0A/n33AGTXbN9DosId6/ipScdW50M3NO5OSs35hXOxmdl//E2cizP/UqAlss6ZbOk1jVouw
	k12ub4ww==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syXKZ-00000004zjr-3bBP;
	Wed, 09 Oct 2024 14:06:24 +0000
Message-ID: <871b41dc-512c-4910-a00a-5b8311c2c3ab@infradead.org>
Date: Wed, 9 Oct 2024 07:06:18 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: Address spelling errors
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/24 3:05 AM, Simon Horman wrote:
> Address spelling errors flagged by codespell.
> 
> This patch is intended to cover all files under drivers/smc
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  net/smc/smc.h      | 2 +-
>  net/smc/smc_clc.h  | 2 +-
>  net/smc/smc_core.c | 2 +-
>  net/smc/smc_core.h | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
 

-- 
~Randy
