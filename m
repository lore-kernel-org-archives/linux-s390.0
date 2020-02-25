Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730466AbgBYOWY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 09:22:24 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PEM72d103149
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 09:22:23 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1qdug5c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 09:22:13 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Feb 2020 14:21:46 -0000
Subject: Re: [PATCH v4 20/36] KVM: s390/mm: handle guest unpin events
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-21-borntraeger@de.ibm.com>
 <20200225131838.2d68e7f9.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 25 Feb 2020 15:21:42 +0100
MIME-Version: 1.0
In-Reply-To: <20200225131838.2d68e7f9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <2c45d494-8fdf-69c1-e786-0f07c6f09a40@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>



On 25.02.20 13:18, Cornelia Huck wrote:
> On Mon, 24 Feb 2020 06:40:51 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>
>> The current code tries to first pin shared pages, if that fails (e.g.
>> because the page is not shared) it will export them. For shared pages
>> this means that we get a new intercept telling us that the guest is
>> unsharing that page. We will make the page secure at that point in time
>> and revoke the host access. This is synchronized with other host events,
>> e.g. the code will wait until host I/O has finished.
>>
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/intercept.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
>> index b6b7d4b0e26c..c06599939541 100644
>> --- a/arch/s390/kvm/intercept.c
>> +++ b/arch/s390/kvm/intercept.c
>> @@ -16,6 +16,7 @@
>>  #include <asm/asm-offsets.h>
>>  #include <asm/irq.h>
>>  #include <asm/sysinfo.h>
>> +#include <asm/uv.h>
>>  
>>  #include "kvm-s390.h"
>>  #include "gaccess.h"
>> @@ -484,12 +485,35 @@ static int handle_pv_sclp(struct kvm_vcpu *vcpu)
>>  	return 0;
>>  }
>>  
>> +static int handle_pv_uvc(struct kvm_vcpu *vcpu)
>> +{
>> +	struct uv_cb_share *guest_uvcb = (void *)vcpu->arch.sie_block->sidad;
>> +	struct uv_cb_cts uvcb = {
>> +		.header.cmd	= UVC_CMD_UNPIN_PAGE_SHARED,
>> +		.header.len	= sizeof(uvcb),
>> +		.guest_handle	= kvm_s390_pv_get_handle(vcpu->kvm),
>> +		.gaddr		= guest_uvcb->paddr,
>> +	};
>> +	int rc;
>> +
>> +	if (guest_uvcb->header.cmd != UVC_CMD_REMOVE_SHARED_ACCESS) {
>> +		WARN_ONCE(1, "Unexpected UVC 0x%x!\n", guest_uvcb->header.cmd);
> 
> "Unexpected notification intercept for UVC 0x%x"

ok.
> 
> ?
> 
>> +		return 0;
>> +	}
>> +	rc = gmap_make_secure(vcpu->arch.gmap, uvcb.gaddr, &uvcb);
>> +	if (rc == -EINVAL)
> 
> Add a comment why?

       /*
        * If the unpin did not succeed, the guest will exit again for the UVC
        * and we will retry the unpin.
        */



I will also fixup the misleading patch description:

The current code tries to first pin shared pages, if that fails (e.g.
because the page is not shared) it will export them. For shared pages
this means that we get a new intercept telling us that the guest is
unsharing that page. We will unpin the page at that point in time,
following the same rules as for make secure. (wait for writeback, no
elevated page refs etc).
