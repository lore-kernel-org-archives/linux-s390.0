Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04913481CE;
	Tue, 20 Aug 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148029; cv=none; b=EE3a2PSaNB14anUp25SUdCJXbEAL1ABnrhXKQdpOWp9Sgv4/eNMcuXUs25rnwDDWuOCz8CjcaSdNNQv7G2660VmY8683eV+xfOxjzxCwY4s0wsLo2gJUo4AFEtXBHSsluTFAU+ukZelhJQHLQ+IIZkSWmHC8F6djqL1s84VHohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148029; c=relaxed/simple;
	bh=y35oaBjpJkIq9sWmpmxXEx14BAM1pza37IPm49U8Fe4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cb/5tYpcQjNaMSDOtmQ8/jRcHAZm+4EngZaj+qi20ojz1ccMoOT+fEIQ4zzyF1up1ghydXJs7tr0HXlaSymeI1wtmWEuBODP9mMQaqDfonrTfUaFjOSD4IKdQecYjOTQjQIxfOZ5DYecYvEHZQb7f+IWChnwOe/ty4DNxxvUu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTOqZDyj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTOqZDyj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F266C4AF10;
	Tue, 20 Aug 2024 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724148028;
	bh=y35oaBjpJkIq9sWmpmxXEx14BAM1pza37IPm49U8Fe4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cTOqZDyjPXh+ORkp4g6EKWHMXC5C6bmR8J8L2ApDdlY9IjFzN2Mnz3pk6L90zB4oa
	 DdynwnNZdouzZhPeyi7y2RRThzRek0YmOJx6dp34dxI7oCoACVSidbyT+oZ1RXlKAa
	 8cWO+LHCRjiguM8B7gO2YnLvD4Yer3wThG/e0VsT7F6ss9Xcmd6ko3pECpqtYix9az
	 1Lknx+c/jPZpgscK6ldRZeDUlkUejTFmhZs6ooCVCcVurchEudX2E6STZetKdtRdYR
	 vF1t5XTPIYjE53xQ/kniKLvBLvdumT1OVGl6FK+n5aaKjlwD+Pta27XIhIxP1kTXxU
	 9pYnq4n0Ve4Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D873804CA6;
	Tue, 20 Aug 2024 10:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net/smc: introduce ringbufs usage statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172414802803.1091572.2090967549088436542.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 10:00:28 +0000
References: <20240814130827.73321-1-guwen@linux.alibaba.com>
In-Reply-To: <20240814130827.73321-1-guwen@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 14 Aug 2024 21:08:25 +0800 you wrote:
> Currently, we have histograms that show the sizes of ringbufs that ever
> used by SMC connections. However, they are always incremental and since
> SMC allows the reuse of ringbufs, we cannot know the actual amount of
> ringbufs being allocated or actively used.
> 
> So this patch set introduces statistics for the amount of ringbufs that
> actually allocated by link group and actively used by connections of a
> certain net namespace, so that we can react based on these memory usage
> information, e.g. active fallback to TCP.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net/smc: introduce statistics for allocated ringbufs of link group
    https://git.kernel.org/netdev/net-next/c/d386d59b7c1a
  - [net-next,v3,2/2] net/smc: introduce statistics for ringbufs usage of net namespace
    https://git.kernel.org/netdev/net-next/c/e0d103542b06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


