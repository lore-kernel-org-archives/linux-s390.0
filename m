Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092592;
	b=2KrOX8gGy6SewGrAwmGea9SPyBxtnGHES+b00ZPO56DGpTsHqR0zjp4rKtfTHEVj3+hH
	 Zhu4feA3FWXrH2Hn48UW9XiE3VHu4amdSR+c4jkepZR6wvP+BaRLdOK22nqypyMNKjcSi
	 1NuLqdqAPOxJpU1mYAiSVYbJYQb9v81aO8jZMttq/YiaH6Ee9G+5y1LXM74inAc5nbWUV
	 mn4ykW5oh7tY/PPLh0+E0ZtAYJx3LQKPAWVtQFNi5AtgA3z4tp83tuB44aeoieT0VWiA5
	 pufpKnA7jA6SHdDf1iIHFNPtbm3TQxb/N8GsN5nLaaeQdCYCs4aKGXgR0w2aPnjQ1dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092592;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wc5Z+Bgvfy/RM5eyK1PuRjqykhiLXUkN1T3bZmEmzPA=;
	b=QpwGMyGJ0eiMmJQT4/9FRpHtaOjOWfx8eAhOcwwWmO+/mGyr9sCzuX2Q9lq9lOJJnVDV
	 tThXJzqkw+XxcyTfKXSav5dZq6CIGltAIKY6zoP7V123bKLUN7KbDNvt5BaX4HtXCCZ6t
	 xA+UdCZUWI7WEu6M9DAoI1uRvu6XitOLkASsSRhASn5yOJxYG7+kaqyB/4cO+3uDCvgZo
	 vRrFKvAHCqjNRmO1jMS9HJ6BNkTtjTo7fLyvcgQaxlZ/ijTc4Ut4XYz1mZcNEM5g+CcrK
	 mr3vSjfMQN4eQnwCvTbIrUNdCgK81oxNPCAnMgouak1sWkzgCEGwQ9YsU20WJ4B9Bfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EuGCzCtZ;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45E606A335;
	Thu, 19 Nov 2026 12:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE45E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EuGCzCtZ
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBuAZQ2870932;
	Thu, 19 Nov 2026 12:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wc5Z+Bgvfy/RM5eyK
	1PuRjqykhiLXUkN1T3bZmEmzPA=; b=EuGCzCtZeXIHD5dPxYwTQ0DdIzJ4+saAH
	pk+rsxjafMH5SSQomQFOmVX9md1pawJMQdOgnzZThoR1J4ZpRYkwc4MJEn+tAgQG
	QIj21dn1SngUPdITkfyqS0RyVAmL7FC0HKedvgpRH0qHsgvqDmAu2rpPeT4nflXQ
	g67pk+nx/T+yrrB6dLp1I/abacV2ey/q9Uv/0Dgkwl7BXu+PoaYDtomyJonevxh8
	JUIWSYqqQKBCzSliNAusp/ns4ayNiLVyGW1YBh4UHWLs7QrC8opa8kh+6NbVV9oL
	mh9ApZcg5DYjjHORr6GjCp1GpXDgsU2CSJ/EGp+nNtNVwQM5OmafQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w0s8r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 12:49:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJC4ugs2919237;
	Thu, 19 Nov 2026 12:49:46 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvqjwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 12:49:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJCnjEe721618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 12:49:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AC985805D;
	Thu, 19 Nov 2026 12:49:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A95FC58056;
	Thu, 19 Nov 2026 12:49:42 +0000 (GMT)
Received: from b46lp13.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 12:49:42 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, pbonzini@redhat.com,
        seanjc@google.com, shuah@kernel.org, ggala@linux.ibm.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] KVM: s390: selftests: Add vsie validity interception tests
