Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4EC2D948D;
	Tue, 10 Mar 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152620; cv=none; b=YIF/kw35WruaTpxZ34S2Z+fSX1ehjp52ccqEpIni+gIu52GlLLiQBU0Pd5lZCiouAXq0UIIJU8DElQnR138WuZoYf3oo6vdKqbqm07warfVRlxp2+heHkSlTFOGdgwLsISMcqueCurf3lbkoye8Yq4n3RVwmegze+xWhfkxaebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152620; c=relaxed/simple;
	bh=+2cyDmiJoE4b3SnGbX3g9Z1UsELlCLCz28jhFFO9UQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l7lf8sfxGQRJ38njGaKlAN67/8mjX4a3djdjNeYqNZDrQMFJNpa9roG+JfWGVgplnjxHme82qDctoWyxQawE/KagJLuc/nstsAIXMyKBqwAQfzagpGqyp8VxITMmPG542i7sx8RhVk0phA4oQpAfTVDvQjF7qHfrX2iPpHOybf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cabaFNBR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cabaFNBR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AAddeF1808765;
	Tue, 10 Mar 2026 14:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bAgfYOPQU0UpKj7nvHKlONj04JJTitpB1AvJO2Jn2
	+4=; b=cabaFNBRNiZZ/Xn3qpNfq6H+XWKR2in/PjLAYzTbIGdO9rNcrE88ELC1m
	8l9GwjDG3o2JnU82ZTw5q/D62Y+XtaHEdNoPK2LcYB5DiBpHy60b/+vYGBMpQ3Kx
	0UILlW7e9zcX6k/usiRhfRachp+dl5MDjR2njTc4VcLKyBQ42q+7QQuiLf8Pi0fj
	XW/fl+JWm2d1jfi6ZwXKrAfQJ68DwnSBwhejJeEQ66wlOY/vGoWc9TJWKwoeM5bW
	hs2uEW+1PK2iLGhu4XBmh26I+mrFZSMS+fwlL83xxdfBcSvWkQ9xGLXN09QvAApp
	BiBI7Ia0ExqfrhE1tRfbeeZqmvvsw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywb8db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 14:23:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AB1xlL029356;
	Tue, 10 Mar 2026 14:23:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6up2nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 14:23:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62AENVvG30015974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 14:23:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 108B120043;
	Tue, 10 Mar 2026 14:23:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E972420040;
	Tue, 10 Mar 2026 14:23:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 10 Mar 2026 14:23:30 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id CE7AEE09B2; Tue, 10 Mar 2026 15:23:30 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] s390/dasd: copy pair swap fixes
Date: Tue, 10 Mar 2026 15:23:28 +0100
Message-ID: <20260310142330.4080106-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyMiBTYWx0ZWRfXygqsg1lIFCDl
 bj+FI+AGnMo9v34vMltBoBjlIsUMVRjCppIAS3irSHuBPXREVzEYQDGkkbm4wsuR7752vMa0emn
 /aV2n33VuEH7DPgzh+yt3bVC1QJI9t/5bnARlrpKb03CoeIovlPFXIH1JyeCVzkm3cCNXPixntz
 MTCzMUfuHAvUoqXCA5KCa/rXjpiqwBLYKFx5BbP3k1ZwLFgWkWR0H1OKuJ+VqrsMAtKtK+yNP7O
 tm3sN4uOHB3Wo0oxZo0IME5vHiVZG1Hrr7npxsRGs8tj3aJvRFSz38oZn9dPL4KEG5IYHfCESLP
 pQi3BagGIZr8weF0o0T5kIMXDMNlj7Hl2Bha8isI462xK8pSSCkBvp/9OmoAFNRQ5jSrfaRHyic
 gWTbhopaNcoarNf6hlkXRwfyAkX51SH8tjKKE8SHjchhNCs+0NU+uoLt8s7Ym+lEE/Z4SAMoC7O
 hit1bFUMQJAdSnXRndA==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b0296a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=dfpi3sGcLMQskvs3B5IA:9
X-Proofpoint-GUID: LBlbZ-PAdeStym-PvVZVudsESAxhzPVv
X-Proofpoint-ORIG-GUID: LBlbZ-PAdeStym-PvVZVudsESAxhzPVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100122

Hi Jens,

Please apply the following two patches for the upcoming 7.0-rc.

Both patches are straightforward and address a rarely used code path.
While users are unlikely to encounter these issues in typical
deployments, the second patch is important as it addresses a potential
data corruption issue after a disk swap.

Best regards,
Stefan

Stefan Haberland (2):
  s390/dasd: Move quiesce state with pprc swap
  s390/dasd: Copy detected format information to secondary device

 drivers/s390/block/dasd_eckd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--=20
2.51.0

