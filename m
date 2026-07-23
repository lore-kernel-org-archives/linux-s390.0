Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6435D5E2
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794597; cv=pass; b=HGMH7uqsjyOn7Fq6YNjOuxKPZWkdEPkGYFly3hXCmgb+TycmN9IF5IRBnjXsL0cVGfPSpoVs1l6zGOY+pe77yxVDxPBDONFBuHsJ3mNkHHywUrXk63fptqL9HKL2+ggyHhYOx0g5WkazNZdS/nNt1EPOV5rU7OkoTta2mgUT4ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794597; c=relaxed/simple;
	bh=VT4MWQfU9hCucpc7cWdAlF6H9kZnwG+Gwdmmhdc0Ick=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aKWjJxY/UktdTs99mEgqmeXCVO+T3pCE/PbjOMEzFy1Gh+VL1vAMgtjMKCOam+8Ds/8VgOmB/awhLOhdINAVHR0VYGCApnl6A69MSpLYW0e1oV3TC+7KFityB7SDMtnBEZYeZ7jJOxtlBvY5UtKOITto2ajr88oENv+5D530NYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hudrlQZc; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hudrlQZc"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceed7018c8so2834965ad.1
        for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 01:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784794595; cv=none;
        d=google.com; s=arc-20260327;
        b=W7Wme8dq/9gG+C2Fv7a6xnbuGWnqC4nV7ppLOstB65bKkLhOQ+1svJzERN4rpYHZrH
         LETADdZ6kqshl8XPAuUSLWqGVln3+7nPRQXyVLBBT8ZWcqUJoxXDU8x6cZ24br1Z5j5a
         qX1J3Q8kTYsXaJADKgC22QpSs+zCBIj+LGpq2qEyL8jNUbcIp4SStxmO7JmGT6JMOWxP
         2mlTJDFJzs5026vZ1PlsLL9lzTjM8BZTifS9Mp2px8jq01VB3a6l7UKZY/RfeuzpSC2e
         xcLQFfQI9S+aEVcX44T29PtJwrb6Ij/yJjy84EkZkW2DFMs3bjttTrdM+m6MOWnWJpEu
         +QtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Wo+Vi5K3kSEn+1EpaozgmT/8tPtVROlmrkhTXMeQFAc=;
        fh=CRHHD80oVnjcDZFTcSoJQpKGLy2XkLs/ettkyiP+yEg=;
        b=FWqLOb69RZkyipK9fzUlvc75CL7CikQzoPt7IsLOGXs1cqrPvMjspjgPikbH3/ujF9
         7zdRs2l80p7Nl7vEnJKZD/K3TbCqH8iAVYQKBw867Ndew/VO7YC06Yy3uKMO9deouldB
         8/0nTr0XbrrLJcUS2lKPeDzIra2lbNjSIVVQe4sr3LhviZ388QfaW7yt+J6mWXCjpKsz
         Tv4+oidkRmvfHAoa7TBZnSNAT2r/fvK+g99/XA4uEJ3mw2QjRzZE2jtOjr9Enb7mp23E
         laQ7n70VkU5jk7BK/BlrvZYUibsjF9boqbia26W0D94+NmdIJJdYrOmfPpa6psY6Vsc5
         pn3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784794595; x=1785399395; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wo+Vi5K3kSEn+1EpaozgmT/8tPtVROlmrkhTXMeQFAc=;
        b=hudrlQZcCfRhc5K4qAFHCbIVX7cW5ty3gcBIAsEBvX7xZW9m1rYktX3y9d5B/gJpPA
         f1ylWa4AZP9KS9fxgHoLuYqWD7SUaUMhPywCieWIQgCqFcM1sh36MQnMIh+aHNx20HgI
         IsAWksYkAaPqykD065zA+yweUQi2MboCUi65DOm+Alf8x7V+RZOZAWCGKShM40Q7QZGh
         yzlqeagc6o2aUZxb8YGhoDJ+t4AkNZ/phjcQOfRVyQwy8HsF3oALRwPgmyYVPqPhtuUJ
         kRJifVVw9v136OiwbMPNLdxQAcx5/5CNmriTNTa5eaG0/FnCj2KYnfRJ3HD/CJZKP96P
         rMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784794595; x=1785399395;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wo+Vi5K3kSEn+1EpaozgmT/8tPtVROlmrkhTXMeQFAc=;
        b=sXqSRwTMcRWxAsxKHQKGX6pnfVi/xUYQpp+z2u3kuflGupiGPSiY8Y4A4hyGJJeA20
         TNg+taI8edP6ETWYw41v9awC7lRkEukI+44YWPg9Bqm6pa5jFDI+wdMmxOW/tzdyQ3KD
         h65UOr5IQM4UBHovtxtBK0FZef6sxQhz1Adkbf6C+DWb532ANwW3Ym7ji3c/9ShTzN7+
         zDFb+NNGgMJT2vc18MfbntBnitDigB22nPfQS4gaBWbGKPsb9kMwMSWwsQYfxR9xEeWW
         RruFfUFWlg7AathDSW8K8TJ7wVUMBaHOVq8TxfHJqbludBHCVFauHFVD3BnIDw7uzD1r
         WMmw==
