Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgINIXT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Sep 2020 04:23:19 -0400
Subject: Re: [PATCH v1 2/3] s390: define UV compatible I/O allocation
References: <1598875533-19947-1-git-send-email-pmorel@linux.ibm.com>
 <1598875533-19947-3-git-send-email-pmorel@linux.ibm.com>
 <20200911144058.5fe82f26.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <4e09343a-6eed-7270-2157-dc65f4fb47aa@linux.ibm.com>
Date: Mon, 14 Sep 2020 10:23:12 +0200
MIME-Version: 1.0
In-Reply-To: <20200911144058.5fe82f26.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-09-11 14:40, Cornelia Huck wrote:
> On Mon, 31 Aug 2020 14:05:32 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> To centralize the memory allocation for I/O we define
>> the alloc/free_io_page() functions which share the I/O
>> memory with the host in case the guest runs with
>> protected virtualization.

...

>> +
>> +void *alloc_io_page(int size)
>> +{
>> +	void *p;
>> +
>> +	assert(size <= PAGE_SIZE);
>> +	p = alloc_page();
> 
> I see that you use this for some I/O structures in the next patch. Is
> this guaranteed to be under 2G all the time?
> 

Good catch.
I forgot that I already worked on this problem a while ago, I will 
rework the allocation.

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
