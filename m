Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405300AbgFYOn1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 10:43:27 -0400
Subject: Re: [PATCH 2/2] docs: kvm: fix rst formatting
References: <20200624202200.28209-1-walling@linux.ibm.com>
 <20200624202200.28209-3-walling@linux.ibm.com>
 <20200625083423.2ee75bb1.cohuck@redhat.com>
 <22b7d435-480e-ac7f-de4f-b992df6c9ebb@linux.ibm.com>
 <20200625090942.21dbc0cf.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <97c7d88f-1e97-1499-9e9a-77497a27d386@linux.ibm.com>
Date: Thu, 25 Jun 2020 10:43:22 -0400
MIME-Version: 1.0
In-Reply-To: <20200625090942.21dbc0cf.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On 6/25/20 3:09 AM, Cornelia Huck wrote:
> On Thu, 25 Jun 2020 09:07:43 +0200
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> On 6/25/20 8:34 AM, Cornelia Huck wrote:
>>> On Wed, 24 Jun 2020 16:22:00 -0400
>>> Collin Walling <walling@linux.ibm.com> wrote:
>>>   
>>>> KVM_CAP_S390_VCPU_RESETS and KVM_CAP_S390_PROTECTED needed
>>>> just a little bit of rst touch-up
>>>>  
>>>
>>> Fixes: 7de3f1423ff9 ("KVM: s390: Add new reset vcpu API")
>>> Fixes: 04ed89dc4aeb ("KVM: s390: protvirt: Add KVM api documentation")  
>>
>> Do we really do that for documentation changes?
> 
> Feel free to keep it or leave it :)
> 

I'm indifferent. I suppose I'll go with David's suggestion of
"Introduced in commit..."

Thanks for all the feedback. Will sent out v2 shortly.

-- 
Regards,
Collin

Stay safe and stay healthy
