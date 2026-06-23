Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14B2D739C;
	Tue, 23 Jun 2026 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228822; cv=none; b=JwXPUJu64iA5nw1smeE75d0AjFTdJUaCSX1iiUtVliU0Oh3QkppfHNN3C6//isPAyN/Q/YVdWo59Ts9TvRBlTzNg4Rxo1Y2+bcmiAn1XmifOraueuiTXfl0XtHn+iN8++KCFnUmjyvHDGWu1cxFcfJjJ9ONPdS7KtVl32aAioPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228822; c=relaxed/simple;
	bh=foJkRG4vkRZpigAdAM9BKfsFTchxWvWwH+I0FCrAQ+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmYblRUlI+nZCqfs1zYER9Za7IsIY7Rr/J7NfZ8cHNknpjXlUAHIUOwHZZjT9wiyjTCHjfD2Gp3IhydB1V+U2Kwh6la297Bw+bWdRhQuabibbWUiZ+wgLVFf3UZU9za9JTgWZxSRz8xO7pqQLoBUGocvYofi9292eMstwV7Efyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Otw3Gszi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Otw3Gszi"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmtK41826848;
	Tue, 23 Jun 2026 15:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hueKKIPgLu8lVGsmW
	ip9AppZpu+h5pBfqf+1Wmp4eSs=; b=Otw3GsziM14Xhi34k4NJtBIIpGgC9e40k
	4axzDfyuOOoXvWwbtmK/2qR0SC9UaMg8JQIevt2K9jw97FyEX3ktAEGdd/cnTnHm
	kBuVq90Att5aACK5KxDCDwOmbKDfJtl71piFUmSjUXeaWh+qDrt1TBgJ+mkmhz9y
	ZrasJPxT7KoF4qp2bI1Ej6XYsbOhKCn0pBTPdm4NWHh2PlYkwaHX+JSTkUEL3o+D
	NfStkXd/z+jaE7gon7Zptfv/9LJjUUa34homSWSg8UDp4y77JDIvAJUzZ7UtT7+8
	M0S98UJlWcWon2EWsJ8TEN/1tZKVZydkP+PqorcqcpqDjh5fCc9hA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsq8f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFJeSH006992;
	Tue, 23 Jun 2026 15:33:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phbxt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFXWov32178686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:33:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44C1F20040;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 103EA2004D;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v6 03/10] KVM: s390: Do not set special large pages dirty
Date: Tue, 23 Jun 2026 17:33:24 +0200
Message-ID: <20260623153331.233784-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623153331.233784-1-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX6+JJoJXxzPMA
 k8clEqkr3+NU9G8QwM6N8jrXMXpJxWYPm9vjoqLImLtIQ8+XCpVT0WdDCX8nM55cTZHb1lYyohv
 VUuqBb1r+mdAHnfUj1MP20Hzec+Qb1Ln8iPONDACbYamXCR9IUw+13lMSIp2/EUsbN2hD9zNePT
 F9YY3mg21HcRQd7TbeiDPTxP1F6GUUH5NnlzaG22zUlh7nZDbu0qPwUwgboIHIxiLcXT0IDzuSh
 GEyIF/I5F5eT13/6wY2wmGZyR0gI+dbdJjH8fQLJFCBSyQ/HqFX6KxBMueHDDTwPKIXz2+o1lYE
 ttiWbLjbJ/ZjLziHerPkaPnYj47PgtaWJ7ztayDeYkodn12wQs3FPMsqHlXlFrjLkMGtsgPceZf
 Wgg1Mtm4tuhQRhqGjdX/zFjHrND65WuBNGGnkxkDDRtWbONS+mv1T/7ehCNsh41vdAqCZNSGtGj
 KvGjpficqbM1p5CP7Dw==
X-Proofpoint-GUID: 5V1vx4Pf143ULZSJ2NnNsPyKCQ2J48lj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfXwu9S+54k99P0
 3G/n7ZyUx3iq8LkYTIyXGB+DabW8YnO8ctum69pddP183WUh7NWwvH6vmxeF6iHCe0OpNxrDYEM
 iiyAr/UM0KV02KMyD0nCqEzxlhiRBe8=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3aa750 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=NX4vPgGMuaxhIts7GPsA:9
X-Proofpoint-ORIG-GUID: 5V1vx4Pf143ULZSJ2NnNsPyKCQ2J48lj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230126

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

