Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72833CB8F0;
	Mon, 22 Jun 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144470; cv=none; b=Vz8gvUQ5mK7br6DylaV4dyfNjJzfN5fZ/kASOKUn19L/0VFhu2OY7OtYPJnSBDVXBPNyjhs+CaFOBi+YDBple2Xy2CEzPnSzVoX/V9xkidXUR7m/wPCGemp/3CsumP0nW8Dwyu7flnlUL0umqUI6ZG9D0GWStb6mgQRBmXMhpI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144470; c=relaxed/simple;
	bh=foJkRG4vkRZpigAdAM9BKfsFTchxWvWwH+I0FCrAQ+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyBA4gebBuC0BbiIN/MTEZIDNOrW9mNT74ldzGo3COjLGBg1Gsilt63PNLMzrnfC5yQXojS8T57PfdbJ5Y3MLe1008s+fp0i5/gvLlPpR7RPuqDkWMq8gxty3O8q6q9eiYERia4BLIXTjysr6hX1LWxjtX7ztsaiLtC6+CmojnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OqbtowWu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OqbtowWu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmgYl3333252;
	Mon, 22 Jun 2026 16:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hueKKIPgLu8lVGsmW
	ip9AppZpu+h5pBfqf+1Wmp4eSs=; b=OqbtowWu+TD8R5VBzAr1rOx5QeHMQdr7w
	O4Roi6GGjuJw2nAx3yGMIyoaq53FG5fSxVsaZm+CF2XYPFJvKEbR5d0c1ekscYOE
	VgR4QI1Gu6AA6sLQdLemIO+0K97uspk/G5H3cVw8GtcLWhZyR8J/kq2sFu2ncQK8
	HmE4d/Urmqp1x1/WoRGw10YxS8V9zuQACPkBtRlhEmz9ceW92qnyHHQ8K4fv+4Eo
	fQp9QBb+cCl4iDB6Mz3iuqq/sfTGAT363marr5JS6RC+rVTCoA4eSEzs44etpHdT
	vcg00ENpfeWZZqsNFDE+gt16LiE/Uof5JKRckA7o2pk9VAZj7NgNw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsj2je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MG4bvE028208;
	Mon, 22 Jun 2026 16:07:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw73vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MG7fKI11403542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:07:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E897C20049;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0EC22004D;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v5 3/9] KVM: s390: Do not set special large pages dirty
Date: Mon, 22 Jun 2026 18:07:33 +0200
Message-ID: <20260622160739.202044-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622160739.202044-1-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX/0HUHVKRwNVD
 NGERwmaNdAD5tWAJ+NaDJzGP+HeU0RP1aiE8bRYC0qZ8+Nb4RCyi8DuxD7S/YDYZJiNJOIwx4HA
 W6wloYroLT0XP5DjzJtMYs6gimabgov3q08st2Rj14VwQ8NvXitIygQQ3ROe1l5iPpfWpnTIfU8
 LCvgVZtvG2PxoH+MKgW1GbCBGFACUFstf/ixBWleppaYNBNqxJd3ZEPHSDcbgCeS2munDUrrv/l
 nWAL7wbW/2EZ+O4QNJe45lP37T5t/Eqmx1vLosSEV1LERSQO05KOAp38mw0BmQyBiPSIKtfBXmE
 haR5ypcJFuqKe2neSwONofUC8OndmC5NYsl+QlMhSpbasLFY34tLrauIYUmPL7CBaxHx6GI3y6Q
 /PL5aasnhvy5+uqlIDe7A1isSRf5JMpqHvhhpfGOgSqYWW2HGaR2ZTSI5mcfLtTIIpnwB74+2a9
 eMO2LA2DClOZF6uCLkA==
X-Proofpoint-GUID: MvTLhkZ2HEy-tV2hhchgu9DjVY9WNulo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfXxrEarLo3xy6L
 0NJqMCiDdICzgraGZ42s2gMBm/JcbPVxwIwJInGadXpWYKDAscZPvlZmfuxhcwTvDEY3tx94Vpm
 LQyp6pAflTQJRSXGjazSmxaxLqCkMJs=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a395dd1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=NX4vPgGMuaxhIts7GPsA:9
X-Proofpoint-ORIG-GUID: MvTLhkZ2HEy-tV2hhchgu9DjVY9WNulo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220157

Special pages / folios should not be set dirty. This also applies to
large pages.

Add a missing check in gmap_clear_young_crste() to prevent setting the
large page dirty if it is a special page.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/gmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 52d55ddea8d4..3192f610f696 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -327,7 +327,7 @@ static long gmap_clear_young_crste(union crste *crstep, gfn_t gfn, gfn_t end, st
 		new.h.i = 1;
 		new.s.fc1.y = 0;
 		new.s.fc1.prefix_notif = 0;
-		if (new.s.fc1.d || !new.h.p)
+		if ((new.s.fc1.d || !new.h.p) && !new.s.fc1.s)
 			folio_set_dirty(phys_to_folio(crste_origin_large(crste)));
 		new.s.fc1.d = 0;
 		new.h.p = 1;
-- 
2.54.0

