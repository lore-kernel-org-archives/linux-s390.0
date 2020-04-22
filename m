Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbgDVFy1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 01:54:27 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M5WeQ9038426
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 01:54:26 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gcbg8b9j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 01:54:26 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 22 Apr 2020 06:53:48 +0100
Subject: Re: [kvm-unit-tests PATCH v5 03/10] s390x: cr0: adding AFP-register
 control bit
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-4-git-send-email-pmorel@linux.ibm.com>
 <a4ce1829-027e-d632-be2b-9f6b59d9b96d@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 22 Apr 2020 07:54:18 +0200
MIME-Version: 1.0
In-Reply-To: <a4ce1829-027e-d632-be2b-9f6b59d9b96d@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b7cd0ae4-ce3d-52a9-697a-d2d6e04bf953@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com



On 2020-04-21 18:15, David Hildenbrand wrote:
> On 20.02.20 13:00, Pierre Morel wrote:
>> While adding the definition for the AFP-Register control bit, move all
>> existing definitions for CR0 out of the C zone to the assmbler zone to
>> keep the definitions concerning CR0 together.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
...snip...
>> -	.quad	0x0000000000040000
>> +	.quad	CR0_AFP_REG_CRTL
>>
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
