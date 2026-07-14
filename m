Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1842BE95;
	Tue, 14 Jul 2026 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071339; cv=none; b=H3WiHr0IypJAWCxkllnFCreMDTptNp27EJZX6oKDFsPyXZAAFYq5gobMv1lTdxd/nLCL6uAYpjxkMiUAWSfRzaCRleuCTeSKsjxlkrDEQKEXPQexCWQHV1g/pdZ0LLf3Cr/zcgFCYhgQJ3Spp7Xq0/7QQLysDJk/AVWhKgKXgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071339; c=relaxed/simple;
	bh=PVFcPV7a8IiGyZusUfGwMSC8/Qgs0elyNRsO6J94NS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8lKavol8COV913wduVfNnqY+u0HWybv4ZZ7BexWuzNgndarCllQWDtSv21NZCnTPUT4Dt2ajXqc90TJmqestpjhjsYmUm4nJdKTWTjIhPWJlCAokapl2jIhubRgK1TOpBqPJ44IjZbE4u2DaUrQlXw0vkNKZ4DrG4lOihXG1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c3xqPRQH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c3xqPRQH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EJBjW82198619;
	Tue, 14 Jul 2026 23:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RvX3wjFVBiIFnX0eT
	yYT1jCPxHd6yorYubpelkCZmQ0=; b=c3xqPRQHV0QYu3pBeQUky66nlea7aqKFq
	vthgkXh6TcrAgp75HiQdbPZLgBYasLeDxDkpbOSkHJYS7ai+GO+E0pjZm2jIktW4
	2dFHKExx5dIGVLmlecFEkcilic2soSmUCzLYqFFuYnx8JxiT3j2UunIKVwXhgRQc
	MgT6fofb6JB4uYvnnVWhuu5/CkI2YfUcHPLR2K+mgISuTPMeZCLLt5AmRjeHwNYt
	mm4Dq0FxY54oLznvweMujlYWgGqGhTcIwutiu81egNhz6SY0je8u0tba5EybFlHx
	dqHPTWgdadcw6wxOglIlk4jsH6w18ExfmPGEEBZyQwW/qA/DTpM/Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxgrq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ENJfYF012337;
	Tue, 14 Jul 2026 23:22:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgcyjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ENMCGq30998854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 23:22:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64E5C2004B;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44BF820040;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 25F2016267D; Wed, 15 Jul 2026 01:22:12 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v1 2/6] s390/vfio_ccw: limit the number of channel program segments
Date: Wed, 15 Jul 2026 01:22:04 +0200
Message-ID: <20260714232208.1683788-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714232208.1683788-1-farman@linux.ibm.com>
References: <20260714232208.1683788-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eHsTBQ8hmANsyNGgMB2SdWyhJnwqAZ_9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfXw5cyF8xOiRS2
 avp3X5RC2VfsbN4LgZueytcIXjhvUVHxkx2pbyAkWxFb6vo8Xt7lqhzrND4IW+UKB5BelMHbwVa
 8CmvchElmk0Qq/D+pBRHrcc7WmhIhkU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfX4KvJinxMHbu7
 P1dbyhQt/oGv7rUROwhI1u+8ItYbbd5OxLXqVwrGvqS0Qd360cFm/ViYYvBn70JJ1vnvlONQvBU
 eMfgkJ2KUx+j8Q3wOje68oIW3sPRcf4OGL8b+5kR1m7ZkLQ4nJtfaQCetMhWi4K75LKO3Zg7Ngu
 2v8qSxoUBr15ayhE3uVgU1kHyfIFEvTZySWMXN9oGHklo7/KaFiucfVlZkdbrzaEkBkSyMaiYBl
 DHO5vts4ryYVCm9EMdPrL5vv+5zRtzo6dF95viWzwFEkIY/4VJ5OhqrO9+gYeRcyYOY9WMoJSAW
 F0cULeS8WG/Ax7J0hJc09PnvRi5gOzdbU/aoUIeWHDhdPQ4PphhhFPBDSavHUavCvGXRDNmY4Oi
 PkBfnJJSCIRe5OrCkYNnbwwNmGu5/T/dYHf8rIyn5FWoiddepBaLsJSE9I44bZi+OShG3xaGOiG
 26XrVTZxCOP7eM8lQEA==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a56c4a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=OzPGupj-Brq4hERWPoIA:9
X-Proofpoint-ORIG-GUID: eHsTBQ8hmANsyNGgMB2SdWyhJnwqAZ_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140240

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
 drivers/s390/cio/vfio_ccw_cp.c | 5 +++++
 drivers/s390/cio/vfio_ccw_cp.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 80c3d87f5482..76632b18fc37 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -319,6 +319,9 @@ static struct ccwchain *ccwchain_alloc(struct channel=
_program *cp, int len)
 {
 	struct ccwchain *chain;
=20
+	if (cp->ccwchain_count >=3D CCWCHAIN_COUNT_MAX)
+		return NULL;
+
 	chain =3D kzalloc_obj(*chain);
 	if (!chain)
 		return NULL;
@@ -332,6 +335,7 @@ static struct ccwchain *ccwchain_alloc(struct channel=
_program *cp, int len)
 		goto out_err;
=20
 	list_add_tail(&chain->next, &cp->ccwchain_list);
+	cp->ccwchain_count++;
=20
 	return chain;
=20
@@ -731,6 +735,7 @@ int cp_init(struct channel_program *cp, union orb *or=
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

