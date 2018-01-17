From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/6] KVM: s390: wire up seb feature
Date: Wed, 17 Jan 2018 12:32:11 +0100
Message-ID: <db8adc42-2d57-68ee-9532-79a7020fe914@redhat.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <1516182519-10623-6-git-send-email-schwidefsky@de.ibm.com>
 <4fa9b6fa-40cb-b51e-0aa8-2e21bd93d526@de.ibm.com>
 <d732ca53-9aba-8db5-b748-09193a615963@redhat.com>
 <0a8dad23-0d88-cb10-d943-ac9ee265df7f@de.ibm.com>
 <23083bfd-7fd9-0b03-53ba-fa5f4d46a6b6@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <23083bfd-7fd9-0b03-53ba-fa5f4d46a6b6@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On 17/01/2018 12:29, Christian Borntraeger wrote:
>> The problem is not that I announce the facility, I in fact announce that the
>> programmatic interface is available (the sebc sync reg and the usage of that field).
>> (So the CAP is part of this patch to have both in lockstep)
>> A non-existing facility will then just disable that programmatic interface.
> To put it differently. CAP_S390_GS and CAP_S390_SEB could also just
> do a 
> 
> return 1;
> 
> and the QEMU has to check both (which it probably does anyway)

I see.  Thanks for the explanation!

Paolo
