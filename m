Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6233ADB0;
	Thu,  2 Jul 2026 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012093; cv=none; b=WSkorQTeXA3oLWE0CrBMh95o8W+n6MI0aS1brHT6ieSMIr56ZgT9qXB/PLaJ+fewqPt9hV2AVLUyfc0xQjW92qOVh/pDh8okPo/CM9kwBHcTDeC6Mo7wwHwuzs90QnQ3IIqRX/50RnOrcoIbhAWK1cGfSQ7u7T/jAUBzTK5vvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012093; c=relaxed/simple;
	bh=1Bn6x8nNAEkYJho3nAo8diq1miet24ECuHaYMJGrr4U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mQ2nOZZgFRP/QsZ80vX7/Wik3eCcRnnF918uZERtrgnAh4V5Yx4bxn3q8PuTVmu2mDiWrzGJgZY3HhvSaDlc7+rCg1Jgj1cKqsujynGdJTP2jLP3Pu4WylZrIiG1+dOWbUHn1cMxLvz5XR+OobaT8Sdcs6iCcy4mog+SX7IwnUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bIXjFJ6P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bIXjFJ6P"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662EIFsb4134394;
	Thu, 2 Jul 2026 17:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BlZ2jn
	RJ6bWnOj2JDQjEpzct0GrjVf+TKpDeeLBL5zs=; b=bIXjFJ6PxOIK0wKP4oETf5
	NEVqj0lFmQpQ94szAEz0XDrNDjkz4ueH6PDoWM7CjsgcjODvNg/n5dOLzetXk0n7
	BLVkkQy3QVqgTMQylDNZJ7A+hkZEayBaBW1yP745+MIN0y5bzPJe4sd4EIsO/X/v
	BusMdkoyzYo+V4EA7GTcYLS2S1wyxBSJugscOW6LhRZmaAHww/+Qaja+jK3Ni9TQ
	8NDqMghjPhrizCBa6IittLOfvhhUkgFtLD+ygXhj1h8QeBXT3hnuTrmSD1R2KevJ
	a31B4wijd+SliXGWSDlNHSaiCDP5oIDmWBtThGsrX7B5yLIf5JXlo/HZWs14N43w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26peb73k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 17:08:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662H4gVd000676;
	Thu, 2 Jul 2026 17:08:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhmwuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 17:08:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662H87uD10814172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 17:08:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DCBB58043;
	Thu,  2 Jul 2026 17:08:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83DDD58059;
	Thu,  2 Jul 2026 17:08:06 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.136.69])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 17:08:06 +0000 (GMT)
Message-ID: <6f251f37b0aa2b829769d59bb3e4f6d494484750.camel@linux.ibm.com>
Subject: Re: [PATCH v1 3/8] KVM: s390: Fix unlikely race with
 KVM_CAP_S390_USER_OPEREXEC
From: Eric Farman <farman@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Date: Thu, 02 Jul 2026 13:08:06 -0400
In-Reply-To: <20260702152406.204782-4-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
	 <20260702152406.204782-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bu1nPldO9y19wGYeoTPqQ2JmXwS4OTnK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE3NyBTYWx0ZWRfXz8SQtCO2eUrP
 mDJVjA2wU5zX7U7LXYpjKMqCDWhXyEOYxJjrviiycDXtGGwKIeVUlfjf2Wj4gkvtdCSpfUvkYmI
 905TOHsnLaKGX6aYy/U8NoNjFPBG6BM=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a469af9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=UTdIPT0w00pXnvBMiBYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE3NyBTYWx0ZWRfX87HSXYfA2OQg
 d9V4cQ3YY0Dvg4W+k3vTPuvZzLYZGRypKDrAlQB9bUlDxkJngMK8IsJai+ZofKveDCvZYdWFkpG
 CvNIuydrSW335F6XiHTmJYotp7eFhAxekREosQD06jMvqmZlkgkA2fYBEi4fqtg860Zoj8bqU0l
 CFie7lwAyYJnvv0f1EUmXH8AcNh9ucxfBbny8vW9KWxh1xo+bjIxfY3LWmhHpwq5K+gWIIgbheo
 x9z5oiF/XCqbfeVCwqdocw18euwWxQtPRBMWZaTyXSZqUfBNRj9OJEeJKJaEczqLvFWOWISLJg9
 rKIgJRbG5pnRONf9O9KyR2X3wQGSlovCYOSutbNWQjjR1wXo2qMOlCUa/R3IoJ3VZwPGPhCg0gA
 H9G16eZE3LWT6W5ZbNLr65VzmvnkFM/9SZGW5JOT3SYiQnpFuVHBLIO0dlv5y07ZWAtVfT3VChb
 721T7mqnR3DKLT85QwA==
X-Proofpoint-ORIG-GUID: Bu1nPldO9y19wGYeoTPqQ2JmXwS4OTnK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020177

On Thu, 2026-07-02 at 17:24 +0200, Claudio Imbrenda wrote:
> Due to a missing barrier, it was theoretically possible that a vCPU
> being created concurrently with enabling KVM_CAP_S390_USER_OPEREXEC
> would end up with the capability not enabled.
>=20
> Fix by using WRITE_ONCE(), which is enough on s390.
>=20
> Fixes: 8e8678e740ec ("KVM: s390: Add capability that forwards operation e=
xceptions")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, Claudio. FWIW,

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4a6d903e3523..784f7d9c79c7 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -955,7 +955,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct k=
vm_enable_cap *cap)
>  		break;
>  	case KVM_CAP_S390_USER_OPEREXEC:
>  		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_OPEREXEC");
> -		kvm->arch.user_operexec =3D 1;
> +		WRITE_ONCE(kvm->arch.user_operexec, 1);
>  		icpt_operexc_on_all_vcpus(kvm);
>  		r =3D 0;
>  		break;
