Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FC6D1B8;
	Thu,  8 Feb 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391229; cv=none; b=fGOSb0tfc2uqjsNomAWrpbwaE0kuYKabYyv/eM+cUgX4ObrbKNbCosMwiRzRWA8niVm7vVPRArXz1hkRPv01wumdxxS05tbxgVxKklkdWeBwjVu5DqbJxLA3SXuMM+5uy9cxURvWzI3XZhI0UvD2gLsJ5JifqmzoTlBAVwlUQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391229; c=relaxed/simple;
	bh=EByImiwpvZijymQrU+gOcwzDg3ZBDq9SHqW6dSWiRCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pxxUjV+N+iEKDxucKLLNxq2wBTzIwj5NRC9A/kLPDgiW6erZl+wa2QZTbwMyBE7J7tdj9s6HGCqVJapWv7HsolVf3twAmK5+5t0JsCHwLM/cFQtxyMGq778ugy1BOqRzjsURAGMAnhOB4csbhJro2LnOI9YYed/G5eDDstfkCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrZ6Nkor; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrZ6Nkor"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F77DC43390;
	Thu,  8 Feb 2024 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707391228;
	bh=EByImiwpvZijymQrU+gOcwzDg3ZBDq9SHqW6dSWiRCA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jrZ6Nkorpep8rr4TqL33j21eViMwyffNSxkzxTxwaS+EhKp52/i0ppaVFOwPbrW99
	 5G8P7Tl128UflSFxmW1ce7xBPEhz+7U7hunlxo4ksYJNTwqertAUScuj1kqchHDpwa
	 ZJL0C/tHy+pFperEbPfp6v7K6J99LxtTRnRrjPdeWKG5muCxmU7c4IoqCPYFRcQS19
	 ob1T/hEX+klahDP7zY23kWH7WZJkMoH1FJVflD4pi5zYjS3MktCszGfZGPry8k0Xzx
	 DQoDaIBaCxYFM0jRZlPUZAqSL0JPkvl04BpQAVkphV3iOGVoH0l3TXPNBW0l8VnisV
	 RJIldPy4S4sNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7430BC395F1;
	Thu,  8 Feb 2024 11:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/qeth: Fix potential loss of L3-IP@ in case of
 network issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170739122846.26165.3983765571371603826.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 11:20:28 +0000
References: <20240206085849.2902775-1-wintera@linux.ibm.com>
In-Reply-To: <20240206085849.2902775-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  6 Feb 2024 09:58:49 +0100 you wrote:
> Symptom:
> In case of a bad cable connection (e.g. dirty optics) a fast sequence of
> network DOWN-UP-DOWN-UP could happen. UP triggers recovery of the qeth
> interface. In case of a second DOWN while recovery is still ongoing, it
> can happen that the IP@ of a Layer3 qeth interface is lost and will not
> be recovered by the second UP.
> 
> [...]

Here is the summary with links:
  - [net] s390/qeth: Fix potential loss of L3-IP@ in case of network issues
    https://git.kernel.org/netdev/net/c/2fe8a236436f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


