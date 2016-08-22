From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] KVM-S390: Delete an unnecessary initialisation for
 a buffer variable
Date: Mon, 22 Aug 2016 14:59:17 +0200
Message-ID: <20160822145917.19382bbf@thinkpad-w530>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
        <6cf36937-3937-0521-5f11-258f557e0c32@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <6cf36937-3937-0521-5f11-258f557e0c32@users.sourceforge.net>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 17 Aug 2016 19:28:15 +0200
> 
> The variable "bp_data" will eventually be set to an appropriate pointer
> from a call of the memdup_user() function.
> Thus omit the explicit initialisation which became unnecessary with
> a previous update step.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Looks sane to me.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>

Thanks!

David
