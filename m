Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 4 Aug 2017 11:20:17 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: drivers/s390/char/keyboard.c kernel stack infoleak
References: <116f735.aa23.15da864e94a.Coremail.sohu0106@126.com>
 <0b76e8f9-e1ea-da9e-23f2-92cdbd475ec9@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b76e8f9-e1ea-da9e-23f2-92cdbd475ec9@tuxfamily.org>
Message-Id: <20170804092017.GA3278@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Huth <huth@tuxfamily.org>
Cc: sohu0106 <sohu0106@126.com>, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 04, 2017 at 11:09:24AM +0200, Thomas Huth wrote:
>  Hi,
> 
> On 03.08.2017 15:59, sohu0106 wrote:
> > 
> > The stack object "kbdiacr" has a total size of 4 bytes. Its last 1 bytes are padding bytes after "result" which are not initialized and leaked to userland via "copy_to_user".
> > 
> > 
> > diff --git a/keyboard.c b/keyboard.c
> > index ba0e4f9..76a6d35 100644
> > --- a/keyboard.c
> > +++ b/keyboard.c
> > @@ -480,6 +480,8 @@ int kbd_ioctl(struct kbd_data *kbd, unsigned int cmd, unsigned long arg)
> >                 struct kbdiacr diacr;
> >                 int i;
> >  
> > +               memset( &diacr, 0, sizeof(struct kbdiacr) );
> > +
> 
> I think it would be nicer to simply init the struct with "= {}"
> directly, i.e.:
> 
> 		struct kbdiacr diacr = {};
> 
> And by the way, please have a look at the kernel patch submission
> guidelines first, especially the COO part here:

The patch doesn't make sense. There is no padding and therefore no
information leak.
