Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D155D865
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971707; cv=pass; b=R+GN1Z3m+kH4WUgGHcYp6Kd28rPA714gbIa2xAsUziiaFqHfGyeYS8VBycz3zRlStDnXYq5FrQAow1J03bIAS3JrsZKKQXVGCIDX0GreSmA4IjFJrpC15Wcm85fXb31AqEcIm2oXjS4dG7SMDUoqNpjCLvZFRvZ+9NWFWAXRN30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971707; c=relaxed/simple;
	bh=CaGvruleJgSZ7D4tJOVRAyip+ySuTNDBO1Fgf4mzBjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2DhcAsVGR65IDOecx8LBhW+2VzZidqHP6iiamOBsGOt9AnW/rietFhyRyPheUVbwjHUXFpqp5WDddw7zaRenSAYUhGh84jLqs0AJ+/S92VDy7RtvQ6PUYzwPOEQcivHdxNz0BMHBCByOP5HeqaeqIXsOe+HQ76VsumpaJZidJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAavCD61; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAavCD61"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-87ffa98d4a9so11308217b3.3
        for <linux-s390@vger.kernel.org>; Wed, 09 Sep 2026 09:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788971705; cv=none;
        d=google.com; s=arc-20260327;
        b=WF46CfxiLYC4QBtn5GnpHuXIPLkOnHAEw7qhBHdn/oDA6mBvN+8DuyPP56hvWXQD25
         AumPeHOdHMXhreou+TBmZtsa9Y1+AvMgXI+dtUqB9zR9h3BUdJ9UbzZLe3mDvOx/w3IN
         VqgHJEumvmLksDXBXZHSZZ/KOOTLsd13iKd/QmGZxhX+RdPNCL24Og+KqX/eo2SANL1Q
         cGgnOD8gSQ8pBG6A6AO0BD3mjbP7TN/zzNGKlniwNl6fTySeCa8E2zRHWAIBUns/7RLH
         HnSJQ6Xxs92NFsAYgQv4qDhjx6yY98BlysS0dMf6kMgt1/Oq+yYE0HXDvwcBSLTBwcYt
         JvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AurL6CS51ZxhuGokqtXHBRLRcchDPoQ4/ZSuDu7JVek=;
        fh=SSONzHcTOZO2hxpd94ZPe69FlfnH6Wr5PFbXTr+nJyk=;
        b=mrFpO7xMWwMa23w9oBB2RxXgXc7V+q5XN0GB+t0IeanycC6pOENLX6/hdMLuatg5af
         2ZoSEJ8mSixCsFnaAib+bEMHiMlbDsUhwC8mZbcoBJlsmXrvh1wlU/w00xPfoBzpvV7b
         Sf//0Wqgsj/TlCb4yOnHDY2SSawkROmIduV/NoT16bM8vlkpEiJj2k0VjaG5Sbfu43lP
         h9Ety5YSmdnuQ6sR7QdmGy6dbygDPiMD4nNGf5nPrHIAa0oCpLxm583A5V+LV8NotdIG
         +paumLYIJOBMz8KVJZd2REml6azTdDzu3bkCnMCICax/OloE8G0bADo1F7h/AIKKFxyc
         KSGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788971705; x=1789576505; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AurL6CS51ZxhuGokqtXHBRLRcchDPoQ4/ZSuDu7JVek=;
        b=eAavCD61HoITToJi72MH3kovLTox2K97malcDr3Q9GRDdZasXxxoNnCpeUbAe63y/Q
         QMuHeZxcrREH8kZDubpkURnw7kXShAaPqa9iDIdDDwW4ouAy6PiWvIsv+i6YDEQIO/oa
         7LgMb/IIck834sVs8SpX67rjYC9GJRBDwTUay+YzMaFXmrw2vE7fz3thxVGH2IPIODAn
         ws1i28deTBK0v/yW6HN+nWHfXol6x4up9T59knVRLnThz+1URdJVG8oIMESvxG0qaXGp
         l8K6PvDT6vyGZOkKgihUfheBKsr7K3rkJ1Pf1+rTGhFKGFs7JJSctONDwm/SaICpQTAY
         UyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788971705; x=1789576505;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AurL6CS51ZxhuGokqtXHBRLRcchDPoQ4/ZSuDu7JVek=;
        b=AWrM3GupmN621px8fgSNO/L44VShYupC3Z275rtKqVS5iHljEUK9zDUKJeEtM9qtqc
         HDpKWC16+y26IHwacG+UjtMShpXuH1hwuwdiRgSqlDTUNfLW/Jteyi0SMZRZKaW0tSFz
         PvWM/0Yuub6mRv3WfByyvtmB6/OXqho2OecJ+I8DHAXCKC/Logo9z+0IBCF9i1yhfZp5
         ZZjUazxvAc08cIOTD9CpjvFVsyq76ISoBP7xYoNWMy7ZlRLzmZous/QFn6hSSmuZMXll
         FzLNNV7XNBlLOzFWfLkypbgs8/43UA/LG8MW928UxKJIfGjtGTyNsOaOALkzXMxSthdg
         qotg==
