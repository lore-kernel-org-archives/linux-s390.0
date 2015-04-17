Return-Path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150413210035.099736663@linutronix.de>
References: <20150413210009.682000343@linutronix.de> <20150413210035.099736663@linutronix.de>
Subject: Re: [patch 2/5] s390: crypto: Protect poll timeout update
Message-ID: <OFC24DF575.5AA2422C-ONC1257E2A.00498846-C1257E2A.0054E893@de.ibm.com>
From: Ingo Tuchscherer <ingo.tuchscherer@de.ibm.com>
Date: Fri, 17 Apr 2015 15:27:26 +0200
MIME-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=4EBBF4B9DFDA0ED68f9e8a93df938690918c4EBBF4B9DFDA0ED6"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

--0__=4EBBF4B9DFDA0ED68f9e8a93df938690918c4EBBF4B9DFDA0ED6
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: quoted-printable


You're right. Thanks for pointing this out.
I'll fix these issues and bring them upstream.

Mit freundlichen Gr=FC=DFen / Kind regards

Ingo Tuchscherer

Software Development - Linux on z Systems
IBM Systems &Technology Group
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
 Phone:            +49-7031-16-1986                 IBM Deutschland    =
                      (Embedded 
                                                                       =
                    image moved 
                                                                       =
                       to file: 
                                                                       =
                  pic14137.gif) 
                                                                       =
                                
 E-Mail:           ingo.tuchscherer@de.ibm.com      Schoenaicher Str. 2=
20                              
                                                                       =
                                
                                                    71032 Boeblingen   =
                                
                                                                       =
                                
                                                    Germany            =
                                
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
 IBM Deutschland                                                       =
                                
 Research &                                                            =
                                
 Development                                                           =
                                
 GmbH /                                                                =
                                
 Vorsitzender des                                                      =
                                
 Aufsichtsrats:                                                        =
                                
 Martina Koederitz                                                     =
                                
                                                                       =
                                
 Gesch=E4ftsf=FChrung:                                                 =
                                    
 Dirk Wittkopp                                                         =
                                
 Sitz der                                                              =
                                
 Gesellschaft:                                                         =
                                
 B=F6blingen /                                                         =
                                  
 Registergericht:                                                      =
                                
 Amtsgericht                                                           =
                                
 Stuttgart, HRB                                                        =
                                
 243294                                                                =
                                
                                                                       =
                                





From:	Thomas Gleixner <tglx@linutronix.de>
To:	LKML <linux-kernel@vger.kernel.org>
Cc:	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
            <mingo@kernel.org>, Ingo Tuchscherer/Germany/IBM@IBMDE,
            mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com,
            linux-s390@vger.kernel.org
Date:	04/13/2015 11:02 PM
Subject:	[patch 2/5] s390: crypto: Protect poll timeout update



The poll timeout update via sysfs runs completely unprotected against
other usage sites of the timer. Take the proper lock before fiddling
with the timer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Tuchscherer <ingo.tuchscherer@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---

P.S: I have serious doubts about the following snippets in that code:

@@ -1174,11 +1174,13 @@ static ssize_t poll_timeout_store(struct
       poll_timeout =3D time;
       hr_time =3D ktime_set(0, poll_timeout);

       spin_lock_bh(&ap_poll_timer_lock);
       if (!hrtimer_is_queued(&ap_poll_timer) ||
-->        !hrtimer_forward(&ap_poll_timer, hrtimer_get_expires
(&ap_poll_timer), hr_time)) {

Why does it check, whether the forwarding resulted in an overrun?

If the timer is not queued, then it is either expired or has never
been started. So if the poll timeout gets written, then the timer is
started when

		 timer->expires + hr_time < now

This results in random behaviour at best.

                hrtimer_set_expires(&ap_poll_timer, hr_time);
                hrtimer_start_expires(&ap_poll_timer, HRTIMER_MODE_ABS)=
;
        }
@@ -1552,11 +1553,16 @@ static inline void __ap_schedule_poll_timeout
       spin_lock_bh(&ap_poll_timer_lock);
       if (hrtimer_is_queued(&ap_poll_timer) || ap_suspend_flag)
                goto out;
--->   if (ktime_to_ns(hrtimer_expires_remaining(&ap_poll_timer)) <=3D =
0) {

The check above does not make any sense either. Again, if the timer is
not queued then it is either expired or was never started. As the
timer is never canceled except on module unload the condition is
always true.

               hr_time =3D ktime_set(0, poll_timeout);
               hrtimer_forward_now(&ap_poll_timer, hr_time);
               hrtimer_restart(&ap_poll_timer);
       }

But that's not scope of that patch and I leave this to the s390
wizards to digest.

---

 drivers/s390/crypto/ap_bus.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux/drivers/s390/crypto/ap_bus.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/s390/crypto/ap_bus.c
+++ linux/drivers/s390/crypto/ap_bus.c
@@ -1174,11 +1174,13 @@ static ssize_t poll_timeout_store(struct
 		 poll_timeout =3D time;
 		 hr_time =3D ktime_set(0, poll_timeout);

+		 spin_lock_bh(&ap_poll_timer_lock);
 		 if (!hrtimer_is_queued(&ap_poll_timer) ||
 		     !hrtimer_forward(&ap_poll_timer, hrtimer_get_expires
(&ap_poll_timer), hr_time)) {
 		 		 hrtimer_set_expires(&ap_poll_timer, hr_time);
 		 		 hrtimer_start_expires(&ap_poll_timer,
HRTIMER_MODE_ABS);
 		 }
+		 spin_unlock_bh(&ap_poll_timer_lock);
 		 return count;
 }



=

--0__=4EBBF4B9DFDA0ED68f9e8a93df938690918c4EBBF4B9DFDA0ED6
Content-type: image/gif;
	name="pic14137.gif"
Content-Disposition: attachment; filename="pic14137.gif"
Content-transfer-encoding: base64

R0lGODlhVwAeAPcAAAAAAIAAAACAAICAAAAAgIAAgACAgMDAwMDcwKbK8ER3u8bGxv///wAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAP/78KCgpICAgP8AAAD/AP//AAAA//8A/wD//////yH5BAAAAAAALAAAAABXAB4A
hwAAAIAAAACAAICAAAAAgIAAgACAgMDAwMDcwKbK8ER3u8bGxv///wAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/7
8KCgpICAgP8AAAD/AP//AAAA//8A/wD//////wj+ABcoGEiwYMEFDAQaXGhwAUIGEBMyLBixIsSJ
By1qVIiRIEKOHRc+hAiS4ciKJU1qXMmypcuXMGPKnEmzps2bLlNO/Biy40OdBlf2VHByJVCREoeq
TOrT4tGMOKNKnUq1qtWrDBjmDIoSacWOFpve1NqypNOFGsUyXYq1rdu3cOO2JMvyKdq0Te0WnUnX
qFKiQkUebOhVruHDiBPD7Lvx796sDddmLFyT8dm/gaFOvBhZsefPoN9a7kqRdOmvnVNGpExzdESz
pj2G7QxZNmeooXPr3o1aAUmlPP/ePToSZG+2F1dLxhhcuG3ivU+qzZpVIHXecH0PTI5dNHXtdmUZ
h9/5mnnXotOvUx8PmP3Bk9C/4iU/2zeDgAA7

--0__=4EBBF4B9DFDA0ED68f9e8a93df938690918c4EBBF4B9DFDA0ED6--
