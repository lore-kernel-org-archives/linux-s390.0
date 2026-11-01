Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571407;
	b=p1jNimCAFJuNnuPxLmVmS92fJ+XTq19yN3lTHboB5UMCsPmEBxUgcVMukUzrcM+hMU99
	 Mb9QjjJyk2cRJSxdsyb/0IFe6VBjSHTJsdgC1TO8ncknFw6MuDq5rcpL0J9sY51q8ePpF
	 o1ITULEJ/3RUomjc1qh059ActNDZiGVARI9PX74pQRqU5hItDlnCFzROU1VLNP/wQCgG2
	 UvohsxXEbCQRBA/EZKi2idH7Jed/LYkWDtj09jmUtxpGuBPsR8kf7H+pP1H2FDIg18pWl
	 +Rq9JIrh4W4X3OVElyP8pkGAvCiKa1Z8a9dW/FaA2ZgpUoSOFHvnJGB/ZNBpAUqAaNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9SjWrhc7XGpfrZLDGv5e/UGJ5LKzUlRr1ymU5F3rbK4=;
	b=aXG8cv1OdhmiJxAkwatFP2Z2gsKR3SoG4KqPboe8thhOnjpNd2nioWsBCWIYBRQ6HsjS
	 Ln61gZyhx5EAMLnU3/zSLrJA+Pd8REvHZINcQEo9LdPwvH6WfGnSu0t58+RcQiTYq5/bk
	 V64i7NL8sR9Py8RybxXLJMlU1dthgc5gjH7Ne8B846r9nu8O4onGaptybIpLaAbt6ocet
	 ZHOUuMIU0A7/xcVHg916H/8Yt8YFEVws5O34ZkBwr8XZBWm+MPx7SP8yzb5gHZkcegEs5
	 u/9n4Azf52Ks367VluXDKlcaBGALRvC9m/NyH9Rr9kOAqq58b8OdwOnvQW9BXlkUr5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCRw8XNL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EEC6070EB7;
	Sun,  1 Nov 2026 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCRw8XNL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43571F00A1C;
	Sun,  1 Nov 2026 22:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571406;
	bh=9SjWrhc7XGpfrZLDGv5e/UGJ5LKzUlRr1ymU5F3rbK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PCRw8XNLxhwpgQY+VNJEgyemCH7WcIUexDDLxDQtKsJZyKUtdTMN3MNlZltJ6M0iy
	 0sNvBS5zOI3cOGvEHXCS4FDiiBRJt4YTWvt0Z5W2pEwwNWqyPsD/jW7sJeFMWEVfwu
	 32f/8TpLwxDIfiPxqr6f6Sc8JtU205KYvtKUxdXIsWKDgfMrSec039M8wUBLONKqKV
	 C8h60HgiPJV6UBIQ+RJCyhEArenvuts1IeS5Ti1EIWkF9gSpCYTJmdYsxaCB3+MhvH
	 cKC00fZeAT+3Xb1OaF1XeCb/NrEIVbK+ayJvZHgHKBP7c9ZLF51en7iMywKamnPnBz
	 Vky2U/YXxjHxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1E838003B8;
	Sun,  1 Nov 2026 22:16:46 +0000 (UTC)
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
Subject: Re: [PATCH v2] arch, mm: promote DEBUG_WX to CHECK_WX
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357140534.2624073.9989407542230376185.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:45 +0000
References: <20260926-direct-map-verify-wx-v2-1-efcd64a6b74a@kernel.org>
In-Reply-To: <20260926-direct-map-verify-wx-v2-1-efcd64a6b74a@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 aou@eecs.berkeley.edu, agordeev@linux.ibm.com, alex@ghiti.fr, bp@alien8.de,
 catalin.marinas@arm.com, chleroy@kernel.org, borntraeger@linux.ibm.com,
 dave.hansen@linux.intel.com, david@kernel.org, gerald.schaefer@linux.ibm.com,
 hca@linux.ibm.com, mingo@redhat.com, liam@infradead.org, ljs@kernel.org,
 maddy@linux.ibm.com, mark.rutland@arm.com, mpe@ellerman.id.au,
 mhocko@suse.com, npiggin@gmail.com, palmer@dabbelt.com, pjw@kernel.org,
 hpa@zytor.com, ritesh.list@gmail.com, linux@armlinux.org.uk,
 sshegde@linux.ibm.com, surenb@google.com, svens@linux.ibm.com,
 tglx@kernel.org, gor@linux.ibm.com, vbabka@kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Sat, 26 Sep 2026 12:29:29 +0300 you wrote:
> Verification that the kernel does not have writable + executable
> mappings is about detecting security risks rather than a pure debug
> feature.
> 
> Major distribution configurations enable it in their kernels as well as
> defconfigs of most architectures that have ARCH_HAS_DEBUG_WX.
> 
> [...]

Here is the summary with links:
  - [v2] arch, mm: promote DEBUG_WX to CHECK_WX
    https://git.kernel.org/riscv/c/2e83e2ce34ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


