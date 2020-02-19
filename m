Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49874 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBSIcP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 19 Feb 2020 03:32:15 -0500
Subject: Re: [PATCH v2.1] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200214222658.12946-10-borntraeger@de.ibm.com>
 <20200218083946.44720-1-borntraeger@de.ibm.com>
 <42deaa19-d2ca-f1cc-3e83-af0d5d77347f@redhat.com>
 <f6bc712e-44b0-233e-886f-c72485ea13c3@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <189b779d-c74d-5622-3c07-2b6db694de97@redhat.com>
Date: Wed, 19 Feb 2020 09:32:04 +0100
MIME-Version: 1.0
In-Reply-To: <f6bc712e-44b0-233e-886f-c72485ea13c3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Ulrich.Weigand@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

>>
>>> +	return r;
>>> +}
>>> +
>>> +static int kvm_s390_switch_to_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
>>> +{
>>> +	int i, r = 0;
>>> +	u16 dummy;
>>> +
>>> +	struct kvm_vcpu *vcpu;
>>> +
>>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>>> +		mutex_lock(&vcpu->mutex);
>>> +		r = kvm_s390_pv_create_cpu(vcpu, rc, rrc);
>>> +		mutex_unlock(&vcpu->mutex);
>>> +		if (r)
>>> +			break;
>>> +	}
>>> +	if (r)
>>> +		kvm_s390_switch_from_pv(kvm,&dummy, &dummy);
>>> +	return r;
>>> +}
>>> +
>>> +static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>>> +{
>>> +	int r = 0;
>>> +	u16 dummy;
>>> +	void __user *argp = (void __user *)cmd->data;
>>> +
>>> +	switch (cmd->cmd) {
>>> +	case KVM_PV_ENABLE: {
>>> +		r = -EINVAL;
>>> +		if (kvm_s390_pv_is_protected(kvm))
>>> +			break;
>>
>> Why not factor out this check, it's common for all sucommands.
> 
> Unfortunately it is not common. Sometimes it has an "!" sometimes not.

Right, makes sense.


-- 
Thanks,

David / dhildenb