X-Forwarded-Encrypted: i=1; AHgh+RoUpxQQCqfKfxoz62UVW63oHwXF0bJ57YM+zlLaIKMZrHA2nodkpQ6Wk2h8CprCxNESku0QZehmFzgT@vger.kernel.org
X-Gm-Message-State: AOJu0YzG4tLq4uFGxzk5nIZZtxYKFYi3PUMZo60jAPW6URsXJv1QMUYY
	A+6qVkKC0d//LfHiP+gw4NhA8IGiNq3rrb2BI5m2TJuOA+wITjw0H8wGCBjg4Pna8uunYVOKLkK
	ia/4vwzZuxyDTp07GpGgKuIg8mK5x8bnX5eBdF0c=
X-Gm-Gg: AR+sD10erws5RS26vwGOhV41NBp0c8/lcscTEBipHmo+WuRyxtVQz98fiz6vovYcGy9
	rxZYVIHodYSf/OvkeGibzYhuimT/pjdqOna18KpH2LrLbjk+rpab76Lg1e5RhtMKgXkNgwN8hS0
	vDahFH33e9S7qp0MgOPmgVKJbCBwgK8W8dFovStFfCsyrgpvxVB2cOVCT3v7wrU7UzYRUcneVi3
	l2mB6ZTNnbXNbHCJEmps/M5A+KvvntvjkNDFoJOU3dTOd4DSYH0IMwApn4emx64
X-Received: by 2002:a05:6a21:608a:b0:3bf:9b61:f7ae with SMTP id
 adf61e73a8af0-3c44afcf8a6mr2128914637.14.1784794595473; Thu, 23 Jul 2026
 01:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Min-gyu Kim <gimm78064@gmail.com>
Date: Thu, 23 Jul 2026 17:16:23 +0900
X-Gm-Features: AUfX_myL9bF7X6cpM8-4rFrG6l6JryBzW6Ow15hH2749EXFeM9RDeP9w91553Hg
Message-ID: <CAGKGUv=sOuqQtA1Ub-5JXfA4FPosJFYKAQE4B79cK+P1erxqtg@mail.gmail.com>
Subject: [RESEND][REGRESSION][SECURITY] bpf, s390: verifier/JIT mismatch
 allows unprivileged kernel memory access
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a potential security regression involving eBPF verifier state
pruning and the s390x JIT. I reproduced arbitrary kernel read and write access
and local privilege escalation as an unprivileged user.

AI assistance was used during discovery and analysis. In accordance with the
kernel security-bug reporting guidance, I am not requesting an embargo. The
reproducer and exploit are not attached or published; I can provide them
privately to maintainers on request.

Summary and affected versions

A verifier regression can cause the verifier and the s390x JIT to disagree
about the upper 32 bits of scalar registers. A crafted socket-filter program
can consequently form an unchecked 64-bit offset from an ARRAY map-value
pointer and access attacker-selected kernel addresses.

The regression was introduced by:

  107e169799057bc6a379ddb625cbe1e51cfc7d72
  ("bpf: disable and remove registers chain based liveness")

