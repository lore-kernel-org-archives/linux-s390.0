From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2/RFC] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
Date: Thu, 16 Jan 2014 20:56:38 +0200
Message-ID: <20140116185638.GD29522@redhat.com>
References: <52D7C186.1070700@redhat.com>
 <1389876260-46636-1-git-send-email-borntraeger@de.ibm.com>
 <52D7D7A2.2080409@redhat.com>
 <52D7D95F.5040600@de.ibm.com>
 <52D7D987.8060305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52D7D987.8060305@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Gleb Natapov <gleb@minantech.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 16, 2014 at 02:07:19PM +0100, Paolo Bonzini wrote:
> Il 16/01/2014 14:06, Christian Borntraeger ha scritto:
> > Will you edit the patch description or shall I resend the patch?
> 
> I can edit the commit message.
> 
> Paolo

I think we really need to see the effect adding srcu has on interrupt
injection.
