From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 06/12] KVM: s390: exploit GISA and AIV for emulated
 interrupts
Date: Thu, 25 Jan 2018 16:05:02 +0100
Message-ID: <20180125160502.6229000d.cohuck@redhat.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
        <20180125132848.175942-7-borntraeger@de.ibm.com>
        <040c7c5d-bbbd-89d4-ebcd-5d04ed80a40d@redhat.com>
        <7624195c-6933-ec70-11c5-328b247f21b8@de.ibm.com>
        <c43faba6-e4c2-89ad-afff-5da54afbb700@redhat.com>
        <dab4f172-7854-66f3-71e1-f9317ff0867c@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <dab4f172-7854-66f3-71e1-f9317ff0867c@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Jan 2018 15:45:14 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 01/25/2018 03:42 PM, David Hildenbrand wrote:
> > On 25.01.2018 15:32, Christian Borntraeger wrote:  
> >>
> >>
> >> On 01/25/2018 03:20 PM, David Hildenbrand wrote:
> >>  
> >>>> +void kvm_s390_gisa_init(struct kvm *kvm)
> >>>> +{
> >>>> +	if (1 || !css_general_characteristics.aiv)
> >>>> +		kvm->arch.gisa = NULL;  
> >>>
> >>> 1 || ... ? This will always trigger. -> gisa never active with this patch  
> >>
> >> See patch 10. 
> >>  
> > 
> > Well than this is just ugly this way.  
> 
> Reshuffling this is hard due to code dependencies. I can try to minimize this.
> The alternative is to merge patches 6,7,8,9 and 10, but this split makes it
> easier to review the parts. 
> 

if (1 /* disabled for now */ || !css_general_characteristics.aiv)

?

I dunno, I'm not really bothered by this.
