Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EEA19E;
	Mon,  3 Jun 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413630; cv=none; b=ccGRn10tVyxYC+ME/zQny6xn+J+Gr/JmYDbegcb76rY9u3k0+O3CeGEcyyL63Ndkcwip9modO5W0+dDUa39cx39L15QK90WT1/XP4+Af3q44T+bQ0+qqO9WZmrZGrooSHgqugnHHAmUukCcxyPmq5EK8XXMUgYq8Zawcl7a2K1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413630; c=relaxed/simple;
	bh=U8sl2r2xVwW6qA0KhLzuybAoLCozXZqUb3VmIAW8JqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4Z5PWUdTzDTRI7sKaGqGIvyqaShxzKeE1t1CusETV7ThdlvKB1ucdO/iO7andvjqdv5GvyPfOm4BONDtO0mNX8TqkDFD7sGkHp/6G/fG6ZubmKZByBpO0iYi+VZ8DOOzgT1uzF/0QDwOxzEZ/Bwit/XOMBLmSIFZV5UJDgPr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRFDaFlS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRFDaFlS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E92DC32789;
	Mon,  3 Jun 2024 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717413629;
	bh=U8sl2r2xVwW6qA0KhLzuybAoLCozXZqUb3VmIAW8JqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NRFDaFlSuHkRePRe9HYQzaBocLpm7Acgnz/VkkMIE4I4GeForCbNmGlGjKKUvo1ba
	 S1SxeOzG9qkENG/AbsFNPySh26nf/UYv0TT9MF081YNkPXZdY0LUglGqlvn53eHbea
	 p8B/IjH2zuVa1rZcelsxXGDKi+U+9CCz3Rgv2JL/KvZQY61pA1NJNyW2AsveDhu2i9
	 ut7eaeV6sb8x4X65TALqD8OEJuCbN/k5OB0olpSW95Ob0A2mKjaRGBE7VeVGtY43lD
	 BthInGf/FBfxJtaVRLskJ0pma/2rqhjf0hyMGrZJXFHri9G7aZrHUZtF9v5GOUUHpY
	 VIFMdV5nx+ceQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EA7AC54BB3;
	Mon,  3 Jun 2024 11:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net/smc: Change the upper boundary of SMC-R's
 snd_buf and rcv_buf to 512MB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171741362931.21322.15314690362780882616.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 11:20:29 +0000
References: <20240603030019.91346-1-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20240603030019.91346-1-guangguan.wang@linux.alibaba.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kgraul@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jun 2024 11:00:17 +0800 you wrote:
> SMCR_RMBE_SIZES is the upper boundary of SMC-R's snd_buf and rcv_buf.
> The maximum bytes of snd_buf and rcv_buf can be calculated by 2^SMCR_
> RMBE_SIZES * 16KB. SMCR_RMBE_SIZES = 5 means the upper boundary is 512KB.
> TCP's snd_buf and rcv_buf max size is configured by net.ipv4.tcp_w/rmem[2]
> whose default value is 4MB or 6MB, is much larger than SMC-R's upper
> boundary.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net/smc: set rmb's SG_MAX_SINGLE_ALLOC limitation only when CONFIG_ARCH_NO_SG_CHAIN is defined
    https://git.kernel.org/netdev/net-next/c/3ac14b9dfbd3
  - [net-next,v2,2/2] net/smc: change SMCR_RMBE_SIZES from 5 to 15
    https://git.kernel.org/netdev/net-next/c/2f4b101c542e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


