Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45793 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728035AbgBJM57 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 10 Feb 2020 07:57:59 -0500
Date: Mon, 10 Feb 2020 13:57:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 09/35] KVM: s390: protvirt: Add KVM api documentation
Message-ID: <20200210135743.580d6eeb.cohuck@redhat.com>
In-Reply-To: <aae6434d-de87-503d-de51-4cee52d375b9@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
        <20200207113958.7320-10-borntraeger@de.ibm.com>
        <f7089ad6-65d2-35fc-16fb-b94e968fd4e8@redhat.com>
        <aae6434d-de87-503d-de51-4cee52d375b9@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 10 Feb 2020 13:26:35 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 08.02.20 15:57, Thomas Huth wrote:
> > On 07/02/2020 12.39, Christian Borntraeger wrote:  
> >> From: Janosch Frank <frankja@linux.ibm.com>
> >>
> >> Add documentation for KVM_CAP_S390_PROTECTED capability and the
> >> KVM_S390_PV_COMMAND and KVM_S390_PV_COMMAND_VCPU ioctls.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  Documentation/virt/kvm/api.txt | 61 ++++++++++++++++++++++++++++++++++
> >>  1 file changed, 61 insertions(+)

> >> +4.125 KVM_S390_PV_COMMAND
> >> +
> >> +Capability: KVM_CAP_S390_PROTECTED
> >> +Architectures: s390
> >> +Type: vm ioctl
> >> +Parameters: struct kvm_pv_cmd
> >> +Returns: 0 on success, < 0 on error
> >> +
> >> +struct kvm_pv_cmd {
> >> +	__u32	cmd;	/* Command to be executed */
> >> +	__u16	rc;	/* Ultravisor return code */
> >> +	__u16	rrc;	/* Ultravisor return reason code */
> >> +	__u64	data;	/* Data or address */  
> > 
> > That remindes me ... do we maybe want a "reserved" field in here for
> > future extensions? Or is the "data" pointer enough?  
> 
> 
> This is now:
> 
> struct kvm_pv_cmd {
> 
>         __u32 cmd;      /* Command to be executed */
>         __u32 flags;    /* flags for future extensions. Must be 0 for now */
>         __u64 data;     /* Data or address */
>         __u64 reserved[2];
> };

Ok, that is where you add this... but still, the question: are those
fields only ever set by userspace, or could the kernel return things in
the reserved fields in the future?

Also, two 64 bit values seem a bit arbitrary... what about a data
address + length construct instead? (Length might be a fixed value per
flag?)