X-Forwarded-Encrypted: i=1; AKwUvBw8yXiwzgQDHVsaqeJNuV5qbiy97syWXSjJmQepPptavcMmTISWALUR3Ujl88vZGnZAWQlXsaMdVx+c@vger.kernel.org
X-Gm-Message-State: AFuF++lIOIBRDzNRC+wP0gDqAhlSGGVLzybjQokY7uScpLNWc3tmLoSi
	T+zQ3k9EoJ0yrMylc1Mol1x3VLLiL8w+5qQyWJe4S7ApP/ByeO24Z0m72zDsFTle3jPEq4N27Rb
	H1IZWAxRkPwxqluxACwuBTCK/1Lyyj84=
X-Gm-Gg: AYBFou1fiYWkzGsh15AtspUekNc46CKvG9glAzdRijAF39Ojuxe/OktsIatWi+DNfBP
	4TsymUslWcJFgqnuhn9alA4n7N6we06wkiFzIimCNEdP1JCnfeoQVM9hSvgwwwAX3OTucL56De3
	gvx6cTdq492aFXT0dxrl49J05xI17iWrmeaxDU+lcaSAzGZHtgKAcCjskgZce1qAMdEXTDwkxNE
	qZxFI/uBkf1iAG+JqXnT2UgRls/VFz5I2f2/tRqqsh0WGz1etoQQBGkYqRmpSqJHhq6yOzOJtRT
	ztKit7Po3sOz3+hTDgDuziSeOorDigcyDUWNEWhzgxfJkXmakQHy38jCG8cMH0OyD4Ut6Oto+vZ
	jopecchfwYzZrZm/U0A9EvfBI6DF4d5Xp5OCgo2k2QjPemFw7n0z1ZSVYYH4kGbvCVE7enIhm7u
	q1TPa2x+oSU9jeI3HLVht4tpw=
X-Received: by 2002:a05:690c:c622:b0:86f:6c64:7eb7 with SMTP id
 00721157ae682-87122599769mr119770507b3.1.1788971705167; Wed, 09 Sep 2026
 09:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904195132.141068-3-sidchintamaneni@gmail.com> <4866144aa416a8491c9874325394e88f5dc2e66259212baa56032e0428f0772b@mail.kernel.org>
In-Reply-To: <4866144aa416a8491c9874325394e88f5dc2e66259212baa56032e0428f0772b@mail.kernel.org>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Wed, 9 Sep 2026 09:34:53 -0700
X-Gm-Features: AcwNN1WCeNCqyff3VAuQjYBnYtHIwccOam8Qp1LEGjFOZzxZQ1VjRoRu1i5QAcI
Message-ID: <CAE5sdEhdsPvK8UD-SEZ=YNX5_GpHkUV8mivRW1j=6hJ6XkM7Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/7] bpf, x86: Use resolved pointer for timed may_goto
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, jeremy.jean@oss.cyber.gouv.fr, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, a.s.protopopov@gmail.com, puranjay@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-riscv@lists.infradead.org, rlmenge@gmail.com, 
	hargar@linux.microsoft.com, apais@microsoft.com, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sept 2026 at 13:33, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/arch/x86/net/bpf_timed_may_goto.S b/arch/x86/net/bpf_timed_may_goto.S
