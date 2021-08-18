Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358C1C19F34
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 00:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD4C61038
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 00:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhHRANC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 17 Aug 2021 20:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbhHRANB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 17 Aug 2021 20:13:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B49C061764
        for <linux-s390@vger.kernel.org>; Tue, 17 Aug 2021 17:12:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f64-20020a2538430000b0290593bfc4b046so966638yba.9
        for <linux-s390@vger.kernel.org>; Tue, 17 Aug 2021 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=0kmO0MXVdRK0WdAgg/6yMEC7RBXf+m4S57NGAaoueXI=;
        b=vajtP/F/au1Tkxc/uMHpx+wr8aY1oET38J2sT1hES8QrTFB2Dr3oDgomOmJ/04aSMX
         lPK1QrJIh+mzpGub10rTCHasL8utUkiKO5AujazcvozxMjzzzWE/06eICjttBqDW3wf+
         L+e0XTHIKQBt1t0atCJyvQw6dljHh7sPVM+lNxiOVyhoa1DzUDDx6dQHJ2ZOrMCmt0xA
         fFbKEG/o6KcSe6yZPj3GRHJnKKFGJyAKq2ptleprShB7iq6yF+/x+neqdnUnQI+JIIMX
         VZ6h4TGr3Gq7pWzwv41cDDYdvfyYVIZwrxDQBv0kJyCpdV4sxAMmf3uwkTGRUUMGsrs7
         dfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=0kmO0MXVdRK0WdAgg/6yMEC7RBXf+m4S57NGAaoueXI=;
        b=FvwLhzOeZ5ZzVsX9OV24gjWVZFgJW2VVqLpbsUFryqAkdqU1QbRRM1T6Cvsv7W18wI
         nvw8VIhyODOYkBEf748JRgzVFWD/+fcuY+LRsdrBTWVQIoKkYFgbktwp5jPaBVhaURMx
         EaOoF4/uKlGc0MTqcCk6mJ66OIZ7fW0/y5j1eJieeNYOwz8abizn1iVioWtstL9viYhI
         NBTsfsF9JQBVPde8IN6exaIEplm416paCHiRvvc5kIq6ztoJakZgJI9fpdE8lGShOgLf
         T+zu8lFEMNXDIh7D877cZshvQ7pTLhJU8CFmC4SW6JGkcwW01BrqLCag/uC9cUCuzlFf
         jTnw==
X-Gm-Message-State: AOAM53275zS3bk19j2l0beKp1FqOSFMwTDN7PWeSPg1Q3i0RZHI7Uv16
        xtAjIVl9uitacG1A/EtEKQDI8dWIEbY=
X-Google-Smtp-Source: ABdhPJwj0XdhQo6iokvEKxnWDKRRiWaTrHjA6QIRd/4VPgyLOcTkIrMPZ6K8bZ+tJ3Cs7VZGVyliISEEGh0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:158e:55a:74dd:5197])
 (user=seanjc job=sendgmr) by 2002:a25:e60a:: with SMTP id d10mr7393693ybh.56.1629245545888;
 Tue, 17 Aug 2021 17:12:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 17 Aug 2021 17:12:06 -0700
In-Reply-To: <20210818001210.4073390-1-seanjc@google.com>
Message-Id: <20210818001210.4073390-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210818001210.4073390-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 1/5] KVM: rseq: Update rseq when processing NOTIFY_RESUME on
 xfer to KVM guest
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Invoke rseq's NOTIFY_RESUME handler when processing the flag prior to
transferring to a KVM guest, which is roughly equivalent to an exit to
userspace and processes many of the same pending actions.  While the task
cannot be in an rseq critical section as the KVM path is reachable only
via ioctl(KVM_RUN), the side effects that apply to rseq outside of a
critical section still apply, e.g. the CPU ID needs to be updated if the
task is migrated.

Clearing TIF_NOTIFY_RESUME without informing rseq can lead to segfaults
and other badness in userspace VMMs that use rseq in combination with KVM,
e.g. due to the CPU ID being stale after task migration.

Fixes: 72c3c0fe54a3 ("x86/kvm: Use generic xfer to guest work function")
Reported-by: Peter Foley <pefoley@google.com>
Bisected-by: Doug Evans <dje@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/entry/kvm.c | 4 +++-
 kernel/rseq.c      | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 49972ee99aff..049fd06b4c3d 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -19,8 +19,10 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 		if (ti_work & _TIF_NEED_RESCHED)
 			schedule();
 
-		if (ti_work & _TIF_NOTIFY_RESUME)
+		if (ti_work & _TIF_NOTIFY_RESUME) {
 			tracehook_notify_resume(NULL);
+			rseq_handle_notify_resume(NULL, NULL);
+		}
 
 		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
 		if (ret)
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 35f7bd0fced0..58c79a7918cd 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -236,7 +236,7 @@ static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
 
 static int rseq_ip_fixup(struct pt_regs *regs)
 {
-	unsigned long ip = instruction_pointer(regs);
+	unsigned long ip = regs ? instruction_pointer(regs) : 0;
 	struct task_struct *t = current;
 	struct rseq_cs rseq_cs;
 	int ret;
@@ -250,7 +250,7 @@ static int rseq_ip_fixup(struct pt_regs *regs)
 	 * If not nested over a rseq critical section, restart is useless.
 	 * Clear the rseq_cs pointer and return.
 	 */
-	if (!in_rseq_cs(ip, &rseq_cs))
+	if (!regs || !in_rseq_cs(ip, &rseq_cs))
 		return clear_rseq_cs(t);
 	ret = rseq_need_restart(t, rseq_cs.flags);
 	if (ret <= 0)
-- 
2.33.0.rc1.237.g0d66db33f3-goog

