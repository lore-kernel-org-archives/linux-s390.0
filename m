Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 29 Jan 2019 11:35:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
Message-ID: <20190129103557.GF28485@hirez.programming.kicks-ass.net>
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190128134410.GA28485@hirez.programming.kicks-ass.net>
 <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
 <20190129090108.GA26906@osiris>
 <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de>
 <20190129102409.GB26906@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129102409.GB26906@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>, Sebastian Sewior <bigeasy@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 29, 2019 at 11:24:09AM +0100, Heiko Carstens wrote:

> Yes, sure. However ;) I reproduced the above with v5.0-rc4 + your
> patch. And now I am trying to reproduce with linux-next 20190129 +
> your patch and it doesn't trigger. Did I miss a patch which is only in
> linux-next which could fix this?
> 

I'm forever confused on what patch is where; but -ESRCH makes me thing
maybe you lost this one:

---

commit da791a667536bf8322042e38ca85d55a78d3c273
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Mon Dec 10 14:35:14 2018 +0100

    futex: Cure exit race
    
    Stefan reported, that the glibc tst-robustpi4 test case fails
    occasionally. That case creates the following race between
    sys_exit() and sys_futex_lock_pi():
    
     CPU0                           CPU1
    
     sys_exit()                     sys_futex()
      do_exit()                      futex_lock_pi()
       exit_signals(tsk)              No waiters:
        tsk->flags |= PF_EXITING;     *uaddr == 0x00000PID
      mm_release(tsk)                 Set waiter bit
       exit_robust_list(tsk) {        *uaddr = 0x80000PID;
          Set owner died              attach_to_pi_owner() {
        *uaddr = 0xC0000000;           tsk = get_task(PID);
       }                               if (!tsk->flags & PF_EXITING) {
      ...                                attach();
      tsk->flags |= PF_EXITPIDONE;     } else {
                                         if (!(tsk->flags & PF_EXITPIDONE))
                                           return -EAGAIN;
                                         return -ESRCH; <--- FAIL
                                       }
    
    ESRCH is returned all the way to user space, which triggers the glibc test
    case assert. Returning ESRCH unconditionally is wrong here because the user
    space value has been changed by the exiting task to 0xC0000000, i.e. the
    FUTEX_OWNER_DIED bit is set and the futex PID value has been cleared. This
    is a valid state and the kernel has to handle it, i.e. taking the futex.
    
    Cure it by rereading the user space value when PF_EXITING and PF_EXITPIDONE
    is set in the task which 'owns' the futex. If the value has changed, let
    the kernel retry the operation, which includes all regular sanity checks
    and correctly handles the FUTEX_OWNER_DIED case.
    
    If it hasn't changed, then return ESRCH as there is no way to distinguish
    this case from malfunctioning user space. This happens when the exiting
    task did not have a robust list, the robust list was corrupted or the user
    space value in the futex was simply bogus.
    
    Reported-by: Stefan Liebler <stli@linux.ibm.com>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Acked-by: Peter Zijlstra <peterz@infradead.org>
    Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
    Cc: Darren Hart <dvhart@infradead.org>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Sasha Levin <sashal@kernel.org>
    Cc: stable@vger.kernel.org
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=200467
    Link: https://lkml.kernel.org/r/20181210152311.986181245@linutronix.de

diff --git a/kernel/futex.c b/kernel/futex.c
index f423f9b6577e..5cc8083a4c89 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1148,11 +1148,65 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
 	return ret;
 }
 
+static int handle_exit_race(u32 __user *uaddr, u32 uval,
+			    struct task_struct *tsk)
+{
+	u32 uval2;
+
+	/*
+	 * If PF_EXITPIDONE is not yet set, then try again.
+	 */
+	if (tsk && !(tsk->flags & PF_EXITPIDONE))
+		return -EAGAIN;
+
+	/*
+	 * Reread the user space value to handle the following situation:
+	 *
+	 * CPU0				CPU1
+	 *
+	 * sys_exit()			sys_futex()
+	 *  do_exit()			 futex_lock_pi()
+	 *                                futex_lock_pi_atomic()
+	 *   exit_signals(tsk)		    No waiters:
+	 *    tsk->flags |= PF_EXITING;	    *uaddr == 0x00000PID
+	 *  mm_release(tsk)		    Set waiter bit
+	 *   exit_robust_list(tsk) {	    *uaddr = 0x80000PID;
+	 *      Set owner died		    attach_to_pi_owner() {
+	 *    *uaddr = 0xC0000000;	     tsk = get_task(PID);
+	 *   }				     if (!tsk->flags & PF_EXITING) {
+	 *  ...				       attach();
+	 *  tsk->flags |= PF_EXITPIDONE;     } else {
+	 *				       if (!(tsk->flags & PF_EXITPIDONE))
+	 *				         return -EAGAIN;
+	 *				       return -ESRCH; <--- FAIL
+	 *				     }
+	 *
+	 * Returning ESRCH unconditionally is wrong here because the
+	 * user space value has been changed by the exiting task.
+	 *
+	 * The same logic applies to the case where the exiting task is
+	 * already gone.
+	 */
+	if (get_futex_value_locked(&uval2, uaddr))
+		return -EFAULT;
+
+	/* If the user space value has changed, try again. */
+	if (uval2 != uval)
+		return -EAGAIN;
+
+	/*
+	 * The exiting task did not have a robust list, the robust list was
+	 * corrupted or the user space value in *uaddr is simply bogus.
+	 * Give up and tell user space.
+	 */
+	return -ESRCH;
+}
+
 /*
  * Lookup the task for the TID provided from user space and attach to
  * it after doing proper sanity checks.
  */
-static int attach_to_pi_owner(u32 uval, union futex_key *key,
+static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 			      struct futex_pi_state **ps)
 {
 	pid_t pid = uval & FUTEX_TID_MASK;
@@ -1162,12 +1216,15 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 	/*
 	 * We are the first waiter - try to look up the real owner and attach
 	 * the new pi_state to it, but bail out when TID = 0 [1]
+	 *
+	 * The !pid check is paranoid. None of the call sites should end up
+	 * with pid == 0, but better safe than sorry. Let the caller retry
 	 */
 	if (!pid)
-		return -ESRCH;
+		return -EAGAIN;
 	p = find_get_task_by_vpid(pid);
 	if (!p)
-		return -ESRCH;
+		return handle_exit_race(uaddr, uval, NULL);
 
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		put_task_struct(p);
@@ -1187,7 +1244,7 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 		 * set, we know that the task has finished the
 		 * cleanup:
 		 */
-		int ret = (p->flags & PF_EXITPIDONE) ? -ESRCH : -EAGAIN;
+		int ret = handle_exit_race(uaddr, uval, p);
 
 		raw_spin_unlock_irq(&p->pi_lock);
 		put_task_struct(p);
@@ -1244,7 +1301,7 @@ static int lookup_pi_state(u32 __user *uaddr, u32 uval,
 	 * We are the first waiter - try to look up the owner based on
 	 * @uval and attach to it.
 	 */
-	return attach_to_pi_owner(uval, key, ps);
+	return attach_to_pi_owner(uaddr, uval, key, ps);
 }
 
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
@@ -1352,7 +1409,7 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 	 * attach to the owner. If that fails, no harm done, we only
 	 * set the FUTEX_WAITERS bit in the user space variable.
 	 */
-	return attach_to_pi_owner(uval, key, ps);
+	return attach_to_pi_owner(uaddr, newval, key, ps);
 }
 
 /**
