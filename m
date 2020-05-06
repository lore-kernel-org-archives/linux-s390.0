Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60174 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728045AbgEFNEx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 09:04:53 -0400
Received: by mail-wm1-f72.google.com with SMTP id j5so1188957wmi.4
        for <linux-s390@vger.kernel.org>; Wed, 06 May 2020 06:04:50 -0700 (PDT)
Subject: Re: [GIT PULL 1/1] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
References: <20200506115945.13132-1-borntraeger@de.ibm.com>
 <20200506115945.13132-2-borntraeger@de.ibm.com>
 <bcd98cbd-1e28-47a2-6cbd-668da4ddb9f5@redhat.com>
 <fe991071-25d0-3842-73cc-23cb365850f3@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8688ff1-edc6-fdd8-9575-adbf726f9f06@redhat.com>
Date: Wed, 6 May 2020 15:04:45 +0200
MIME-Version: 1.0
In-Reply-To: <fe991071-25d0-3842-73cc-23cb365850f3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Qian Cai <cailca@icloud.com>

On 06/05/20 14:23, Christian Borntraeger wrote:
> 
> the problem is that z/VM seems to have disabled that bit. The interpretion
> only works when all layers have this bit set. (Its called an effective bit). 
> So we have
> LPAR -> ECA_APIE = 1
> Z/VM -> ECA_APIE = 0
> KVM  -> ECA_APIE = 1
> nested KVM guest --> does during boot in ap_instructions_available PQAP with
> FC==0 to test if crypto is available.
> 
> As the nested guest is in fact a shadow guest of z/VM
> this will now intercept to z/VM, which will forward that to KVM.

Right, and I'd understand, that since KVM has set ECA_APIE=1, z/VM
should either:

* not forward the intercept to KVM unless FC==3

* toggle ECA_APIE back to 1 while running the KVM nested guest.

Of course I have no idea if either of these choices is impossible, or
too expensive, but this is how we'd try to handle it for x86 features.

So it would be a z/VM bug, because it's not virtualizing ECA_APIE=1
correctly.  The next question is, if removing the WARN_ON is okay for
you, should KVM not bother setting ECA_APIE=1 so that you don't trigger
the z/VM bug at all?

Thanks,

Paolo

> 
> As PQAP with FC==0 DOES work in the KVM, KVM believes that we have crypto
> support and we will enable it for our guests. So all the early checks in
> handle_pqap will succeed until we run in the check for fc!=3.
> 
> In the end this is obviously a case how this warning can trigger. So we better
> remove it and rely on the error path to clean up.
