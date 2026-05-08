Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C913E3DA9;
	Fri,  8 May 2026 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246733; cv=none; b=hQcd5QExWgA6NjlhTYYsIg0QnSHUhP8OfLHRNRjDlQQMmSb+al72aBa/B2LlqSRwYoece79QypfMsvKr4AqovHLramcnfi0eSToc3rbst+yy4LUNH/f7JI7qCFbRYQUPymAPiuhkmQ+rAT0AWFzBPNjRzkPlAMJFkzbFFEvfYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246733; c=relaxed/simple;
	bh=TbxRhXrZVjXIg2jkCQ+Lj3a0haNTs4sB3Its3VkIoKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4AUzTKGLJ6ACrPF5vg1ayXH7SirjheGcTAqzWK3hP9+vfEzrlyu1KFpKf4dJNTJQ2wHcmQ8u6bDwhVhMnjJ0nDyj+AZJGn02MaFSRrs5act0TI87B57f2rnY4GgX+2zqeo1m5RUkMQvQi6HKda6lN6p1YU5d/WYQPfyDHftBss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kE4cbQx0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kE4cbQx0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6486Ta1H1531488;
	Fri, 8 May 2026 13:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bcw4Lp
	xZ5p5qk0ACsnIlB/lvzXcRVMy58Dp00PgHetI=; b=kE4cbQx0tIc25rAobhQB1T
	mktkStktTFif1CryUTGZ+YzD9XBLh27mXid4mTijCZtSl5dcBYdXZHloDhWzlVkk
	pOcRoSfI7BQxxaLrijhYCDMKgAjvCL+Cfo+5Merl/DhsFssYdzb0IShtE38pXjsr
	7JV+NKnKPXXIT6vDZlhJX68FazwdTIVqt+/7tckyzdauvsPpSejkBCYqEWfDWp0D
	PDnWkzxU83/Rl9v+YvK6xvVdwQ95EgSB0lublXExHot4ppVHEmskjZ/cYMAgpQkK
	nKolF4GG+PjCTDtyetS6P8o+J1lTXbDEoBoqqm/AczTkrzoaB7MNRwOWIgFVz2kg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x53vk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 13:25:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648DOTYQ018391;
	Fri, 8 May 2026 13:25:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hg8fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 13:25:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648DPL2a51904946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 13:25:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 116D720040;
	Fri,  8 May 2026 13:25:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BC5B2004F;
	Fri,  8 May 2026 13:25:20 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.47.82])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  8 May 2026 13:25:20 +0000 (GMT)
Date: Fri, 8 May 2026 12:30:09 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: s390: selftests: Extended user_operexec
 tests
Message-ID: <20260508123009.50b406be@p-imbrenda>
In-Reply-To: <20260507200836.3500368-3-farman@linux.ibm.com>
References: <20260507200836.3500368-1-farman@linux.ibm.com>
	<20260507200836.3500368-3-farman@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEzNiBTYWx0ZWRfXysqBQtVsjF3x
 E7r0NR8fR6Umm9nxsYASZT359NaGQBwzxNvdoBTpfqn4ycc+vxzn+SeDUlWiLc4z1FKYMR8Rh1S
 0G8zrTZGm+RNAWYcvDgXlhLIu0zaSzI1Pizda7bclMaP45Rwb+bOpYFo5Z9jj/Ih6LyZtqztexG
 zcv3fDAPtUGwNjMgFM/Ldu+6k2rROHNWHbM++lNX8AJj/qcNmeY7vhE6TuW5EDmbcpfxPsSZ5R3
 qt65AkHS/nQvgaUF6JRumnR7unN+N+UOv8iZiEibf7Ih6Hk+VgT7e9W2aTLUVTOyu0O4EjcaqpF
 mQExUwZ8L7+2uThtTsXRvczr9IM15c0uX3jjwPzC3UlrzOfSTmgzV6aqJJHX0UX4FAj8QElfuBY
 E65GlNqLesvI1JeMGVSNc118PkhYd6Ltkcg0Sse1yKSO4aruyOOypICCHDx52iJWi6Xs2L4lPTs
 ixTWfVa1vNOL2O7YXfg==
X-Proofpoint-ORIG-GUID: tCuT2o3cYkuyUChtYvywOYMoUWQJaxez
X-Proofpoint-GUID: tCuT2o3cYkuyUChtYvywOYMoUWQJaxez
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fde446 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=sPCGW8O3KLxBFVHUMcMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080136

On Thu,  7 May 2026 22:08:35 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> There is a possibility that the user_operexec capability
> only works if facility bit 74 is enabled. This is now fixed,
> but add a selftest to demonstrate that.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


