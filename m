Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43815 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727274AbgBTKxL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 20 Feb 2020 05:53:11 -0500
Subject: Re: [PATCH v2 31/42] KVM: s390: protvirt: Report CPU state to
 Ultravisor
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-32-borntraeger@de.ibm.com>
 <33cffbe7-9d87-d94f-dc56-6d31ea2e56eb@redhat.com>
 <7e74ad84-b0ae-9dc1-91cc-52be989d6c34@de.ibm.com>
 <95f7cd6a-c8d4-a119-d87e-7b25929e0b5c@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <10c4673e-120c-2cce-73ab-9f96ca1a4e1a@redhat.com>
Date: Thu, 20 Feb 2020 11:52:58 +0100
MIME-Version: 1.0
In-Reply-To: <95f7cd6a-c8d4-a119-d87e-7b25929e0b5c@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 19.02.20 20:46, Christian Borntraeger wrote:
> I could add a comment to all other users of kvm_s390_vcpu_start/stop like
> 
> 
>         /*
>          * no need to check the return value of vcpu_stop as it can only have
>          * an error for protvirt, but protvirt means user cpu state
>          */
>         if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
>                 kvm_s390_vcpu_stop(vcpu);
> 
> 
> to make clear why we do not check the return everywhere
> 

Makes sense!

-- 
Thanks,

David / dhildenb
