Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbfKMMnk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 07:43:40 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADCeUeD027973
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:43:39 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8j1w84xy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:43:39 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 13 Nov 2019 12:43:37 -0000
Subject: Re: [PATCH v1 0/4] s390x: Testing the Subchannel I/O
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <30d17ea4-1c35-f44a-8736-05725b251c69@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 13 Nov 2019 13:43:34 +0100
MIME-Version: 1.0
In-Reply-To: <30d17ea4-1c35-f44a-8736-05725b251c69@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <9f3100d9-de50-7e9e-f8a0-dcef2ee923ef@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com


On 2019-11-13 13:35, Thomas Huth wrote:
>   Hi Pierre!
>
> Meta-comment: Please use "[kvm-unit-tests PATCH ...]" in the subject for
> future kvm-unit-tests patches.


Oh sorry, I didn't notice, thanks.

Will take care for the next series.


>
> On 13/11/2019 13.23, Pierre Morel wrote:
> [...]
>> The simple test tests the I/O reading by the SUB Channel. It needs QEMU to
>> be patched to have the pong device defined.
> Are you going to send QEMU patches for this? I assume that's a
> prerequisite for this patch series?
>
>   Thomas
>
Yes I will.

Regards,

Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
