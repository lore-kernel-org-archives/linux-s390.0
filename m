Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7781A6810;
	Fri, 24 Apr 2026 05:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777008233; cv=none; b=qraWATjwWCKfpP2+a8IJPK8AD3S0qz3n7EbTKfmMTGCDkrd08qoHXm5yg43Bm0n2e1TGfOVaUzLgi0E9A9pKUCzTQycwQOCzf4fEEYvZ98TmmwQF5oVcyaHgMtz43Lzf9/eHFN7jqjdab7Ga3qskQMS4il4pQyzk/X6ZbczSv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777008233; c=relaxed/simple;
	bh=AMpqD3jJWGeBhZV7IR4TXunOBsGwB4TmJSwuYV7sTPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcQAHqConNVWRikxXUhk1XO0fLizY755EIhy4TlREB1XF5YoL8Z2wBon/0hT/UCIGl/V1d8fWK+Kofa351ZWqic+gvluNZHpRIV1EssknXAIW8tROVFam13j+XJUp2RcdsHKQAc+lqKSYjh1Q7NAoPCPko6Jydp+eWivBjTSKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U8bwX7e+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U8bwX7e+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NJ0mU13291923;
	Fri, 24 Apr 2026 05:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cOFHgr5aOL1G48JRBbJNYttBKipfGte8kTv2A3cqD
	Fs=; b=U8bwX7e+4XiivLMfH216gG6lnhJUdYE8kAIutVlO7Sw9zo+emEr0a36vB
	5FaOsZSVKrteHR7nOx4n2qTi+AMJW3WuGa3UZkVJ+GGnvpILd7Lue7NwCpSDvjkd
	Ir5MDw1GsfT9cibVXEJjHdimydoPciX3lkxq0hukbOm7T0Yid5VNcmI9Fb+0YBvJ
	6X+gGU6BIeJ3/lbP1FnciAYf/dEKWqTTyzhEuB4J+AWRydiNlkODgV7Yfa6mF9Ci
	C5PSy/jbxltsZ3f8RJgdIr+J1lEa2Tb3ljBrJDwteo9ry5cK7nwb7pRkipc2buWP
	ZwBH2zm17BOqVpXuTz0HL6LZlP3Ow==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrkkgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 05:23:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O5KTp4001297;
	Fri, 24 Apr 2026 05:23:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky9h5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 05:23:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63O5NcA262325192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 05:23:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D5FF2004B;
	Fri, 24 Apr 2026 05:23:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D700520043;
	Fri, 24 Apr 2026 05:23:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 24 Apr 2026 05:23:37 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id C00E3E09D6; Fri, 24 Apr 2026 07:23:37 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
        wintera@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [PATCH net-next v2] Documentation: net/smc: correct old value of smcr_max_recv_wr
Date: Fri, 24 Apr 2026 07:23:36 +0200
Message-ID: <20260424052336.3262350-1-mjambigi@linux.ibm.com>
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
X-Proofpoint-GUID: Z28CPBAV4-S7sGOdNPTx9zF1f8UI8aMr
X-Proofpoint-ORIG-GUID: Cygo8PD4LyyGIlXczw7XCXUbFkjUF24f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA0NSBTYWx0ZWRfX15fAlfHgG1Tx
 /RVarDNwhhVzLHDGdGgDpp9WPxFu8izECo8IX2NjKB4BaonpeKHJbe7vmYXIXus15brjuWKpRXe
 xqIfsiPFej4ngAX8FFdcNAEhq2NRUbdhPGRnK0fAqCP5RF2B1B2fiTe7x65kt6kUIN6lCCCx00u
 5eHxpdeczTSiU1aAK2TwJwzZqgOTHOPobQ6ZITHMcCOohwG43HbTc7whZLCCCLOhdf1RR9LLY/X
 Y4SC5nAKdy66OuVY809+oDRZSO3q5lyPmnLT9n69OULIu7G8P0D0gqi5xlLoxg7Jr3RUZxxOw+k
 zkk/Valo5PE0y92yFH5pNDpPU2xvPD4EwdSsGvBCtKM1QbHU3wg/tNv2BENwzvOKB6INAWiB7IR
 h3nkopNlJYX4Swk2cCqySraNCxYRrx4DFkUNQJ6fjXCRggTvlFTbaLxcc3T/mHpleKznUecPk77
 gRF+O9RdS924qMNs+nA==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69eafe5f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=BZQz5A-QrOPzpkkcf3QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240045

The smc-sysctl.rst documentation incorrectly stated that the previous
hardcoded maximum number of WR buffers on the receive path (smcr_max_recv=
_wr)
was 16. The correct historical value used before the introduction of the =
sysctl
control was 48. Update the documentation to reflect the accurate historic=
al
value. Also fix a couple of minor typos.

Fixes: aef3cdb47bbb net/smc: make wr buffer count configurable
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
v2: Addressed few minor comments from Alexandra Winter.
---
 Documentation/networking/smc-sysctl.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/netw=
orking/smc-sysctl.rst
index a8b4f357174e..93cc6244f6c8 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -86,7 +86,7 @@ smcr_max_send_wr - INTEGER
 	Please be aware that all the buffers need to be allocated as a physical=
ly
 	continuous array in which each element is a single buffer and has the s=
ize
 	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retryin=
g
-	with half of the buffer count until it is ether successful or (unlikely=
)
+	with half of the buffer count until it is either successful or (unlikel=
y)
 	we dip below the old hard coded value which is 16 where we give up much
 	like before having this control.
=20
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
-	with half of the buffer count until it is ether successful or (unlikely=
)
-	we dip below the old hard coded value which is 16 where we give up much
+	with half of the buffer count until it is either successful or (unlikel=
y)
+	we dip below the old hard coded value which is 48 where we give up much
 	like before having this control.
=20
 	Default: 48
--=20
2.51.0

