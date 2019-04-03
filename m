Return-Path: <linux-doc-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] s390/setup: diag318: remove bit check and refactor
 struct
References: <20190402174636.15175-1-walling@linux.ibm.com>
 <20190402174636.15175-2-walling@linux.ibm.com>
 <92d69cf5-0510-cf22-9f72-ab3efe4ede9b@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <13072d30-0ecb-e655-8f34-71c640a519df@redhat.com>
Date: Wed, 3 Apr 2019 14:09:14 +0200
MIME-Version: 1.0
In-Reply-To: <92d69cf5-0510-cf22-9f72-ab3efe4ede9b@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, pbonzini@redhat.com, cohuck@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 03.04.19 13:28, Christian Borntraeger wrote:
> 
> 
> On 02.04.19 19:46, Collin Walling wrote:
>> Execution of DIAGNOSE 0x318 is fenced by checking an SCLP bit
>> for the availability of hardware support for the instruction.
>>
>> In order to support this instruction for a KVM/QEMU guest, we
>> would need to provide modifications to the SCLP Read SCP Info
>> data, which will in turn reduce the maximum number of CPUs that
>> may be provided to the guest. This issue introduces compatability
>> and legacy concerns.
>>
>> Let's circumvent this issue by removing the bit check and blindly
>> executing the instruction. An exception table rule is in place to
>> catch the case where hardware does not support this instruction.
> 
> 
> No, please keep the check. We have to extend the read scp field anyway
> for future extensions.

Wasn't there already an SCLP-way of telling the guest that the read-scp
info response is bigger than 4k? Somehow rings a bell ...

-- 

Thanks,

David / dhildenb
