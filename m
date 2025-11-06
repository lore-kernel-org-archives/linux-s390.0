Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728E21D3CA;
	Thu,  6 Nov 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439435; cv=none; b=HnMXa1GBl2sXJaspl6cFuiTtyiUqUHeq51mZkixz8wmwyfj830xGJGEBcxyudmREXSdbFFewCuqLAIQNN5tNmvyU4CEn5UIfuqBs3KOtrZidNee/aFPLqDJOzYEksFgM+gHaIZOv+xwdm7eF/gDzaJb79K1RJicLVBe5kIsy1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439435; c=relaxed/simple;
	bh=DvRREBRYuDOCESnDpJAgcuJWRTjoxTzA8EmUaYHusb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pyLHXNly1SsdPvia80qFrAgzX9CeOgTCgKhUqBqRr7WHjLxnNsMmaMDvE83wEAnaKqoDlNBWLn5Te4uCCXjWHwYJ9vRnuBi3K52bU1vN5Oois4Dk5eLGy9RP9OCENVnRPrkkx7ivX5MRMgWfBq+0jUHOrj/DM9xttaIHNuXuypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfkzXxgC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfkzXxgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF6EC4CEF7;
	Thu,  6 Nov 2025 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762439433;
	bh=DvRREBRYuDOCESnDpJAgcuJWRTjoxTzA8EmUaYHusb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EfkzXxgCTZQxuvlu4uE9zlyAxLqgG8E0OrKc3+Nq7q/Yb4BpnzLqTUBc9yZu5hUoa
	 HTyQe2CDBVJFX1wCnisVMabPVg8R6gc9PLFNgRIZuRgAj+BfbVmD2aANqSmGgWzXdi
	 WshsSYX7FZarvZPTkQ2gam8AxQQfypScg7rboigXaP4hd2uNtkwmWfKTN2lbmPD2HA
	 yDrMSVmwLJb8e3MXtGuBZaEJ58gCuewnQKI/ZBvrwGcuyF29sBdGDr2guikQdiTXvE
	 ZmmFJMp5k2VqPWLmManvk+qzSjnkOcjx5apZ7sXe8Otao5ziusjPiAamn6I2lZIXS6
	 m5No1ewbPY+FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0D39D6549;
	Thu,  6 Nov 2025 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] s390/ctcm: Use info level for handshake
 UC_RCRESET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176243940650.230375.7618185802650828717.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 14:30:06 +0000
References: <20251103101652.2349855-1-aswin@linux.ibm.com>
In-Reply-To: <20251103101652.2349855-1-aswin@linux.ibm.com>
To: Aswin Karuvally <aswin@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, wintera@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  3 Nov 2025 11:16:52 +0100 you wrote:
> CTC adapter throws CTC_EVENT_UC_RCRESET (Unit check remote reset event)
> during initial handshake, if the peer is not ready yet. This causes the
> ctcm driver to re-attempt the handshake.
> 
> As it is normal for the event to occur during initialization, use info
> instead of warn level in kernel log and NOTICE instead of ERROR level
> in s390 debug feature. Also reword the log message for clarity.
> 
> [...]

Here is the summary with links:
  - [net-next] s390/ctcm: Use info level for handshake UC_RCRESET
    https://git.kernel.org/netdev/net-next/c/0cc4b8461591

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


