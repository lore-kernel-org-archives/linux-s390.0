Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429430;
	b=GCiCvht2zFsG6g0Akszvji0BNtOZJYT+kjTafuQAsnb/WPbcrFaN6UVxnSAr9poXrmBP
	 vhfx6pJo3gV4zgK7r8x9PanhYaKAhUBXhMyFjgo7BE66RZY+ZiRU9xQNgFa8b4E5hGe43
	 zrVRWrl+IBAsA15YoPVO6rLru8XEK4d2FQOQ6wtsTyWAfaWyBMQ2B9aq98dboYgD10Xvr
	 /9wLOQyd0wZbRpESCZ/NEn8VheJkuPvAAwFYT0BQqk+NaXO2ZK7WO+jDcw3FyMUaFQrNZ
	 k11No20T90CLYOCeSBZC6BDHsRd8scSpHPyQ/y7xrUeFQUqNZi4+DryQRLjHOx+5HQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429430;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fiiKM0+xi0ayYfPAy/M637Tb7JKI4IHdG+ssRZM3nzg=;
	b=WksANKS0LJMoTfgIssHpkVAoj+vw03f1odrqzY/f5mWQOWRBWQNAh0ZJ0FBXOrrKAEdS
	 Six75yWiHW1aMq/tc0UBUBcZVEv+j807TKgq/Eql6GH0sxExhdzZ4ZRfGDr7MEBX9Y99v
	 1OksZGWr9OusH8DUpLXp1dIRY09wa6h5vT24ZeU+Tw6H3Nbd5xTnFqqEf5gOqACNg+Mji
	 qTwuEOISonrgCeJUFz51jlVY9iMryYq85r2a0SMOhi9qJDjBRkiIDsntU+DymoO4XRBAB
	 9oMLLBJY5UTdVV+qwLYkUa41C7Wq9ZgoAAok8oTsge66lSgc+GnOcPgKh1ZxSu8TNKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WO4SF9f0;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07B606A321;
	Mon, 23 Nov 2026 10:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D07B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WO4SF9f0
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9Yph23194739;
	Mon, 23 Nov 2026 10:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fiiKM0+xi0ayYfPAy/M637Tb7JKI4IHdG+ssRZM3n
	zg=; b=WO4SF9f0e/3CAl2XWBArn2s/xdoRtssstarNATr1cr9T2yOmrcbzPvxyy
	3kritER/ii/gg2UK2r0EIZ5XW1oMECKWWM6ZSjoTMSi6SCPbUgW4t2z+DaOUsw7e
	N70LIHl3Sh6TSmT5ZjQe+MYtg7rgCFmQ7FgSD0Y9TbnH1lWQOhOc5XvrpKKybHnB
	6LnQXM4yn1AISZBocCuq9NyNRaK0i12K6kD38dhesREZGJyp8q+HvkxSbd2tFNUm
	FEuIONQks0T0qN3FN9rBBDxxK5Y15Uea9tZ5SUx3BckrBzdwr+QTCSmyWF4av0OC
	xuInWgTtmqbILs72A/1t3LMO3gj3A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv2av3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9JJCo537969;
	Mon, 23 Nov 2026 10:23:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufp4ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANANOUP53215594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 10:23:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7670D20049;
	Mon, 23 Nov 2026 10:23:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4975520040;
	Mon, 23 Nov 2026 10:23:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 10:23:24 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/2] s390/cert_store: Restrict link creation and key type creation
Date: Mon, 23 Nov 2026 11:23:22 +0100
Message-ID: <20261123102324.483917-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
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
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b041423 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=qz5U1ZZxgNoLv9Z8dagA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfX9l+FMRw/IS5H
 4qIEpRvhrH2cPiLC23I5tJY2lXOWD5kY9im8H1tjhFIHPzXHLFNRXVzwNfaPK6rBJh6Qe1cxzMn
 CAXxHM5Dh3t7XGZUxaBMWz5pC7txGlg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfXwQjhl6OYVG1b
 efOJSaY3o6ub0cgKt98D3s2RqIHYHCfpOHaEArkSSXu/jUX1Tyy9cX3xcTxQBRqsEkLK4S1A2kI
 PYauI0gbgqALfiKpGlDESPmwjRk76POvIPc5EHMxN1yn7lqdVB8ORZv+JBAk9msx7UwjIjbOhSg
 msb/KdX+cjNWe9HBeNOehZvPVXHn7YluBMg4nkUTC9z0VHMRMWT3N2Ic4HSH18SHDRUznreit2y
 +Xev/iLZrFoCeZWUMpfRrSA9GfUu577H7esyt0zvqxhfJrs+p7+IrycLtNoqP/4KYsSaOJiReeh
 RuIzuZp3wR9iOHOqzpDcMI+vII0Dw8262zd/tDaArCUGfobtHU2vTat3O9V8vlKA/2wBqtKJpvU
 KlVA0weydynUJQsFIuB01pLgSu/9tnxCMES+Gvzlmjef4qhJ3br+1CrcMCNevodDVoWVJtLSI7P
 TNmXN40NXWgZA4bdymA==
X-Proofpoint-ORIG-GUID: _jhjA2EaNHwywvu8-SBDguHGI92jXQod
X-Proofpoint-GUID: _jhjA2EaNHwywvu8-SBDguHGI92jXQod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230040

Two more patches from Anastasia, which apply on top of linux-next
20261120, which includes all the previous cert_store fixes:

Patch 1 allocates the keyring with a restriction which rejects all
links, so a possessor of the keyring can no longer link arbitrary keys
into it before the certificates have been added.

Patch 2 only allows the kernel to create cert_store_key keys. Fixes
potential disclosure of adjacent kernel heap memory to user space.

Thanks,
Heiko

Anastasia Eskova (2):
  s390/cert_store: Allocate keyring with link restriction
  s390/cert_store: Only allow the kernel to create cert_store_key keys

 arch/s390/kernel/cert_store.c | 38 ++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
-- 
2.53.0
