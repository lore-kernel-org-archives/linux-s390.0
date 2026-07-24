Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651A42124B;
	Fri, 24 Jul 2026 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902422; cv=none; b=TuoL2qEyelH1RA0GYtrLTJJhJEcoQfwyG2DDsrk603wG9JX5hM8fu/BrrCp0HCwXXWHYxYUvD5WY62iQERnW5xWuGfv5+iT7b9zN+DzQ2S8coMMVv90BM/PWXyWdxcqk3RkJEPNITnevcNiaq24z9ZMExzXRwWxYI9NmcaY93L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902422; c=relaxed/simple;
	bh=WWuQjLtR2ZU+kwd9Fgh+1d7PBoDfUJOkfOpfXQTGC84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1u0Ye8zsN4dAkweIPtFF2wPG+t50Zyx6LbQwNZTT0AbxhSthxn7tVV7cBHselJf3HBAJzxbvmCqUjT7JQoSSA+ry5wbCgD2ed9o/AGPcqpAo8YnexiHxHrQsvvXMEnL1a7R7PKYBsA45M+Yf7K0Zyof3cZJ5/jJyKF5+HcuXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hzHYZzoP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hzHYZzoP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODg4Vr1899209;
	Fri, 24 Jul 2026 14:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=idMIRk6fwlnR1JVVo0orcC9+0hFBzZ1UC6FlbQL/q
	7k=; b=hzHYZzoP3AAXvYP2mAZM6kYmXB1jjBg2QyYdQYCd2ICrYBP4h6r13SUEl
	Ujmy3WVXaqEv56Tgdx6qfPBXJdKVRwGtt+y0+7bNqDtIIJN1J2gr4WlkEdOR90RP
	/9hdQnYhvis60OFO5674mUFbcBHNxYT/Rea/YUMO9dxAn6sG69/J2o6Hlj4/6HEp
	eNdYHn5Xm6fIPKM/kMMTPzvIDhH1fKAH+OlTCiH+wdghm1sj3Cx+hVoYGgjbF31G
	hqf9kwBRWIGJaDHUrli25DpLrYsyJkjF/lZhb8pZl4HFnbjYXZd5jdADtcI4C/+l
	ascxrC7qaMq2GAYCgfcOzHuVCijAQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kmf2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4fNC013225;
	Fri, 24 Jul 2026 14:13:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6whamw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEDLDS36897264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:13:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6734F20116;
	Fri, 24 Jul 2026 14:13:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B9CE2012B;
	Fri, 24 Jul 2026 14:13:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:13:21 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Dominik Steenken <dost@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: llvm@lists.linux.dev, bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] s390: Add kCFI support
Date: Fri, 24 Jul 2026 16:13:12 +0200
Message-ID: <20260724141318.1037434-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a637306 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dpzNp9uz1j0L51h_C7EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfXwCOSe2gPb7jF
 YakqJlRRc4yiXGozXQbZhixKZVjaXGDASLoVs8qofDf0WS1M5p9ceXWjE4FxqsMiJ/bkJe0fyx6
 YAWrEAmsZ12xsXILYAY++DKepLERbhLEWg26yd6p0nYaepOUNU6cPD1Fao32mOp6YJFcJwhM3Xl
 868mCG+JsBPKquxXuCFtYKUs2imxcKWW0rqtWsBv2fwtQvOB1YQaDE4vXFC9DQC/JPbRBDWM48d
 /ogacdlJbHky6Pt1wrfFuKsFD7cPebwBgUhNB7+DDe/ud/1vmcM/gosBl7gfbFHDRc22f1Je1YQ
 xXd+iPg1kN64AK0Gi6Xav/153xgzii/Ct/pAzGVdH2OxKse+6WnbyvxxDptwDNPXa/3mG75HNM1
 JkrqCUVXvJkFgx7K4IOjGi2fy58YEaVk7AKt47CQAQT2nl5KFf3LRNw403NdJHWVt1XfD9G8YWw
 v/INVHJ/iOUdUt26g8g==
X-Proofpoint-ORIG-GUID: W5430t7FHRFqiE5hWeE8OljIS3oQE2eR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX94Zut8QSD+Ub
 cHDLP/SQcKdXt9YCfM1O7TEu9TaVWatnxj6FrcS+7arbVgADyBSCNKT6jyacD5jSfN9RNxjqJcV
 fg8I1GzVb/OXTF2bLEjwBv7vabtT+N8=
X-Proofpoint-GUID: srTFIt1MZZw3p95XhVGfz6hobj9KGiDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240128

Add s390 kCFI support using the generic support provided by clang.
This comes with a couple of limitations:

The generic kCFI implementation does not generate a .kcfi_traps section,
nor is a special instruction used in case a checksum mismatch is detected.

This means in case of a checksum mismatch the kernel just crashes.
It should be quite easy to tell by the surrounding code that a crash
happened because of a checksum mismatch.

If clang and/or gcc provide a .kcfi_traps section it will be possible to
print proper CFI messages instead of just crashing the kernel (enable
ARCH_USES_CFI_TRAPS).

In addition this also means that CFI_PERMISSIVE does not work. Even if the
option is selected the kernel will crash in case of a checksum mismatch.

However it seems to be acceptable to enable kCFI support to the kernel now
even if it is not perfect. Later s390 specific clang and gcc extensions are
required to improve this.

This passes all ftrace selftests. It also passes the kernel bpf selftests
(vmtest.sh), except those using the task work scheduling kfuncs. However
that appears to be a real bug and has been reported [1].

[1] https://lore.kernel.org/all/20260724112221.212464A3f-hca@linux.ibm.com/

Thanks,
Heiko

Heiko Carstens (6):
  s390/tools: Pass symbol name to do_relocs()
  s390/tools/relocs: Ignore __kcfi_typeid_ relocations
  s390: Add ftrace_stub_graph
  s390/diag: Generate CFI type information for assembly functions
  s390/Kconfig: Select ARCH_SUPPORTS_CFI
  s390/bpf: Add kCFI support

 arch/s390/Kconfig               |   1 +
 arch/s390/include/asm/cfi.h     |   7 ++
 arch/s390/kernel/mcount.S       |   7 +-
 arch/s390/kernel/text_amode31.S |  13 +--
 arch/s390/net/bpf_jit_comp.c    |  26 +++++-
 arch/s390/tools/relocs.c        | 158 +++++++++++++++++++++++++++++++-
 6 files changed, 198 insertions(+), 14 deletions(-)
 create mode 100644 arch/s390/include/asm/cfi.h

-- 
2.53.0

