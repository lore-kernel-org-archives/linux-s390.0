Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727327AbgBZINC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Feb 2020 03:13:02 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q8ASJr044977
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 03:13:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydcp4d732-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 03:13:01 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 26 Feb 2020 08:12:59 -0000
Subject: Re: [PATCH v4.5 09/36] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <f80a0b58-5ed2-33b7-5292-2c4899d765b7@redhat.com>
 <20200225214822.3611-1-borntraeger@de.ibm.com>
 <a8bf1afc-8afe-a704-32f6-b20ed2f3a54c@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Feb 2020 09:12:52 +0100
MIME-Version: 1.0
In-Reply-To: <a8bf1afc-8afe-a704-32f6-b20ed2f3a54c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <8ac08255-f830-934d-1e91-d26b2cbe99f5@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Ulrich.Weigand@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com



On 25.02.20 23:37, David Hildenbrand wrote:
> 
>> +static int kvm_s390_pv_alloc_vm(struct kvm *kvm)
>> +{
>> +	unsigned long base = uv_info.guest_base_stor_len;
>> +	unsigned long virt = uv_info.guest_virt_var_stor_len;
>> +	unsigned long npages = 0, vlen = 0;
>> +	struct kvm_memory_slot *memslot;
>> +
>> +	kvm->arch.pv.stor_var = NULL;
>> +	kvm->arch.pv.stor_base = __get_free_pages(GFP_KERNEL, get_order(base));
>> +	if (!kvm->arch.pv.stor_base)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Calculate current guest storage for allocation of the
>> +	 * variable storage, which is based on the length in MB.
>> +	 *
>> +	 * Slots are sorted by GFN
>> +	 */
>> +	mutex_lock(&kvm->slots_lock);
>> +	memslot = kvm_memslots(kvm)->memslots;
>> +	npages = memslot->base_gfn + memslot->npages;
>> +	mutex_unlock(&kvm->slots_lock);
> 
> As discussed, I think we should just use mem_limit and check against
> some hardcoded upper limit. But yeah, we can do that as an addon (in
> which case memory hotplug will require special tweaks to detect this
> from user space ... e.g., a new capability)
> 
> 
> [...]
> 
>> +int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
>> +{
>> +		struct uv_cb_cgc uvcb = {
>> +		.header.cmd = UVC_CMD_CREATE_SEC_CONF,
>> +		.header.len = sizeof(uvcb)
>> +	};
>> +	int cc, ret;
>> +	u16 dummy;
>> +
>> +	ret = kvm_s390_pv_alloc_vm(kvm);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Inputs */
>> +	uvcb.guest_stor_origin = 0; /* MSO is 0 for KVM */
>> +	uvcb.guest_stor_len = kvm->arch.pv.guest_len;
>> +	uvcb.guest_asce = kvm->arch.gmap->asce;
>> +	uvcb.guest_sca = (unsigned long)kvm->arch.sca;
>> +	uvcb.conf_base_stor_origin = (u64)kvm->arch.pv.stor_base;
>> +	uvcb.conf_virt_stor_origin = (u64)kvm->arch.pv.stor_var;
>> +
>> +	cc = uv_call(0, (u64)&uvcb);
>> +	*rc = uvcb.header.rc;
>> +	*rrc = uvcb.header.rrc;
>> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT CREATE VM: handle %llx len %llx rc %x rrc %x",
>> +		     uvcb.guest_handle, uvcb.guest_stor_len, *rc, *rrc);
>> +
>> +	/* Outputs */
>> +	kvm->arch.pv.handle = uvcb.guest_handle;
>> +
>> +	if (cc) {
>> +		if (uvcb.header.rc & UVC_RC_NEED_DESTROY)
>> +			kvm_s390_pv_deinit_vm(kvm, &dummy, &dummy);
>> +		else
>> +			kvm_s390_pv_dealloc_vm(kvm);
>> +		return -EIO;
> 
> A lot easier to read :)
> 
> 
> Fell free add my rb with or without the mem_limit change.

I think I will keep the memslot logic. For hotplug we actually need
to notify the ultravisor that the guest size has changed as only the
ultravisor will be able to inject an addressing exception.

Lets keep it simple for now 

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

thanks for all the good review. Code looks much better now :-)
