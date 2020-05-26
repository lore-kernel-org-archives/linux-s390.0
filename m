Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728148AbgEZLi2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 07:38:28 -0400
Subject: Re: [kvm-unit-tests PATCH v7 08/12] s390x: css: stsch, enumeration
 test
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-9-git-send-email-pmorel@linux.ibm.com>
 <da731645-c408-2e79-4c78-a55b5f0d477b@redhat.com>
 <e87b8573-f227-6e28-9e53-3188b0374754@linux.ibm.com>
 <a621c370-5ee6-7db2-5942-adb27d8fe9c9@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <181917f1-2da6-f976-e020-2fb3666dc643@linux.ibm.com>
Date: Tue, 26 May 2020 13:38:22 +0200
MIME-Version: 1.0
In-Reply-To: <a621c370-5ee6-7db2-5942-adb27d8fe9c9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com



On 2020-05-26 12:49, Thomas Huth wrote:
> On 26/05/2020 12.41, Janosch Frank wrote:
>> On 5/25/20 9:12 PM, Thomas Huth wrote:
>>> On 18/05/2020 18.07, Pierre Morel wrote:
>>>> First step for testing the channel subsystem is to enumerate the css and
>>>> retrieve the css devices.

...snip...

>>> I gave your patch series a try on a normal upstream QEMU (that does not
>>> have the ccw-pong device yet), and the css test of course fails there,
>>> since QEMU bails out with:
>>>
>>>   -device ccw-pong: 'ccw-pong' is not a valid device model name
>>>
>>> This is unfortunate - I think we likely have to deal with QEMUs for
>>> quite a while that do not have this device enabled. Could you maybe add
>>> some kind of check to the kvm-unit-tests scripts that only run a test if
>>> a given device is available, and skip the test otherwise?
>>>
>>>   Thomas
>>>
>>
>> Could we for now remove it from unittests.cfg and let Pierre come up
>> with a solution without delaying this whole series? I expect changes to
>> run_tests.sh to attract a rather long discussion...
> 
> Fine for me, too.
> 
>   Thomas
> 

OK, thanks you both, I do so, take the unittest.cfg out from this series 
and come back later with a proposition for unittest.cfg.

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
