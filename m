Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C31AC43219
	for <linux-s390@archiver.kernel.org>; Fri,  7 Oct 2022 15:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJGPmu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiJGPms (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Oct 2022 11:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E2FD73DC
        for <linux-s390@vger.kernel.org>; Fri,  7 Oct 2022 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665157365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1lKCnBjxRPjgpNNPlEylbLIMLTQ3r/0aTk3SgXwAPQE=;
        b=D3fMXMR78n4xee4LUX7DvwAr8+9TnmZSGvDyqx41pUtbdb94MgLwZsyyqLBiaqDidCrGAq
        4DC77GsjTuvFetCeuxk48O0HLhBM+O/nwCKQJXf9fLNw9uILTAXnjwcRFqqRrRf7L0BAmZ
        FhgjivLTmKlwC+EKcl7LwocodkpdEWI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-JnINyWdiNOSd6uiFrzyG6g-1; Fri, 07 Oct 2022 11:42:44 -0400
X-MC-Unique: JnINyWdiNOSd6uiFrzyG6g-1
Received: by mail-wm1-f72.google.com with SMTP id v191-20020a1cacc8000000b003bdf7b78dccso2848859wme.3
        for <linux-s390@vger.kernel.org>; Fri, 07 Oct 2022 08:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lKCnBjxRPjgpNNPlEylbLIMLTQ3r/0aTk3SgXwAPQE=;
        b=dj3grjJ+lJhDCMxHmy/2IhjR+8alfQYbqvl+0kmmGUjQZwq+/RnelSnYrnzRfwIMkA
         ND8sb1c0WiIfsQf8qozui+mVPM06PBUdDVQ4fBZmB2qWDXEMWY7JNsPWsccBFKDFVeQG
         fOYfhXw7YOl47gnRkxAV8xNiLqXqNkqXIITmwAHipb5NfXwIXIw3SEFcrLltfXMeuyPT
         Q4lXOidAAxiVpE8JTwhyvbsNhtbmGG+ZpMzKHaKoHtH61zbjuPVVLzZq9w2JjYxRnPOP
         0kU8uNoLGt/TBDlik31DMYnGcKKLxgroA1dTYmhslaFHNJwWe95py8oTY0nFqANnVx2T
         buZQ==
X-Gm-Message-State: ACrzQf09ZVawSZzdqoSInNX1VVNmHLzEhLkKkhbFzqmHsZlwfqn0Xypz
        U9VVQ1vpYoND9DcMjrIBa9JLdRb6/vXYRuaULarA9HmGoIc3I6j/wmJTPLygtOH2YwzRnEz0kNq
        fvkYyGk0FobwYCyQmI1ziYg==
X-Received: by 2002:a5d:5010:0:b0:22a:cb71:9493 with SMTP id e16-20020a5d5010000000b0022acb719493mr3770648wrt.514.1665157361752;
        Fri, 07 Oct 2022 08:42:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Tr05uM1rtU5aj/QWiT6cTirx56otcH3SojWjYuAUChmPHRHcJ6HatWEhyYipO7y3unWYaxQ==
X-Received: by 2002:a5d:5010:0:b0:22a:cb71:9493 with SMTP id e16-20020a5d5010000000b0022acb719493mr3770632wrt.514.1665157361532;
        Fri, 07 Oct 2022 08:42:41 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b0022af865810esm2307021wri.75.2022.10.07.08.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 08:42:40 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH 0/5] Generic IPI sending tracepoint
Date:   Fri,  7 Oct 2022 16:41:40 +0100
Message-Id: <20221007154145.1877054-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Background
==========

Detecting IPI *reception* is relatively easy, e.g. using
trace_irq_handler_{entry,exit} or even just function-trace
flush_smp_call_function_queue() for SMP calls.  

Figuring out their *origin*, is trickier as there is no generic tracepoint tied
to e.g. smp_call_function():

o AFAIA x86 has no tracepoint tied to sending IPIs, only receiving them
  (cf. trace_call_function{_single}_entry()).
o arm/arm64 do have trace_ipi_raise(), which gives us the target cpus but also a
  mostly useless string (smp_calls will all be "Function call interrupts").
