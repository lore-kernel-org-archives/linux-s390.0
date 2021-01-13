Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbhAMMQT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 07:16:19 -0500
Subject: Re: [kvm-unit-tests PATCH v4 4/9] s390x: Split assembly into multiple
 files
References: <20210112132054.49756-1-frankja@linux.ibm.com>
 <20210112132054.49756-5-frankja@linux.ibm.com>
 <c07280f6-f56c-ea6c-1255-28a36a2385c0@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <fce05f26-8cdb-009d-a88d-c799c3784506@linux.ibm.com>
Date: Wed, 13 Jan 2021 13:15:32 +0100
MIME-Version: 1.0
In-Reply-To: <c07280f6-f56c-ea6c-1255-28a36a2385c0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 1/13/21 1:04 PM, Thomas Huth wrote:
> On 12/01/2021 14.20, Janosch Frank wrote:
>> I've added too much to cstart64.S which is not start related
>> already. Now that I want to add even more code it's time to split
>> cstart64.S. lib.S has functions that are used in tests. macros.S
>> contains macros which are used in cstart64.S and lib.S
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> ---
>>   s390x/Makefile   |   6 +--
>>   s390x/cstart64.S | 119 ++---------------------------------------------
>>   s390x/lib.S      |  65 ++++++++++++++++++++++++++
> 
> lib.S is a very generic name ... maybe rather use cpuasm.S or something similar?

instr.S ?
Or maybe entry.S to make it similar to the kernel?


> 
> Anway,
> Acked-by: Thomas Huth <thuth@redhat.com>
> 

Thanks
