Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B193BED5F;
	Mon, 20 Jul 2026 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578781; cv=none; b=OV11hYsg1kt6q/p7dvB7V837ZtV4W/epi0x/eemcBjiiNBy5/vGU+KBXH3I357lv1HE8fozwdsRPISf/u6/8mY9w44tnzXgh2UpYYN3vaEESmYRY/GOhI1duTgMtDiKR7uxWpWAh6FZFi3xaMdZxuRwkf5W9HARQZhoBl44RJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578781; c=relaxed/simple;
	bh=N7evDN3Q7iGhJtEVsHCOuOIwh62OQK5s/FLwcNHpNRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMo2h2dSJBrhTDg067u9jCoPW7dsphSZYGkDvJ/Beho/jqSCv2T8pinv7z/+5x0kURtDlaf7SAuM+Hawrga1vrnJB1dqg2T92Ovqz9yZhJ31w9FG2z4yiz0i9JivpPCC7wfK2gbPIaqRY9+9ZQNLmWz3IVyE3RAshRriV/AXbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VL4YYaJ+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VL4YYaJ+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJgEe13133784;
	Mon, 20 Jul 2026 20:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8xnrAsqIGJOgRS+ol
	KL3N8Jcu+SF2CxJ+EnZg9NoK3s=; b=VL4YYaJ+RijHwfoacaHmXWtDIdirC4utz
	FsZ+ShLFyY3lgpUTAoPtGgaEXctjgjU8MRgk8pEpjr64tml6endW3ImWDyKAcvG/
	g1qj63KSL58/fKhVCi0wthxL8Mxow24A8oFK3q9oeIue2t+4XFy8bPWoNL0kO+yC
	xtmRiH2xP/KXAtBr9X2J5IV83c6zWQQiTtypo9LnUdDnhkekwbHJzEJczd6Vpd+h
	P4CZpI1rwLfVs6E1E54w60Lga7kUuJLlAaFI+jjlsZuaRSJ4anbyDfykZIhBnqd1
	NGlIdz136mXmsplhqxyMILZKESy6DyS8529luCej8kYMQJHHnyXQw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790sbk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KKJbeL018698;
	Mon, 20 Jul 2026 20:19:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vyayw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KKJXAp51380702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 20:19:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE5E92004E;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D01D22004B;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id B9A04162783; Mon, 20 Jul 2026 22:19:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/7] s390/vfio_ccw: limit the number of channel program segments
Date: Mon, 20 Jul 2026 22:19:26 +0200
Message-ID: <20260720201931.976660-3-farman@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: QTDNvkh-u0NGqKpaR25-M9jl6wGBc49q
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5e82da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sBi1HX8ECoo2m5KYV-oA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfXxwJt/oj+xYad
 aVIJYvPeEBuqQE+TXNfrZBwQeqld/diN7RnBRcmKAtSsudHwFV5YDSLiquLRJytVe7DyhzG7lWM
 QN0tyR9Vp/U8XbqiOtD/RzXCJMunwlo=
X-Proofpoint-GUID: QTDNvkh-u0NGqKpaR25-M9jl6wGBc49q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX6qj00W+BADPg
 bJeNuLqot2U/F2vtDaIauwsNDSTKQymc5QvIlTy5tCykbiZTff66sDht3Mh4tnFIv1OtigzcsN0
 gyznTtLdUOcJLQTyu3TZBK9n3WkfMhmmZcTdlk5coGZ1IFfhd6ojC57bN3+fbFcJ/7oLX5TiQZH
 BNiWGPn6r1gJe7TmqNnYIj7Ecs8wssVS4JLjwba/itbf1i37O1oNbRMY4b2E4k7t87XBKjXIW65
 qoaz0nJ6a8nR3AUUywGTY8NOhUFAVcToG7gOjxgF4vZvylvQuImsMwMJW93gNapOLghwIdKK6U7
 rLQaGOaMME3pecweZ0AILCxFbHZy22H4fJ1REdaw9miqfkHO5QgpPePdtAr7/43lUUidzXq1HsK
 sy4RCPX8UNXFIurA91JvsArzKjkmLbfb8mrGirKk59wqjcpsLtlZ8bSyCFfDiQQ2Os7frVfA7xM
 S+abXx5AIlhyVsmhGsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200220

The processing of channel programs, and the CCWs within them, is done
recursively. As such, there is an arbitrary (but not architectural)
limit to the number of CCWs that can exist in a single channel program.

The vfio-ccw logic breaks these channel programs into segments whenever
it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
of segments count towards the global limit. Impose an equivalent limit
to the number of segments until such logic can be made non-recursive.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 6 ++++++
 drivers/s390/cio/vfio_ccw_cp.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 086d1b54bdb0..7abdebd8f7c3 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -332,6 +332,7 @@ static struct ccwchain *ccwchain_alloc(struct channel=
_program *cp, int len)
 		goto out_err;
=20
 	list_add_tail(&chain->next, &cp->ccwchain_list);
+	cp->ccwchain_count++;
=20
 	return chain;
=20
@@ -441,6 +442,10 @@ static int ccwchain_handle_ccw(dma32_t cda, struct c=
hannel_program *cp)
 	if (len < 0)
 		return len;
=20
+	/* Limit number of chains in a single channel program */
+	if (cp->ccwchain_count >=3D CCWCHAIN_COUNT_MAX)
+		return ERR_PTR(-EINVAL);
+
 	/* Need alloc a new chain for this one. */
 	chain =3D ccwchain_alloc(cp, len);
 	if (!chain)
@@ -745,6 +750,7 @@ int cp_init(struct channel_program *cp, union orb *or=
b)
 			vdev->dev,
 			"Prefetching channel program even though prefetch not specified in OR=
B");
=20
+	cp->ccwchain_count =3D 0;
 	INIT_LIST_HEAD(&cp->ccwchain_list);
 	memcpy(&cp->orb, orb, sizeof(*orb));
=20
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_c=
p.h
index fc31eb699807..dc91a317ef19 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -23,6 +23,11 @@
  */
 #define CCWCHAIN_LEN_MAX	256
=20
+/*
+ * Maximum number of chains
+ */
+#define CCWCHAIN_COUNT_MAX	16
+
 /**
  * struct channel_program - manage information for channel program
  * @ccwchain_list: list head of ccwchains
@@ -38,6 +43,7 @@ struct channel_program {
 	union orb orb;
 	bool initialized;
 	struct ccw1 *guest_cp;
+	int ccwchain_count;
 };
=20
 int cp_init(struct channel_program *cp, union orb *orb);
--=20
2.53.0

