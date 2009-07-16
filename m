From: Christian =?iso-8859-1?q?Borntr=E4ger?= <borntraeger@de.ibm.com>
Subject: [PATCH] kvm-390: fix wait_queue handling
Date: Thu, 16 Jul 2009 17:17:37 +0200
Message-ID: <200907161717.38035.borntraeger@de.ibm.com>
References: <Pine.LNX.4.64.0907101344350.9598@ask.diku.dk> <4A599D51.8030506@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4A599D51.8030506@redhat.com>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Julia Lawall <julia@diku.dk>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

There are two waitqueues in kvm for wait handling:
vcpu->wq for virt/kvm/kvm_main.c and
vpcu->arch.local_int.wq for the s390 specific wait code.

the wait handling in kvm_s390_handle_wait was broken by using different
wait_queues for add_wait queue and remove_wait_queue.

There are two options to fix the problem: 
o  move all the s390 specific code to vcpu->wq and remove
   vcpu->arch.local_int.wq
o  move all the s390 specific code to vcpu->arch.local_int.wq

This patch chooses the 2nd variant for two reasons:
o  s390 does not use kvm_vcpu_block but implements its own enabled wait
   handling.
   Having a separate wait_queue make it clear, that our wait mechanism is
   different
o  the patch is much smaller

Report-by:  Julia Lawall <julia@diku.dk>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: kvm/arch/s390/kvm/interrupt.c
===================================================================
--- kvm.orig/arch/s390/kvm/interrupt.c
+++ kvm/arch/s390/kvm/interrupt.c
@@ -386,7 +386,7 @@ no_timer:
 	}
 	__unset_cpu_idle(vcpu);
 	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&vcpu->wq, &wait);
+	remove_wait_queue(&vcpu->arch.local_int.wq, &wait);
 	spin_unlock_bh(&vcpu->arch.local_int.lock);
 	spin_unlock(&vcpu->arch.local_int.float_int->lock);
 	hrtimer_try_to_cancel(&vcpu->arch.ckc_timer);
