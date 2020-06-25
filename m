Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31463 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390013AbgFYHJM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 Jun 2020 03:09:12 -0400
Subject: Re: [PATCH 2/2] docs: kvm: fix rst formatting
References: <20200624202200.28209-1-walling@linux.ibm.com>
 <20200624202200.28209-3-walling@linux.ibm.com>
 <20200625083423.2ee75bb1.cohuck@redhat.com>
 <22b7d435-480e-ac7f-de4f-b992df6c9ebb@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <afcdae56-5d53-4395-7326-cfce66eef545@redhat.com>
Date: Thu, 25 Jun 2020 09:08:59 +0200
MIME-Version: 1.0
In-Reply-To: <22b7d435-480e-ac7f-de4f-b992df6c9ebb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On 25.06.20 09:07, Janosch Frank wrote:
> On 6/25/20 8:34 AM, Cornelia Huck wrote:
>> On Wed, 24 Jun 2020 16:22:00 -0400
>> Collin Walling <walling@linux.ibm.com> wrote:
>>
>>> KVM_CAP_S390_VCPU_RESETS and KVM_CAP_S390_PROTECTED needed
>>> just a little bit of rst touch-up
>>>
>>
>> Fixes: 7de3f1423ff9 ("KVM: s390: Add new reset vcpu API")
>> Fixes: 04ed89dc4aeb ("KVM: s390: protvirt: Add KVM api documentation")
> 
> Do we really do that for documentation changes?

Had a similar discussion recently, I prefer to just mention the commits
in the commit message like "Introduced in commit ...".

-- 
Thanks,

David / dhildenb
