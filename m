Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449A342AF81;
	Fri,  7 Aug 2026 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102144; cv=none; b=iNhsIQiIEHQni+rbT+WXY8y9BCvYYXVBuEsJ3UqhVN4Zw+oUW6VnkNjH/MeZaqDFCNgfu2AWknC0To09C9IwDw2crW6DogHqICWVgRM/NoKPVEU/Mefi2taWBM8v/xwaMUYlfvKnhI0m8UqqnlHc9/MbWKRaawFycX1TY02drpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102144; c=relaxed/simple;
	bh=WmIfcCWMA7ULRRJ6kxGWz3Iuj9MfgiAf2MPpmGUBpbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPBr7+ShkipQxUVqPEMr4LJbEtwBNcRh92yzLxEk8cst2KAqoHSCS+NYgJAngUyCNGPVWvoGd7RjRFnCjXXWJKaad7YukjbPbTxuFSTAH5O58IPBiE0frNn8YtUJNWsSfi88v/eM4slyEpumPUcs5N+Hzg4FucgqSgjenw5k/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A7VKKKeX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A7VKKKeX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Huh44060714;
	Fri, 7 Aug 2026 11:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w+3dM6
	mWy93CNwdiDFte6LkLe0VGV4KAmqVwBqAFIqM=; b=A7VKKKeXnzaoKDeTJW1BCc
	qdtn6Ce+hqXexkhdp6OrWG8e5CqTxxdvkmU66sOnHBTQnN5zUkjrLqx0b2NtJeoU
	Hrdl92xU58sKtmLa98blsb5JKclo6h2/n5M1o8k4kTWI1mwVfkv/O8oNKbk/hVOK
	C0X66zii/6bnbcmQegny4i4s1CqB9qliz/kEevFqhHZGcJzQ/k2K5bD7bQTHqCjc
	n1txy7mdh6S/E9T2906gkYpStxddY3oYOZ21K72EUhXjTRSWI6seDJYcJHVuAVZT
	6vavwD3Rnzy+KamORYj8v8B5cn131Oo2reTvTZhnbDgLjxepmaisNjSoE88qrGKw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02bgwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:29:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BQMTe019996;
	Fri, 7 Aug 2026 11:28:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qyjyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:28:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BStOw37814722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:28:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDA052004B;
	Fri,  7 Aug 2026 11:28:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A71F820043;
	Fri,  7 Aug 2026 11:28:55 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  7 Aug 2026 11:28:55 +0000 (GMT)
Date: Fri, 7 Aug 2026 13:25:47 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven
 Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 5/6] KVM: s390: vsie: Assert crycb alignment in
 vsie_page
Message-ID: <20260807132547.3a4b7160@p-imbrenda>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-5-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
	<20260807-vsie-cleanup-202607-v1-5-b18659b55e3d@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75c17c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=kYesBGs7L6EJELLaMM0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX5QxEkV4Yhi5p
 YOEPZhu6xaIdmo2HXB5FRZPKb2+0Yk6KrO5/7f6N1WUdRu5uohOhhDnX8cIYoJoFRLBcxcQuiI1
 ys6qViVEgjMUewMVbkf7/c3DRJiDYgKRW1vaMw0ghmaT/pxos5xXlmzASEjzSh/Ym3YRJ6AJYgn
 5LOzrsk+0lD6SCHODGxNyDpBBP3zhP5fzkqddG4oTZZmLAH6jr3Qd0aBVsJVpLemJLEJVYm8zGS
 imU6knJem0SdX6MBYiu4K5moBNH8EAKywD7Bu5whZJml+7FGk4Og+fSmfv2m38GpVcZlqzAROyl
 yr+4ESK7IsIDpMIRI9xuk1pUl1uWvNyV15ps5dM0KCQjNf21x2qv5u6Klac1AQNlWaTL2Dw2dRn
 reYeI3NfPlpZIwh38uKDTtoglAb/9N9GFK3TTpmewYbij/TCNmO9O7z25H3OzmIiXOvndKZvPIE
 gyaykumseRkcK4NiXnA==
X-Proofpoint-ORIG-GUID: sgnTREmL4U1K99WpXnGRt2ekSNcBJg6A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX2kOSvjZUcf7J
 hkKO8tHuBGQ3a3oIf2LcJnVmhQok8S6WQXInsKYoz/6RWvUajqdKRsO4ZJqO17eOA9Vrk4gx/K3
 k6ZnD7cHUwnY+Yd/KMuXMLCD2nYOLfo=
X-Proofpoint-GUID: sgnTREmL4U1K99WpXnGRt2ekSNcBJg6A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070087

On Fri, 07 Aug 2026 11:57:46 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> The crypto control block address is required to have double word
> alignment.

I would add:

"Add a static_assert to enforce correct alignment."

> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 7c3b5e11b301..c9392460edca 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -69,6 +69,7 @@ struct vsie_page {
>  
>  static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
>  static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
> +static_assert(IS_ALIGNED(offsetof(struct vsie_page, crycb), 8));
>  
>  /* trigger a validity icpt for the given scb */
>  static int set_validity_icpt(struct kvm_s390_sie_block *scb,
> 

