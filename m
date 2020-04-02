Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388001AbgDBKoK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Apr 2020 06:44:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032AYfPK102521
        for <linux-s390@vger.kernel.org>; Thu, 2 Apr 2020 06:44:09 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3043g98evv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 02 Apr 2020 06:44:09 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 2 Apr 2020 11:44:05 +0100
Subject: Re: [kvm-unit-tests 2/2] s390x/smp: add minimal test for sigp sense
 running status
References: <20200330084911.34248-1-borntraeger@de.ibm.com>
 <20200330084911.34248-3-borntraeger@de.ibm.com>
 <2e511a31-b976-ec07-f0c4-a01c32ceba7f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 2 Apr 2020 12:44:03 +0200
MIME-Version: 1.0
In-Reply-To: <2e511a31-b976-ec07-f0c4-a01c32ceba7f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6222d239-2540-455a-4e25-226111e7d80e@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>



On 30.03.20 12:58, David Hildenbrand wrote:
> On 30.03.20 10:49, Christian Borntraeger wrote:
>> make sure that sigp sense running status returns a sane value for
>> stopped CPUs.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  lib/s390x/smp.c |  2 +-
>>  lib/s390x/smp.h |  2 +-
>>  s390x/smp.c     | 11 +++++++++++
>>  3 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>> index 5ed8b7b..492cb05 100644
>> --- a/lib/s390x/smp.c
>> +++ b/lib/s390x/smp.c
>> @@ -58,7 +58,7 @@ bool smp_cpu_stopped(uint16_t addr)
>>  	return !!(status & (SIGP_STATUS_CHECK_STOP|SIGP_STATUS_STOPPED));
>>  }
>>  
>> -bool smp_cpu_running(uint16_t addr)
>> +bool smp_sense_running_status(uint16_t addr)
>>  {
>>  	if (sigp(addr, SIGP_SENSE_RUNNING, 0, NULL) != SIGP_CC_STATUS_STORED)
>>  		return true;
>> diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
>> index a8b98c0..639ec92 100644
>> --- a/lib/s390x/smp.h
>> +++ b/lib/s390x/smp.h
>> @@ -40,7 +40,7 @@ struct cpu_status {
>>  int smp_query_num_cpus(void);
>>  struct cpu *smp_cpu_from_addr(uint16_t addr);
>>  bool smp_cpu_stopped(uint16_t addr);
>> -bool smp_cpu_running(uint16_t addr);
>> +bool smp_sense_running_status(uint16_t addr);
>>  int smp_cpu_restart(uint16_t addr);
>>  int smp_cpu_start(uint16_t addr, struct psw psw);
>>  int smp_cpu_stop(uint16_t addr);
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index 79cdc1f..f9f143d 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -210,6 +210,16 @@ static void test_emcall(void)
>>  	report_prefix_pop();
>>  }
>>  
>> +static void test_sense_running(void)
>> +{
>> +	report_prefix_push("sense_running");
>> +	/* make sure CPU is stopped */
>> +	smp_cpu_stop(1);
>> +	report(!smp_sense_running_status(1), "CPU1 sense claims not running");
>> +	report_prefix_pop();
>> +}
>> +
>> +
>>  /* Used to dirty registers of cpu #1 before it is reset */
>>  static void test_func_initial(void)
>>  {
>> @@ -319,6 +329,7 @@ int main(void)
>>  	test_store_status();
>>  	test_ecall();
>>  	test_emcall();
>> +	test_sense_running();
>>  	test_reset();
>>  	test_reset_initial();
>>  	smp_cpu_destroy(1);
>>
> 
> In kvm, we set/clear via kvm_arch_vcpu_load/kvm_arch_vcpu_put. This
> means, that a VCPU will also be indicated as running, in case we perform
> certain VCPU IOCTLs, while the VCPU is already stopped.
> 
> Especially, there is a theoretical race between stopping a VCPU, and it
> still being in the kernel, and the other thread sensing the running
> status. This is the case with !kvm_s390_user_cpu_state_ctrl(), when
> leaving handle_stop() but also with kvm_s390_user_cpu_state_ctrl(), when
> setting the MP state via kvm_arch_vcpu_ioctl_set_mpstate().

I think I will just busy wait until the target is not running. This must happen and a timeout indicates a failure.
