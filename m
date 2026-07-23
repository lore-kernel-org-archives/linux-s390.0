Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EEB4D98EC;
	Thu, 23 Jul 2026 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815866; cv=none; b=SnAJsmI2ic7n/pKfK6tVtIvmJEtE309QbSCVJvluYaqm3of+NuEUBkDRRnrvhRJYty66S74vtdMAM51kxUaEfNjcGTpEjdOAD59wK4hgAOc7UDqQlPvinSePCzogVv6dOpzNfjcEOpk4cZUTT9U8boduubB8geNXsz8Joagb4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815866; c=relaxed/simple;
	bh=ciq2LWZ3xEuE2AHnFLcBGFoVl5PndzarVUze0mapLGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QGQhEfnmGSlYWa/lnK8s22b0P6bqoICbubmAfIeH/GxB27PFldh1ZcZ1jUjzydR910y1c6C8snHDhviTaNHifq2/iVG2NGq+6jZcTiTGR4+56tdpeDaLOjdSh4UMxDMI5xKExZsu83DeTqm2qWkDmzY007W4F6sWWWn/cP/xosg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEHWwMN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEHWwMN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C3C1F00A3A;
	Thu, 23 Jul 2026 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815851;
	bh=dYsgV7bhpHW2r8cJsJ1Mi2zJOES69OLLKWlcQQRI/qA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TEHWwMN65d9iqnuEKzd93g+UMTPpjLm28qv/d+W54enQLvKLAbQaWb20xrU0YcxNc
	 pg4OVDPmXxnKWsjI11pK2StQl3QKR6uWWX8dEq8c50B4l3bxaBugzsalf+LB/KP3Jv
	 /UYwU87vJ1WMyuo2x71QMBHkoe4EOn/eGF0jd2g1lX5tD+ADWi8TyIM+JXazLfC0Sz
	 SoBaS4ozc75UVHLFngS8oabqI8smCBxwbvUxdZClQ71XIpj6lhJwqhPwIiYw7Asspf
	 CytPIilg/2TTMsbMFptyUDLWqk82g58CuZUPPri5YEZe3f8DJzhlAAwXj3yMh++d5w
	 6T6qlGhgjkFEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BD4380CFD4;
	Thu, 23 Jul 2026 14:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Add missing facility check to ptp_s390 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481581889.2248593.3567702646132973015.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 14:10:18 +0000
References: <20260714130342.1971700-1-svens@linux.ibm.com>
In-Reply-To: <20260714130342.1971700-1-svens@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jul 2026 15:03:40 +0200 you wrote:
> This patchset adds a missing facility check and a check that the 'query
> physical clock' (PTFF QPT) function is actually available. If it's not
> present, no qpt ptp device will be registered. In order to use ptff_query()
> in a module, the first patch adds a EXPORT_SYMBOL() to export
> ptff_function_mask.
> 
> Changes in v2:
> - drop CC check
> - add PTFF QAF check
> - add patch to export ptff_function_mask
> 
> [...]

Here is the summary with links:
  - [v2,1/2] s390/ptff: Export ptff_function_mask[]
    https://git.kernel.org/netdev/net/c/9de445d8296a
  - [v2,2/2] ptp: ptp_s390: Add missing facility check
    https://git.kernel.org/netdev/net/c/e78f1ac37afc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


