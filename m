Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729074AbgBNKdz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 05:33:55 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EAP3AG016659
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 05:33:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4qyu1hat-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 05:33:54 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 14 Feb 2020 10:33:52 -0000
Subject: Re: [PATCH 04/35] s390/protvirt: add ultravisor initialization
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-5-borntraeger@de.ibm.com>
 <44aa351c-2333-e1df-42ce-6cf3a6808802@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Feb 2020 11:33:48 +0100
MIME-Version: 1.0
In-Reply-To: <44aa351c-2333-e1df-42ce-6cf3a6808802@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <81e4d5a1-ec8a-4de8-e136-8e61ad1fc788@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>



On 14.02.20 11:25, David Hildenbrand wrote:
> [...]
> 
>>  #if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) ||                          \
>> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
>> index f2ab2528859f..5f178d557cc8 100644
>> --- a/arch/s390/kernel/setup.c
>> +++ b/arch/s390/kernel/setup.c
>> @@ -560,6 +560,8 @@ static void __init setup_memory_end(void)
>>  			vmax = _REGION1_SIZE; /* 4-level kernel page table */
>>  	}
>>  
>> +	adjust_to_uv_max(&vmax);
> 
> I'd somewhat prefer
> 
> if (prot_virt_host)
> 	adjust_to_uv_max(&vmax);
> 
>> +

fine with me. ack

>>  	/* module area is at the end of the kernel address space. */
>>  	MODULES_END = vmax;
>>  	MODULES_VADDR = MODULES_END - MODULES_LEN;
>> @@ -1140,6 +1142,7 @@ void __init setup_arch(char **cmdline_p)
>>  	 */
>>  	memblock_trim_memory(1UL << (MAX_ORDER - 1 + PAGE_SHIFT));
>>  
>> +	setup_uv();
> 
> and
> 
> if (prot_virt_host)
> 	setup_uv();

ack
> 
> Moving the checks out of the functions. Makes it clearer that this is
> optional.
> 
>>  	setup_memory_end();
>>  	setup_memory();
>>  	dma_contiguous_reserve(memory_end);
>> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
>> index fbf2a98de642..a06a628a88da 100644
>> --- a/arch/s390/kernel/uv.c
>> +++ b/arch/s390/kernel/uv.c
>> @@ -46,4 +46,57 @@ static int __init prot_virt_setup(char *val)
>>  	return rc;
>>  }
>>  early_param("prot_virt", prot_virt_setup);
>> +
>> +static int __init uv_init(unsigned long stor_base, unsigned long stor_len)
>> +{
>> +	struct uv_cb_init uvcb = {
>> +		.header.cmd = UVC_CMD_INIT_UV,
>> +		.header.len = sizeof(uvcb),
>> +		.stor_origin = stor_base,
>> +		.stor_len = stor_len,
>> +	};
>> +	int cc;
>> +
>> +	cc = uv_call(0, (uint64_t)&uvcb);
> 
> Could do
> 
> int cc = uv_call(0, (uint64_t)&uvcb);

I could actually get rid of the cc and the comparison with UVC_RC_EXECUTED.
When the condition code is 0, rc must be 1.

Something like
	if (uv_call(0,.....

> 
>> +	if (cc || uvcb.header.rc != UVC_RC_EXECUTED) {
>> +		pr_err("Ultravisor init failed with cc: %d rc: 0x%hx\n", cc,
>> +		       uvcb.header.rc);
>> +		return -1;
>> +	}
>> +	return 0;
>> +}
>> +
>> +void __init setup_uv(void)
>> +{
>> +	unsigned long uv_stor_base;
>> +
>> +	if (!prot_virt_host)
>> +		return;
>> +
>> +	uv_stor_base = (unsigned long)memblock_alloc_try_nid(
>> +		uv_info.uv_base_stor_len, SZ_1M, SZ_2G,
>> +		MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
>> +	if (!uv_stor_base) {
>> +		pr_info("Failed to reserve %lu bytes for ultravisor base storage\n",
>> +			uv_info.uv_base_stor_len);
> 
> pr_err() ? pr_warn()

ack.


> 
>> +		goto fail;
>> +	}
>> +
>> +	if (uv_init(uv_stor_base, uv_info.uv_base_stor_len)) {
>> +		memblock_free(uv_stor_base, uv_info.uv_base_stor_len);
>> +		goto fail;
>> +	}
>> +
>> +	pr_info("Reserving %luMB as ultravisor base storage\n",
>> +		uv_info.uv_base_stor_len >> 20);
>> +	return;
>> +fail:
> 
> I'd add here:
> 
> pr_info("Disabling support for protected virtualization");

ack

> 
>> +	prot_virt_host = 0;> +}
>> +
>> +void adjust_to_uv_max(unsigned long *vmax)
>> +{
>> +	if (prot_virt_host && *vmax > uv_info.max_sec_stor_addr)
>> +		*vmax = uv_info.max_sec_stor_addr;
> 
> Once you move the prot virt check out of this function


> 
> 	*vmax = max_t(unsigned long, *vmax, uv_info.max_sec_stor_addr);

ack
> 
>> +}
>>  #endif
>>
> 
> 
