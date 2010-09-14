From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [-next Sept 10] Build break - arch/s390/mm/pgtable.c
 (INIT_RCU_HEAD)
Date: Tue, 14 Sep 2010 13:39:19 +0200
Message-ID: <20100914133919.19878e39@mschwide.boeblingen.de.ibm.com>
References: <4C89E8A0.1050905@in.ibm.com>
	<20100910122806.05548325@mschwide.boeblingen.de.ibm.com>
	<4C8F2EBF.4060606@in.ibm.com>
	<20100914183648.b4371ae5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100914183648.b4371ae5.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 14 Sep 2010 18:36:48 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Sachin, Martin,
> 
> On Tue, 14 Sep 2010 13:43:51 +0530 Sachin Sant <sachinp@in.ibm.com> wrote:
> >
> > Martin Schwidefsky wrote:
> > > On Fri, 10 Sep 2010 13:43:20 +0530
> > > Sachin Sant <sachinp@in.ibm.com> wrote:
> > >
> > >   
> > >> Today's next fails to build on a s390 box with
> > >>
> > >> arch/s390/mm/pgtable.c: In function 'rcu_table_freelist_finish':
> > >> arch/s390/mm/pgtable.c:79: error: implicit declaration of function 'INIT_RCU_HEAD'
> > >> make[2]: *** [arch/s390/mm/pgtable.o] Error 1
> > >>
> > >> This code in question was added via following commit:
> > >>
> > >> commit e726023d9ff7e4968e3e0622782174a4695d68a4
> > >> S390] lockless get_user_pages_fast()
> > >>     
> > >
> > > I guess that there is an #include <linux/rcupdate.h> missing in pgtable.c. I'll
> > > add it to the patch.
> > >   
> > I don't see definition for INIT_RCU_HEAD in rcupdate.h so adding rcupdate.h might
> > not help.
> > 
> > Infact i can't find usage/implementation of INIT_RCU_HEAD anywhere else in the code.
> > Is this macro deprecated ?
> 
> It has been removed by commit 5e8067adfdbaf97039a97540765b1e16eb8d61cc
> ("rcu head remove init") from the rcu and tip trees.
> 
> It was just initialising two internal pointers to NULL, so should not be
> needed (for non automatic definitions) even in Linus' current tree.

Ok, I'll drop the INIT_RCU_HEAD call from the patch. Without it linux-next compiles for me.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
