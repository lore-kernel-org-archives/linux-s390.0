Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58A52E04B;
	Fri,  4 Sep 2026 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554035; cv=none; b=pEo6h23mLzHxbKxXFkZqRyhASMN71yBATMJVyR5ulJhSgA/cVCTTf4Kt0+hd3C20kzCWq6lvkdLKnTxfjGU9zT6LVzCGVju5e+iaLvXdPZb2/m2WtidJ1Y4m8PFdKQdayhc7zxgWPJBTVUgV5oODczDJnEsqXI9GTET4ujKSczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554035; c=relaxed/simple;
	bh=SFCxo7jK8Vf7vBF6dwk61ATDJXcZ4hYutjmFl5AKd1I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Q1hv08BVtOyA4FR/bkv8vmYk3szcQe3ARjim+4WNP9zYMD8Vb8yRTwGCeMr5l+FmkNWn55y5hBOKBGM17kNMti/RlpGvIugzvOv9FjrQc+LBXV8tIjQOeNsaIRyde15A2fhGFnuqAVoOZhZ0FjpCZmT4tXscw+rJcwVXJCypWNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOs13i6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOs13i6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F161F00A3F;
	Fri,  4 Sep 2026 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788554028;
	bh=vAH6Kx/+f1y/dA82fhj1/GE5vDzTAqE05dgfOpLPlKQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AOs13i6EDO2Fzu97k8IOOEWHKjMF7tiKJZrWtE9Hqu/jrpY7Gigs3l2rjFc3oVQCE
	 vgthG19FvLLx7MtgPkQWNBNnXWb1qZNe+M0kvxfs9hB6Zl1irBKK/UUaUg4UE1iOPy
	 hZDbstFUbxL2so8v8NdxI8o5uJ5gMzYOcT38qEIrolAYlyQM9BQH8coVigkKMRNi+9
	 EVQfI7vh5UhjEssJjkYKyeGzL8pjEvvawojOWZX+H2CMK7pZEtTxvmUqCwRA4ywMP0
	 RiAjlKNc+SFMMJQumREkewHyc6t7tcYW/GvgiaIJxdUIcLhxaTjkZGyXn96ZlYDFg4
	 /GBn9ndzSQYhQ==
Content-Type: multipart/mixed; boundary="===============1590814207464027886=="
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f57cf431f791ef17d4e2d70bfcc30ae31eb1224c6ee152d382c8245c41f88c3a@mail.kernel.org>
In-Reply-To: <20260904195132.141068-7-sidchintamaneni@gmail.com>
References: <20260904195132.141068-7-sidchintamaneni@gmail.com>
Subject: Re: [PATCH bpf-next v1 6/7] bpf, s390: Use resolved pointer for timed may_goto
From: bot+bpf-ci@kernel.org
To: sidchintamaneni@gmail.com,bpf@vger.kernel.org
Cc: sidchintamaneni@gmail.com,jeremy.jean@oss.cyber.gouv.fr,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,a.s.protopopov@gmail.com,puranjay@kernel.org,linuxppc-dev@lists.ozlabs.org,linux-s390@vger.kernel.org,linux-riscv@lists.infradead.org,rlmenge@gmail.com,hargar@linux.microsoft.com,apais@microsoft.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 20:33:46 +0000 (UTC)

--===============1590814207464027886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 20356163d51e7b8551f96780e7e969a26767c5c4
> Author:     Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> AuthorDate: Fri Sep 4 19:51:31 2026 +0000
> Commit:     Kernel Patches Daemon <kernel-patches-bot@fb.com>
> CommitDate: Fri Sep 4 13:03:02 2026 -0700
>
>     bpf, s390: Use resolved pointer for timed may_goto
>
>     The timed may_goto fixup now passes the resolved counter pointer through
>     BPF_REG_AX instead of a stack offset and BPF frame pointer pair.
>
>     Copy the pointer directly into the first argument register and update the
>     special calling convention documentation.
>
>     Fixes: b8efa810c1db ("s390/bpf: Add s390 JIT support for timed may_goto")
>     Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
>     Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
>     Assisted-by: Copilot:gpt-5.6-sol
>     Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Should the Fixes: tag point at b8efa810c1db?

At that commit the s390 trampoline was correct for the ABI in force at the
time. kernel/bpf/fixups.c emitted `insn_buf[4] = BPF_MOV64_IMM(BPF_REG_AX,
stack_off_cnt)`, so %r12 held a signed byte offset and `lay
%r2,0(%r12,%r13)` correctly resolved it against the s390 BPF frame pointer
%r13. Nothing was wrong with b8efa810c1db.

What makes the old code wrong is the parent commit in this series,
d8319a04dafc ("bpf: Fix timed may_goto stack pointer for private stacks"),
which replaced that with:

  insn_buf[4] = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_FP);
  insn_buf[5] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, stack_off_cnt)

so that %r12 now carries an already-resolved pointer. Only after that does
`lay %r2,0(%r12,%r13)` double-add the frame pointer.

If a stable maintainer or AUTOSEL picks 20356163d51e on the strength of
its Fixes: tag without also taking d8319a04dafc, s390 is left with `lgr
%r2,%r12` while the fixup still puts a raw offset (stack_off_cnt =
-stack_depth - 16, e.g. -528) in %r12:

  bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)

then does `p->count` / `p->timestamp` loads and stores through a small
negative integer treated as a kernel pointer, which would trigger an oops
or memory corruption on every timed may_goto timeout.

The mirror case is equally bad: d8319a04dafc carries `Fixes:
e723608bf428` and will be selected for stable on its own, leaving s390
(and arm64/ppc64/riscv) double-adding the frame pointer.

The generic ABI change and its five arch consumers are not independently
correct, so either they belong in one commit, or the arch patches should
carry the same `Fixes: e723608bf428 ("bpf: Add verifier support for timed
may_goto")` and a `Cc: <stable@vger.kernel.org> # <sha>: <generic
commit>` prerequisite note. No Cc: stable and no prerequisite note is
present today.

Note: the same pattern is used by all four sibling commits (28bd77eb835b
x86, d35642770d98 arm64, 6e03227c5677 ppc64, 7053db7d3c0d riscv), so this
is a series-wide tagging decision rather than an s390-only slip.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33914557238
--===============1590814207464027886==--
