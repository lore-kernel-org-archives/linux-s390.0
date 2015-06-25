Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Jun 2015 13:37:12 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/process: Delete an unnecessary check before the
 function call "kfree"
Message-ID: <20150625113712.GB4069@osiris>
References: <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <558B1799.8040003@users.sourceforge.net>
 <558BD1B4.4030209@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558BD1B4.4030209@bfs.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: walter harms <wharms@bfs.de>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jun 25, 2015 at 12:02:28PM +0200, walter harms wrote:
> 
> Am 24.06.2015 22:48, schrieb SF Markus Elfring:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 24 Jun 2015 22:40:30 +0200
> > 
> > The kfree() function tests whether its argument is NULL and then
> > returns immediately. Thus the test around the call is not needed.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  arch/s390/kernel/process.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> > index dc5edc2..22e6448 100644
> > --- a/arch/s390/kernel/process.c
> > +++ b/arch/s390/kernel/process.c
> > @@ -81,8 +81,7 @@ void release_thread(struct task_struct *dead_task)
> >  
> >  void arch_release_task_struct(struct task_struct *tsk)
> >  {
> > -	if (tsk->thread.vxrs)
> > -		kfree(tsk->thread.vxrs);
> > +	kfree(tsk->thread.vxrs);
> >  }

This code will be changed soon anyway. So it would be rather pointless
to apply your patch now. Thanks anyway!

> >  int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
> maybe the intention was to check tsk != NULL ?

No.
