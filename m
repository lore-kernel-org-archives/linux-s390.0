Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46538B14B;
	Mon, 20 Jul 2026 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543778; cv=none; b=JGZRHKDNFOwc0DCgieKbqJ4HkpgLrCvZrUXck4kosE4+mERsp0WrhDuddesyX2RGMqQmSe3wUCmZ2LSiMSCHtEMrz+P4JOmwoeTc7JY9T2qC3Jonog64zbtKQLbeCjAJL71kGq2HrOMBJGbUBskt1HMvVmmgpMdskSGT9CkhDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543778; c=relaxed/simple;
	bh=BsLCYH02GJ/gnqgv6MBkCJOShh21LNQ0hfHEMr2WUZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GysN+aPX4ZsKnsNhs0sTe9BItGiEe5tBVgj+Yc1sWyL5BnUxePYBxmgXYdXhzhD8UkkpnaG2MZ+cMxyfEKz7g2E5QBldsG3j+q1oWUNGrpkkdfmfFr7njf+FAR+CY1StY99Qmzf7RMtcb6z8khy0NMaMVOQvo198BfWdn8mVb7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tNdQ/Xkp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tNdQ/Xkp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KACXak1907338;
	Mon, 20 Jul 2026 10:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WMwyx5
	BpMKft4UHPI3xqoV6kNxfeWpiR+ax5+EXgGbc=; b=tNdQ/XkpFkaoYfD967NdZ8
	H+VCxD3Xm924653MxjXxRDEvznOmCljjKmCsSXXqoW/pM4jtL0fp6FAtJGJRYQg9
	PiudK05XvyaVy7d0bBY1y1uxkevPm7Dzki2ErmqJLh0uelOxftz5o3SCsmyKCEiv
	uCWfFuA47QzJx6F3mrf7tD6zzSG32Urdek+0wnN8//dBo1ibCtjZ384lh0adL2m5
	w4nnF5eQMP5kk8hjU8v4Id63dMi8oFtVroxiu2Thw9txANku0RdWCOwn2Jo5xMaz
	u+7taBRF5Kepz5k0K6mAJtrrtad4OdQsGnxb612xXffk2eDJMJBcUKw5nScU8Pcw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab703a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:36:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAZ1Kl026889;
	Mon, 20 Jul 2026 10:36:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpwbk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:36:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAaALB11403724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:36:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A1CB2004F;
	Mon, 20 Jul 2026 10:36:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12B452004E;
	Mon, 20 Jul 2026 10:36:10 +0000 (GMT)
Received: from [9.111.21.55] (unknown [9.111.21.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:36:09 +0000 (GMT)
Message-ID: <6b40ec5c-4156-47cb-a815-f95ff0c57646@linux.ibm.com>
Date: Mon, 20 Jul 2026 12:36:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] s390/mm: Use goto statement in
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
 <20260720085834.898025-8-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260720085834.898025-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfX9bLH2UQdt4/W
 tFIzcgNRCu4pYhGNhfI+IIRTjPuOAfvTiRE9kA8d6hELDfwEv+gEyJd7JJF85p01f9/6JB1Jnbe
 LPgzB1HBvWHX4R2JDUOZIa9dE7o+C48AAj8xxkuB6sha9vzY1aiwpTLJt74rkT57gi4sY3WxYbJ
 nVRqGEK+DdZ26POWbyQ/yedPUrZv1SLmTjeiTEi6zl1Hc8/94JDBADN9tx/iOJ1p4C2sCQLV3JX
 1bJHOsaSZnvyf5TRY72cm2tMDKFTmWw6Q8kqTW6gC1hdwgRfpxSNCUowi8VbKOmuxOzlbWwWB91
 XccsmcK2mTSn+vGjJqPQMq01ZNHGQ53WlaL+1wG3H9DSz55pnmZPt6qGE5/bBGqohadR6cZ7TE8
 Sz+ssbzEOUTDfbDhmv6AQAo2VnEZfMdP2KFkE57K/mXpAZTzT4OQeNDskZn5YGVaMpYqsCO4WQl
 yxQKwwG/6DEmuFM8www==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5dfa1f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=PlptOBhbmMDRM6niCggA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZsM68WUnYfRvCxqVThA9JSRLViOEaiSd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfX1OHawTlNR4QT
 W48DBnLzxJiDaC4ia5zkP2xAa1xEytFG1K4pOqPX/Iz+QK/+QlwutSLzjVvg6ceQkLQGyUA76ZY
 kjf0mAS6+nmgiUv4Th6Fq11bbReZYS4=
X-Proofpoint-GUID: ZsM68WUnYfRvCxqVThA9JSRLViOEaiSd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200114



Am 20.07.26 um 10:58 schrieb Heiko Carstens:
> Make do_secure_storage_access() look more like the do_exception()
> by using a goto statement to get rid of an extra open coded
> mmap_read_unlock() call.
> 
> Just cosmetic, no functional change.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/mm/fault.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 2a9b9fb30d09..666fe8e99480 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -453,10 +453,8 @@ void do_secure_storage_access(struct pt_regs *regs)
>   		if (!vma)
>   			return handle_fault_error_nolock(regs, SEGV_MAPERR);
>   		folio = folio_walk_start(&fw, vma, addr, 0);
> -		if (!folio) {
> -			mmap_read_unlock(mm);
> -			return;
> -		}
> +		if (!folio)
> +			goto out;
>   		/* arch_make_folio_accessible() needs a raised refcount. */
>   		folio_get(folio);
>   		rc = arch_make_folio_accessible(folio);
> @@ -464,6 +462,7 @@ void do_secure_storage_access(struct pt_regs *regs)
>   		folio_walk_end(&fw, vma);
>   		if (rc)
>   			return handle_fault_error(regs, SEGV_ACCERR);
> +out:
>   		mmap_read_unlock(mm);
>   	}
>   }

