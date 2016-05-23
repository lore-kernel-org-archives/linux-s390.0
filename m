Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 May 2016 15:43:20 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH] s390: fix info leak in do_sigsegv
Message-ID: <20160523134318.GT2278@dhcp22.suse.cz>
References: <20160523111630.GN2278@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160523111630.GN2278@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <asarai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

OK, Martin would prefer a simple patch so here we go.
---
From de1ad037f3181e795ef0e66a61b8fbe1157f66cc Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Mon, 23 May 2016 15:35:51 +0200
Subject: [PATCH] s390: fix info leak in do_sigsegv

Aleksa has reported incorrect si_errno value when stracing task which
received SIGSEGV:
[pid 20799] --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_errno=2510266, si_addr=0x100000000000000}

The reason seems to be that do_sigsegv is not initializing siginfo
structure defined on the stack completely so it will leak 4B of
the previous stack content. Fix it simply by initializing si_errno
to 0 (same as do_sigbus does already).

Cc: stable # introduced pre-git times
Reported-by: Aleksa Sarai <asarai@suse.de>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/s390/mm/fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 7a3144017301..19288c1b36d3 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -250,6 +250,7 @@ static noinline void do_sigsegv(struct pt_regs *regs, int si_code)
 
 	report_user_fault(regs, SIGSEGV, 1);
 	si.si_signo = SIGSEGV;
+	si.si_errno = 0;
 	si.si_code = si_code;
 	si.si_addr = (void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK);
 	force_sig_info(SIGSEGV, &si, current);
-- 
2.8.1

-- 
Michal Hocko
SUSE Labs
