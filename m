From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/2] KVM: s390: add vcpu stat counters for many
 instruction
Date: Wed, 24 Jan 2018 16:20:49 +0100
Message-ID: <1570f253-f499-06dd-c869-5f8e422ea85b@de.ibm.com>
References: <20180124113235.31485-1-borntraeger@de.ibm.com>
 <20180124113235.31485-2-borntraeger@de.ibm.com>
 <20180124154510.02481cc6.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180124154510.02481cc6.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/24/2018 03:45 PM, Cornelia Huck wrote:
> On Wed, 24 Jan 2018 12:32:34 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> The overall instruction counter is larger than the sum of the
>> single counters. We should try to catch all instruction handlers
>> to make this match the summary counter.
>> Let us add sck,tb,sske,iske,rrbe,tb,tpi,tsch,lpsw,pswe.....
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h | 18 ++++++++++++++++--
>>  arch/s390/kvm/kvm-s390.c         | 18 ++++++++++++++++--
>>  arch/s390/kvm/priv.c             | 33 +++++++++++++++++++++++++++++++--
>>  3 files changed, 63 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 2aee050..5d47991 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -1,7 +1,7 @@
>>  /*
>>   * definition for kernel virtual machines on s390
>>   *
>> - * Copyright IBM Corp. 2008, 2009
>> + * Copyright IBM Corp. 2008, 2018
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License (version 2 only)
>> @@ -323,18 +323,32 @@ struct kvm_vcpu_stat {
>>  	u64 deliver_program_int;
>>  	u64 deliver_io_int;
>>  	u64 exit_wait_state;
>> +	u64 instruction_epsw;
>> +	u64 instruction_gs;
>> +	u64 instruction_io;
> 
> I find the naming a bit confusing (tpi/tsch are I/O instructions, too)
> -- call this instruction_io_other?

yes will rename.


> 
>> +	u64 instruction_lpsw;
>> +	u64 instruction_lpswe;
>>  	u64 instruction_pfmf;
>> +	u64 instruction_ptff;
>> +	u64 instruction_sck;
>> +	u64 instruction_sckpf;
>>  	u64 instruction_stidp;
>>  	u64 instruction_spx;
>>  	u64 instruction_stpx;
>>  	u64 instruction_stap;
>> -	u64 instruction_storage_key;
>> +	u64 instruction_iske;
>> +	u64 instruction_ri;
>> +	u64 instruction_rrbe;
>> +	u64 instruction_sske;
>>  	u64 instruction_ipte_interlock;
>>  	u64 instruction_stsch;
>>  	u64 instruction_chsc;
> 
> The stsch and chsc counters are dead (probably have been for quite some
> time).

will remove
> 
>>  	u64 instruction_stsi;
>>  	u64 instruction_stfl;
>> +	u64 instruction_tb;
>> +	u64 instruction_tpi;
>>  	u64 instruction_tprot;
>> +	u64 instruction_tsch;
>>  	u64 instruction_sie;
>>  	u64 instruction_essa;
>>  	u64 instruction_sthyi;
> 
> If your goal is to catch all instructions, shouldn't you add a counter
> for diagnose functions that don't have a kernel handler as well?

Will add that on top.

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 913c8ac849206..c8b3c1aee7b5c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -367,6 +367,7 @@ struct kvm_vcpu_stat {
        u64 diagnose_258;
        u64 diagnose_308;
        u64 diagnose_500;
+       u64 diagnose_other;
 };
 
 #define PGM_OPERATION                  0x01
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 89aa114a2cbad..45634b3d2e0ae 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -257,6 +257,7 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
        case 0x500:
                return __diag_virtio_hypercall(vcpu);
        default:
+               vcpu->stat.diagnose_other++;
                return -EOPNOTSUPP;
        }
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 35e18d84e6828..648c6943cdfed 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -138,6 +138,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
        { "instruction_diag_258", VCPU_STAT(diagnose_258) },
        { "instruction_diag_308", VCPU_STAT(diagnose_308) },
        { "instruction_diag_500", VCPU_STAT(diagnose_500) },
+       { "instruction_diag_other", VCPU_STAT(diagnose_other) },
        { NULL }
 };
 



> 
> I've never used the counters much, but that change looks fine in
> general.

Whenever I have a performance issue, this is the first thing that I look at. :-)
