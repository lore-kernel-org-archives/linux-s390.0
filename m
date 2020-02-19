Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726771AbgBSMpz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Feb 2020 07:45:55 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JCiKbC018027
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 07:45:53 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8xdnecu1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 07:45:53 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 19 Feb 2020 12:45:51 -0000
Subject: Re: [PATCH v2 29/42] KVM: s390: protvirt: Add diag 308 subcode 8 - 10
 handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-30-borntraeger@de.ibm.com>
 <9e5e7409-aaa2-47af-812f-169c2d290e18@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Feb 2020 13:45:45 +0100
MIME-Version: 1.0
In-Reply-To: <9e5e7409-aaa2-47af-812f-169c2d290e18@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1ff8a25b-6998-b88f-763e-71f6db08c3fe@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 18.02.20 10:38, David Hildenbrand wrote:
[...]

set_kvm_facility(kvm->arch.model.fac_mask, 65);
>>  
>> +	if (is_prot_virt_host()) {
>> +		set_kvm_facility(kvm->arch.model.fac_mask, 161);
>> +		set_kvm_facility(kvm->arch.model.fac_list, 161);
>> +	}
>> +
> 
> Aren't these IPL subcodes completely emulated in QEMU? If so, rather
> QEMU with support should enable them when the kernel capability for PV
> (=== is_prot_virt_host()) is in place.

ack. will drop this patch.
