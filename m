Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807D3ED5DC
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001231; cv=none; b=Q5S9CsmymTv+tKFMQBZy/zewTWzQnhJu3+W/4cQEavA457K12Zy6w8RqZH/PGt2qldDhJANAe5qDW2eDoXtgg6UpS1+ZUXgxtq1MLL7jVVyyXSeRKKgmmj5RhMK1aWBWHGPjueJidbqEQ/cVz5rqSCr3Uj/bgSFIOXxhYiJyJ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001231; c=relaxed/simple;
	bh=eaXF3XNS2Qmve3LhQUKy8w3OPWU6EeLQsDwd38V3tPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJ66DmVRKOGolhWHIjdA1X5Fo8xELfFI8VekI8Mr/Yq5KWC6wwlR+fTFRxEoxOWPshDM77a56SDJIA8VGSMcudyWHIBMzD1yBFpGqQpqzCb1lfT3xQWY2iGtKDDPu5Uh/BmHOlib/vKOkWuML5uwpoiyaIKuv6afcW83Na5AqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KOYt1G75; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KOYt1G75"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658KsA0F2157486
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mTAq1ZHGZ7kzBfwvz
	b8ENpKT2902jF62JBLhX38WIpo=; b=KOYt1G75+/3zCQZNGztcunU8q7iEv+kUk
	KXGD9lnamWqbp9g/xEkBS4ku/1gdXweDYoCLdCzkC8oVUAOqnXhR3KEjnkiOQ+KD
	MsWx+wux2BDjKVMBjJuv3nFUXa9xzBYK+cmrZRqGSlcIxo73pV0Aj0xSvPjr8BX1
	3ZALUEkH56bYH2BJLqS4br0YXo5XLcx+QXs1JiK8TBVtAJUZJ5N5Cc5yM5GS7GWr
	1bqHaFUxnUTUuo9UIftPu+FQOzS4lslzFd29Pc7QUuYf8dSSatUYqez6lvFtjS9r
	PdeSw0VYZs2q1Si96RyfeeSTvEu8h7sAUNluwt5LF6Dw5A7EDOlUQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sucmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659AJbRG005403
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych1fcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659AXiqC40698292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:33:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BC1120040;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 638CD20043;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v3 2/9] s390: Add .noinstr.text to boot and purgatory linker scripts
Date: Tue,  9 Jun 2026 12:33:36 +0200
Message-ID: <20260609103343.107325-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609103343.107325-1-hca@linux.ibm.com>
References: <20260609103343.107325-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mj_EMItlx9BKk3m7GOYsNfTgrqV_Mw_2
X-Proofpoint-GUID: Mj_EMItlx9BKk3m7GOYsNfTgrqV_Mw_2
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a27ec0c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=9kNBAdQCpEflj3fUxFoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NCBTYWx0ZWRfX/zDA0pZa+YYD
 AJkK8whlCRaAktH7HoDNtZ7GzXJ4CUyXH7BXDK25aQyOOOCa5ZW/CWOnJUuAerPoPeOs71KsO6k
 wAT4w4xvP/3Vv8lCXfT76ZO3CZ6f/imwrzH4UgSPz3bahJ+ylLh4hyD0EzU7Jh70ynRGOM0PKHp
 2JqYH1N3qhoAOwdZs7WBZAFhx06fjiohFk3TIijH1Rl7IS6sn7+3DFOjEx6Uy0oc+I+BEHfgnsb
 3peHgNHxyDcLR8tSipB3TZ9rE9+SnAGhgEHJWpCaYNsNmxSrieHqZcilkVpW1dXEd28Qjh/OeuW
 ovAW/L8g3I4fA13u9kMuZ2yDHvNo22bG+QiIkHZ1n7unjays7TrrkVwiRdAFgCVFqSFyZ9+uDU0
 vqJFPKgdYLni6wGXKCb2shmcQGYpxdMSStgzn6QoFVX2+QtaSEDw5mAdWQWl2OSfa7xjlHinobD
 xwT/X6rUgSUIHxEpgBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090094

Upcoming changes will result in a .noinstr.text section within the
boot and purgatory string.o binary. Explicitly add the new section to
avoid orphaned warnings from the linker.

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/vmlinux.lds.S        | 1 +
 arch/s390/purgatory/purgatory.lds.S | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index 070bc18babd0..d44964592541 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -31,6 +31,7 @@ SECTIONS
 		_text = .;	/* Text */
 		*(.text)
 		*(.text.*)
+		*(.noinstr.text)
 		INIT_TEXT
 		_etext = . ;
 	}
diff --git a/arch/s390/purgatory/purgatory.lds.S b/arch/s390/purgatory/purgatory.lds.S
index 482eb4fbcef1..387d0db4085f 100644
--- a/arch/s390/purgatory/purgatory.lds.S
+++ b/arch/s390/purgatory/purgatory.lds.S
@@ -19,6 +19,7 @@ SECTIONS
 		_text = .;	/* Text */
 		*(.text)
 		*(.text.*)
+		*(.noinstr.text)
 		_etext = . ;
 	}
 	.rodata : {
-- 
2.53.0

