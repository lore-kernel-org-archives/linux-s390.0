Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0AD2773FF;
	Wed, 22 Apr 2026 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837878; cv=none; b=Gv6EsmxAcqzp4hM+3t1ldcDqPFEJ7XB1zOqAlYFU54A47QUgXKA+H026JcesHE5bGlTQjuIFssyubuV446inJoSFwEzCSzUf1kx3uYN1ZDHp2ZoFRRLoWET2BdEXcIBCuRUz5eubevYtBXR7MXd1vwKcIVGagUDn7btvG967UN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837878; c=relaxed/simple;
	bh=l/Xv0ByC+wpOpBjaVlGMf2Va9omIbMuTRr98oFoAT3Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rNxhAG/4kohS0IfgSa/kBxaSH+O0QGw7wOCwPw/zQrmYMmGmzSlu4vlxHjFqz1wUiVW06qjddczaOJtOA07PQ+qt9AV0Mp+dPFW4DlMERqVFXOCG1rDsdv7Drf7baPx+JTJXcvxUk8oo3lSO3I5ZiFgPOK34/npWWI85slfUQKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bKjb55FJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bKjb55FJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIlh45970191;
	Wed, 22 Apr 2026 06:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yqoli/
	BKS1Da1rSShv6mTI8JJDCdV0SCpYsnIOdKZFo=; b=bKjb55FJwQ8nYjWOgUC5QD
	20gvTXAcw3VrhGCCg+ithk5pWq/Id61i3EoGa7bS1qD2ReKTI6WKqjpFsrqHa1iT
	fmNpRp7l/1L20e947zURAONQcrCB4ZBkIg9Wwgu8ECHRi9EbOVp4gedZR2hHBKaf
	1/G51iu9qnGyINZ4xFQjT7p0xCEprd0MoSfsxq/w6BBSC4LNNj23FAssNFKZPnJI
	0PqMf1PHP48ZnFietN4sR7qB7QCu6SPdR15hUUneqNYzWtTP3iAkXdWoDn3TLL1R
	ckS0HRckM9JxLqiytUvp29FM2c3M3X7RUt7SMcrHFktbMSTQAK1s3PPBHyjCy6kA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3hs5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 06:04:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63M5oTfp025645;
	Wed, 22 Apr 2026 06:04:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxs0gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 06:04:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63M64W1s57934258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 06:04:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06FD320043;
	Wed, 22 Apr 2026 06:04:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADF1C20040;
	Wed, 22 Apr 2026 06:04:31 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.40.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 06:04:31 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 08:04:31 +0200
Message-Id: <DHZGGHFIB3HM.23YH58OREC8WD@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <nrb@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/4] lib: s390x: sie: Allocate
 physical guest memory via memalign
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>,
        "Janosch Frank"
 <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260420084933.251244-1-frankja@linux.ibm.com>
 <20260420084933.251244-3-frankja@linux.ibm.com>
 <DHYXKO2IPF13.1SJ3D8S49W7BZ@linux.ibm.com>
In-Reply-To: <DHYXKO2IPF13.1SJ3D8S49W7BZ@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d625QQD7ttNf8_fzwrqZrcPwaGOHoi3S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA1NSBTYWx0ZWRfX+GMl8ukwESIJ
 bFggQ+gAFdXA+4M/RfYmKww7npHYBhOpM00HAB9+kYQeq3FwhskbYoP0G27h/qSeCXy7qdHVzQb
 np9KmU9WYgC+C5tEgUhcjWv4UV+9HVts0J6UK9gVZqyTjLWT8TSSOVHEmMyaF9NA8l2iccXfK0/
 QPo+wlkV3qfAy1S7ujIcHzSLjatO0/Z0vmcM4lyI4bRqtfS4YUpN7eiIuCFXOBrqrJMNNgLVTkN
 y3I9ZDNj8RPSpI3oGKDwdBhsO1tnGp4i/M1+hHNiKCklJNNVGzaTMcI0VjWhFQp26b0OlxX/FbN
 Jmyya70DAsLSMwd7FoH4LLqkQPyVUXz8hbtvK3mOdef39sk4b2ehey9YJcBtupFXb3i4yyEz91N
 6omhj6aMIJWNxbK30dpPLRTU8s9/t9L9OVCx0NJsahdnOMRin61qXjfnK40hrhRgUIMYkTE6meY
 0ufnnNQo3Kd2sSDN9fw==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e864f4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=6CX5Zf9KZRiv3f7GAsYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d625QQD7ttNf8_fzwrqZrcPwaGOHoi3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220055

On Tue Apr 21, 2026 at 5:16 PM CEST, Christoph Schlameuss wrote:
> On Mon Apr 20, 2026 at 10:44 AM CEST, Janosch Frank wrote:
>> alloc_pages_flags() alignes the allocation on the same order as its
>> requested size. Since we use virtual memory for SIE we can instead
>> align to 1MB by using memalign() which is less wasteful.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/sie.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
>> index 47d4cdde..b1b0a8a0 100644
>> --- a/lib/s390x/sie.c
>> +++ b/lib/s390x/sie.c
>> @@ -171,7 +171,8 @@ uint8_t *sie_guest_alloc(uint64_t guest_size)
>>  	guest_virt =3D (uint8_t *)ALIGN(get_ram_size() + guest_counter * 4UL *=
 SZ_1G, SZ_2G);
>>  	guest_counter++;
>> =20
>> -	guest_phys =3D alloc_pages(get_order(guest_size) - 12);
>> +	guest_phys =3D memalign_pages_flags(SZ_1M, guest_size, 0);
>
> There is a const for that:
>
> guest_phys =3D memalign_pages_flags(SZ_1M, guest_size, AREA_ANY);

Or just

guest_phys =3D memalign_pages(SZ_1M, guest_size);

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
