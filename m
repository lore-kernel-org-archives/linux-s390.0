Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbfKNKLy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 05:11:54 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEABI87147202
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:11:53 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w92x53pxd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 05:11:53 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Nov 2019 10:11:50 -0000
Subject: Re: [PATCH v1 1/4] s390x: saving regs for interrupts
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-2-git-send-email-pmorel@linux.ibm.com>
 <7f40bf69-6e34-7613-1ab5-83e09464c0b0@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 14 Nov 2019 11:11:45 +0100
MIME-Version: 1.0
In-Reply-To: <7f40bf69-6e34-7613-1ab5-83e09464c0b0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <c7d6c21e-3746-b31a-aff9-d19549feb24c@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com


On 2019-11-13 17:12, Janosch Frank wrote:
> On 11/13/19 1:23 PM, Pierre Morel wrote:
>> If we use multiple source of interrupts, for exemple, using SCLP console
>> to print information while using I/O interrupts or during exceptions, we
>> need to have a re-entrant register saving interruption handling.
>>
>> Instead of saving at a static place, let's save the base registers on
>> the stack.
>>
>> Note that we keep the static register saving that we need for the RESET
>> tests.
>>
>> We also care to give the handlers a pointer to the save registers in
>> case the handler needs it (fixup_pgm_int needs the old psw address).
> So you're still ignoring the FPRs...
> I disassembled a test and looked at all stds and it looks like printf
> and related functions use them. Wouldn't we overwrite test FPRs if
> printing in a handler?

If printf uses the FPRs in my opinion we should modify the compilation 
options for the library.

What is the reason for printf and related functions to use floating point?

I will have a deeper look at this.


Regards,

Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
