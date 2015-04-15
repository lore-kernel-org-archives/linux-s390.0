From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: s390: Fix for kvm/master (target 4.1)
Date: Wed, 15 Apr 2015 13:11:06 +0200
Message-ID: <552E474A.9060109@redhat.com>
References: <1429093624-49611-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1429093624-49611-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On 15/04/2015 12:27, Christian Borntraeger wrote:
> Paolo,
> 
> here is a small fix for a regression that came in during the
> merge window. If affects only guests older than 3.12 when
> running on z196 or newer and transparent huge pages are used
> in the guest.
> 
> As it is only one patch I prepared no signed tag - let me
> know if you prefer to have one.

Thanks, it's okay.

Paolo
