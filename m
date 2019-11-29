Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42790 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfK2NE4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Nov 2019 08:04:56 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATD340E142147
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 08:04:55 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wjar9mv8c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 08:04:54 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 29 Nov 2019 13:04:52 -0000
Subject: Re: [kvm-unit-tests PATCH v2 4/9] s390x: export the clock
 get_clock_ms() utility
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-5-git-send-email-pmorel@linux.ibm.com>
 <442f3d30-e61f-e884-096e-6ed47b4c6d7e@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 29 Nov 2019 14:04:49 +0100
MIME-Version: 1.0
In-Reply-To: <442f3d30-e61f-e884-096e-6ed47b4c6d7e@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <db120d16-210a-5ed4-fb98-857ce0f4ee4b@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com



On 2019-11-29 13:03, David Hildenbrand wrote:
> On 28.11.19 13:46, Pierre Morel wrote:
>> To serve multiple times, the function get_clock_ms() is moved
>> from intercept.c test to the new file asm/clock.h.
> 
> I'd probably call this "tod.h" instead. Nevermind.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
