Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D51684BE
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316454; cv=none; b=cJ7CDEAFVeIBVO0ME0rh7XTkOKK9/thAe4Dn9T5oZqD3OGC3ZyjKSWJaMDIoBVUTR4/xofqbgWmaBlPVTGWGv4G9YHTFwsIqJibl0jM818bMmBwGihCHGt0x2v4qNxIWP3ZHb/jAA7kzsenayQN7HJsZb/4l8FKMzoedafQ2L3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316454; c=relaxed/simple;
	bh=btRW1JdjcPDe4i+35hwqVjBxo048mdoq8DhdXxEbcL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGr0QyBGIyctPctZiZsW+rLU9/UH2EVcu8/TWCMD7YQUfycnaxSztliSxsH57a68Mfmv9b8eFqrYXezayZXcGFR2hV1RBhF6Ue8cLYfO67miSEnxzsrKfdYDWFP9n9Q2wXvI2XhuMD+vtSybnn+pihkN2ytUtZC4YWVfA6skWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHOkoWIF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHOkoWIF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48909558b3aso56152415e9.0
        for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779316451; x=1779921251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjRGxqRtt8MP9Bs7zaGqTQmaFwBTdBUCVOG4VUHTA50=;
        b=jHOkoWIF4nLjlDk44jpE3+dp+YRYta9YUuafuDaz0hW9Oxb5sbCynGPKQgSk27erGE
         i5ewjLAIQrCHCvNXT4AW3+2yXjkwZZJNiPGLRR8GlalN3Ag9Pq1yY/XsdyVKD4iGsWuW
         dUzQxms8rdJ4zPdYkf3Gxh3kQUIRcHB1YQ/kH3EiEQikLBMlOx1xgJ8RMAF4ZeogZgiw
         2PokzeBly3THeB6U/PoWnP8B0cfiHp2yjAAQYC3Mj2aOQAmBhIee0IiOLqvRWgILWMpG
         j5cIcJUggvAV0iV6Z/pjBJQr70TXTsONLNeueY52BPxrElagKVM35XYNbnHGDaZqHhWy
         wJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779316451; x=1779921251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wjRGxqRtt8MP9Bs7zaGqTQmaFwBTdBUCVOG4VUHTA50=;
        b=ZqrG0bGR6D1u9eRuWGYOURwQCwPz5n08Pj3i2rWqYyCZoJ8Rv6Xsv9G02IdvSfZROB
         LD1QujsxM/pTFw4q0EHzfBzlPdynutPEaapq/4pWQG56DnQmcgNPPeZ/jczZau8b16n6
         IcydS7QX7DBe2iPDMrZclHbkR/QALcYgLwEEj22qMUaSlmpWWgmPMBHenQlUnb92/VaU
         OyRGiI5/q0J3zU0VppiuN+zfgekCehAHqh4AZV3Slr9NC/Gulkeehr9gxYMfFquJyfUI
         c3P6h68GfGXYBoA4Mjq/Qtyis3gSkE7S4GGN9xN4Pk982rn9XkDJySkCnRjKhGARxmn2
         PgKA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ieu4jSW9VJJQOfdDb1aO2T7qaZRNvRvzm2bdwrreqVRXtQaeanSOPNP8QaLRzR5pKQAo9FB6swevO@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6p3MGfxGiRWkJiiRESDvNfWv8gmuyCqoc/lqMEwqvbWfrFIR
	l5lGT6raeaJ78QRWEK6arqBip/hVk+/VhTMXJqKQYtjMck41kbWNHMWA
X-Gm-Gg: Acq92OHgegLePrWwiMBdexyJ9y8jnxuhs1+TzckykfnBigxOIClfOxxHBP9iSXgDZLw
	9BzEJwc1wH788A9aGk+FaL1/7FXGbRtLGUBGa68iUh9QgokUsuSyW9LWCro9oJJ0E5HDv/eLqIu
	H7HFCBcAC9kSp5PuvneFW93M0Mu0X4vQPz/0oaPv7483++wdCohp5YuTlJf9bEN3D573FvuyEIx
	8SCtiQQFqtT5yaBazyFo6xJVWOG30C1BEgp07Y59zIt7E9pZiQ9Mt0hzpiVq1Nzni0uJCiI2Lbc
	wTzibtXEo6t8r+BYfjQar6ld9bMIG1+zKk+BMv2xkCQxghIVV+D+nW/DiKintkG11GY69F3cw+P
	5RVH4w+iXDCJkpcGeVSOx2vK5B3D3yXcBiCw8Qv9j3D3jluxzoCVuUw5JCjmv/B3fvPhOW9taMV
	gVlj0CgT3FpslDT1m1Pwsxn8jzs18p5nvozDnsA/2e1WhKqxCsoa9TpS4zy0II6cfialeHzEVgg
	t6dQcmK5j5D3g==
