Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B191472762;
	Thu,  6 Aug 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016461; cv=none; b=hL1haFzLw7YLR3h+Hlkk+DEeytsfo/XgrBN3mUYI4k9+5YjZREzoaLQRcSSCDVurOaam8IxtIfdNoy0lbVfZkZJjCC8q50PbYTGDhhIC88SKfqkZz/erS8YkpuH5A1dkJZLFE2Ftbkyw0jyRHG6DqKaipY1WPXtFuhAsjCkTy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016461; c=relaxed/simple;
	bh=rYTjHbUrl9b5N6ogifdgOcKznIuzf0FuTExqAI5NC8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V5gYS0bD67fPR3MdNL9l1teEmWZNS3SwAkBJHhQlSL2ZOQFM3r5Cv7ZE9MOlzvg0/NCKd69ktmcEwqf5cNaP8nnGVBdtnT3madoZd0+nuC1nPbDhw0i6/XPYdCRgcgH2n2rQDGvTUz2/ho59Tj/L2OAm9DZjumclcd0nunD5Pfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcXsxxfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcXsxxfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735A11F000E9;
	Thu,  6 Aug 2026 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016447;
	bh=zy17dLJAiURGR1RiJlWaqZZePvRmyg2uWh1NUwjRCtk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LcXsxxfy1nimuVs0+6KtLR/QWk7NuUlv8mZOkq8SLh3gWdqFeJwFYAm46KvyabvYJ
	 RJTHyEw4i3ObZlVmD9t8EytPB8vt880ro30ZA8QYbBDq1KqOmbLpPCZeeKWbOq2zVm
	 YzKDybZPN7AYsysSLVOohb16KkgDatpRz8XYGcAbFltcqLjWOLZO+YKasLhUUW0cna
	 3A2s2nAEpSfHowPTqF1ACEps1iv9dwnsszrNXv5v7q7mFVKBvrCUdROfGLbNyez2Le
	 8WX/gCyzveujQzJd/sqIUh2xKmsXWD3uM6mKW+k8ubua3IZKOXcdtisHUQFX5XG+5R
	 MPRtCGw4wP7+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983D380AA5D;
	Thu,  6 Aug 2026 11:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix TOCTOU race between smc_listen_out() and
 listener close
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178601640689.798872.1785237402553323723.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 11:40:06 +0000
References: <20260803070701.126339-1-sidraya@linux.ibm.com>
In-Reply-To: <20260803070701.126339-1-sidraya@linux.ibm.com>
To: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 horms@kernel.org, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, hidayath@linux.ibm.com, pasic@linux.ibm.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  3 Aug 2026 09:07:01 +0200 you wrote:
> smc_listen_out() reads lsmc->sk.sk_state without the listener lock,
> then acquires lock_sock_nested() only after the check passes. This
> opens a window where smc_close_active() can transition the listener
> to SMC_CLOSED, call smc_close_cleanup_listen() to drain the accept
> queue, and release the lock, all between the lockless read and the
> delayed lock acquisition:
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix TOCTOU race between smc_listen_out() and listener close
    https://git.kernel.org/netdev/net/c/185a4caeecab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


