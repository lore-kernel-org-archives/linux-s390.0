Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90DA1E49F;
	Fri, 22 May 2026 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453004; cv=none; b=p6yW5+n47bN1lgcfktUY9xgj1KdwV5qkI45bwGVnEHIxgQEdEmYtcAH/sc4pA2V7kB8yOFN/mYjN0zgd7TfR0TauXmpH3OnmNl57VUQ3iwnsApehkpkw7XvQMpY/vIn/Rr4hCEZJKVWkWbG8kLfD+EIlpjl1TeWnN5mOkLukO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453004; c=relaxed/simple;
	bh=Secu8FptgjMWD+c/fx1iuTuRml60JlYjwBxqZxox8Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3vmA97EqJr0yJQIGzL7gHnw406+OpOxZsAqUT8pvvHiZ247jP9SPeeLm084W4KQ1snmaQiYEs81z9XOV/fAWICPrYahnXINMSBzDtocqh/Fl+kDPznn0SeQYu03uwpcwQGc9Znj6026sB6agZnPJgq3sn+X06db0/2ztFJRAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PplLdmbP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PplLdmbP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M0FHh7883231;
	Fri, 22 May 2026 12:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZW8uMLcDcELjaq8gT
	IJ2mQ5tL48A4BqRVu6NJ/oriVg=; b=PplLdmbPRi8Oz6hq/B9WKGhIXNEw299+V
	IhEolbNLQIQjdThyb4gO5iz+gJzK6kDntRO7GkgSprmL0hN4pU7Bm8naVpgcP3dq
	MkuY6ZXhcxH485SFQ8HWHJ/haKG4MWxS6ecQ4BMJGE83N8PLjJIl44ZxCnuxXGzd
	HJFmYhNrAyPWoWXSwhbv3XJlbmEH9Eaia2LbKA3mjRbPXc74mbUJ+v1VUCRD4iXa
	TqD1tq+jd56YrXY7JEqQ4Tgja3xUZQLHKnLk1eLTors0o47vLJIEqjqI9SpK7tPY
	l9rZCysW2JEelKcRURGSC/LCTYRqqMQnWIzZlOf1/KwgM9SnPIXVQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n3v3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MCO6Bf010442;
	Fri, 22 May 2026 12:29:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w8y1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MCTqEl51315168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 12:29:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 428BD20040;
	Fri, 22 May 2026 12:29:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B0102004B;
	Fri, 22 May 2026 12:29:52 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 12:29:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 2/5] KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
Date: Fri, 22 May 2026 14:29:48 +0200
Message-ID: <20260522122951.117120-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522122951.117120-1-imbrenda@linux.ibm.com>
References: <20260522122951.117120-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7cMfwEdqXOWiYTjgIapuV6IMsIySCZfD
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a104c47 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=EVFxPqBYVl373qEVmGMA:9
X-Proofpoint-ORIG-GUID: 7cMfwEdqXOWiYTjgIapuV6IMsIySCZfD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEyMSBTYWx0ZWRfXz2faYuqX8aGG
 Dq9+eMJvufCZNnEMvRMVHCSG39YrunNg3mBrie5yAUfoNtOgGOo0F1QUj1hEIbhp2gWnq7s2/lw
 dpR8kAR8UaHS3yT6LA/GGNEFNvb0x9PauEejy1G1G1OsxmklvBTP2c/+ER3aQmIY3EQW+z/OiR3
 g4R8idCX2wikDj+uxQVeWyBzm07uHPUfF1jpKV/W9TyCVVgcgSztmAevzQlprQbYThwHV++F6El
 kZ9M5QrWkFYTy6SenwffSXVkOdh/+x1ObyHzZ/q/+N1A72DsxQky18auCK5jPadf9+XsOj+G2eq
 v+rp4Sj8FYQZ0r1bUFDHNhMnZWKugYi8TZAhyLc/Y5zz0VBup6aah7XAAp4b0mHuuc/50iHHLzC
 vYfsslkV9/KlGzy+DnBmXGKOX/bFiwaR889dBO9hZdEnACr9OYZM0RY76F3rnhv1CKbrfgqn1dq
 3lIrdiezwdnJT5alj5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220121

Fix a memory leak that can happen if gmap_ucas_map_one() or
kvm_s390_mmu_cache_topup() return error values.

Also fix a similar issue in gmap_set_limit().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reported-by: Jiaxin Fan <jiaxin.fan@ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index fd1927761980..10c98c8cc1d8 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -125,7 +125,7 @@ struct gmap *gmap_new_child(struct gmap *parent, gfn_t limit)
 
 int gmap_set_limit(struct gmap *gmap, gfn_t limit)
 {
-	struct kvm_s390_mmu_cache *mc;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
 	int rc, type;
 
 	type = gmap_limit_to_type(limit);
@@ -142,7 +142,6 @@ int gmap_set_limit(struct gmap *gmap, gfn_t limit)
 			rc = dat_set_asce_limit(mc, &gmap->asce, type);
 	} while (rc == -ENOMEM);
 
-	kvm_s390_free_mmu_cache(mc);
 	return 0;
 }
 
@@ -822,8 +821,8 @@ int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t
 
 int gmap_ucas_map(struct gmap *gmap, gfn_t p_gfn, gfn_t c_gfn, unsigned long count)
 {
-	struct kvm_s390_mmu_cache *mc;
-	int rc;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	int rc = 0;
 
 	mc = kvm_s390_new_mmu_cache();
 	if (!mc)
-- 
2.54.0

