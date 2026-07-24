Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD93F482D;
	Fri, 24 Jul 2026 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930441; cv=none; b=sFJRZW8TZjxmgcUGNmHsP5ZVe+SnRrR5a4u+qkqyaV/nd/6DY083IUl8tz1tc3px1eZiLWmMJq6SQe9OWTU0HHA8Ie1ebJTG2F/X5t0rGvYaZLdvED2j81tN1I74LBCCqpqvklZ1pM/Yz+sHyOJQUw63C1DeKZOSvuvZaq2IvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930441; c=relaxed/simple;
	bh=X07jI/+qvanFnqzYWrbcYoCKu6qHnqXRLUz9I1YjOX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vu2PA3iAwnUowAQ9iL944NA9jgAr0pWjq2sx+nYVx8heu3OXbpDQl6croJFFj6k6kIq1MMHZHMhs5Elsk0KX8k2f4IsorurGtE61QafnHt2zdhs7b0Xz6YnNrFDSvyCCmF/oRqepeM/Txf9AgE/QT6bVmK38/RX1TiDgaITWbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVVoSBug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVVoSBug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A9D1F000E9;
	Fri, 24 Jul 2026 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784930440;
	bh=Fl7Pc1djCZRwzz9Bth0ewIIi6/wzJ/eiV84p8CK2bQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AVVoSBugieNKYjXI6FC/4mNN37hSAavbBTE8gDeYjeR+sem1995JIEngkJfUaLqyy
	 tKoSR9+Z0RPdLSX3F5sJRTyA1dExdxzoC2cd3LMAyn5j7kLlrgCbhksybFHyftvRgV
	 hfnaOvXVji+9O+szxP2WZx3B5hBSIxDF6Tb0Go1v+qYUjjnmseiJL63GYJ+1tNMW7z
	 Cax6TupfOZQ2AIthEJp9OuNoRWClvWgrLSSmjAWcOYDBDpeWkIbxnvgIRmhZ6ZAb/G
	 X9EhzkROVTtg00UCqNJudiefbsKQO7e6Qlt+bpPOLW2BxP9G86Lu+58EN6vyqEYJkO
	 RMtW1vsHn7rIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A4738111D7;
	Fri, 24 Jul 2026 22:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] MAINTAINERS: Update SHARED MEMORY
 COMMUNICATIONS
 (SMC) maintainer entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493040692.3326421.5106894914058435335.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 22:00:06 +0000
References: <20260724053752.3084-1-wenjia@linux.ibm.com>
In-Reply-To: <20260724053752.3084-1-wenjia@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, sidraya@linux.ibm.com, mjambigi@linux.ibm.com,
 aswin@linux.ibm.com, wintera@linux.ibm.com, pasic@linux.ibm.com,
 guwen@linux.alibaba.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 dust.li@linux.alibaba.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jul 2026 07:37:52 +0200 you wrote:
> Due to a change in responsibilities, I can no longer serve as an SMC
> maintainer and need to be removed from the MAINTAINERS list.
> 
> To reflect these organizational changes, promote Mahanta Jambigi
> <mjambigi@linux.ibm.com> from reviewer to maintainer.
> 
> Acked-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] MAINTAINERS: Update SHARED MEMORY COMMUNICATIONS (SMC) maintainer entries
    https://git.kernel.org/netdev/net/c/9736d2efc996

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


