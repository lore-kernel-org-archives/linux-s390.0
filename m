Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8845134BC;
	Sat,  1 Jun 2024 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717230924; cv=none; b=C5nsxuqg5txRmpHMwWMiG3HWU7J14WpLS6UFWvOeTXbHrqhQw7Z4tJmt1cmiX/kIOT6kaFkxz+M+JvFIE3O4dNzCDY+iPsd+eHX6WXX0QtkZ3tTSdRh90pTHuqO/bgfgt8biHT8r+mwOwovMwMr/A2xaUsuyKtdXG6FpTP7v2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717230924; c=relaxed/simple;
	bh=i6QXw0K5kD5BqtAZxeo4zpXZBwWLBWtzp1J9e0muU8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsWQlqva6K/vhYefX1zg+m7H7wslf6kDTIA+NbT43jbKcNSXPFcTkqoOKrt8j9k3ABbJy0SmJOXyiTvfFawk2wwjhZAznP7Lm7Uj7oKWMoTJiiOL35D/j2f697ytP0sSnNYQFnxJn4bvdlwikVZ5KMr8QDAVGuHv/7DXiC9gakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t33ghpcn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t33ghpcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2F7C116B1;
	Sat,  1 Jun 2024 08:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717230923;
	bh=i6QXw0K5kD5BqtAZxeo4zpXZBwWLBWtzp1J9e0muU8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t33ghpcnE/BmCqaAshrQt17eVB2iwIAhBihh8ANAqgvrW4XD6/WzPzv+ZI2bxvs6/
	 wzuDIYcORClcDYgFhJKGsq1Wh7GnTciiLgKXNKhExNdR5tbfz5eLAg+Pr1qupo9oOx
	 q97iT3Vl+4eEJejchQbdxGFYU9S8yK3k7/QlmFqj7cb6KLwqJPff960P6jZiXAaSDZ
	 qyzGupR6m9hLvhOLioR0cYZjYD7CAP4dOdk5gO5pFTZPxx4VjJ6lzyGAeqddh6vGI+
	 90O1nLsAOO8XJD7N5lBT9L6sAcemJe0q3+m+iKIeHK3AvbZEc0BrP9yzo6DPvB2SJh
	 w1tjKH6vzJi6g==
Date: Sat, 1 Jun 2024 09:35:17 +0100
From: Simon Horman <horms@kernel.org>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kgraul@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net/smc: set rmb's SG_MAX_SINGLE_ALLOC
 limitation only when CONFIG_ARCH_NO_SG_CHAIN is defined
Message-ID: <20240601083517.GX491852@kernel.org>
References: <20240528135138.99266-1-guangguan.wang@linux.alibaba.com>
 <20240528135138.99266-2-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528135138.99266-2-guangguan.wang@linux.alibaba.com>

On Tue, May 28, 2024 at 09:51:37PM +0800, Guangguan Wang wrote:
> SG_MAX_SINGLE_ALLOC is used to limit maximum number of entries that
> will be allocated in one piece of scatterlist. When the entries of
> scatterlist exceeds SG_MAX_SINGLE_ALLOC, sg chain will be used. From
> commit 7c703e54cc71 ("arch: switch the default on ARCH_HAS_SG_CHAIN"),
> we can know that the macro CONFIG_ARCH_NO_SG_CHAIN is used to identify
> whether sg chain is supported. So, SMC-R's rmb buffer should be limitted

Hi Guangguan Wang,

As it looks like there will be a v2:

In this patch: limitted -> limited
In patch 2/2:  defalut -> default

checkpatch.pl --codespell is your friend.

> by SG_MAX_SINGLE_ALLOC only when the macro CONFIG_ARCH_NO_SG_CHAIN is
> defined.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Co-developed-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Fixes: a3fe3d01bd0d ("net/smc: introduce sg-logic for RMBs")

I think it is usual to put the fixes tag above the Signed-of tags,
although I don't see anything about that in [1].

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

...
