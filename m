From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] KVM-S390: Use memdup_user() rather than duplicating
 its implementation
Date: Mon, 22 Aug 2016 15:02:08 +0200
Message-ID: <20160822150208.2b78aaf3@thinkpad-w530>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
        <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 17 Aug 2016 18:41:43 +0200
> 
> * Reuse existing functionality from memdup_user() instead of keeping
>   duplicate source code.
> 
>   This issue was detected by using the Coccinelle software.
> 
> * Return directly if this copy operation failed.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I like that. Thanks for running that analysis software against s390 KVM code!

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>

David
