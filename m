Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] s390/protvirt: fix compilation issue
References: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
 <your-ad-here.call-01587646462-ext-4177@work.hours>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <a12b704f-b9b8-6ce8-0f65-5751a69bfdd2@de.ibm.com>
Date: Fri, 24 Apr 2020 15:17:11 +0200
MIME-Version: 1.0
In-Reply-To: <your-ad-here.call-01587646462-ext-4177@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, cohuck@redhat.com, david@redhat.com, kbuild test robot <lkp@intel.com>, Philipp Rudo <prudo@linux.ibm.com>



On 23.04.20 14:54, Vasily Gorbik wrote:
> On Thu, Apr 23, 2020 at 02:01:14PM +0200, Claudio Imbrenda wrote:
>> The kernel fails to compile with CONFIG_PROTECTED_VIRTUALIZATION_GUEST
>> set but CONFIG_KVM unset.
>>
>> This patch fixes the issue by making the needed variable always available.
> 
> This statement confuses me a bit.
> 
> It's worth to mention that both arch/s390/boot/uv.c (for the
> decompressor) and arch/s390/kernel/uv.c (for the main kernel) are only
> built when either CONFIG_PROTECTED_VIRTUALIZATION_GUEST or
> CONFIG_KVM is enabled.
> Both arch/s390/boot/Makefile and arch/s390/kernel/Makefile contain:
> obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) $(CONFIG_PGSTE))   += uv.o
> 
> So this makes the variable available when
> CONFIG_PROTECTED_VIRTUALIZATION_GUEST or CONFIG_KVM (expressed via
> CONFIG_PGSTE) is enabled. Hence no need for extra conditions for variable
> declaration.
> 
>> Fixes: a0f60f8431999bf5 ("s390/protvirt: Add sysfs firmware interface for Ultravisor information")
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reported-by: Philipp Rudo <prudo@linux.ibm.com>
>> Suggested-by: Philipp Rudo <prudo@linux.ibm.com>
>> CC: Vasily Gorbik <gor@linux.ibm.com>
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> ---
>>  arch/s390/boot/uv.c   | 2 --
>>  arch/s390/kernel/uv.c | 3 ++-
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
>> index 8fde561f1d07..f887a479cdc7 100644
>> --- a/arch/s390/boot/uv.c
>> +++ b/arch/s390/boot/uv.c
>> @@ -7,9 +7,7 @@
>>  #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
>>  int __bootdata_preserved(prot_virt_guest);
>>  #endif
>> -#if IS_ENABLED(CONFIG_KVM)
>>  struct uv_info __bootdata_preserved(uv_info);
>> -#endif
>>  
>>  void uv_query_info(void)
>>  {
>> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
>> index c86d654351d1..4c0677fc8904 100644
>> --- a/arch/s390/kernel/uv.c
>> +++ b/arch/s390/kernel/uv.c
>> @@ -23,10 +23,11 @@
>>  int __bootdata_preserved(prot_virt_guest);
>>  #endif
>>  
>> +struct uv_info __bootdata_preserved(uv_info);
>> +
>>  #if IS_ENABLED(CONFIG_KVM)
>>  int prot_virt_host;
>>  EXPORT_SYMBOL(prot_virt_host);
>> -struct uv_info __bootdata_preserved(uv_info);
>>  EXPORT_SYMBOL(uv_info);
> 
> hm, EXPORT_SYMBOL(uv_info) is not needed without CONFIG_KVM and this saves
> 1 symbol export, but I'd still made EXPORT_SYMBOL follow the declaration
> immediately. Documentation/process/coding-style.rst mentions that only
> for function declarations though.
> 
> Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Vasily, I guess you have a pull request soon? Do you want to pick this?
