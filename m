From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: KVM: s390: Use memdup_user() rather than duplicating code
Date: Mon, 3 Oct 2016 16:25:34 +0200
Message-ID: <da96837e-50bb-de1e-be42-0a22474edee8@users.sourceforge.net>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
 <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com>
 <e72e9854-443b-7033-d674-8a2d237600ca@users.sourceforge.net>
 <c86f7520-885e-2829-ae9c-b81caa898e84@users.sourceforge.net>
 <CAMuHMdVX6RKZYQyOrX35D+EKoRH6ZFAkyiC=BKnyKtE1Ph4t8g@mail.gmail.com>
 <73d5a586-2178-a311-f19c-c16c6e8cbb22@users.sourceforge.net>
 <CAMuHMdWgCBmObqfhkrtZPXjYqK7sA0DWeLzTV18hqKpevu1MeA@mail.gmail.com>
 <9ee60162-110b-1305-5a97-624de425d072@users.sourceforge.net>
 <CAMuHMdUS2aMd5B2nQOpQFdQGE7EvWMCea+dMzS7R7_yZ4LdONw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUS2aMd5B2nQOpQFdQGE7EvWMCea+dMzS7R7_yZ4LdONw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Walter Harms <wharms@bfs.de>
List-ID: <linux-s390.vger.kernel.org>

>> * Does there really a probability remain that an inappropriate product
>>   would be calculated here (as the situation was before my two update steps
>>   for this software module)?
> 
> Perhaps not. Hence my "Probably not an issue here, ...".

Thanks for your clarification.


>> * Can it be that you are looking for a variant of a function like "memdup_user"
>>   where values can be passed as separate parameters "count" and "size" so that
>>   the needed multiplication and corresponding overflow check would be performed
>>   together as desired?
> 
> If there are enough uses, and people like it, adding memdup_user_array()
> may be a good idea...

How are the chances of such an addition for the Linux programming interface?


> P.S. Why do your questions make me think of a scientific paper? ;-)

Would you like to recommend any for further reading?   ;-)

Regards,
Markus
