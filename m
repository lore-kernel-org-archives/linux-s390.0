Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 24 Oct 2018 13:34:25 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()
Message-ID: <20181024043425.GA8862@jagdpanzerIV>
References: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On (10/24/18 13:30), Sergey Senozhatsky wrote:
> -		 * OK, the message is on the console.  Now we call printk()
> -		 * without oops_in_progress set so that printk will give klogd
> -		 * a poke.  Hold onto your hats...
> -		 */
> -		console_loglevel = 15;
> -		printk(" ");
>  		console_loglevel = loglevel_save;
> +
> +		oops_in_progress = 0;
> +		wake_up_klogd();

D'oh... Fat fingers!
I noticed that I have removed "console_loglevel = 15".
Sorry about that.

====

From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()

printk() without oops_in_progress set is potentially dangerous.
it will attempt to call into console driver, so if oops happened
while console driver port->lock spin_lock was locked on the same
CPU (NMI oops or oops from console driver), then re-entering
console driver from bust_spinlocks() will deadlock the system.

Some serial drivers have are re-entrant from oops path:

static void serial_console_write(struct console *co, const char *s,
                                 unsigned count)
{
...
        if (port->sysrq)
                locked = 0;
        else if (oops_in_progress)
                locked = spin_trylock_irqsave(&port->lock, flags);
        else
                spin_lock_irqsave(&port->lock, flags);
...

        uart_console_write(port, s, count, serial_console_putchar);
...
        if (locked)
                spin_unlock_irqrestore(&port->lock, flags);
}

So it's OK to call printk() or console_unblank() and re-enter
serial console drivers when oops_in_progress set. But once we
clear oops_in_progress serial consoles become non-reentrant.

From the comment it seems that s390 wants to just poke klogd.
There is wake_up_klogd() for this purpose, so we can replace
that printk(" ").

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/s390/mm/fault.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2b8f32f56e0c..53915c61ad95 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -92,16 +92,12 @@ void bust_spinlocks(int yes)
 		oops_in_progress = 1;
 	} else {
 		int loglevel_save = console_loglevel;
-		console_unblank();
-		oops_in_progress = 0;
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk will give klogd
-		 * a poke.  Hold onto your hats...
-		 */
+
 		console_loglevel = 15;
-		printk(" ");
+		console_unblank();
 		console_loglevel = loglevel_save;
+		oops_in_progress = 0;
+		wake_up_klogd();
 	}
 }
 
-- 
2.19.1
