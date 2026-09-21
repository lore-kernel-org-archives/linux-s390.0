Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2531D39A;
	Mon, 21 Sep 2026 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993251; cv=none; b=g/kfgvEMyppyVW6d5oKqvy2JnK09wt8rgdNJ5GWyBAc1rT+m+3BcBNoDXW7VBLMOtsJkOpYeDkRrAsCZ+vsPbha+641HAY4bu4NuOyDRx6/WTqTPSyqCKG2nKtduW3vRl0C51Xil/dDmw+8z8vUggflvcDOh9C8Wyw+a74NrhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993251; c=relaxed/simple;
	bh=mgO4mokD0E24PqAMfH5gWDTW5fAHUY+njIaRzx4iI+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pZR7TSV9uiZj6Ufox50DU9kOzz+vopS62SvpZPQPf4yjlC7Iw7jpny9ywnnyY7M+AeEcDHv1pWkY83jV4M2k+Q660CrL3aTZEO5I2E7qdJcuRqg9r3PMxHLlU3ZEUS3T8jsnrlS1JpJ6GGsrYMU1sXiUxf5owX69RWU8+HYdg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oYQ6SLpW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oYQ6SLpW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB5X2g1360907;
	Mon, 21 Sep 2026 12:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mgO4mo
	kD0E24PqAMfH5gWDTW5fAHUY+njIaRzx4iI+Q=; b=oYQ6SLpW5rQjlVqsRUgxaF
	v2htOAE/B01yyQEEnlDvXAGFdKoYCxD1S/x+1CY+Sgs+0EwI/c7/M4B4eZN3AL9W
	HjefTbs0rn6G2fkJ0tcGFYP7xUoIBIUw0uW+XpiW7jgI9czYbT9wMvlJ5pLrl7W6
	vQCHcQk4uoG5BA7YIKErBSHteo02LQtFvrGXhsuoMMrtZ6qp0KcV1GQbKeRD152T
	0s0NyBPOT0HGRFnf9cEH5PWSR3RKzeNLUyaU4hpCzeVO7Yj3vvzkVUZNMUD3PWph
	OJAFx+KMufOvmTf0HiZ4bKviOoWTAJqZdZ+kZG8Gk5dmjAG1N3YWd38D+/6NmAwQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv09sh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:20:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlTjs2063267;
	Mon, 21 Sep 2026 12:20:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy4xv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:20:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LCKiw945154774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 12:20:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A82D20040;
	Mon, 21 Sep 2026 12:20:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 710D02004B;
	Mon, 21 Sep 2026 12:20:44 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com (unknown [9.224.79.183])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 12:20:44 +0000 (GMT)
Message-ID: <6f6c532cf8f192277661f0383c29ad7f9abb0666.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/sclp: Resize for sclp-vt220 console
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Date: Mon, 21 Sep 2026 14:20:44 +0200
In-Reply-To: <20260921121619.1354611-1-maxbr@linux.ibm.com>
References: <20260921121619.1354611-1-maxbr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YivCbbaYkuHk8a1MFm_ridCoQ2gauXI3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX9kosdGEYPXI6
 A0kUcUMBJ2FK7PWMjp8Mc4YgmYMHz/DKiF9ABSD4BQ3s8HNPN3kwoGu1y4SJqe9sopKSgzLRtYl
 I4GVhV1gMiHJIqbB3NwFPDkCIutNp3c=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab12121 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Fyptuc2d6Q3nMO3XRtAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FBTYA53j5xaenkK4BZYZ2EnovEQdOisz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX59blTO2oBRKW
 WTlSvm5CXGi6C1Nwiu3G4PPI7Lgk0KFQ9QshdSMr2Le8YkRwdoeHlJhavmiNLpsastRmhjf+CUD
 dIjauWOjU3g2WwU+40+mFpxxG5gU/dn215Goly36+Q6f4YwYy7O0xJjfG/5g8jza5F1ylvTz1ml
 WToV3q6dnSsQ77woH7km2YxIWvI7extx4iLYUIJwQubXK7wDqKlBl4m/dCZw4GghRGn0DLeqiFK
 urdkFb/7CXr9gWF2KOaRB8AvsgeqjffpyZX7dTze4SO5ULy1P/Sj146h8YoyOWB5qfLnVwsLoOI
 S7+UaNpghT9JQ0uPhqgec/6Ug9nMUEsGuyWWHdFs2g3H24d1LJ0Wk0uqfTbe0INPMsreQRvmHeQ
 +uMvr+bLOM3O26+FfzcFOhIP/Nag0bwjSOhc/5EuuHYkJvscfPuRK35L/wCTTmGHp1woZ/Gnw5x
 RU0W+OiGO/6fScMDFNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210175

For the QEMU Patch see: [PATCH] s390x/sclpconsole: implement resizing
for vt220 consoles (https://lore.kernel.org/qemu-
devel/20260921121641.1354712-1-maxbr@linux.ibm.com/T/#u)
