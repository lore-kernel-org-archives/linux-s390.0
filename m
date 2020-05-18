Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44617 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbgEROqc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 May 2020 10:46:32 -0400
Subject: Re: [PATCH v7 2/3] s390: keep diag 318 variables consistent with the
 rest
References: <20200515221935.18775-1-walling@linux.ibm.com>
 <20200515221935.18775-3-walling@linux.ibm.com>
 <6f910102-c729-6605-39f7-d22ee8b40b4c@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <36ceecf8-a1cd-3592-362b-53d6c57722be@linux.ibm.com>
Date: Mon, 18 May 2020 10:46:24 -0400
MIME-Version: 1.0
In-Reply-To: <6f910102-c729-6605-39f7-d22ee8b40b4c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

On 5/18/20 2:30 AM, Thomas Huth wrote:
> On 16/05/2020 00.19, Collin Walling wrote:
>> Rename diag318 to diag_318 and byte_134 to fac134 in order to keep
>> naming schemes consistent with other diags and the read info struct
>> and make grepping easier.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/diag.h   | 2 +-
>>  arch/s390/include/asm/sclp.h   | 2 +-
>>  arch/s390/kernel/setup.c       | 6 +++---
>>  drivers/s390/char/sclp.h       | 2 +-
>>  drivers/s390/char/sclp_early.c | 2 +-
>>  5 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
>> index ca8f85b53a90..19da822e494c 100644
>> --- a/arch/s390/include/asm/diag.h
>> +++ b/arch/s390/include/asm/diag.h
>> @@ -295,7 +295,7 @@ struct diag26c_mac_resp {
>>  } __aligned(8);
>>  
>>  #define CPNC_LINUX		0x4
>> -union diag318_info {
>> +union diag_318_info {
> 
> $ grep -r diag.*info arch/s390/include/asm/diag.h
> struct diag204_info_blk_hdr {
> struct diag204_x_info_blk_hdr {
> struct diag204_cpu_info {
> struct diag204_x_cpu_info {
> 	struct diag204_x_cpu_info cpus[];
> union diag318_info {
> 
> ... none of these seem to use an underscore between the "diag" and the
> number ... so this seems unnecessary to me ... or what do I miss?
> 
>  Thomas
> 

I could have sworn I saw more cases with the underscore. I think I was
honing-in on a few cases in QEMU for whatever reason.

Let's just forget this patch was posted :)

-- 
--
Regards,
Collin

Stay safe and stay healthy
