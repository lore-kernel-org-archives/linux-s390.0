Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233759AbhBCKLY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Feb 2021 05:11:24 -0500
Subject: Re: [kvm-unit-tests PATCH v1 2/5] s390x: css: simplifications of the
 tests
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
 <1611930869-25745-3-git-send-email-pmorel@linux.ibm.com>
 <daf7ef77-98fc-3e29-d753-78b933a494d5@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <a46eae99-0cb2-a775-3254-83dd8dfe1f83@linux.ibm.com>
Date: Wed, 3 Feb 2021 11:10:36 +0100
MIME-Version: 1.0
In-Reply-To: <daf7ef77-98fc-3e29-d753-78b933a494d5@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com



On 2/2/21 6:29 PM, Thomas Huth wrote:
> On 29/01/2021 15.34, Pierre Morel wrote:
>> In order to ease the writing of tests based on:
...snip...
>>   error_ccw:
>>       free_io_mem(senseid, sizeof(*senseid));
>> -error_senseid:
>> -    unregister_io_int_func(css_irq_io);
>> +    return retval;
>> +}
> 
> Maybe use "success" as a name for the variable instead of "retval"? ... 
> since it's a boolean value...
yes, I do, thanks.
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
