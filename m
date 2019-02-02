Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 2 Feb 2019 12:20:06 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
References: <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de>
 <20190130233557.GA4240@linux.ibm.com>
 <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de>
 <20190131165228.GA32680@osiris>
 <20190131170653.spnrxsiblkssleyd@linutronix.de>
 <20190201161227.GG3770@osiris>
 <alpine.DEB.2.21.1902012258290.8200@nanos.tec.linutronix.de>
 <20190202091043.GA3381@osiris>
 <alpine.DEB.2.21.1902021027060.8200@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902021027060.8200@nanos.tec.linutronix.de>
Message-Id: <20190202112006.GB3381@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Feb 02, 2019 at 11:14:27AM +0100, Thomas Gleixner wrote:
> On Sat, 2 Feb 2019, Heiko Carstens wrote:
> So after the unlock @timestamp 337.215675 the kernel does not deal with
> that futex at all until the failed lock attempt where it rightfully rejects
> the attempt due to the alleged owner being gone.
> 
> So this looks more like user space doing something stupid...
> 
> As we talked about the missing barriers before, I just looked at
> pthread_mutex_trylock() and that does still:
> 
> 	if (robust)
>           {
>             ENQUEUE_MUTEX_PI (mutex);
>             THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
>           }
> 
> So it's missing the barriers which pthread_mutex_lock() has. Grasping for
> straws obviously....

Excellent! Taking a look into the disassembly of nptl/pthread_mutex_trylock.o
reveals this part:

140:   a5 1b 00 01             oill    %r1,1
144:   e5 48 a0 f0 00 00       mvghi   240(%r10),0   <--- THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
14a:   e3 10 a0 e0 00 24       stg     %r1,224(%r10) <--- last THREAD_SETMEM of ENQUEUE_MUTEX_PI

I added a barrier between those two and now the code looks like this:

140:   a5 1b 00 01             oill    %r1,1
144:   e3 10 a0 e0 00 24       stg     %r1,224(%r10)
14a:   e5 48 a0 f0 00 00       mvghi   240(%r10),0

Looks like this was a one instruction race...

I'll try to reproduce with the patch below (sprinkling compiler
barriers just like the other files have).

diff --git a/nptl/pthread_mutex_trylock.c b/nptl/pthread_mutex_trylock.c
index 7de61f4f68..3b093cb09c 100644
--- a/nptl/pthread_mutex_trylock.c
+++ b/nptl/pthread_mutex_trylock.c
@@ -116,8 +116,12 @@ __pthread_mutex_trylock (pthread_mutex_t *mutex)
 	      mutex->__data.__count = 1;
 	      /* But it is inconsistent unless marked otherwise.  */
 	      mutex->__data.__owner = PTHREAD_MUTEX_INCONSISTENT;
-
+	      /* We must not enqueue the mutex before we have acquired it.
+		 Also see comments at ENQUEUE_MUTEX.  */
+	      __asm ("" ::: "memory");
 	      ENQUEUE_MUTEX (mutex);
+	      /* We need to clear op_pending after we enqueue the mutex.  */
+	      __asm ("" ::: "memory");
 	      THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
 
 	      /* Note that we deliberately exist here.  If we fall
@@ -177,7 +181,12 @@ __pthread_mutex_trylock (pthread_mutex_t *mutex)
 	}
       while ((oldval & FUTEX_OWNER_DIED) != 0);
 
+      /* We must not enqueue the mutex before we have acquired it.
+         Also see comments at ENQUEUE_MUTEX.  */
+      __asm ("" ::: "memory");
       ENQUEUE_MUTEX (mutex);
+      /* We need to clear op_pending after we enqueue the mutex.  */
+      __asm ("" ::: "memory");
       THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
 
       mutex->__data.__owner = id;
@@ -279,7 +288,11 @@ __pthread_mutex_trylock (pthread_mutex_t *mutex)
 	    /* But it is inconsistent unless marked otherwise.  */
 	    mutex->__data.__owner = PTHREAD_MUTEX_INCONSISTENT;
 
+	    /* We must not enqueue the mutex before we have acquired it.
+	       Also see comments at ENQUEUE_MUTEX.  */
+	    __asm ("" ::: "memory");
 	    ENQUEUE_MUTEX (mutex);
+	    __asm ("" ::: "memory");
 	    THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
 
 	    /* Note that we deliberately exit here.  If we fall
@@ -308,7 +321,12 @@ __pthread_mutex_trylock (pthread_mutex_t *mutex)
 
 	if (robust)
 	  {
+	    /* We must not enqueue the mutex before we have acquired it.
+	       Also see comments at ENQUEUE_MUTEX.  */
+	    __asm ("" ::: "memory");
 	    ENQUEUE_MUTEX_PI (mutex);
+	    /* We need to clear op_pending after we enqueue the mutex.  */
+	    __asm ("" ::: "memory");
 	    THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
 	  }
 
