From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] KVM-S390: Less function calls in
 kvm_s390_import_bp_data() after error detection
Date: Mon, 22 Aug 2016 14:58:26 +0200
Message-ID: <20160822145826.386328d8@thinkpad-w530>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
        <47f88a11-b949-28ed-5589-925888a37574@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <47f88a11-b949-28ed-5589-925888a37574@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 17 Aug 2016 19:25:50 +0200
> 
> The kfree() function was called in a few cases by the
> kvm_s390_import_bp_data() function during error handling
> even if a passed variable contained a null pointer.
> 
> Adjust jump targets according to the Linux coding style convention.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/s390/kvm/guestdbg.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

Nack, we don't need micro optimization for error handling code. Adding more
jump labels is never a good idea, it just increases complexity.

David
