Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A0337107;
	Mon, 28 Sep 2026 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600859; cv=none; b=mYoXQwWhL1YZgpyR9Rc5cgmlBf2RPveztS0OorPMB6RD0XhI9oL4zUh0N0YacGhsgNimDBfO+RHioNQaqW8YkQj9Jzpl9Zn2ukzCln4lkJDGROr7FscfwAF+qubLMjtQvQZo81l2zCMK4kK6DhYPud4+Gfm59vE0JgUFJNiccV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600859; c=relaxed/simple;
	bh=tW1hWHNEiGuQOyKMOmY43XQvLOGqIBc2bKO/fB579SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZGNdIPHeeK/1oXvl0ioK8H8weFUcYFPiesBTS1dXlr4u9OpH6NzeB1McAMPLN+jqE1GHl4q55LOyntqsWvgDoSvbSgxk9hubVC3Ur7buyebiZVM3VoOz+KqhSvqk5DKtfQCsoY54xAxVnwasNKEqet8jVG6HFHTV0aPZs3dlhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LoncGwbA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LoncGwbA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZgfv1011371;
	Mon, 28 Sep 2026 13:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1DXNrJ
	51Y/wVKjZCK8BTiWE8M/nrVYhKTDBWA+hZieA=; b=LoncGwbAbxeKgDy26xbzbb
	Yisk5AoEB79BrQCRtraH2JKY4J4XHrcoWfCZRzAfv8FSbRWJU2Lgz4fxD6elOMc0
	tbIyLS4f5eahd9Q28ocFSI8+vl01RrI7ViBDsTeH2bLyxZ5VkBgVjbyFW0bbjuzG
	Ke+2JL5Y1rKnE0OnxZotWwfnwnby/izufu+FMY4/S7plkl/CpPzNNH1OIZ680rCM
	zZ8fLg4mBQkCyikMMwYpcgvwodjkrXKMXXbb9iAYB9A/N9Akzkf611sTRrmHBLH3
	ejFXg2RJuXnUGploUhfrkk7ce9aZ6WLcVtrvyuf3fKHiHOcWr85Y1qiGVYNDMB3g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt11bc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 13:07:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHXNG017627;
	Mon, 28 Sep 2026 13:07:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck5a3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 13:07:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SD7FLs50725338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 13:07:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91AA920040;
	Mon, 28 Sep 2026 13:07:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F25B2004B;
	Mon, 28 Sep 2026 13:07:15 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 13:07:15 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Mon, 28 Sep 2026 15:07:04 +0200
Subject: [PATCH v4 3/6] KVM: x86: Use file_to_kvm_x86() in SEV
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-vfio-v4-3-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
In-Reply-To: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: nlnycff0dZs3BPwFvDsm6--YcXgB5dZd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfXzlNGe2Bqb2QV
 B7jFItcVUS3gWIzPVQ4YU1cmX7/jUcyF0pu41CoWQxHHiAtu4osdLOyOp5qtEB9eOxashS9kr3K
 zCkqhrz2RW8hOz7bS3AtaDtN/7yhlepQ8eh9H7tVWr9IgyGRqP8gHnxRu/hIE1lKJAZVzleg8cD
 12CXhreBqdPFEZW02+KXa6+5knSqaqbJbBkejOf3mW/3P/tW1FXcjRcBVBjo5o+nAuyNWWqPbEz
 hRRfcPWp48b+jsagDmY4v6Y/+lSzlOw/nqwXmC0hzbIfV5eXvjZPrvkiUQKcU5EcEXbjap8NcKe
 B0MRohFS/X22N5mucpBu82Y3FxgEw0oawSxJjibdVGRyFFk2aeXzIvgjT4MTgPshIRfdjHYT41K
 Eolfl4k9NiZmjPtROdowHsHQW2dcHxPvRtQadgrVByhqxs7jC1/UMps6YW1m36V+1+9whNHhr6v
 7h5iif599lGEjZQUvqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfX1ENUBywO/LkA
 UumWqL+ch2ggyVNNVoxahI3P6/TtvrN1t+jpMfqJOUMYWheepbcK/O1WGyqSSOVDa91Dor48xOO
 mlz6pKuJtxmlJwSwDh7fQVFxq8KwRRk=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6aba6688 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=l3-dTue_M56NaxOcOaoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4CscFwi2P3YPpEq1Wwrfg1F4OR6UFx5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280052

Use the new arch-namespaced helper instead of open-coding the file check
and private_data cast separately.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 63eb2155a774..db7ed11e9056 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2151,10 +2151,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f)))
+	source_kvm = file_to_kvm_x86(fd_file(f));
+	if (!source_kvm)
 		return -EBADF;
 
-	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		return ret;
@@ -2876,10 +2876,10 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f)))
+	source_kvm = file_to_kvm_x86(fd_file(f));
+	if (!source_kvm)
 		return -EBADF;
 
-	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		return ret;

-- 
2.53.0

