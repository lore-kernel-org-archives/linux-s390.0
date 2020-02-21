Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731560AbgBUIkQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 03:40:16 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L8cx59026235
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 03:40:15 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubqrh24-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 03:40:15 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 21 Feb 2020 08:40:13 -0000
Subject: Re: [PATCH v3 09/37] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-10-borntraeger@de.ibm.com>
 <1f0c2c5a-5964-dc34-73af-7b1776391276@redhat.com>
 <b9aa96ce-9701-cefb-68d8-76d1cba4d5c7@de.ibm.com>
 <abcad458-ff2d-2ec0-6a3c-f4491336d743@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 21 Feb 2020 09:40:05 +0100
MIME-Version: 1.0
In-Reply-To: <abcad458-ff2d-2ec0-6a3c-f4491336d743@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <947e04fa-d5d3-f352-3b58-766dd463bfd9@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 21.02.20 09:22, David Hildenbrand wrote:
>>>> +
>>>> +		break;
>>>> +	}
>>>> +	case KVM_PV_DISABLE: {
>>>> +		r = -EINVAL;
>>>> +		if (!kvm_s390_pv_is_protected(kvm))
>>>> +			break;
>>>> +
>>>> +		kvm_s390_cpus_from_pv(kvm, &cmd->rc, &cmd->rrc);
>>>> +		r = kvm_s390_pv_destroy_vm(kvm, &cmd->rc, &cmd->rrc);
>>>> +		if (!r)
>>>> +			kvm_s390_pv_dealloc_vm(kvm);
>>>
>>> Hm, if destroy fails, the CPUs would already have been removed.
>>>
>>> Is there a way to make kvm_s390_pv_destroy_vm() never fail? The return
>>> value is always ignored except here ... which looks wrong.
>>
>> This should not fail. But if it does we should not free the memory that
>> we donated to the ultravisor. We then do have a memory leak, but this is 
>> necessary to keep the integrity of the host. 
>> I will fix the other places to only call dealloc when destroy succeeded.
>>
>> Same for VCPU destroy. If that fails I should not free arch.pv.stor_base
>> will fix.
> 
> A comment would be nice, documenting exactly that.


something like this on top:

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 738f7fefcaec..cad04e26dccf 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2173,6 +2173,11 @@ static void kvm_s390_cpus_from_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
        struct kvm_vcpu *vcpu;
        int i;
 
+       /*
+        * we ignore failures and try to destroy as many CPUs as possible.
+        * At the same time we must not free the assigned ressources when
+        * this fails, as the ultravisor has still access to that memory.
+        */
        kvm_for_each_vcpu(i, vcpu, kvm) {
                mutex_lock(&vcpu->mutex);
                kvm_s390_pv_destroy_cpu(vcpu, rc, rrc);
@@ -2221,6 +2226,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
                        kvm_s390_pv_dealloc_vm(kvm);
                        break;
                }
+               /* we never switch back to bsca from esca */
                r = kvm_s390_pv_create_vm(kvm, &cmd->rc, &cmd->rrc);
                if (r) {
                        kvm_s390_pv_dealloc_vm(kvm);
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 6b581b5f8521..f93811a0a441 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -16,6 +16,7 @@
 #include <asm/mman.h>
 #include "kvm-s390.h"
 
+/* only free ressources when the destroy was successful */
 void kvm_s390_pv_dealloc_vm(struct kvm *kvm)
 {
        vfree(kvm->arch.pv.stor_var);
@@ -62,6 +63,7 @@ int kvm_s390_pv_alloc_vm(struct kvm *kvm)
        return -ENOMEM;
 }
 
+/* this should not fail, but if it does we must not free the donated memory */
 int kvm_s390_pv_destroy_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
 {
        int cc;
