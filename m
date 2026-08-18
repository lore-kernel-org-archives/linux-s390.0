Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AFB46D540;
	Tue, 18 Aug 2026 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059566; cv=none; b=on6xmj0hX4uw88Ef9rlZY78cjwHe1HpJOmJYoe1l3apHJaL2ARGXPwQnvKvmKackvrhRz+2faAjxaJgEkl/xSifDr8JkiBgpKjcEV2jCGiveqQqbfsk3pETY2fKYBSB9FZB3Rf057iPxIRH0Y+9Ts1PXhEZIcLxiCFTYVsKiJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059566; c=relaxed/simple;
	bh=lXpCTErAQKrJXdI0MEqxQfEh9tHIfoTCO6F6/I9afiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cq86TQIlgIrE0iNqbz0TicT8Z/A7LoKrKROJfUJ54LaS2rZgo5iR+n2Dt+TkCVme1/Q+vDomh8w56w1dnyvH4oKAqSin4K6nA2OppSGdmUqXtJrh9QlgHE1UlkIedOkBiMbboOIRrzclj6vDE1fqnKeJ1cSXDi7O09uQxVTbWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qw12gdIP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qw12gdIP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IAVX072355718;
	Tue, 18 Aug 2026 13:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cn351H
	Nbb/2D4FWZ1iLUzJEXYrNfcrRT4RkgY/qT16M=; b=Qw12gdIP3UKF9XWEOvfGy+
	jJil8QkZIJ1UR/AGTYaIOwHisc+clrPs6BoEVn4owZmww5grbJ2UXmLZZiptdysk
	wsLH0os2sr5bqogEV9B7CB5EYsO3ehQz5LOoCViCsnlE2RDaBhquP6YXW9UQ1mdS
	sYIygc4L0u5sz7zZz+uf/VhapDIY+xsd4GnDrO8v2d8MglOh3LEbsa1X+bqKIfmU
	NlsVVFk863rsr5KcDycPuQdaQqEgVJdSFHPCakMiqQ+emE4RzUDpxlJSFB6fK90p
	QGsNfgKPrM8BvqAZaoW9T5TqiQhuZFrfXPzzPL3PWNWHwg6PmhCOlvXURcmF5O7w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqrdab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 13:26:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ICuIY8025785;
	Tue, 18 Aug 2026 13:26:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngb6df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 13:26:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IDQ1jn25428496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 13:26:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C0AB5805C;
	Tue, 18 Aug 2026 13:26:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E8A358051;
	Tue, 18 Aug 2026 13:26:00 +0000 (GMT)
Received: from [9.61.131.241] (unknown [9.61.131.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 13:26:00 +0000 (GMT)
Message-ID: <2bb8cf48-2dcf-4457-86ad-f1424d9ae28b@linux.ibm.com>
Date: Tue, 18 Aug 2026 09:26:00 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-2-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260814163355.227191-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5NiBTYWx0ZWRfXyIRMMkiyjn+z
 H/hy7m+lb8UqyE840lmVz8smtqui9WNvcMTwi8fzdM+gBWzMtPQgIx7xxj+0AwKBsUQM4YL7T+E
 K31BqwX9nwPlSZsapPtZ8rJtI0javohv4K1+0o2V2jEnwN5S5Y8e3SVLs6BM7z4riQs/V4B/lRW
 pqCdF+2Tq9fupKmnjHdfzwwM3bQYSLIcAaeyj6py7H5SPYCW8TKNq2EEl0JlSohICKYive+aDve
 UBuY2u/D45E7rxC78aKYJ80LgecLNwKlLWjdHoTnzy3qJO+g0/KYc8wyL9f7N6K8lfoj3n0+rJb
 EE8WyGC3tFgMYS5jVQGcqncwIfIaKaTpTllcsRtU/cBRrfjo0kQtf/afhxh61wbJ/kVqMvBeMS0
 vjwEm+4bqvAJ0xzXjvI1hdOabKrokDZ4oqn0KaE+IoxRy/+jcBbvHll1chOpUS53nckxN3dZy1d
 pHM9+TOrmVHL9/53TbQ==
X-Proofpoint-ORIG-GUID: tfpDPVyrPTD5DPUzgc4BCT_cIdpRQWDu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5NiBTYWx0ZWRfXwKXgxSXhZTh7
 fwvPhskMhvUQQUKUXH+fUtGJVtNZympYoyILdaL2gwBm9WFUtLJdSmepPXZ6aukTQhgVmnLOUOM
 h6awav4ff8M7F0qHDTKC+rLAJ/Xq5hk=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a845d6b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=ttbNLuTc0CewZQEAKyMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tfpDPVyrPTD5DPUzgc4BCT_cIdpRQWDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180096

On 8/14/26 12:33 PM, Claudio Imbrenda wrote:
> When the indicator and/or summary bits are set in the guest, the
> accessed page was only marked dirty in KVM if the access was performed
> using the slow path; accesses through the new kvm_arch_set_irq_inatomic
> fast inject path would not mark the page as dirty.
> 
> Fix by adding/moving the missing calls to mark_page_dirty(). Note that
> for the inatomic path set_page_dirty{,_lock}() is not needed as the
> page stays pinned; the unpin path correctly marks it as dirty.
> 
> Opportunistically reorder the local variables to be in reverse
> Christmas tree order and refactor to use guard().
> 
> Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use mapped pages")

So I'm not strictly opposed to adding the dirtying on the 'fast path'
but AFAIU the idea here was to still mark the page as dirty right before
unpin.

Is it strictly required to dirty the page every time it's touched even
if it's long-term pinned, so long as we make sure to mark the page dirty
before we eventually unpin it?

I think the answer to that dictates whether this is a fix or not (or if
there was a missing path that failed to mark the page dirty)

Thanks,
Matt


