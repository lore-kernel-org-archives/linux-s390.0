From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH REBASED 3/6] s390: Add __down_read_killable()
Date: Sat, 30 Sep 2017 12:38:55 +0200
Message-ID: <20170930103855.GA9309@osiris>
References: <150670038738.23930.7190484711222807884.stgit@localhost.localdomain>
 <150670117817.23930.13068785028558453848.stgit@localhost.localdomain>
 <20170930092002.GA4623@osiris>
 <20170930123612.0fb250fe@mschwideX1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170930123612.0fb250fe@mschwideX1>
Sender: linux-alpha-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, linux-ia64@vger.kernel.org, avagin@virtuozzo.com, peterz@infradead.org, hpa@zytor.com, gorcunov@virtuozzo.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, mingo@redhat.com, mattst88@gmail.com, fenghua.yu@intel.com, arnd@arndb.de, ink@jurassic.park.msu.ru, tglx@linutronix.de, rth@twiddle.net, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, davem@davemloft.net, rientjes@google.com, viro@zeniv.linux.org.uk
List-ID: <linux-s390.vger.kernel.org>

On Sat, Sep 30, 2017 at 12:36:12PM +0200, Martin Schwidefsky wrote:
> On Sat, 30 Sep 2017 11:20:02 +0200
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > On Fri, Sep 29, 2017 at 07:06:18PM +0300, Kirill Tkhai wrote:
> > > Similar to __down_write_killable(), and read killable primitive.
> > > 
> > > Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > > ---
> > >  arch/s390/include/asm/rwsem.h |   18 ++++++++++++++++--
> > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/s390/include/asm/rwsem.h b/arch/s390/include/asm/rwsem.h  
> > 
> > FWIW, while looking into this patch I realized that we never optimized our
> > rwsem primitives to make use of new atomic instructions.
> > 
> > The generic rwsem header file however does, since it uses atomic ops which
> > we did optimize. Even when compiling for old machines the generic version
> > generates better code. Therefore I will remove the 15 years old s390
> > implementation and switch to the generic version instead.
> 
> Take care not to conflict with the queued spinlock/rwlock patches on the
> features branch. 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=eb3b7b848fb3dd00f7a57d633d4ae4d194aa7865
> 
> Me thinks that what you have in mind is already done.

No, it's not done. You probably mixed up rwlocks and rwsems?
