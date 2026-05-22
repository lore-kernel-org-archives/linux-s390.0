Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD02F28E3
	for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474796; cv=none; b=NGo1EuiIruZVeP3L/VTPbFP5EYMPMAfP9Np+aLd3S6MRPnWiOeYLp2VAnpY6JMISJOAV+rj6eLlK34rJpjAz4DoP4LV6sgkUIck26BCSS6GsDiUoVeIrStqfWWil1liRIOnlS2EsQpZ9qtuA6mKjkb5jAqXb5XHalgbNMPzIHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474796; c=relaxed/simple;
	bh=xJTj8jJ+4X0OyW/OuYW/Q/xkFPDEpvLsamdMWd3ywiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cW713y5d6nidWSp6FJV543nhNRzbgyctYfHtMjhnaalhZk7yNfzN/1oAsMl5eK958vZtc0LAXac8fcgksH4KJxVOGRcquRcYrhEISDPVfqLcfvTGARsE1yhHAqDlXJAbqnKOkuGG0wGmYI75ZZktJWgiTYEG3Utr0++whciJBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRYZMec5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRYZMec5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso55500995e9.2
        for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474792; x=1780079592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQlIvI9YRBN1pTgWxGebVFlvg9D4sotQmqZzbJzrIag=;
        b=ZRYZMec5UXKlY61aDiCE+QwBu0cryKNCJ3XPZ6vc5n+lSSVeHtffPb01LZF5o5wF3p
         MpfFXgMahvozM4W/LfQrvaw55lLz1whoax53/GlQy4IfoyJlZG4YQnBkLKjyQAX0cwXb
         kpYuLJ2VvlvnbOL38iN1+U8vRXtFMR7hfyn/OEHkrIGMoO9VQ/Xx0BX0sq8fJ5YoJJRL
         o0W7XAOdVEMNKq5v3jmEpi6PZKKN/Cb29FSObmndrHQcwZJMbSAfk8UD9OqZF+nEnesf
         J5mfho19rt61juhl4582/RBwFpalhoWM3p1noNd4TWgnJCKmifv60te/pD1wYLqLGZVx
         pS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474792; x=1780079592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fQlIvI9YRBN1pTgWxGebVFlvg9D4sotQmqZzbJzrIag=;
        b=P4iFd9dKuEEELDvuXfRVUWTAVsIo4EdtLMKl5+jaXSHcLjPwWgEm3jQWlzr+YsOi66
         c4NUKHzAPdepAl4zsLjrneOXpdF7jIUqcemrTslEwgVVFySraew9y44u0BvZETCN3zsv
         43IFD0AFxK61IIpzDJa4xYAN0nrtcIPG1rc7vO0cosYn2OzmbbfpRgj2USXVgt6q34us
         lCg2d9EpHRb2fxyIi+IPQV0W7S7tILGYpOU/6LRc7zYREOYQ8pEHgnukv0MHXrwfCqA0
         0U7O08Xb093sgbY9saWjtYb0GDJJBCg/wVyr6tjZnwBXHrEe7p0RZaJtZ4uV3ixjZPgF
         gwTg==
X-Forwarded-Encrypted: i=1; AFNElJ+WbRzQwR3lR67zCoakf1Z8REIMxIK0BzFNgCXF3ppex+IDDYPwY7WX1CtD4KEHXy7uxXRMHATLOdTA@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7yoKBPG0QMlz5mRsRJYHFF3dxqC1MErD2L2RZXh5yMYV/nMY
	QOWtxmrsROFqlX9u2v9biSC1Giv/Eung0jhlxFzMekzf3OdMlYkcGhgL
X-Gm-Gg: Acq92OEAcMeS0JLksJrhYfTOpbHUyd2g4/FKfWGG+j6oEgIwgZpOYPhzN6xq/1VfF5W
	/1T6HaGmVqllrp2cY4g/K/zQEkjP2PlXWACrPx6qlLjTXx8XXgQjLq6JjoScoMDGhSA/TEu5Wne
	LXDULTt6N/98khMqApYhCH9Xl1Hp/sPktlGwC13Y2tFvFfSLxWeoSJ9UN0jbdlyQxhdatuusENb
	StXWCvGSGzWmsMU4vWldju8juTr+rmWfpQlEmL/Y0RiWXAD6tlPsqjjmHMgGiyB7pCYJ9JmZy+v
	fz5I7OGrlEZNg6c8QWcZQA6CkSZ6fW18RabRTKDkLnIeXqrnoPq9pbF7fKHHfotj8CKXmvNot/Z
	s6Lv2SdtEidzYURxA0qe8x5lQ5gqemKvgCcxBpKmPaUTizUgAILYisDbivWLqk19v1ajv0mVupm
	AHuW7i8nh4nsUcOW6n2A/3bBfr/oJpMW1fT00tIHEN86aRs6gO70P/IEW71wIt/Im4A1YGNF9Ag
	Ao=
X-Received: by 2002:a05:600c:c4a1:b0:490:3fd9:e78b with SMTP id 5b1f17b1804b1-490426cef8bmr67453415e9.17.1779474792023;
        Fri, 22 May 2026 11:33:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454dedd9sm51299635e9.6.2026.05.22.11.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:33:11 -0700 (PDT)
Date: Fri, 22 May 2026 19:33:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Juergen Christ
 <jchrist@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Yang Shi
 <yang@os.amperecomputing.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 0/8] s390: Improve this_cpu operations
