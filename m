Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447B4A5EBD;
	Fri, 25 Sep 2026 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344140; cv=none; b=MO+FJpq6H93HDtX/EGiUAE304McGd62otBTtWk23hK9nIxk7l6D5YVGeWMyCUZRNQ8aQmWRupH8QD2lb4NVFFEx59pZbYJyZ12HzdNtq9IvuR2XgZiIDblXPJQgges98G8IR2NekdJVwqfGE9+7I23xuQqm+UMprzRCCcoZG4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344140; c=relaxed/simple;
	bh=WjxKZasN2j01CHH/zt2npltpduTlS4FjfX69sy2klps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/7xfpkkSpazBiqAQM7rSWlxxDWprwJ+DsRgkNNFOgLWZBRC3kE4zSnybfDfcepaojWyYuvz3FD7sKBL010WBNwxji+R5W+mrsQ+/JkGXm8covW8bIneQF+YEhQeetI+zofa6QKZPA41i2/PiroZRaM7pGc6AOdZ+Zde7/24Olw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U6JtKzmP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U6JtKzmP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4ZsAU074224;
	Fri, 25 Sep 2026 13:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vW0cVh
	I9lri601sLp4W4jAmowTfw/qCQjrhh6YYFyjo=; b=U6JtKzmP6o1X7vakCJH288
	qZEk4h4vRviGZeyZPpV4qi6ZbAr1Zga0Yl9oyUKDFzovu73VDDKp0cSKIQc2OcoY
	kBDldsMqOCCroWuoel4XGw1APuREzQoJAFn+P3e+L4CnSZh8X4q83Oxl61OHz1u2
	va85gSaVtZ2We6qOIAV+RDT1Gets4l/DDVPfwfC9yC6vxzPq4SjnTpiqurEebME3
	ofhtp1d9tcduJhvprAdUtX7HaOrxV06p//R2su2e/oA0I+nlRL3lKITjDCWh4GR1
	G0amN7RYYdsyEXzhSWjDuI0SFaPUg+SIQMW8LpYSCXabIhtkmR4ufRtmmJIlUDsA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2yfa4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 13:48:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9jcQL3296986;
	Fri, 25 Sep 2026 13:48:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qtn13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 13:48:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PDmsCa46727578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 13:48:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BAEC20040;
	Fri, 25 Sep 2026 13:48:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 294812004B;
	Fri, 25 Sep 2026 13:48:54 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 13:48:54 +0000 (GMT)
Message-ID: <942440e4-33e0-470a-a926-66572add41d8@linux.ibm.com>
Date: Fri, 25 Sep 2026 15:48:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] KVM: s390: Improve floating IRQ injection behavior
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, pasic@linux.ibm.com
References: <20260820121546.24694-1-frankja@linux.ibm.com>
 <20260820121546.24694-2-frankja@linux.ibm.com>
 <b7707a7e-26bc-4b0b-ad58-9cd7f8f820fa@linux.ibm.com>
 <6ed30827-e79f-4fdb-8e26-dd14860f1d4f@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <6ed30827-e79f-4fdb-8e26-dd14860f1d4f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lrD8FhhxUtIZEG32iIcT_v7RQvv_zofq
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab67bca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=0NI4bR7Cfh6FfpvhMD8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX29IShEsp6ZpS
 UPh+cOnTQ1SVZtcTKhvv5q8ZMzeoYQgbbOdK7Ns2JMLXuk1nWrUIxKWjg7HccYVqRtzYt1nLT8H
 HxGN6VCnq52v76QGDU98HaKC7+T3SinCDpOUg9ZIFvtuZ3vVyUjQEuGIP5T+cv5yAvGM1xM4HCV
 cEbUcwuBW4tfiMs4Qw1u8mkED25PvOIXg4SmDx+YmHCZeUK9Tydpt74nztfXHq60bTAJhDEtR1B
 YmbdSyymPm3GQRetuzP+CfD+gRpllNTJm0YrcM6y46b9LY5rdgVjTWJSJ9r63qHaYEdC3fb+uI0
 vj0Y9DV1D9/c9e2NtKlECHFL38ZmFtXIcz33gtnozl0j7uQhV31nnLe0dbHXhXKk+V2iBV9qTcF
 /XKjTeb8Noc3zx0vMVr6PMb2rmCxpmfHPJLkpNC0yMGYHe6SeBxnqCHUaG+xsbpjEUqLP3YmzNh
 Xx2Yq9aurZHKW25pBVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX+J1N5fHGstPe
 6i38jEh2KChLApZtAWOkDfvBJXl1gWEzpE3GdMi3gb56K7xlRFy+uW+k1Ql3BWLYDZjcofGkeEL
 Szdbxz+OkUmSfpwreft9WNJbiJ6vHx4=
X-Proofpoint-GUID: lrD8FhhxUtIZEG32iIcT_v7RQvv_zofq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250054



Am 25.09.26 um 15:45 schrieb Janosch Frank:

>>> +        if (nr_tries++ >= online_vcpus * 2) {
>>
>> why 2 rounds?
> 
> I honestly can't recall why
> I can remove that change if you want.

Lets do one round.
