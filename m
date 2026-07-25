Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBEC4908A9;
	Sat, 25 Jul 2026 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784999017; cv=none; b=M63SXn9YIp7mZ0boN7iEwM9P7Hf1v9lj9gjAcBhuNrQWwkHTuXUac85bmup8fxUCysO07nLH7RNuJrpOKNwrudcHtsC06BUOdSQjKMKvmotfuWEbODooQhksjlzEpc+Ef+jRJ7Xq/b+80X6FQzzQi9XTOyC8F70Ha9ykl8JFxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784999017; c=relaxed/simple;
	bh=Go5jrgumjBtXg0tC5k6RDEhrHqz4TtMY8z3v4+63S+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptEEh+yyEEgjWCEVyN4lFxjFIrP+pqW+vVtlfcC8A1g5sIIqLh5tSEhb+efn+EnWLRSqhSfB07qk+1rY5C80c+MSmsje2/QRcShu0a6dRI+CqUQ1h494vVDYAkGUpJKbuWEIUwUEfNXqnWT2Jh4LHuWZE+r5Y8Q1NtsIS5J1oKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V4TKnbXV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V4TKnbXV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDmnJf795957;
	Sat, 25 Jul 2026 17:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DzMBZn
	7mZAEirnM6jF0uVFUbQ5zfRnXfSar/RBJgKAo=; b=V4TKnbXVy4pWaC4nlI1RvU
	0z6kthLycgPkNUci4u0n7fbK9iJ84ig5g7rocdbzw9XEbQUTFovFGd2/Rc985oZ+
	ldX2NaAev7q23gia/VJnfD2fcFKjRpRzPvWV3QOcCDyBrucRxaLLNCPhHlcBAZZ9
	4fFfIrMinF8anJRyR7hBQbiiNFOgAZgC3TawNwarhJJve5R9rdtSx/3YlODiL4eq
	w+tNzVh6e8uyNmO70BOdNI93oDu3frWYjeg1RxzHOp7c3g/1BUnaElkQoS38O+fu
	WxIgp8uN6ulkQC09+7L6r536dGMCpVUUcEQDfXRoNbb+YKFauK8fD/vwaKpNz67Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw70u0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 17:03:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PGv3il005149;
	Sat, 25 Jul 2026 17:03:34 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn2c1wmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 17:03:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PH3WoH13632038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 17:03:33 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DDE858057;
	Sat, 25 Jul 2026 17:03:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3D4258064;
	Sat, 25 Jul 2026 17:03:31 +0000 (GMT)
Received: from [9.61.125.168] (unknown [9.61.125.168])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 17:03:31 +0000 (GMT)
Message-ID: <7a3da5de-de52-4543-8b42-a3ee344d4d95@linux.ibm.com>
Date: Sat, 25 Jul 2026 13:03:31 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] s390/vfio_ccw: implement a crw lock
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-10-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260725152705.3958100-10-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XXx-tp584rWDpP_V3jc9l8y41yP25M5Z
X-Proofpoint-ORIG-GUID: XXx-tp584rWDpP_V3jc9l8y41yP25M5Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE1OSBTYWx0ZWRfX6V57Sojp/ZNp
 rVg70FB5Kyw7g3D2XvNcK7FAYPt7nL9kj2n0H2++dEGVOscCwTJGaaWYqZngTf6Z79Wur57StyF
 vYqY6Vf0e7W3xgV/S4oUjwJ5XJAJFq24zkSGp0TuO200n04FhgTm5TfkgvYFL+MOA5N+2jdYEwo
 dgEv1Rg8AIqudCnI5Vl6nVhp86gHdx2ygwF84cuzRmK40OzRXoy0uuy1QyWq/HyPFAPmQTjRtJv
 MiVNerT6Fh9RigUPEYy+Zqe63CSnV0rRbzjy1I4aeL38f9q2eMDwMOyHuueYpXP6QxHzzlBr6s4
 4ufhgt7pvlt6awPoURQbjlESGmmxh0+p0Cy+vzcEGIgjnPuWYETIcL+Mdnqw4vE19U5o9ssnoOI
 Y6peERol7J2ml3oFgp/d5cUmF4VRUKPyabfwYgpUx1lz60pUiUYeuJWxnTqfZdddz/nEu3mrOw3
 ZsBdF6zo8QP1KntLZAQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a64ec67 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yrKzOalhxZC9lAfiQyUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE1OSBTYWx0ZWRfX2vt+x30+im3O
 ZQNx1RcuTawYpHaU9xexSy5Jky8JF2FPDTrY/I3unOnEr5cvZNrARm4EgwgATquEwEAqrS13AIn
 LiDcJOJBUG2dUjUdsK1Y7aJdJYT6hZY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607250159

On 7/25/26 11:27 AM, Eric Farman wrote:
> Unlike the channel_program struct, which covers synchronous I/O
> submissions and asynchronous interrupts, the CRW region relies
> exclusively on asynchronous events coming from hardware.
> 
> Implement a lock to manage the list of those payloads, to ensure
> they are read cohesively.
> 
> Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
> Cc: stable@vger.kernel.org
> Cc: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

...

> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -98,6 +98,8 @@ struct vfio_ccw_parent {
>   * @cp: channel program for the current I/O operation
>   * @irb: irb info received from interrupt
>   * @scsw: scsw info
> + * @crw_lock: serialization of CRW information

I would re-word this to say 'CRW list', to make it a bit more clear that
the lock does not protect crw_trigger at this time (as discussed in v3).

With that:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


> + * @crw: list of Channel Report Word elements
>   * @io_trigger: eventfd ctx for signaling userspace I/O results
>   * @crw_trigger: eventfd ctx for signaling userspace CRW information
>   * @req_trigger: eventfd ctx for signaling userspace to return device
> @@ -122,6 +124,8 @@ struct vfio_ccw_private {
>  
>  	struct irb		irb;
>  	union scsw		scsw;
> +
> +	spinlock_t		crw_lock;
>  	struct list_head	crw;
>  
>  	struct eventfd_ctx	*io_trigger;

