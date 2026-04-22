Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501693EBF02;
	Wed, 22 Apr 2026 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864042; cv=none; b=GdfadUsCIHQJSsDnmo9a8KeUljW8AKhAAGchVKrtD0pynSvCWl/uV0eOrRaiZZyFpzRWEeoFqKMzp4b1ywRwFa7VeLzqy8YA/Tv6PAfOcUl/VL26xBsxvNtlV6FY9bGjsPbJkIgmTxC1Bxx+worQRCnfCBR88SQCtB3pWUDQqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864042; c=relaxed/simple;
	bh=4gm+trizGRssTBU2RjEWULtb1ACPnt8c5bht1jPuO9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=IIlXgxa0fDu1asxlxGqjuFxz07UUGR08Un8U8m8Xs1mbP5TLzrDuUgYRnffHfu388oEYTIqCdzhy6Nf2L3Xz0y5A5unB1+hFkrZHnLLXv8g2IwvAMbwfGQaQsIfEFsUo3mwHvtR6cn0qTiJl9mQ4xR/9DHHiRcv6mWXZwZTfAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X5cKG4uw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X5cKG4uw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MBKWxM176912;
	Wed, 22 Apr 2026 13:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3/592L
	4QDFeOIYuGRd/zHpH37QjjAKy2409C8NMkBCw=; b=X5cKG4uw4TJfPDrzsUYCpz
	/8nJNgNnSNjeN/7BC6nI2NQjKyvOZ6X6FB2f6g5bO0KNabiXNKecO5pF/c5Q5Z0G
	IPyNH/R3dtxFidGYYruLrY7rBZeMoHGBbgA6ahjGrrhxsXf7bAl0wWiWr7QYiyAC
	4NMyn8ZW9Jyl/vIdHAXjL+Vm6h9g8M3/kqVk+T1jJuYLj/GOqUonwk1KlCmIW5P3
	S/s20NZ+b4p7IBQOMzNUW6gCW20FjK17Fqs8GYpfVABUh8mXsj6HfV4qpn61nT8P
	cFh1OKgGdHtzrq9XjI3GZ1nQqHGg1FQ1VEKfqzd0hCQAnle6qio8/lqRkRVw2yWA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6bd53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 13:20:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MDKHpt005941;
	Wed, 22 Apr 2026 13:20:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxtc7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 13:20:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MDKSMn29950266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 13:20:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADFC520043;
	Wed, 22 Apr 2026 13:20:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E7D320040;
	Wed, 22 Apr 2026 13:20:28 +0000 (GMT)
Received: from darkmoore (unknown [9.87.155.156])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 13:20:28 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 15:20:23 +0200
Message-Id: <DHZPQ7DONRP5.1IL4NP46DFHCD@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?=
 <nrb@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Thomas Huth"
 <thuth@redhat.com>, <kvm@vger.kernel.org>
To: "Janosch Frank" <frankja@linux.ibm.com>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>,
        <linux-s390@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH v3 3/6] s390x: sclp: Rework
 sclp_facilities_setup() for simpler control flow
X-Mailer: aerc 0.21.0
References: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
 <20260421-vsie-stfle-fac-v3-3-3cee84efefa3@linux.ibm.com>
 <f82ad19a-5576-4a10-82f4-1c1577af2fef@linux.ibm.com>
In-Reply-To: <f82ad19a-5576-4a10-82f4-1c1577af2fef@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyOCBTYWx0ZWRfXxc0pT4IazlZ3
 6Fdnpe66a5tNXG6+zieLDQDnyyG0VKd2dhBNhAdrh4GGowQSSruEqs7qyTX84i4la6iK3PDxupp
 Qa5JKAbXKPXZtAhfSHtnyqCUuDaaVuKbLR9MspHNQBLgfqjnOWiZNpBbTaWHCjEJruFgajnl74f
 7SO/E94ntsH5Bcf97rqGiZy1rSIMyLUp5UCjGZFKdTlUpRY0nNcVDM+qK2T3cwVrDSGEs7jmWx+
 3y2dDAe9K95lweDJHxb62eT45UFp7OQTjkdak43WAIHI8ZdYXbjbgJpHboLOyIuz6cy3Ih6xNMo
 ump/Q4nHUOpjXaYPw8gjjucteN5d2pdCDjv2s7q6HrqoTF+eFyBpocUazuYnqKzmQPY+avJJ56u
 WqOJZgNehkzE14B6Iv4acjqQUVMp8SPxVgWyjU/pN+/DjAy6iecrFGz5+pzMVKC20DOK4q3L/H0
 XEywYFHuZ8ymf4xpnSw==
X-Proofpoint-ORIG-GUID: ZsiQRnA7E8HD5MvyFRUgxqkeYRXb429L
X-Proofpoint-GUID: ZsiQRnA7E8HD5MvyFRUgxqkeYRXb429L
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69e8cb21 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=59YRPpYevQR9MkLxtZgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220128

On Wed Apr 22, 2026 at 1:05 PM CEST, Janosch Frank wrote:
> On 4/21/26 13:31, Christoph Schlameuss wrote:
>> Reverse the order of operations to allow for early exits with increasing
>> cpu offsets when reading facility bits in the extended range.
>>=20
>> This is done to ease future additions like the one in the next patch in
>> this series.
>>=20
>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>> Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
>> ---
>
> I have a feeling that we start coding ourselves into a corner here.
> Wouldn't something like this be enough to fix the offset checks? With=20
> that we don't need checks in sclp_facilities_setup() anymore.
>
> diff --git i/lib/s390x/sclp.c w/lib/s390x/sclp.c
> index 2f902e39..1ffcf448 100644
> --- i/lib/s390x/sclp.c
> +++ w/lib/s390x/sclp.c
> @@ -142,6 +142,9 @@ static bool sclp_feat_check(int byte, int bit)
>   {
>          uint8_t *rib =3D (uint8_t *)read_info;
>
> +       if (read_info->offset_cpu <=3D byte)
> +               return false;
> +
>          return !!(rib[byte] & (0x80 >> bit));
>   }

That is a good idea. Makes sclp_facilities_setup() nicer and less likely to=
 mess
up if someone wants to add code in the end of that in the future.
Since the number of feature bits here is so limited anyway this should also
not have any real performance impact.

I will revert the reodering and early returns and add this instead.

