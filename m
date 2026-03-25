Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89B3264E2;
	Wed, 25 Mar 2026 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472522; cv=none; b=oHbALnnmg0yVhRxovjrRSlEQUTXWPb+bsS8aj4Xauuxe6c/H6CCqn5LsxOcjZBlw4VjXPCQt1MBA/vSaqiB2hHslTY7A9DN/Qq2x5eTKOink/C3QQbdjqKcmAwKU7xiTdsGL5T1wcU6lShSGZaFp+KLd9t42cKtBpoYpkey6A10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472522; c=relaxed/simple;
	bh=p76+bNHj1RzRVON3iTskt71WjJtdn+xktZomXKhr8xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/qgIY1imYyH0MHEWtubOsA+sNVOB8eSLCpTkUX134BO7PnsiodJichqGVzGd8sBzJ/UCs+nrGW+2oYGl9+lXvtGzrkDF7mszNBnZY4gsCb88HSNqv/RtXXvR3BAs4cbx/iaNNlL5YR7jjbtaYDqvQF1v1iAojC7VMwKLjr5AYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uk56U2E8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uk56U2E8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PCEI8B691552;
	Wed, 25 Mar 2026 21:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aovKZRY1qNFleNNyr
	SFpjmfdwG746o8nAcCzl3rHXKE=; b=Uk56U2E8YuJ7RKmyH0nvdv0reyIeoUZQ+
	lb9gpmS3nfIPzJdnPd6zsY/ppCk4rv6IM0YvlQVPz4199V9b198/2j+8zVJCFTSf
	JIkqZMEhEDKc0D7k8XKNMnmF/JYV46+uag2YyBVu2Y3D2ktXZheQPp2X0d+FaEsC
	V4mlCT2ijyj7ZGmi/8TD69pwok4eniYxLd33ekKHwn5Gu1bCx4x5wr92rnT8+HFh
	J3st0tUc6Nzwuk9h50cpDeZm8Z22QiFptGDy+pD2AAvmaQ+C6CUcTiPfq1WoAWgX
	n+L22871YKYVfHBykDYZfRsea/5VH5t+arQ+byOpGv4M0ElSKQo7w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv1hhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PJxqwk005976;
	Wed, 25 Mar 2026 21:01:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yrat0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL1qtf39649784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:01:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 941425805D;
	Wed, 25 Mar 2026 21:01:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9175C58056;
	Wed, 25 Mar 2026 21:01:51 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:01:51 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 01/24] fixup! KVM: s390: Remove non-atomic dat_crstep_xchg()
Date: Wed, 25 Mar 2026 17:00:48 -0400
Message-ID: <20260325210149.888028-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vwtmCUSz4j-IhH-zNlNSJf8MZCkjjf7r
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c44d43 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=lXafCBgdT3Pbg7ryY5UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX1vSvm7bJpVxD
 WeNShLLuR3tDhV9wzyny/Zdq/f6u/XVwpMBFlauGSeUTKo9y0J6K3iMtLaX4AyNGnAQs8iRx72Q
 Y5A1WeGP+Ob9LBPHMWVn+6YJAsX4CBJbG1NfmIQEBj48nbM9b2+dLGdb7RLV4SuCodLlxGLbNyI
 oHny4xD/RU/EpOjsbdinC+TzmihQ88cPw1Im2Dw/7awBfwwQFtdJJxxgPnywPaxbj0Jq1IQJ3yx
 OIfL/zaEQ2iD3+hTfoW2/JVKTMEGUDvs39Xh6QkZMcEPt1NO/Y99OC+4Hbkqnt4nboJMX6o5qA0
 9qLNbtwaDda5dNILwH1oOar4xXTOYq1hNt9GFgnTRUUOaYcS2tZPixggf91F2CAApBdWNFwiz6N
 xq3f9EtYSdXnApqmf94bl2GXOac2HUWboESiUYskthmYJB0VZZf246gjfsx4r7SN+CK9nPH4AKn
 gVPtw1PFY3qkfpfvhOg==
X-Proofpoint-GUID: vwtmCUSz4j-IhH-zNlNSJf8MZCkjjf7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 967a280b3235..19379d162777 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -198,7 +198,7 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 							 union crste oldcrste, union crste newcrste,
 							 gfn_t gfn, bool needs_lock)
 {
-	unsigned long align = 8 + (is_pmd(*crstep) ? 0 : 11);
+	unsigned long align = is_pmd(*crstep) ? _PAGE_ENTRIES : _PAGE_ENTRIES * _CRST_ENTRIES;
 
 	lockdep_assert_held(&gmap->kvm->mmu_lock);
 	if (!needs_lock)
-- 
2.52.0

