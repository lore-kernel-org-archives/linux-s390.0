From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 19 Sep 2018 16:51:07 +0000
Subject: Re: [PATCH 1/3] s390/setup: set control program code via diag 318
Message-Id: <66771da5-b4a1-2907-1fcd-4d65eeaf0b74@linux.ibm.com>
In-Reply-To: <20180919113524.3712df2c.cohuck@redhat.com>
References: <20180919113524.3712df2c.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 09/19/2018 05:35 AM, Cornelia Huck wrote:
> On Fri, 31 Aug 2018 12:51:17 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> The s390x diagnose 318 instruction sets the control program name code (CPNC)
>> and control program version code (CPVC) to provide usefu information regarding
> 
> s/usefu/useful/
> 
>> the OS during debugging. The CPNC is explicitly set to 4 to indicate a Linux/KVM
>> environment.
>>
>> The CPVC is a 7-byte value containing:
>>
>>  - 3-byte Linux version code
>>  - 3-byte distribution identifier set in the config file
>>  - 1-byte null
>>
>> The distro ID is set by the Kconfig option "Distribution Identifier" under the
>> "Processors Type and Features" section.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>> ---
>>  arch/s390/Kconfig              |  8 ++++++++
>>  arch/s390/include/asm/diag.h   | 12 ++++++++++++
>>  arch/s390/include/asm/sclp.h   |  1 +
>>  arch/s390/kernel/diag.c        |  1 +
>>  arch/s390/kernel/setup.c       | 23 +++++++++++++++++++++++
>>  drivers/s390/char/sclp_early.c |  6 +++++-
>>  6 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index 9a9c7a6..ca7fbd0fc 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -595,6 +595,14 @@ config EXPOLINE_FULL
>>  
>>  endchoice
>>  
>> +config DISTRO_ID
>> +	string "Distribution Identifier"
>> +	help
>> +	  This option sets a unique distribution identifier for this kernel build
>> +	  that will assist with internal problem diagnosis for IBM Z.
>> +
>> +	  Only the first three characters of this string will be utilized.
> 
> Might be a good place to point to a registry for known values.
> 

Agreed. Next version I will include this file as a template, and I'll have the description
for this option point to it.

> And perhaps "If you don't know what to set here, leave this value
> empty."?
> 

Good idea.

>> +
>>  endmenu
>>  
>>  menu "Memory setup"
> 

Thanks

-- 
Respectfully,
- Collin Walling
