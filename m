Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbfFZOaO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jun 2019 10:30:14 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QEStZo006707
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 10:30:13 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tc8uhmu15-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 10:30:13 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <walling@linux.ibm.com>;
        Wed, 26 Jun 2019 15:30:12 +0100
Subject: Re: [PATCH v5 2/2] s390/kvm: diagnose 318 handling
References: <1561475022-18348-1-git-send-email-walling@linux.ibm.com>
 <1561475022-18348-3-git-send-email-walling@linux.ibm.com>
 <19c73246-48dd-ddc6-c5b1-b93f15cbf2f0@redhat.com>
 <17fe3423-91b1-2351-54cb-26cd9e1b0e3f@de.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 26 Jun 2019 10:30:08 -0400
MIME-Version: 1.0
In-Reply-To: <17fe3423-91b1-2351-54cb-26cd9e1b0e3f@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dd1f4c39-9937-b223-adc8-01a764cf9462@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, cohuck@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org

On 6/26/19 6:28 AM, Christian Borntraeger wrote:
> 
> 
> On 26.06.19 11:45, David Hildenbrand wrote:
> 
>>
>> BTW. there is currently no mechanism to fake absence of diag318. Should
>> we have one? (in contrast, for CMMA we have, which is also a CPU feature)
> 
> Yes, we want to be able to disable diag318 via a CPU model feature. That actually
> means that the kernel must not answer this if we disable it.
> 
Correct. If the guest specifies diag318=off, then the instruction 
shouldn't be executed (it is fenced off in the kernel by checking the 
Read SCP Info bit).