X-Received: by 2002:a05:600c:1909:b0:490:778:4fe7 with SMTP id 5b1f17b1804b1-4903607857dmr3625665e9.23.1779316450721;
        Wed, 20 May 2026 15:34:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d9ee3bsm21108285e9.14.2026.05.20.15.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:34:10 -0700 (PDT)
Date: Wed, 20 May 2026 23:34:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Juergen Christ <jchrist@linux.ibm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Peter Zijlstra
 <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
Message-ID: <20260520233409.0683f595@pumpkin>
In-Reply-To: <9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
	<9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 11:42:36 -0700
Yang Shi <yang@os.amperecomputing.com> wrote:

> Hi Heiko,
> 
> Thanks for cc'ing me the patchset. Please see the below inline comments.
> 
> 
> On 5/20/26 2:22 AM, Heiko Carstens wrote:
> > v3:
> > - Fix various typos [Juergen Christ]
> >
> > - Add missing kprobe detection / handling [Sashiko [3]]
> >    [FWIW, this made me also aware of that the current general s390 kprobes
> >     code seems to be racy against concurrent removal of a kprobe while a
> >     probe hit on a different CPU. But that is a different story.]
> >
> > - Fix various minor findings [Sashiko [3]]
> >
> > - All of this might be dropped / exchanged in future in favor of the percpu
> >    page table approach proposed by Yang Shi [4].  
> 
> Thanks for mentioning my approach. I will do some comparison with rseq 
> in the following design details section of the cover letter.
> 
> >
> > [3] https://sashiko.dev/#/patchset/20260319120503.4046659-1-hca@linux.ibm.com
> > [4] https://lore.kernel.org/all/20260429170758.3018959-1-yang@os.amperecomputing.com/
> >
> > v2:
> >
> > - Add proper PERCPU_PTR cast to most patches to avoid tons of sparse
> >    warnings
> >
> > - Add missing __packed attribute to insn structure [Sashiko [2]]
> >
> > - Fix inverted if condition [Sashiko [2]]
> >
> > - Add missing user_mode() check [Sashiko [2]]
> >
> > - Move percpu_entry() call in front of irqentry_enter() call in all
> >    entry paths to avoid that potential this_cpu() operations overwrite
> >    the not-yet saved percpu code section indicator  [Sashiko [2]]
> >
> > [2] https://sashiko.dev/#/patchset/20260317195436.2276810-1-hca%40linux.ibm.com
> >
> > v1:
> >
> > This is a follow-up to Peter Zijlstra's in-kernel rseq RFC [1].
> >
> > With the intended removal of PREEMPT_NONE this_cpu operations based on
> > atomic instructions, guarded with preempt_disable()/preempt_enable() pairs,
> > become more expensive: the preempt_disable() / preempt_enable() pairs are
> > not optimized away anymore during compile time.
> >
> > In particular the conditional call to preempt_schedule_notrace() after
> > preempt_enable() adds additional code and register pressure.
> >
> > To avoid this Peter suggested an in-kernel rseq approach. While this would
> > certainly work, this series tries to come up with a solution which uses
> > less instructions and doesn't require to repeat instruction sequences.
> >
> > The idea is that this_cpu operations based on atomic instructions are
> > guarded with mvyi instructions:
> >
> > - The first mvyi instruction writes the register number, which contains
> >    the percpu address variable to lowcore. This also indicates that a
> >    percpu code section is executed.
> >
> > - The first instruction following the mvyi instruction must be the ag
> >    instruction which adds the percpu offset to the percpu address register.
> >
> > - Afterwards the atomic percpu operation follows.
> >
> > - Then a second mvyi instruction writes a zero to lowcore, which indicates
> >    the end of the percpu code section.
> >
> > - In case of an interrupt/exception/nmi the register number which was
> >    written to lowcore is copied to the exception frame (pt_regs), and a zero
> >    is written to lowcore.
> >
> > - On return to the previous context it is checked if a percpu code section
> >    was executed (saved register number not zero), and if the process was
> >    migrated to a different cpu. If the percpu offset was already added to
> >    the percpu address register (instruction address does _not_ point to the
> >    ag instruction) the content of the percpu address register is adjusted so
> >    it points to percpu variable of the new cpu.  
> 
> If I understand correctly, you replaced preempt_disable() and 
> preempt_enable() with seq begin and seg end, and seq begin and seq end 
> can be optimized by mvyi instruction on S390. So you just need a single 
> mvyi instruction for each instead of read-modify-write the seq count.
> 
> But you need some extra overhead for context switch (save and restore 
> the seq count register) and need to check whether it is still on the 
> same cpu once resuming execution. And there is also penalty if it is 
> migrated to another CPU (need to rerun this_cpu ops).

