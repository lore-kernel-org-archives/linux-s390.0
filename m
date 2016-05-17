From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] KVM: shrink halt polling even more for invalid
 wakeups
Date: Tue, 17 May 2016 18:43:59 +0200
Message-ID: <3532aed4-3021-8703-2714-2a3c50586e94@redhat.com>
References: <1463474962-5941-1-git-send-email-borntraeger@de.ibm.com>
 <1463474962-5941-2-git-send-email-borntraeger@de.ibm.com>
 <573B229A.3050608@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <573B229A.3050608@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Matlack <dmatlack@google.com>, Wanpeng Li <kernellwp@gmail.com>
List-ID: <linux-s390.vger.kernel.org>



On 17/05/2016 15:54, Christian Borntraeger wrote:
>> > -	if (halt_poll_ns) {
>> > +	if (!vcpu_valid_wakeup(vcpu))
>> > +		 shrink_halt_poll_ns(vcpu);
> 		^ hmpf. Small whitespace error. I can resend if wanted.

No need.

Paolo

>> > 
