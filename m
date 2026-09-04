Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916D4EA394;
	Fri,  4 Sep 2026 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554035; cv=none; b=RqfOwo6MoojiQFbR+wKXmutyL6CcPHWSnGurFruSzoKy08h4MFH7SadgK/R8odDYxXMZscAyzBSMQPIKyTi0vw20jLscHV/FKUu8xhoPRwja40tTht86qtfwfFMwPweUrhJw5SVFDLF6TPeL4kzrVsYw1abZXa0md5XLKTtbQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554035; c=relaxed/simple;
	bh=jvYCLIPJv5nyeQkLvI5m84SZ/oFLyU61j1EB/iX187A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nTvKaRZdAFg+aHPnSHp6/2YcJBowBN9rT0WkY3MgRl2oMD09NlhYF6yGaclYujXsUpybxvNujXxrBCUcgBlgWlTKjciRQZwI/RRAEvS9tQSczvnvtq88obGwJ7c0ygTydJkXu9ISpkGtJYyOdP750z0WeWIYP4qNMdmhjv1ZgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw1B/cic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw1B/cic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6881E1F00A3E;
	Fri,  4 Sep 2026 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788554025;
	bh=8aB1i9jJLG+tSKTCm+1ryvh5nYTDSP1C/YxKnVYbkFo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Nw1B/cic15PV8GvcJBDU3KgUvAJCEDg1ovQi0JHYn+ONAlYGy+dGN7nC8R1VMhzVU
	 P6y5s2cNwlnf2En8vgDUM+4WRjVWAnVv6qum4rdKSFpd7PElGXT//ley+6mZ9avApz
	 tJzpPov8X0+v5xlfa32tgkywVgKAXqV8DpeW1knJ3W3e8vE6Hbl0rKHdxh6Ng0FPpO
	 NrAtWI7NNT6jI4Y/iHu+4v6QSWwO/+VnLbQsD5V0dzxi7/myWyg/ifUrh/kPYXOdBI
	 P3d230pecJL0TTFmWIqlWxhBmt9vkqZrtYef58g8CQ3yGu2eZlzPkoZ6h+X8PjhWUe
	 xnGC3xZiiySKQ==
Content-Type: multipart/mixed; boundary="===============0649529080789511206=="
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4866144aa416a8491c9874325394e88f5dc2e66259212baa56032e0428f0772b@mail.kernel.org>
In-Reply-To: <20260904195132.141068-3-sidchintamaneni@gmail.com>
References: <20260904195132.141068-3-sidchintamaneni@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/7] bpf, x86: Use resolved pointer for timed may_goto
From: bot+bpf-ci@kernel.org
To: sidchintamaneni@gmail.com,bpf@vger.kernel.org
Cc: sidchintamaneni@gmail.com,jeremy.jean@oss.cyber.gouv.fr,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,a.s.protopopov@gmail.com,puranjay@kernel.org,linuxppc-dev@lists.ozlabs.org,linux-s390@vger.kernel.org,linux-riscv@lists.infradead.org,rlmenge@gmail.com,hargar@linux.microsoft.com,apais@microsoft.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 20:33:44 +0000 (UTC)

--===============0649529080789511206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_timed_may_goto.S b/arch/x86/net/bpf_timed_may_goto.S
> index 54c690cae190..6e9d9e7c2b1d 100644
> --- a/arch/x86/net/bpf_timed_may_goto.S
> +++ b/arch/x86/net/bpf_timed_may_goto.S
> @@ -11,12 +11,6 @@
>  SYM_FUNC_START(arch_bpf_timed_may_goto)
>  	ANNOTATE_NOENDBR
>
> -	/*
> -	 * r10 passes us stack depth, load the pointer to count and timestamp
> -	 * into r10 by adding it to BPF frame pointer.
> -	 */
> -	leaq (%rbp, %r10, 1), %r10
> -