Not as I understand it.
What happens is the context switch code 'corrupts' the register being
used to access per-cpu data so that it is correct for the new cpu.
The write of zero after the sequence is there to stop the register
being corrupted outside of this code window.

This really just means that you can (mostly) only do single accesses,
since nothing stops pre-emption between the RW or an RMW sequence.
Although you can probably do an increment of the preempt disable count
because if you are preempted the value read will be zero.

> 
> So it seems have more overhead than the percpu page table approach IIUC. 
> We don't need all the steps with percpu page table. And there is no 
> penalty for migration.

This code looks like it relies on 'page zero' already being percpu.
So it probably isn't really that different.
Some values like the 'preemption disable count' and 'current' could be
(maybe are?) written into page zero to give fast access.

But I'm sure I remember that some cpu don't like having the same
physical address at different virtual addresses (and not just those
with VIVT caches like some sparc cpu).
I'm sure code can end up accessing the current cpu's percpu data
using the same address that other cpu use - there are definitely
places where it needs that address.
On x86-64 that means it reading the address from the array rather
than just offsetting from %gs.

-- David

> 
> >
> > All of this seems to work, but of course it could still be broken since I
> > missed some detail.
> >
> > In total this series results in a kernel text size reduction of ~106kb. The
> > number of preempt_schedule_notrace() call sites is reduced from 7089 to
> > 1577.  
> 
> Yeah, both approaches can reduce the number of 
> preempt_schedule_notrace() call sites. And both approaches can reduce 
> the number of non-preemptible critical sections.
> 
> >
> > Note: this comes without any huge performance analysis, however all
> > microbenchmarks confirmed that the new code is at least as fast as the
> > old code, like expected.  
> 
> I'm really interested in the benchmark number. I'm supposed percpu page 
> table approach should have better performance per my above analysis.
> 
> Christopher Lameter is also interested in it, cc'ed him too.
> 
> Thanks,
> Yang
> 
> >
> > [1] 20260223163843.GR1282955@noisy.programming.kicks-ass.net
> >
> > Heiko Carstens (9):
> >    s390/alternatives: Add new ALT_TYPE_PERCPU type
> >    s390/percpu: Infrastructure for more efficient this_cpu operations
> >    s390/percpu: Add missing do { } while (0) constructs
> >    s390/percpu: Use new percpu code section for arch_this_cpu_add()
> >    s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
> >    s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
> >    s390/percpu: Provide arch_this_cpu_read() implementation
> >    s390/percpu: Provide arch_this_cpu_write() implementation
> >    s390/percpu: Remove one and two byte this_cpu operation implementation
> >
> >   arch/s390/boot/alternative.c         |   7 +
> >   arch/s390/include/asm/alternative.h  |   5 +
> >   arch/s390/include/asm/entry-percpu.h |  76 ++++++++
> >   arch/s390/include/asm/lowcore.h      |   3 +-
> >   arch/s390/include/asm/percpu.h       | 249 +++++++++++++++++++++------
> >   arch/s390/include/asm/ptrace.h       |   2 +
> >   arch/s390/kernel/alternative.c       |  25 ++-
> >   arch/s390/kernel/irq.c               |  26 ++-
> >   arch/s390/kernel/nmi.c               |   6 +
> >   arch/s390/kernel/traps.c             |   6 +
> >   10 files changed, 344 insertions(+), 61 deletions(-)
> >   create mode 100644 arch/s390/include/asm/entry-percpu.h
> >
> > base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8  
> 
> 

