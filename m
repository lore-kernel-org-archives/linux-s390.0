Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91A246762;
	Tue, 21 Oct 2025 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010833; cv=none; b=RJbjoSM4aHE1K8RlPsdXProrRLAFngJbIlMS1eaXyRPH4EO1CDY6EledA6xVgvmXhuT6/jhGmc0vzEgjmbtsnu9/EUYbhoJCCf/ep9dQys+w49bQnAPEhqW3fr7OeRY2pB8/BcpoTy5iKER5SNE6rM3fPwyB24uS7+eMXvuR9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010833; c=relaxed/simple;
	bh=9j/NwYb2uzgrW6O++TqHgQBWqYvtL1IgF0kMNUqMjU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DAvXEdw5ZjlOyIJ4gsjznQznGvy5g8EtxvlxPHhK/l7c2FBTI6bDRvmqlI/stM4q9JAGpMXFSq4nofPMaQCilPVjmpwhoTPHs4NRszxPdquZHzEfob/3lS5IvwvpxorVWcAv74qrFldpw47tQD8DIAoeaidd7IJ2KUj8rADTlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqQyfjUP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqQyfjUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEACFC116D0;
	Tue, 21 Oct 2025 01:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761010832;
	bh=9j/NwYb2uzgrW6O++TqHgQBWqYvtL1IgF0kMNUqMjU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uqQyfjUPz2hZIZv982wUpTSLXbDgsyCxU8/aHHx/nK6zBMtli9FTEGthXjqlI+zEl
	 Snt2jabThVXqjUTWrBCC9l84XARiUeGklCrXoFJHTFmuAxWY1TRceAS72CFmvXl5Pm
	 CFmCTIU4eYQwPtIDqdG6Y78Y6eRxPlIZUh2n0QGv0vT4dGEY+s/0gKW4RsbyVvS40C
	 hWluhOoxuIglspB0iMM+zG9DdLrsK/1utfLkYTdmQ4os8ZnIgFyCAxtA97uwxR6mmR
	 KrlIQWRetW9EqwgdVQx8OKSdbHSWlqOxFuR2cT0yKnAOY6zw6SiglLJA2Aspmh01Fs
	 7QAy8+NdJ4LYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE023A4102D;
	Tue, 21 Oct 2025 01:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] s390/iucv: Convert sprintf/snprintf to scnprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176101081451.484471.13334778110409476366.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 01:40:14 +0000
References: <20251017094954.1402684-1-wintera@linux.ibm.com>
In-Reply-To: <20251017094954.1402684-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, aswin@linux.ibm.com,
 twinkler@linux.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Oct 2025 11:49:54 +0200 you wrote:
> From: Aswin Karuvally <aswin@linux.ibm.com>
> 
> Convert sprintf/snprintf calls to scnprintf to better align with the
> kernel development community practices [1].
> 
> Link: https://lwn.net/Articles/69419 [1]
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net-next] s390/iucv: Convert sprintf/snprintf to scnprintf
    https://git.kernel.org/netdev/net-next/c/38516e3fa4ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


