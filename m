Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B072248A5;
	Fri, 18 Jul 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848247; cv=none; b=E8pJbu4smIqWVfXolH5Uw2xPC2lucDzPLvZzkEwpY1NHkMRQIjuAqVqkgdqLveLnaxMVSL/9hyfEdyjQhDEXkoQMcKVnIS6fUznE9yNW11T9Gc5TUqslbK7+FW02+QUPKZaAISMgUFZxn0PEXivF11Xi4nH21XumAjVxBq2M0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848247; c=relaxed/simple;
	bh=Ae55siu6Nbb060Uh8M1RJ2paIZYdpDQRPwMwhQTcnzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejcc6Dm7YJEbGQjbaP+/vkF46iZ6RYcD8VzgY2fmKf2zcl1L97UHZIGGPFIzqApAqyWsvRNlIxZ5XJf21kXqvjmK1JrVBytPsVlfK35cGWkQvNCMRAibev1h1KBj9eVZVwWxZYunNaaoD6AKZJmsnEu1yXS5S6pDuUtSspJN3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X2HuUyV4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X2HuUyV4"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8fFtb024843;
	Fri, 18 Jul 2025 14:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4F6/L9k8uxZN+O7i1/3Bn+hTTBrUY5cRdtZQgf4Nu
	Zs=; b=X2HuUyV4vkCc5l+1T8FQz9Vd0Yu3JGt49l45NPegP5wyZaLHdThRQ16YW
	6bq+2fvgm8UYbvHghOFSDVvhLDnioYukMm2fW61U3sdFT94MhJc9FnWtxtYQ5gjo
	3NU+wMiqsnMYVhvEw6/IzvVbgru+Oz2jIyoF19cn7d03dPLRHkuIq/Fm6c8FjmPV
	4Py4G7TrtwZuMJ8SxqIvfPfM4zeSs2dTVR89OnL52uIgFVvntLvGLjk3wZ2xt3Dv
	YxY7+ikqkmT6M69epSpy/Av4BvWpZzukk5z6BwXoBGAFXs4eRwlxkkUMWf+5qb4r
	tpBAfQN11GWnm+L0ur/a+P+i7d5+g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47y6qqch5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 14:17:17 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56IE8wUl000794;
	Fri, 18 Jul 2025 14:17:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47y6qqch5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 14:17:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56IAsu4u008951;
	Fri, 18 Jul 2025 14:17:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hn1dus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 14:17:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56IEHBLv50528762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 14:17:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2DA220043;
	Fri, 18 Jul 2025 14:17:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 905F720040;
	Fri, 18 Jul 2025 14:17:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Jul 2025 14:17:11 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 585EFE1180; Fri, 18 Jul 2025 16:17:11 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Aswin Karuvally <aswin@linux.ibm.com>
Subject: [PATCH net-next] s390/qeth: Make hw_trap sysfs attribute idempotent
Date: Fri, 18 Jul 2025 16:17:11 +0200
Message-ID: <20250718141711.1141049-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BWPUWdMHiN5INFieRW-Axp7KCQVtWCsn
X-Authority-Analysis: v=2.4 cv=cczSrmDM c=1 sm=1 tr=0 ts=687a576d cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=SUaj4fTi5kSNPZrQ2xYA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEwOSBTYWx0ZWRfX6/xz0QUVDP4M xKDl08AWfSCwgi68Hha59zfgMF5NaKfeOn6ZXvFedQ+ngJ/uA5tTFuyXoRdimPxMz42yFjKtULn XIg0KUCMeS9btvZ7YxLpDKUvZVT8tTEuLu9iTXSt4ZaMG13eBQMfz9N54tXPAj76uYngHCjYxVA
 ddq4flm01OQof+9zAtsz+yIh9hqaZvuhSByIsY3rKwPqj1VYYjx5qH9ojBITQIE7DTAadU0WvR5 NjfQqMTcOxH9/iacALMOljK+zxB8owiiBCmJ7ei4JGnOFPQuj+Z4eOb01e7yy9DTk28fQO9Ui0U XF05Yg4efpolHcWLXtFi2Z6tytrxKklYE7Dyoj5kLDBE+/BiflXX+0b2b7DnDPdiCdUvgF6nGZc
 SSUNRe2GDxwpjBFWOJO+83BDDNohJLWRJa71wl0OwaNy4KpO6/Q0Lwz0AZElU6rbglEU0VuM
X-Proofpoint-ORIG-GUID: XtD1nexb1jhZHOa0sUmewo0cOK0YJOQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=892 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180109

From: Aswin Karuvally <aswin@linux.ibm.com>

Update qeth driver to allow writing an existing value to the "hw_trap"
sysfs attribute. Attempting such a write earlier resulted in -EINVAL.
In other words, make the sysfs attribute idempotent.

After:
    $ cat hw_trap
    disarm
    $ echo disarm > hw_trap
    $

Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_core_sys.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index eea93f8f106f..c0e4883be6d0 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -518,28 +518,32 @@ static ssize_t qeth_hw_trap_store(struct device *dev,
 	if (qeth_card_hw_is_reachable(card))
 		state = 1;
 
-	if (sysfs_streq(buf, "arm") && !card->info.hwtrap) {
-		if (state) {
+	if (sysfs_streq(buf, "arm")) {
+		if (state && !card->info.hwtrap) {
 			if (qeth_is_diagass_supported(card,
 			    QETH_DIAGS_CMD_TRAP)) {
 				rc = qeth_hw_trap(card, QETH_DIAGS_TRAP_ARM);
 				if (!rc)
 					card->info.hwtrap = 1;
-			} else
+			} else {
 				rc = -EINVAL;
-		} else
+			}
+		} else {
 			card->info.hwtrap = 1;
-	} else if (sysfs_streq(buf, "disarm") && card->info.hwtrap) {
-		if (state) {
+		}
+	} else if (sysfs_streq(buf, "disarm")) {
+		if (state && card->info.hwtrap) {
 			rc = qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
 			if (!rc)
 				card->info.hwtrap = 0;
-		} else
+		} else {
 			card->info.hwtrap = 0;
-	} else if (sysfs_streq(buf, "trap") && state && card->info.hwtrap)
+		}
+	} else if (sysfs_streq(buf, "trap") && state && card->info.hwtrap) {
 		rc = qeth_hw_trap(card, QETH_DIAGS_TRAP_CAPTURE);
-	else
+	} else {
 		rc = -EINVAL;
+	}
 
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
-- 
2.48.1