Message-ID: <20260522193304.72f226ab@pumpkin>
In-Reply-To: <20260522141257.303617-1-hca@linux.ibm.com>
References: <20260522141257.303617-1-hca@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 16:12:49 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> v4:
> 
> - Drop alternatives approach and extract percpu base register number for
>   mviy at compile time [David Laight]

Definitely looks better.
I'm sure I managed to understand it once :-)

-- David

> 
> - Fix logic for percpu code section detection, as well as
>   interruption/exception/nmi path [Sashiko [5]]
> 
> [5] https://sashiko.dev/#/patchset/20260520092243.264847-1-hca%40linux.ibm.com
> 
> v3:
> 
> - Fix various typos [Juergen Christ]
> 
> - Add missing kprobe detection / handling [Sashiko [3]]
>   [FWIW, this made me also aware of that the current general s390 kprobes
>    code seems to be racy against concurrent removal of a kprobe while a
>    probe hit on a different CPU. But that is a different story.]
> 
> - Fix various minor findings [Sashiko [3]]
> 
> - All of this might be dropped / exchanged in future in favor of the percpu
>   page table approach proposed by Yang Shi [4].
> 
> [3] https://sashiko.dev/#/patchset/20260319120503.4046659-1-hca@linux.ibm.com
> [4] https://lore.kernel.org/all/20260429170758.3018959-1-yang@os.amperecomputing.com/
> 
> v2:
> 
> - Add proper PERCPU_PTR cast to most patches to avoid tons of sparse
>   warnings
> 
> - Add missing __packed attribute to insn structure [Sashiko [2]]
> 
> - Fix inverted if condition [Sashiko [2]]
> 
> - Add missing user_mode() check [Sashiko [2]]
> 
> - Move percpu_entry() call in front of irqentry_enter() call in all
>   entry paths to avoid that potential this_cpu() operations overwrite
>   the not-yet saved percpu code section indicator  [Sashiko [2]]
> 
> [2] https://sashiko.dev/#/patchset/20260317195436.2276810-1-hca%40linux.ibm.com
> 
> v1:
> 
> This is a follow-up to Peter Zijlstra's in-kernel rseq RFC [1].
> 
> With the intended removal of PREEMPT_NONE this_cpu operations based on
> atomic instructions, guarded with preempt_disable()/preempt_enable() pairs,
> become more expensive: the preempt_disable() / preempt_enable() pairs are
> not optimized away anymore during compile time.
> 
> In particular the conditional call to preempt_schedule_notrace() after
> preempt_enable() adds additional code and register pressure.
> 
> To avoid this Peter suggested an in-kernel rseq approach. While this would
> certainly work, this series tries to come up with a solution which uses
> less instructions and doesn't require to repeat instruction sequences.
> 
> The idea is that this_cpu operations based on atomic instructions are
> guarded with mvyi instructions:
> 
> - The first mvyi instruction writes the register number, which contains
>   the percpu address variable to lowcore. This also indicates that a
>   percpu code section is executed.
> 
> - The first instruction following the mvyi instruction must be the ag
>   instruction which adds the percpu offset to the percpu address register.
> 
> - Afterwards the atomic percpu operation follows.
> 
> - Then a second mvyi instruction writes a zero to lowcore, which indicates
>   the end of the percpu code section.
> 
> - In case of an interrupt/exception/nmi the register number which was
>   written to lowcore is copied to the exception frame (pt_regs), and a zero
>   is written to lowcore.
> 
> - On return to the previous context it is checked if a percpu code section
>   was executed (saved register number not zero), and if the process was
>   migrated to a different cpu. If the percpu offset was already added to
>   the percpu address register (instruction address does _not_ point to the
>   ag instruction) the content of the percpu address register is adjusted so
>   it points to percpu variable of the new cpu.
> 
> All of this seems to work, but of course it could still be broken since I
> missed some detail.
> 
> In total this series results in a kernel text size reduction of ~106kb. The
> number of preempt_schedule_notrace() call sites is reduced from 7089 to
> 1577.
> 
> Note: this comes without any huge performance analysis, however all
> microbenchmarks confirmed that the new code is at least as fast as the
> old code, like expected.
> 
> [1] 20260223163843.GR1282955@noisy.programming.kicks-ass.net
> 
> Heiko Carstens (8):
>   s390/percpu: Infrastructure for more efficient this_cpu operations
>   s390/percpu: Add missing do { } while (0) constructs
>   s390/percpu: Use new percpu code section for arch_this_cpu_add()
>   s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
>   s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
>   s390/percpu: Provide arch_this_cpu_read() implementation
>   s390/percpu: Provide arch_this_cpu_write() implementation
>   s390/percpu: Remove one and two byte this_cpu operation implementation
> 
>  arch/s390/include/asm/entry-percpu.h |  78 ++++++++
>  arch/s390/include/asm/lowcore.h      |   3 +-
>  arch/s390/include/asm/percpu.h       | 257 +++++++++++++++++++++------
>  arch/s390/include/asm/ptrace.h       |   2 +
>  arch/s390/kernel/irq.c               |  24 ++-
>  arch/s390/kernel/nmi.c               |   5 +
>  arch/s390/kernel/traps.c             |   5 +
>  7 files changed, 315 insertions(+), 59 deletions(-)
>  create mode 100644 arch/s390/include/asm/entry-percpu.h
> 

