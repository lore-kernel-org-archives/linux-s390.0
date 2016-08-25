From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 1/2] KVM: s390: Improve determination of sizes in
 kvm_s390_import_bp_data()
Date: Thu, 25 Aug 2016 18:10:09 +0200
Message-ID: <20160825181009.381411d9.cornelia.huck@de.ibm.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
        <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
        <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com>
        <e72e9854-443b-7033-d674-8a2d237600ca@users.sourceforge.net>
        <c3323f6b-4af2-0bfb-9399-e529952e378e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c3323f6b-4af2-0bfb-9399-e529952e378e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?= <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Walter Harms <wharms@bfs.de>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 24 Aug 2016 20:36:26 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 24 Aug 2016 19:45:23 +0200
> 
> * A multiplication for the size determination of a memory allocation
>   indicated that an array data structure should be processed.
>   Thus reuse the corresponding function "kmalloc_array".
> 
>   Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> 
>   This issue was detected also by using the Coccinelle software.

Do you have the scripts you use published somewhere?

> 
> * Replace the specification of data structures by pointer dereferences
>   to make the corresponding size determination a bit safer according to
>   the Linux coding style convention.
> 
> * Delete the local variable "size" which became unnecessary with
>   this refactoring.

I think your description is a bit on the verbose side, but not enough
to gripe more.

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> 
> v2: Rebased on source files from "Linux next-20160824".
>     Advices were integrated from source code review.
> 
>  arch/s390/kvm/guestdbg.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
