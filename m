From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH v2 2/2] KVM: s390: Use memdup_user() rather than
 duplicating code
Date: Mon, 3 Oct 2016 15:47:46 +0200
Message-ID: <9ee60162-110b-1305-5a97-624de425d072@users.sourceforge.net>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
 <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com>
 <e72e9854-443b-7033-d674-8a2d237600ca@users.sourceforge.net>
 <c86f7520-885e-2829-ae9c-b81caa898e84@users.sourceforge.net>
 <CAMuHMdVX6RKZYQyOrX35D+EKoRH6ZFAkyiC=BKnyKtE1Ph4t8g@mail.gmail.com>
 <73d5a586-2178-a311-f19c-c16c6e8cbb22@users.sourceforge.net>
 <CAMuHMdWgCBmObqfhkrtZPXjYqK7sA0DWeLzTV18hqKpevu1MeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWgCBmObqfhkrtZPXjYqK7sA0DWeLzTV18hqKpevu1MeA@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Walter Harms <wharms@bfs.de>
List-ID: <linux-s390.vger.kernel.org>

>> Did you notice the check "IS_ERR(bp_data)" and the corresponding reaction
>> in this update suggestion?
> 
> Yes, but bp_data may still be a valid (as in "not an error") value.

Thanks for your constructive feedback.


> Your commit a1708a2eaded836b ("KVM: s390: Improve determination of sizes in
> kvm_s390_import_bp_data()") made the code more robust, as kmalloc_array() ha
>  a builtin overflow check, and will return NULL if overflow is detected.
> However, commit 0624a8eb82efd58e ("KVM: s390: Use memdup_user() rather than
> duplicating code") dropped that safety net again.

* How much are you concerned about the shown software evolution around
  multiplications for memory allocations?

* Does there really a probability remain that an inappropriate product
  would be calculated here (as the situation was before my two update steps
  for this software module)?

* Can it be that you are looking for a variant of a function like "memdup_user"
  where values can be passed as separate parameters "count" and "size" so that
  the needed multiplication and corresponding overflow check would be performed
  together as desired?

Regards,
Markus
