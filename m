Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731973AbgEZLk6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 07:40:58 -0400
Subject: Re: [kvm-unit-tests PATCH v7 10/12] s390x: define function to wait
 for interrupt
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-11-git-send-email-pmorel@linux.ibm.com>
 <23933f4c-490c-0c16-c8b6-84a7630130f7@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <80c82816-cb94-a10a-c7fe-58651e6c6ebe@linux.ibm.com>
Date: Tue, 26 May 2020 13:40:52 +0200
MIME-Version: 1.0
In-Reply-To: <23933f4c-490c-0c16-c8b6-84a7630130f7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2020-05-26 12:42, Janosch Frank wrote:
> On 5/18/20 6:07 PM, Pierre Morel wrote:
>> Allow the program to wait for an interrupt.
>>
>> The interrupt handler is in charge to remove the WAIT bit
>> when it finished handling the interrupt.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 
Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
