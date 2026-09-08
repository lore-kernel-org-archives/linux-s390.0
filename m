Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E0B1397;
	Tue,  8 Sep 2026 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788825666; cv=none; b=cFCLwxUKddrceHwhSJAwRZCOOtG+dn/pdgOdJARCOKHW9ipYQIIrQkkFv0vc4ShQZ45iarGa2Dr7s26n7EgsrGmcU2lso4Xr1D2jrHvPL8gZkjiKjpVImDys58bKQAxLnTRWC9K2H1pCnbCNCFAGsMLMyooIhgCsk6/1ANMsHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788825666; c=relaxed/simple;
	bh=zAFB8A7S5qgRzStZDFBUa52YmjjCuGqlcqTGN9KTyxA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FqkwQKEBYnVJBUg3DNH0jvvTj+gvhFkSQYBBXN7FrRbXlqmhb3XYiJRIs0329dlbtA5fj2XnxJkAo3hh7+CKbXN5GzwDQF0LeaLDHn78Za1EVjSOyCg+HrK7eY5URpyCPfQE1n5X24KUzZy8DU9LXeECbkaNq7d/F4ynMMqi3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqUp66iU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqUp66iU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D501F00A3A;
	Tue,  8 Sep 2026 00:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788825665;
	bh=dNdGLNUoPmE/62Fpu/BzjHK27J5iVTN+KG/p6F1St7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JqUp66iUVxLUFjDksOhaVCfrt8guH5F9JE3Kcm7An57FPzQEEhBv5dyvLeVsMjnPm
	 V56izbVzBtNdu8sP1BP9dWg1E4d1EHDxzJxl7Mv0xYb/9jsxXuv+U3a+ZMCiarNi2H
	 7ae2ZtazfnlM9JnU47U3IOTOISE2BsAQ+Vjo0pBIKzUuBuBD12GIUaEve02+AiVvNa
	 Cg6RS45ZZg8RGlOowfsmMZOOi6Rvn6i8bLuH7YRd2LM0Pp/XEDqx+X9AwKycCLv1Zq
	 NecBhn5tUT0R+b3yWZhObkHyllFVGlQRya3qYuzC+N5D2a//5exlDCnKXmklgjhlpf
	 604fbBDpSS8RQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A5139E8A5A;
	Tue,  8 Sep 2026 00:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/qeth: allow bridgeport queries despite
 OS_MISMATCH
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882560414.3212362.13375645059125761818.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 00:00:04 +0000
References: <20260901155344.3561483-1-nagamani@linux.ibm.com>
In-Reply-To: <20260901155344.3561483-1-nagamani@linux.ibm.com>
To: Nagamani PV <nagamani@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
 pasic@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, Eugene.Crosser@ru.ibm.com, ubraun@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Sep 2026 17:53:44 +0200 you wrote:
> When HiperSockets interfaces on the same VCHID span different OS
> families, reads of the sysfs attributes bridge_role and bridge_state
> fail with -EPERM if bridge port ownership belongs to another OS family.
> 
> As a result, userspace tools such as 'lszdev -ii' cannot retrieve
> bridge_role and bridge_state, even though firmware returns valid bridge
> port data for QUERY_BRIDGE_PORTS requests.
> 
> [...]

Here is the summary with links:
  - [net] s390/qeth: allow bridgeport queries despite OS_MISMATCH
    https://git.kernel.org/netdev/net/c/74f27fc8642b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


