Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Nov 2017 15:07:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 08/12] s390: kvm: Remove redundant license text
Message-ID: <20171124150742.1e776030.cohuck@redhat.com>
In-Reply-To: <20171124140043.10062-9-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
        <20171124140043.10062-9-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 24 Nov 2017 15:00:39 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

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

Acked-by: Cornelia Huck <cohuck@redhat.com>
