From: Avi Kivity <avi@redhat.com>
Subject: Re: next June 10: S390 build failure [arch/s390/kvm/kvm.ko]
Date: Wed, 23 Jun 2010 12:04:36 +0300
Message-ID: <4C21CE24.2010609@redhat.com>
References: <20100610160012.30ea7606.sfr@canb.auug.org.au> <4C10DCB7.7090903@in.ibm.com> <20100610154848.616aff99@mschwide.boeblingen.de.ibm.com> <201006120854.14259.borntraeger@de.ibm.com> <4C218E7D.8070006@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4C218E7D.8070006@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 06/23/2010 07:33 AM, Sachin Sant wrote:
> Christian Borntraeger wrote:
>> Am Donnerstag 10 Juni 2010, 15:48:48 schrieb Martin Schwidefsky:
>>> On Thu, 10 Jun 2010 18:08:15 +0530
>>> Sachin Sant <sachinp@in.ibm.com> wrote:
>>>
>>>> Today's next fails to build on a s390 box with
>>>>
>>>> ERROR: "__kvm_s390_vcpu_store_status" [arch/s390/kvm/kvm.ko] 
>>>> undefined!
>>>>
>>>> Yesterday's next was good.
>>> That is caused by git commit fbc5eec58e652339e9df1332cd5e10e8d8250aaf
>>> which fails to take git commit 5288fbf0ef041ba0e8b4dcb2df4536b5e3a48b32
>>> into account. There is a second caller of __kvm_s390_vcpu_store_status
>>> in arch/s390/kvm/intercept.c. As far as I understand the code you could
>>> just drop the 'static' from kvm_s390_vcpu_store_status and call it from
>>> handle_stop instead of the old __kvm_s390_vcpu_store_status.
>>>
>>> Carsten, Christian: could one of you have a look please?
>>
>> that patch should do the trick. Avi can you add that to kvm.git?
>>
>> kvm-s390: Fix build failure 
> ping on the patch. Still not merged with next.

Missed it somehow.  Now applied to kvm.git next and kvm-updates/2.6.36 
(which is the linux-next queue).

-- 
error compiling committee.c: too many arguments to function
