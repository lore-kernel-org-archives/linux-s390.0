From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [BUILD-FAILURE] next-20081217-s390x-'struct device' has no
	member named 'knode_parent'
Date: Thu, 18 Dec 2008 10:47:45 +0100
Message-ID: <1229593665.7086.1.camel@localhost>
References: <20081217232536.0b18f4a7.sfr@canb.auug.org.au>
	 <20081217181745.GA18420@linux.vnet.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20081217181745.GA18420@linux.vnet.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-12-17 at 23:47 +0530, Kamalesh Babulal wrote:
> drivers/s390/cio/device.c: In function 'io_subchannel_register':
> drivers/s390/cio/device.c:913: error: 'struct device' has no member
> named 'knode_parent'
> make[2]: *** [drivers/s390/cio/device.o] Error 1
> make[1]: *** [drivers/s390/cio] Error 2
> make: *** [drivers/s390] Error 2

Should be fixed now by the following patch from Cornelia:

commit efe46b59567ae999ff7d344170d21f093159ad80
Author: Cornelia Huck <cornelia.huck@de.ibm.com>
Date:   Thu Dec 18 10:26:55 2008 +0100

    [S390] cio: Use device_is_registered().

    Check if a ccw device is registered via device_is_registered()
    and not via the old kludge of checking the membership in driver
    core internal klists.

    Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
    Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

You'll find the fix in the features branch of git390 which will be
included in the next linux-next kernel.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
