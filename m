Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571374;
	b=l5KH+YHtWSf6jGkQiSckXj328xaHiIZ7DqoJSXLh+Q6eVFZz9HZfwZbsScygPXI6wcak
	 0hAvKprTjXz5aM7sOVqsl+64FTsBUPg/fkRyuJXy4br9ZEqF7fci3bjaAWkgcW7Ajp2QY
	 gqyxyfZxHgqXbM5VfPTM2D3eSO8HPnidEdBgVtRgaYrwXz9A2zscAxKwju/wSSRmwpUSW
	 Xf3UtvvnikT7sdyZHLmguSYLfBOpdFDnWAC4zwHFxXGAWqAmz0px6ud04EmznzYO8BPAM
	 ptUjqVw4/+hMELbb6NLWZyQRLaEZsZwo0c0lCLXniDDbCq50j0Y5M4FmU2Azi6zu7Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571374;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=k1DWd8TsBWg5NBBxBu42AFkg72eDnbidrtlPTmYRtJY=;
	b=kb7UrpmxCpp/rNPSsRZeWOoRvHootzjsnyT2ts+zvIG6ZvIEd1A7tItpCgaDmwcPFmMn
	 H4bSjspg95jE0Gy4AvT/XXe1ILL19LTQJgVKWLLBOgQNa4agVbvKaYMhS0XVLEwh0DuX/
	 WyrYgpRzaVAQRjzHFjX57cEtkF9K16AGIbmiWJRe9VNK2gR/8aox7E5Ovxhr69CLZDyMJ
	 DlHtZ2WdcHc7+LnGb796z4/KD3So1YM4Er56bp3nTLbNaOa21034o+/SddnkRNxaDhamP
	 FjnP3yIlIUKnynbUlyBwjB6aKoPBSi8bsHTjj4auRtJkuH42EuXbmHtHVCctH3GWFEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4nmcWS6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10360A3829;
	Sun,  1 Nov 2026 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4nmcWS6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE641F00A2C;
	Sun,  1 Nov 2026 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571374;
	bh=k1DWd8TsBWg5NBBxBu42AFkg72eDnbidrtlPTmYRtJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l4nmcWS6A/4Hr5O71oODbuTRUfO0NkWJ85KjSmxpc4wtkYxkpb1bOMwK0jr4BmFWY
	 lYIEM9ylgDV6SUrYMpJIE2KKFpoD2nnt+UGewiExEhxyhKTMOjm+T52MFPeK8Yd0J+
	 p4q/4axVz0UfZx3L63VYvsm1IdHUsRWd2LlParmpMe2U//B6WU2rzsRD4qt6poBS3X
	 9nvXcpbi8Wvh3JxnKjFOreSdRvTy7KVewOW8UsbJ5RSKNcsm8ZfOb0TAb1yKpjZZPl
	 L41yoUudqhZYHKnzicNfUykC9EKnM+e9w4aN1yX+WbAJDCsXR56xtkURsIUpOdA2Bn
	 Z4trFEgXz6Wyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030DB38003B8;
	Sun,  1 Nov 2026 22:16:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/6] arch, mm/execmem: resolve confusion about
 set_direct_map_valid_noflush()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357137254.2624073.6914916059318534007.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:12 +0000
References: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
In-Reply-To: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 abarnas@google.com, aou@eecs.berkeley.edu, agordeev@linux.ibm.com,
 alex@ghiti.fr, luto@kernel.org, bp@alien8.de, brendan.jackman@linux.dev,
 catalin.marinas@arm.com, borntraeger@linux.ibm.com,
 dave.hansen@linux.intel.com, david@kernel.org, gerald.schaefer@linux.ibm.com,
 hca@linux.ibm.com, chenhuacai@kernel.org, mingo@redhat.com, lenb@kernel.org,
 palmer@dabbelt.com, pjw@kernel.org, pavel@kernel.org, peterz@infradead.org,
 hpa@zytor.com, rafael@kernel.org, ryan.roberts@arm.com, svens@linux.ibm.com,
 tglx@kernel.org, urezki@gmail.com, gor@linux.ibm.com, kernel@xen0n.name,
 will@kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org,
 linux-s390@vger.kernel.org, loongarch@lists.linux.dev

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Thu, 03 Sep 2026 12:28:26 +0300 you wrote:
> Recent discussion about implementation of execmem's ROX caches on arm64
> revealed a confusion about how set_direct_map_valid_noflush()
> implemented on different architectures.
> 
> On arm64 it sets or clears the PTE_VALID bit marking a PTE as present or
> not present.
> 
> [...]

Here is the summary with links:
  - [v3,1/6] set_memory: add number of pages parameter to set_direct_map APIs
    https://git.kernel.org/riscv/c/be7dacb9c1d4
  - [v3,2/6] mm/vmalloc: set area's page_order after allocation succeeds
    https://git.kernel.org/riscv/c/40702f168a9e
  - [v3,3/6] mm/vmalloc: constify vm parameter of get_vm_area_page_order()
    https://git.kernel.org/riscv/c/1f73dfdeb9c2
  - [v3,4/6] mm/vmalloc: make set_area_direct_map HUGE_VMAP friendly
    https://git.kernel.org/riscv/c/86dc0280b807
  - [v3,5/6] mm/execmem: use VM_FLUSH_RESET_PERMS for ROX cache allocations
    https://git.kernel.org/riscv/c/4c4b2ed5b783
  - [v3,6/6] Revert "arch: introduce set_direct_map_valid_noflush()"
    https://git.kernel.org/riscv/c/0e774fdb2ed6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


