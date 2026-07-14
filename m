Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F1466B6A;
	Tue, 14 Jul 2026 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034256; cv=none; b=s+8mY50QGS/AWWR9qCKjrzCVdPVbCOIceTAsdIJlRWUQfGcW9HU60pwYLEPNTLoaPxQM7B9OsOM7Nj4ROgl9pKRpb1gjkdLP1KjoooRQTMWD985h2CeXqgDr4KQ8ryP3qc0YkSImOlfXHk4sRmPQ555mCSzHXSrpkM6ga/IaV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034256; c=relaxed/simple;
	bh=xkX7cJXJW6EWkCkvq9rtJBEiFguBR+hdf2B40qpbo50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deLrLRB0uXmDJXsGaDexf3k/pG3SSP6QoOX6j3EBN6v67vdBY5VTVXRUvQ8BvCjj1PKv3N/dtrw/ZtbwM0AN3arOvBaDSXTybr2zm61VCQzRYDH7vbI3htqF71tJUxLvKRS+uswTC5Y6W997yzNcMQsnWGz0z08XkK6XR/kjDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sarylVtU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sarylVtU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBfaf33511685;
	Tue, 14 Jul 2026 13:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xkX7cJXJW6EWkCkvq
	9rtJBEiFguBR+hdf2B40qpbo50=; b=sarylVtUTqZhM5n5iy1FIxKngQxHqMs1t
	9RSVtofWRqMMquoUyYuieHP/uvOyHesJAfLEh8O6KHwpXaxMJZbXtI6hGtCv+uJW
	6uwWXcMHwPYp36n+CI1BrE/3M/kEuQ9R3CTXMTQM1yYe9lFC+dYxu8LpwQBVE6f2
	5D8BPOCoVaXSHOLCBqlzOO95o99ZWcvmCYE4kNvFPUAVICxI5fQ0KzwM77epO6YL
	kGRzEpPmOZ33HqJB4lS4JYp+WHyMR9bYKBratAGD/tqkNwEi/9PD3zby3GYoC+kf
	g6MLf4fYeDZXpxHsvWaSfQF98M8M9f8FW6HqftaZaA1A52lR7PJOQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv336s9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 13:04:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ECndBv020092;
	Tue, 14 Jul 2026 13:04:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05q32w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 13:04:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ED44D449545568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 13:04:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74F0A20040;
	Tue, 14 Jul 2026 13:04:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FA8720049;
	Tue, 14 Jul 2026 13:04:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 13:04:04 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 38B931625B6; Tue, 14 Jul 2026 15:04:04 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 1/2] s390/ptff: Export ptff_function_mask[]
Date: Tue, 14 Jul 2026 15:03:41 +0200
Message-ID: <20260714130342.1971700-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714130342.1971700-1-svens@linux.ibm.com>
References: <20260714130342.1971700-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfX5O6BPHaI1AWG
 3SstSytBIDQfu907WlkTEA9bMeqFUATUGQSR3/ointPQBJbAtcqaAaAG1yM1JAnypOVVZ4+42H1
 E7VOra4cPEyXXyp2tUZJ1zcxEgp6L9U=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5633c9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DoSMonE1AzDNFuiaGKgA:9
X-Proofpoint-GUID: WNp983H-4c8RVIy_IV0y9q_cDuTXLOBQ
X-Proofpoint-ORIG-GUID: CyCb4ap9UJxZizpTu9Qz9-6TGMClmOgk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfX59ntWHgZlsRb
 PB5e0Tiw+j/IlTZ5A1aHaFUA9A5x8nTvRUAnRON7+/c6C/YSJCayn1vpOPF9XIpZlp7KPWwB21U
 zqFa4UThaX9pVJf4q1jMEFLhbdFIqpSp9pz7z4d7XZVpRr5fqUlsbYEOGKWA7KbJnXc2DJnCmx1
 bJIQkizzNoJUD+9aJt0HEu3zn8te8Sm/F0SsEDVhkeVMR1kldsi6GBv9/0sKq4290rBUsXH673S
 83OAX+uQMtvNphnJ1k+/Oql+HYjSnkIi3tCllg+TkbSY5KpXsTvmxjzjyFkSKRjy6HF7MJvQ/HZ
 /FmE7rmeuP3Dfx4DzIlnjXFQwVvO/5pK6nQFmUy6d+n1i4MPSpWi66Uuy2wc/InUI3IG1rL/3Qb
 NDiSjUjyv2hi2J4NnrykxUYverNVbjWuj+Pyqn18CdvrV2HROaczZDWE/pVGpqn8rboyfpM3Akl
 cf5apwpd609z0zV34pQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140132

Export the ptff_function_mask to make ptff_query() usable in modules.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/kernel/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index bd0df61d1907..2b989bebd220 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -65,6 +65,7 @@ ATOMIC_NOTIFIER_HEAD(s390_epoch_delta_notifier);
 EXPORT_SYMBOL(s390_epoch_delta_notifier);
=20
 unsigned char ptff_function_mask[16];
+EXPORT_SYMBOL(ptff_function_mask);
=20
 static unsigned long lpar_offset;
 static unsigned long initial_leap_seconds;
--=20
2.55.0

