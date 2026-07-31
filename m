Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED142CB00;
	Fri, 31 Jul 2026 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503381; cv=none; b=efJAyR9DazQe5GesRDOHeROZfRUc4bRyJjdZE6qN7kawzTNPlp6uvCYOXjXGKaJdIdTddu1pDLop3MWzfzYWujDqTC5fiScs0DWCBvZ26G4pDwC0UEWT+AzSV5U1DApRwUXvLp3uxPXtr97gxPoPmLHoY+Eqf14iYkZi12bO+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503381; c=relaxed/simple;
	bh=s/VHK3l4V/opXyxmvjHVQQyx6bMLTnHI1mFNxF8QCQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ows1PLJo1dXMxD6UR6Zvs4SXgeDVcFWN4yvIiKvRNt4IFKQFji5IUtDitwkzc4ZRb3UI8TK2zaL+nUo5i53924af1qit2GfR0jqdAJ07tH4PnzXOic+HZG+IixepQVqjKZGD5iQajqhb+rkW11ru+mfCu6401wg/0kuhSb7PX8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lYFH91c3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lYFH91c3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmUqC1732345;
	Fri, 31 Jul 2026 13:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pxBQDzcefpvTkc6N8
	16N8JcNplQq+L7zx85iUJorX5Q=; b=lYFH91c3Q49AJZxfK0CP9omslwsrhUr5L
	pcHOi1WIYDZs17D38EtC6J8/yhVrM7I9U1Ib0QTUO8BkUq64ejdhH8ZnPADNMFXM
	4D2qL70u/XaTy6n9giH1QJqxh4dR900ZwscnuzwLQ8nShwIkZA92fTlQEvMuMFME
	Tx1TiBS2RGWuSGR0yS+PXtzVAWxF5QzN6QOy841w9ZOhwhQr5pDuhmjC9R/HIdap
	bal4z5IfY75faVbMWVwwOAPl9WK/ENCwVHdHxberpREoZrVJlarO+5VCCYvE9PBN
	R39p2+qtnhIVVDEDiCTa3jcynEbBCnmIPSFJE6TqbA3wkRbt1RnkQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7w4kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuLc6023579;
	Fri, 31 Jul 2026 13:09:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yfqfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD9Akw32637358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A36F20040;
	Fri, 31 Jul 2026 13:09:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE2142004B;
	Fri, 31 Jul 2026 13:09:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:09 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v5 16/31] KVM: s390: Move PGM code definitions to asm/kvm_host.h
Date: Fri, 31 Jul 2026 15:08:44 +0200
Message-ID: <20260731130902.654679-17-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cU7S3y4KSk2SIDvEgrsO8afsPJQL_AIn
X-Proofpoint-ORIG-GUID: a2lqMBN7jYHmnRoNghA6BeDvM0XIgTvb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX7B4GY8RGThkQ
 URj2Jneu56iseBIK2qgNknpnHN0nx5XYYBOf14Wg/wOV09EVsUSxQGTG2r3/hAgjH5XiFfcOKhz
 hJybZNDp4QUiaqgEVXgLnRN2os1+7EoM5bpViIOafovR57xI0gE9oqmz2iKBJ8j9H2e0eHXlQE5
 2iMJzipC0QUomQ8SWcD6dqTf2WzIe1THoAgZWQtB8di6C8KFuM3qDL0u4U6WcyQb+ddCa32bxJQ
 Ww5Ym3EqkUUce/gcn3026MMTeigmADZvRpGUpXqg2Hn+/GOgRxfwGxO4HjwkSwwnI1Jz7SLZStD
 QvLCRtFF/fbkodJ/FMFLYZ2UsGo0zlJzurgoEbylCAMYYMG8lmP024Hifw+V4zNgpMkD1XFzoDH
 ie4Y3LBfy1BmZHOaYpqE2+jOs8ScSpAm0bQ4nVdXYWbp68XO0sWxJ3efTmsEsWnr9sHWBYHfk/i
 xqAMpkar3cUXF7Z+GUg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6c9e7e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=TiwjLMfUdNF-F4zQeIEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX+h51CXDNeRl6
 dc8fzXFh8PPy2q4DIvhSzsZy4Hw0z5I35A21sy3ZAnLN+S7sxUj+jf0j0CIPy45kb9FyuWGACXL
 BGAFxw0b1lkvUa1Fojf64ziw6LMUapA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310096

