Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F014C581;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420744; cv=none; b=UdXdcaML+V+eK3Is/Cbw96Pz2+Hc9upxJuoDFtPtjhFLSjG/ZPKgLQsewdrd+8iT6QX/kJAz+SrP6GrZMG0fEN4uj8Eu2IwRyzLwxFJbPRrdhhpOBY1YUwiZQ0MuN+pLkRtOTe0SyAr0/507c+GPtgt7Mk0U5zHelQhngOW45m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420744; c=relaxed/simple;
	bh=DMZ8A416rj3K/WIir9WPtL3TV/SPPZCOPyqRSy00irs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OxHVW9lM2Yt5bz9x4L02eC1ccJiBtxcydZSrHa5p2cTGXeiQ+7tOrPoFyfnWZ4gKJySwKE7Atisn8bVKeqR+Ey6QojgTZKmU0FwhzJiKhLxgsgGsJ2Jpl0HkeOH18rxCp4Fy3MyBi+S6OyJ4JzlxnPa9H9qXAUuKwEURXkj3KhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnrWrKxA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnrWrKxA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A476C32782;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716420743;
	bh=DMZ8A416rj3K/WIir9WPtL3TV/SPPZCOPyqRSy00irs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nnrWrKxAo9mkqq71SM15auqRvSuvMo1cwsc6uvNC0KmIf+8W+IFcGygA3Eo10mVeF
	 G2s+yrZMHPymUXLo+nLgP9UO7ySUEsYIr50vVERehi9hXlgnqcVX15e5hUtoNM1MCz
	 KdnJ408xiD+Wl9pXpBy3F6o9nfLEvLRX7/+b2odzWwlKArAQUij/s2m/3Jjh97LXPg
	 F8nJXMua61Qqa3D8YshT5wUFNBblfy5aUQ+sDx/fnkyS8EUbkRV5Kgi4KlL/y5Jmh6
	 7bCukgmu47qPQMBbXvCJyTY00enK+zaAd4j5um3XBgM7w9fHKYmb4gx7qdCy7Br/vb
	 fDCO7Xn+t58qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7625CC43638;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] kprobe/ftrace: bail out if ftrace was killed
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642074348.9409.15455041633304152397.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:32:23 +0000
References: <20240501162956.229427-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20240501162956.229427-1-stephen.s.brennan@oracle.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, guoren@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, James.Bottomley@HansenPartnership.com, deller@gmx.de,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Masami Hiramatsu (Google) <mhiramat@kernel.org>:

On Wed,  1 May 2024 09:29:56 -0700 you wrote:
> If an error happens in ftrace, ftrace_kill() will prevent disarming
> kprobes. Eventually, the ftrace_ops associated with the kprobes will be
> freed, yet the kprobes will still be active, and when triggered, they
> will use the freed memory, likely resulting in a page fault and panic.
> 
> This behavior can be reproduced quite easily, by creating a kprobe and
> then triggering a ftrace_kill(). For simplicity, we can simulate an
> ftrace error with a kernel module like [1]:
> 
> [...]

Here is the summary with links:
  - [v3] kprobe/ftrace: bail out if ftrace was killed
    https://git.kernel.org/riscv/c/1a7d0890dd4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


