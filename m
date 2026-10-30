Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396407;
	b=FnEVbCAlA5pwQeKqLmhAYYuj4NP1iv8cyHr3wUa7RaAOwMxb6dt7gEL3EkEnEuzzGNeE
	 52cCxXve+PL3fgDLRZVbBd9ixlM0/a+i01bfcoS22D7hIKsbIaSmq7EiptwGWBlZtfwVc
	 tpUiXPV1kUfiFlofHZrK3v8qHiOcRcWXaC1UIKG2JMZtPY0gpXW2BUotWoS3frsbTpKLq
	 beDiN48opMUMGf7l6kNy5hxmoeOmIWIkx2eZbEylXH4MsG6G1aRPe71srWJNyqgu1PKhc
	 ECTXvMcRdtF6hbNg+6DHx6j2XknupolGX4NzbA3EBEzaopQV66nlk4egLLL2tTHNfPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=NdQCtHgXHon/pkAvjlHuvOoNN5Yh+NVemupI+L597I4=;
	b=yb15CkzqSCGZnvEeK/WMvZIo0axbdJIjzzWDNR02O0SratAPRn6r/CBtwp+raXqpQv8E
	 i2iQVrRtQCaCAgw7+0lSlFvExCwSyk5e56zbi7ShPkTPK5mPNieVkR7kLOa/IyoDek1x/
	 qdigZKQl6jrmtYlSosA9KY5B2MKi6JeXTa0g0o5/kdyoq2EQRWYlwvtEtFxSzR3/tqTae
	 DD0gvhhw+QChvhC6y0KTOkWagMfzXchqjR2rINwLDmxFfvLUvm35U8CUsnvT0f3Fhkqyr
	 UXv9C/w9IcX6U1zCktmwF+BqoPY8pEDiQp21vvb68Y+KgT8O/+o5QlDDMgVL6ow084Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwrX051i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE1606A31D;
	Fri, 30 Oct 2026 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwrX051i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEBB1F000C1;
	Fri, 30 Oct 2026 21:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793396406;
	bh=NdQCtHgXHon/pkAvjlHuvOoNN5Yh+NVemupI+L597I4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dwrX051ix7iadJ16BVoZCtQEJyj5FOkCQHRMcs+zpQO4EmgMu1mN7WVWQkIbatAId
	 YJoUwc1uIoU+1wBVYnIL74jmu8rDp0r1h62575E2Wi3pQaTx+Q3HEM3OqvhRfDqHYb
	 KDraTEqvvpNhjw7StqKfbpF7m4zTcCGYP9pfk9R3raa0sABh69tcX1WVpBrapnVU8e
	 x6VAyd31z29N6vIED0rJ1F8PiduPZCBPGk112M85+6md3Un5zwao60gdeHtOFv3vKf
	 U82R9VMHWC38dh+/Xd+2K/YCoBBUi5HuogGCTfkwbkyKGc7CXHN/JXt3rqaxZjpZAt
	 +s1FNhngcfyYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4019E3800478;
	Fri, 30 Oct 2026 21:40:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf v2] bpf: Fix jited line info off by the CFI preamble
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179339640506.1785640.8958890304775889953.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 21:40:05 +0000
References: <20261030-b4-arm64-bpf-linfo-cfi-v2-1-4eac83435d4b@linux.dev>
In-Reply-To: <20261030-b4-arm64-bpf-linfo-cfi-v2-1-4eac83435d4b@linux.dev>
To: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, iii@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, john.fastabend@gmail.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 peterz@infradead.org, puranjay@kernel.org, bjorn@kernel.org,
 mbland@motorola.com, will@kernel.org, samitolvanen@google.com,
 bpf@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 pulehui@huawei.com, sashiko-bot@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 30 Oct 2026 18:14:22 +0000 you wrote:
> With CONFIG_CFI=y, every jited line info entry after a function's
> first is cfi_get_offset() bytes too high on x86-64, riscv64 and arm64,
> so tools that use it show the wrong source line.
> 
> The JITs count the insn_to_jit_off[] offsets from the start of the
> image. Since the CFI commits below, prog->bpf_func starts
> cfi_get_offset() bytes into the image, and bpf_prog_fill_jited_linfo()
> adds the offsets to prog->bpf_func. s390 corrects its offsets before
> the call, the other three JITs do not.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: Fix jited line info off by the CFI preamble
    https://git.kernel.org/bpf/bpf/c/3e4279dc5144

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


