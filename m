Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729392AbfLLNgN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 08:36:13 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCDWKD9029087
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 08:36:12 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtdp5n66p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 08:36:12 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 12 Dec 2019 13:36:11 -0000
Subject: Re: [kvm-unit-tests PATCH v4 4/9] s390x: export the clock
 get_clock_ms() utility
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-5-git-send-email-pmorel@linux.ibm.com>
 <c26c335a-7894-09ad-bc23-6ae060f4a255@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 12 Dec 2019 14:36:07 +0100
MIME-Version: 1.0
In-Reply-To: <c26c335a-7894-09ad-bc23-6ae060f4a255@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <664e1119-24c1-eab0-0f0c-d1d57f0e6f6b@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2019-12-12 10:40, Janosch Frank wrote:
> On 12/11/19 4:46 PM, Pierre Morel wrote:
>> To serve multiple times, the function get_clock_ms() is moved
>> from intercept.c test to the new file asm/time.h.
> 
> Let's move get_clock_ms() to lib/s390/asm/time.h, so it can be used in
> multiple places.
> 
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 
Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
