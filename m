From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCHv2/RFC] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
Date: Fri, 17 Jan 2014 10:19:25 +0100
Message-ID: <52D8F59D.90803@redhat.com>
References: <52D7C186.1070700@redhat.com> <1389876260-46636-1-git-send-email-borntraeger@de.ibm.com> <52D7D7A2.2080409@redhat.com> <52D7D95F.5040600@de.ibm.com> <52D7D987.8060305@redhat.com> <20140116185638.GD29522@redhat.com> <52D8E9E6.5040507@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <52D8E9E6.5040507@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gleb Natapov <gleb@minantech.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

Il 17/01/2014 09:29, Christian Borntraeger ha scritto:
> Michael, 
> do you have a quick way to check if srcu has a noticeable impact on int
> injection on your systems? I am happy with either v2 or v3 of the patch,
> but srcu_synchronize_expedited seems to have less latency impact on the 
> full system than rcu_synchronize_expedited. This might give Paolo a hint
> which of the patches is the right way to go.

For 3.14, I'll definitely pick v3.

Paolo
