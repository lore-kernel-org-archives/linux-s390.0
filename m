Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2367749C4D7;
	Wed,  2 Sep 2026 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359866; cv=none; b=RhHRclXz+Rif287bBQziWIPqN1E9D91Qta7oyql4b/sylubxoZNWUJjV5v6RRSs11BOtHH1DWOQQNgOLTWtjxQvARcZR2hSElPRwtp+/rsTIRtaDP72Lqfb6wHU4ki+JWa+Qi6KDM6tremO2DkCKGUX6ZqIXoSnbReBg9RWJ3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359866; c=relaxed/simple;
	bh=Z2SmtmE1suspIAmKKHbFLu6H2SwSdqIjvFfPBGIw8mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OsZ7k4VLOgSot6dCYRJ+hwHRw1UKR1QsMfXmRcrL2ilCkxeHIfHUVHY/dJqer4+oNmuW4ycMC52kSjDJCeQZBqBhNWuV7kd/7ZvGTqgTIiHYkYEb6biUrBncbOfj4NcTWM8I5RcNKHI1nhc/XpTUF/oK6u1Nhl6Bx06o0HhlI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MTcd2h7C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MTcd2h7C"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CVt3k046988;
	Wed, 2 Sep 2026 14:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=iRHFg86EO0/MN34t0IR1s3CzJshwoAt0NYJyN21zt
	bU=; b=MTcd2h7CViPyov3jtthYP9hErMGGOSHLjccUFjpgZQ9qnyIQYhDSzcq+6
	LXSUW5VP/BS/lhVoQBq1lThp9hDYvNhuD6mHkQrTq64rGFRLYQPRnCJ0LY/kDi3z
	TGiGDKHkUV0Wdsc5Danh0VSYt/P1jNybMJsr+intaYz1vmKIp/Q+hC+P5LmyheHJ
	OjLgWd6OtQfKq7/nvSWQPVKxgIagHc0EtqEDAhjADNNeS3qELgQF1sdf/wPNYw6r
	12tNWhFohsCg5HOKghARvmXQjHz5e8C5Hc43RUwvzO44zr3jA0RH6cJmLAQ+SmNS
	2bTOM7Fq5Set+JCjfzFlcKy+VRmkg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tes87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:37:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682EQHn8019138;
	Wed, 2 Sep 2026 14:37:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygj5xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:37:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682EbXnB40304986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 14:37:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9548520043;
	Wed,  2 Sep 2026 14:37:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59F2D2004D;
	Wed,  2 Sep 2026 14:37:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  2 Sep 2026 14:37:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 3F45F160CDE; Wed, 02 Sep 2026 16:37:33 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Bayer <gbayer@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net] s390/ism: folio_put() after error
Date: Wed,  2 Sep 2026 16:37:33 +0200
Message-ID: <20260902143733.433574-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9834b2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=YWMzHMNbCl421vV1xwsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX3ZL7SCahZHug
 ypjv5wWt3AoWurYhhwn7tfUhYhzJ+PLvURJDTdPlTllOu1Zmf0K1pMWsQvH7pw3+vy11QafET6T
 JWVU/cR3v/kTWjfZC/anGaAFfF0iyFU=
X-Proofpoint-ORIG-GUID: cb_pReO7UX88rfvXiYsg3iIo_Y1I9slW
X-Proofpoint-GUID: dMCPfe_cWoXXux3_NHcXGgVJUhGD4aq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX/EUha08rVjsK
 tszIPV40XQXwk5M+Y3R8zM0f/u461zjvF6MSoJbzURwqJpcGBkOO3gtVGwBEWQTbi1e165chBqV
 clP2tz3V6GJoXdRwiIhnss/Gl6ho+5trY0rr15nXRa4e5aEIiae6tIsiRUFQhXauGYltmdSKlWk
 DAevH/ltsf0vvL2iEGGE9Fw4K79Lz9Y6+tmxbAhr/nIMcMgOmxfYMA5zK71pnuoRssJPmGXyymF
 a7vPkA6tYOAYYsqSbh/+2pfNLzc+3N2fWfrNJHOeHdd/35XP00uDZgUl4EqVYPLZ6m6NK09R5H8
 xCsE8W8pP+A7K39MKo9CcNRHsPlnW0bIc4ZUk4b+juIvTvlXRouihVecL367KXekRLsJlj9nzjS
 xWRhUURTUTe1f7E0b952LqRt3t1SbBOZqtKm6lKZPf7CA2mTKGF081FjDtIC5ZDzF73fz+Ef7MI
 J6zaEf/ovvtMWzuIPbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020128

dmb->cpu_addr was allocated via folio_alloc(). Use folio_put() instead of
kfree() in the error exit of ism_alloc_dmb() to avoid slab allocator
corruption.

While at it, reset dmb->cpu_addr after folio_put to avoid unintentional U=
AF
by future callers.

Fixes: 83781384a96b ("s390/ism: Properly fix receive message buffer alloc=
ation")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 242da20f27e0..035b233abb4e 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -231,6 +231,7 @@ static void ism_free_dmb(struct ism_dev *ism, struct =
dibs_dmb *dmb)
 	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
 		       DMA_FROM_DEVICE);
 	folio_put(virt_to_folio(dmb->cpu_addr));
+	dmb->cpu_addr =3D NULL;
 }
=20
 static int ism_alloc_dmb(struct ism_dev *ism, struct dibs_dmb *dmb)
@@ -274,7 +275,8 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct =
dibs_dmb *dmb)
 	return 0;
=20
 out_free:
-	kfree(dmb->cpu_addr);
+	folio_put(folio);
+	dmb->cpu_addr =3D NULL;
 out_bit:
 	clear_bit(dmb->idx, ism->sba_bitmap);
 	return rc;
--=20
2.53.0

