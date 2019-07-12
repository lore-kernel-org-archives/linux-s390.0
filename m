Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbfGLN14 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 09:27:56 -0400
Subject: Re: [PATCH v3 5/5] vfio-ccw: Update documentation for csch/hsch
References: <cover.1562854091.git.alifm@linux.ibm.com>
 <7d977612c3f3152ffb950d77ae11b4b25c1e20c4.1562854091.git.alifm@linux.ibm.com>
 <20190712133006.23efcd0d.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Message-ID: <7b71133b-0257-ba6e-a544-02ec8216094c@linux.ibm.com>
Date: Fri, 12 Jul 2019 09:27:13 -0400
MIME-Version: 1.0
In-Reply-To: <20190712133006.23efcd0d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 07/12/2019 07:30 AM, Cornelia Huck wrote:
> On Thu, 11 Jul 2019 10:28:55 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> We now support CLEAR SUBCHANNEL and HALT SUBCHANNEL
>> via ccw_cmd_region.
>>
>> Fixes: d5afd5d135c8 ("vfio-ccw: add handling for async channel instructions")
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   Documentation/s390/vfio-ccw.rst | 31 ++++++++++++++++++++++++++++---
>>   1 file changed, 28 insertions(+), 3 deletions(-)
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

There is one other thing, I forgot to add a fixes tag to the first 
patch. If you don't mind fixing that as well that will be great :)

otherwise I could send a new round


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

Thanks for reviewing it

Thanks
Farhan
