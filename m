Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D526E71F;
	Wed, 22 Apr 2026 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847939; cv=none; b=bBRuu1cuLzhk91xxRJTWozWQDLR37EFH+GIr7Lh0OuGUHM7VL8zGBZA32oWBZ+4XZ0G75ny2SQzFq90QWJH4yDcVuWBNBkCinKAh7/zgb0iWWkJyexRr5tfM+UcxvWjdleVNdX85pdl/wqhZzYt2MEL2DRQJdTJW6Gw1FLqVybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847939; c=relaxed/simple;
	bh=Lqua1pS4ZmK47MXlRuBFRaKP4CJxJ0+JDtHlCR2N8/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxaKO4ieakQAOi98XjTusVB1qpVHr69DZ+vfbdLQ/UHv5QurZJfd0Ydcrn/n/PnUzqeIhMswD9z5VU6NyM2skFjDi/Yd0dcaxNP7N3wz9sHXfDsQxWDi8rJ6FT8+ieKXJzlmC62/fXmUkKPV96T6Gyj9UrRrzB2HTCqQycGy+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ce+cA812; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ce+cA812"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LImIrF590746;
	Wed, 22 Apr 2026 08:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CWmXBMP4bq7eKGOssZSZjtmv3UCSbFFGPeE4LBuDj
	sI=; b=Ce+cA812hYIzTEaq8AJGmhBTl15lo1k/2rYY3v4ODPBMqVZy7c6PIpBr/
	EC+GhkqP2noCAln4kFeYCg0hzspY8uHUOJF1oDbBd+1s4i7TUISqS52nIPX8yXAv
	9UCGWeRISQ4QFBBQGGVM7il5AeYJzBFyUWwbIQwZW5b8BxVg9fOWi5nQcx0SxpMl
	Z7V1zVsjf+DOmxqV1WjzHE7Z+Tb94WK2swNAXn3I+Xb/wisSiRYD1pjyByYoY9ld
	AqWRuOUgty6R0Lu0bnhrZIy/IIEdcJOCuEDho9RmzUNWto8c/L5zAVNtT4iD8SWd
	ZCGm3AsRZZ/W1ZCqK4MfB210iINow==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu22k1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 08:52:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63M8oJKD000692;
	Wed, 22 Apr 2026 08:52:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxsgde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 08:52:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63M8q1Yi23200036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 08:52:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2440C2004E;
	Wed, 22 Apr 2026 08:52:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D81752004B;
	Wed, 22 Apr 2026 08:52:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 22 Apr 2026 08:52:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id BA1DFE08CC; Wed, 22 Apr 2026 10:52:00 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [PATCH net-next] Documentation: net/smc: correct old value of smcr_max_recv_wr
Date: Wed, 22 Apr 2026 10:51:58 +0200
Message-ID: <20260422085159.459678-1-mjambigi@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: DiKhJPsbYyBo2LC1o3Q2OtwNoIlMSEbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4MyBTYWx0ZWRfX5GMLbm9neV7S
 i9omhBUhv7kTVDos5S8TB7zdabKGTMNAuC7IDSIcpiIbgm2kB2AdY1axkv0l1j0bDAJKnmFHeG9
 yZYqbhh/F915XDNLgB/YEv7axtdnxojVCFNTDqMxWdpwH6ITVs9G+o5JmDDRy+p8z9RWIPiT2wY
 T9KWsFDiXpHj6uJ+CqQmDxORwO0mmjUt5ZcDYtmOji98O10U/uzFOqYdx/FVzXX038h5a4fwyl8
 qnqU8Y47JP0ES9+VvSZEr/oRut+qKDDuXOXGuxWSmYc4ydzoq0QUm+c38+1Z3NMwnGOwBHQyFFZ
 Kn7BhUERha4tr148oj3e74jf9MFLA94Wu1bYgWIYdYzdFc6vP5vknertzcxG9SI8KeBaq3Wysee
 R9RiabKKn/QcWkMIG7eai1Yotj6jjH5Of0XAL/l1MUjyAqQR2nIjyhcvG7SrWjYdd7XGhuZcihT
 23/h0m4YZGQpoahn8xQ==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69e88c36 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=-1I9Ca7gilJNwrX6hDwA:9
X-Proofpoint-ORIG-GUID: 1kJ5ozpDJcrH44q8Eda_A4I41BcmCE51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220083

The smc-sysctl.rst documentation incorrectly stated that the previous
hardcoded maximum number of WR buffers on the receive path (smcr_max_recv=
_wr)
was 16. The correct historical value used before the introduction of the =
sysctl
control was 48. Update the documentation to reflect the accurate default =
value.

Fixes: aef3cdb47bbb net/smc: make wr buffer count configurable
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
 Documentation/networking/smc-sysctl.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/netw=
orking/smc-sysctl.rst
index 904a910f198e..279d15e61899 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -100,14 +100,14 @@ smcr_max_recv_wr - INTEGER
 	depending on the workload it can be a bottleneck in a sense that thread=
s
 	have to wait for work request buffers to become available. Before the
 	introduction of this control the maximal number of work request buffers
-	available on the receive path used to be hard coded to 16. With this co=
ntrol
+	available on the receive path used to be hard coded to 48. With this co=
ntrol
 	it becomes configurable. The acceptable range is between 2 and 2048.
=20
 	Please be aware that all the buffers need to be allocated as a physical=
ly
 	continuous array in which each element is a single buffer and has the s=
ize
 	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retryin=
g
 	with half of the buffer count until it is ether successful or (unlikely=
)
-	we dip below the old hard coded value which is 16 where we give up much
+	we dip below the old hard coded value which is 48 where we give up much
 	like before having this control.
=20
 	Default: 48
--=20
2.51.0

