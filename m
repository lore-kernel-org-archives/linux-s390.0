Return-Path: <linux-kernel-owner+w=401wt.eu-S1762929AbYGOVCt@vger.kernel.org>
Date: Wed, 16 Jul 2008 00:02:30 +0300
From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] chsc headers userspace cleanup
Message-ID: <20080715210230.GK24533@cs181140183.pp.htv.fi>
References: <20080715125817.GB24533@cs181140183.pp.htv.fi> <20080715191748.1f3905ad@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20080715191748.1f3905ad@gondolin.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 15, 2008 at 07:17:48PM +0200, Cornelia Huck wrote:
> On Tue, 15 Jul 2008 15:58:18 +0300,
> Adrian Bunk <bunk@kernel.org> wrote:
> 
> > Kernel headers shouldn't expose functions to userspace.
> 
> Could you please elaborate? Especially as I see e.g.
> include/linux/virtio_ring.h exporting functions outside #ifdef
> __KERNEL__ as well...

Our headers are in a bad shape...

The userspace headers should contain everything that is part of the ABI 
between the kernel and userspace.

Nothing more.

The kernel is heavily changing with each release while the userspace ABI 
is cast in stone, and leaking more stuff to userspace than required only 
increases the chances of some userspace programmer using it and some 
kernel programmer then changing it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
