Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDF653368;
	Mon,  8 Apr 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605571; cv=none; b=EMnMKEdRaLtEAA3jdz5XPBT/4jiOp6f7KhdO0A1GufUozIRRxY+xYB+mRmyOSkQqWEd6s0VkEJuInI/ZW15P2ohyltI+RDB0xeTYPgcx3m3vZbvsk5j0zjWvJhSUJOPKP1xSxnyJylfIUvuptwnwjruY+ZkXCj+5I1NdD0cTahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605571; c=relaxed/simple;
	bh=KKwOOthlrZFQbXVgAQ1NLmuizfVtzSGCUSBZn0g3YQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQKkvx21993JSTXPX+8J+b+1Gjgfiq/NdhDDbRk/vxyD9SqdrwTyp4MgC/MEVwDWfKBh8VKa9L4jm/xPv2Mm+VL4MOTva46BAAEtvuN1nU3sE7NoaMFOr+TemKA0+BuM6V0M/nW6v/1JTK45XiJzmu7/Zu5D/bs5e1aNQm6BiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjxWh4xU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjxWh4xU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89701C433C7;
	Mon,  8 Apr 2024 19:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712605571;
	bh=KKwOOthlrZFQbXVgAQ1NLmuizfVtzSGCUSBZn0g3YQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mjxWh4xUaLPqK3L1xkSWfPVH7U1pbcewy6VwUs/xgtffQA89pllrRPIphdCxBAAmv
	 jcQkm+ZRF5N4EwCLRrDBmT7biaY29sGaeNAwgEvYDFhWYETapsSBcEZR537WNH2/H0
	 2eDJK2YoW+Wp0OitzQaGzSjiCRXAgaNck+mxFrMInYj4BRKDi7IZg0+Sf6rLeGgse6
	 TUQHI5+T+vIEyRBbpEqgN04orUpv/w8xjKx57ypjlVFPgEwJi4OSQt1gA5HOeWYjNM
	 +lwcUOH+fLdv+/yRMIA8AuqLUIqx+kLZ7CQO7K0CsBv0Eu0b565ZhhV9YMeIATTXAL
	 WvdOZFderjrEA==
Date: Mon, 8 Apr 2024 12:46:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, "David S.Miller" 
 <davem@davemloft.net>, wintera@linux.ibm.com, twinkler@linux.ibm.com,
 hca@linux.ibm.com, pabeni@redhat.com, hch@lst.de, pasic@linux.ibm.com,
 wenjia@linux.ibm.com, guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com
Subject: Re: [PATCH net v2] s390/ism: fix receive message buffer allocation
Message-ID: <20240408124609.4ca811f2@kernel.org>
In-Reply-To: <7e6baff2338ef4c3af9073c46b5492f271bdd9ae.camel@linux.ibm.com>
References: <20240405111606.1785928-1-gbayer@linux.ibm.com>
	<171257402789.26748.7616466981510318816.git-patchwork-notify@kernel.org>
	<87cfb39893b0e38164e8f3014089c2bb5a79d63f.camel@linux.ibm.com>
	<7e6baff2338ef4c3af9073c46b5492f271bdd9ae.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 08 Apr 2024 21:05:47 +0200 Gerd Bayer wrote:
> Hi Dave,

Hi, from the Dave replacement service.

> so how do we go forward? Would you revert this v2 in the netdev tree to
> have my next v3 properly reviewed?
> 
> Second best option: I can send a fixup to address the last issue from
> [0], but that would still leave some pieces sent with (v1/v2) not
> properly R-by'd or at least ack'd.

If there's a chance we can get an incremental fix ready to merge by
Wednesday morning, let's try that. If we fail please post a revert by
Wednesday morning. On Thu morning EU time we'll ship the fixes to Linus,
so we gotta have the tree in a good share at that point.
