Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 08/12] s390: kvm: Remove redundant license text
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
 <20171124140043.10062-9-gregkh@linuxfoundation.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 Nov 2017 15:23:57 +0100
MIME-Version: 1.0
In-Reply-To: <20171124140043.10062-9-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <aefb6e1b-d849-74d4-5fd1-89f44dc2345c@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 11/24/2017 03:00 PM, Greg Kroah-Hartman wrote:
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

thanks, queued  for kvms390