Move the PGM definitions from kvm_host_s390.h (back) to kvm_host.h so
they can be used by a second KVM implementation.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h      | 57 +++++++++++++++++++++++++++
 arch/s390/include/asm/kvm_host_s390.h | 57 ---------------------------
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index e76ceee11ef5..147325978225 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -5,4 +5,61 @@
 
 #include <asm/kvm_host_s390.h>
 
+#define PGM_OPERATION			0x01
+#define PGM_PRIVILEGED_OP		0x02
+#define PGM_EXECUTE			0x03
+#define PGM_PROTECTION			0x04
+#define PGM_ADDRESSING			0x05
+#define PGM_SPECIFICATION		0x06
+#define PGM_DATA			0x07
+#define PGM_FIXED_POINT_OVERFLOW	0x08
+#define PGM_FIXED_POINT_DIVIDE		0x09
+#define PGM_DECIMAL_OVERFLOW		0x0a
+#define PGM_DECIMAL_DIVIDE		0x0b
+#define PGM_HFP_EXPONENT_OVERFLOW	0x0c
+#define PGM_HFP_EXPONENT_UNDERFLOW	0x0d
+#define PGM_HFP_SIGNIFICANCE		0x0e
+#define PGM_HFP_DIVIDE			0x0f
+#define PGM_SEGMENT_TRANSLATION		0x10
+#define PGM_PAGE_TRANSLATION		0x11
+#define PGM_TRANSLATION_SPEC		0x12
+#define PGM_SPECIAL_OPERATION		0x13
+#define PGM_OPERAND			0x15
+#define PGM_TRACE_TABEL			0x16
+#define PGM_VECTOR_PROCESSING		0x1b
+#define PGM_SPACE_SWITCH		0x1c
+#define PGM_HFP_SQUARE_ROOT		0x1d
+#define PGM_PC_TRANSLATION_SPEC		0x1f
+#define PGM_AFX_TRANSLATION		0x20
+#define PGM_ASX_TRANSLATION		0x21
+#define PGM_LX_TRANSLATION		0x22
+#define PGM_EX_TRANSLATION		0x23
+#define PGM_PRIMARY_AUTHORITY		0x24
+#define PGM_SECONDARY_AUTHORITY		0x25
+#define PGM_LFX_TRANSLATION		0x26
+#define PGM_LSX_TRANSLATION		0x27
+#define PGM_ALET_SPECIFICATION		0x28
+#define PGM_ALEN_TRANSLATION		0x29
+#define PGM_ALE_SEQUENCE		0x2a
+#define PGM_ASTE_VALIDITY		0x2b
+#define PGM_ASTE_SEQUENCE		0x2c
+#define PGM_EXTENDED_AUTHORITY		0x2d
+#define PGM_LSTE_SEQUENCE		0x2e
+#define PGM_ASTE_INSTANCE		0x2f
+#define PGM_STACK_FULL			0x30
+#define PGM_STACK_EMPTY			0x31
+#define PGM_STACK_SPECIFICATION		0x32
+#define PGM_STACK_TYPE			0x33
+#define PGM_STACK_OPERATION		0x34
+#define PGM_ASCE_TYPE			0x38
+#define PGM_REGION_FIRST_TRANS		0x39
+#define PGM_REGION_SECOND_TRANS		0x3a
+#define PGM_REGION_THIRD_TRANS		0x3b
+#define PGM_SECURE_STORAGE_ACCESS	0x3d
+#define PGM_NON_SECURE_STORAGE_ACCESS	0x3e
+#define PGM_SECURE_STORAGE_VIOLATION	0x3f
+#define PGM_MONITOR			0x40
+#define PGM_PER				0x80
+#define PGM_CRYPTO_OPERATION		0x119
+
 #endif /* ASM_KVM_HOST_H */
diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 3c592e4bb883..9e4d7ed53078 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -150,63 +150,6 @@ struct kvm_vcpu_stat {
 	u64 signal_exits;
 };
 
-#define PGM_OPERATION			0x01
-#define PGM_PRIVILEGED_OP		0x02
-#define PGM_EXECUTE			0x03
-#define PGM_PROTECTION			0x04
-#define PGM_ADDRESSING			0x05
-#define PGM_SPECIFICATION		0x06
-#define PGM_DATA			0x07
-#define PGM_FIXED_POINT_OVERFLOW	0x08
-#define PGM_FIXED_POINT_DIVIDE		0x09
-#define PGM_DECIMAL_OVERFLOW		0x0a
-#define PGM_DECIMAL_DIVIDE		0x0b
-#define PGM_HFP_EXPONENT_OVERFLOW	0x0c
-#define PGM_HFP_EXPONENT_UNDERFLOW	0x0d
-#define PGM_HFP_SIGNIFICANCE		0x0e
-#define PGM_HFP_DIVIDE			0x0f
-#define PGM_SEGMENT_TRANSLATION		0x10
-#define PGM_PAGE_TRANSLATION		0x11
-#define PGM_TRANSLATION_SPEC		0x12
-#define PGM_SPECIAL_OPERATION		0x13
-#define PGM_OPERAND			0x15
-#define PGM_TRACE_TABEL			0x16
-#define PGM_VECTOR_PROCESSING		0x1b
-#define PGM_SPACE_SWITCH		0x1c
-#define PGM_HFP_SQUARE_ROOT		0x1d
-#define PGM_PC_TRANSLATION_SPEC		0x1f
-#define PGM_AFX_TRANSLATION		0x20
-#define PGM_ASX_TRANSLATION		0x21
-#define PGM_LX_TRANSLATION		0x22
-#define PGM_EX_TRANSLATION		0x23
-#define PGM_PRIMARY_AUTHORITY		0x24
-#define PGM_SECONDARY_AUTHORITY		0x25
-#define PGM_LFX_TRANSLATION		0x26
-#define PGM_LSX_TRANSLATION		0x27
-#define PGM_ALET_SPECIFICATION		0x28
-#define PGM_ALEN_TRANSLATION		0x29
-#define PGM_ALE_SEQUENCE		0x2a
-#define PGM_ASTE_VALIDITY		0x2b
-#define PGM_ASTE_SEQUENCE		0x2c
-#define PGM_EXTENDED_AUTHORITY		0x2d
-#define PGM_LSTE_SEQUENCE		0x2e
-#define PGM_ASTE_INSTANCE		0x2f
-#define PGM_STACK_FULL			0x30
-#define PGM_STACK_EMPTY			0x31
-#define PGM_STACK_SPECIFICATION		0x32
-#define PGM_STACK_TYPE			0x33
-#define PGM_STACK_OPERATION		0x34
-#define PGM_ASCE_TYPE			0x38
-#define PGM_REGION_FIRST_TRANS		0x39
-#define PGM_REGION_SECOND_TRANS		0x3a
-#define PGM_REGION_THIRD_TRANS		0x3b
-#define PGM_SECURE_STORAGE_ACCESS	0x3d
-#define PGM_NON_SECURE_STORAGE_ACCESS	0x3e
-#define PGM_SECURE_STORAGE_VIOLATION	0x3f
-#define PGM_MONITOR			0x40
-#define PGM_PER				0x80
-#define PGM_CRYPTO_OPERATION		0x119
-
 /* irq types in ascend order of priorities */
 enum irq_types {
 	IRQ_PEND_SET_PREFIX = 0,
-- 
2.53.0