o Other architectures don't seem to have any IPI-sending related tracepoint.  

I believe one reason those tracepoints used by arm/arm64 ended up as they were
is because these archs used to handle IPIs differently from regular interrupts
(the IRQ driver would directly invoke an IPI-handling routine), which meant they 
never showed up in trace_irq_handler_{entry, exit}. The trace_ipi_{entry,exit}
tracepoints gave a way to trace IPI reception but those have become redundant as
of: 

      56afcd3dbd19 ("ARM: Allow IPIs to be handled as normal interrupts")
      d3afc7f12987 ("arm64: Allow IPIs to be handled as normal interrupts")

which gave IPIs a "proper" handler function used through
generic_handle_domain_irq(), which makes them show up via
trace_irq_handler_{entry, exit}.

Changing stuff up
=================

Per the above, it would make sense to reshuffle trace_ipi_raise() and move it
into generic code. This also came up during Daniel's talk on Osnoise at the CPU
isolation MC of LPC 2022 [1]. 

Now, to be useful, such a tracepoint needs to export:
o targeted CPU(s)
o calling context

The only way to get the calling context with trace_ipi_raise() is to trigger a
stack dump, e.g. $(trace-cmd -e ipi* -T echo 42).

As for the targeted CPUs, the existing tracepoint does export them, albeit in
cpumask form, which is quite inconvenient from a tooling perspective. For
instance, as far as I'm aware, it's not possible to do event filtering on a
cpumask via trace-cmd.

Because of the above points, this is introducing a new tracepoint.

Patches
=======

This results in having trace events for:

o smp_call_function*()
o smp_send_reschedule()
o irq_work_queue*()

This is incomplete, just looking at arm64 there's more IPI types that aren't covered:

  IPI_CPU_STOP,
  IPI_CPU_CRASH_STOP,
  IPI_TIMER,
  IPI_WAKEUP,

... But it feels like a good starting point.

Another thing worth mentioning is that depending on the callsite, the _RET_IP_
fed to the tracepoint is not always useful - generic_exec_single() doesn't tell
you much about the actual callback being sent via IPI, so there might be value
in exploding the single tracepoint into at least one variant for smp_calls.

Links
=====

[1]: https://youtu.be/5gT57y4OzBM?t=14234

Valentin Schneider (5):
  trace: Add trace_ipi_send_{cpu, cpumask}
  sched, smp: Trace send_call_function_single_ipi()
  smp: Add a multi-CPU variant to send_call_function_single_ipi()
  irq_work: Trace calls to arch_irq_work_raise()
  treewide: Rename and trace arch-definitions of smp_send_reschedule()

 arch/alpha/kernel/smp.c          |  2 +-
 arch/arc/kernel/smp.c            |  2 +-
 arch/arm/kernel/smp.c            |  5 +----
 arch/arm64/kernel/smp.c          |  3 +--
 arch/csky/kernel/smp.c           |  2 +-
 arch/hexagon/kernel/smp.c        |  2 +-
 arch/ia64/kernel/smp.c           |  4 ++--
 arch/loongarch/include/asm/smp.h |  2 +-
 arch/mips/include/asm/smp.h      |  2 +-
 arch/openrisc/kernel/smp.c       |  2 +-
 arch/parisc/kernel/smp.c         |  4 ++--
 arch/powerpc/kernel/smp.c        |  4 ++--
 arch/riscv/kernel/smp.c          |  4 ++--
 arch/s390/kernel/smp.c           |  2 +-
 arch/sh/kernel/smp.c             |  2 +-
 arch/sparc/kernel/smp_32.c       |  2 +-
 arch/sparc/kernel/smp_64.c       |  2 +-
 arch/x86/include/asm/smp.h       |  2 +-
 arch/xtensa/kernel/smp.c         |  2 +-
 include/linux/smp.h              |  1 +
 include/trace/events/ipi.h       | 27 +++++++++++++++++++++++++++
 kernel/irq_work.c                | 12 +++++++++++-
 kernel/sched/core.c              |  7 +++++--
 kernel/smp.c                     | 18 +++++++++++++++++-
 24 files changed, 84 insertions(+), 31 deletions(-)

--
2.31.1

