Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D33B42ED;
	Tue,  4 Aug 2026 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845205; cv=none; b=A/7i8NwVk7p86F3xC+kyqa2WBPULebSfULFfztQ69g88oH1kq2CJQIdqIEmTzjXgcYbcNYseUEbZbA7vTKqPs8484gZFhdfRY61hz1Giyh/t3bW40cnZUDEFgDLU6DiI9O+cBXVIJxIvmzx4bMv/1Kh7ErXqVHv4pDibYJq+jSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845205; c=relaxed/simple;
	bh=HfTH2VQGlew4Ts2tMMggc/LTeW8u+w213EgKr7w4occ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHM1Ftcyzm5AFcWw4J2RLkAbHnqggIUb2s9767l0poVN8f7jepvUlKmCDknx/3SIn0y9a6BHnSKYycldRe8ouvuXhhHa2psbkc9CiuWB4pG0JPElejiupMNhLGF5hHWyxKI6JntZtHF4VgBiedkxo2962eobERMipX24GXnuT7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fCfB+M4Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fCfB+M4Z"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748HXxN323662;
	Tue, 4 Aug 2026 12:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JdzDhMr6txDQQDcBCg7sKk845oJ/xo6PgUbt8Jduh
	tw=; b=fCfB+M4Z4ob7oEMzqMCpDxIkSPN/9bceVEzjnrtOwTikX2ZpmGan0uJ9W
	KHg3qrxT3XF8jvKzdomu52kqdZirQIDED5jyO88OgbMcJIWDzSxkA1wShyALn92U
	Odxmwo3M1KTiyGV1iKycFSkqcVPQYKH2Cdgo3eV1QHoYdNebY8/zqQaQ+d6HRuVz
	OKG7w98UIqGRIR5B/fSFUgMyYHzbN+zKD3in2t5pDxueL9zu6eC2GBV8mavoZeAO
	HqQ/IEOivd5k3WdQHHTbhJgrzgeMB/2pAAxxccLw9UvUgBm6YThfLZJMNRn/j3fq
	bN3OfEoFPoYRVRqTZ1hZY38fBHlgw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4wpvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:06:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674BuFTC030756;
	Tue, 4 Aug 2026 12:06:37 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k1tq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:06:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674C6Zst8389126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 12:06:36 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5B5A5805F;
	Tue,  4 Aug 2026 12:06:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CECA658051;
	Tue,  4 Aug 2026 12:06:33 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 12:06:33 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [PATCH 0/3] KVM: s390: more fixes
Date: Tue,  4 Aug 2026 14:06:28 +0200
Message-ID: <20260804120631.736919-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX5VN5874olYnl
 eM3zcnyiOb10dN/WFfkbRyJHHudpa12v0CdyP6zro0VFfTAcTofvzW0eYdFrA0QNP4snUjNMSRj
 hhENtu5rL4N5K2pepmP4p4C8K58oEak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfXw0NJk/MaLEb/
 qb633kPi5UstoJPS7LNhx7Pjvx7l22LoPy0KLaqkDnYRCG8JyqXwM2N58gvUQ3/h21KNyUGQfZ1
 /y1hiJLCrvt0WThNir1IeYWkMmF4hDYkLc9rr/s+TIGsd+/4cf48j+Eti/cWvslcFJvcrXoBIwC
 vvG860gg7IT0RWF6wqzWAiWeNE5stKKCRxSF/GTErnmYXZYvpO5dV13lYsbSMZ5Lil2Nn5wiFe2
 xosRC+cigiWVSYw5otxJOoo48EFTphm3e+aBrDY/AN7sOzEU62IqfG2eRfINqSoHCHOCmRuK+Zv
 84HZlSrM0TxRFpFRMRV9vGxZ1jlRUVxFdOqTABN25uu7lskqc7ZsVew/OejGoijWCOULiwUciuv
 8CwpqloaE6G0SNcRpCVHQ49cI98b1i5zXnyG6v4xZuq55qb6FvwgOJ5El6LC2SywPboh4KhoVxU
 LKJhwyQGCeCTHBr9JoA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a71d5ce cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=hWOXj4-Wzb3IWit2K00A:9
X-Proofpoint-ORIG-GUID: WgZTelzF6IqEnggkOySs8bbmTV5UibpP
X-Proofpoint-GUID: WgZTelzF6IqEnggkOySs8bbmTV5UibpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040094

3 more small fixes all over the place.

Christian Borntraeger (3):
  KVM: s390: remove user triggerable WARN_ON
  KVM: s390: zero initialize irq for inject_pfault_token
  KVM: s390: memory leak in guest debug handling

 arch/s390/kvm/guestdbg.c  | 1 +
 arch/s390/kvm/interrupt.c | 2 +-
 arch/s390/kvm/kvm-s390.c  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.53.0

