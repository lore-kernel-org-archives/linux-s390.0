From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC/PATCH v2 21/22] KVM: s390: Add KVM HPAGE capability
Date: Wed, 20 Dec 2017 14:21:59 +0100
Message-ID: <20171220142159.29cf7185.cohuck@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
        <1513169613-13509-22-git-send-email-frankja@linux.vnet.ibm.com>
        <20171220140236.7043f9a7.cohuck@redhat.com>
        <9def7f57-5cab-8b7b-e213-83d5b07727a0@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <9def7f57-5cab-8b7b-e213-83d5b07727a0@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 20 Dec 2017 14:17:24 +0100
Janosch Frank <frankja@linux.vnet.ibm.com> wrote:

> On 20.12.2017 14:02, Cornelia Huck wrote:
> > On Wed, 13 Dec 2017 13:53:32 +0100
> > Janosch Frank <frankja@linux.vnet.ibm.com> wrote:
> >   
> >> KVM huge page backing support can not be easily tested under
> >> s390. Currently testing is only possible after most of the guest has
> >> already been set up.
> >>
> >> To indicate, that KVM has huge page backing support, we add the
> >> KVM_CAP_S390_HPAGE capability. This does not mean, that transparent
> >> huge pages are supported.  
> > 
> > Do you expect to use a different cap for non-1MB huge pages? If yes,
> > this should probably be mentioned here.  
> 
> Yes probably KVM_CAP_S390_HPAGE2, but this will not come in the near future.
> However this commit message lacks the information, that we only support
> 1m pages, I'll add that.

OK

> 
> 1m guest backing pages ought to be enough for everybody (TM) 

:)

> and the
> pain to support 2g pages is expected to be a magnitude bigger than the
> one for this patchset.

This patchset already looks complicated enough to me...

> 
> >   
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> >> ---
> >>  Documentation/virtual/kvm/api.txt | 10 ++++++++++
> >>  arch/s390/kvm/kvm-s390.c          |  1 +
> >>  include/uapi/linux/kvm.h          |  1 +
> >>  3 files changed, 12 insertions(+)
> >>
> >> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> >> index 57d3ee9..a56b0af 100644
> >> --- a/Documentation/virtual/kvm/api.txt
> >> +++ b/Documentation/virtual/kvm/api.txt
> >> @@ -4369,3 +4369,13 @@ Parameters: none
> >>  This capability indicates if the flic device will be able to get/set the
> >>  AIS states for migration via the KVM_DEV_FLIC_AISM_ALL attribute and allows
> >>  to discover this without having to create a flic device.
> >> +
> >> +8.14 KVM_CAP_S390_HPAGE
> >> +
> >> +Architectures: s390
> >> +This capability, if KVM_CHECK_EXTENSION indicates that it is
> >> +available, means that KVM supports VMs that are memory backed through
> >> +hugetlbfs with 1 megabyte pages.
> >> +
> >> +While it is generally possible to create and start a VM without this
> >> +support, the VM will not be functional.  
> > 
> > This sentence applies only to the hugepage case, doesn't it?  
> 
> Yes, of course.
> I'll do a: s/a/such a/
> 
> Expect a QEMU fencing patch next year.

Sounds good!