> ---
>  .../selftests/kvm/include/s390/facility.h     |   6 +
>  .../selftests/kvm/s390/user_operexec.c        | 110 ++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/s390/facility.h b/tools/testing/selftests/kvm/include/s390/facility.h
> index 41a265742666..e5259f63be22 100644
> --- a/tools/testing/selftests/kvm/include/s390/facility.h
> +++ b/tools/testing/selftests/kvm/include/s390/facility.h
> @@ -11,6 +11,7 @@
>  #ifndef SELFTEST_KVM_FACILITY_H
>  #define SELFTEST_KVM_FACILITY_H
>  
> +#include <linux/atomic.h>
>  #include <linux/bitops.h>
>  
>  /* alt_stfle_fac_list[16] + stfle_fac_list[16] */
> @@ -19,6 +20,11 @@
>  extern u64 stfl_doublewords[NB_STFL_DOUBLEWORDS];
>  extern bool stfle_flag;
>  
> +static inline bool clear_bit_inv(unsigned long nr, unsigned long *ptr)
> +{
> +	return clear_bit(nr ^ (BITS_PER_LONG - 1), ptr);
> +}
> +
>  static inline bool test_bit_inv(unsigned long nr, const unsigned long *ptr)
>  {
>  	return test_bit(nr ^ (BITS_PER_LONG - 1), ptr);
> diff --git a/tools/testing/selftests/kvm/s390/user_operexec.c b/tools/testing/selftests/kvm/s390/user_operexec.c
> index 714906c1d12a..b24c1f9dbbe8 100644
> --- a/tools/testing/selftests/kvm/s390/user_operexec.c
> +++ b/tools/testing/selftests/kvm/s390/user_operexec.c
> @@ -6,6 +6,7 @@
>   * Authors:
>   *  Janosch Frank <frankja@linux.ibm.com>
>   */
> +#include "facility.h"
>  #include "kselftest.h"
>  #include "kvm_util.h"
>  #include "test_util.h"
> @@ -109,6 +110,111 @@ static void test_user_operexec_combined(void)
>  	kvm_vm_free(vm);
>  }
>  
> +static struct kvm_vm *create_vm_without_sthyi(void)
> +{
> +	struct kvm_s390_vm_cpu_processor info;
> +	struct kvm_vm *vm;
> +
> +	vm = vm_create(1);
> +
> +	kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
> +			    KVM_S390_VM_CPU_PROCESSOR, &info);
> +
> +	clear_bit_inv(74, (unsigned long *)&info.fac_list);
> +	kvm_device_attr_set(vm->fd, KVM_S390_VM_CPU_MODEL,
> +			    KVM_S390_VM_CPU_PROCESSOR, &info);
> +
> +	return vm;
> +}
> +
> +static void test_user_instr0_no_stfle_74(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	int rc;
> +
> +	vm = create_vm_without_sthyi();
> +
> +	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_INSTR0, 0);
> +	TEST_ASSERT_EQ(0, rc);
> +
> +	vcpu = vm_vcpu_add(vm, 0, guest_code_instr0);
> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_S390_SIEIC);
> +	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, ICPT_OPEREXC);
> +	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipa, 0x0000);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +static void test_user_operexec_no_stfle_74(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	int rc;
> +
> +	vm = create_vm_without_sthyi();
> +
> +	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_OPEREXEC, 0);
> +	TEST_ASSERT_EQ(0, rc);
> +
> +	vcpu = vm_vcpu_add(vm, 0, guest_code_user_operexec);
> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_S390_SIEIC);
> +	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, ICPT_OPEREXC);
> +	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipa, 0x0807);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +static void test_instr0_combined_no_stfle_74(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	int rc;
> +
> +	vm = create_vm_without_sthyi();
> +
> +	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_INSTR0, 0);
> +	TEST_ASSERT_EQ(0, rc);
> +	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_OPEREXEC, 0);
> +	TEST_ASSERT_EQ(0, rc);
> +
> +	vcpu = vm_vcpu_add(vm, 0, guest_code_instr0);
> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_S390_SIEIC);
> +	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, ICPT_OPEREXC);
> +	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipa, 0x0000);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +static void test_operexec_combined_no_stfle_74(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	int rc;
> +
> +	vm = create_vm_without_sthyi();
> +
> +	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_INSTR0, 0);
> +	TEST_ASSERT_EQ(0, rc);
> +	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_OPEREXEC, 0);
> +	TEST_ASSERT_EQ(0, rc);
> +
> +	vcpu = vm_vcpu_add(vm, 0, guest_code_user_operexec);
> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_S390_SIEIC);
> +	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, ICPT_OPEREXC);
> +	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipa, 0x0807);
> +
> +	kvm_vm_free(vm);
> +}
> +
>  /*
>   * Run all tests above.
>   *
> @@ -122,6 +228,10 @@ static struct testdef {
>  	{ "instr0", test_user_instr0 },
>  	{ "operexec", test_user_operexec },
>  	{ "operexec_combined", test_user_operexec_combined},
> +	{ "instr0_no_stfle_74", test_user_instr0_no_stfle_74 },
> +	{ "instr0_combined_no_stfle_74", test_instr0_combined_no_stfle_74 },
> +	{ "operexec_combined_no_stfle_74", test_operexec_combined_no_stfle_74 },
> +	{ "operexec_no_stfle_74", test_user_operexec_no_stfle_74 },
>  };
>  
>  int main(int argc, char *argv[])

