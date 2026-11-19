Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076947;
	b=1Ts0M6JIuoKFopDtioSttMAQYdh5BhvrUwsrPYorigmQk4pdWRLB4a4L2kHnM+Gct80j
	 yRUfRaN0avaZJqJ3N1WrRkuS+14Hmc2WQr0fG2w2bp7uL3yixO++I53SPwdWLQaREb7us
	 avJ/nYyQ1q+7DHVdDnMuqqp3D611TX8zH7ijstwrOwxXgUeJX2cpJgeKYMrNsGcVtjkcZ
	 JnDQgjzcBMwa3fTbCJPRYq7cPPd4Sk/L8CJ3YOhL4CiD1Szg81AcpcHljni4xTzOhGHuT
	 HKhZq95AcTkUVFyE8qhJehsdX0Dz/AwVWU6gM1CHTH5AsWjLOdd1QZaqIk8O5dtzK5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076947;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f51b8tB6VpP1Wj9P2gyxiXh1IFjmZFkHnlXtuEHncH0=;
	b=C20xlsrxFhhasDw3fBHR6pJviY0RvmACVnk8dz0URmBG+CYht7yt6kYT8Ui3Ca8vNriJ
	 dYAxRJ9dyY65jwBz9uDQ2MFCFW835Me/b1dh5aAEmURSa1GQ0Yi8FaI0CGILaB2asWvQV
	 OUUrtqGrBiP/b6q92n5GwFDcnuNNDMQsiugAq+FH7bKvNVAPel5ZTAa3GeYu6VZZ5DxBl
	 P7+krUqf8tF9kZhf3hFfJvzV2P4reKnZJluRqwFsZRt+UV3U8YyrtyMzFRHpmjxGZE3dU
	 FuXT44tfk9tXlcs9njtJM8Vkajn9eABShVXatf9TFcvGDUUAmumF44Kfwpqo/mluPRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T36iafg7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458E606A320;
	Thu, 19 Nov 2026 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T36iafg7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989DD1F000C4;
	Thu, 19 Nov 2026 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795076946;
	bh=f51b8tB6VpP1Wj9P2gyxiXh1IFjmZFkHnlXtuEHncH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T36iafg73BtbkBse/f9RUqWdUGqiHzVESt54+/jMcjn/BuJzfwpZ6PeaDVXTabTWw
	 dn9mDc7L8DHGcXFMS0eit+mAY+RzmEYC6UiwewzO2iSy+2OS45YhWQDqQ73H+nophC
	 xPW7eGNHezJDm0bx9rhJiQH7PNToNk3GqEfwsWsVZ8YrE70CSBGR5M9a3J+ARSYnVc
	 CJke71Pmll67uH3roZ8v1wgnmi5Wr9JJv7p+G3xza2atEbHIgHonrUYTDsL4mqdVie
	 5AdjE0uvzv7bz3zRmkihCE/9BU2xdbyCmKWl53r9UZCo8JyLdnieMqH2aSDTmry+AZ
	 ye997UTPjWAdQ==
Date: Thu, 19 Nov 2026 10:29:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/8] s390: Add __must_check to set_memory() primitives
Message-ID: <av6zTc7Lx8VtVRBm@kernel.org>
References: <20261118144709.202520-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118144709.202520-1-hca@linux.ibm.com>

On Wed, Nov 18, 2026 at 03:47:01PM +0100, Heiko Carstens wrote:
> A small series which adds missing return value checks of set_memory()
> calls to s390 specific call sites. Also add __must_check to set_memory()
> primitives in order to avoid that new unchecked callers will be added.
> 
> This is basically the same what was done for powerpc with [1].
> 
> Note that this (trivially) conflicts with [2]. Furthermore the kexec code
> is the only call site which for now only prints an error message instead
> of really handling the error, since error handling in common code is
> missing. That needs to be added with later changes.
> 
> While doing this conversion I realized that s390's execmem support also
> can be improved. Will happen with a follow-on series.
> 
> [1] 2abbd6d5fbe0 ("powerpc: Add __must_check to set_memory_...()")
> [2] https://lore.kernel.org/all/20261117-fixes-s390-v1-1-2d9d04ca0072@kernel.org/
> 
> Thanks,
> Heiko
> 
> Heiko Carstens (8):
>   s390/kfence: Add error handling to arch_kfence_init_pool()
>   s390/kprobes: Add error handling to alloc_insn_page()
>   s390/kexec: Let crash_protect_pages() warn in case of an error
>   s390/module: Add error handling to module_alloc_ftrace_hotpatch_trampolines()
>   s390/mm: Add error handling to arch_setup_zero_pages()
>   s390/mm: Add error handling to mark_rodata_ro()
>   s390/mm: Add error handling to vmem_map_init()
>   s390/set_memory: Add __must_check to set_memory() primitives

For the series:

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  arch/s390/include/asm/kfence.h     |  3 ++-
>  arch/s390/include/asm/set_memory.h |  4 ++--
>  arch/s390/kernel/kprobes.c         |  5 ++++-
>  arch/s390/kernel/machine_kexec.c   |  7 +++++--
>  arch/s390/kernel/module.c          |  7 ++++++-
>  arch/s390/mm/init.c                | 10 ++++++++--
>  arch/s390/mm/vmem.c                | 14 +++++++++-----
>  7 files changed, 36 insertions(+), 14 deletions(-)
> 
> base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
> -- 
> 2.56.1

-- 
Sincerely yours,
Mike.
