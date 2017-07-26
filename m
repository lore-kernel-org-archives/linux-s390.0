Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 26 Jul 2017 13:48:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Qemu problems in -next with 's390/spinlock: add niai spinlock
 hints'
In-Reply-To: <20170726114014.1f3cc5d6@gondolin>
References: <20170726011451.GA24947@roeck-us.net>
        <20170726050033.GA3218@osiris>
        <20170726074044.41bdc796@mschwideX1>
        <20170726114014.1f3cc5d6@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170726134823.3ba72cd8@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 26 Jul 2017 11:40:14 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 26 Jul 2017 07:40:44 +0200
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > On Wed, 26 Jul 2017 07:00:33 +0200
> > Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> >   
> > > On Tue, Jul 25, 2017 at 06:14:51PM -0700, Guenter Roeck wrote:    
> > > > Hi Martin,
> > > > 
> > > > my s390 qemu tests in linux-next stopped working a few days ago.
> > > > Bisect points to commit 's390/spinlock: add niai spinlock hints'.
> > > > 
> > > > Looking at the patch, this isn't really surprising; at least to me it looks
> > > > like the patch is making instructions mandatory which are only available in
> > > > Z14 CPUs. Does this mean that older s390 CPUs (such as the Z900 used in my
> > > > qemu tests) are no longer going to be supported in Linux ?      
> > > 
> > > No, that means that the patch has a bug. The NIAI instruction is only
> > > available if the execution-hint facility is installed. That facility came
> > > with zEC12. Luckily it uses the same facility indicator bit like the
> > > miscellaneous-instruction-extensions facility, which we already use anyway
> > > if the kernel gets compiled for zEC12. In that case we have early code
> > > which verifies if all required facilities to run the kernel are installed,
> > > and if not it will print a message to the console and stop the machine.
> > > 
> > > So the easiest fix would be to generate the NIAI instruction only if the
> > > kernel gets compiled for zEC12 or newer.    
> > 
> > Hmm, I though that NIAI is a NOP on older machines.  
> 
> FWIW, the upcoming qemu 2.11 (in tcg mode) will support to activate
> stfle bit 49 and generate NOPs for NIAI and friends.
> 
> If I read the PoP correctly, the only correct way is to check for stfle
> bit 49 before trying to use NIAI. While a real zEC12 or later probably
> will have the facility, you can withdraw the feature bit via the cpu
> model when running under qemu.
 
A kernel compiled for ZEC12 or later will check STFLE bit 49 at boot time
and crash if the bit is not set.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
