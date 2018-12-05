From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 05 Dec 2018 15:00:21 +0000
Subject: Re: [PATCH v1 1/2] s390/setup: set control program code via diag 318
Message-Id: <582b136a-383c-9f87-698d-adc5f0b316d8@linux.ibm.com>
In-Reply-To: <8f356c45-0707-b784-a036-f08db33b0616@linux.ibm.com>
References: <8f356c45-0707-b784-a036-f08db33b0616@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 12/5/18 5:59 AM, Cornelia Huck wrote:
> On Tue,  4 Dec 2018 17:06:29 -0500
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> The new s390x instruction, diagnose 318, sets the control program name 
>> code (CPNC) and control program version code (CPVC) to provide useful 
>> information regarding the OS during debugging. The CPNC is explicitly 
>> set to 4 to indicate a Linux/KVM environment.
>>
>> The CPVC is a 7-byte value containing:
>>
>>  - 3-byte Linux version code
>>  - 3-byte unique value, currently set to 0
>>  - 1-byte trailing null
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>> ---
>>  arch/s390/include/asm/diag.h   | 12 ++++++++++++
>>  arch/s390/include/asm/sclp.h   |  1 +
>>  arch/s390/kernel/diag.c        |  1 +
>>  arch/s390/kernel/setup.c       | 21 +++++++++++++++++++++
>>  drivers/s390/char/sclp.h       |  4 +++-
>>  drivers/s390/char/sclp_early.c |  2 ++
>>  6 files changed, 40 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks!

-- 
Respectfully,
- Collin Walling
