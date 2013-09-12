From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/8] KVM: s390: Split up __vcpu_run into three parts
Date: Thu, 12 Sep 2013 11:13:42 +0200
Message-ID: <523185C6.8050609@redhat.com>
References: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com> <1378974829-46578-3-git-send-email-borntraeger@de.ibm.com> <52318277.6010200@redhat.com> <523184D9.5070304@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <523184D9.5070304@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gleb Natapov <gleb@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 12/09/2013 11:09, Christian Borntraeger ha scritto:
>> > I don't have this VCPU_EVENT in kvm/queue, it is after preempt_enable:
> Huh? This was moved with
> 
> commit 2b29a9fdcb92bfc6b6f4c412d71505869de61a56
> Author: Dominik Dingel <dingel@linux.vnet.ibm.com>
> Date:   Fri Jul 26 15:04:00 2013 +0200
> 
>     KVM: s390: move kvm_guest_enter,exit closer to sie

Nevermind...

Paolo
