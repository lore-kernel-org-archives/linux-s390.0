Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C263E51D3;
	Fri,  7 Aug 2026 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146077; cv=none; b=b5eBois60ItkiiXiEDQSSJ8h1P4fxFQPSGuEYHpJNOsxFfi/SMprWMW6zMFDRbgjb3axkUR5XJTEy8Q8iAlIA86GzzMv0C+Q3lX4RPfhrWV1uDIoNcmlgO3dXdjpTv7dP4QAKQxhUGgG0dr/0ozmU4rZgg+J7GWL7Mjd32HAQtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146077; c=relaxed/simple;
	bh=XoS14kvFOv4SiGQ/VnEVHUJGGIrPuIv3pZmyIZS+41E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HyfeOVkTtAK3AgFyWnKta07T8lxGB9b2+YCzNqjHUtxOirR65buiqdsKfPFYz3M+a4RXqR+ii162omV6FMvyoVvt/Ts0k1eenUtUlLlGYLL0RX98Ftbe/23szVqi0FXJDr6/2JXJh7nyyoxNN2xoTQNseHDoBNYb3mxxLdc1+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7AVh/dx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7AVh/dx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A432B1F000E9;
	Fri,  7 Aug 2026 23:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786146066;
	bh=9DFmypWpmVHZU7PmvERyZc25SfrArDmgI2FIP1ogS3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l7AVh/dxAVlzOmtPiPJhvQXBfdptFT1BrOfkoZlE9NFHpFN/3WIQUzvBxpb4IbBoc
	 RAPUOXcXdBmb+Coe1OOU5NrSYsggVBUAwLaUxvcUPjz6x8vkZjfqM9o+Zs7EsNML9L
	 M8gAkPj3ym6/auWx9sGvgUMYj2IakNT+fmtbdfNbkzVvj8p7w86ZIoXk2Hf0KLJxQP
	 i03O2AsFVSr0qHOkuUoGMRhms+0POEP6T8pzJ+2jY+tQjLjrkAsa4uWpHfET5suc2g
	 zGlk/OBWrrYgvoCShllEfoyhcUfoZitYozqVKQlCq6DGlcO2JMV2Wtfyb6f8gkMJvI
	 GOb2QViLkkDeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5697E380CEF9;
	Fri,  7 Aug 2026 23:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] s390/ctcm: Convert fsm.h to proper kernel-doc
 format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178614602489.2465504.5258419928849173397.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 23:40:24 +0000
References: <20260803182736.2356374-1-nagamani@linux.ibm.com>
In-Reply-To: <20260803182736.2356374-1-nagamani@linux.ibm.com>
To: Nagamani PV <nagamani@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, wintera@linux.ibm.com,
 aswin@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 20:27:36 +0200 you wrote:
> drivers/s390/net/fsm.h contains comments starting with '/**'
> that don't follow kernel-doc syntax, triggering warnings when
> running:
> 
>   scripts/kernel-doc -none -Wall drivers/s390/net/fsm*
> 
> Example warning:
> Warning: drivers/s390/net/fsm.h:14 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>  * Define this to get debugging messages.
> 
> [...]

Here is the summary with links:
  - [net-next] s390/ctcm: Convert fsm.h to proper kernel-doc format
    https://git.kernel.org/netdev/net-next/c/0023e4c6171d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


