From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 05/11] KVM: s390: Support Configuration z/Architecture
 Mode
Date: Tue, 29 Aug 2017 14:21:43 +0200
Message-ID: <b4d1df32-9915-4c7a-5db5-affe00cb9adf@de.ibm.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
 <1503907651-65296-2-git-send-email-borntraeger@de.ibm.com>
 <d72ff520-8fac-34d9-e71a-53697a59957c@redhat.com>
 <28c5c4be-d07a-a82d-916f-5771759f35f1@de.ibm.com>
 <ae6cf9ff-8820-1a63-47ea-b6a28046fc5e@de.ibm.com>
 <c2876d8a-f729-90a1-5d35-93a5b69e7bb9@redhat.com>
 <55b2a9e4-2b48-e19f-cc68-f26ab689dd5b@de.ibm.com>
 <4c32d305-52e8-215d-134d-02091b8f1b42@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4c32d305-52e8-215d-134d-02091b8f1b42@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 08/29/2017 02:08 PM, David Hildenbrand wrote:
> 
>>> This is also what we do on the QEMU side and what I meant by "consistent".
>>
>> Yes, I agree. QEMU will always enable stfle.138. So should the kernel.
>> Shall I fixup the patch with your change proposal or do you want to send an on-top patch?
>>
> 
> Whatever you prefer!

Can you send a fixup patch on top?
