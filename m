Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5F3D5662;
	Wed, 15 Apr 2026 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243159; cv=none; b=oBFAe5JWPf/VcetKJPoQyYcBK0a6tbePA0o/jdtX4uJProOaOY/exm4BaVtLx56uLrUm7ERbP+LOYpQoXkTxgbLk/i82jP5mAc9BLx46cP4qMLZS6f+5Ly1OH3e1LEonINRptqrVdO5OEr24+FLAy+3/NSMFu9XOCUOovVz5gbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243159; c=relaxed/simple;
	bh=xysu5jLQLfbVF9hVcPbczeN0IxtC8Sysi+kLZgvPPow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMp8HgBJUYodnVavrpsjeWbwiT9elYDfpHHAhBH5oWDa5RJZC33oEljVIyN8hU729OjkMI8Pakoo7+GI3bbyRRvIc6Zk+tkvUGK9vHgGqHa3tRkYBKaQNRrhFEfJ3txtXnVmp2F9mqA+7m28xBXGKzN3GOyRl2nqoxEQDu/CkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cSlUQ66o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cSlUQ66o"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F4Y37B1833140;
	Wed, 15 Apr 2026 08:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fEbh/VemSqq+B9Mqd
	sJqbYlDIEegcLdrYzg/YcqJYqE=; b=cSlUQ66oSdqY6GL/03AcbBF0ensbychU8
	ZB7vmzxtg1IZowb75s+WgI8HyjrsO3ixF86+0cU6sNkk7n9sVUcpjNFfqsMs6crV
	T9O/A0oVMZF0OUL4OCQqZ2FTqzrNMDrdB+B2qGb8bwHIEVaPhySxDcNrkQ4PRqIF
	3f19E5SJm14BLgxZjYMBRpuv2ttziW3QAYTtL/eZUeXRXbE8a99zxSGYwRC8I2vn
	ZJ+oJAh5v758uU2DgRLeOpEHr3mMcdP5rUkG2iW/frXAYfqRFXb3ij3mHpnQON64
	OP9aOly5REhw+36KnTJcVF+t+RTI84cmZQdPGLCcjSnfJRyJouynw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rf5hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F7gFZs003514;
	Wed, 15 Apr 2026 08:52:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mndds3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F8qVdC40370636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 08:52:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E261620040;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAB842004E;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests 3/5] lib: s390x: sie: Free guest memory on destroy
Date: Wed, 15 Apr 2026 08:45:43 +0000
Message-ID: <20260415085145.91197-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260415085145.91197-1-frankja@linux.ibm.com>
References: <20260415085145.91197-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4MCBTYWx0ZWRfX6ZM2DWE8pkoD
 DQyrSq+g9NJTAvDF4oSOsx7C+pWF4J39T1sqMtCECkKf6WH9z0koONIaBlyKEw6lP2KOYXaJJFp
 vAvHm436LZrGoLRAmPkWZy3oea6gO9c8fdSxmfaVqkjJRqwbsgUtHbO2LQF488k02SHjpZ5cf4/
 qsYd21rBJrtRrcOnAaiv69RsDp/DPdThw6HkaW4rOF4EycYt1zK1tjS3TXp+8ZnhuVpOCSxtCBC
 NO355Olxf5Hzgyj1d7pH0amAOeTPGUmkhqC3ZubrefNPRZkOlvGpz7lzOvqye3jiWgmOCWJV/Eu
 i+9oUlIgf/7f+ruBc4UAjLqgLJYPhHfJNU9Lgb1H8bP0Fe5wYOnY2jFyBPpLASjgOCaba5DbyP9
 Hfb+e+qfVjLntZAQ1V4oPRT1OzZye6Jv/THavmlks7h8Eg/Fvifg8QR+3xiOykQuvAfGB474Fd3
 fmnd22EaAKPKaufCrIw==
X-Proofpoint-ORIG-GUID: sHGShqNpaPhnKjy3RQPRBSSZ2ks47F3_
X-Proofpoint-GUID: sHGShqNpaPhnKjy3RQPRBSSZ2ks47F3_
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69df51d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=clHM_NND8LjUN_pgk4IA:9
 a=0lgtpPvCYYIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150080

We never freed the memory that the sie library allocates as the guest
ram on destruction of the VM. Most tests reuse the VM or just leak the
memory since the standard allocation is one megabyte and tests only
use single digit numbers of VMs.

It's time to add automatic freeing to the sie library when a VM is
destroyed.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/sie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index a49c45c7..758ead77 100644
--- a/lib/s390x/sie.c
+++ b/lib/s390x/sie.c
@@ -192,4 +192,5 @@ void sie_guest_destroy(struct vm *vm)
 	free_page(vm->sblk);
 	if (vm->sblk->ecb2 & ECB2_ESCA)
 		free_page(vm->sca);
+	free_pages((void *)virt_to_pte_phys(get_page_root(), vm->guest_mem));
 }
-- 
2.51.0

