Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 May 2016 15:54:28 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH] x86: fix potential memleak in do_error_trap
Message-ID: <20160523135428.GU2278@dhcp22.suse.cz>
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

And here is the x86 one. I haven't found others so far but I haven't
checked other architectures and I might have missed some callpaths for
x86 as well. Also please note this hasn't been tested properly and
it is based on the code reading.
---
From fa8e84058c243f81a49c847624daaf935efdeb5a Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Mon, 23 May 2016 15:47:28 +0200
Subject: [PATCH] x86: fix potential memleak in do_error_trap

do_error_trap defines on stack siginfo structure which is then sent down
to do_trap -> force_sig_info without initializing it. __send_signal ->
copy_siginfo will copy the content for later use when the signal is
dequeued. This information might later leak into userspace. Fix it by
clearing the whole siginfo in do_error_trap before sending it to
do_trap.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/x86/kernel/traps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d1590486204a..945b4dfc02e6 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -271,6 +271,7 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
 
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
 			NOTIFY_STOP) {
+		memset(&info, 0, sizeof(info));
 		cond_local_irq_enable(regs);
 		do_trap(trapnr, signr, str, regs, error_code,
 			fill_trap_info(regs, signr, trapnr, &info));
-- 
2.8.1

-- 
Michal Hocko
SUSE Labs
