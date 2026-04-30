Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9B369992;
	Thu, 30 Apr 2026 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519563; cv=none; b=XaLxvcBiAPP6DhgrCOMAaZ9bognTDpkYV3kGRnEBIqmxr6ZaSCdp4hw+IVwYc2KaS9xcc7wrOCaEgg686T2oKpnivI6BQ5+9wHVvhtNf6574w4rC3Wc/pXqTKzuGr96bu8pkFRcXo7MnXGYYAohGemCL165tIdWdWhWHMZHYhGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519563; c=relaxed/simple;
	bh=uKdK5DO8u2N0tp/g6YrMeqTyIWEtsNmEtR2OQZOamME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BRhZzyVIkxenn87ak5cME6OnUs1keuvNg26ziLgDjtzgZlvf4N7/Zs7SY9BkGPN7fk0P5qzXR2oQvsLJRfZh+p1lHZeO4QhAQrHqlEQVMSsuKL1XbLLD+aWGXhSz4COf3ujC/kz5LM+nlPaqJ4lBUrPDcs0h9T8zuWHJDrjMYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2/IHGrf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2/IHGrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2178CC2BCC6;
	Thu, 30 Apr 2026 03:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519563;
	bh=uKdK5DO8u2N0tp/g6YrMeqTyIWEtsNmEtR2OQZOamME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V2/IHGrfyciCnZ68jtYyLcCX+9M7ThJMZaRbPHBvBmKoRk+K76qcgOuTXYyo/kQf/
	 h5OTplRTliCc4X63Y6FlfrVyvAdg5KYdnsvxSXwm9hkZAf8pdGxkdX/t+wSKmPKykm
	 3o2z+7QFO6wUIvvg+B0mdIk+nx1z6uoJGIDFvup9VAMO4drdvfxfJ8iFN05E11UcZy
	 rOwhunXd1D1ig0KRo5uu1vq5DA20gcZZ1Y5ckR+SNFRn+SNJ3mB2LionwukPg6k1ck
	 b3Kp9ZgtCTOh6fyut2FuoH+jqJa7iiIMSyJ3HPmYm6RuG1wUntuJYtMYTQhd5hUjoS
	 OIP4lynLo8F1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFE43809A07;
	Thu, 30 Apr 2026 03:25:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/6] change young flag check functions to return bool
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751951805.2274119.14382362682727203864.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:18 +0000
References: <cover.1774075004.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1774075004.git.baolin.wang@linux.alibaba.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Sat, 21 Mar 2026 14:42:48 +0800 you wrote:
> This is a cleanup patchset to change all young flag check functions to
> return bool, as discussed with David in the previous thread[1]. Since
> callers only care about whether the young flag was set, returning bool
> makes the intention clearer. No functional changes intended.
> 
> Ran mm selftests on Arm64 and x86 machines, and no issues were found.
> 
> [...]

Here is the summary with links:
  - [v2,1/6] mm: change to return bool for ptep_test_and_clear_young()
    https://git.kernel.org/riscv/c/a62ca3f40fea
  - [v2,2/6] mm: change to return bool for ptep_clear_flush_young()/clear_flush_young_ptes()
    https://git.kernel.org/riscv/c/06c4dfa3ced6
  - [v2,3/6] mm: change to return bool for pmdp_test_and_clear_young()
    https://git.kernel.org/riscv/c/42e26354c4ef
  - [v2,4/6] mm: change to return bool for pmdp_clear_flush_young()
    https://git.kernel.org/riscv/c/2d46a3974721
  - [v2,5/6] mm: change to return bool for pudp_test_and_clear_young()
    https://git.kernel.org/riscv/c/fb87c8827297
  - [v2,6/6] mm: change to return bool for the MMU notifier's young flag check
    https://git.kernel.org/riscv/c/1fc7dc675e26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


