From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: linux-next: Tree for Apr 4
Date: Mon, 4 Apr 2016 16:26:35 +0200
Message-ID: <20160404142635.GF4058@osiris>
References: <20160404140951.148c95f6@canb.auug.org.au>
 <57025C35.6090206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57025C35.6090206@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 04, 2016 at 05:51:09PM +0530, Sudip Mukherjee wrote:
> On Monday 04 April 2016 09:39 AM, Stephen Rothwell wrote:
> >Hi all,
> >
> >Changes since 20160401:
> 
> s390 allmodconfig build fails with the error:
> 
> arch/s390/crypto/ghash_s390.c:14:24: fatal error: crypt_s390.h: No
> such file or directory
>  #include "crypt_s390.h"
>                       ^
> 
> build log is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/120536718
> 
> caused by the commit -
> ce69a690149c ("s390/crypto: cleanup and move the header with the
> cpacf definitions") which removed the file "crypt_s390.h"

Thanks for letting us know!

I just removed that specific patch from the 'features' branch again. It was
incomplete since it didn't convert the ghash module at all.

No idea what Martin was thinking when pushing that patch.
