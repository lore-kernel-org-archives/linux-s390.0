Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F91EA7CE;
	Tue,  7 Apr 2026 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527832; cv=none; b=LFCZ8pdFEniNvcP61BuVEbZ6Fxjm4We+gB4uGgQkOZEHjv7DsEUREKzQE1ao/InRojAQk70hNz3ttYaDDzPz8X2lyXSKtvxFKiHVDB3mWiLouAzQnfgWQe9UAwGDYR9QUQ9nWOWu/VBWCDpfYlJbYmbzG2sISsJFvwoq4EISu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527832; c=relaxed/simple;
	bh=NUrupb/CF97DyehgDM1bR3YngtCbCXQcoCVeKQ2GbB4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aJOQ1vr0uyhNqg2EcdN/RZRMVak633DM7lBB/UMTw5PiqjEpSGhyUHHHS/U4S/v9xLT9or9GW4e1n78isfAnUL36Vc4nN1/1FBmjcSLdLcsQYzLo9UBi7mFv42rdsgF3cbPVABB03ouN3gTi4L/q27LMRgObfcNQu07vPU4gyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2wlu8lJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2wlu8lJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB12C4CEF7;
	Tue,  7 Apr 2026 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775527832;
	bh=NUrupb/CF97DyehgDM1bR3YngtCbCXQcoCVeKQ2GbB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s2wlu8lJlZOw0FDnuFEbb1GIYBBpLFRmBCOwF42KTyNk+9QKJhFGELVg47XWRSkUp
	 VCwBD9vMkxe0JrC3ionEMbNtZ7rcN4qYPiL842Bqon5zJlQS/4MGH42pP0wgzJnulc
	 qUY5dxPpk3U5LtvBnHO5cajhh2Toib8iE/1nK3kqWegr6V6WDqPDANtSlJcNcvZKrt
	 n0BxwclZpplISYN2ZWCorIbmg1+cjijdgDztRpFvfYbKVDh3gm5qTz0uKnaMUUOBlL
	 BLtNwSE51BS7xdRHIoxvwGsTft8alJ6kvE2VZF7s/XEPVVMsiAQXfWcVv3i6HT/PJj
	 cp0Z8SZ36lTUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCB83809A28;
	Tue,  7 Apr 2026 02:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] eth: remove the driver for acenic / tigon1&2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552781030.3342975.4848886248762600181.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 02:10:10 +0000
References: <20260403220501.2263835-1-kuba@kernel.org>
In-Reply-To: <20260403220501.2263835-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jes@trained-monkey.org, gregkh@linuxfoundation.org, helgaas@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, ebiggers@google.com, ardb@kernel.org, tiwai@suse.de,
 tytso@mit.edu, enelsonmoore@gmail.com, martin.petersen@oracle.com,
 jirislaby@kernel.org, geert@linux-m68k.org, vineethr@linux.ibm.com,
 lirongqing@baidu.com, kshk@linux.ibm.com, vadim.fedorenko@linux.dev,
 wangruikang@iscas.ac.cn, dong100@mucse.com, hkallweit1@gmail.com,
 kees@kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Apr 2026 15:05:01 -0700 you wrote:
> The entire git history for this driver looks like tree-wide
> and automated cleanups. There's even more coming now with
> AI, so let's try to delete it instead.
> 
> Acked-by: Jes Sorensen <jes@trained-monkey.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] eth: remove the driver for acenic / tigon1&2
    https://git.kernel.org/netdev/net-next/c/e6b7e1a10cba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