> > index 54c690cae190..6e9d9e7c2b1d 100644
> > --- a/arch/x86/net/bpf_timed_may_goto.S
> > +++ b/arch/x86/net/bpf_timed_may_goto.S
> > @@ -11,12 +11,6 @@
> >  SYM_FUNC_START(arch_bpf_timed_may_goto)
> >       ANNOTATE_NOENDBR
> >
> > -     /*
> > -      * r10 passes us stack depth, load the pointer to count and timestamp
> > -      * into r10 by adding it to BPF frame pointer.
> > -      */
> > -     leaq (%rbp, %r10, 1), %r10
> > -
>
> A subsystem pattern flags this as potentially concerning: This commit
> changes the x86 trampoline to the new 'pointer in BPF_REG_AX' ABI, but the
> producer side of that ABI was changed one commit earlier, in d8319a04dafc
> ("bpf: Fix timed may_goto stack pointer for private stacks"), which
> rewrote kernel/bpf/fixups.c to emit:
>
>     insn_buf[4] = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_FP);
>     insn_buf[5] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, stack_off_cnt);
>
> At commit d8319a04dafc (i.e. HEAD~1), does x86 still execute
> 'leaq (%rbp, %r10, 1), %r10' on a register that already holds a resolved
> pointer, producing r10 = rbp + (frame_ptr + stack_off_cnt) -- roughly
> 2*rbp, a non-canonical address?
>
> bpf_check_timed_may_goto() then reads and writes p->timestamp / p->count
> through it (kernel/bpf/core.c:3410). Would any BPF program containing
> may_goto oops on x86_64 at that commit?
>
> The same window exists for arm64, riscv, powerpc64 and s390, whose
> trampolines are only converted in the four later commits d35642770d98,
> 7053db7d3c0d, 6e03227c5677 and 20356163d51e. Is the tree bisectable across
> the series?
>
> The two halves carry different Fixes: tags (this one 2fb761823ead, the
> fixups.c one e723608bf428), which invites a partial stable backport that
> reintroduces exactly this wild-pointer write. Would squashing the fixups.c
> ABI change with the arch trampoline updates, or ordering all arch updates
> before the generic change, address the bisectability concern?
>
> >       /* Setup frame. */
> >       pushq %rbp
> >       movq %rsp, %rbp
>

I tried to follow the same pattern used when the patches were
introduced, but this is a valid concern.
Should I just squash all the patches to one then?

> The x86-only __xlated expectations for the timed may_goto expansion in
> tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c were never
> updated for the new 7-insn -> 8-insn sequence. The test expects:
>
>     __xlated("7: if r12 == 0x0 goto pc+6")
>     __xlated("8: r12 -= 1")
>     __xlated("9: if r12 != 0x0 goto pc+2")
>     __xlated("10: r12 = -24")
>     __xlated("11: call unknown")
>     __xlated("12: *(u64 *)(r10 -24) = r12")
>

I've fixed this in the selftests patch.

> Does this test fail on x86_64 for the whole series? Every line from index
> 7 onward is now wrong: the first branch becomes 'goto pc+7' (insn->off + 6
> instead of insn->off + 5), the second becomes 'goto pc+3' instead of
> 'pc+2', 'r12 = -24' is replaced by the pair 'r12 = r10' / 'r12 += -24',
> and the trailing indices shift by one ('call unknown' at 12, the store at
> 13, then 14 and 15).
>
> git log 28bd77eb835b..8dc5c7d5340d shows the only selftest commit in the
> series is 8dc5c7d5340d ("selftests/bpf: Test timed may_goto with private
> stacks"), which adds new coverage but does not touch
> verifier_bpf_fastcall.c. Note the original x86 JIT enablement commit
> 2fb761823ead -- the commit this patch lists in its Fixes: tag -- adjusted
> this very test for the same reason, so the update belongs with the ABI
> change.
>
> > commit 28bd77eb835bc1a95190315e93afbc6bb186b9ff
> > Author: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> >
> >     bpf, x86: Use resolved pointer for timed may_goto
> >
> >     The timed may_goto fixup now passes the resolved counter pointer through
> >     BPF_REG_AX instead of a stack offset.
> >
> >     Use the pointer directly rather than adding it to RBP. This preserves the
> >     private-stack address selected by the JIT through R9.
> >
> >     Fixes: 2fb761823ead ("bpf, x86: Add x86 JIT support for timed may_goto")
>                  ^^^^^^^^^^^
>
> The existing Fixes: tag points to commit 2fb761823ead, which is not an
> ancestor of this fix and is on a different branch (bpf-next/res_spin_lock).
>

I'll fix this in the next iteration

> The bug was actually introduced by commit 47ab38f3f4d9 in this branch's
> history, which added the incorrect code 'leaq (%rbp, %r10, 1), %r10' that
> overwrites r10 instead of preserving it.
>
> Should this use:
>
>   Fixes: 47ab38f3f4d9 ("adding ci files")
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33914557238
