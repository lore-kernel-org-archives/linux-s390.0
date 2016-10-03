From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH v2 2/2] KVM: s390: Use memdup_user() rather than
 duplicating code
Date: Mon, 3 Oct 2016 14:28:24 +0200
Message-ID: <73d5a586-2178-a311-f19c-c16c6e8cbb22@users.sourceforge.net>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
 <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com>
 <e72e9854-443b-7033-d674-8a2d237600ca@users.sourceforge.net>
 <c86f7520-885e-2829-ae9c-b81caa898e84@users.sourceforge.net>
 <CAMuHMdVX6RKZYQyOrX35D+EKoRH6ZFAkyiC=BKnyKtE1Ph4t8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVX6RKZYQyOrX35D+EKoRH6ZFAkyiC=BKnyKtE1Ph4t8g@mail.gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Walter Harms <wharms@bfs.de>
List-ID: <linux-s390.vger.kernel.org>

>> -       if (!bp_data) {
>> -               ret = -ENOMEM;
>> -               goto error;
>> -       }
>> -
>> -       if (copy_from_user(bp_data,
>> -                          dbg->arch.hw_bp,
>> -                          sizeof(*bp_data) * dbg->arch.nr_hw_bp)) {
>> -               ret = -EFAULT;
>> -               goto error;
>> -       }
>> +       bp_data = memdup_user(dbg->arch.hw_bp,
>> +                             sizeof(*bp_data) * dbg->arch.nr_hw_bp);
> 
> ... while this would continue silently,

How do you think about to explain this information a bit more?


> and corrupt memory.

I wonder about this conclusion at the moment.

Did you notice the check "IS_ERR(bp_data)" and the corresponding reaction
in this update suggestion?

How does your feedback fit to the tag "Acked-by: Cornelia Huck"
from 2016-08-25?

Regards,
Markus
