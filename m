From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: linux-next: Tree for Apr 4
Date: Wed, 13 Apr 2016 09:52:35 +0200
Message-ID: <20160413075235.GB3832@osiris>
References: <20160404140951.148c95f6@canb.auug.org.au>
 <57025C35.6090206@gmail.com>
 <20160404142635.GF4058@osiris>
 <20160412183408.248092c7@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160412183408.248092c7@mschwide>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 12, 2016 at 06:34:08PM +0200, Martin Schwidefsky wrote:
> On Mon, 4 Apr 2016 16:26:35 +0200
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > On Mon, Apr 04, 2016 at 05:51:09PM +0530, Sudip Mukherjee wrote:
> > > On Monday 04 April 2016 09:39 AM, Stephen Rothwell wrote:
> > > >Hi all,
> > > >
> > > >Changes since 20160401:
> > > 
> > > s390 allmodconfig build fails with the error:
> > > 
> > > arch/s390/crypto/ghash_s390.c:14:24: fatal error: crypt_s390.h: No
> > > such file or directory
> > >  #include "crypt_s390.h"
> > >                       ^
> > > 
> > > build log is at:
> > > https://travis-ci.org/sudipm-mukherjee/parport/jobs/120536718
> > > 
> > > caused by the commit -
> > > ce69a690149c ("s390/crypto: cleanup and move the header with the
> > > cpacf definitions") which removed the file "crypt_s390.h"
> > 
> > Thanks for letting us know!
> > 
> > I just removed that specific patch from the 'features' branch again. It was
> > incomplete since it didn't convert the ghash module at all.
> > 
> > No idea what Martin was thinking when pushing that patch.
> 
> That is strange. On my local features branch that I use to push to kerne.org
> there is no ghash commit. The last commit is this:

Nobody said there is a ghash commit ;)

> commit ce69a690149c7431d05b4679409ab8fa6ad3a09f
> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date:   Thu Mar 17 15:22:12 2016 +0100
> 
>     s390/crypto: cleanup and move the header with the cpacf definitions
> 
> which Heiko now removed. My guest right now is that the ghash commit stems
> from another tree merged into linux-next and we simply have an unresolved
> dependency here. I do have an updated ghash patch that includes the correct
> header.

Your patch did not convert/touch arch/s390/crypto/ghash_s390.c which is
very old code. And you need to do more within that file than just changing
the include.
