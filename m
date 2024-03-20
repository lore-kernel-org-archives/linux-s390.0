Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5F7464;
	Wed, 20 Mar 2024 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710899747; cv=none; b=j1ux75H00ZGn568bArRo7hIr0RXr8rDRWRG4/GUkaM3S4AnXB3GTUbe6pQAcyq68e9TEDhy+xLbOwnlJgJOw85tBwPm0EAA2A9wtF7+YSIFngtZObg8ydb/iA2NpwhUkK5yF56j7Az5dKi/GXesAQvWmsbrgsV/GnNiUq9kwzK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710899747; c=relaxed/simple;
	bh=qwt+oskm3Z2QuQGEi1X58ZXLsbjWCY5LeBU+rkFRJNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJzZ9nDXnqNiqxBycIxRnrZkOoLZUoQfxy3Nwfd7Xhgj7hrS7my7t2e6pQ7ogHBbKzikgo4Q6TZ7geQgD7Lx2DY3b9IakXnMIujdzc32K5JByoOk5Dkx2NLbuxMbe3Bp3+QSiWSWNcZGkhucG2khhs76HlkqV5sHl8914DANX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qkk7Gjde; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qkk7Gjde"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K1MTJB010884;
	Wed, 20 Mar 2024 01:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=e1GgvWldc0x8EPUNZOz226pGr0ULfy4oaScrjoI1974=;
 b=qkk7GjdeDkeqo02lxIZNO2CawBpKs8FVOYX4C4jTqeDc8b/zGA/d0mAm6UbeJUuWOI9+
 G9XCOlqmfDukm9MzxSLomdNPnM/NcbnpwI/5aC4AM/sBEnMGWOKjw8XfvBWbI1xSgQmM
 lENP7OrV6ibK5Y8AHXQI84C7do1BJXk/9rrSHA2rFPA6xfL8hrSWcwXuZ6W2RF/6UJdd
 VAXP98qwf2Yn7nXGXKlQjCw0sPTmf7jUXbem5+KOTKD5MOwbUaN2ymQVjjVF8/H5fcP/
 0NjiYOSbsIH520uJYi+S5VAM6OE9Nw3zPeOlHGnZC+RYzmW6S0gsYipS4CxNpX0qZzPe Nw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyp2u01dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:55:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JMnirg011606;
	Wed, 20 Mar 2024 01:55:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8m3a2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:55:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42K1tJ9744499380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 01:55:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2F9F2004B;
	Wed, 20 Mar 2024 01:55:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 661342005A;
	Wed, 20 Mar 2024 01:55:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.51.201])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 01:55:18 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, bpf@vger.kernel.org,
        linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf] s390/bpf: Fix bpf_plt pointer arithmetic
Date: Wed, 20 Mar 2024 02:54:12 +0100
Message-ID: <20240320015515.11883-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ujhJlRs8TOjuK96ZqDlTzSHxsAWwMSiu
X-Proofpoint-ORIG-GUID: ujhJlRs8TOjuK96ZqDlTzSHxsAWwMSiu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200012

Kui-Feng Lee reported a crash on s390x triggered by the
dummy_st_ops/dummy_init_ptr_arg test [1]:

  [<0000000000000002>] 0x2
  [<00000000009d5cde>] bpf_struct_ops_test_run+0x156/0x250
  [<000000000033145a>] __sys_bpf+0xa1a/0xd00
  [<00000000003319dc>] __s390x_sys_bpf+0x44/0x50
  [<0000000000c4382c>] __do_syscall+0x244/0x300
  [<0000000000c59a40>] system_call+0x70/0x98

This is caused by GCC moving memcpy() after assignments in
bpf_jit_plt(), resulting in NULL pointers being written instead of
the return and the target addresses.

Looking at the GCC internals, the reordering is allowed because the
alias analysis thinks that the memcpy() destination and the assignments'
left-hand-sides are based on different objects: new_plt and
bpf_plt_ret/bpf_plt_target respectively, and therefore they cannot
alias.

This is in turn due to a violation of the C standard:

  When two pointers are subtracted, both shall point to elements of the
  same array object, or one past the last element of the array object
  ...

From the C's perspective, bpf_plt_ret and bpf_plt are distinct objects
and cannot be subtracted. In the practical terms, doing so confuses the
GCC's alias analysis.

The code was written this way in order to let the C side know a few
offsets defined in the assembly. While nice, this is by no means
necessary. Fix the noncompliance by hardcoding these offsets.

