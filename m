Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854BC440A08;
	Thu, 24 Sep 2026 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240345; cv=none; b=c1liYUZylCYELiZ7yZ8Roy4RmRxhzy+QHvJJimMtjzlgXQRrnheE23qbdlR/kbbjLxf8tIiv+VczKWDS94+G1SNR0MaUv+sqJ0+jf7GGVmV3sDf3YucvEUXgvoew5+m1w4JPghMuKc9qkrLLtdQ6DqhbkoB47FHs/QH0JD+T5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240345; c=relaxed/simple;
	bh=u73LKcm8bGY5Aw4Nqfini1ABcjD5R9crFx9O6wvqB2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMx2na5Wa23uqQw8P1wTQpE+zIdHkJCX3RpJ+mfEh2NO+bGLVNTkDQgsOiiXOfD857PJeuwgCBZvkn6gUlyUw5Rw5+IOGCY6/9nYEoSGNP6/P9Cs8Owp7FM9/H80BpPpIL30z2NJ8QRLrpdi+9BWOpwsS8TK2FxB9PZxFAyaJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X55jAFnx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X55jAFnx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bpPZ1179971;
	Thu, 24 Sep 2026 08:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SYAa3I
	M/+xKk/8iMdL2vB2N3OhtXJgQijRnR9BRL4WM=; b=X55jAFnxc9SRykfm7I+msh
	AniYYCqh5vWY465Nj2WtVA5ttNXoml0cM6jjrKaQljIYhtp1Ix2WL5vl5PJykAvQ
	A1FpT7LmIg01vLZlmuDc8BSENJxZztFfr4Ln7UguDOgJwQXx2Ki4uGji6WKxgQFk
	NZ1L5kUAneix3DrmbjuVhYBBKmPkOSxHfM2/XTsO+a01OW2P8ATs1iy1lygN0LYu
	cpaTR15CpCB8TN6fbBtDeSzSoWb/t+TrXVisJ1mH9AUCWgzHp5QkZDhm6KRUnf+M
	y0dVIhbzlV5s8MNRo5tvxuuxvYZCIKxyHd3oL1TUywFB9kMyZw6EsECKSiJUtRBw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1qdf1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 08:58:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5lTo41501452;
	Thu, 24 Sep 2026 08:58:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2vsrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 08:58:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O8weCc31982204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 08:58:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7EDC20040;
	Thu, 24 Sep 2026 08:58:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 640D420043;
	Thu, 24 Sep 2026 08:58:40 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 08:58:40 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Thu, 24 Sep 2026 10:58:34 +0200
Subject: [PATCH v3 5/5] KVM: Restrict kvm_get_kvm/kvm_put_kvm export to
 internal KVM modules
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-vfio-v3-5-4a294307797b@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
In-Reply-To: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 3U_JyZXUK6kzha80TThf9iX5kysaqgN5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX+UozSMrUe7oQ
 KJLJ9/RoPyYGe1Whh6XGM0fNt38TDVSHcuDIaGsD48Q+/TtnLStkxjJQCoTSfhvn2e3WVS61FXY
 dcYVLmnZPqZO45+xfrQ+bFRkkiSrYVChFT7d6+JnCnJw6GRK/yzPy0gqACCFQ7BKpBA8lJq8Pbs
 C3i55lOwAW7SzNwkHTXYdPaYPpSaCh8yyMnQt/X0w0+Ltgev/noKIYuyD1AxhEjdlOFZdQJhzAd
 iZi92m/YlL/zPtkC8spsoJltQCdEuUHqjicyIzSdjwPKL+fk/6qgOjb5aKT6cgmRjabL0ScsEXe
 QROv4vlJuODh+kac5X8Ci7+MRlct+pgC7zbUIRvlw2XE0114GBcGAgJjohSsbOpVq+yM33mRlOM
 T/U1Ejt0TAAYcJw2r5jg7i/ZlB53BCaIXlSe6GhJqfbcLM0k06GqYnbB7AkWlGJvi1WF8CmET5k
 w8eM7Eof5MolfUvkvEg==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab4e645 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=cWV-k8hB2h86IYwIXi4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX1agVaYczpMPP
 ceFYguFyJZDh5HbizcNcQIu4QFq6mSMs7pdJdgGQTlvUfVhdai7jbI5qEh/QvNwXlNg1KUbYEaK
 FjiWabEBvu9BuniXGsrzH5PHlSUaRsw=
X-Proofpoint-GUID: R4Dokp0rHAU3A5bWzsAfiJTwsbqOF3v7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240036

Switch kvm_get_kvm, kvm_get_kvm_safe, and kvm_put_kvm from
EXPORT_SYMBOL_GPL to EXPORT_SYMBOL_FOR_KVM_INTERNAL. These symbols are
now only used within KVM itself. No external module needs them now that
VFIO uses file-based reference counting. Remove the corresponding
exemptions from the x86 KVM Makefile exports check.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/x86/kvm/Makefile | 5 +----
 virt/kvm/kvm_main.c   | 6 +++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index e6d395ede9e2..c6bf463f5032 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -61,10 +61,7 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 				-e kvm_page_track_unregister_notifier \
 				-e kvm_write_track_add_gfn \
 				-e kvm_write_track_remove_gfn \
-				-e kvm_file_to_kvm_fn \
-				-e kvm_get_kvm \
-				-e kvm_get_kvm_safe \
-				-e kvm_put_kvm
+				-e kvm_file_to_kvm_fn
 
 # Force grep to emit a goofy group separator that can in turn be replaced with
 # the above newline macro (newlines in Make are a nightmare).  Note, grep only
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index bab71d398236..891a67cb365a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1314,7 +1314,7 @@ void kvm_get_kvm(struct kvm *kvm)
 {
 	refcount_inc(&kvm->users_count);
 }
-EXPORT_SYMBOL_GPL(kvm_get_kvm);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm);
 
 /*
  * Make sure the vm is not during destruction, which is a safe version of
@@ -1324,14 +1324,14 @@ bool kvm_get_kvm_safe(struct kvm *kvm)
 {
 	return refcount_inc_not_zero(&kvm->users_count);
 }
-EXPORT_SYMBOL_GPL(kvm_get_kvm_safe);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm_safe);
 
 void kvm_put_kvm(struct kvm *kvm)
 {
 	if (refcount_dec_and_test(&kvm->users_count))
 		kvm_destroy_vm(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_put_kvm);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_put_kvm);
 
 /*
  * Used to put a reference that was taken on behalf of an object associated

-- 
2.53.0

