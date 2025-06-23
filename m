Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B20522FF35;
	Mon, 23 Jun 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668726; cv=none; b=qiYvIGpmtK5VzlwanL3sE7ZqkQGtwTrucmJCwFy/PFKBQDpLRSaQvsPCpRZny4BV5Eea0ocsmocWtuy2NCM/HtEaDihyFoYhUGP+vwqplJys9SbockGJ4PgMXRfDhwXvu0lsFavQopEQcZnSM6wynYArstJC0hMqbGrbfytFkq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668726; c=relaxed/simple;
	bh=T1ks2sA7STV6Dy2RqsA/+pbJrGp8o6mvEMi3hvyBpU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlWXo3dbhdUjTngn2W2aHyqo7kVOkgHii6MQB2/yAoFNsaBebr5oKrKlr0SlR4f8I+t27o6mGuCopwoq5DJfkbWsWc+DXp685y9Pp9khr4Yl2uFxTQOdd4xI/X969mlWs5zzrGuG3Mm015rQd9Gb1mYQdVR1YbyDsDHfwi/ZgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qi9tLdd8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qi9tLdd8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MLrclo022278;
	Mon, 23 Jun 2025 08:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=inwYZ9x6qfNh/e/jmCONVrKKGruSHYUf9ZxAXkfni
	JY=; b=qi9tLdd8evDtAZ2F6IUYFQbwInjxdQEkgj3I0vafZ+LrLPIMOnsnlnDzU
	//ujPm47ip9XYc8eQHQvTo6al7sLljpHzxy1utO6cGty8vnvxxaAX0aI1pePFuqF
	YfLOmYAa+ce21lxUw7uqMymQ83QKx5Mn47zJs/hf6WXz8TxhghhjGGJ2vVRW5pR0
	Hp5M/AdqaeAI4a9j7bLxnIpRQlnJI5w93lnD9CwBzvUJ2O2ofcHleCckqugYeV1E
	wCK8eW8+KqRpDgjUZOU7bRkX50Dy5wB7oirf15gt5vfZ247oLQqAvC3T+1QVpVSz
	3RMbNYB5fuOhcwZbfhWXHxTnTevnw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme10cff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:51:56 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55N8o57N015998;
	Mon, 23 Jun 2025 08:51:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme10cf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:51:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N7sICu015033;
	Mon, 23 Jun 2025 08:51:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72tdhf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:51:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55N8ppON25625250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 08:51:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE95220077;
	Mon, 23 Jun 2025 08:51:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C07B920071;
	Mon, 23 Jun 2025 08:51:49 +0000 (GMT)
Received: from LAPTOP-8S6R7U4L.ibm.com (unknown [9.111.61.8])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Jun 2025 08:51:49 +0000 (GMT)
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
Subject: [PATCH net] MAINTAINERS: update smc section
Date: Mon, 23 Jun 2025 10:50:53 +0200
Message-ID: <20250623085053.10312-1-jaka@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685915ac cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=9JzLZ8vFzxP9H69fwZ8A:9
X-Proofpoint-GUID: LcEoZcXplxlbX_5se7vWzdacSdQHxDeI
X-Proofpoint-ORIG-GUID: UF9lFq4HUEIrzvHEtKBj7u8IqyyobzHe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1MSBTYWx0ZWRfX6FW5QpFMxlW8 NEc8tbYLy0tkTAja3avqoTWL2u3j0fW9+aWZCH0pIZ02g7TMUB4P4iNwYYyU+EmNNkBOfubpgYs BmKoODU+oOf6uJgLwne80nU8qc3Na8p1jdrE5TbQt8DSs+SOA+cr1uDCxZ1NJYQo4c0o+XzsY6m
 qXX2lbgdkJvPtKGUSHpRuV26Gw+uHP6Wd81vE/5cVDf7fpdFjzt7wcto88PUk9dN52PjT8SdErv 6inw0gF4ypYDJMMjIi4FZeLdmQb2K92KC6kJ+3NGZI1JQwMZQOTl2wiEeuW+HW8fK+BZpWkB4Pl B8XeppJWKWaeA5Ccwh6aL5S1O6rNwQ3ielgEdjEyi9T1MxYR5z2URID58pSvTnKVbKhdEGU+eqt
 NUgw7uFSYMOfteiZU0pRXN0AbxcZ1DwMh/OXpNQDxNj3qXUg7NSEnsX8bdKky3FN72VV6gyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=689 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230051

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

Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..88837e298d9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22550,9 +22550,11 @@ S:	Maintained
 F:	drivers/misc/sgi-xp/
 
 SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
+M:	D. Wythe <alibuda@linux.alibaba.com>
+M:	Dust Li <dust.li@linux.alibaba.com>
+M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
+M:	Sidraya Jayagond <sidraya@linux.ibm.com>
 M:	Wenjia Zhang <wenjia@linux.ibm.com>
-M:	Jan Karcher <jaka@linux.ibm.com>
-R:	D. Wythe <alibuda@linux.alibaba.com>
 R:	Tony Lu <tonylu@linux.alibaba.com>
 R:	Wen Gu <guwen@linux.alibaba.com>
 L:	linux-rdma@vger.kernel.org
-- 
2.45.2

