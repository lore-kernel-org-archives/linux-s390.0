From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 1/9] s390/sthyi: reorganize sthyi implementation
Date: Fri, 10 Nov 2017 14:39:49 +0100
Message-ID: <dc748c42-e2a6-2ed4-b83f-b4b3c456af15@de.ibm.com>
References: <20171110080013.111004-1-borntraeger@de.ibm.com>
 <20171110080013.111004-2-borntraeger@de.ibm.com>
 <ea8673ad-3ad9-cab5-d2a0-0d60002adb32@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <ea8673ad-3ad9-cab5-d2a0-0d60002adb32@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 11/10/2017 02:05 PM, Janosch Frank wrote:
> On 10.11.2017 09:00, Christian Borntraeger wrote:
>> From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>>
>> As we need to support sthyi instruction on LPAR too, move the common code
>> to kernel part and kvm related code to intercept.c for better reuse.
>>
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> This is missing my Reviewed-by and the next two are missing my ACK. -_-

Dont complain here, this just came via the s390 tree. 
