Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537EC60260;
	Mon,  8 Apr 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574028; cv=none; b=WtuDILrXtk0UFQFIvzNGOR106SGyHQ3f68Qs4yaloEILLCtTaeZnSr9fi7vjrF5Iw5ZjGKKcr5+GUDqZec7sW6XM6HbQNYoynNNfF05wL1TVhh3Zlu8cAXrM4BTiGPYNvrP5RSYNG6dmTXywFAWjzAbqlrwiR6vydoyTTHG7L9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574028; c=relaxed/simple;
	bh=Jze5Spew/BujLP9d5cmP1ObYQD8kiyCPV8Y66LQDy98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pm7/mANCqOJqrG6EzVGufqDF+9+rs3rMSx+q3vaev3eHUPHqwutPmgdYtQ3zi6dLbEu9SqWHfAw3FdKPnXGn4ZmmL9nA+aq2JVdqeE7xmdbuduYCeLN5INl5mGw4MRoAXB3Qc8krynyIJNZfKTsqnk9GvaIqqYv7y7cZk3dllKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj5v0vCt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj5v0vCt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9FC1C433F1;
	Mon,  8 Apr 2024 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712574028;
	bh=Jze5Spew/BujLP9d5cmP1ObYQD8kiyCPV8Y66LQDy98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hj5v0vCta4VsagJeqkqOBUe/QPVvgtuY8mxqT7ZjdU71VvKvUDTw9uT7cFH1Rg6b6
	 u+cmDvqqgZehaNqOo3l1f0/BdrOFUCb+cQAz9hK6mraS/MGOIB7TBdiYUlsnW3FkN7
	 ct7C0XPPJBV10eZVVG/+CvN9ZctevLMlleUeRzxUfn+IXLjkijbq4HyEasP3kNw9CD
	 uPJcaECpj5h4y+z4nn1lFkZWJUaR8oRhxwOsFoihhgggOtvETfQkdov03FPmry1/es
	 Gzee4nk78ZI1wrMvnuFziWxB/4AHA9XuSyGXMbYfJYqZTZF0Jms6mteAY3ODd3piJL
	 tGu5u7tYYG/wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAA53C54BD3;
	Mon,  8 Apr 2024 11:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] s390/ism: fix receive message buffer allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257402789.26748.7616466981510318816.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 11:00:27 +0000
References: <20240405111606.1785928-1-gbayer@linux.ibm.com>
In-Reply-To: <20240405111606.1785928-1-gbayer@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
 pabeni@redhat.com, hch@lst.de, pasic@linux.ibm.com, schnelle@linux.ibm.com,
 wenjia@linux.ibm.com, guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Apr 2024 13:16:06 +0200 you wrote:
> Since [1], dma_alloc_coherent() does not accept requests for GFP_COMP
> anymore, even on archs that may be able to fulfill this. Functionality that
> relied on the receive buffer being a compound page broke at that point:
> The SMC-D protocol, that utilizes the ism device driver, passes receive
> buffers to the splice processor in a struct splice_pipe_desc with a
> single entry list of struct pages. As the buffer is no longer a compound
> page, the splice processor now rejects requests to handle more than a
> page worth of data.
> 
> [...]

Here is the summary with links:
  - [net,v2] s390/ism: fix receive message buffer allocation
    https://git.kernel.org/netdev/net/c/58effa347653

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