The commit first appears in v6.18-rc1 and is not present in v6.17. The cause
was still present in the v6.18, v6.19, v7.0, and v7.1 stable branches and in
v7.2-rc4, bpf, and bpf-next when checked by source comparison on 2026-07-22.
I also confirmed the relevant logic in mainline commit
4539944e515183668109bdf4d0c3d7d228383d88 on 2026-07-23. Dynamic
reproduction was performed on v6.18.38.

Affected code:

  kernel/bpf/verifier.c
  kernel/bpf/states.c in current development trees
  arch/s390/net/bpf_jit_comp.c

Required conditions:

  Architecture:                        64-bit s390x
  Program type:                        BPF_PROG_TYPE_SOCKET_FILTER
  Map type:                            BPF_MAP_TYPE_ARRAY
  CONFIG_BPF_SYSCALL:                  enabled
  BPF JIT:                             enabled and active
  kernel.unprivileged_bpf_disabled:    0
  Required capabilities:               none
  User namespace:                      not required

Root cause

The verifier records an ALU32 definition in subreg_def. A later 64-bit read
causes mark_insn_zext() to mark that instruction for explicit zero extension.
Before 107e16979905, a cache hit in is_state_visited() propagated the 64-bit
read to the alternate path's ALU32 definition.

Commit 107e16979905 removed that propagation when register-chain liveness was
replaced with static liveness. The static live-register mask does not track
read width or path-specific subreg_def information. In current states.c,
regs_exact() compares only fields before id, while subreg_def follows id in
struct bpf_reg_state. The SCALAR_VALUE case in regsafe() also does not compare
subreg_def. States with equal tracked scalar values but different ALU32
definitions can therefore compare as equal, leaving the pruned path's ALU32
instruction without a zero-extension mark.

On s390, ALU32 ADD updates the low 32 bits while preserving the register's
high half. EMIT_ZERO() emits llgfr only when the program-wide verifier_zext
flag is clear. If another ALU32 definition is marked, verifier_zext is set and
the JIT relies on each instruction's zext_dst flag. The pruned instruction
lacks that flag and can execute with attacker-controlled high bits intact.

Reproduction and impact

I ran the test as uid 1000 with all capability sets empty:

  Linux syzkaller 6.18.38 s390x
  kernel.unprivileged_bpf_disabled = 0
  net.core.bpf_jit_enable = 1

The exploit disclosed array_map_ops through the existing map->ops pointer,
derived the KASLR slide, and obtained arbitrary kernel read and write
primitives. It used those primitives to locate and modify the calling
process's credentials. map->ops was read only and was not overwritten.

The resulting shell reported:

  uid=0(root) gid=0(root) groups=0(root),27(sudo),100(users),1000(poc)
  context=system_u:system_r:kernel_t:s0

A standalone C reproducer and exploit, verifier log, kernel configuration,
and build details are available privately on request.

Mitigation and fix direction

Setting kernel.unprivileged_bpf_disabled to a non-zero value prevents this
attack by unprivileged users. Disabling the s390 BPF JIT also prevents the
demonstrated mismatch.

I have not yet tested a patch. A conservative verifier fix may be to avoid
pruning live scalar states whose relevant subreg_def values differ, or to
preserve the read-width information needed to mark the current path's ALU32
instruction. As defense in depth, the s390 JIT could avoid relying only on
the program-wide verifier_zext flag. I can prepare a regression test and test
proposed changes in the s390x QEMU environment used for reproduction.

References

  Regression-introducing commit:
  https://github.com/torvalds/linux/commit/107e169799057bc6a379ddb625cbe1e51cfc7d72

  Public review discussion related to read width and zero extension:
  https://www.spinics.net/lists/bpf/msg139280.html

  Merged patch discussion:
  https://www.spinics.net/lists/bpf/msg152234.html

If appropriate, I would appreciate a Reported-by tag as:

  Min-gyu Kim <gimm78064@gmail.com>

Please let me know if you need additional information or would like the
private reproducer and exploit.

Thank you for your time.

Best regards,
Min-gyu Kim
