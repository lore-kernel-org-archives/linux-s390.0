Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgBJIpm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 03:45:42 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01A8dX1k036843
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 03:45:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tpb5xjx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 03:45:40 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 08:45:38 -0000
Subject: Re: [PATCH 28/35] KVM: s390: protvirt: UV calls diag308 0, 1
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-29-borntraeger@de.ibm.com>
 <bc9b1c4f-af9f-8859-79b7-ed232cfd5f6e@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 09:45:34 +0100
MIME-Version: 1.0
In-Reply-To: <bc9b1c4f-af9f-8859-79b7-ed232cfd5f6e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f1249641-812b-174b-848b-c6082534c556@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 09.02.20 17:03, Thomas Huth wrote:
> On 07/02/2020 12.39, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> diag 308 subcode 0 and 1 require KVM and Ultravisor interaction, since
>> the cpus have to be set into multiple reset states.
>>
>> * All cpus need to be stopped
>> * The "unshare all" UVC needs to be executed
>> * The "perform reset" UVC needs to be executed
>> * The cpus need to be reset via the "set cpu state" UVC
>> * The issuing cpu needs to set state 5 via "set cpu state"
> 
> Is the patch description still accurate here? The patch seems mostly
> about adding two new UVCs, and not really about diag 308 ... ?

Yes, this patch seems a bit unordered, I messed that one up.
I will keep the UNSHARE_ALL and the  KVM_PV_VM_PREP_RESET things
as we call both for diag 308 subcode 0 and 1 (kexec and kdump)

Everything else belongs in other patches. 
Will move and improve the patch description.

> 
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
> [...]
>> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
>> index 3fb54ec2cf3e..390830385b9f 100644
>> --- a/arch/s390/kvm/diag.c
>> +++ b/arch/s390/kvm/diag.c
>> @@ -13,6 +13,7 @@
>>  #include <asm/pgalloc.h>
>>  #include <asm/gmap.h>
>>  #include <asm/virtio-ccw.h>
>> +#include <asm/uv.h>
>>  #include "kvm-s390.h"
>>  #include "trace.h"
>>  #include "trace-s390.h"
> 
> This single change to diag.c looks like it could either be removed, or
> the hunk should belong to another patch.
> 
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 4afa44e3d1ed..0be18ac1afb5 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
> 
>  Thomas
> 
