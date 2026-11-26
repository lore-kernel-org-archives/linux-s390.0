Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703890;
	b=WPsvAhRxCFsyvmbEdXnGIp4sb8qtoVIHe3LZxgantTjhTiLqWiZqjpwPMH/FJrvLdqA9
	 44sMOGPuGpuP/fiU/SAk0R62WIm5VpxuU6EiYL+2w+d0LvSjy3sKuaUYGtwd09Le2Cl9G
	 HACRsM5CttDzAWcjNy6IUrlu/FZ0P+B2dHxhZ09FbM8WSj5HiYO+k+QfVCoDrcR3S8Ij/
	 40p2W0MV2wY4zIdfd/KgehnBJh963A1L+tBDEPKv5ZB50tbHKjdngrtftsGLKRh6EEMlh
	 umQJnN/GC2nlncA0aVDEnjh/iim/5Jjl0hoVzEzA+toNtLtMTX9EiyxcSy60Do8NpaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703890;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TwYtFIIgARqtGbMM7qPTE29IrecbQ9zr89kNyuGkh8s=;
	b=fIMUz6S0V//6b324bv4X7Vz2SoXZELD1rCVzrn9n0RSqRNnIIAw+qsFoKyPMBlRO6urj
	 8UyMPrNlQrfi8e+8AOsBRfJdK1CFZzXpfuPIkHo919EU444OuBIawtd7TDdfEgyd4c2mM
	 5YKxFJSd8w66EDdIgO/DtHSGZuFFLGsZb53Ue9t1D3Dga45+zU69gQw9+m43ITk2PABn8
	 2U2isyb7qQFs0lFUMeP3qPNu2CmqalSWDGVuo04rO1Llkb5OOup4QkO0n+8Ce4Anum/2v
	 CItQS+UdMbixS57r8bGFGaztSmI2w3Ywr73qK+kkH8KXBX2tr6mY4/izmJx0hxJHjyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qBcCtccu;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036A606A32E;
	Thu, 26 Nov 2026 14:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E036A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qBcCtccu
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQEYaoX3001329;
	Thu, 26 Nov 2026 14:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TwYtFI
	IgARqtGbMM7qPTE29IrecbQ9zr89kNyuGkh8s=; b=qBcCtccuhOdZwEnpLZnn7/
	rLjOrKcvpDQtNOvT1K7DU3CXFWt1dIACTgb9yoluSCkgQH4p3Fvmu+6fe/BiUD10
	iiBg3fH3YjNsQ8bfKvIpierfwUA4jirUI/055Cs/lXFCESRdwY0+yrJXLLmWO+Pi
	+6QOTj4fpJKWsCJZORsqKJuDC7GxfKA99QNlV5HqGKX2jlVnjt5cTz+ST+53ccH2
	o45TNTnGDVjEZqC/r0x2UGT1e6p+dWeC6Z/M5AVfQ63+VvB7ghL9/u9wOhDibIze
	kcylGs3lpgTS1pnTMOB9SXySFRziKjaIAvQNsZEdE4j+Z+ptEpqcKq1qvFMV+t1A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3hqmn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 14:37:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQEYRT11733411;
	Thu, 26 Nov 2026 14:37:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx54b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 14:37:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQEbld649283426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 14:37:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71BD02004B;
	Thu, 26 Nov 2026 14:37:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D05D20040;
	Thu, 26 Nov 2026 14:37:47 +0000 (GMT)
Received: from p-imbrenda (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 26 Nov 2026 14:37:47 +0000 (GMT)
Date: Thu, 26 Nov 2026 15:37:45 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Yvan Janssens <yvanj@cyber.gent>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman
 <farman@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson
 <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] KVM: s390: selftests: Add a test for nested
 guests in ESA mode
