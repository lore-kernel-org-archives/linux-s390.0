Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D6432861E;
	Tue, 21 Apr 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784609; cv=none; b=Fw0EP5BdUFqaQ5QgjM9+6kxruKrvv5PWarfxOXDSHc8g8DsEYxsu/h+69h4n6qSNXQKwRvUMh33h2PGOXjuDhUsKAlCqH2GmdczJaeBMSO7Jb25TPyXAQmRFsVeeZCBr6qdhK7rLtzwmRpvtSXP639KFHrNW4qMNG7FHuTtyLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784609; c=relaxed/simple;
	bh=I+6IJ6AiuN5AxoiIvjk/Rmz7QdK7La1Jj8MtXAtDFsI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=f1thApsTPeK+24y0RuCRS2ADlFAN1mvvK00rJUUje+6GuYWF3+FY4UmIbtBzP2gqaq2D6ZA2eJghbjdpASvFOZsuDigjI8x4MIw/c8gA77GEMJMbpgEqUXPcrsroCDb9j6DstxnaCk6m8OtVVctB+Lcy+LOmIre3He8uhbJydfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NjZaJQMG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NjZaJQMG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCTdRP1926174;
	Tue, 21 Apr 2026 15:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+Ktvn6
	hLgT3VWjoZvH0sb0AJI+Pyh/Xp3exuJbIqkBQ=; b=NjZaJQMGSqluP0rhvMBoJ5
	lYc+FciD0XYQxD8UVAE3Ix+GMg1XfX+X+VWP5Trjm/1HvPrJ4mJqOyNE+i6mvrvf
	Q+hYAWU+fHAo0m6kH6OVFwRKkXwR+WHw9qwHQAmDmt12L4KMpQVrGh2evxw9WWll
	pH3CR+tc6nXBk2tJGYUzDSlzKYxnKrzCLnFAhplJ8HbeXBR4PsDCbWLQAqM8oo58
	QLbx5WT1FQwTzoLfizXmd1d6Ac7XT6ty+kVwUJRhpGpQfVv6Ez65YmXCxbXhnzc+
	OEzGOgRz8SPhK74mqRidIqinNxEBXphBNq3w7zKm0SuCABFqqNcyHZFr2GB8Uq3g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf4ytq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 15:16:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LF5NR6000624;
	Tue, 21 Apr 2026 15:16:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9q1bqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 15:16:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LFGhtU42009012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 15:16:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 707AD20043;
	Tue, 21 Apr 2026 15:16:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DC2F20040;
	Tue, 21 Apr 2026 15:16:43 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 15:16:43 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 17:16:38 +0200
Message-Id: <DHYXKO2IPF13.1SJ3D8S49W7BZ@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <nrb@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH v2 2/4] lib: s390x: sie: Allocate
 physical guest memory via memalign
X-Mailer: aerc 0.21.0
References: <20260420084933.251244-1-frankja@linux.ibm.com>
 <20260420084933.251244-3-frankja@linux.ibm.com>
In-Reply-To: <20260420084933.251244-3-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MbXhIikD_Hn7XFKQIXP4f_Xhs9aWaTYn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfX0XQjnOlkABQT
 fZ44Cqn9iW+0MJQGzpH2ZxTx2gwoy5ReW4hwikbx+ak0JZXOGWgaY39nZbJQsaL7KrIHZPf4+jG
 0pD7VWnOMZoDmZ3PpSTW1keqryk9M9ZC0gbS0u2fpiemAcLaGeMFOWXJZoj1tnkoRfQd239v/9d
 cwivrLbiDOicHU03OypnsStGySlTAtFekuO4CCKj60j8l18cstdhX8LbRNsi+xRed2bwJdd3pUr
 gj6x9cxpse3cfvSN6fm9FlCyKRvPTGbzEpWzXLuoYt3VnSXC0VzEgIlGkpMMWw/FGo9bXwzRdtY
 5RaHyvL+ThSGeoVlkDUwwvi4ntteBIJhQcNwlNlq1v582b6nYzL+I2dzRVLKkvbwfx/f/5h1WrB
 GNdaGGNzBGu+eLzp16TGSBN9JTUbrXSAmBqCmC6b9Sa9yaa8to8YHe+7gJOUbZixzJt8gYjH2LL
 63CdSeFEI9WSIBgqIBQ==
X-Proofpoint-GUID: MbXhIikD_Hn7XFKQIXP4f_Xhs9aWaTYn
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e794df cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ffEQ_VCRwRa52qU5eVcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210148

On Mon Apr 20, 2026 at 10:44 AM CEST, Janosch Frank wrote:
> alloc_pages_flags() alignes the allocation on the same order as its
> requested size. Since we use virtual memory for SIE we can instead
> align to 1MB by using memalign() which is less wasteful.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/sie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
> index 47d4cdde..b1b0a8a0 100644
> --- a/lib/s390x/sie.c
> +++ b/lib/s390x/sie.c
> @@ -171,7 +171,8 @@ uint8_t *sie_guest_alloc(uint64_t guest_size)
>  	guest_virt =3D (uint8_t *)ALIGN(get_ram_size() + guest_counter * 4UL * =
SZ_1G, SZ_2G);
>  	guest_counter++;
> =20
> -	guest_phys =3D alloc_pages(get_order(guest_size) - 12);
> +	guest_phys =3D memalign_pages_flags(SZ_1M, guest_size, 0);

There is a const for that:

guest_phys =3D memalign_pages_flags(SZ_1M, guest_size, AREA_ANY);

> +	assert(guest_phys);
>  	/*
>  	 * Establish a new mapping of the guest memory so it can be 2GB aligned
>  	 * without actually requiring 2GB physical memory.

