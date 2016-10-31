Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 31 Oct 2016 11:56:00 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 9/9] s390: virtio: make ccw explicitly non-modular
In-Reply-To: <20161030203732.26405-10-paul.gortmaker@windriver.com>
References: <20161030203732.26405-1-paul.gortmaker@windriver.com>
        <20161030203732.26405-10-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161031115600.0a0830e2.cornelia.huck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 30 Oct 2016 16:37:32 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> The Kconfig currently controlling compilation of this code is:
> 
> arch/s390/Kconfig:config S390_GUEST
> arch/s390/Kconfig:      def_bool y
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We replace module.h with moduleparam.h since the file does declare
> some module_param() and leaving that as-is is currently the easiest
> way to remain compatible with existing boot arg use cases.
> 
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)

There might actually be a case for making this modular, as the
virtio-pci transport can be built as a module as well. But I don't
think anybody really cares, and your patch is easily reverted should we
want to do this later, so

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

[going through the s390 tree with the other patches is probably easier
as taking this through the virtio tree]
