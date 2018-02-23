From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 23 Feb 2018 11:04:17 +0000
Subject: Re: [PATCH 1/2] KVM: document KVM_CAP_S390_[BPB|PSW|GMAP|COW]
Message-Id: <20180223120417.09b476a0.cohuck@redhat.com>
In-Reply-To: <07414b0f-7b5e-2eca-3ce4-56e7cdacd9a8@de.ibm.com>
References: <07414b0f-7b5e-2eca-3ce4-56e7cdacd9a8@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 23 Feb 2018 12:03:00 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02/23/2018 11:55 AM, David Hildenbrand wrote:
> > On 23.02.2018 09:11, Christian Borntraeger wrote:  

> >> +8.17 KVM_CAP_S390_BPB
> >> +
> >> +Architectures: s390
> >> +
> >> +This capability indicates that kvm will implement the interfaces to handle
> >> +reset, migration and nested KVM for branch prediction blocking.
> >>  
> > 
> > Maybe add a comment about bpb being exposed via CPU model (stfl) and
> > that it should not be used without this capability?  
> 
> Something like:
> "The stfle facility 82 should not be provided to the guest without this capability".
> ?
> 

Makes sense.
