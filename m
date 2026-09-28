Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205A3D9DAC;
	Mon, 28 Sep 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600862; cv=none; b=tD65ufNAmKR3Lx++RqgJJqKKr9MAeEWaZxsd4JCUobdUOaQBfMineQ5L4zeSs17nVDnJ0xnYewIxE9cCjNabCHTqIGurRKCnYfG98Li1Vn8Vu+DVgLBIbzurWluyD/PbBm1g5s2ul2X2q8r6waLjpqLNWoZGsRjIg7vjJ8l1mEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600862; c=relaxed/simple;
	bh=Lgk4Yl5ECazunlnovme2X0kqMT7/PEKFrd5CImiZEUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBW1uvltupBIWhsiwNXJo+HSEpMf+q0BU4/+HqzTfdr4gYcr5lGB6XFP8N3VDS1FerMdVrJ5GaZp3bJ0KNYeMwFkw5yQoAFc1eBavQA+I2gqNSTLM/GKSyFRLCo62uV99iaTp02hifFN4Xnf7OPni0byAQelNJarArZIC6uhtf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZlqwUatZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZlqwUatZ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZLvQ1019073;
	Mon, 28 Sep 2026 13:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LUb8P2
	MX+JpsIWOQaH0YfFu3Ekb3VI3xMhU6eunzbRw=; b=ZlqwUatZaYe7WkgE/1rnPL
	DsCmRfEBenzJQNHKV2CjWnkaVgvzocrWL503zxSgs8nCbKUBN8kPPUKyYw+QTUmd
	PjwgHUkYxqt+VxAeCvJFWNAIhfFmUqk7pvUPq3XZ/WQKyPaOa8sHaQLdig/WuZFI
	o6ZvJlat62pflnBFMtvrAcB0sO4YD55SrEYL/XP71ru/+ms2P26UpnTDcdTSMjY+
	dxuBm+D2Q7g9D4TeDFQcz7TE4hgfsJOENNPg52Qq+JDPfMJE803WtpeqWQcnjn1o
	ZCu6tud+j4QW9+i1zyPfykoxoN13qGYJOKlWhQdsU+riGLS5T+G+D39hJd6kAiPA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s51dq1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 13:07:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHUOs069385;
	Mon, 28 Sep 2026 13:07:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpnfj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 13:07:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SD7GSJ42992062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 13:07:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89C1A20040;
	Mon, 28 Sep 2026 13:07:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4483520049;
	Mon, 28 Sep 2026 13:07:16 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 13:07:16 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Mon, 28 Sep 2026 15:07:07 +0200
Subject: [PATCH v4 6/6] KVM: Remove unused file_is_kvm
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-vfio-v4-6-e32e226d5932@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfX2wgbCApTjgmU
 tLXt2MdB6Bb7xmgjM/3/yBndLbSFsy5imP2N03p9W6VPTjVVSiWUFmQek5XF1PJRmG3iJxLWncO
 PYsO7T7TS1Myz5IcJz3DP9N97XfWlLw=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6aba6689 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Jz1F51lgnJ0LvKA2XJkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8A4_Vqrf8TklL0BL7x_a8YxGwrKKM__s
X-Proofpoint-ORIG-GUID: 0L439sQncL8Dot4Aagr-wIov-NwGKu_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfXxoM6oIr86GTB
 4Dw62BmX8lOnbf76u04zxAG8BLouQcRff/A5zZ6M5UGIYpCusdFp4bGOZVITzh0/al9vocXluCL
 yegCQzgqgFWQ8jLmZXHRfTKeAkp8fyZN04sBS7DXjMUwsvbOQx1wK5u/0Id6jCNgUNg3/eRhFau
 W0YowXTFy1Z4A6Uzts5F5JUaXxIxvEbJrlRhpsv9ok+jH2SZygBZlYgWlFT/XVLQhmxhowV0Y4/
 VWZxfndqpHz2EoEQ9CiOuRw1kkg9un9ZnIiPRStcCn/vdA9Nc/g8B1k476TGhmRx+6ZUDLCIK8e
 bLsPAaS3KNOf1zkxucnhPbBqHti1HmfjhX10zlWD24ugw9jA0y3YRfXZUIsthPUEXDFbeiH3Zst
 fTf5xaiaOphNRg2gg31SCoGtzCrtaBYP8p/QrUb8o7d/MwEQdFQxPEs3LwYfKC/wjIrM0BUnnVI
 gNg1tlVoS+2+hKpqoXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280052

Remove the now unused file_is_kvm function.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 include/linux/kvm_host.h | 1 -
 virt/kvm/kvm_main.c      | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3c5a389361c6..586f6e8bb81b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1087,7 +1087,6 @@ void kvm_exit(void);
 void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
-bool file_is_kvm(struct file *file);
 
 /*
  * Architectures define kvm_file_to_kvm_arch to <arch>
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ff4fab9753ca..60e614795a36 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5515,12 +5515,6 @@ static struct file_operations kvm_vm_fops = {
 	KVM_COMPAT(kvm_vm_compat_ioctl),
 };
 
-bool file_is_kvm(struct file *file)
-{
-	return file && file->f_op == &kvm_vm_fops;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
-
 #ifdef kvm_file_to_kvm_arch
 struct kvm *kvm_file_to_kvm_fn(struct file *file)
 {

-- 
2.53.0

