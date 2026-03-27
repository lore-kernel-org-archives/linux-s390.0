Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E0330324;
	Fri, 27 Mar 2026 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625055; cv=none; b=CCd+WqY1ny3yuqpP/4uZUyGU6uhK3SFWenB+6usZMZVFFQbxihScrsvGoaymh3/E7tqf2XDuVFJ3Cgi4bFlxGO8IoPeQKiE5zMoWVt2lKXwlfAW9uwh5fyEIrMzneWXsSjHG0ySqbr6qHeVn9b+xhMMFSDAQ+mZWFIJexn94Jxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625055; c=relaxed/simple;
	bh=q7yXiF0uKPbiw7VS8bak9xECjyPCR0gMe8+2I2IN0nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz+cFfb2zpKdOBbk57DVEtFBqvX6fiHlk9TBmOVO4aCaf88ZVUMbu8EcCa3DbUJtsDKnQIyFhArliSsMQgeODeZZctYJrujlYIkJYATWtnObNj8CNTvLfPn5KWRg6N+Rhze1gMtGtN5B7UAPugvwAktEeSuDERm9KxRsOb73Fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sA4l0KnG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sA4l0KnG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R8Vs48665898;
	Fri, 27 Mar 2026 15:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZLWB6iPo+7QH+u3FE
	LZQ0W5i2jslJonjWggZdAwrOUc=; b=sA4l0KnGhp5GixWF+U5eDrr9tXgfpc5uV
	64m5u0o6cGEDLzDb3lh47fMnJNq+eMHs9E0HBN4ZMNu9BxQbMy3SRU80SjmOwvS6
	fB3/pbv7/Hx9j2cKEEDMRckfjSYQdeurNHenCJAzNN6o21M/NbnUNvMKqJlfU+vz
	zYhu7TXfXYKWCEEWaf4dMI+KP+aAt6mtrukHIjsVC7i7qInk20QtQQ1Muwqlp93f
	E8UYKaj9ASa5qJ9ZAFs9CrSM0LtYf8hYWQhJphuBGNNkmdfSkvrQZbEyVqes7e4b
	SIsNHyHS7px6GACzM/34EaXtQpdabaFL+/bLw7Gx6Rtd1DgDIPmbA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwaaty0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RBTQMw004387;
	Fri, 27 Mar 2026 15:24:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2fs04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFO4H116056728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:24:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF2D52004B;
	Fri, 27 Mar 2026 15:24:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A1F920043;
	Fri, 27 Mar 2026 15:24:04 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.84.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:24:04 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 09/10] KVM: s390: vsie: Fix guest page tables protection
Date: Fri, 27 Mar 2026 16:23:55 +0100
Message-ID: <20260327152356.250625-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327152356.250625-1-imbrenda@linux.ibm.com>
References: <20260327152356.250625-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c6rMEbhz0kqeUa3FO4GwrRe_i2eJ5gD2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX/kSi6hq4uNJD
 Q2j7RuFv6BuPNsPRef3n71XZx2YgdlrvLgcQSQMSuHwY0Fo3/C6+rVfx5N46nqVXklKAC1WmuPA
 wlggax2dpoT/YvpUid2Ki2u3QZiZOHNfzjREC8wYumMxZYxmBidzEbcp5a9yf+U2/04atCpy3NH
 OLelXF/Rx+es2VcK2lnCy1ic6ZzSXFgbtRhe2iV7YCMyBPhbvb3JlHgDW9tB7bXGi7/Sww3phii
 s7y8Gz9jpI5AknP1p4SI5F16tyaEYzz37KCvoCzNdoTrrZbWRE47tnigxnYjYrnGPWU14VtiK/N
 +HHaWIBucfb4IHG3yMsLsEoIs5XNs0JCodRoMB7wqv7UT23RozTqaZnlELM28znv9r8URl8B60m
 V71CK6qzo77F4bojUXNGj00+DgZIZb/gJ+VhBryXYOTZMFI0BOpj9o8hvye+V96MPYTUhpajXow
 iP+cIDqLeb1z1tBxBWg==
X-Proofpoint-GUID: c6rMEbhz0kqeUa3FO4GwrRe_i2eJ5gD2
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c6a11b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=oWLg5jHnNaD6DMA7ueYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105

When shadowing, the guest page tables are write-protected, in order to
trap changes and properly unshadow the shadow mapping for the nested
guest. Already shadowed levels are skipped, so that only the needed
levels are write protected.

Currently the levels that get write protected are exactly one level too
deep: the last level (nested guest memory) gets protected in the wrong
way, and will be protected again correctly a few lines afterwards; most
importantly, the highest non-shadowed level does *not* get write
protected.

Moreover, if the nested guest is running in a real address space, there
are no DAT tables to shadow.

Write protect the correct levels, so that all the levels that need to
be protected are protected, and avoid double protecting the last level;
skip attempting to shadow the DAT tables when the nested guest is
running in a real address space.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 8d99667e7d34..53a8550e7102 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1529,13 +1529,20 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 
 	gl = get_level(table, ptep);
 
+	/* In case of a real address space */
+	if (w->level <= LEVEL_MEM) {
+		l = TABLE_TYPE_PAGE_TABLE;
+		hl = TABLE_TYPE_REGION1;
+		goto real_address_space;
+	}
+
 	/*
 	 * Skip levels that are already protected. For each level, protect
 	 * only the page containing the entry, not the whole table.
 	 */
 	for (i = gl ; i >= w->level; i--) {
-		rc = gmap_protect_rmap(mc, sg, entries[i - 1].gfn, gpa_to_gfn(saddr),
-				       entries[i - 1].pfn, i, entries[i - 1].writable);
+		rc = gmap_protect_rmap(mc, sg, entries[i].gfn, gpa_to_gfn(saddr),
+				       entries[i].pfn, i + 1, entries[i].writable);
 		if (rc)
 			return rc;
 		if (!sg->parent)
@@ -1551,6 +1558,7 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	/* Get the smallest granularity */
 	l = min3(gl, hl, w->level);
 
+real_address_space:
 	flags = DAT_WALK_SPLIT_ALLOC | (uses_skeys(sg->parent) ? DAT_WALK_USES_SKEYS : 0);
 	/* If necessary, create the shadow mapping */
 	if (l < gl) {
-- 
2.53.0

