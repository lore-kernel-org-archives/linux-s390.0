Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD898749A;
	Tue, 18 Feb 2025 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841601; cv=none; b=MB9GZ/2powYZdY9Cysi+hkQtxMFhFSMoJBM4tcf8FsFhrNlO74WAQgsIkzekmlGbA6Rz6IFcfBiwJvj3ts2MTkcQMkLI6FpxWu5WPQUK8nD1IMgI7ZMGme2hQ6hBbAvb+XFt424lQyEC6sF9r7fbdwaTSarh+4bGJOPeTAHiYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841601; c=relaxed/simple;
	bh=1+R3AxY4ep2Td0pFGzl3dbsukT9cYIZeGkJukXulpqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CoVuOFPzVYSiBxFwdjgAikCe63UN0ty1ht7Mlt3iZP4hFwhB2OE/CDs4Y1nkOhw1aKmZgG4l/82sVxhiNlxCUtmI17E6V4ppeTl9dznz9WkXVh1TCnWugaHDTzujtu0xqH/6iQrXiO5vZWfbaQp+Pi8hsQfP3q3fy5rimDpmy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrnRnBkv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrnRnBkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E33C4CED1;
	Tue, 18 Feb 2025 01:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739841601;
	bh=1+R3AxY4ep2Td0pFGzl3dbsukT9cYIZeGkJukXulpqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BrnRnBkvHQVKuvz8BrEokMG2XRDWd1c7Y379QlZiOtrxNQO5h3uWCZP9JLpViYBwE
	 i8sZFYqRphLfHZRMYyiDi/kDjvfuC6N+PQTCDeAowZVmhUWyXcRBXUhU+zzIXOZyRp
	 4swaxWWbOIct3b5VC+ij6kLbYgyMGbbZDSaZZ9t2m5doXv/Y+DGI+Zo3XRw+1eM3Sy
	 FU/6nAjqGH4f+cV4GXfxSDwvM92TQYLfPnPU0BoXe8m5M3UusfCRZz0wmoMjIbXxde
	 WshS/z6mVpl06LPFthmZ5B07KFvXwUajJVeazmzEHfXRVm+zhonn58bSlTxCBvoqdh
	 R2KGrxx+F0ERA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED7D9380AAD5;
	Tue, 18 Feb 2025 01:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/ism: add release function for struct device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173984163176.3591662.6324124388363934052.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 01:20:31 +0000
References: <20250214120137.563409-1-wintera@linux.ibm.com>
In-Reply-To: <20250214120137.563409-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, julianr@linux.ibm.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, twinkler@linux.ibm.com, horms@kernel.org,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, gbayer@linux.ibm.com,
 pasic@linux.ibm.com, raspl@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 13:01:37 +0100 you wrote:
> From: Julian Ruess <julianr@linux.ibm.com>
> 
> According to device_release() in /drivers/base/core.c,
> a device without a release function is a broken device
> and must be fixed.
> 
> The current code directly frees the device after calling device_add()
> without waiting for other kernel parts to release their references.
> Thus, a reference could still be held to a struct device,
> e.g., by sysfs, leading to potential use-after-free
> issues if a proper release function is not set.
> 
> [...]

Here is the summary with links:
  - [net] s390/ism: add release function for struct device
    https://git.kernel.org/netdev/net/c/915e34d5ad35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