Date: Thu, 19 Nov 2026 13:49:36 +0100
Message-ID: <20261119124936.33396-3-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119124936.33396-1-ggala@linux.ibm.com>
References: <20261119124936.33396-1-ggala@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1Dw7H4BqaW4FAurYochlaJUR1L96TCWu
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afef06b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=50UqINU-3ndPhjj9g14A:9
X-Proofpoint-ORIG-GUID: TLAIZCLP5FSOy_1jaqDcPXcPeL1fL2r6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfX+3xH5sq7IYuj
 AF/uFTreP8TP8ha5n27E0A1vwQ2ElN2TD0A2f0RlcM6Jl0wOlt+Z/c+6FZqG+IRRzp1UJ7CzNHV
 r/iOOqsuWOrC91zCYo4mZ8psaSYjXrI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfX6SmUp8V1yrRG
 gtFGXU2QFJjFzhL0uO4h95fbFtipg1Fb1Jjokd1OBa1ayLxbq1qf6Ob6Zg4zM7tQHoAOu3y3DnN
 xQVy46p5GrbsDQqY8WmIAjapk2FTzb9qqWOm+PVNDu5hxMt3YKTzy732bTxfHq5ltywSelDku2i
 F/7qGv1wJMYKOoyrvQoXbiAHssuXwAz4m3BHBvUfcr6GScwv0qS1lg4k5Zc05zTJSUB6VgQxSXB
 ReZTg6apyHnPVhQUOUEMvitq2uNFLaAKD8T+5w6gtiCspkB4AzKyrwQ+Qxy9yaZQFq15MHqhcNV
 1ABmBHOt9HLp3qTRhzKGKhP+GWaZuhOUaIoTwC/19CuBkHdrdiWgwC6FQGrlsyXkcP+yCU4bxjo
 ZgaSMA+EWH9AkC/p2KSOWlyOFTvsuhyv307p/LQSO1eP8R3Z9042NtOLg+1AniUfDIeLzhpZMWc
 PdDjl8+I1g0ZQlZy9gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190049

Add tests for validity interceptions raised during vsie shadow SCB
setup. An interception raised before any guest 3 state has been copied
into the shadow SCB must report only the interception data (icptcode,
ipa, ipb) to guest 2. It must not write back guest 3 state, in
particular cpuflags, ihcpu and icptstatus.

Check the early validity interception with a new and a cached vsie
page, for the RRF, SLSV, GED+GED2 and ESA mode cases. The cached case
leaves stale state in the shadow SCB (for example a non-zero
icptstatus), so that a bogus write back to guest 2 is detected.

Also check that a valid guest 3 still has its state written back, and
that validity interceptions raised later (shadow_crycb(), pin_blocks(),
unmapped prefix) still report the reason code and leave the SCB
unchanged.

The early validity cases fail without the preceding vsie fix. Skip the
test if SIEF2 is not available, and skip the GED+GED2 and CRYCB cases
if facility 78 or 76 is missing.

Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/s390/vsie_validity_test.c   | 435 ++++++++++++++++++
 2 files changed, 436 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390/vsie_validity_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..e9b1fec3903f 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -227,6 +227,7 @@ TEST_GEN_PROGS_s390 += s390/shared_zeropage_test
 TEST_GEN_PROGS_s390 += s390/ucontrol_test
 TEST_GEN_PROGS_s390 += s390/user_operexec
 TEST_GEN_PROGS_s390 += s390/keyop
+TEST_GEN_PROGS_s390 += s390/vsie_validity_test
 TEST_GEN_PROGS_s390 += rseq_test
 TEST_GEN_PROGS_s390 += s390/irq_routing
 TEST_GEN_PROGS_s390 += mmu_stress_test
