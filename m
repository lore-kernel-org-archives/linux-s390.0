Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E063B47A0AE;
	Tue, 16 Jun 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628682; cv=none; b=sZR3PRmcm8cAtAxL9XDyGhzQvBMm0skj8GfpzdvcV6Szn2zaENulGdaLjHiies8xhdz87Bc+zQpy9uRlaxmKz+KMCtsRIRK0DUc9W8IVWARLy789GxyQlHbiXGBuuQ+fi+UFo7WWyqcZa78Ys2TSVaLfIhwGgmnb9/ieSkFy1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628682; c=relaxed/simple;
	bh=MotyW5vj3zXvDoMxIEdjCCbCRVxwaVElCvaRRg6AbiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+lMS7evUWBd+ZPohaAfNxJ7a1br7D3nCOFLO08MA69ULCpSqkmcojVjKQCD9wfN2UXyGtkjsgIPSo4Ro8qq4nn9Z8msooLxjIZJ9gbsdFM0gygX4DJRU8MtYof/Hvi9F1MHhWrjswAAkHMD0tZMgC/KAut8RtFuECtVb89Lf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nuD5EJMA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nuD5EJMA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GFmVNB2118620;
	Tue, 16 Jun 2026 16:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TzaokU+Y+h3u3u2lE
	74js3Fr+ir14XtNtlTgxLuH7gE=; b=nuD5EJMA7XtSxZn3cfZRCDz5LHy8xhPEe
	2ACPetKtIifQlxeoA6v5aavmc0kfD+wB9hqgMWDO5wlXIsSk5XmFcyoLgpHaUS/O
	gLbrM4p/kxkpEcSgdK1u3MgNyPXWxNqRZb/pg/4VH1p8bklQfF5ah8PvzDwuQgxt
	AlGl1r5OEWAAvfb6ZJGdGRep+63gjmxDRoH4Iin7KXuEWEockeJnjr/+DXM/7+hF
	9DOxy3dBSBJWtMVhL0Y2Rv2nyrjLP12W2FuUkxeV/DrXxU/jZJMLXdr1GrFGIIdY
	iEt7uVgJDQTVjtaqVnJpCcZMOSjqb2Zc433wzeXP0Kh8QHsktmWag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h8713q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 16:51:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GGnhI7009589;
	Tue, 16 Jun 2026 16:51:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhk4dam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 16:51:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GGpEKu40763810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 16:51:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A9C420040;
	Tue, 16 Jun 2026 16:51:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4193C20043;
	Tue, 16 Jun 2026 16:51:13 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.66.4])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 16:51:13 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v3 2/4] KVM: s390: Fix dat_peek_cmma() overflow
Date: Tue, 16 Jun 2026 18:51:08 +0200
Message-ID: <20260616165110.360921-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616165110.360921-1-imbrenda@linux.ibm.com>
References: <20260616165110.360921-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX6ZimWGNpBdXb
 rWYn7epGKwkDHOehj9eJOZy5aDwfAw/T+lFKnV31MvKXbcXROTEvbfO/oNYYvYObzRA9B5YwWcM
 DoQv7TxXsx5ruLsnFDwJMAg1QOKwx4o=
X-Proofpoint-ORIG-GUID: P0_KTZl33TSH1MKpOByAy3QdhO0AE03k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX4XJnoHewgU7M
 CeQQXbn6IqqONkHs7pWy2mm29AgXS57dazggUO7AQauw61h+3NdzKG4Mc7QznFVpo8zHQj4atne
 ilAUsel2r5+vWuFwj65stBIh29XbTNDVqH5Tf4mC9Js+qlzZ9Y47fJutCXJjHSnCUT0+n050BtO
 0kUEGaZgbUPgvHXIj+kZWrabsTFGcDtWSuZfpoR0G4LYO70C3wQzibT1/O/UsqoYZ11Ir1dmgma
 hwS7o8cuWkdfPy6sbqX/RiI1W+FBRcRwLu/kOovxQcly50DvjQo6rMDFsITGLakO1SLtLekQzpD
 YugEHRqwIeuN4Ftk0CKea5ZmvbaAaT3CubjL0bZZplmKM+sInxXT2S92vvNfxGlRhPSs9pl0PNI
 ZxVjpXZz8cDgzVtgy0LyWbpwx1J1DCOKLa7J7kXl4p8ZRufYVj4c+dAbD3IiZGqtZ1Gqy42UKC6
 eB8+2/P+ozGsA3wExGQ==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a317f07 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=0SZZOaMt82sS6LYugLYA:9
X-Proofpoint-GUID: P0_KTZl33TSH1MKpOByAy3QdhO0AE03k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160173

If userspace passes a start address that is out of bounds,
_dat_walk_gfn_range() will fail with -EFAULT, but state.end will not be
touched and will stay 0. This will cause *count to underflow and report
a very high number, and the function will end up erroneously reporting
success.

Fix by only setting *count if the end address is not smaller than the
starting address. This way invalid starting addresses will correctly
return -EFAULT and *count will correctly indicate that no values have
been returned.

Fixes: 7b368470e1a4 ("KVM: s390: KVM page table management functions: CMMA")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 4a41c0247ffa..cffac7782c4b 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -1209,7 +1209,7 @@ int dat_peek_cmma(gfn_t start, union asce asce, unsigned int *count, u8 *values)
 	int rc;
 
 	rc = _dat_walk_gfn_range(start, start + *count, asce, &ops, DAT_WALK_DEFAULT, &state);
-	*count = state.end - start;
+	*count = state.end >= start ? state.end - start : 0;
 	/* Return success if at least one value was saved, otherwise an error. */
 	return (rc == -EFAULT && *count > 0) ? 0 : rc;
 }
-- 
2.54.0

