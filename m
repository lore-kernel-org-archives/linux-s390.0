Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684543;
	b=K7IOnWfraZeH1x+yMuZmZKdbM7LYE/HKizjTp/Fw5y+e5bn1dv7OS69dpE3ZzeRnKDfc
	 M+eBd4VoH+vffH9GByZ6wx8ciyP+uIvu3x9HFB5JJ3VbHue3ebgryTuq/NrRQpm2361wL
	 /kVeQiWeyyZX+KLHsFlKA9m+RbynN+uo/idywHSq7dBlHKSazotMYvjHspK02m0cVRgjB
	 DwKvcnUR1qxzx5FJJnm4cu05D4jgtKZKee4TrSxC1is3K1WqIF2D4qeLJ/c/6zy5GlEQS
	 LA+doPoOdUTG4hMHzFUejzX6cMGMwoUngfajXVdNhlrfyLO6mViVEJZzNFPzs3JXu1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684543;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bID2BpoIY09HLgjD2eQALeygUFmNaSi2I6bMp351Yxs=;
	b=Q89kxsqLYQ0L/3fCaUDPwHZdEQLhdwDDSfbEad0npUEOtnWO0mJIjWEE7I3rmoM8BiVj
	 12NnuO3WFaSNhPkEbwH/twFOeXCP8hze9u/ui/QKWTqm/DxPXvtyD3kA+qk1BrGX/qNen
	 qyr0mPmEHluOAssABYe860gcT6CmqXZn4d/5LiaBDi8q8YkuwVwrFytUJO/4pB1O0ZrIm
	 zGfevzOInM8dnTRyJljcixPFGaGav+Q4l2ctC66FVbxMEDrplvCgW5eHl45NgUHDoa+2D
	 v4zB7xBAgBger9nC1fQQnlz6vUpFgWP0Hz1AHj66xA+6rG7yLkLrqXNQdyQNACy7qNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jidyvvnk;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D860A2604;
	Thu, 22 Oct 2026 15:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A4D860A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jidyvvnk
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEEUUL140111;
	Thu, 22 Oct 2026 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bID2BpoIY09HLgjD2
	eQALeygUFmNaSi2I6bMp351Yxs=; b=Jidyvvnkpq/gZ6U05FGNl7LBonWXb4+F7
	/dlS3VMHqr41xSi/rTiSmVbrKUfT/6A/lqIgsaYcUXJiEIy1aGcm1dc2w9Z4Wx/H
	sFbuP6QpUYS31e9Vv0XMJVlNNiG3ZoQjutwYd0KoRaWkTSk0GxhrHGRKllHGr7zH
	hb1ByYvxrYLhzJEycVZxb4RJnGYBSivjYhFxzuSlq266lomXYaHvTJ4VlF0gI5Co
	U98xwP/nLAfBnGfQKWLhzhs99Kz45UEUkDaGO2hoDXin7m6es6Q60jZ6R2rFkUPk
	TT3SCrUWlAAR77koR37wHHowQgaJjMobpa8znFfb1yhpxdpMVK8kg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a7jfs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEJsix619357;
	Thu, 22 Oct 2026 15:55:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x0ubt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFtXvc50004386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:55:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FC2E2004B;
	Thu, 22 Oct 2026 15:55:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA2B020043;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 10/10] KVM: s390: Enable 1M pages by default
Date: Thu, 22 Oct 2026 17:55:31 +0200
Message-ID: <20261022155531.204593-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022155531.204593-1-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX9eCv0hPvXYwo
 +MlrTsEnw7+4ziJZw86r9sPDdrqZ7Dd7ksHKjvSUF3lTExHQXqPcpAZCwEl1rRryUrke0AnD+vj
 OItJH629eNm5InJKNMiBZ7mw50EKYDx8eA1sYRt4CrIwLrfPi+YL2ir2l+GTULr+KPlfVyvgb9D
 UuREBdFNsTg7a13pxBJr+gGeaXmeVkY6FVSsO4P073sdwdRrZc/GRpJogdvSbCJiGzThccpAESR
 6a/HebcYoUCF20hzM1ICjnpXJM0DcEAfZqRUwP2lqe5xwZnBb4kfZWMq283D2qSK5mFqXe4B3ZT
 ktDi5Na5bQIj1HXvhb4aL6Fx5obCelZICSKy1+9L4Ijk228Iu7kpUO+5VtySLs64RKJySYTvRmP
 EZQ/D5b9ZfonC6PCHgez0BM93ghU6MJZm6rqbbst86RN3u/69Ps4d8e/Yb66C1Ef4CC34hS+F5S
 gJdi3dAh7VVGfB74YbA==
X-Proofpoint-ORIG-GUID: m75Agf35zt2zooz5VOTTmFnAGuOgLi5l
X-Proofpoint-GUID: m75Agf35zt2zooz5VOTTmFnAGuOgLi5l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX8UREXjsAd6yf
 ebEuciHgBwsVQWF+hvniVvJSYBPdt872SuYbwohjD9sB6k//uc0OIJLTRoF74/WIYFeV6I3bjG9
 /KToO33zxtseezZ1YQpH2jcBNCGuvIY=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ada31fb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=GTA4chkwOabIMoMS33IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220062

When userspace uses hugepages (e.g. hugetlbfs or THP), use hugepages
for the guest mapping by default. Until now the hpage parameter had to
be set manually when loading kvm.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 280310870dac..71d79b4437ac 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -212,7 +212,7 @@ module_param(nested, int, S_IRUGO);
 MODULE_PARM_DESC(nested, "Nested virtualization support");
 
 /* allow 1m huge page guest backing */
-static int hpage;
+static int hpage = 1;
 module_param(hpage, int, 0444);
 MODULE_PARM_DESC(hpage, "1m huge page backing support");
 
-- 
2.56.0

