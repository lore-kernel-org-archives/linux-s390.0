Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEFA40B6D6;
	Tue, 24 Mar 2026 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374195; cv=none; b=XNdshLInCVxv9HNVyW/BPkG3Sc0SPApkACpVTZ0MSTFawz+Vqs/GietMqVVqq8BeU/4F90SZUTsLa1PqWyva/eF8sxgLi+gT7LomzDTg7fiiEzGhnGcver8oW7e6u/aUK8cZ90XSlrAiEQjjrXK0e0N/w8rUuTXRftmsiW8tzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374195; c=relaxed/simple;
	bh=AD1Wo2ci/5DqF4gGSVesfq5rSxmCnlBmXMXYiJZ+rMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjJ3jhyRoxf5S/bBNSdjlzHX1VdZNILHMWANZMt71wrtojIPBTdVFw+tiH3mRsmTLILvb+ZMs036Bm4+/YeRO5FuqjyUsDyYtwWoC/EOWSyCaVGVrNRRiT0c0rF6I9UsMkA6XBlRxctPeZWDjJ53kT0MsePrfDchVTaLJH94HTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tC79Mmkk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tC79Mmkk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OEp8q33448655;
	Tue, 24 Mar 2026 17:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lTiUuR+K7zie45gtF
	ik5T0EO3v+6hZxFUJ+mJC7sVzA=; b=tC79MmkkIfa/FcAqGV7yL4FTJkLIW8XTY
	jJevYnoyagRYjWdVewrJvg0ucfQkdL2G27qHTHoLdrTj+plarV4TCpn8Zt22fUqE
	iY5/O60uM9fRy5hot4JG/TBPwS6x6F3fVojh/ZplfEOuBRnVtPZIKMDOGJ6Ncn+p
	/IijYtWDaJU8VZ7NocE8kYqTvqV/EIsIUVBX0IJMwQZ74FUHEPbh0R0MY97RfXrv
	xA+HB/lLprVD2Cs8T6MdZKVp1BraUo8M++ACETfn9/RHVwPjeN8Cos+5Twp15zgx
	NHs3vKkyJ55Ks9T/KdRCWZDC3jVOuF35/3CI2opmRa+3IkWJQPwQQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9vwks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OGIHeY026797;
	Tue, 24 Mar 2026 17:43:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275ku11h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OHh7mV31195486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:43:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABA7F20040;
	Tue, 24 Mar 2026 17:43:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFE8320043;
	Tue, 24 Mar 2026 17:43:06 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.26.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 17:43:06 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 3/9] KVM: s390: vsie: Fix check for pre-existing shadow mapping
Date: Tue, 24 Mar 2026 18:42:55 +0100
Message-ID: <20260324174301.232921-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324174301.232921-1-imbrenda@linux.ibm.com>
References: <20260324174301.232921-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oz2qMi1cPC74z_6ZkBpdOD8DY2HohzGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzNCBTYWx0ZWRfX+tmurLHFGu2y
 dE/mUlBMSP5kBbTnZkkXPfkq9E8kDhsZZQBId5VMPEZPgXvPwMVZLmjMaXDafJhipK8KFRkhOet
 oYEkBwclGur7kjz1GTfXxwVXplQyRTaOrvWRfSzDkm/863pMwpViZ6TjPJenVO0Q+xsYRJIkWQh
 Efdwmlyp5ZIrHQ52XXzraK1qPhPT7yN7AXiyiu1fYuwJUHPKVxOaXwS69pDgjptcR1RrbmxvVGG
 oTJHxBQZ67hs7PTEeYgVApcad/Srl5+TSiyLilPDDmSf4RDee00rTINOiMFXVZsZ4C0gVQwWjsa
 7tCRk1FwYgfPT7LEOdG5fPY+F4aKSABd5zZp+amXyXtFh1Y2vjbPmQM1nkdaoHr4AvLO0q3vDqk
 Ru+h0WMxLeTRwIJkdIZG5WDuU39rEOhaibBRhkUM/JVm7j7PR4UR/i0jHXtBb54APlSxFtX/iBq
 gcF2gJvzX8nf+QkD5jQ==
X-Proofpoint-GUID: oz2qMi1cPC74z_6ZkBpdOD8DY2HohzGc
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c2cd30 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=IDpXgTtpuR7I2MJaEF4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240134

When shadowing a nested guest, a check is performed and no shadowing is
attempted if the nested guest is already shadowed.

The existing check was incomplete; fix it by also checking whether the
leaf DAT table entry in the existing shadow gmap has the same protection
as the one specified in the guest DAT entry.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4ee862424ca0..8fd690255e1b 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1506,8 +1506,9 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	if (rc)
 		return rc;
 
-	/* A race occourred. The shadow mapping is already valid, nothing to do */
-	if ((ptep && !ptep->h.i) || (!ptep && crste_leaf(*table)))
+	/* A race occurred. The shadow mapping is already valid, nothing to do */
+	if ((ptep && !ptep->h.i && ptep->h.p == w->p) ||
+	    (!ptep && crste_leaf(*table) && !table->h.i && table->h.p == w->p))
 		return 0;
 
 	gl = get_level(table, ptep);
-- 
2.53.0