Message-ID: <20261126153745.399d7f3d@p-imbrenda>
In-Reply-To: <20261125165604.3074595-3-yvanj@cyber.gent>
References: <20261125165604.3074595-1-yvanj@cyber.gent>
	<20261125165604.3074595-3-yvanj@cyber.gent>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b084441 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=iT8M5YjzDwDgK0uH:21 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=TfUWwnGe8vgNDgZCyUkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NyBTYWx0ZWRfX463DcQ9FW3w8
 4CD1gjYGe5cbHTnInJFa0hzmbLZQcZMsk0jh+Wl/QGuyqNUpyVN8OsSI340ybPdeYeTr8anEF3C
 V2DjfiUHZq7i/quCX1J7Z7A5LXp/1o8=
X-Proofpoint-ORIG-GUID: 6B-dCLwvQ5RuX7wWuRuAQyEWvGPt4g2g
X-Proofpoint-GUID: BPlFXjlmmVQRsmo6wtXFssUrmVrOXFJH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NyBTYWx0ZWRfX0ktblx3NA4pf
 4QnZX2B04tI/iM3wCIZc9DUAcLkCw9hOzrPYg6fdvd7/7TzsZIEl8Vn38ERflJHWZ5EHAo9fEo3
 bCOnLtgB8FJkDljQlMs9CjQvSsDuWfZJuI+Gkckyc13Cu5d2pnj+pz/4zaKSJz1bTNc6WYk7m+N
 8ja4/q37Ypc9/fW/KaqdA4jQZ0i6wDor6FBkK8rqt15xj+oAFAkl3ycCYjKHu4qzyrszmUHgDgD
 iiy38IQi0DVlEhlzuy91PTAvXttp5uAx8p9Zg0/PghyCk7Sq89zquapiA0I15CCH9GF61HZFCR6
 h+/GE5bYl1GzppBD98bgk9c26fw6wfxUTe/fBB5Az4ysjA2Oc2YgdQ8zR4gTBSkj29VSLa44fEL
 Jyuuu9zGDb2tD26b+qpqu+IbaGkjJGFS73cNM6aF6OYvD5aZjQGidepv/w+QprZ/U36EsuIN4q0
 Kbjgd1HCnue7Zl/00bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260057

On Wed, 25 Nov 2026 17:56:03 +0100
Yvan Janssens <yvanj@cyber.gent> wrote:

> Run a nested guest from a state description without the z/Architecture
> flag, with KVM_CAP_S390_VSIE_ESAMODE enabled, and let it execute STORE
> FACILITY LIST EXTENDED twice. vsie intercepts the first one of every SIE
> entry to shadow the facility list guest 2 designates and then has the
> instruction repeated.
> 
> The test checks that the second doubleword of the PSW field, which is not
> part of an ESA/390 PSW, comes back unchanged, that the PSW points behind
> the last instruction, and that the first instruction stored the
> designated list. What the second instruction stored is printed for
> diagnosis.
> 
> The test is skipped without the capability, without interpretive
> execution for the guest (SIEF2) and without facility 7 in the guest's
> model.

which KVM ioctls are you testing here?

are you sure that this is the right place for this test? my impression
is that this would be done more cleanly as a kvm-unit-test

