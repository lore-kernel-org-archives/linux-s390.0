Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5451EF092;
	Thu, 17 Jul 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715798; cv=none; b=Tf+sNzR3hii3IjHLSxL2DrUzLn3wPi9LXNAgOuVirb5Y486ZSO3sK156qhpidxr0SyM5CMMzEQtdQo2jNU8TM5kbojrI4oHris2Pw7joDZSu6+W+5Hgc5lWxzXfWq4W9A3aaIjm7jxsQkOQ9CZMX3Mv8uJ6HP1E95EmFPBE0DNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715798; c=relaxed/simple;
	bh=edzSWKCa2PNYzid9Z7i3xsZJb+XNXsnNlEF99MtCEjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u9/l7IwPZnxHlL7THxOBv7xaXUs3rcD8nJ2YUpj78n8myMQb7F9LPn57ssmVU8Zmd4dWFKR+GRa8cklRSa1C4et9gpnSxkSbwPnAqMi+YoEjQ8q0QzVpGkVzUGCfBw9jzqlRyeWF+2CqFV3odrstIAUf4b4kmJOoIcDXIUJHMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTalCS5P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTalCS5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F23FC4CEE7;
	Thu, 17 Jul 2025 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752715798;
	bh=edzSWKCa2PNYzid9Z7i3xsZJb+XNXsnNlEF99MtCEjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jTalCS5Pfm40u1apBaJsDFYqsHr00l8KZ5e3NqIMDtSRkNn5/9v+hi4R+39JSnrLH
	 ddb/mT1EAK9L4N3SZwMlsRuHQpSdSQh/AP4n+j6eHRDFsJVWZSOrn/FaLeEcrCEgG6
	 Eas7S31QhbdpKNnlbx1iZ1iUch/D60fK8VkDEftvyTHDBl4cnbOBW1Nz3g04PXWS5D
	 0qQPY8qPhWMD8tguhe0lhfp+zClsKmcwGR9GpKYKgDXcmEuBIm7j3uu35GA7vx+h/Y
	 0WNTKsdgpxMIMRzLNZCFVgOOY20ZytWv3o00BPtHSQXuJYn074NS+jTh7UEULJOBNy
	 tvCaZwXbTTGqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71110383BA38;
	Thu, 17 Jul 2025 01:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] s390/net: Remove NETIUCV device driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271581800.1388574.4454566301754879755.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 01:30:18 +0000
References: <20250715074210.3999296-1-wintera@linux.ibm.com>
In-Reply-To: <20250715074210.3999296-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 twinkler@linux.ibm.com, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, nagamani@linux.ibm.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 09:42:10 +0200 you wrote:
> From: Nagamani PV <nagamani@linux.ibm.com>
> 
> The netiucv driver creates TCP/IP interfaces over IUCV between Linux
> guests on z/VM and other z/VM entities.
> 
> Rationale for removal:
> - NETIUCV connections are only supported for compatibility with
>   earlier versions and not to be used for new network setups,
>   since at least Linux kernel 4.0.
> - No known active users, use cases, or product dependencies
> - The driver is no longer relevant for z/VM networking;
>   preferred methods include:
> 	* Device pass-through (e.g., OSA, RoCE)
> 	* z/VM Virtual Switch (VSWITCH)
> 
> [...]

Here is the summary with links:
  - [net-next] s390/net: Remove NETIUCV device driver
    https://git.kernel.org/netdev/net-next/c/727258025b93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


