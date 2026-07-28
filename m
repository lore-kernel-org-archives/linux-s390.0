Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DE22FDE6;
	Tue, 28 Jul 2026 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201041; cv=none; b=XbSn8kgPtUhg0YJlyqbJS+5qWlKG5ABPLLLeWtw+ygASdYOpJMs7m7fbXHcY3Qo8n2DNOl/AaPw686lHUA6lVS+A8fj6fVFKDWeDN9bW5bjmBctqiqwLz5b8xJ8NxMZmOEHtVM/Qw5Vm922JLcz8JeS7h+BrLjT6WAED+Az1FQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201041; c=relaxed/simple;
	bh=qQgrFjKGg/CvuZlH2wNxEkTjZL2ZdL+V7Pla+N05Qtc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z+XLlZJEfYuirP4v6BIOdyqbwPt0SsydYNGExUjDtjF2a3W6ZPplYFQ/614M3Vfraly38AnCSsfwSJSU2iAhvQEeyZxKJRUXHp4U69JvE6HckDAzSnIqiOt1Z5VWD5+UhhiZpM8dwZTE4pDXMYlzERj/GD6cl13K3+HX9o9fgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTqSxmaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTqSxmaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC0A1F000E9;
	Tue, 28 Jul 2026 01:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785201040;
	bh=5iS80mAgDQggTAF4qVKPanXxXHDVk7uaIWp7CGUEWys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DTqSxmafbCJ2adu9QD8GQMAETOWkjfFYyhi+dL9ov5YxI8qlv04pazYZgFQu5eyDt
	 DZEyXJBEdFKJXrKBsEbmbUiOdV/7JrJHB5sPJi9UUCqKBnG0x4AVPQ47fBa/WbAmnO
	 L8J03Dy0Qvqd7TFRlPOZz5jNCQsjZ32Iku2Z9Sg7Wf40iWdHPt9MOY6qsZo6zpm+lY
	 F9m/Xgetb3cbFdR+0gXx750VWqlA5R/XY6FV83syfnlaKGdJOWGeNb8GboDNeA5fS2
	 EIAF2/65XgxWTbG5nuZlRMe98XC173M2V4t5rEvMiFQq3p7k4dGIHSA61YBpRqTOId
	 ACKQTxu7sRO7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B28380CED8;
	Tue, 28 Jul 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/qeth: Check CAP_NET_ADMIN for private ioctls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178520100564.1486027.2436428958867554773.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 01:10:05 +0000
References: <20260723140050.762991-1-aswin@linux.ibm.com>
In-Reply-To: <20260723140050.762991-1-aswin@linux.ibm.com>
To: Aswin Karuvally <aswin@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, wintera@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, horms@kernel.org, arnd@arndb.de, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jul 2026 16:00:50 +0200 you wrote:
> Gate the SIOCDEVPRIVATE ioctl commands SIOC_QETH_ADP_SET_SNMP_CONTROL,
> SIOC_QETH_GET_CARD_TYPE and SIOC_QETH_QUERY_OAT with CAP_NET_ADMIN
> capable check to ensure unprivileged users cannot invoke them.
> 
> Fixes: 18787eeebd71 ("qeth: use ndo_siocdevprivate")
> Cc: stable@vger.kernel.org
> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net] s390/qeth: Check CAP_NET_ADMIN for private ioctls
    https://git.kernel.org/netdev/net/c/d211028bac1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


