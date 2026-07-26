Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65EBE63;
	Sun, 26 Jul 2026 04:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785038499; cv=none; b=athn3Vtq4U6l12Atv5IKPBCEqYX02giU6QL4to4fqmjyKZ/hehAZi9+NTydhq3takik+1X2QboRdeBJW0bTUWXJHYOesm1OFdL0xTdMcR8SU4QBsUZ3bI4NJZn+oCGfDX9rodFCuGPdB3c1le0NFLn+IR/7HNEWoN/hp31FZDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785038499; c=relaxed/simple;
	bh=p+PbP0myv75st5mwvzBTsdFK7aSDgUKdeNFvumRPnck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hvv7umvBujcjTTZJGwBdZvnUjidkqm3VMiQ+nXDrG15S+l99vWI40lBBImIwohqzbsmdtxsyfuoPgjQ7BFxDgKpqgM3b83EkDOWGUUIxFsqPkwSYYkG1CoxZUx0DHeTOztLRkkYMzGme8VroOXSh5qC2DGhfT+egnLukhwwqkvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k63ghTRH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k63ghTRH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PNHjiC1911661;
	Sun, 26 Jul 2026 04:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WRGNLeV0oXr2M/BZ+
	sfXha8JHIJWYlAk6/V1XSPYaiM=; b=k63ghTRHVOxk4vod1dUuEZwPverQAU2IR
	VBNRP/m4Zlg/jXhNj9qF+0zEdW3FO8Fu0ksu0VHp7UzfGLaIOnd174Urp6EYp+bj
	4OtnkRAR9Sy75XlzKevJ0SKnIM0jardICoV+Q67GMXorQ+/bJ5Dyc+b2gvMq1de2
	AjXVTfgCZ/a9q7PA606T/ISYQBXQS7/XIM1VdIEZmgVNeBCtrNDempdz+UrBZ9PT
	gigQz9uecHVcPjvjxTa66mr57zjvXkj/bfBpxDBR7vNqF+DwMC8ub7NpYLGw0g6K
	Gmy7AzdP9huzzxuslVysn6S3I3/9M9B6GKPbTRxeJPZrQHqs4Uq8w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw72bqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q3uLan008970;
	Sun, 26 Jul 2026 04:01:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xr2pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q41WcB46203264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 04:01:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63717200CA;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3606E200C7;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 1D1F916151A; Sun, 26 Jul 2026 06:01:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v5 01/10] s390/vfio_ccw: free all memory if cp_init() fails
Date: Sun, 26 Jul 2026 06:01:20 +0200
Message-ID: <20260726040129.2946151-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726040129.2946151-1-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QelXM3O4oPNTe-G36-XJt06kPx-v7qsB
X-Proofpoint-ORIG-GUID: QelXM3O4oPNTe-G36-XJt06kPx-v7qsB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfXy+uIxQ+s9jWP
 K+En+dgZr0wiNAzIyYNEcoEFn4KFtmMEW1TlGN9f1W7+3Sy+xpZxxkfA8cOhuu9h9vgcV/WNWhB
 IT05AU2CtPkpzD/p0eYLinKZKAfvOFHueBujO1EsQc+Ym62nypre173umJr/g0Z+8LFGgMuRILo
 a0e4NVjU8JDl4AziN5hPSuqzS/SSqEO2PG/41dQ1qdwotcQnYjt8PKwYEl+L5zUjSnk5mluybEn
 1+gCHM03XX+xeD4n9yTLFQLfyCIfvXyH3rhXB4t5Wl74bvxZZarq82w3Bkdo0WQyCCy8/gvVm18
 xyRLxTATED5ZQyD6OmSw8LTZxNj8WS2rIuX2tqry3ynDnH6UT7G/BL93S56DU5dSkOJ8R9kj4uw
 TqJTcl8miwX451l1Lwmv2h3lTv5ugFSrUnloBnlwTeNWO7z8UHFmcMm7qV/P0CktCn/muHon5BF
 /iJLDJZZFZqkAeCuBVA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6586a0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WEmllObKAWPfCt-5-jUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX4C5XSrRcND4O
 sDjykJm615DUs+BHMd/r8y+D6kEdPqY46YaL/QzE89yCqMazdsQpG9J0evnbUyO2sPoqSFzBUd7
 evt+b+suYrmoPOPpS8eKzSdoN61opuc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_07,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260033

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
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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

