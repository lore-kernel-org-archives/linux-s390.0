Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbfF0ME3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jun 2019 08:04:29 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RBwD6B058132
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 08:04:28 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcvwjsqy2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 08:04:27 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 27 Jun 2019 13:04:25 +0100
Date: Thu, 27 Jun 2019 14:04:19 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v9 4/4] s390: ap: kvm: Enable PQAP/AQIC facility for the
 guest
In-Reply-To: <69ca50bd-3f5c-98b1-3b39-04af75151baf@de.ibm.com>
References: <1558452877-27822-1-git-send-email-pmorel@linux.ibm.com>
        <1558452877-27822-5-git-send-email-pmorel@linux.ibm.com>
        <69ca50bd-3f5c-98b1-3b39-04af75151baf@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190627140419.1df5f519.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com

On Tue, 25 Jun 2019 22:13:12 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> 
> 
> On 21.05.19 17:34, Pierre Morel wrote:
> > AP Queue Interruption Control (AQIC) facility gives
> > the guest the possibility to control interruption for
> > the Cryptographic Adjunct Processor queues.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> > ---
> >  arch/s390/tools/gen_facilities.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> > index 61ce5b5..aed14fc 100644
> > --- a/arch/s390/tools/gen_facilities.c
> > +++ b/arch/s390/tools/gen_facilities.c
> > @@ -114,6 +114,7 @@ static struct facility_def facility_defs[] = {
> >  		.bits = (int[]){
> >  			12, /* AP Query Configuration Information */
> >  			15, /* AP Facilities Test */
> > +			65, /* AP Queue Interruption Control */
> >  			156, /* etoken facility */
> >  			-1  /* END */
> >  		}
> > 
> 
> I think we should only set stfle.65 if we have the aiv facility (Because we do not
> have a GISA otherwise)
> 
> So something like this instead?
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 28ebd64..1501cd6 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2461,6 +2461,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>                 set_kvm_facility(kvm->arch.model.fac_list, 147);
>         }
>  
> +       if (css_general_characteristics.aiv)
> +               set_kvm_facility(kvm->arch.model.fac_mask, 65);
> +       
>         kvm->arch.model.cpuid = kvm_s390_get_initial_cpuid();
>         kvm->arch.model.ibc = sclp.ibc & 0x0fff;

I will go with this option because it is more readable (easier to find)
IMHO. Will also add a chech for host sltfle.65. So I end up with:

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 28ebd647784c..1c4113f0f2a8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2461,6 +2461,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
                set_kvm_facility(kvm->arch.model.fac_list, 147);
        }
 
+       if (css_general_characteristics.aiv && test_facility(65))
+               set_kvm_facility(kvm->arch.model.fac_mask, 65);
+
        kvm->arch.model.cpuid = kvm_s390_get_initial_cpuid();
        kvm->arch.model.ibc = sclp.ibc & 0x0fff;
 
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index d52f537b7169..cead9e0dcffb 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -111,7 +111,6 @@ static struct facility_def facility_defs[] = {
                .bits = (int[]){
                        12, /* AP Query Configuration Information */
                        15, /* AP Facilities Test */
-                       65, /* AP Queue Interruption Control */
                        156, /* etoken facility */
                        -1  /* END */
