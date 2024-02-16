Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42B1BF34;
	Fri, 16 Feb 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073429; cv=none; b=qFb83BKQmmr1CDPSW7o+ZyqtOdxUWQ4Wx78OshvzKGPv9v6XlknujQHuHZ3XekBZgKuRZBriiAsrnfG/YojtR9VCUczn113nofLMy605BsoPO01CsI7BQIczkOWwxlDY+vMwWEpy/4JHqNyjr+Trpmu9nUB2eYIHFEyuXiN3M2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073429; c=relaxed/simple;
	bh=0LkhTOcyVHNDwM1Tqq4VZjD7Iom7GhtFzz2HBNChAw0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vi5kE7JDN2+biGQXnV02MLPW5eQN/lBr+6xaUvkx5Xr1f6zhiOhu0NRIykp9hjQ2gAiktgW5xp1mOHIPXFhu+3jIynsSi0hM7P+pQNcHaz/nmjebEgJOt4bY4n2Hp12WK8GXMhGKjLzvp/NaBP3bwcPZx0OlZdcJVzzxBlM9lo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUNP6/VF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUNP6/VF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F12B8C433C7;
	Fri, 16 Feb 2024 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708073429;
	bh=0LkhTOcyVHNDwM1Tqq4VZjD7Iom7GhtFzz2HBNChAw0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lUNP6/VFxSkd/oM7xEM1Z/l96rEFOCii8ZLEtl7dxF4cNYi8ncQ/nhclSpxTNctEt
	 B494LahHy9dfzq/dkn3iv8fkSf+XHUJQVXlh3bW87bt+7N7hHScTqWSgkjdegaaQVE
	 QfYni0uQr3Z+qdbgAqpv90c+1ZokVDDOr5ZNA5HAdHPYBLJ+1mXJAz3hXuUUvBMhGb
	 9pr5SXaGfSKaCkeAGyd7+CmHHuzyscH7NMdVznDlyO9g2TaViWv8BIVE0zEcAGGBub
	 tGdKTbYVYg3VbF2NJaK7UI1PUJpvZ9YZ17dkXFY7uBnN8sOfsmJjW8Y4a0MrchFna5
	 VT0MVOIXI2q3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5538D8C966;
	Fri, 16 Feb 2024 08:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/iucv: fix virtual vs physical address confusion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170807342887.14240.10301038348627699464.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 08:50:28 +0000
References: <20240214084707.2075331-1-wintera@linux.ibm.com>
In-Reply-To: <20240214084707.2075331-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Feb 2024 09:47:07 +0100 you wrote:
> From: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Fix virtual vs physical address confusion. This does not fix a bug
> since virtual and physical address spaces are currently the same.
> 
> Acked-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/iucv: fix virtual vs physical address confusion
    https://git.kernel.org/netdev/net-next/c/2210c5485e43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


