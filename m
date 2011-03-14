From: Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: Re: linux-next: build failure after merge of the final tree (block
 tree  related)
Date: Mon, 14 Mar 2011 09:33:22 +0100
Message-ID: <20110314083322.GA11932@barkeeper1-xen.linbit>
References: <20110311175830.29a387b2.sfr@canb.auug.org.au>
 <4D79CB66.2020302@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D79CB66.2020302@kernel.dk>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Mar 11, 2011 at 08:12:38AM +0100, Jens Axboe wrote:
> On 2011-03-11 07:58, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the final tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> > 
> > drivers/char/tpm/tpm_tis.c:96: warning: 'is_itpm' defined but not used
> > drivers/block/drbd/drbd_bitmap.c: In function '__bm_change_bits_to':
> > drivers/block/drbd/drbd_bitmap.c:1287: error: implicit declaration of function 'generic___test_and_set_le_bit'
> > drivers/block/drbd/drbd_bitmap.c:1289: error: implicit declaration of function 'generic___test_and_clear_le_bit'
> > drivers/block/drbd/drbd_bitmap.c: In function 'drbd_bm_test_bit':
> > drivers/block/drbd/drbd_bitmap.c:1438: error: implicit declaration of function 'generic_test_le_bit'
> > 
> > Caused by commit 4b0715f09655 ("drbd: allow petabyte storage on 64bit
> > arch").
> > 
> > I have applied this patch for today (surely there is a better way):
> 
> Thanks for not dropping it, I'll let the drbd guys send in a proper fix
> and get it committed.

Should that be fixed by adding
#include <asm-generic/bitops/le.h>
to 
arch/powerpc/include/asm/bitops.h
(and arch/s390/include/asm/bitops.h, possibly others?)

Or are we expected to include that ourselves, directly?

We probably need to select CONFIG_GENERIC_FIND_NEXT_BIT
from our Kconfig as well?

	Lars
