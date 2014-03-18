From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/5] KVM: eventfd: Fix lock order inversion.
Date: Tue, 18 Mar 2014 17:05:32 +0100
Message-ID: <53286ECC.40803@redhat.com>
References: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com> <1395079899-29239-2-git-send-email-cornelia.huck@de.ibm.com> <53276F65.4070501@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53276F65.4070501@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: agraf@suse.de, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Il 17/03/2014 22:55, Christian Borntraeger ha scritto:
>> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Do you still have the lockdep message somewhere?
> Looking at the patch and the description this makes sense. Even without
> irqfd for s390:
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>
> Paolo, maybe this patch can go in independently from s390?

Yes, that's fine.  I'm applying it  to kvm/queue.

Paolo
