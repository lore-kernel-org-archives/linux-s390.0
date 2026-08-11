Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43FC3BFAEE;
	Tue, 11 Aug 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463818; cv=none; b=JHnOTCGuoYDOAML/6hJiDRIuZHk+4+ytFeOe1DMm5Hm9XuH/UPiVZsnHDOa2O2DZUuc9NM0T3cz15mZGT5gXjtxgJv38TXljPAfsL7YViGuWPeFIZW8lgVwp+1U62E2AZvfz0J2/JIWbJSTf/eLc2/kwM0i5PAuPiAfMqx0pb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463818; c=relaxed/simple;
	bh=TODtbCC3cth5fnzucKCWcEe+7zIDmmAaKQMpubzKM58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvjDiKaAB/4B2AvQ6ZIXIkcyf9NbxcinKw1UWK1JR/cOwcrtc5DegcsZwaJl7Ld8gQ7w2fnqNy35wMoWtXPN6U+eXgPl09ZNwzSex8w1si73tkTHbosgU/G+Pf4NzZRAuZ/6KMYoBX7k28DdFqSyNDX6PXrZKY9agzPuyCeLAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hdv55OTQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hdv55OTQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWSM7492273;
	Tue, 11 Aug 2026 15:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SHMfE6tZjaWLRVp1X
	Nlc0KPBLh0pkFrmLT7g5aBRxqc=; b=hdv55OTQd/WxFp3NNPkfrRDA+VY1ITKA9
	sNgyLszGyKZJVfqvjFaCzqvu60KlXICaSuUAIFbjqUTTvj0by7uBePVExcVySA+W
	qsY4gmlB29866i4VJjDrfZLpPFjo7fV/4xMEgvYQ2iv9i7jF5otXhhIc7diMeX+x
	H5VK8qfiZTE9wHnWxFVSzR8+QozHOMuJj/hg8b9mMO2SpigDBmNNSWOLMIejnTRZ
	aoVzY1nMsm/rIsELRJcOTovblsNnJ0PXUIfZ+OVI9aE7qKpPQGxPQ5P0WLbqGA7u
	hrk7Si07cMZtrWJWanuU9G70wXfTlQouN8hj2OCaNrr1Z76oiUq/A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9dsgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuKgc018957;
	Tue, 11 Aug 2026 15:56:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h1j0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFuiPm40436168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C98C20043;
	Tue, 11 Aug 2026 15:56:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 487832004B;
	Tue, 11 Aug 2026 15:56:44 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 11/11] KVM: s390: Fix _gaccess_shadow_fault()
Date: Tue, 11 Aug 2026 17:56:41 +0200
Message-ID: <20260811155641.219777-12-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155641.219777-1-imbrenda@linux.ibm.com>
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4AkJh6iew5EKkNn2tTyDpBB0ddY-sGFG
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b4643 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=E-UwkBRaFZ51XR-txJMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfXykcDdVOY8z2U
 1kAWxK/xlBsTEjw2mUfPohUMyUrqW1zPyRCo8pveO/7Oo2buQ1ktTVOg/tEbk/p/i/oHLA22ZZH
 f529Gz+uXFnCBFl7FY8Z80zxyjXSf/0gIylZ4d7I3XYe5SiIepuOmJlo84ZKNRUkYsBzCmTUn7j
 BjsaK5goh9ZEsQw8Ly5ZpilREe2Nndy+UdANJ23Hs8OwowB3vJcucqn+CMAecW6SbcXqGWZLRvm
 61Ewkmk8PUzU/qsEGXCn46VU+ZCkO8kDERIDPfLZWMJdvFcpONkuakmz0ychBKOfuLb7yf+3uIU
 fkXcCv+wwkRXW5w5RhMAfcl26EzprdcLdrMtcOAAeqgdzHi4bWXSOLJ86Lpl+K8no/3sMayLwbb
 URjGX9HPYks2/pbsDVMqRHYsnCl4odv142Spb7uf34HSiPAE0SD/VK7ODLCwg7zjS2yqsYZ2Cqa
 oq2ttKdbyua0Cwcoxqg==
X-Proofpoint-ORIG-GUID: 4AkJh6iew5EKkNn2tTyDpBB0ddY-sGFG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX7kQ9CzAwJFE3
 f8T1+UtdKdKWKZyfmYdZLLDcEytRq+TC6GLtg1/erL9yC14Bk4XTrF6AuihIYzAvYBA0pl9Fq6h
 YHDg0osESg1/O/Al+o+wVJb/cC4Ghlk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110130

In some circumstances, it is possible that the page of nested guest
memory that is being shadowed is not present at all in the parent guest
gmap. dat_entry_walk() will not find any leaf entry and return with
-ENOENT, which will erroneously be propagated all the way to userspace.

Fix by manually calling gmap_link() on the memory of the nested guest
that is being shadowed if the mapping was not already present.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 36102b2727fb..f3a889988cdb 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1507,6 +1507,7 @@ static int _do_shadow_crste(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gpa_
 static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 			      unsigned long saddr, struct pgtwalk *w)
 {
+	struct kvm_memory_slot *slot;
 	struct guest_fault *entries;
 	int flags, i, hl, gl, l, rc;
 	union crste *table, *host;
@@ -1551,8 +1552,17 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 			return -EAGAIN;
 	}
 
+retry:
 	rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, DAT_WALK_LEAF,
 			    TABLE_TYPE_PAGE_TABLE, &host, &ptep_h);
+	if (rc == -ENOENT) {
+		slot = gfn_to_memslot(sg->kvm, entries[LEVEL_MEM].gfn);
+		if (!slot)
+			return PGM_ADDRESSING;
+		rc = gmap_link(mc, sg->parent, entries + LEVEL_MEM, slot);
+		if (!rc)
+			goto retry;
+	}
 	if (rc)
 		return rc;
 
-- 
2.55.0

