From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 15:19:30 +0000
Subject: Re: linux-next: EXP: Fine-grained timer diagnostics breaks cpu hot unplug on s390
Message-Id: <20171010151930.GZ3521@linux.vnet.ibm.com>
In-Reply-To: <20171010061648.GB3613@osiris>
References: <20171010061648.GB3613@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 10, 2017 at 08:16:48AM +0200, Heiko Carstens wrote:
> On Mon, Oct 09, 2017 at 08:46:56AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 09, 2017 at 04:47:08PM +0200, Christian Borntraeger wrote:
> > > PID: 84     TASK: 3305a00           CPU: 2   COMMAND: "sh"
> > >  LOWCORE INFO:
> > >   -psw      : 0x0404c00180000000 0x00000000001163a6
> > >   -function : smp_yield_cpu at 1163a6
> > >   -prefix   : 0x7d780000
> > >   -cpu timer: 0x7fffffecf69f4974
> > >   -clock cmp: 0x42e71c731cb22c00
> > > 
> > >  #0 [033476e0] arch_spin_lock_wait at 850298
> > >  #1 [03347738] lock_timer_base at 1e4d22
> > >  #2 [033477a0] mod_timer at 1e5f2c
> > >  #3 [03347810] __sclp_vt220_write at 6ba912
> > >  #4 [033478a0] sclp_vt220_con_write at 6ba9ac
> > >  #5 [033478f8] console_unlock at 1c87c8
> > >  #6 [03347978] vprintk_emit at 1c8bbe
> > >  #7 [03347a08] vprintk_default at 1c8e1c
> > >  #8 [03347a68] printk at 1c9d1e
> > >  #9 [03347af8] timers_dead_cpu at 1e66f6
> > > #10 [03347b68] cpuhp_invoke_callback at 169b50
> > > #11 [03347c00] _cpu_down at 851522
> > > #12 [03347c58] do_cpu_down at 16b9fa
> > > #13 [03347c88] device_offline at 5a7826
> > > #14 [03347cc0] online_store at 5a796e
> > > #15 [03347cf8] kernfs_fop_write at 3ed8d2
> > > #16 [03347d48] __vfs_write at 34ddb6
> > > #17 [03347e00] vfs_write at 34e10c
> > > #18 [03347e60] sys_write at 34e44e
> > > #19 [03347ea8] system_call at 85abf4
> > > 
> > > 
> > > Reverting the patch fixes the issue, but I do not yet understand why.
> > 
> > Welcome to my world!  ;-)
> > 
> > Hmmm...  I have to ask...  Have you tried this with lockdep?  The spinning
> > on CPUs is suspicious, though not something that I have seen.
> 
> This seems to simply deadlock because the cpu tries to grab a timer_base
> lock twice: first in timers_dead_cpu() and then via the new pr_info()
> within migrate_timer_list().
> 
> That one get's into our sclp device driver which tries to enqueue a timer
> and needs to grap a timer_base lock as well. Which appearently seems to be
> the same lock that was taken within timers_dead_cpu().

Color me slow and stupid!  I have dropped this commit and will think
about other ways of tracking my timer problem down.  And please accept
my apologies for the hassle.

							Thanx, Paul
