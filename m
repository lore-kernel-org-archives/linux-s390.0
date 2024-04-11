Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF914D43D;
	Thu, 11 Apr 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843553; cv=none; b=RV8tRM+JMFm2wuSvlqoZ1YI5egq7XmvMMCXsejktQtePuT3jCFH7KN1CN6lJORJ3Sdxl2NHdmNZ8uv3kBZ42+JOXvCUupHp/JbprKYqQC+hByKxtX5xoxQ9QdBaCXfih3ES/UvZ6U+a6XARIdMNCUDAd/OJtQIJ5/p8wtqZqI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843553; c=relaxed/simple;
	bh=VE0rjgL+vItzez7sMDo45knHtchyEzkvyT9NlLSE2j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olhwRywsDWWN2Q/1KMN+fLq9OQue6FCbq1gPHJrPgxaW/EYRKGfddZseHO0F4lSKp+a3p2pWT6wL55w88zrTxM+QmPWudSU1G3IAM2azhnf9mettS6nSBUGihp/7vKraF/IWIF0nvNcTjlsFTtNK+Hia3o8K7LY7h8gpDb/2fgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX3HGXRe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX3HGXRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DA1C072AA;
	Thu, 11 Apr 2024 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712843553;
	bh=VE0rjgL+vItzez7sMDo45knHtchyEzkvyT9NlLSE2j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZX3HGXRetyKKBodkwlYNADqJOqQuXXTUahDjHLWO+R2xtvDmfAXJbic0LcQPnE+nP
	 0mZhnXaouVeo5CWo+GBrC9+qOnw/Wjf9op+IA7wfnC3m0NEY4P/e2X/l8pJsaI/bB5
	 XnrlqgZsr8BQsasD+MWVcZpABhaVoH4LtPHk8ovSdm7nHh6UqqsiU3E8zaaDgN7L7X
	 SaTidqaMiLJZwcI7+W2xQ9agBtRS4c8fW2EASHT02NZnRnyrQ7mEJY13GSQ7sixRi5
	 zty3kii1SJkSsVqBD2DfkBOgF1q2R9fHUyfHvr3VqZNcBDVXhBcQjhQw7JvFo7CMdq
	 Nw7Oj2G4NNOsA==
Date: Thu, 11 Apr 2024 14:52:27 +0100
From: Simon Horman <horms@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, pasic@linux.ibm.com,
	schnelle@linux.ibm.com
Subject: Re: [PATCH net] Revert "s390/ism: fix receive message buffer
 allocation"
Message-ID: <20240411135227.GL514426@kernel.org>
References: <20240409113753.2181368-1-gbayer@linux.ibm.com>
 <facf085f326813ec12566b3458650746e0267aca.camel@redhat.com>
 <60455a55f6595b9ac0fe8922a162b5727556d85a.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60455a55f6595b9ac0fe8922a162b5727556d85a.camel@linux.ibm.com>

On Thu, Apr 11, 2024 at 11:13:53AM +0200, Gerd Bayer wrote:
> On Thu, 2024-04-11 at 09:16 +0200, Paolo Abeni wrote:
> > Hi,
> > 
> > On Tue, 2024-04-09 at 13:37 +0200, Gerd Bayer wrote:
> > > This reverts commit 58effa3476536215530c9ec4910ffc981613b413.
> > > Review was not finished on this patch. So it's not ready for
> > > upstreaming.
> > > 
> > > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > 
> > It's not a big deal (no need to repost), but should the need arise
> > again in the future it would be better explicitly marking the
> > reverted commit in the tag area as 'Fixes'. The full hash in the
> > commit message will likely save the day to stable teams, but better
> > safe then sorry!
> 
> Thanks Paolo for the explanation. I was not even sure if the commit
> hash of the erroneous commit will remain stable when this tree will be
> merged upstream. In my (naive?) view this could be "autosquashed" into
> nothing at the time of the merge.

net and net-next hashes are always stable.

> But since there appears to be time for the next pull request to
> upstream, I'll send a new version of the original patch with all the
> review comments addressed.

It looks like this commit was accepted, so we have what it is.