> 
> Signed-off-by: Yvan Janssens <yvanj@cyber.gent>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/s390/vsie_esa_test.c        | 180 ++++++++++++++++++
>  2 files changed, 181 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390/vsie_esa_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 283c59d7649c..aef64ec2719c 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -227,6 +227,7 @@ TEST_GEN_PROGS_s390 += s390/shared_zeropage_test
>  TEST_GEN_PROGS_s390 += s390/ucontrol_test
>  TEST_GEN_PROGS_s390 += s390/user_operexec
>  TEST_GEN_PROGS_s390 += s390/keyop
> +TEST_GEN_PROGS_s390 += s390/vsie_esa_test
>  TEST_GEN_PROGS_s390 += rseq_test
>  TEST_GEN_PROGS_s390 += s390/irq_routing
>  TEST_GEN_PROGS_s390 += mmu_stress_test
> diff --git a/tools/testing/selftests/kvm/s390/vsie_esa_test.c b/tools/testing/selftests/kvm/s390/vsie_esa_test.c
> new file mode 100644
> index 000000000000..a52603e30f63
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/s390/vsie_esa_test.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test nested guests that run in ESA mode (KVM_CAP_S390_VSIE_ESAMODE).
> + *
> + * Guest 2 runs a guest 3 from a state description without the
> + * z/Architecture flag. Such a state description has the eight-byte ESA/390
> + * PSW in the first doubleword of the PSW field. vsie rewinds the PSW of
> + * guest 3 when it has to repeat an instruction; the test uses STORE FACILITY
> + * LIST EXTENDED, which vsie repeats after it has shadowed the facility list
> + * guest 2 designates.
> + */
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include "kvm_util.h"
> +#include "test_util.h"
> +#include "kselftest.h"
> +#include "sie.h"
> +#include "facility.h"
> +#include "ucall_common.h"
> +
> +#define G3_MEM_LEN	0x100000UL
> +/* mso/msl have 1MB granularity */
> +#define G3_MSO		0x10000000UL
> +#define G3_START	(2 * 0x1000UL)
> +/* where guest 3 stores its facility lists, in its first page */
> +#define G3_STFLE_1	0xf00
> +#define G3_STFLE_2	0xf80
> +
> +#define FAC_STFLE	7
> +
> +/* bit 12 of an ESA/390 PSW is one, bit 32 selects 31-bit addressing */
> +#define ESA_PSW_MASK	0x0008000080000000ULL
> +#define ESA_PSW_ADDR	0x000000007fffffffULL
> +
> +/* facility list for guest 3: only the first doubleword is looked at */
> +#define G3_FAC_0	0x4000100000000001ULL
> +
> +static const u8 g3_code[] = {
> +	0xa7, 0x08, 0x00, 0x00,			/* lhi   %r0,0 */
> +	0xb2, 0xb0, 0x0f, 0x00,			/* stfle G3_STFLE_1 */
> +	0xa7, 0x08, 0x00, 0x00,			/* lhi   %r0,0 */
> +	0xb2, 0xb0, 0x0f, 0x80,			/* stfle G3_STFLE_2 */
> +	0x83, 0x00, 0x00, 0x44,			/* diag  %r0,%r0,0x44 */
> +};
> +
> +static u64 scb_real;
> +
> +static void guest_code(void)
> +{
> +	while (1) {
> +		asm volatile("	sie	0(%[scb])\n"
> +			     :
> +			     : [scb] "a" (scb_real)
> +			     : "memory", "cc");
> +		GUEST_SYNC(0);
> +	}
> +}
> +
> +static void get_machine_feat(struct kvm_s390_vm_cpu_feat *feat)
> +{
> +	struct kvm_vm *vm = vm_create_barebones();
> +
> +	kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
> +			    KVM_S390_VM_CPU_MACHINE_FEAT, feat);
> +	kvm_vm_free(vm);
> +}
> +
> +static bool machine_has_sief2(void)
> +{
> +	struct kvm_s390_vm_cpu_feat feat = {};
> +
> +	get_machine_feat(&feat);
> +	return feat.feat[0] & (1ULL << (63 - KVM_S390_VM_CPU_FEAT_SIEF2));
> +}
> +
> +static bool machine_has_facility(int nr)
> +{
> +	struct kvm_s390_vm_cpu_processor proc = {};
> +	struct kvm_vm *vm = vm_create_barebones();
> +	bool ret;
> +
> +	kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
> +			    KVM_S390_VM_CPU_PROCESSOR, &proc);
> +	ret = test_bit_inv(nr, (unsigned long *)proc.fac_list);
> +	kvm_vm_free(vm);
> +	return ret;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_s390_vm_cpu_feat feat = {};
> +	struct kvm_s390_sie_block *scb;
> +	u64 *g3_page0, *fac_list;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	gva_t gva, fac_gva;
> +	u64 psw_end;
> +	struct ucall uc;
> +	void *code;
> +	int i;
> +
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_VSIE_ESAMODE));
> +	TEST_REQUIRE(machine_has_sief2());
> +	TEST_REQUIRE(machine_has_facility(FAC_STFLE));
> +
> +	ksft_print_header();
> +	ksft_set_plan(3);
> +
> +	/* SIEF2 must be enabled before the first vcpu is created */
> +	get_machine_feat(&feat);
> +	vm = vm_create(1);
> +	kvm_device_attr_set(vm->fd, KVM_S390_VM_CPU_MODEL,
> +			    KVM_S390_VM_CPU_PROCESSOR_FEAT, &feat);
> +	vm_enable_cap(vm, KVM_CAP_S390_VSIE_ESAMODE, 0);
> +	vcpu = vm_vcpu_add(vm, 0, guest_code);
> +
> +	gva = vm_alloc_page(vm);
> +	scb = addr_gva2hva(vm, gva);
> +	memset(scb, 0, getpagesize());
> +	scb_real = addr_gva2gpa(vm, gva);
> +	sync_global_to_guest(vm, scb_real);
> +
> +	fac_gva = vm_alloc_page(vm);
> +	fac_list = addr_gva2hva(vm, fac_gva);
> +	memset(fac_list, 0, getpagesize());
> +	fac_list[0] = G3_FAC_0;
> +
> +	/* guest 3: two prefix pages and one page of code */
> +	for (i = 0; i < 3; i++) {
> +		gpa_t gpa = vm_phy_page_alloc(vm, MEM_REGION_TEST_DATA);
> +
> +		virt_pg_map(vm, G3_MSO + i * getpagesize(), gpa);
> +		memset(addr_gpa2hva(vm, gpa), 0, getpagesize());
> +		if (i == 0)
> +			g3_page0 = addr_gpa2hva(vm, gpa);
> +		if (i == 2)
> +			code = addr_gpa2hva(vm, gpa);
> +	}
> +	memcpy(code, g3_code, sizeof(g3_code));
> +
> +	scb->cpuflags = CPUSTAT_RUNNING;
> +	scb->ihcpu = 0xffff;
> +	scb->mso = G3_MSO;
> +	scb->msl = G3_MSO + ((G3_MEM_LEN - 1) & ~0xfffffUL);
> +	scb->psw_mask = ESA_PSW_MASK | G3_START;
> +	scb->psw_addr = 0;
> +	scb->fac = addr_gva2gpa(vm, fac_gva);
> +	TEST_ASSERT(!(scb->fac & 7) && addr_gva2gpa(vm, fac_gva) < (1UL << 31),
> +		    "facility list not usable for a designation");
> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
> +	/*
> +	 * The capability does not tell whether the machine (or the hypervisor
> +	 * this host is a guest of) runs a state description without the
> +	 * z/Architecture flag. If not, it answers with validity 0x0001.
> +	 */
> +	if (scb->icptcode == ICPT_VALIDITY && (scb->ipb >> 16) == 0x0001)
> +		ksft_exit_skip("the host cannot run nested guests in ESA mode (validity 0x0001)\n");
> +	TEST_ASSERT(scb->icptcode == ICPT_INST && scb->ipa == 0x8300,
> +		    "guest 3: icptcode 0x%02x ipa 0x%04x ipb 0x%08x psw 0x%016llx 0x%016llx",
> +		    scb->icptcode, scb->ipa, scb->ipb, scb->psw_mask, scb->psw_addr);
> +
> +	psw_end = ESA_PSW_MASK | (G3_START + sizeof(g3_code));
> +	ksft_test_result(scb->psw_addr == 0,
> +			 "second PSW doubleword of the ESA mode guest untouched (0x%llx)\n",
> +			 scb->psw_addr);
> +	ksft_test_result((scb->psw_mask & ~0x0000300000000000ULL) == psw_end,
> +			 "ESA/390 PSW after the last instruction (0x%llx)\n",
> +			 scb->psw_mask);
> +	ksft_print_msg("second STFLE stored 0x%lx\n",
> +		       g3_page0[G3_STFLE_2 / sizeof(u64)]);
> +	ksft_test_result(g3_page0[G3_STFLE_1 / sizeof(u64)] == G3_FAC_0,
> +			 "first STFLE of the ESA mode guest executed (0x%lx)\n",
> +			 g3_page0[G3_STFLE_1 / sizeof(u64)]);
> +
> +	kvm_vm_free(vm);
> +	ksft_finished();
> +}

