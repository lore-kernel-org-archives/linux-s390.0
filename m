Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791872;
	b=oBbW9SwiV3/ksZXRFv9GnxdN3V+Q2GjmyT/3Dv8ZSNuBiKgI2THwoo/ETydHDHsaX2s9
	 uy69HuVvPz5UcyQHNPsoZ+9h1nTuPv2l89X8dwzaYEsqoKQ014jHSjINVKYwKs9fEwdJ7
	 6rQGIn2NNYcW8Nvj1IJd/xiDOvP2UM/vVP+mSvwJzxwaxUwqbvY9TAfBrFL8vME7LQKiC
	 RvC2447/PGALTg43bFrww2TkQVMONrlb5qeDJyzIUDWYftnQy3D4HWQicR9mPnhjMP0hy
	 ihPw0H2D4kHssvLOOd3+pOyEuC1Bag6FwNLlRLIInOZvNFbAfFfwn0DUz1FgptV3wVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791872;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fsm3GbmlJTiSIko5/J8bY6PBBaJ5aeGKypybp4/N1M8=;
	b=zAfkghMgklR0yKGV70Y7yDSfxSlKQ2dmjVv9CWo0lo8FzxKYv5C43ovojiqKNAmqdIEe
	 TIkPsOGDzBk4HAlu0YbdrisU8J0NnyeYS06iuBdHaGFB2SIxKYnnUfc8nzkENrocd2s1u
	 S/4eWryuGtOly7+R4sfDzoXAW73Xv2WVQU4uPrGBbagoPjEqCsNvHi7VDVTKXcr4TFR3a
	 SzArozmr4r+NpyA3hCwF1DBEcnpAaVeElWbWrjdoFAuLfoqg37740wdXItheDMxfglYVx
	 C2JnWDcJicRxtxYXpdPEla1EdPnfSJ05779mYj3/HQv+PXAA2hjUkJJMPdU1wkL8hVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MkYmKs1H;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C90606A323;
	Fri, 27 Nov 2026 15:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C90606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MkYmKs1H
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4Tjg1649965;
	Fri, 27 Nov 2026 15:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fsm3GbmlJTiSIko5/
	J8bY6PBBaJ5aeGKypybp4/N1M8=; b=MkYmKs1HfqDSMq/HNXeqjHubjealsYYYp
	Zpfa47QFRR0COyEAw3G8Q0dtPgctuPuKr4HlXoQ4t+TgTW2VccVKTVKIY/OaOf7b
	24Ka7D6qBGOAfIhNuWQEQ5zEGOF7vIaEJ4xI6Kr3D6PX5hH+Bj6lDpyEQOELueqB
	evWi0SmehiSICibDvy1cSayTQwAoyKspZLQ5izeVvtFSHm0w9ZeXSAYJj+LPomzR
	oyydf7rCbcSuqoyQ11avYu8dIfg28c6bDcdekGCxyhYzQBgYhjzYNhaBA0SZGRbi
	gNzSYiC2/+o5pRQspjYEPgTVCHetXtWrDUL26KJhcHf+y22NX/mWg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3pcbm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4HXO2819251;
	Fri, 27 Nov 2026 15:04:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfaanmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4Irt56623498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0262004D;
	Fri, 27 Nov 2026 15:04:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91C8E20040;
	Fri, 27 Nov 2026 15:04:17 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:17 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 05/12] KVM: s390: Fix dat_entry_walk() with DAT_WALK_CONTINUE
Date: Fri, 27 Nov 2026 16:04:04 +0100
Message-ID: <20261127150411.221072-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127150411.221072-1-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b099bf9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZB-jMgGvMHF0BiKFYkIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX/IYZee/rZzG8
 iMuhSW9ogP4dybIVNu0DbNbQ32I1Uop+xi5ZrI6UZ1x2D+RqgiB189A0HVs8zq+9Okn6yl5m3CT
 mR0YksuMbFvJ4hTDUkmyV8pZ7KdGwaM=
X-Proofpoint-ORIG-GUID: Kuxn9L8OnXJN0tsssZaIWtP5Hk6xDGvy
X-Proofpoint-GUID: Kuxn9L8OnXJN0tsssZaIWtP5Hk6xDGvy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX7txrWW4D9sd7
 5GHb6/OtbW2395bVgPQmCjVKEt8oLWSETqEmgmxp12P7XFdHt7QNh6deMNKGCXil5gkWhrcHaf4
 KNbVeFc8sK2wwOs46gzaH4fahri1UxdrXKA3AtWxmLniM0dHv6h6GtF+7pm620Iahvmqp7hGUmX
 +UNWj8EL80fBABXtYnoSWKpjUHihyI487Ltt+nXzeVpGtngej1gblGsU12H8LUanND9j3qobh0d
 9I8cuDzY6fmoX1/MGohJOU5vIEfwe0o4dFPYeKrSKrngehXvubbwZ/PPOzl8KK+ndSlPC/eQS1s
 m2AErSXBy85WqRrGbLMG2Qjm8pi2QeZeiehpzp4kS0+/mcSYqTtGPamGdZPSG0eMLzNVb65pCMQ
 2v4lQ6PglB++afknTmb3k25J9ihVmE275LDep3Roa4NDWJsSfwWpxVH+R+b2xRuG2DfPWq7etYz
 HoVFWQ8rnm/jDaQ2//g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270060

When dat_entry_walk() is called specifying the DAT_WALK_CONTINUE flag,
the page table walk continues past the specified level, towards ptes.

If TABLE_TYPE_REGION3 (pud) was specified together with
DAT_WALK_CONTINUE, but the segment table entry (pmd) is invalid or a
large entry, the current code will return a failure, instead of the pmd.

Fix by overriding walk_level with TABLE_TYPE_SEGMENT instead of
TABLE_TYPE_PAGE_TABLE. The code handling segment table entries (pmd)
will correctly handle the situation and continue to ptes if needed.

Fixes: 2db149a0a6c5 ("KVM: s390: KVM page table management functions: walks")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index b9507daaf327..fc3e1420a4bb 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -425,7 +425,7 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 			return entry.tok.type == _DAT_TOKEN_PIC ? entry.tok.par : -EFAULT;
 		if (walk_level == TABLE_TYPE_REGION3 &&
 		    continue_anyway && !entry.pud.h.fc && !entry.h.i) {
-			walk_level = TABLE_TYPE_PAGE_TABLE;
+			walk_level = TABLE_TYPE_SEGMENT;
 			allocate = false;
 		}
 		if (walk_level == TABLE_TYPE_REGION3 || ((leaf || any) && entry.pud.h.fc))
-- 
2.56.1

