Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991B23D649C;
	Fri,  4 Sep 2026 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564069; cv=none; b=KWpTZZG70OG43v1+++cci31gqk70zqUFPYDyaW3JI1Q4JR+UgF2cSK2oleKsy55x97riOCUKrwrMzvrAi6X8JA3Cp1lHoIcLNPSscLjZGJytMd4Vj/tjb8yLbOSe5i4pQbF/LF7ckzpW7S/keiLphK8UbCGdXXAqFa05krokhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564069; c=relaxed/simple;
	bh=iOU7YxgAhWEV+IuWQrWa2JuSB6NOkVqByfZRh40KNnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RNsL7KQOdwqOHn3ZX+ZNREngkLTWB6AWl+A3ZVzuTnUsJNpRekF4Nw99sMgPVtapXTh+njUtBYFYQcu4qgPc2ggomh8IACa5IgxjFZPL5R8bhM/zKpQXoqEsQkaJ4CU5MEtlT37cWAdTFE7Mr3TaUMOxzUufvFrIOsqbHuLbkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD0Snkyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD0Snkyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE4F1F00A3D;
	Fri,  4 Sep 2026 23:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788564068;
	bh=LqDAE9lf7QypN9wR+oKiw1uvxn5gz2kxOu4tZZtM6rM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aD0SnkyyTAIeGBKs+g402p24i+vH7TTaDsrGRRvhIcLNqKU6EF5VJWufOg98JC5l3
	 AWL899WrDd47fCDUZJcEGbvbUp5V66m1hvj3jliabGx1gVvksAmE7V/hfAJf8R9CEJ
	 OtFmkWmbHogLFt82/1lrJF6bkfs2NGtJ+0OY8xK8myqSPlYmjipObfB+bCNqNCiaA/
	 8uFPW16Fb8Smy/DwJ7SI8N/fulDYjtKGHo5gUm72iNMQNrH9xN9OnMquTRQWyGHqGj
	 t5lMarKNNYAsN5GNh+ZC0B2/loh0nGCWJRlV7ppDSACTcUVj1RWLl4uoFKPW6+wV6O
	 Q1mvq2yrJ5/8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E43924A7F;
	Fri,  4 Sep 2026 23:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/ism: folio_put() after error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856400864.1013351.13477192621282445494.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 23:20:08 +0000
References: <20260902143733.433574-1-wintera@linux.ibm.com>
In-Reply-To: <20260902143733.433574-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, gbayer@linux.ibm.com,
 aswin@linux.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 16:37:33 +0200 you wrote:
> dmb->cpu_addr was allocated via folio_alloc(). Use folio_put() instead of
> kfree() in the error exit of ism_alloc_dmb() to avoid slab allocator
> corruption.
> 
> While at it, reset dmb->cpu_addr after folio_put to avoid unintentional UAF
> by future callers.
> 
> [...]

Here is the summary with links:
  - [net] s390/ism: folio_put() after error
    https://git.kernel.org/netdev/net/c/907a56ab3eb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


