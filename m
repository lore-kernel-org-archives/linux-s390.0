Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209B364953;
	Wed, 24 Jun 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299981; cv=none; b=c6rTAKZlHzb7LkZNBiG91xhr7qqAywbQVZE1byLnOF+ucks92mwqmWM/gnhqE9u65eMy+ypp84IT1YXgIq2rK0awBaVNV3ipBVONJee//GCMDUhgFdcj9D3HBU9EZGSC3g/zP/Vm0oTQRFl3pOc3qAcg6p7aZnCX3xUd0Lijz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299981; c=relaxed/simple;
	bh=ZKE1tR1ORcSfKo9zZ/woQMBWzdqTZ/td57McTis6EV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJp+v/j4CP5fBRFrXnAkfhHyrDbxocdjQjZtaBzx8GwGMqdH01PLXSq6w/0M9RW9RnZl0eHMqUKukg+9gTjAh8zN5JWD9+OZQDaVXIYtqGWhlpRAfbYdI3ibZ5uqw0biboJK5NNIRCCCkb/Rz1Gqj9SsYpYGJQ9T3IB47EslYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nnk5BDaA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nnk5BDaA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmRg6718050;
	Wed, 24 Jun 2026 11:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6rCspicw7DaYG7t0a
	cEtteh90hNs+SbwCCzgPOEJDYA=; b=Nnk5BDaAZhTfsdUAID79uEoltIWmPQ5Rv
	7nBoPbkxv671sbcuXMN5aRvxDS6JFxqNw2x3XumY7xTQJ22YCdvZpc+E1WAeAJ9q
	8kPNzpmyX3Ki/ggX7dmM/ONMgw+/v0pFhiM1WGNYUjeoCGTOAdZTYGl1erxmGkOI
	36GjbA141Nd3bON1e31oCD6CgTT9B3sfYIlPqPiZU581qZHj+6/P80tBTvb9fVQD
	eh+D/0XleKK9VA07cRE46wDGx7ci+hFuuxUQH0sZzHl3fZvmtzPMOS6KGHUjw9Ps
	MY9aeYfR+EBOSddNGlwGijTvZsZUl9fpLjeNLpfVmrlyPxR7dNiYw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3kv5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4gKT001543;
	Wed, 24 Jun 2026 11:19:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k88ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJUhw38011320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B6E720040;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 208302004D;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 05/12] KVM: s390: Fix dat_peek_cmma() overflow
Date: Wed, 24 Jun 2026 13:19:21 +0200
Message-ID: <20260624111928.144283-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624111928.144283-1-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3bbd49 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=0SZZOaMt82sS6LYugLYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfXxFzQXF380ouT
 4szB9G8Xc6+Mj8twOjSg8LsobpYFI8KRONOSE93E7qT1D2DSA/y5LB0j2gi5TB/grhbV4uTGEBy
 iKrXHuFn+DeKIq+XgeNdWE4Uhvx3Uk0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX8AuyLN2mSoq6
 +6z6v7SZ/bSeKIZ3lux2RDC9ztt+jXLOYbSErfMz3w/WacZJ+pjU+ycWKaYW+eerWkqvw1P8SY7
 bpyK1lJ9nKK+kDtWZHqTB6yarCj27IwnRpxWIz+WA+Q/FXln2WugBg87BzWRQueINzIyEj7MABa
 khJab3UrJLl7nV4+y8rKT6fG1LBuT+CfuDRj2pQQ7n2aYtM/9CEOjESeNKO+8wyDDBt0VEGTH+b
 vrkZyBiHcmDlMSiLWIeN0acvwBpVbs/0hN/5F1VkFkicai4YNU8j2mZcZIt+aBkdrwUUTasoFSM
 aoxesOtSzcr5z8IKBAqw0HhJyWALVY3YXVjjuCEgf3SROULrnKd1Tpv/7vmMCbedIKbS6Yusz5G
 pXvKN33gwB2d8rYTBuQ8ZCVG3h2UNg==
X-Proofpoint-ORIG-GUID: 41AgCub1WxcueVlOwv7l-sM2g45k4-DT
X-Proofpoint-GUID: 41AgCub1WxcueVlOwv7l-sM2g45k4-DT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240094

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
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260623153331.233784-3-imbrenda@linux.ibm.com>
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

