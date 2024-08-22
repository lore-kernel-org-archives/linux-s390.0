Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF251D0DEC;
	Thu, 22 Aug 2024 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358035; cv=none; b=PbQZq939XvRMmX9pcVWnI9PoWJxI6skeP5DGi1jhqMm6IUX798mpot0bj+ePfkW+B2tmFsElh4d1SWbSkswVwCNayFhAUqVhk+UnenbCIC/0MxzvqKzd3Wx+srKqIgS8SlSsqh6oLESd5IKxJj4L+oF9AbC8Uicx9mHGDbV24gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358035; c=relaxed/simple;
	bh=H7zktjbZgNSzDNz2S4bvZWh/Pyfojc7NjoBkDms+UGk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YZRUwdnXIzNEJQfNNamcyGWJDXioTJ7V+pvm8YVgqMPq4hwAvPOOQ2ZixBSuwWVYIM42ojL553bdIp4boGre2pcBpO90QAz1B3JgY4xJcqpDKoJ9vXcWzxkhfQNaSNj0Nte432K8BpzlOAy/O/ogIBeeKPeQ9Ij7B0EfE1jXKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSm43BjX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSm43BjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8052C32782;
	Thu, 22 Aug 2024 20:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724358034;
	bh=H7zktjbZgNSzDNz2S4bvZWh/Pyfojc7NjoBkDms+UGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OSm43BjX73kFPoRvRXFOmlhleftWnL+I0lHcqf1G09mcxZexES/CCi2YxTyRtPCIL
	 jHxYhfjldfBA6liGGhXphT5fccUDd99CI8cb9ybjC2lGMjKaQbMb7kUaKL7MYM88VX
	 OINTLFMjR8iaJ4SbB3scivE8mtubPMPZ6jW/KJK99mGRRwccbOpP5ltHPWq6toooJ/
	 cCzBEFDgbdNy7D83Y0BYfW1l9RCLoy/nYk0fzUvhTeKpzMDOlF1a7WYPuZTZtGz4x0
	 VtJRiGVhwQsYkhgClfBT0sw5k9aEWrieMu2CTGPghM/OS9rL/LtZK9AP0b5SG1lT52
	 ZfJ3lSWjxmVfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEF963809A81;
	Thu, 22 Aug 2024 20:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] s390/iucv: Fix vargs handling in iucv_alloc_device()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172435803454.2470731.9208772227879585831.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 20:20:34 +0000
References: <20240821091337.3627068-1-wintera@linux.ibm.com>
In-Reply-To: <20240821091337.3627068-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, twinkler@linux.ibm.com,
 gregkh@linuxfoundation.org, przemyslaw.kitszel@intel.com, lkp@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Aug 2024 11:13:37 +0200 you wrote:
> iucv_alloc_device() gets a format string and a varying number of
> arguments. This is incorrectly forwarded by calling dev_set_name() with
> the format string and a va_list, while dev_set_name() expects also a
> varying number of arguments.
> 
> Symptoms:
> Corrupted iucv device names, which can result in log messages like:
> sysfs: cannot create duplicate filename '/devices/iucv/hvc_iucv1827699952'
> 
> [...]

Here is the summary with links:
  - [net,v4] s390/iucv: Fix vargs handling in iucv_alloc_device()
    https://git.kernel.org/netdev/net/c/0124fb0ebf3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