diff --git a/tools/testing/selftests/kvm/s390/vsie_validity_test.c b/tools/testing/selftests/kvm/s390/vsie_validity_test.c
new file mode 100644
index 000000000000..0a6d85d19555
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390/vsie_validity_test.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test vsie validity interceptions raised while the shadow SCB is set up.
+ *
+ * A validity interception raised by prepare_cpuflags() happens before any
+ * guest 3 state is copied into the shadow SCB. Only icptcode, ipa and ipb
+ * may change in the guest 2 SCB; the guest 3 state, icptstatus and ihcpu
+ * must not be overwritten with the contents of the shadow SCB.
+ */
+#include <stdio.h>
+#include <string.h>
+
+#include "kvm_util.h"
+#include "test_util.h"
+#include "kselftest.h"
+#include "sie.h"
+#include "facility.h"
+#include "ucall_common.h"
+
+#define G3_MEM_LEN	0x100000UL
+/* mso/msl have 1MB granularity */
+#define G3_MSO		0x10000000UL
+
+#define FAC_CRYPTO_KEYS	76
+#define FAC_GED2	78
+
+#define ADDR_BELOW_2_PAGES	0x1000UL
+
+#define G3_START	(2 * 0x1000UL)
+#define G3_CODE_LEN	12
+
+static u64 scb_real;
+
+static void guest_code(void)
+{
+	while (1) {
+		asm volatile("	sie	0(%[scb])\n"
+			     :
+			     : [scb] "a" (scb_real)
+			     : "memory", "cc");
+		GUEST_SYNC(0);
+	}
+}
+
+struct ctx {
+	struct kvm_s390_sie_block *scb;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u64 scb_real;
+	void *code;
+};
+
+static void get_machine_feat(struct kvm_s390_vm_cpu_feat *feat)
+{
+	struct kvm_vm *vm = vm_create_barebones();
+
+	kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
+			    KVM_S390_VM_CPU_MACHINE_FEAT, feat);
+	kvm_vm_free(vm);
+}
+
+static int machine_has_sief2(void)
+{
+	struct kvm_s390_vm_cpu_feat feat = {};
+
+	get_machine_feat(&feat);
+	return !!(feat.feat[0] & (1ULL << (63 - KVM_S390_VM_CPU_FEAT_SIEF2)));
+}
+
+static bool machine_has_facility(int nr)
+{
+	struct kvm_s390_vm_cpu_processor proc = {};
+	struct kvm_vm *vm = vm_create_barebones();
+	bool ret;
+
+	kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
+			    KVM_S390_VM_CPU_PROCESSOR, &proc);
+	ret = test_bit_inv(nr, (unsigned long *)proc.fac_list);
+	kvm_vm_free(vm);
+	return ret;
+}
+
+/*
+ * Without the prefix pages mapped, vsie cannot shadow them and raises
+ * validity 0x0037.
+ */
+static struct ctx *ctx_create(bool map_prefix)
+{
+	struct kvm_s390_vm_cpu_feat feat = {};
+	struct ctx *c = calloc(1, sizeof(*c));
+	gva_t scb_gva;
+	int i;
+
+	/* SIEF2 must be enabled before the first vcpu is created */
+	get_machine_feat(&feat);
+
+	c->vm = vm_create(1);
+	kvm_device_attr_set(c->vm->fd, KVM_S390_VM_CPU_MODEL,
+			    KVM_S390_VM_CPU_PROCESSOR_FEAT, &feat);
+	c->vcpu = vm_vcpu_add(c->vm, 0, guest_code);
+
+	scb_gva = vm_alloc_page(c->vm);
+	c->scb = addr_gva2hva(c->vm, scb_gva);
+	memset(c->scb, 0, getpagesize());
+	c->scb_real = addr_gva2gpa(c->vm, scb_gva);
+	scb_real = c->scb_real;
+	sync_global_to_guest(c->vm, scb_real);
+
+	for (i = 0; i < 3; i++) {
+		gpa_t gpa;
+
+		if (i < 2 && !map_prefix)
+			continue;
+		gpa = vm_phy_page_alloc(c->vm, MEM_REGION_TEST_DATA);
+		virt_pg_map(c->vm, G3_MSO + i * getpagesize(), gpa);
+		if (i == 2)
+			c->code = addr_gpa2hva(c->vm, gpa);
+	}
+	return c;
+}
+
+static void ctx_destroy(struct ctx *c)
+{
+	kvm_vm_free(c->vm);
+	free(c);
+}
+
+static void run_sie(struct ctx *c)
+{
+	struct ucall uc;
+
+	vcpu_run(c->vcpu);
+	TEST_ASSERT_EQ(get_ucall(c->vcpu, &uc), UCALL_SYNC);
+}
+
+static void setup_guest3(struct ctx *c)
+{
+	static const u8 g3_code[G3_CODE_LEN] = {
+		0xc6, 0x00, 0x00, 0x00, 0x00, 0x04,	/* exrl %r0,.+8 */
+		0x07, 0x07,
+		0x83, 0x00, 0x00, 0x44,			/* diag %r0,%r0,0x44 */
+	};
+
+	memcpy(c->code, g3_code, sizeof(g3_code));
+	memset(c->scb, 0, sizeof(*c->scb));
+	c->scb->cpuflags = CPUSTAT_ZARCH | CPUSTAT_RUNNING;
+	c->scb->ihcpu = 0xffff;
+	c->scb->mso = G3_MSO;
+	c->scb->msl = G3_MSO + ((G3_MEM_LEN - 1) & ~0xfffffUL);
+	c->scb->psw_mask = 0x180000000ULL;
+	c->scb->psw_addr = G3_START;
+	c->scb->gg14 = 0xccccccccccccccccULL;
+	c->scb->gg15 = 0xddddddddddddddddULL;
+	c->scb->gcr[0] = 0x40000;
+	c->scb->cputm = 0x00ffffffffffffffULL;
+	c->scb->ckc = 0x00eeeeeeeeeeeeeeULL;
+	c->scb->todpr = 0x12345678;
+	c->scb->pp = 0x0badc0de0badc0deULL;
+	c->scb->gbea = 0x0123456789abcdefULL;
+	c->scb->fpf = FPF_BPBC;
+}
+
+/* The intercept is reported for the EXECUTE target and sets icptstatus. */
+static void run_guest3(struct ctx *c)
+{
+	setup_guest3(c);
+	run_sie(c);
+	TEST_ASSERT(c->scb->icptcode == ICPT_INST,
+		    "guest 3 run: icptcode 0x%02x ipa 0x%04x ipb 0x%08x",
+		    c->scb->icptcode, c->scb->ipa, c->scb->ipb);
+	TEST_ASSERT(c->scb->icptstatus,
+		    "guest 3 run: expected a non-zero icptstatus, got 0");
+}
+
+static void fill_state(struct kvm_s390_sie_block *s, u64 seed)
+{
+	int i;
+
+	s->psw_mask = 0x1111111111111111ULL ^ seed;
+	s->psw_addr = 0x2222222222222222ULL ^ seed;
+	s->gg14 = 0x4444444444444444ULL ^ seed;
+	s->gg15 = 0x5555555555555555ULL ^ seed;
+	for (i = 0; i < 16; i++)
+		s->gcr[i] = 0x1000000000000000ULL + i + seed;
+	s->cputm = 0x6666666666666666ULL ^ seed;
+	s->ckc = 0x7777777777777777ULL ^ seed;
+	s->todpr = 0x88888888 ^ (u32)seed;
+	s->pp = 0x9999999999999999ULL ^ seed;
+	s->gbea = 0x3333333333333333ULL ^ seed;
+	s->fpf = FPF_BPBC;
+	s->ihcpu = 0x7b3d ^ (u16)seed;
+}
+
+static int field_changed(const char *name, const void *act, const void *exp,
+			 size_t len)
+{
+	if (!memcmp(act, exp, len))
+		return 0;
+
+	ksft_print_msg("%s changed unexpectedly\n", name);
+	return 1;
+}
+
+/*
+ * icptstatus is not set by a validity interception raised by vsie itself and
+ * must not carry over from an earlier interception of a cached shadow SCB.
+ */
+static int check_preserved(struct kvm_s390_sie_block *act,
+			   struct kvm_s390_sie_block *saved)
+{
+	struct kvm_s390_sie_block exp = *saved;
+	int bad = 0;
+
+	exp.icptcode = act->icptcode;
+	exp.ipa = act->ipa;
+	exp.ipb = act->ipb;
+
+	if (act->icptstatus) {
+		ksft_print_msg("icptstatus 0x%02x, expected 0\n", act->icptstatus);
+		bad++;
+	}
+	exp.icptstatus = act->icptstatus;
+
+	bad += field_changed("psw_mask", &act->psw_mask, &exp.psw_mask,
+			     sizeof(exp.psw_mask));
+	bad += field_changed("psw_addr", &act->psw_addr, &exp.psw_addr,
+			     sizeof(exp.psw_addr));
+	bad += field_changed("gg14", &act->gg14, &exp.gg14, sizeof(exp.gg14));
+	bad += field_changed("gg15", &act->gg15, &exp.gg15, sizeof(exp.gg15));
+	bad += field_changed("gcr", act->gcr, exp.gcr, sizeof(exp.gcr));
+	bad += field_changed("cputm", &act->cputm, &exp.cputm,
+			     sizeof(exp.cputm));
+	bad += field_changed("ckc", &act->ckc, &exp.ckc, sizeof(exp.ckc));
+	bad += field_changed("todpr", &act->todpr, &exp.todpr,
+			     sizeof(exp.todpr));
+	bad += field_changed("pp", &act->pp, &exp.pp, sizeof(exp.pp));
+	bad += field_changed("gbea", &act->gbea, &exp.gbea, sizeof(exp.gbea));
+	bad += field_changed("fpf", &act->fpf, &exp.fpf, sizeof(exp.fpf));
+	bad += field_changed("ihcpu", &act->ihcpu, &exp.ihcpu,
+			     sizeof(exp.ihcpu));
+
+	if (!bad && memcmp(&exp, act, sizeof(exp))) {
+		ksft_print_msg("SCB modified outside the checked fields\n");
+		bad++;
+	}
+	return bad;
+}
+
+static int check_validity(struct kvm_s390_sie_block *scb, u16 reason)
+{
+	if (scb->icptcode == ICPT_VALIDITY && scb->ipa == 0x1000 &&
+	    (scb->ipb >> 16) == reason)
+		return 0;
+
+	ksft_print_msg("expected validity 0x%04x, got icptcode 0x%02x ipa 0x%04x ipb 0x%08x\n",
+		       reason, scb->icptcode, scb->ipa, scb->ipb);
+	return 1;
+}
+
+static int run_early_validity(struct ctx *c, u32 cpuflags, u16 reason, u64 seed)
+{
+	struct kvm_s390_sie_block saved;
+
+	fill_state(c->scb, seed);
+	c->scb->cpuflags = cpuflags | CPUSTAT_RUNNING;
+	saved = *c->scb;
+
+	run_sie(c);
+	return check_validity(c->scb, reason) + check_preserved(c->scb, &saved);
+}
+
+static int test_new_page(int cpuflags)
+{
+	struct ctx *c = ctx_create(true);
+	u16 reason = 0x0001;
+	int bad;
+
+	if (cpuflags & CPUSTAT_SLSV)
+		reason = 0x0007;
+	bad = run_early_validity(c, cpuflags, reason, cpuflags);
+	ctx_destroy(c);
+	return bad;
+}
+
+static int test_cached(int unused)
+{
+	struct ctx *c = ctx_create(true);
+	int bad;
+
+	run_guest3(c);
+	bad = run_early_validity(c, CPUSTAT_ZARCH | CPUSTAT_RRF, 0x0001,
+				 0xa5a5a5a5a5a5a5a5ULL);
+
+	run_guest3(c);
+	ctx_destroy(c);
+	return bad;
+}
+
+static int test_writeback(int unused)
+{
+	struct ctx *c = ctx_create(true);
+	struct kvm_s390_sie_block saved;
+	int bad = 0;
+
+	setup_guest3(c);
+	saved = *c->scb;
+	run_sie(c);
+
+	if (c->scb->icptcode != ICPT_INST || c->scb->ipa != 0x8300) {
+		ksft_print_msg("expected DIAG intercept, got icptcode 0x%02x ipa 0x%04x\n",
+			       c->scb->icptcode, c->scb->ipa);
+		bad++;
+	}
+	if (!c->scb->icptstatus) {
+		ksft_print_msg("expected icptstatus of the EXECUTE target, got 0\n");
+		bad++;
+	}
+	if (c->scb->psw_addr <= G3_START ||
+	    c->scb->psw_addr > G3_START + G3_CODE_LEN) {
+		ksft_print_msg("psw_addr 0x%llx, expected 0x%lx < addr <= 0x%lx\n",
+			       c->scb->psw_addr, G3_START, G3_START + G3_CODE_LEN);
+		bad++;
+	}
+	if (c->scb->gg14 != saved.gg14 || c->scb->gg15 != saved.gg15 ||
+	    memcmp(c->scb->gcr, saved.gcr, sizeof(saved.gcr))) {
+		ksft_print_msg("gg14, gg15 or gcr differ from what guest 3 ran with\n");
+		bad++;
+	}
+	ctx_destroy(c);
+	return bad;
+}
+
+/*
+ * Late validity interceptions are raised after the state was shadowed, so
+ * unshadow_scb() copies it back and must not alter what guest 2 provided.
+ */
+static int test_late_crycb(int cached)
+{
+	struct ctx *c = ctx_create(true);
+	struct kvm_s390_sie_block saved;
+	int bad;
+
+	if (cached)
+		run_guest3(c);
+
+	fill_state(c->scb, 0x5a5a5a5a5a5a5a5aULL);
+	c->scb->cpuflags = CPUSTAT_ZARCH | CPUSTAT_RUNNING;
+	c->scb->crycbd = CRYCB_FORMAT1;
+	saved = *c->scb;
+
+	run_sie(c);
+	bad = check_validity(c->scb, 0x0039) + check_preserved(c->scb, &saved);
+	ctx_destroy(c);
+	return bad;
+}
+
+static int test_late_pin_blocks(int unused)
+{
+	struct ctx *c = ctx_create(true);
+	struct kvm_s390_sie_block saved;
+	int bad;
+
+	fill_state(c->scb, 0x6b6b6b6b6b6b6b6bULL);
+	c->scb->cpuflags = CPUSTAT_ZARCH | CPUSTAT_RUNNING;
+	c->scb->scaol = ADDR_BELOW_2_PAGES;
+	saved = *c->scb;
+
+	run_sie(c);
+	bad = check_validity(c->scb, 0x0038) + check_preserved(c->scb, &saved);
+	ctx_destroy(c);
+	return bad;
+}
+
+static int test_prefix_unmapped(int unused)
+{
+	struct ctx *c = ctx_create(false);
+	struct kvm_s390_sie_block saved;
+	int bad;
+
+	setup_guest3(c);
+	saved = *c->scb;
+
+	run_sie(c);
+	bad = check_validity(c->scb, 0x0037) + check_preserved(c->scb, &saved);
+	ctx_destroy(c);
+	return bad;
+}
+
+static const struct testdef {
+	const char *name;
+	int (*test)(int arg);
+	int arg;
+	int facility;
+} testlist[] = {
+	{ "early validity icpt (RRF) with a new vsie page", test_new_page,
+	  CPUSTAT_ZARCH | CPUSTAT_RRF },
+	{ "early validity icpt (SLSV) with a new vsie page", test_new_page,
+	  CPUSTAT_ZARCH | CPUSTAT_SLSV },
+	{ "early validity icpt (GED+GED2) with a new vsie page", test_new_page,
+	  CPUSTAT_ZARCH | CPUSTAT_GED | CPUSTAT_GED2, FAC_GED2 },
+	{ "early validity icpt (ESA mode) with a new vsie page", test_new_page, 0 },
+	{ "early validity icpt with a cached vsie page", test_cached },
+	{ "valid guest 3 has its state written back", test_writeback },
+	{ "late validity icpt (CRYCB) with a new vsie page", test_late_crycb, 0,
+	  FAC_CRYPTO_KEYS },
+	{ "late validity icpt (CRYCB) with a cached vsie page", test_late_crycb, 1,
+	  FAC_CRYPTO_KEYS },
+	{ "late validity icpt (pin_blocks)", test_late_pin_blocks },
+	{ "late validity icpt (prefix not mapped)", test_prefix_unmapped },
+};
+
+int main(int argc, char *argv[])
+{
+	int idx, bad;
+
+	TEST_REQUIRE(machine_has_sief2());
+
+	ksft_print_header();
+
+	ksft_set_plan(ARRAY_SIZE(testlist));
+
+	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
+		if (testlist[idx].facility &&
+		    !machine_has_facility(testlist[idx].facility)) {
+			ksft_test_result_skip("%s - facility %d not available\n",
+					      testlist[idx].name,
+					      testlist[idx].facility);
+			continue;
+		}
+		bad = testlist[idx].test(testlist[idx].arg);
+		ksft_test_result(!bad, "%s\n", testlist[idx].name);
+	}
+
+	ksft_finished();
+}
-- 
2.56.0