A subsystem pattern flags this as potentially concerning: This commit
changes the x86 trampoline to the new 'pointer in BPF_REG_AX' ABI, but the
producer side of that ABI was changed one commit earlier, in d8319a04dafc
("bpf: Fix timed may_goto stack pointer for private stacks"), which
rewrote kernel/bpf/fixups.c to emit:

    insn_buf[4] = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_FP);
    insn_buf[5] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, stack_off_cnt);

At commit d8319a04dafc (i.e. HEAD~1), does x86 still execute
'leaq (%rbp, %r10, 1), %r10' on a register that already holds a resolved
pointer, producing r10 = rbp + (frame_ptr + stack_off_cnt) -- roughly
2*rbp, a non-canonical address?

bpf_check_timed_may_goto() then reads and writes p->timestamp / p->count
through it (kernel/bpf/core.c:3410). Would any BPF program containing
may_goto oops on x86_64 at that commit?

The same window exists for arm64, riscv, powerpc64 and s390, whose
trampolines are only converted in the four later commits d35642770d98,
7053db7d3c0d, 6e03227c5677 and 20356163d51e. Is the tree bisectable across
the series?

The two halves carry different Fixes: tags (this one 2fb761823ead, the
fixups.c one e723608bf428), which invites a partial stable backport that
reintroduces exactly this wild-pointer write. Would squashing the fixups.c
ABI change with the arch trampoline updates, or ordering all arch updates
before the generic change, address the bisectability concern?

>  	/* Setup frame. */
>  	pushq %rbp
>  	movq %rsp, %rbp

The x86-only __xlated expectations for the timed may_goto expansion in
tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c were never
updated for the new 7-insn -> 8-insn sequence. The test expects:

    __xlated("7: if r12 == 0x0 goto pc+6")
    __xlated("8: r12 -= 1")
    __xlated("9: if r12 != 0x0 goto pc+2")
    __xlated("10: r12 = -24")
    __xlated("11: call unknown")
    __xlated("12: *(u64 *)(r10 -24) = r12")

Does this test fail on x86_64 for the whole series? Every line from index
7 onward is now wrong: the first branch becomes 'goto pc+7' (insn->off + 6
instead of insn->off + 5), the second becomes 'goto pc+3' instead of
'pc+2', 'r12 = -24' is replaced by the pair 'r12 = r10' / 'r12 += -24',
and the trailing indices shift by one ('call unknown' at 12, the store at
13, then 14 and 15).

git log 28bd77eb835b..8dc5c7d5340d shows the only selftest commit in the
series is 8dc5c7d5340d ("selftests/bpf: Test timed may_goto with private
stacks"), which adds new coverage but does not touch
verifier_bpf_fastcall.c. Note the original x86 JIT enablement commit
2fb761823ead -- the commit this patch lists in its Fixes: tag -- adjusted
this very test for the same reason, so the update belongs with the ABI
change.

> commit 28bd77eb835bc1a95190315e93afbc6bb186b9ff
> Author: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
>
>     bpf, x86: Use resolved pointer for timed may_goto
>
>     The timed may_goto fixup now passes the resolved counter pointer through
>     BPF_REG_AX instead of a stack offset.
>
>     Use the pointer directly rather than adding it to RBP. This preserves the
>     private-stack address selected by the JIT through R9.
>
>     Fixes: 2fb761823ead ("bpf, x86: Add x86 JIT support for timed may_goto")
                 ^^^^^^^^^^^

The existing Fixes: tag points to commit 2fb761823ead, which is not an
ancestor of this fix and is on a different branch (bpf-next/res_spin_lock).

The bug was actually introduced by commit 47ab38f3f4d9 in this branch's
history, which added the incorrect code 'leaq (%rbp, %r10, 1), %r10' that
overwrites r10 instead of preserving it.

Should this use:

  Fixes: 47ab38f3f4d9 ("adding ci files")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33914557238
--===============0649529080789511206==--
