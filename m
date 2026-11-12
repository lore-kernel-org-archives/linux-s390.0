Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479180;
	b=1Ln53bgSWKGZqKyGOlsxrPRQmaxG5tPA/oz3N+8acPte/y7Yb+mEAe38PpSxjYW8hDPB
	 qT1N/mxPfPkH3dLUWzbELAnIajsoaAI3HEkWz3L20ARhO/m9EzKyirxvN0qgS8Pk1nkXu
	 GWITNotF8XIRyNF3ihHRULyjXGBZR6uXALAru32IaPuoTkklIIRpEzmj+TMUvtzbMJZzn
	 4786mxV4jjwjU11rv6+jWeUWFOalySvdR25bu6Lok5+diTXFOTK164YrkY/S87ZWlbDTB
	 ckLZXn2jvAPLtUBbHQgUeH6bqz3xAy5XZO96qopTW+SKY20TmhirN5XDzEyrPJK4JQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479180;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rduM2ChEY2vuwblkaxaGB4h8k/mCpba35Y3WJiBJgb8=;
	b=vazHgXOob/lXFjYdVefyQjmt4wOm3oI65kvDOu+TcnTK2rXpvdDpfyqq4AKsIQXtQDJV
	 7FB2k/+aPc1A6WRhjorO21V+L4nFn4SXdje+qOfUIL0RdfBRIl/MeFAX5/4Gq7ikhxOkn
	 7ZMew17BRE4k1jgi24y0YEo8ceMtFPQBV6OvsY4TN1fvzoQ4yNq7Wg8XO0YwFeOrTM3ds
	 oWt/0hxnsNx8MZmxbPDRmIq1vuSRTTNRzDTHsIo/L2Vz1qmbOQ4gfVKHE4TqBTKaJO12Q
	 07uFh3Q+SIYtguQ/U0Uuo3UAOr0IhpCzKCrZ6YnJX8nsr+rieovp4gYAfzsnevdG8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m2epVg9S;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1568606A880;
	Thu, 12 Nov 2026 10:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1568606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m2epVg9S
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iR1f1637105;
	Thu, 12 Nov 2026 10:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rduM2ChEY2vuwblkaxaGB4h8k/mC
	pba35Y3WJiBJgb8=; b=m2epVg9S+8Y6iOOtqBERZpywpQz4ggBpEsNEoMc9qavT
	FDJm9XSHmhiWez8msyIaKwi1ryny8eCp6/mRjzPK7zrkTkrgsqG77Nwf3WRNaFLs
	0wV1wUBfpnGF6Q0DYKUgJfdbJaWjIXLEpaw+aX/0RI3TxpPQhbKDF4WdcxSbayG0
	79y4pWEERZbe3So4v2lnx9r83H8g0dlTnqHDHWSnSoCiciPcs02UvMpuzBcFIvKB
	1s4YycacVULUajrLYi+CspQ1+lAie+n11YvzLgBTau7Dcx1SUxWtE2G0gJjyTLXQ
	fli30Ggnf2nJBiZOAH5WjZ2KPvBrI//ZJ66pkYA4nQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgdx3d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 10:26:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC85pxp146718;
	Thu, 12 Nov 2026 10:26:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthxpy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 10:26:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACAQBda47644932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 10:26:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4766F2004E;
	Thu, 12 Nov 2026 10:26:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14C012004D;
	Thu, 12 Nov 2026 10:26:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 10:26:11 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/4] s390/dasd: fixes for RCD retry and BIODASDCHECKFMT
Date: Thu, 12 Nov 2026 11:26:04 +0100
Message-ID: <20261112102608.1057852-1-sth@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af5944a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=3lEHgIg-lAG8oC5C7moA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX83sywHaNmyTY
 o3lQ4uE9QtadgslCTgxzPDwTKj5uS4dE1UqBVYtLFUVPfx3Kfw2vPgxIxn4OetpxK326qMcEVz0
 BshgIK03Nm361QH3i8GYQcb4s9LoIZTyTbtEp2U2fZyhXk1+0NI08AK0dFoW0Te6uq6+vSRc1y8
 SQWsp4U2nTmTtZT7acPYBjq5vtSjIHZSmnptkmz1V5Nv5qLIn3f2xrFz57j7ztoCvA1JXRnAcR1
 FMmr8ESZwHQYv8y4100kCS4TGlEMM/yVJZLeTvXu9qh4v5BXbO4JwRDKAf7/YqbEMAOCWxLIR03
 +bF78ID3UibeRe554v4hM0l7EHRp0zo0JbAiInQQXjXJAoJcVc7zQV2q/xAWtaaF2P/nLg6IrDL
 xeip5HJs8DtlmciAwkm+vYFwpA/yPsgt25PFC4oHFz3faYSDcD3Hml5ndW5KSrhD7G47ubKwESV
 s6cXu3+E4Ii6ktb7Vbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX2pqh+EuHR1v8
 EoElXk7lSn+JSAjwsOP9ZnvalLrtRAge9m6j84pYihi7MX33YbeJWF7ElfoxYXe8W2srmjqdSbk
 BUXA4pYisEFEzXemBAGQof4zJHoTsA8=
X-Proofpoint-GUID: SW37BPRSNHYdqLibreX9J6CoA4i9RsGN
X-Proofpoint-ORIG-GUID: SW37BPRSNHYdqLibreX9J6CoA4i9RsGN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120040

Hi Jens,

please apply the following DASD fixes.

 - Re-initialize the RCD buffer magic "V1.0" before every start of the
   request to fix a condition where z/VM omitted the UIT and the paths
   were wrongly reported as leading to different devices.
 - Two fixes for the BIODASDCHECKFMT ioctl, both reported by Sashiko:
   a wrong free plus a refcount leak in the dasd_eckd_build_check_tcw()
   error path, and an info leak caused by trusting the userspace-supplied
   result field.
 - A typo fix in a function name, dasd_sleep_on_immediatly(). It is a
   prerequisite for the RCD patch.


Thanks,
Stefan

Stefan Haberland (4):
  s390/dasd: Fix typo 'immediatly' -> 'immediately'
  s390/dasd: Re-initialize RCD buffer with "V1.0" before every start
  s390/dasd: Fix wrong free and refcount leak in build_check_tcw error
    path
  s390/dasd: Don't trust userspace-supplied result field in format check

 drivers/s390/block/dasd.c       |  5 ++-
 drivers/s390/block/dasd_alias.c |  2 +-
 drivers/s390/block/dasd_eckd.c  | 69 +++++++++++++--------------------
 drivers/s390/block/dasd_int.h   | 17 +++++++-
 drivers/s390/block/dasd_ioctl.c |  4 +-
 5 files changed, 50 insertions(+), 47 deletions(-)

-- 
2.53.0

