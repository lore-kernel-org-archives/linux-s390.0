Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33942E645;
	Tue, 18 Nov 2025 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428241; cv=none; b=PXrNdxW2yM6RhN9MdYo10mQrQRI2hnAvBXZn8uLvCsrhHKwhMHso81BtR5NYOMUqf+rml6xaF1RxGjti9T8RraSf2xRDLOvy8ob5x608hqjMZBupA7axdtGgIhUqoJfFG40Ri9XE7Jj6zL1i0BJh7pfCyebpCNL/Kqsd1JX8LqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428241; c=relaxed/simple;
	bh=ccxOOxmDyth7x42En/wPSfBqD1THJfgQoT1B39Zlmm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cD5tZvJhYMIliCoa9z6IGmm8sHKPS/gFm3CR+drBEvfqDpLllcchioAPHZrphfqMCBvJWtZUk9cWL9QKutaCUhEkbc8MtumXPa/ScQDIEe7r77csnKDjI++2g/ucmDkQjKE7aztcme/A0BYV2Xokz68EfxXWGyq6cv0uqcp1HoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NutPyCOB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NutPyCOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AE1C19421;
	Tue, 18 Nov 2025 01:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763428240;
	bh=ccxOOxmDyth7x42En/wPSfBqD1THJfgQoT1B39Zlmm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NutPyCOBV5fSjKc7IMTmDJu3oYKP7ILjTzVKyspwlyHAbU71hn+Cewf9w8QnBED4I
	 lXAclxqAMWyJmlPS3429BAE2OPyglcYvWil4uV6clQkUvJ7dBRoqyC9QiuQKtpGsGM
	 okxLKW8GQ7LU8kq7M5AzGFWJdRkzg0d4GC3tiJG1e1Jr5xpjmZwFhBShgIKS9U5bVy
	 yeu44UH+nZhUpILbeHyimOAAZei/7stih+o8TnIj3xXjiIlfAIzI/uFG0DTZcd5APC
	 QdComlFC2BujOqWtvNOxHbIBnSpF5rYqNtyKWzZag2bCE53tV+YDsjfA4zKYvM6h2o
	 TWj3GSVLEmw4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD473809A18;
	Tue, 18 Nov 2025 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] s390/ctcm: Fix double-kfree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176342820651.3535669.10457156248919003680.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 01:10:06 +0000
References: <20251112182724.1109474-1-aswin@linux.ibm.com>
In-Reply-To: <20251112182724.1109474-1-aswin@linux.ibm.com>
To: Aswin Karuvally <aswin@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, wintera@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, horms@kernel.org, aleksei.nikiforov@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 19:27:24 +0100 you wrote:
> From: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
> 
> The function 'mpc_rcvd_sweep_req(mpcginfo)' is called conditionally
> from function 'ctcmpc_unpack_skb'. It frees passed mpcginfo.
> After that a call to function 'kfree' in function 'ctcmpc_unpack_skb'
> frees it again.
> 
> [...]

Here is the summary with links:
  - [net-next] s390/ctcm: Fix double-kfree
    https://git.kernel.org/netdev/net/c/da02a1824884

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


