Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39218 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729478AbfKDRu3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 12:50:29 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA4Hm5d2032591
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 12:50:28 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w14m3fawb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 12:50:27 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 4 Nov 2019 17:50:18 -0000
Subject: Re: [RFC 02/37] s390/protvirt: introduce host side setup
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-3-frankja@linux.ibm.com>
 <20191104165427.0e5e6da4.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 4 Nov 2019 18:50:12 +0100
MIME-Version: 1.0
In-Reply-To: <20191104165427.0e5e6da4.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5a34febd-8abc-84f5-195e-43decbb366a5@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com



On 04.11.19 16:54, Cornelia Huck wrote:
> On Thu, 24 Oct 2019 07:40:24 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> From: Vasily Gorbik <gor@linux.ibm.com>
>>
>> Introduce KVM_S390_PROTECTED_VIRTUALIZATION_HOST kbuild option for
>> protected virtual machines hosting support code.
>>
>> Add "prot_virt" command line option which controls if the kernel
>> protected VMs support is enabled at runtime.
>>
>> Extend ultravisor info definitions and expose it via uv_info struct
>> filled in during startup.
>>
>> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  5 ++
>>  arch/s390/boot/Makefile                       |  2 +-
>>  arch/s390/boot/uv.c                           | 20 +++++++-
>>  arch/s390/include/asm/uv.h                    | 46 ++++++++++++++++--
>>  arch/s390/kernel/Makefile                     |  1 +
>>  arch/s390/kernel/setup.c                      |  4 --
>>  arch/s390/kernel/uv.c                         | 48 +++++++++++++++++++
>>  arch/s390/kvm/Kconfig                         |  9 ++++
>>  8 files changed, 126 insertions(+), 9 deletions(-)
>>  create mode 100644 arch/s390/kernel/uv.c
> 
> (...)
> 
>> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
>> index ed007f4a6444..88cf8825d169 100644
>> --- a/arch/s390/boot/uv.c
>> +++ b/arch/s390/boot/uv.c
>> @@ -3,7 +3,12 @@
>>  #include <asm/facility.h>
>>  #include <asm/sections.h>
>>  
>> +#ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
>>  int __bootdata_preserved(prot_virt_guest);
>> +#endif
>> +#ifdef CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST
>> +struct uv_info __bootdata_preserved(uv_info);
>> +#endif
> 
> Two functions with the same name, but different signatures look really
> ugly.
> 
> Also, what happens if I want to build just a single kernel image for
> both guest and host?

This is not two functions with the same name. It is 2 variable declarations with
the __bootdata_preserved helper. We expect to have all distro kernels to enable
both. 

> 
>>  
>>  void uv_query_info(void)
>>  {
>> @@ -18,7 +23,20 @@ void uv_query_info(void)
>>  	if (uv_call(0, (uint64_t)&uvcb))
>>  		return;
>>  
>> -	if (test_bit_inv(BIT_UVC_CMD_SET_SHARED_ACCESS, (unsigned long *)uvcb.inst_calls_list) &&
>> +	if (IS_ENABLED(CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST)) {
> 
> Do we always have everything needed for a host if uv_call() is
> successful?

The uv_call is the query call. It will provide the list of features. We check that
later on.

> 
>> +		memcpy(uv_info.inst_calls_list, uvcb.inst_calls_list, sizeof(uv_info.inst_calls_list));
>> +		uv_info.uv_base_stor_len = uvcb.uv_base_stor_len;
>> +		uv_info.guest_base_stor_len = uvcb.conf_base_phys_stor_len;
>> +		uv_info.guest_virt_base_stor_len = uvcb.conf_base_virt_stor_len;
>> +		uv_info.guest_virt_var_stor_len = uvcb.conf_virt_var_stor_len;
>> +		uv_info.guest_cpu_stor_len = uvcb.cpu_stor_len;
>> +		uv_info.max_sec_stor_addr = ALIGN(uvcb.max_guest_stor_addr, PAGE_SIZE);
>> +		uv_info.max_num_sec_conf = uvcb.max_num_sec_conf;
>> +		uv_info.max_guest_cpus = uvcb.max_guest_cpus;
>> +	}
>> +
>> +	if (IS_ENABLED(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) &&
>> +	    test_bit_inv(BIT_UVC_CMD_SET_SHARED_ACCESS, (unsigned long *)uvcb.inst_calls_list) &&
>>  	    test_bit_inv(BIT_UVC_CMD_REMOVE_SHARED_ACCESS, (unsigned long *)uvcb.inst_calls_list))
> 
> Especially as it looks like we need to test for those two commands to
> determine whether we have support for a guest.
> 
>>  		prot_virt_guest = 1;
>>  }
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index ef3c00b049ab..6db1bc495e67 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -44,7 +44,19 @@ struct uv_cb_qui {
>>  	struct uv_cb_header header;
>>  	u64 reserved08;
>>  	u64 inst_calls_list[4];
>> -	u64 reserved30[15];
>> +	u64 reserved30[2];
>> +	u64 uv_base_stor_len;
>> +	u64 reserved48;
>> +	u64 conf_base_phys_stor_len;
>> +	u64 conf_base_virt_stor_len;
>> +	u64 conf_virt_var_stor_len;
>> +	u64 cpu_stor_len;
>> +	u32 reserved68[3];
>> +	u32 max_num_sec_conf;
>> +	u64 max_guest_stor_addr;
>> +	u8  reserved80[150-128];
>> +	u16 max_guest_cpus;
>> +	u64 reserved98;
>>  } __packed __aligned(8);
>>  
>>  struct uv_cb_share {
>> @@ -69,9 +81,21 @@ static inline int uv_call(unsigned long r1, unsigned long r2)
>>  	return cc;
>>  }
>>  
>> -#ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
>> +struct uv_info {
>> +	unsigned long inst_calls_list[4];
>> +	unsigned long uv_base_stor_len;
>> +	unsigned long guest_base_stor_len;
>> +	unsigned long guest_virt_base_stor_len;
>> +	unsigned long guest_virt_var_stor_len;
>> +	unsigned long guest_cpu_stor_len;
>> +	unsigned long max_sec_stor_addr;
>> +	unsigned int max_num_sec_conf;
>> +	unsigned short max_guest_cpus;
>> +};
> 
> What is the main difference between uv_info and uv_cb_qui? The
> alignment of max_sec_stor_addr?

One is the hardware data structure for query, the other one is the Linux
internal state.

> 
>> +extern struct uv_info uv_info;
>>  extern int prot_virt_guest;
>>  
>> +#ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
>>  static inline int is_prot_virt_guest(void)
>>  {
>>  	return prot_virt_guest;
>> @@ -121,11 +145,27 @@ static inline int uv_remove_shared(unsigned long addr)
>>  	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
>>  }
>>  
>> -void uv_query_info(void);
>>  #else
>>  #define is_prot_virt_guest() 0
>>  static inline int uv_set_shared(unsigned long addr) { return 0; }
>>  static inline int uv_remove_shared(unsigned long addr) { return 0; }
>> +#endif
>> +
>> +#ifdef CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST
>> +extern int prot_virt_host;
>> +
>> +static inline int is_prot_virt_host(void)
>> +{
>> +	return prot_virt_host;
>> +}
>> +#else
>> +#define is_prot_virt_host() 0
>> +#endif
>> +
>> +#if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) ||                          \
>> +	defined(CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST)
>> +void uv_query_info(void);
>> +#else
>>  static inline void uv_query_info(void) {}
>>  #endif
> 
> (...)
> 
[...]
