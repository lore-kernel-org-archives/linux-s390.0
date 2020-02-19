Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726548AbgBSLxX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Feb 2020 06:53:23 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JBp8O0113700
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 06:53:21 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubn9csy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 06:53:21 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 19 Feb 2020 11:53:19 -0000
Subject: Re: [PATCH v2 30/42] KVM: s390: protvirt: UV calls in support of
 diag308 0, 1
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-31-borntraeger@de.ibm.com>
 <53a04585-b49c-6b61-5439-9624bd46d3f0@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Feb 2020 12:53:12 +0100
MIME-Version: 1.0
In-Reply-To: <53a04585-b49c-6b61-5439-9624bd46d3f0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <0a09a062-3b3f-172c-f82d-0ac2bed7ff94@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 18.02.20 10:44, David Hildenbrand wrote:
> On 14.02.20 23:26, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> diag 308 subcode 0 and 1 require several KVM and Ultravisor interactions.
>> Specific to these "soft" reboots are
>>
>> * The "unshare all" UVC
>> * The "prepare for reset" UVC
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/uv.h |  4 ++++
>>  arch/s390/kvm/kvm-s390.c   | 22 ++++++++++++++++++++++
>>  include/uapi/linux/kvm.h   |  2 ++
>>  3 files changed, 28 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index 839cb3a89986..254d5769d136 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -36,6 +36,8 @@
>>  #define UVC_CMD_SET_SEC_CONF_PARAMS	0x0300
>>  #define UVC_CMD_UNPACK_IMG		0x0301
>>  #define UVC_CMD_VERIFY_IMG		0x0302
>> +#define UVC_CMD_PREPARE_RESET		0x0320
>> +#define UVC_CMD_SET_UNSHARE_ALL		0x0340
>>  #define UVC_CMD_PIN_PAGE_SHARED		0x0341
>>  #define UVC_CMD_UNPIN_PAGE_SHARED	0x0342
>>  #define UVC_CMD_SET_SHARED_ACCESS	0x1000
>> @@ -56,6 +58,8 @@ enum uv_cmds_inst {
>>  	BIT_UVC_CMD_SET_SEC_PARMS = 11,
>>  	BIT_UVC_CMD_UNPACK_IMG = 13,
>>  	BIT_UVC_CMD_VERIFY_IMG = 14,
>> +	BIT_UVC_CMD_PREPARE_RESET = 18,
>> +	BIT_UVC_CMD_UNSHARE_ALL = 20,
>>  	BIT_UVC_CMD_PIN_PAGE_SHARED = 21,
>>  	BIT_UVC_CMD_UNPIN_PAGE_SHARED = 22,
>>  };
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index f96c1f530cc2..ad84c1144908 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2285,6 +2285,28 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>>  			     cmd->rrc);
>>  		break;
>>  	}
>> +	case KVM_PV_VM_PREP_RESET: {
>> +		r = -EINVAL;
>> +		if (!kvm_s390_pv_is_protected(kvm))
>> +			break;
>> +
>> +		r = uv_cmd_nodata(kvm_s390_pv_handle(kvm),
>> +				  UVC_CMD_PREPARE_RESET, &cmd->rc, &cmd->rrc);
>> +		KVM_UV_EVENT(kvm, 3, "PROTVIRT PREP RESET: rc %x rrc %x",
>> +			     cmd->rc, cmd->rrc);
>> +		break;
>> +	}
>> +	case KVM_PV_VM_UNSHARE_ALL: {
>> +		r = -EINVAL;
>> +		if (!kvm_s390_pv_is_protected(kvm))
>> +			break;
>> +
>> +		r = uv_cmd_nodata(kvm_s390_pv_handle(kvm),
>> +				  UVC_CMD_SET_UNSHARE_ALL, &cmd->rc, &cmd->rrc);
>> +		KVM_UV_EVENT(kvm, 3, "PROTVIRT UNSHARE: rc %x rrc %x",
>> +			     cmd->rc, cmd->rrc);
> 
> I do wonder if that has any possible races with CPUs currently running,
> which try to mark pages shared. That no other VCPUs are running is not
> enforced here AFAIKs.

The only concern would be that the newly bootet guest (e.g. via kexec/kdump) will
have pages shared that it dont want to share. As it is the responsiblity of the
ultravisor to prevent data leakage, it is enforced that we do an UNSHARE all on 
diag 308 subcode 0 and 1. At the same time the ultravisor will enforce that no
CPU will run before we have finished  the full dance of reset activity.  (The 
ultravisor must guarantee guest secrecy and integrity no matter what KVM does). 

> 
> Apart from that, looks good to me.
> 
