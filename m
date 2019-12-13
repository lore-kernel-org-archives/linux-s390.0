Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727619AbfLMOku (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Dec 2019 09:40:50 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDEYmiV028464
        for <linux-s390@vger.kernel.org>; Fri, 13 Dec 2019 09:40:49 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wuhsdttdb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 13 Dec 2019 09:40:49 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 13 Dec 2019 14:40:46 -0000
Subject: Re: [kvm-unit-tests PATCH v4 7/9] s390x: css: msch, enable test
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-8-git-send-email-pmorel@linux.ibm.com>
 <20191212130111.0f75fe7f.cohuck@redhat.com>
 <83d45c31-30c3-36e1-1d68-51b88448f4af@linux.ibm.com>
 <20191212151002.1c7ca4eb.cohuck@redhat.com>
 <c92089cf-39f4-3b64-79a8-3264654130b1@linux.ibm.com>
 <20191212153303.6444697e.cohuck@redhat.com>
 <a29048f4-1783-54c6-8bf3-91d573b2d49d@linux.ibm.com>
 <d34fdb07-c2ff-3a1e-eb31-cf9d160ebac9@linux.ibm.com>
 <20191213103346.1e42d52b.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 13 Dec 2019 15:40:42 +0100
MIME-Version: 1.0
In-Reply-To: <20191213103346.1e42d52b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cd625af6-c225-7871-bd74-bf52e22093ef@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-13 10:33, Cornelia Huck wrote:
> On Thu, 12 Dec 2019 18:33:15 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> After all, I make it simple by testing if the MSCH works as expected, no
>> retry, no delay.
>> This is just a test.
> 
> That's probably fine if you only run under kvm (not sure what your
> further plans here are).

If the test fails, it fails.

However, for other tests we need the enable to work.
For example before making a SENSE_ID, in this case we will make retries.



> 
>>
>> I will add a new patch to add a library function to enable the channel,
>> with retry to serve when we really need to enable the channel, not to test.
> 
> A simple enable should be enough for kvm-only usage, we can add a retry
> easily if needed.
> 
> We probably can also defer adding the library function until after we
> get another user :)
> 

I already work on it in the prepared next series, I have
- the enable test
and
- a enable_sch to use as a librairy function

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
