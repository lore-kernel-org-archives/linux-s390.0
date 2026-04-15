Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C481A8F84;
	Wed, 15 Apr 2026 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251423; cv=none; b=ghMTAdhFIB8+6ibjCjXT7IC6gDzlcufyzCQ2771UMsDiWi9fFpX7EnTqN5AJJrsOKBZcx1qw46l59CMS+uvDYYYI0Ju9cAhAwzOm13dp9uBmegxKemJNdhMmTwSX1a0+JwYYQzQ501KZd2J7QW0zAnSrRSxLvzRAHzfE3Q20MEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251423; c=relaxed/simple;
	bh=xkPiEsI4cF3lsEwffkXYT0VGbx9D1aOjuxAljDoIGnQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bcfm6e3K3aZdG+DExTzLHsx2ThXxMNaVmVHVEqYjTb4Wct2NjjRoXWy94K7dXXgYlL1bmc5WJmJ8rpqe6a/7YsEi96urH/B4+Gkz9JWGmhp95UpcPiOtO93jXJGTxobLjcWBvdz/8E3I+7sXlwq5bR5arz+MK6HdaOdWmouCFsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EAMkkGJf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EAMkkGJf"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F3ndOW1859847;
	Wed, 15 Apr 2026 11:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o/fPOA
	xePRmfKSJ5J8bwEm2YL2VrocDjfuuVoVR09uU=; b=EAMkkGJfqPb/KBRVKdc1Zq
	qwZWtKBzHUeXXymGQW9RTKVY1eLDAm/N0kI3RShAtk53xnN5XQTa1Fhhk1Vv7fvq
	SGaIjj0/T2iA/dJVZN+Re+XHWi8OG1BttrgEym3duGaw579JNRhKkEUoYqNfPCdz
	JNezPziSOtJZhiXs6V6hMbD0WKntaZsRze1KrN59Wxfzutzr5r+wAmxPWHvPnYGW
	6qIOzDdNuMHz0WRDx7sxpQYV7uE3faSYZdh/00sht53AmW0eb/Uamby7mgTIAhMz
	D03079Gk6inhSaYR9HWVmisrlbPiYAvW3dDKQUaY5aIEJAXS5spcSRUl0jH5PxLw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pf92r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:10:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F7hv4e031138;
	Wed, 15 Apr 2026 11:10:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10ye2tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:10:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FBADIq38535650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 11:10:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B60F2004E;
	Wed, 15 Apr 2026 11:10:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E59F20040;
	Wed, 15 Apr 2026 11:10:13 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.91.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 11:10:12 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 13:10:12 +0200
Message-Id: <DHTOKQ1LRG2N.367JA1MZ9W2DI@linux.ibm.com>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Thomas Huth" <thuth@redhat.com>, <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH v2 2/5] s390x: sclp: Remove unnecessary
 padding from struct sclp_facilities
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>,
        <linux-s390@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
 <20260324-vsie-stfle-fac-v2-2-5e52be2e4081@linux.ibm.com>
In-Reply-To: <20260324-vsie-stfle-fac-v2-2-5e52be2e4081@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N6IStAq1B23wnBBO8Y-Xz3EjSK5YZ1Xm
X-Proofpoint-ORIG-GUID: N6IStAq1B23wnBBO8Y-Xz3EjSK5YZ1Xm
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69df7219 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZA9-HtVrEdletW6548IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA5OSBTYWx0ZWRfXxJ/FjmWqVWkx
 zRZafJPah/YbtnTfck04tRj7CR+jdKdJYAZ+hcVLVF+UzgVPg4rOnypJoRXZIC3B81Ew/lvXLI7
 xPXt7jGgYAe2j/WjxyucVDKumaCwJM6qk/Rvwvg0dLEYKdC0P0fujE2nJFS905Cf4+zJhGrJoyw
 Vk3zxybMDGVjwyJNjhDuyQ/vmqX35LdhLOAsyJl+WeTKkIFu9FN3vbWEKhj8qdcNEGcAA/F2MX1
 yEmOIL/oKMwR83nMl+3YMbrZGhg3Yr2hWKihZZ/VX4mnGKrQtilqvDDrOUz4ckX42xKp1k4fyGL
 +zHpMbBHkFmTJtxyPnMi1dPxN8NgCgqovLkIs32/d5+1Tep6KJvU7jcpM0RAHdC60EB/4QcJtTz
 4zKU3GuNtwkD8H4vtleK5WnZjbHtBwdVE6XbWDOK3M6/9YVqQRRJNAWVwDSCP3iIR5eI2qlfUNP
 iAlZM3J1D8JcZTH0y1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150099

On Tue Mar 24, 2026 at 4:28 PM CET, Christoph Schlameuss wrote:
> Struct sclp_facilities is only used within the guest to keep the facility
> information. Nothing bad should happen when the struct size changes in th=
e
> future.
>
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  lib/s390x/sclp.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index 22f120d1b7ea7d1c3fe822385d0c689e5b3459fe..42a2f2e9f25a45d3ebd71729d=
f0d9d6d93a4fb50 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -132,7 +132,6 @@ struct sclp_facilities {
>  	uint64_t has_kss : 1;
>  	uint64_t has_pfmfi : 1;
>  	uint64_t has_ibs : 1;
> -	uint64_t : 64 - 15;
>  };

If I'm not mistaken this is already wrong if I did proper counting since
there are 17 bits and we only subtract 15.

Since bit fields are guaranteed to be allocated left to right (see [1], p 1=
4),
this change makes sense.

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>

[1] ELF Application Binary Interface s390x Supplement, Version 1.6
