Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD61E545;
	Thu, 26 Jun 2025 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750915064; cv=none; b=JCTDj9z6JklPO4tNE/cBs9BlX1ubwXBLvGJGzBJN50jwxb6nhSiGHCFKYOYkFG1XCj3Y5j4SSDgHcmotK5bAyxhDikHWkrQIXZUYqrzpxRdGqhzvL86qELNzoVDG4eyz52e7lc1sChpSpldVaMeHC/7bdoZG9EAASFHgIk0NMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750915064; c=relaxed/simple;
	bh=7pDiatASWg3dksMGPUf9Q1jgVSSLuS8UeB4OcJQOaNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LaFoNUuAuWDjfTthVmKign8qG6ePK5SmpgDzCSsZUWyxmxKwEBRFfjXoPLq/HFqb7J7ACreZb950otieO/pcVjiOOuCqYSzYAbwMpoDhQ1rbeGJVv2Mq/0xdqHWVgDVkc680UdykjRhcdQZvntvAELOVsIRoonqesm1hXXHFwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hXhgJHil; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hXhgJHil"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4An3k019590;
	Thu, 26 Jun 2025 05:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VRE/3PBW3+oTGB+4b4bhY8mH41mjdoc/AXbX/9qR5
	n0=; b=hXhgJHilC8j7Q66Djk1uIdbsAO1Uj3dmdyMH80+WeY2tVuxyzm+DnEwPW
	J7f9yxa/WOqQTezBboPY+3uW3lKMUPiOeY17uYdqj87AQ+/f5qbP6NbE8CvqCqzh
	us69zrhp59j8w9tLXHMxQHxc974QdUd5CWsEdR6uasgXN7c/hhM/r5njXoWinr1g
	4KJbOeZTcny5MYq+PYjfLjpP2Iv/zaXtuhfP7LY85YseWlL47flwiPN28A5uXp1A
	QiVjNVPIzJ0jgHcEA4Fhf7gRG0IK37URhfVlF40dfIreC4brfeMRwPW8RF/vm952
	ItV6VxHpgo1E/9mT572Eh7wNIB5YA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3btyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 05:17:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55Q5HRkZ017031;
	Thu, 26 Jun 2025 05:17:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3btyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 05:17:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4wohH002499;
	Thu, 26 Jun 2025 05:17:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jmd4r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 05:17:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55Q5HMx856426902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 05:17:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 729A02004B;
	Thu, 26 Jun 2025 05:17:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B8B520043;
	Thu, 26 Jun 2025 05:17:21 +0000 (GMT)
Received: from LAPTOP-8S6R7U4L.ibm.com (unknown [9.111.56.205])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 05:17:21 +0000 (GMT)
From: Jan Karcher <jaka@linux.ibm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>
Subject: [PATCH net v2] MAINTAINERS: update smc section
Date: Thu, 26 Jun 2025 07:16:53 +0200
Message-ID: <20250626051653.4259-1-jaka@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=685cd7e7 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=9JzLZ8vFzxP9H69fwZ8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA0MCBTYWx0ZWRfX3h+0JGGmTTqL ybIwV9vnUkpLKKoaJKmb/je2Jtsz93MSuPQ27xGSCBfnWSVCbo3qZtUs1ncKDFWl0yM9su4H6Te qbTMV0kJ4gEWft7Wi3GO0iBj2XZMZj7FpQOTzd6tBYqtD28dEIgk1NS4ox4JpxL4BRKyK+YydEa
 EY8UVSmYJ4oEV8H2QBOT/AJ8wS+ZREZbuR+c/DH6dLrzacnEbd6aWe3MpCoMOWolTU2XMKIcW0j GYTKdEkmTdQVzuRAoydH5zzpfyMISOvgiscjqRT1pfK3uRNJy58jmEyiqwFk+/paboUwpfLv02K yRu81VJByk/YE2hikSkjy33Kqbw3D4EZrfQxhUmqDAnqpIPyeQrH3aFpIV/colAvarZAn8WVgOo
 A8hcnYTfMwnZfSI8iaaYsKHAeTkeQhN1vXehryGpLVCfPP51e0L+3YRUk4ViLtWEKVSFb9D/
X-Proofpoint-GUID: MWReB_C4pjvLduocTBNfzyqN9x032dQ6
X-Proofpoint-ORIG-GUID: 2dILJEqJbjZDEM8XfV_jEJfIlvWbNfqF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_02,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=824 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260040

Due to changes of my responsibilities within IBM i
can no longer act as maintainer for smc.

As a result of the co-operation with Alibaba over
the last years we decided to, once more, give them
more responsibility for smc by appointing
D. Wythe <alibuda@linux.alibaba.com> and
Dust Li <dust.li@linux.alibaba.com>
as maintainers as well.

Within IBM Sidraya Jayagond <sidraya@linux.ibm.com>
and Mahanta Jambigi <mjambigi@linux.ibm.com>
are going to take over the maintainership for smc.

v1 -> v2:
* Added Mahanta as reviewer for the time being due
to missing contributions.

Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3f7fbd0d67a..cfe9d000fbff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22550,9 +22550,11 @@ S:	Maintained
 F:	drivers/misc/sgi-xp/
 
 SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
+M:	D. Wythe <alibuda@linux.alibaba.com>
+M:	Dust Li <dust.li@linux.alibaba.com>
+M:	Sidraya Jayagond <sidraya@linux.ibm.com>
 M:	Wenjia Zhang <wenjia@linux.ibm.com>
-M:	Jan Karcher <jaka@linux.ibm.com>
-R:	D. Wythe <alibuda@linux.alibaba.com>
+R:	Mahanta Jambigi <mjambigi@linux.ibm.com>
 R:	Tony Lu <tonylu@linux.alibaba.com>
 R:	Wen Gu <guwen@linux.alibaba.com>
 L:	linux-rdma@vger.kernel.org
-- 
2.43.2

