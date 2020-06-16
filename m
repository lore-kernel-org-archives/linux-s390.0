Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728869AbgFPNn6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 09:43:58 -0400
Subject: Re: [kvm-unit-tests PATCH v9 11/12] s390x: css: msch, enable test
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-12-git-send-email-pmorel@linux.ibm.com>
 <665f6c4c-6e72-5980-a3c8-d6ca31ff470c@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <16a6a1c3-d6da-75bb-084d-2e990ddadd49@linux.ibm.com>
Date: Tue, 16 Jun 2020 15:43:52 +0200
MIME-Version: 1.0
In-Reply-To: <665f6c4c-6e72-5980-a3c8-d6ca31ff470c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-16 13:43, Thomas Huth wrote:
> On 15/06/2020 11.32, Pierre Morel wrote:
>> A second step when testing the channel subsystem is to prepare a channel
>> for use.
>> This includes:
>> - Get the current subchannel Information Block (SCHIB) using STSCH
>> - Update it in memory to set the ENABLE bit
>> - Tell the CSS that the SCHIB has been modified using MSCH
>> - Get the SCHIB from the CSS again to verify that the subchannel is
>>    enabled.
>> - If the command succeeds but subchannel is not enabled retry a
>>    predefined retries count.
>> - If the command fails, report the failure and do not retry, even
>>    if cc indicates a busy/status pending as we do not expect this.
>>
>> This tests the MSCH instruction to enable a channel succesfuly.
> 
> s/succesfuly/successfully/

yes.

> 
>> This some retries are done and in case of error, and if the retries
>> count is exceeded, a report is made.
> 
> That sentence needs some fixes, too ;-)
> 
> With the commit description fixed:
> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
