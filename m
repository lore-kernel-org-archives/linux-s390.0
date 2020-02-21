Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727876AbgBUNDx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 08:03:53 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LD0A7J016678
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 08:03:52 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yafh8rh87-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 08:03:51 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 21 Feb 2020 13:03:49 -0000
Subject: Re: [PATCH v3.1 09/37] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <b9aa96ce-9701-cefb-68d8-76d1cba4d5c7@de.ibm.com>
 <20200221080742.10233-1-borntraeger@de.ibm.com>
 <08f6ad60-1046-f281-ce81-539f2c967f30@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 21 Feb 2020 14:03:41 +0100
MIME-Version: 1.0
In-Reply-To: <08f6ad60-1046-f281-ce81-539f2c967f30@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ddff81cb-180b-5b7e-1e13-f0a01f121b75@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Ulrich.Weigand@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com



On 21.02.20 12:45, David Hildenbrand wrote:
> 
>> +static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>> +{
>> +	int r = 0;
>> +	u16 dummy;
>> +	void __user *argp = (void __user *)cmd->data;
>> +
>> +	switch (cmd->cmd) {
>> +	case KVM_PV_ENABLE: {
>> +		r = -EINVAL;
>> +		if (kvm_s390_pv_is_protected(kvm))
>> +			break;
>> +
>> +		r = kvm_s390_pv_alloc_vm(kvm);
>> +		if (r)
>> +			break;
>> +
> 
> To make this nicer, can we simply merge alloc+create into init
> 
> 	/* FMT 4 SIE needs esca */
> 	r = sca_switch_to_extended(kvm);
> 	if (r)
> 		break;
> 	
> 	r = kvm_s390_pv_init_vm();
> 	if (r)
> 		break;
> 
> 	r = kvm_s390_cpus_to_pv(kvm, &cmd->rc, &cmd->rrc);
> 	if (r)
> 		kvm_s390_pv_deinit_vm();
> 	break;
> 
> I remember the split dates back to an earlier UAPI interface.
> 
> Similarly from deinit.
> 
> The you can just make deinit never fail and handle that freeing
> special-case in there and add a comment.

We want to tell userspace that PV_DISABLE failed, so I need the return.
But I can still simplify things a bit.
Will send an 3.2. I still have the alloc/dealloc as static helpers inside
pv.c
