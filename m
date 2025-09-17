Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658CE2F6195;
	Wed, 17 Sep 2025 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076815; cv=none; b=M0wAJNXOE9S6t+UNAGveu7SXs7GglN2KOLcWwWeFy6W378rUTBGaHY5xfuTQUirJw8KRwZ48DF8NU1Rop4PlGyhvXDWHNWiCBP726suQl996qkyZMCCDTBSrCne+WNOvpobMGQXpPqlNT2kjox83anPi40iQKcircd2OYHs4sf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076815; c=relaxed/simple;
	bh=S0LGJmfDGnE9fg7KBnzD+2AHLv2B7h2ODLru9DI0lsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bg6ufTiLNETDrU4yz5AlSFD3I+G/puqetK7vfNuK8MO/ofjeqeDBih7EoE6XnhzNNjMs4k2zr8M9KqQ8uOfeuRj5MZ7pub7PI8vE71S2UhXPDsrOfsGGqki0wwr11Ibbj5VrPPB/Za0cevjwXCL67GLmYNblBk4bEaP957pVWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2kToCab; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2kToCab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BF2C4CEFA;
	Wed, 17 Sep 2025 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758076815;
	bh=S0LGJmfDGnE9fg7KBnzD+2AHLv2B7h2ODLru9DI0lsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q2kToCabJnESW8vUmYIu1ab7o3eKbUVQ9kdfBJ5+bFVzM6d+DtAc8KVtPusjYCkkW
	 lfDeTry07jpkrR88IDvRwTSm3FlaZ3DRQ6C++gAnt82jJ0z+Scrrn5/YRjgzwA/HN3
	 00XOAJwZMLLA9HO7PYsBVjZTl/U8OOd6x+xQPVndCWFi4sV0hwZG8LvrJ5/ZQjM8dU
	 g80BovHTnqKi3d7f1jLzDsU2LDkK8EhzlmQ9Ajml61y/5qXBl0YvlIuYhH5VvVi8p4
	 O3PqYNJ19XigxUlBZqKp2vk/Cv2tkyyhAPwjYXzX5Qsgrgr/oifjbHdpTeNPeic3Xx
	 l1L+BkrtQRVLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C6539D0C1A;
	Wed, 17 Sep 2025 02:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] kexec: Fix invalid field access
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175807681600.1444719.17902386827099362069.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 02:40:16 +0000
References: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
In-Reply-To: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: linux-riscv@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org,
 akpm@linux-foundation.org, bhe@redhat.com, coxu@redhat.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 27 Aug 2025 03:42:20 -0700 you wrote:
> The kexec_buf structure was previously declared without initialization.
> commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> added a field that is always read but not consistently populated by all
> architectures. This un-initialized field will contain garbage.
> 
> This is also triggering a UBSAN warning when the uninitialized data was
> accessed:
> 
> [...]

Here is the summary with links:
  - [1/3] arm64: kexec: Initialize kexec_buf struct in load_other_segments()
    (no matching commit)
  - [2/3] riscv: kexec: Initialize kexec_buf struct
    https://git.kernel.org/riscv/c/95c54cd9c769
  - [3/3] s390: kexec: Initialize kexec_buf struct
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


