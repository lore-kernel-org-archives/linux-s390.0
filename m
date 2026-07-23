Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30553A5E97;
	Thu, 23 Jul 2026 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828892; cv=none; b=EBnnBtDwl3XC2Kh/2uAnwhR9w6Nc08wX6vWNYVX/7GACbMCcX2Cb05QWf3+tUnKXf5QKsCmLtuJ6NIsFi4sh+r1NXHrjilXP8/po3ADPrF1e2HI0dz2qHICcB9hszh7lwcM4bZTolfaEUeaCQp0OGcGbPrk5k+SwJeqXPWRb1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828892; c=relaxed/simple;
	bh=OA3LCuoCUOfCEOxu+e7P1jsqfbXbs0Xq2LJ98jivtQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ie+nHXe/A5N05l1aSqQzdNhmDFMg7hfWR/O/mx3jl5g0FIJUvrcYv41miELlRairwd1ejNH0mlq4naCLYKDzDp+otWLB0kAxbo42G7FK2D3uAZ0bWk95Xf73+xjyxBn4MH1tQQzBcrZeUKYL9abnQSIsVUdWjdXUArF6sI/Y18M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U1Y7tRrZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U1Y7tRrZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHg5Pg3688687;
	Thu, 23 Jul 2026 17:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DSFA86ygYl21dKo+h
	BzqhpTt1TC6eOhZaQFbxA9b3sc=; b=U1Y7tRrZ0ZooejFFbVYsN48Ja1u5JGupC
	deZrk055gZrO9LkYEXc07D8UuSst23LLqhxL4AF0VUJJRFYwiJKCNS+QXSg1rCYC
	op+OjaeNX7TQGEcl/NI0aer1bMWx30ePQHiguZcYCQkysNeLC5w6Hh15tWMu8dfY
	m81IwZOkhIBn0k+88kKDcqHytTC4lq4ju1Y5kFD4dUSnvZxeTaT1zpHRWl12fUDm
	vlYnooWfkdzm/+bSCVMEZZe/70YftVGu1UhNzJvUFXY2jUivVtNMYlPWzJlu20zs
	2gHMMFs3CY86cSb/5JtzOCCyfFSBaThEreXOwx2yLEidebazOomJw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahg97g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:48:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NHZ29t009744;
	Thu, 23 Jul 2026 17:48:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gn5as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:48:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NHm52P53608794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:48:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E658B2009C;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB30220098;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 9EEBB1627E3; Thu, 23 Jul 2026 19:47:54 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v3 1/8] s390/vfio_ccw: free all memory if cp_init() fails
Date: Thu, 23 Jul 2026 19:47:44 +0200
Message-ID: <20260723174751.1180334-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723174751.1180334-1-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YIhDyrSaCjA_wm_jMurZgnUP5rqt0NU2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX15tHHQhS0k3M
 Wh7KsUTGR0F8jP1HDI6o/a/Q3pXtIE61+gxkismqcBOJNaS5sziGixQMShGGOd5JykMi3E61Ww8
 cCitZU7NO25xJIqTgTeJwJLilMaqo5z9+JDwftCnT1EBXUBQ2LB8xUY+YO9RBnhUMg6jBjmfW4b
 G4RHzYS6/zKCFOzLpOLhKXYaY3LWPwK9goONFKcn6pkQtC6Raxgn7PysYeATDdtMahUqkc28zIE
 70dYKWXj9Esubhh8JwBirQjygHIWXJzpkWNDS6/nFMoJ4AMBHZc96eFji5twTDn8xs+cxwW9Rq1
 pPb2WahjhfMt2c1KF6r2nxiQhyLinihtrBShj1ea/+Mq/xKfDq4eRDyLBq4evGs2mrJow60GLf0
 Z5Xng0n9Od5Km+reggJLrX30z0rWKErbK1VEuwHc5Ewh+wdBiLPFCYI4RzAWUClVAfR4Cy8N8uR
 GgrGhKVNC03q9/JiMbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX+0bCm5rlsCUF
 bbw//XDK3xyslz+uU9yHYYVLw8Hze6YrJawRNzHdPoRvct7OEnWBBY7x1K4rs9ImRmRQb6lH/Dd
 mhUgEOiIHYdJJAIAT1x8hUGXqONSANc=
X-Proofpoint-GUID: YIhDyrSaCjA_wm_jMurZgnUP5rqt0NU2
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a6253d9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WEmllObKAWPfCt-5-jUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230173

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

