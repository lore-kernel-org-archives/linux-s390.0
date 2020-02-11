Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728656AbgBKNAa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Feb 2020 08:00:30 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BD0JP2008866
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 08:00:29 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y3pqfcsyn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 08:00:26 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 11 Feb 2020 12:59:41 -0000
Subject: Re: [PATCH 25/35] KVM: s390: protvirt: Only sync fmt4 registers
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-26-borntraeger@de.ibm.com>
 <20200211115117.33a2e3a5.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 11 Feb 2020 13:59:35 +0100
MIME-Version: 1.0
In-Reply-To: <20200211115117.33a2e3a5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <fbbe8d21-2334-469a-a1b0-34338f405e60@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 11.02.20 11:51, Cornelia Huck wrote:
> On Fri,  7 Feb 2020 06:39:48 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> +static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>> +{
>> +	/*
>> +	 * at several places we have to modify our internal view to not do
> 
> s/at/In/ ?

ack

> 
>> +	 * things that are disallowed by the ultravisor. For example we must
>> +	 * not inject interrupts after specific exits (e.g. 112). We do this
> 
> Spell out what 112 is?

ack.
> 
>> +	 * by turning off the MIE bits of our PSW copy. To avoid getting
> 
> And also spell out what MIE is?

ack
> 
>> +	 * validity intercepts, we do only accept the condition code from
>> +	 * userspace.
>> +	 */
> 
