Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730343AbfLLSUP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 13:20:15 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCI9fbB037571
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 13:20:13 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wuswr97d1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 13:20:13 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 12 Dec 2019 18:20:11 -0000
Subject: Re: [kvm-unit-tests PATCH v4 8/9] s390x: css: ssch/tsch with sense
 and interrupt
From: Pierre Morel <pmorel@linux.ibm.com>
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-9-git-send-email-pmorel@linux.ibm.com>
 <20191212132634.3a16a389.cohuck@redhat.com>
 <1ea58644-9f24-f547-92d5-a99dcb041502@linux.ibm.com>
Date: Thu, 12 Dec 2019 19:20:07 +0100
MIME-Version: 1.0
In-Reply-To: <1ea58644-9f24-f547-92d5-a99dcb041502@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <96034dbc-489a-7f76-0402-d5c0c42d20b3@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-12 15:10, Pierre Morel wrote:
> 
> 
> On 2019-12-12 13:26, Cornelia Huck wrote:
>> On Wed, 11 Dec 2019 16:46:09 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>

...


> 
>>
>> Also, doesn't the interrupt handler check for the intparm already?
> 
> Yes, if the interrupt fires.
> 
>>
>>> +
>>> +    senseid.cu_type = buffer[2] | (buffer[1] << 8);
>>
>> This still looks odd; why not have the ccw fill out the senseid
>> structure directly?
> 
> Oh sorry, you already said and I forgot to modify this.
> thanks

hum, sorry, I forgot, the sense structure is not padded so I need this.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
