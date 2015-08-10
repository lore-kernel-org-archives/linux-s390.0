From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] kvm:s390:Fix assumption that kvm_set_irq_routing is
 always run successfully
Date: Mon, 10 Aug 2015 17:44:18 +0200
Message-ID: <55C8C6D2.7030806@redhat.com>
References: <1438880754-27149-1-git-send-email-xerofoify@gmail.com>
 <55C45BB7.6020502@redhat.com> <55C8C16F.2020906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C8C16F.2020906@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: nick <xerofoify@gmail.com>, gleb@kernel.org
Cc: borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, linux390@de.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 10/08/2015 17:21, nick wrote:
> > Seems good.
> > 
> > Paolo
>
> If it makes it easier for you to trust my patches I can show at least 10 bug fixes for other subsystems
> to prove that I am trying to do this correctly.

That's up to those maintainers...

I definitely see some improvement in your patches, though I still
haven't answered the submissions that in my opinion are a bit more
problematic.

Paolo
