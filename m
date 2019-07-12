Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726466AbfGLN22 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 09:28:28 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CDRYN6141373
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 09:28:26 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tpsksm8sc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 09:28:25 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Fri, 12 Jul 2019 14:28:21 +0100
Subject: Re: [PATCH v3 5/5] vfio-ccw: Update documentation for csch/hsch
References: <cover.1562854091.git.alifm@linux.ibm.com>
 <7d977612c3f3152ffb950d77ae11b4b25c1e20c4.1562854091.git.alifm@linux.ibm.com>
 <20190712133006.23efcd0d.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 12 Jul 2019 09:28:17 -0400
MIME-Version: 1.0
In-Reply-To: <20190712133006.23efcd0d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8cac1675-0a56-09e3-75aa-00b4f81127c6@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 7/12/19 7:30 AM, Cornelia Huck wrote:
> On Thu, 11 Jul 2019 10:28:55 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> We now support CLEAR SUBCHANNEL and HALT SUBCHANNEL
>> via ccw_cmd_region.
>>
>> Fixes: d5afd5d135c8 ("vfio-ccw: add handling for async channel instructions")
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>  Documentation/s390/vfio-ccw.rst | 31 ++++++++++++++++++++++++++++---
>>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> (...)
> 
>> +vfio-ccw cmd region
>> +-------------------
>> +
>> +The vfio-ccw cmd region is used to accept asynchronous instructions
>> +from userspace.
>> +
> 
> Add :: and indent the structure so that we get proper formatting?
> 
> (Sorry about not noticing this last time; but I can add it while
> applying if there are no other comments.)
> 
>> +#define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
>> +#define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
>> +struct ccw_cmd_region {
>> +       __u32 command;
>> +       __u32 ret_code;
>> +} __packed;
>> +
>> +This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
>> +
>> +Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
>> +
> 
> Otherwise,
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Also good...

Reviewed-by: Eric Farman <farman@linux.ibm.com>
