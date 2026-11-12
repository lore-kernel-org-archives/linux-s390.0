Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492762;
	b=lE45SDuAmwnUdBSOisEMFy2Zw/2pxDSlGJhS1qxoyJ9TsRG7syZNSo+eZm2uR6XJ7E71
	 aCXVY7ia8lC54YYAk7UD2WE0+rdaEhZ8qmSqBQpZivh/NibCOdAD3vTbFqjf0Z8HOEZtf
	 4zloSi1rOxP0/8aARaXj9MPpuJpvTNsfIapMJZf7buRzM60MiNNshrJ+ctFoMz1piJRj6
	 97iQUhXH7AMr/MvDfE9PqSuhAxbvuWDSO/9du03pxG3f9WrSm24QV33AE16bZEOC1H0zK
	 1NL7VLw5APJEw7fFrZ5BpuhDrl2RW+hhsO5Pz1Y2Lho+uieUWIbYD/FY1obENsEDC+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492762;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pQoMQF2na3rL/x1uvMYsB9AAaLctf9EnvpAt3pPN8EM=;
	b=mMZ6vE11Pjo1a+dI30vuFwOFODjDyLZAmmvHSjWwFYVVeyufRUzOBUIm1dExt+cWRICL
	 UjVFhVckONYmiY3u6YQR6D4mdDMqkwkpjSQ3y04jaEP+b5vmzL8FMT5oSMjtivuaZ7Jbv
	 hYtHIS5NlQciU6GQNsBPHyMt/wEQzeR+5fIJui0QEFd4OP0HkwLuqLUNcsumPPGn3+Xxt
	 MrKiE8o9aD7Cq77NTy5w5e02F086MuBHfwTHxEugNHdiUnX81hYbwXh4DDsTGpk+sqwxX
	 diDQ6VRX17MPjKraiQLwaUKSCmTmoHK02cmmXRlRHl09EPzqCdTTFwHShK5W4zZQO4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=de.ibm.com;
	spf=pass smtp.mailfrom=de.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TrqqsQs7;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61485606A32A;
	Thu, 12 Nov 2026 14:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61485606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TrqqsQs7
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iIs71214737;
	Thu, 12 Nov 2026 14:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pQoMQF
	2na3rL/x1uvMYsB9AAaLctf9EnvpAt3pPN8EM=; b=TrqqsQs7mXorj3GLrUslla
	YT3FIvGFr+Hin3ze4ABOzCOzI32La86UHI6Vf06/JShNQWktpsLRNlNGIISwnYWG
	w31Rv2qziggemruNE9XT9yD+gR+Dd8RxQEJLa6N5zFP1RxRp1q8J3cTfkCUbxC3v
	KaITdbDzupE+UGsf4JttieSbPCBOWgI30yV2MYnvd2SmO3w8I12jlmUVrSEXSrNf
	xltleSekpp2mwEZB+U5/OkckJ+tpwud41kRfmE6DpiXwhmcXb6eGIVbbau5gLmC8
	LsWuXhoA1JVTJJLwpjqD649DpqnCmdjXD0YKGG3exbIzCE15Ehd5bi8FaLI87FiQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntfux8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 14:12:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAlP3e676751;
	Thu, 12 Nov 2026 14:12:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwc0t8n2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 14:12:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACECZe850069924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 14:12:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0250220040;
	Thu, 12 Nov 2026 14:12:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7363E20043;
	Thu, 12 Nov 2026 14:12:33 +0000 (GMT)
Received: from [9.111.75.87] (unknown [9.111.75.87])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 14:12:33 +0000 (GMT)
Message-ID: <fa5ce22c-2fa5-4a9e-9529-edb2b34b9195@de.ibm.com>
Date: Thu, 12 Nov 2026 07:12:32 -0700
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] KVM: s390: Misc bugfixes for 7.4
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20261105153705.208516-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX2LjimSKpd38q
 qsRHe/qoWQ3aLJ8fDCTr3pYaK7MVjMXgrGaknwgAh6uVNX49cHhzDxMtEMvS32us6MTpFvX1JsC
 bqnPMtHpH8EMZWvAOmAG1WXccuSYLDCABlLpOoy4742DH8ga9CuymOx/3oLhGUC4SHLD4lftPZJ
 HdhW5V/yLt+O6JsCXs7vCLHjRqLmzZu9xB6KmuNlMbngo8FI8j/y+pyX31BxOW35xC52pKYibHA
 A+YxXoiaonHQXLl9Sqse0v8fBSAHMeTrTPTD9tT99m6PgUa+kRr0ylBNubAC/zjVWmyYdpWDZ+E
 4CZkHEdgVV5pX5VQeI2o2XkdQkD9veAlmGUohiQ99mcuqhvX5TNs+AgtiDqffBi4N5MdhqETjQ5
 iUREzkVGudMj3PIoucJTB60qDmwOoenYsGK1FXnVUYz3TLSL7IfPjd3ljhScQqdDN8L+t3yKDd0
 c9ELprBoo8U15TryHfQ==
X-Proofpoint-ORIG-GUID: j5Yko7n0JbKgcD1c8dwH3jiQPEGAkDHY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfXz4057bP2NK8v
 ItsObM/j9jITvdfl0/U6AQKj5XlwmtGP4P5oseF5rXwk1NGj+BX+buPXn4lpDYxEWLVUzPqL6x3
 02BfG0vM1EuJBXWuB844CPsUYyHPl6Y=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af5c958 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NzrfYeyCx8xSIZO_sXIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: j5Yko7n0JbKgcD1c8dwH3jiQPEGAkDHY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120054


Am 05.11.26 um 08:37 schrieb Claudio Imbrenda:
> Misc bugfixes.
[..]

> 
> Claudio Imbrenda (5):
>    KVM: s390: Fix UCONTROL inconsistencies
>    KVM: s390: Move some skey functions to headers
>    KVM: s390: Fix idte_crste() clobber and table type
>    KVM: s390: Improve unmapping of large ranges
>    KVM: s390: vsie: Fix pinning using the wrong flag
> 
>   arch/s390/kvm/gmap/dat.c  |  26 ------
>   arch/s390/kvm/gmap/dat.h  |  54 ++++++++++-
>   arch/s390/kvm/gmap/gmap.c | 190 ++++++++++++++++++++++++++++++--------
>   arch/s390/kvm/s390/vsie.c | 133 ++++++++++----------------
>   4 files changed, 249 insertions(+), 154 deletions(-)

queued for kvms390/master. thank you 



