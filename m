Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52713 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729311AbgFVPDR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jun 2020 11:03:17 -0400
Date: Mon, 22 Jun 2020 17:03:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v8 2/2] s390/kvm: diagnose 0x318 sync and reset
Message-ID: <20200622170303.5eee22db.cohuck@redhat.com>
In-Reply-To: <43967a50-a69c-face-805d-7cc935d3f230@de.ibm.com>
References: <20200618222222.23175-1-walling@linux.ibm.com>
        <20200618222222.23175-3-walling@linux.ibm.com>
        <20200622122456.781492a8.cohuck@redhat.com>
        <43967a50-a69c-face-805d-7cc935d3f230@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On Mon, 22 Jun 2020 16:50:41 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 22.06.20 12:24, Cornelia Huck wrote:
> > On Thu, 18 Jun 2020 18:22:22 -0400
> > Collin Walling <walling@linux.ibm.com> wrote:
> >   
> >> DIAGNOSE 0x318 (diag318) sets information regarding the environment
> >> the VM is running in (Linux, z/VM, etc) and is observed via
> >> firmware/service events.
> >>
> >> This is a privileged s390x instruction that must be intercepted by
> >> SIE. Userspace handles the instruction as well as migration. Data
> >> is communicated via VCPU register synchronization.
> >>
> >> The Control Program Name Code (CPNC) is stored in the SIE block. The
> >> CPNC along with the Control Program Version Code (CPVC) are stored
> >> in the kvm_vcpu_arch struct.
> >>
> >> The CPNC is shadowed/unshadowed in VSIE.
> >>
> >> This data is reset on load normal and clear resets.
> >>
> >> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> >> ---
> >>  arch/s390/include/asm/kvm_host.h |  4 +++-
> >>  arch/s390/include/uapi/asm/kvm.h |  5 ++++-
> >>  arch/s390/kvm/kvm-s390.c         | 11 ++++++++++-
> >>  arch/s390/kvm/vsie.c             |  3 +++
> >>  include/uapi/linux/kvm.h         |  1 +
> >>  5 files changed, 21 insertions(+), 3 deletions(-)
> >>  
> > 
> > (...)
> >   
> >> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >> index 4fdf30316582..35cdb4307904 100644
> >> --- a/include/uapi/linux/kvm.h
> >> +++ b/include/uapi/linux/kvm.h
> >> @@ -1031,6 +1031,7 @@ struct kvm_ppc_resize_hpt {
> >>  #define KVM_CAP_PPC_SECURE_GUEST 181
> >>  #define KVM_CAP_HALT_POLL 182
> >>  #define KVM_CAP_ASYNC_PF_INT 183
> >> +#define KVM_CAP_S390_DIAG318 184  
> > 
> > Do we strictly need this new cap, or would checking against the sync
> > regs capabilities be enough?  
> 
> We could check the sync_regs valid field to decide about the sync. We do
> that for ETOKEN as well and QEMU also uses it in handle_diag_318.
> 
> I think what this is used for is actually to tell the QEMU CPU model
> if this is there. And for that the sync_reg validity seems wrong. So better
> keep the CAP?
> 

Ok, makes sense.
