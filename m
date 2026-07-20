Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657226B2DA;
	Mon, 20 Jul 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578780; cv=none; b=F/uocrynpTWGqc5j9KxetGRWgGODReKAVIQmQPveh6wHExHWpXya6mc/FI9X9HAW/b+/Kc3vo4ik7Hvevi0zwiPwfhsUUF4ThTwqRHzTljStZ5luvtAZoSFGyOxTTT1l31u2HdV/kmdaSkDuJEVVJ2K3RLo0ho0mIk1wsc7H5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578780; c=relaxed/simple;
	bh=Zk2Yn6BTowlC+vcUBVGFBCS0CLRUwNTuozzVXVqsUJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3rhFar40ru8yph+udNtqbWLucYauh2CrxxuZnPmhrDL/uo+eBjM3wYh4I1/aKt24CroWykf74ccU7HAnlvWF1PNDszYrUsBqy33YJf077UuyOBq1P2hmASnfXtbR93EDiuzXo0Q/J7kBxoPQocKQ4Osv20+PxDQV0pP0INaysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hzm+NSbD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hzm+NSbD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJfrMJ3124864;
	Mon, 20 Jul 2026 20:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ewyopON62ciA3L3OE
	cO2ShzrjKIHIEii141lYvtUvAw=; b=hzm+NSbDdomgPFWfPKfKCe6OMJ9fJY/LW
	9Vco6lZEI4RRXaO9UxAd6uF9IIWFB7ZFiK3W3RLsw9uBlDyyiTK14/5KesUG2N/1
	lqJ4AA98XpHTxkGRD03AhgJEd5dFv5sjcQK6zQhnsgzVHkUwrZkL0Krd6SJgBvu4
	KVjKcaOvzirpQNmMDzGAWSaJlzmAG618u2ukHSiTM2IKrhB7t6XS21uQ+Yc6MrNT
	168AIlreJ8UXPgl58ujgUnkVJA4M/0q9xSu9jC4kYGXiQzESKGoOTLXAanrp454E
	Desd9QQ9GasZBu6R4COgRiZMzw4Xag281wu66u8S1mbFHPtuXs+vw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab9c6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KKJbje015415;
	Mon, 20 Jul 2026 20:19:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g7174-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KKJXBC46727472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 20:19:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0320120043;
	Mon, 20 Jul 2026 20:19:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D102120040;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id B7800162719; Mon, 20 Jul 2026 22:19:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v2 1/7] s390/vfio_ccw: free all memory if cp_init() fails
Date: Mon, 20 Jul 2026 22:19:25 +0200
Message-ID: <20260720201931.976660-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720201931.976660-1-farman@linux.ibm.com>
References: <20260720201931.976660-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX7OfIni89QOns
 fWchE2G2MM9Er0K2zy8GwypYvaEYPdk5GRJUkCLUHNbKSv+gHsjbNGkcwsRa6xqb+MYpHHlTNeU
 ZudRqN9uhvQ/KWl8tTxkP8m65U3zFPTCQ8mGOeBuA3EWJm/0BQnuIGCh4obfgsy99CHmqi889y5
 yGeSW0BU4yw1QNR5hYolhvTQ3aFmiy4zg4C0H1urnj0ARwjT0d+OBUSRsUwZzDGWWPjopi098S2
 ZqVj9Bh7wpZ+qTse3w+bhF78G3/sWvwwyCF+9E+zZSuR5i36XUua0fDj3EYb8v0RVw7oBhFeLGy
 u/SRK0q4JRikVOalKr+zamxh4+Dq5Jtzr/EG4xBNsg1tUK7/T/sKOSS5XdOdYkkFGV/1x9urkwO
 m/+ns9pfE9r2JeQ8J8sUBrELNPXen3Z7EMRvlk9bAZhiQ13vARGRinCi7YnNqrhzM99ps+VTL4i
 uzEDIROkYWZE8iHJROg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5e82d9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WEmllObKAWPfCt-5-jUA:9
X-Proofpoint-ORIG-GUID: uD7PyJc6TKtwA2v9CSD8T4ej1_56JI6D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX1bswP7q6gQNG
 oS3QDdfewdrv8fRsswh7Gcp7tNmuJvOEXOJjdFZk9IYx6RyistNExsP+MAxDm1AJOYruwQ9XKA8
 m6h1KCl9CtsSSPYS46kUZBz0xgAwhIU=
X-Proofpoint-GUID: uD7PyJc6TKtwA2v9CSD8T4ej1_56JI6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200220

The routine cp_free() is called to unpin/free any memory once an I/O
is completed successfully, or if cp_prefetch() fails. But if cp_init()
fails, and cp->initialized is not enabled, the same routine cannot be
used to free all the memory.

An attempt to address this exists in ccwchain_handle_ccw(), where a
single call to ccwchain_free() is made for the currently-processed
CCW segment. But this will leak other segments (created as a result
of a Transfer in Channel) that had been allocated as part of the same
channel program.

Address this by performing the cleanup outside of the recursive
ccwchain_handle_ccw()/ccwchain_loop_tic() logic.

Fixes: 8b515be512a2 ("vfio-ccw: Fix memory leak and don't call cp_free in=
 cp_init")
Cc: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 7561aa7d3e01..086d1b54bdb0 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -455,9 +455,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct ch=
annel_program *cp)
 	/* Loop for tics on this new chain. */
 	ret =3D ccwchain_loop_tic(chain, cp);
=20
-	if (ret)
-		ccwchain_free(chain);
-
 	return ret;
 }
=20
@@ -486,6 +483,23 @@ static int ccwchain_loop_tic(struct ccwchain *chain,=
 struct channel_program *cp)
 	return 0;
 }
=20
+static int ccwchain_build_ccws(dma32_t cda, struct channel_program *cp)
+{
+	struct ccwchain *chain, *temp;
+	int ret;
+
+	ret =3D ccwchain_handle_ccw(cda, cp);
+
+	if (ret) {
+		/* Cleanup if an error occurred */
+		list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
+			ccwchain_free(chain);
+		}
+	}
+
+	return ret;
+}
+
 static int ccwchain_fetch_tic(struct ccw1 *ccw,
 			      struct channel_program *cp)
 {
@@ -735,7 +749,7 @@ int cp_init(struct channel_program *cp, union orb *or=
b)
 	memcpy(&cp->orb, orb, sizeof(*orb));
=20
 	/* Build a ccwchain for the first CCW segment */
-	ret =3D ccwchain_handle_ccw(orb->cmd.cpa, cp);
+	ret =3D ccwchain_build_ccws(orb->cmd.cpa, cp);
=20
 	if (!ret)
 		cp->initialized =3D true;
--=20
2.53.0

