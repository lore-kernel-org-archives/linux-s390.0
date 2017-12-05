From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] KVM: s390: Remove redundant license text
Date: Tue, 5 Dec 2017 08:22:37 -0800
Message-ID: <20171205162237.GK7829@linux.vnet.ibm.com>
References: <20171205083321.102933-1-borntraeger@de.ibm.com>
 <20171205083321.102933-3-borntraeger@de.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171205083321.102933-3-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Dec 05, 2017 at 09:33:19AM +0100, Christian Borntraeger wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Now that the SPDX tag is in all arch/s390/kvm/ files, that identifies
> the license in a specific and legally-defined manner.  So the extra GPL
> text wording can be removed as it is no longer needed at all.
> 
> This is done on a quest to remove the 700+ different ways that files in
> the kernel describe the GPL license text.  And there's unneeded stuff
> like the address (sometimes incorrect) for the FSF which is never
> needed.
> 
> No copyright headers or other non-license-description text was removed.
> 
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Message-Id: <20171124140043.10062-9-gregkh@linuxfoundation.org>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

> ---
>  arch/s390/kvm/Makefile    | 4 ----
>  arch/s390/kvm/diag.c      | 4 ----
>  arch/s390/kvm/gaccess.h   | 4 ----
>  arch/s390/kvm/guestdbg.c  | 4 ----
>  arch/s390/kvm/intercept.c | 4 ----
>  arch/s390/kvm/interrupt.c | 4 ----
>  arch/s390/kvm/irq.h       | 4 ----
>  arch/s390/kvm/kvm-s390.c  | 4 ----
>  arch/s390/kvm/kvm-s390.h  | 4 ----
>  arch/s390/kvm/priv.c      | 4 ----
>  arch/s390/kvm/sigp.c      | 4 ----
>  arch/s390/kvm/vsie.c      | 4 ----
>  12 files changed, 48 deletions(-)
> 
> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> index 2c5a819..05ee90a 100644
> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/Makefile
> @@ -2,10 +2,6 @@
>  # Makefile for kernel virtual machines on s390
>  #
>  # Copyright IBM Corp. 2008
> -#
> -# This program is free software; you can redistribute it and/or modify
> -# it under the terms of the GNU General Public License (version 2 only)
> -# as published by the Free Software Foundation.
> 
>  KVM := ../../../virt/kvm
>  common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqchip.o $(KVM)/vfio.o
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index 481e1fe..89aa114 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -4,10 +4,6 @@
>   *
>   * Copyright IBM Corp. 2008, 2011
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): Carsten Otte <cotte@de.ibm.com>
>   *               Christian Borntraeger <borntraeger@de.ibm.com>
>   */
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index 443b7fa..f4c5175 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -4,10 +4,6 @@
>   *
>   * Copyright IBM Corp. 2008, 2014
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): Carsten Otte <cotte@de.ibm.com>
>   */
> 
> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index d6a1bea..b5f3e82 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -4,10 +4,6 @@
>   *
>   * Copyright IBM Corp. 2014
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
>   */
>  #include <linux/kvm_host.h>
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index fc76a91..9c7d707 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -4,10 +4,6 @@
>   *
>   * Copyright IBM Corp. 2008, 2014
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): Carsten Otte <cotte@de.ibm.com>
>   *               Christian Borntraeger <borntraeger@de.ibm.com>
>   */
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index f37a34e..024ad8bc 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -4,10 +4,6 @@
>   *
>   * Copyright IBM Corp. 2008, 2015
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): Carsten Otte <cotte@de.ibm.com>
>   */
> 
> diff --git a/arch/s390/kvm/irq.h b/arch/s390/kvm/irq.h
> index 54a4a59..484608c 100644
> --- a/arch/s390/kvm/irq.h
> +++ b/arch/s390/kvm/irq.h
> @@ -4,10 +4,6 @@
>   *
>   * Copyright IBM Corp. 2014
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
>   */
>  #ifndef __KVM_IRQ_H
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 0d45e32..34375eed 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4,10 +4,6 @@
>   *
>   * Copyright IBM Corp. 2008, 2009
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): Carsten Otte <cotte@de.ibm.com>
>   *               Christian Borntraeger <borntraeger@de.ibm.com>
>   *               Heiko Carstens <heiko.carstens@de.ibm.com>
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 9777924..5e46ba4 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -4,10 +4,6 @@
>   *
>   * Copyright IBM Corp. 2008, 2009
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): Carsten Otte <cotte@de.ibm.com>
>   *               Christian Borntraeger <borntraeger@de.ibm.com>
>   *               Christian Ehrhardt <ehrhardt@de.ibm.com>
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index c9d962a..28b69ab 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -4,10 +4,6 @@
>   *
>   * Copyright IBM Corp. 2008, 2013
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): Carsten Otte <cotte@de.ibm.com>
>   *               Christian Borntraeger <borntraeger@de.ibm.com>
>   */
> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
> index d12ac5d..c1f5cde 100644
> --- a/arch/s390/kvm/sigp.c
> +++ b/arch/s390/kvm/sigp.c
> @@ -4,10 +4,6 @@
>   *
>   * Copyright IBM Corp. 2008, 2013
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): Carsten Otte <cotte@de.ibm.com>
>   *               Christian Borntraeger <borntraeger@de.ibm.com>
>   *               Christian Ehrhardt <ehrhardt@de.ibm.com>
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index d2b7886..5d6ae03 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -4,10 +4,6 @@
>   *
>   * Copyright IBM Corp. 2016
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *    Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
>   */
>  #include <linux/vmalloc.h>
> -- 
> 2.9.4
> 
