Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370BE30F819;
	Mon, 26 Jan 2026 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769401318; cv=none; b=luXbqybbwNubopkz2Ziy58J9ZutgwOXkJFxd0OU1pkzPMxUp45PSll6FqQbV7+bWSRgm0gNa2qp7PRNvoOIHrk2PZuN7boBvuZw1+MWZC0oO8JcuiXsw8N4Q5MK7TsM7TBmApO1n7CMPNzhRmnm6WLjc3TcNtQLhW2RQEKHgBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769401318; c=relaxed/simple;
	bh=u2mZjtT2ef63nBRxN806PtRnf8Sp48BSpzrnucxNvLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t0V3XQHZ1zFYwiXUyByu6hBWWtObEpAGsQKu8O56DWQaRwF55OMLuAFL9DDA1nkazYwDg+SeP4vrF0Ml4NzYVeDdFdwFf5pLTn0rQdv7a8+mlj2/FXQiXd3fkiTLPyG8C1SKJK2JZ3BOrd+ndi6i05N2ojJPdx1SVmhG8KOuRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx3khty3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx3khty3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163A3C116C6;
	Mon, 26 Jan 2026 04:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769401318;
	bh=u2mZjtT2ef63nBRxN806PtRnf8Sp48BSpzrnucxNvLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mx3khty3+dTGClMOSsm4TCGURDjhMxIJ6Hr1bO+Hbm7pIDDMRiqqUI60/PSBokAlS
	 XDKfB/qj+L3xyJ2qvyINgs0wD1pWn95s+Rkn2LpKpDZVb3Qm6E11lRb6+gmxfXX2fp
	 Y0puJp0SfTExJAn/+KhCOy5Bb/Cb4Wib65mAZItqOyzuEp0PMSk2hQ9F8YHBPAhLUl
	 4OkRVSJbQNM9okPoSdnbRH4h5yxkAZi8MRJuUoppDD2ti/3VZX6AQcX0/6q4RJB+hX
	 BoyEqXvgV5dn4f1qXwsNoEWqJw9JT7awjVq+tpfrUMGLV8dNWUCboeRZP7SRPsDOMP
	 iCanGpQICOKlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B303809A22;
	Mon, 26 Jan 2026 04:21:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7] mm/hugetlb: ignore hugepage kernel args if hugepages
 are
 unsupported
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176940131284.4057692.12950572087692218599.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 04:21:52 +0000
References: <20251224115524.1272010-1-sourabhjain@linux.ibm.com>
In-Reply-To: <20251224115524.1272010-1-sourabhjain@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, christophe.leroy@csgroup.eu,
 hca@linux.ibm.com, mingo@redhat.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 muchun.song@linux.dev, osalvador@suse.de, tglx@linutronix.de,
 gor@linux.ibm.com, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, x86@kernel.org, david@kernel.org,
 ritesh.list@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Wed, 24 Dec 2025 17:25:24 +0530 you wrote:
> Skip processing hugepage kernel arguments (hugepagesz, hugepages, and
> default_hugepagesz) when hugepages are not supported by the
> architecture.
> 
> Some architectures may need to disable hugepages based on conditions
> discovered during kernel boot. The hugepages_supported() helper allows
> architecture code to advertise whether hugepages are supported.
> 
> [...]

Here is the summary with links:
  - [v7] mm/hugetlb: ignore hugepage kernel args if hugepages are unsupported
    https://git.kernel.org/riscv/c/b02019169284

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


