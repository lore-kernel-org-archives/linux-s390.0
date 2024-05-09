Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846312D76E;
	Thu,  9 May 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242829; cv=none; b=JQ6BQ2pKc3f++VjEX/xdpPU6H1bNiz926Fa8x4PDulasazXpd+OAYjUN8a2nnjAOeo6fBC7raxOnB23KF/ZoSgX6JG6TcR8WxSUKlCqVsAKqnthFCz0H2nEl0nSl3JtccSCjhUPSMFjYdooARFnrNlGau1QxqbBoI2TF+q7nYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242829; c=relaxed/simple;
	bh=FlMUqvYrfJFhE+zcBZdCUl/oxTB00wwnITCr+xwtjYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GI6H06gtoeIc9Bqhje7Z0p75QX6nDvGcR/BtUkw4LeGzDMO7ktNjJPiwTWqnG0IwVwdCVPGqkcYhhNjT2fN88e3RsO/fC7kCOCXSBsssT6pjtQI3KiNm2owhg7aw08ha54eqBVesf5QP7zFEdb7xqNtLW0m8TzrxBE65fDYz2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK1doKm7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK1doKm7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AE03C2BBFC;
	Thu,  9 May 2024 08:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715242828;
	bh=FlMUqvYrfJFhE+zcBZdCUl/oxTB00wwnITCr+xwtjYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NK1doKm7EzNAW/oUTLLVBDPHbJVoIGVZJbxZ6zFhQnChzbhvK1UhXigkXbE4CBZYH
	 FFMZKF6qCfjcIGtpGH5tJD6t5ZBfSuy3BGb6vsoJvhkjcd9HGuL3HJ0c3zzjWXqXcE
	 U5bLxyzvj3ENyPKZ2e3F1yM3eifHPeO1PH/TQttmiY8Mnx1FP7oJ+x8WVAEnpd/cPd
	 SvNoFsCvg8IqopUd6xlV9E6kUfolx6eFsF2X0bOAYt4p6883i5XEIFkecD1HzaZ+k3
	 hvaX/EqSe2rzla38HKJ8DIo4DGtLxATLt7PcTNDe13fWN9Ia6n80JEFoKJEiS7qIQe
	 j65d53KjBKkzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AB8CC32759;
	Thu,  9 May 2024 08:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/smc: fix neighbour and rtable leak in
 smc_ib_find_route()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171524282836.9047.9322288635530734098.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 08:20:28 +0000
References: <20240507125331.2808-1-guwen@linux.alibaba.com>
In-Reply-To: <20240507125331.2808-1-guwen@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kgraul@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 May 2024 20:53:31 +0800 you wrote:
> In smc_ib_find_route(), the neighbour found by neigh_lookup() and rtable
> resolved by ip_route_output_flow() are not released or put before return.
> It may cause the refcount leak, so fix it.
> 
> Link: https://lore.kernel.org/r/20240506015439.108739-1-guwen@linux.alibaba.com
> Fixes: e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net/smc: fix neighbour and rtable leak in smc_ib_find_route()
    https://git.kernel.org/netdev/net/c/2ddc0dd7fec8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


