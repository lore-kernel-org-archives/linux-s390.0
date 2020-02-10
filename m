Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729788AbgBJMy7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 07:54:59 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ACnIQi043509
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 07:54:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u9nw7p5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 07:54:57 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 12:54:56 -0000
Subject: Re: [PATCH 03/35] s390/protvirt: introduce host side setup
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-4-borntraeger@de.ibm.com>
 <ad0d8be2-7af8-d195-ba08-157a649a9ab1@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 13:54:51 +0100
MIME-Version: 1.0
In-Reply-To: <ad0d8be2-7af8-d195-ba08-157a649a9ab1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <af6b0234-c9c8-fdf2-40ea-36621ee5eb44@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>



On 10.02.20 13:38, David Hildenbrand wrote:

>> +		pr_info("Running as protected virtualization guest.");
> 
> /me confused about gluing an informative message to disabling a feature.
> 
> Should this actually be a
> 
> pr_warn("Protected virtualization not available in protected guests.");

Yes, this is probably better.

> 
>> +	}
>> +
>> +	if (prot_virt_host && !test_facility(158)) {
>> +		prot_virt_host = 0;
>> +		pr_info("The ultravisor call facility is not available.");
> 
> It's somehwhat confusing for a user to requested "prot_virt" and get
> that error message.
> 
> pr_warn("Protected virtualization not supported by the hardware".);


The name is still in flux, but we can change that later on. Will use your 
variant.
