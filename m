Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF042B326;
	Fri, 24 Jul 2026 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896142; cv=none; b=XvNwEXZJ3pLPoT5+V/sJTHfHP38XO5klWomOSfk2hVzab5JeXPrmU2a5sdXkG3kt05/w4sHUGjhgGcKLL+IrfIgn+4L6q7lrDdRsjMJDFSJCbBc58fT/0lKZaNrQ+N4sK9P9YyxD153Q2fZ+U2oV8NIpmScsCwluq5Sgd+Ccqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896142; c=relaxed/simple;
	bh=HInUqhRZnz6YbDuhfsJTq5qhNsYtH104RAsxn4iSmB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEAK1zqEtvH6Es7RwIn8vdWHaIjW0wrgY+RmqtgPrAF7QbXU/ho35MLpZaOnleFWq8YdV97ZEExDhbgowdroFUNT+UgGVOHrBGkpQjxUEklOdtV900aKuwXODsesdqxAClUI+HbBWs6uVAT99ia5MKMB6S4vhchOynkKAsh1jug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KZDSYTyx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KZDSYTyx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OCCjuP1675635;
	Fri, 24 Jul 2026 12:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DOelgf/YdTj+9W1MazLSPqj9mZwbsA
	TbSM0uzDeUgN8=; b=KZDSYTyxxnBPn7g+MNP39ATEvAhZeyqS4mWIu3x5cCfFUJ
	V13r53mco8t8ootv0mL1BiGptHMabCs1fZLbelMVWHoiKSAz+OcbzvQh5PUzqfCS
	otoctr1clHHVVlbj6eSGyr54B6LXzD7A7RFQmsm3QXNDuWdGhdD/iBY/Vrh+vUpZ
	6VowpOvJVzFB4uvV1TU/Z/739hMY8vsGTNXHpPC+9VsiRFuplX+xQCPZomkN3EV4
	2jC7eUzplqp+xX4lC4jI9OK7TZBUFrfSR+aITTU7iONhtnlxgcMlLQvFK+IiQwFP
	t+HihEKAi5/e0np9lN7UECKen06xPacTWeZs2Zlg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gkx1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:28:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OCJhXg017426;
	Fri, 24 Jul 2026 12:28:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk8u71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:28:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OCSpvv53608736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 12:28:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48F1A2011F;
	Fri, 24 Jul 2026 12:09:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC84A20119;
	Fri, 24 Jul 2026 12:09:33 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.82.156])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 12:09:33 +0000 (GMT)
Date: Fri, 24 Jul 2026 14:09:32 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Add missing vm_start <= addr check to
 do_secure_storage_access()
Message-ID: <d7022700-114e-4aa7-ac56-5b805f700daf-agordeev@linux.ibm.com>
References: <20260717131407.855327-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717131407.855327-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExMSBTYWx0ZWRfX59VfqMp7/9DT
 CU2HuLTQLLUlciDsmZenDGwHkRyVCFx5kZiGIr7Pu97v8PjydTf4vsnXPKJmWgXyxNMhW/QeDUy
 XHnOIZIU11DRTvz68MecMBYZ7ua1XP35i6Ixcwq6ehtI9waXX9i7Ea3p07IPqRYu4QZ0rKkLJsH
 rgfyl+lT2g1XmlpXYHhZoOEmBUdfJnJkBwVd9HIGdUUqvMeMWwuDnQiIO1+w3XlopoIDa/0Z3KA
 cEU2SfgMVgMJlrYELOayeMQnkzNN4ZmD26lSZLJwnvPjlUS7eFdefZ06ra+B0+7dCG0uItxZYxA
 N5v9DbDnDX1tNfGguoSRTPkfSjECkYwdgyDz9jetUFCUtomalOon+rCP++eLKGpK8kFb6Zi/Vuw
 tyl6IYPjhqhrmm6K+LJwOJdbFx2WKpQY6Mu2YbmIZKeeDw7vNaHKFRLT4Q5fwnIgZyka6dLrwRG
 T/KPGGF7L/ErndR3pOQ==
X-Proofpoint-GUID: yVGRFIHnq-16nK-DS-Zqz6tPznwOmfnB
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a635a87 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=hfyX7dS27Qm1KjPdzpkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExMSBTYWx0ZWRfX2Kejb1Mo/jJn
 n9Iv1AKTUS1g3I3C1/pwMftrHcPJzk25AnfFliaXVY6+00Ekql1HwejJfPWORj2oOXfMy7xrbag
 J3KxL2rJUneExqty6HXmDeO0yHLJgl4=
X-Proofpoint-ORIG-GUID: yVGRFIHnq-16nK-DS-Zqz6tPznwOmfnB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240111

On Fri, Jul 17, 2026 at 03:14:07PM +0200, Heiko Carstens wrote:
> do_secure_storage_access() uses find_vma() without verifying that the
> faulting address is within the returned vma. Add this missing check by
> converting to lock_mm_and_find_vma().
> 
> This is not a critical fix, since the worst that could happen is
> WARN_ON_ONCE() in folio_walk_start().
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260717093904.E4A421F00A3E@smtp.kernel.org/
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/mm/fault.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 028aeb9c48d6..d6c58d78edc5 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -456,10 +456,9 @@ void do_secure_storage_access(struct pt_regs *regs)
>  		if (faulthandler_disabled())
>  			return handle_fault_error_nolock(regs, 0);
>  		mm = current->mm;
> -		mmap_read_lock(mm);
> -		vma = find_vma(mm, addr);
> +		vma = lock_mm_and_find_vma(mm, addr, regs);
>  		if (!vma)
> -			return handle_fault_error(regs, SEGV_MAPERR);
> +			return handle_fault_error_nolock(regs, SEGV_MAPERR);
>  		folio = folio_walk_start(&fw, vma, addr, 0);
>  		if (!folio) {
>  			mmap_read_unlock(mm);

The Sashiko feedback looks like a false positive to me.

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
