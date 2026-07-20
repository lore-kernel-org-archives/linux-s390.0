Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C53DD538;
	Mon, 20 Jul 2026 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544371; cv=none; b=l7jHmsTtEX/yKH8QRqJ/Es6RFxFF2Pjb6q7KprzdY4QYzKzginteOB7HjwEtD8eH1fcJQA+d2c1i0gAJ4uF3iyXo0XDRjTkExV5Gw1bVYQfNZzE9NqpO3Zjd6URp9CN3H5YmJC388aPIdBADqqy+O6uojyPmzsCAUtacX7nODF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544371; c=relaxed/simple;
	bh=fz6Drkdwv8gXwfzNbN1LY9qbUlQfMKevAWLWhuyU9CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEd4jYUPYFWD7VxZnIej1rpRCWR6eI6goSriMfO1AzkYIfIlQ8ABffrikFwC94MWC6LP8l2PbSzNdueXlR5bHxKf88kRbCLe8mGejLc1fdslDk21uJlTgmu+0JZL8y1sKK1RK2LFfMhbdyDJiiGiWIhbbZ1TlsfGA/LOTiP1hTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RDyaKIc1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RDyaKIc1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABd8Z1811243;
	Mon, 20 Jul 2026 10:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bmXQH1
	6o6c8a6SRpl5d4CZoleVpfFSP+00UXuT9uJt8=; b=RDyaKIc1G0JDDWXrqwetT9
	gWD2arBSIkNax6UxfnWJy83kH82/2DkdCXKVJt777jKvKmoDLckGaxhmbQiJnOZX
	gDOQlT/i7LJsFJGoqNNSrCGg9CtkfQe6VBcQCtfU56S5C4tyZxYOvf8qT/9IB+D/
	uDOrqWDwf0euPHG0PWLDjR0kijwWWYyBYTH102wYDgqMUn/5G3YTk5bWLHR2XRMd
	K1tnH18ihNhZkEFivUZ0A8vFHB1GMMYad7LBE9tcytq4GtKbdymxOaPy+5/cr4As
	x/WukK0pDmrANepI6XawLZRvZQA5UqCHxDv+mipQLrWOIoy5TNs/Rai30mxzqsWQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fxrhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:46:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAYclP026284;
	Mon, 20 Jul 2026 10:46:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy4wuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAjuVv53018914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:45:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5350720043;
	Mon, 20 Jul 2026 10:45:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCDFB2004B;
	Mon, 20 Jul 2026 10:45:55 +0000 (GMT)
Received: from [9.111.21.55] (unknown [9.111.21.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:45:55 +0000 (GMT)
Message-ID: <1365e423-89aa-4eeb-97bd-d5c2317cad3a@linux.ibm.com>
Date: Mon, 20 Jul 2026 12:45:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] s390/mm: Use lock_mm_and_find_vma() in
 do_secure_storage_access()
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-4-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260720085834.898025-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX74G1WHfcnkqa
 g+Lnr5x9CleWlCbWCt/nzY/h0coJQswQ/c1L/zQZ1j0Tt2OSYhaCVZFR1V650ogGY5Mb3N9td4h
 lwozt6nOMFtnHa+8fTNhxwj0HVfvIzqHXNONwDZjRz16RrbGX4FPkA1aEtVUpNtJ2syIMtuuEvI
 Z7hSKXKB2n9ELa8p6NPe2tj4mV8O00z6WFv/09/B5oVLqKd1VAtIWXhKWZm6ykajyISSCoUf912
 0vrwP0paE9TTSW9EFrSQmhPqcjE/PHcjUpsdIZSRK3Nik+AQm3lMROe1Z8Pb+VOb6D5y+iUqiDZ
 2ljJjHVd10v3vyJcvxurhNqBnLrzoXDBubwxaeLHQL5GAd5YOcGwEMXHzyBH5lOBQyM9zH5u+XS
 Cc+zQQMepZyoDD83224TZ/NGbejHgN8z5IJ9FlBU4JVg2K9IN04r9/ZyAyrsvCrPeVA6SEeUJnG
 wuhMW3LYj8YYW59N/4w==
X-Proofpoint-GUID: 918gR6G_1NsFLDeuaESSyXViyZP1JMmk
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5dfc68 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=erYjzpU186MQmpMAmsMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX+vkDQ/tePRhN
 fHDReAiXG+RPp+DakfgjBjogiDQJ91vV5oCZk2tB+H+jHKDQDQATfgdAoguzTfl5Mfk6RMP/gCy
 HM4KvLIyqYVTAZrEE915I4VYAlnqfC0=
X-Proofpoint-ORIG-GUID: 918gR6G_1NsFLDeuaESSyXViyZP1JMmk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200119


Am 20.07.26 um 10:58 schrieb Heiko Carstens:
> do_secure_storage_access() uses find_vma() without verifying that the
> faulting address is within the returned vma. Add this missing check by
> converting to lock_mm_and_find_vma().
> 
> This is not a critical fix, since the worst that could happen is a
> WARN_ON_ONCE() in folio_walk_start().
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260717093904.E4A421F00A3E@smtp.kernel.org/
> Link: https://lore.kernel.org/all/20260717093904.E4A421F00A3E@smtp.kernel.org/
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/mm/fault.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 2839d7a64401..f150d97cac2e 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -455,10 +455,9 @@ void do_secure_storage_access(struct pt_regs *regs)
>   	} else {
>   		if (faulthandler_disabled() || !mm)
>   			return handle_fault_error_nolock(regs, 0);
> -		mmap_read_lock(mm);
> -		vma = find_vma(mm, addr);
> +		vma = lock_mm_and_find_vma(mm, addr, regs);
>   		if (!vma)
> -			return handle_fault_error(regs, SEGV_MAPERR);
> +			return handle_fault_error_nolock(regs, SEGV_MAPERR);
>   		folio = folio_walk_start(&fw, vma, addr, 0);
>   		if (!folio) {
>   			mmap_read_unlock(mm);

