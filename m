Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517DAC4332F
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 17:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDEC6138D
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 17:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhJTRex (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:34:53 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:39418 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJTRew (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 Oct 2021 13:34:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:55338)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFS2-00EuET-9k; Wed, 20 Oct 2021 11:32:30 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47416 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFS0-009qGU-Te; Wed, 20 Oct 2021 11:32:29 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Maciej Rozycki <macro@orcam.me.uk>, linux-mips@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 20 Oct 2021 12:32:20 -0500
Message-ID: <87y26nmwkb.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdFS0-009qGU-Te;;;mid=<87y26nmwkb.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+QTFOF+6WLUwS/6b+bA87HzOEzbRhNKPA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 00/20] exit cleanups 
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


While looking at some issues related to the exit path in the kernel I
found several instances where the code is not using the existing
abstractions properly.

This set of changes introduces force_fatal_sig a way of sending
a signal and not allowing it to be caught, and corrects the
misuse of the existing abstractions that I found.

A lot of the misuse of the existing abstractions are silly things such
as doing something after calling a no return function, rolling BUG by
hand, doing more work than necessary to terminate a kernel thread, or
calling do_exit(SIGKILL) instead of calling force_sig(SIGKILL).

It is my plan after sending all of these changes out for review to place
them in a topic branch for sending Linus.  Especially for the changes
that depend upon the new helper force_fatal_sig this is important.

Eric W. Biederman (20):
      exit/doublefault: Remove apparently bogus comment about rewind_stack_do_exit
      exit: Remove calls of do_exit after noreturn versions of die
      reboot: Remove the unreachable panic after do_exit in reboot(2)
      signal/sparc32: Remove unreachable do_exit in do_sparc_fault
      signal/mips: Update (_save|_restore)_fp_context to fail with -EFAULT
      signal/sh: Use force_sig(SIGKILL) instead of do_group_exit(SIGKILL)
      signal/powerpc: On swapcontext failure force SIGSEGV
      signal/sparc: In setup_tsb_params convert open coded BUG into BUG
      signal/vm86_32: Replace open coded BUG_ON with an actual BUG_ON
      signal/vm86_32: Properly send SIGSEGV when the vm86 state cannot be saved.
      signal/s390: Use force_sigsegv in default_trap_handler
      exit/kthread: Have kernel threads return instead of calling do_exit
      signal: Implement force_fatal_sig
      exit/syscall_user_dispatch: Send ordinary signals on failure
      signal/sparc32: Exit with a fatal signal when try_to_clear_window_buffer fails
      signal/sparc32: In setup_rt_frame and setup_fram use force_fatal_sig
      signal/x86: In emulate_vsyscall force a signal instead of calling do_exit
      exit/rtl8723bs: Replace the macro thread_exit with a simple return 0
      exit/rtl8712: Replace the macro thread_exit with a simple return 0
      exit/r8188eu: Replace the macro thread_exit with a simple return 0

 arch/mips/kernel/r2300_fpu.S                       |  4 ++--
 arch/mips/kernel/syscall.c                         |  9 --------
 arch/nds32/kernel/traps.c                          |  2 +-
 arch/nds32/mm/fault.c                              |  6 +----
 arch/openrisc/kernel/traps.c                       |  2 +-
 arch/openrisc/mm/fault.c                           |  4 +---
 arch/powerpc/kernel/signal_32.c                    |  6 +++--
 arch/powerpc/kernel/signal_64.c                    |  9 +++++---
 arch/s390/include/asm/kdebug.h                     |  2 +-
 arch/s390/kernel/dumpstack.c                       |  2 +-
 arch/s390/kernel/traps.c                           |  2 +-
 arch/s390/mm/fault.c                               |  2 --
 arch/sh/kernel/cpu/fpu.c                           | 10 +++++----
 arch/sh/kernel/traps.c                             |  2 +-
 arch/sh/mm/fault.c                                 |  2 --
 arch/sparc/kernel/signal_32.c                      |  4 ++--
 arch/sparc/kernel/windows.c                        |  6 +++--
 arch/sparc/mm/fault_32.c                           |  1 -
 arch/sparc/mm/tsb.c                                |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c              |  3 ++-
 arch/x86/kernel/doublefault_32.c                   |  3 ---
 arch/x86/kernel/signal.c                           |  6 ++++-
 arch/x86/kernel/vm86_32.c                          |  8 +++----
 arch/xtensa/kernel/traps.c                         |  2 +-
 arch/xtensa/mm/fault.c                             |  3 +--
 drivers/firmware/stratix10-svc.c                   |  4 ++--
 drivers/soc/ti/wkup_m3_ipc.c                       |  2 +-
 drivers/staging/r8188eu/core/rtw_cmd.c             |  2 +-
 drivers/staging/r8188eu/core/rtw_mp.c              |  2 +-
 drivers/staging/r8188eu/include/osdep_service.h    |  2 --
 drivers/staging/rtl8712/osdep_service.h            |  1 -
 drivers/staging/rtl8712/rtl8712_cmd.c              |  2 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |  2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |  2 +-
 .../rtl8723bs/include/osdep_service_linux.h        |  2 --
 fs/ocfs2/journal.c                                 |  5 +----
 include/linux/sched/signal.h                       |  1 +
 kernel/entry/syscall_user_dispatch.c               | 12 ++++++----
 kernel/kthread.c                                   |  2 +-
 kernel/reboot.c                                    |  1 -
 kernel/signal.c                                    | 26 ++++++++++++++--------
 net/batman-adv/tp_meter.c                          |  2 +-
 43 files changed, 83 insertions(+), 91 deletions(-)

Eric
