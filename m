Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB11AED27;
	Thu,  4 Jul 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098657; cv=none; b=T1bimdxh2rVFcOl2kgoOO/80LNzoKVqK3OLxkXhGtsyFq3/lSI13mp8rLeGoASEqBHFP5xQUXBfoF+a0EKhOc+/F/ArG08POcJtCzjyVIgVQN44sa9+FSAp5MDVUGpEWnd1CTRME2ybm4VI/mbsXUo7onZYmSO/JTGUwzuUCsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098657; c=relaxed/simple;
	bh=lJXnONd5ISVvmE4QQ4QJTEc1T2lWaVBV5IrBFXcFzSs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RyziWlbFZvksz6E4/oP+1W+KIi7FZiDd4FTFBCD7JtY0i+Ur4CFq1L666XpInDwEF3in4G9fHc9JLkuegwl51fk/Cu5zwQI5/LU7Ko2uFgmaTQHlSgaV+1KF1Nt0FVsrAsLLRNG8W2UerE67Gr8ydTWwCsbo0rqweEvBlivS6HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpwd2tcY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpwd2tcY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2A1DC4AF11;
	Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720098657;
	bh=lJXnONd5ISVvmE4QQ4QJTEc1T2lWaVBV5IrBFXcFzSs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vpwd2tcYqNgW1dMG4DUsuYkKBIfDlCn4PVslQ+vVDvZ3zq5iOcb6vvRYYnY6zPLqm
	 b7qRPNJMCF708+0X9bllMigap/i9FHO/+hiquNIRAZExPqCwtGbOBjIJuQ7OkQnqn0
	 sPH8SB9WW3Zr18pR0U7e1oUFPHWfJ1HJqEs8ZH2+2KSpcEudv6FOxA6WTWsch9b6Or
	 Tab2z58GTWX2feeNdjzi6LpoNRXkbTLsvakMu53Ah1izJcjwti+u6cCNBmIy7ILBgZ
	 8q99pCDwKY1JTEl8QytqRgm64Qa8FzCXj9BCjgdlSwIP/Xyncj4Y/MSAwHIEK4Njwe
	 nAqxfUSP9Im+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4BA4C433A2;
	Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] randomize_kstack: Remove non-functional per-arch entropy
 filtering
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172009865686.17306.9398253862841269029.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 13:10:56 +0000
References: <20240619214711.work.953-kees@kernel.org>
In-Reply-To: <20240619214711.work.953-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-riscv@lists.infradead.org, arnd@arndb.de, liuyuntao12@huawei.com,
 mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 gustavoars@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, leobras@redhat.com, imbrenda@linux.ibm.com,
 pawan.kumar.gupta@linux.intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Kees Cook <kees@kernel.org>:

On Wed, 19 Jun 2024 14:47:15 -0700 you wrote:
> An unintended consequence of commit 9c573cd31343 ("randomize_kstack:
> Improve entropy diffusion") was that the per-architecture entropy size
> filtering reduced how many bits were being added to the mix, rather than
> how many bits were being used during the offsetting. All architectures
> fell back to the existing default of 0x3FF (10 bits), which will consume
> at most 1KiB of stack space. It seems that this is working just fine,
> so let's avoid the confusion and update everything to use the default.
> 
> [...]

Here is the summary with links:
  - randomize_kstack: Remove non-functional per-arch entropy filtering
    https://git.kernel.org/riscv/c/6db1208bf95b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