[1] https://lore.kernel.org/bpf/c9923c1d-971d-4022-8dc8-1364e929d34c@gmail.com/

Fixes: f1d5df84cd8c ("s390/bpf: Implement bpf_arch_text_poke()")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 46 ++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index b418333bb086..5af0402e94b8 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -516,11 +516,12 @@ static void bpf_skip(struct bpf_jit *jit, int size)
  * PLT for hotpatchable calls. The calling convention is the same as for the
  * ftrace hotpatch trampolines: %r0 is return address, %r1 is clobbered.
  */
-extern const char bpf_plt[];
-extern const char bpf_plt_ret[];
-extern const char bpf_plt_target[];
-extern const char bpf_plt_end[];
-#define BPF_PLT_SIZE 32
+struct bpf_plt {
+	char code[16];
+	void *ret;
+	void *target;
+} __packed;
+extern const struct bpf_plt bpf_plt;
 asm(
 	".pushsection .rodata\n"
 	"	.balign 8\n"
@@ -531,15 +532,14 @@ asm(
 	"	.balign 8\n"
 	"bpf_plt_ret: .quad 0\n"
 	"bpf_plt_target: .quad 0\n"
-	"bpf_plt_end:\n"
 	"	.popsection\n"
 );
 
-static void bpf_jit_plt(void *plt, void *ret, void *target)
+static void bpf_jit_plt(struct bpf_plt *plt, void *ret, void *target)
 {
-	memcpy(plt, bpf_plt, BPF_PLT_SIZE);
-	*(void **)((char *)plt + (bpf_plt_ret - bpf_plt)) = ret;
-	*(void **)((char *)plt + (bpf_plt_target - bpf_plt)) = target ?: ret;
+	memcpy(plt, &bpf_plt, sizeof(*plt));
+	plt->ret = ret;
+	plt->target = target;
 }
 
 /*
@@ -662,9 +662,9 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 	jit->prg = ALIGN(jit->prg, 8);
 	jit->prologue_plt = jit->prg;
 	if (jit->prg_buf)
-		bpf_jit_plt(jit->prg_buf + jit->prg,
+		bpf_jit_plt((struct bpf_plt *)(jit->prg_buf + jit->prg),
 			    jit->prg_buf + jit->prologue_plt_ret, NULL);
-	jit->prg += BPF_PLT_SIZE;
+	jit->prg += sizeof(struct bpf_plt);
 }
 
 static int get_probe_mem_regno(const u8 *insn)
@@ -2040,9 +2040,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	struct bpf_jit jit;
 	int pass;
 
-	if (WARN_ON_ONCE(bpf_plt_end - bpf_plt != BPF_PLT_SIZE))
-		return orig_fp;
-
 	if (!fp->jit_requested)
 		return orig_fp;
 
@@ -2148,14 +2145,11 @@ bool bpf_jit_supports_far_kfunc_call(void)
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *old_addr, void *new_addr)
 {
+	struct bpf_plt expected_plt, current_plt, new_plt, *plt;
 	struct {
 		u16 opc;
 		s32 disp;
 	} __packed insn;
-	char expected_plt[BPF_PLT_SIZE];
-	char current_plt[BPF_PLT_SIZE];
-	char new_plt[BPF_PLT_SIZE];
-	char *plt;
 	char *ret;
 	int err;
 
@@ -2174,18 +2168,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		 */
 	} else {
 		/* Verify the PLT. */
-		plt = (char *)ip + (insn.disp << 1);
-		err = copy_from_kernel_nofault(current_plt, plt, BPF_PLT_SIZE);
+		plt = ip + (insn.disp << 1);
+		err = copy_from_kernel_nofault(&current_plt, plt,
+					       sizeof(current_plt));
 		if (err < 0)
 			return err;
 		ret = (char *)ip + 6;
-		bpf_jit_plt(expected_plt, ret, old_addr);
-		if (memcmp(current_plt, expected_plt, BPF_PLT_SIZE))
+		bpf_jit_plt(&expected_plt, ret, old_addr);
+		if (memcmp(&current_plt, &expected_plt, sizeof(current_plt)))
 			return -EINVAL;
 		/* Adjust the call address. */
-		bpf_jit_plt(new_plt, ret, new_addr);
-		s390_kernel_write(plt + (bpf_plt_target - bpf_plt),
-				  new_plt + (bpf_plt_target - bpf_plt),
+		bpf_jit_plt(&new_plt, ret, new_addr);
+		s390_kernel_write(&plt->target, &new_plt.target,
 				  sizeof(void *));
 	}
 
-- 
2.44.0

