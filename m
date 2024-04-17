Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0B13CFAF;
	Wed, 17 Apr 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355228; cv=none; b=gorbCn5zLVMBsprtLkqrVuQqReDxVjBHgUkDWmJ7AkqT5Kd4G8MHlnNm7sB2qwr54aOSEzsJr2fKK0Ddxm4uQFPyc5rBdFc94oR08/1mVA0h54bBePbbVA2Pfu1hwezlZYf5ACv/OjXxIm4PtTMvWKnddbnUdYBhrD9FlRzz0lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355228; c=relaxed/simple;
	bh=s/iFbCV9rIybHPFZJdbUwB5clC746c5zJyRTz59Ty90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NGPuHihH6pEBt3yd3pZtEYcsTU6Nql4LPuouilWP1wLRyq6G+Hwhtuas5PoQCLWRo5R1oWPz+MRygczuxpL29UdhSsbS4YdhBrMuGG8VVFL2xadori8hAbfUJSHTO0/DXWxzi1CPS93QWhdqrWoc82geqw4gfhSpkFcxNILZ8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMrpGDtT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMrpGDtT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AA67C32783;
	Wed, 17 Apr 2024 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713355228;
	bh=s/iFbCV9rIybHPFZJdbUwB5clC746c5zJyRTz59Ty90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RMrpGDtTPr3Jp3bi0ly8dvnR2F9Pg2aIHepdtewC7CcsB/2p6qBD/T6lwWaQrhpxj
	 lU4Ix2OnFsmeEqjkBr4X1frzidHJCjKR4Xpah5NZSAsEE/qQ4fQKpavMHRsxqM/+UM
	 VRy6hZcVGcKA+N6UUXut91YsVS5JRT3d1Fqz8qCXT0qAJZCCV8UDIZmcEF8uVIRLgL
	 V8lg0RwHEZh1WryoJB4/n4Dbt7GBAPRP2cZNg4bbYeYyQwbCSaKb1Iggg23XTV9l99
	 11fU8HEAxHGxQ4C5HK6CvvK/t9KcezFsaL1f8XqYPJj5F9IT32xC978NEVnCrSHf8t
	 4eHZJd6TirfPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C802C54BB3;
	Wed, 17 Apr 2024 12:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/ism: Properly fix receive message buffer allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171335522811.25671.11363979683780241618.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 12:00:28 +0000
References: <20240415131507.156931-1-gbayer@linux.ibm.com>
In-Reply-To: <20240415131507.156931-1-gbayer@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
 pabeni@redhat.com, hch@lst.de, schnelle@linux.ibm.com, kuba@kernel.org,
 davem@davemloft.net, wenjia@linux.ibm.com, guwen@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 pasic@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 15 Apr 2024 15:15:07 +0200 you wrote:
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
  - [net] s390/ism: Properly fix receive message buffer allocation
    https://git.kernel.org/netdev/net/c/83781384a96b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


