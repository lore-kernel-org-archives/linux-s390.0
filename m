Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgBGPED (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 10:04:03 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017EsNTj128120
        for <linux-s390@vger.kernel.org>; Fri, 7 Feb 2020 10:04:02 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0nngc0uj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 07 Feb 2020 10:04:01 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 7 Feb 2020 15:03:59 -0000
Subject: Re: [PATCH 07/35] KVM: s390: add new variants of UV CALL
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-8-borntraeger@de.ibm.com>
 <e387472b-4417-9079-2df2-8f6f1689093e@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 7 Feb 2020 16:03:53 +0100
MIME-Version: 1.0
In-Reply-To: <e387472b-4417-9079-2df2-8f6f1689093e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <c3895c9a-c616-e5f0-4bea-488a9ae636c3@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>




On 07.02.20 15:34, Thomas Huth wrote:
[...]

+static inline int uv_call_sched(unsigned long r1, unsigned long r2)
>> +{
>> +	int cc;
>> +
>> +	do {
>> +		asm volatile(
>> +			"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
>> +			"		ipm	%[cc]\n"
>> +			"		srl	%[cc],28\n"
> 
> Maybe remove one TAB before "ipm" and "srl" ?

ack
> 
> Apart from that, patch looks fine to me now.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
