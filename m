Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728191AbgBQLNl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 06:13:41 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HB9JZZ129161
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 06:13:40 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6af2wg90-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 06:13:40 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 17 Feb 2020 11:13:38 -0000
Subject: Re: [PATCH v2 04/42] s390/protvirt: add ultravisor initialization
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-5-borntraeger@de.ibm.com>
 <ad934492-afcb-7a11-c682-6884e5c0ffed@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Feb 2020 12:13:34 +0100
MIME-Version: 1.0
In-Reply-To: <ad934492-afcb-7a11-c682-6884e5c0ffed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <335c794f-e6d9-18bb-170e-e1e4e2350da6@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>



On 17.02.20 10:57, David Hildenbrand wrote:
t setup_uv(void)
>> +{
>> +	unsigned long uv_stor_base;
>> +
>> +	if (!prot_virt_host)
>> +		return;
> 
> That can go.

ack.
> 
>> +
>> +	uv_stor_base = (unsigned long)memblock_alloc_try_nid(
>> +		uv_info.uv_base_stor_len, SZ_1M, SZ_2G,
>> +		MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
