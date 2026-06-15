Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A093A40757F;
	Mon, 15 Jun 2026 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539442; cv=none; b=pH6wDZJmU/8BsGBmeeqYZNSRjufQVydeBWqhHkNhrb/9mihu1GtAIgg/ek/aJHhJoYgdGO2RiXChVL+G7pPJunVvD1VbiFJDTRvwDfYerfGFI39Prge6Y4k4J8apWYlfJW/2DOPD2YwrLTumXbbVeszasnGweDi8R4KKc6AD14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539442; c=relaxed/simple;
	bh=qa13kamCNEt6QnqDLVLn0mOvLn6jtv/7BMgesqoQOG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGyo90iRN+crekYtUvXUZRFahIpmpTM9CULfzdJzY27V9MBpq0SWoSMNXRm8nFU7HnjPPXDncRqUvZJ/UVqglE+uAkSrVb+egztD2GbOvTfWNzmmfxJH1JaQBsXx3ahjq906Z4fBuMoMR84jxc37/RnVDChd0mJsQf4hq3P2BCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SWZtPDpZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SWZtPDpZ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFmlZd2851859;
	Mon, 15 Jun 2026 16:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=oTFkH6ZWPihDfV6+W1YSDxgP9pPMSV
	z6nEgyt3zR7BQ=; b=SWZtPDpZpD+hQCEEVIBfl0IMIAmBPQulv0+YvtTr8l9/y1
	CYYN6rCNlHaRURsOhsT28JZ32ct0GJDeqTdCO4blxv2g/7qdCkc51nRFsOX6Zbsn
	pwQjV6qhjW0oA3ODjQeVGAHqp71WHvsLgvZMwZLBN0dT2pDdx37tydM/BTWOkRBB
	7RZHzVawZMAni3hljKkB2DvIMLPkDZPFuU9XA+aUHlqSaFSeoeiguA72dQUFiDxu
	Ck6G+fPpwDKzNwYV4Bbu8bJhs1Uqs9DZA9ZIURe0jPIAJxIACtulh8K2hJh8uRUb
	k2yiTVvjv/sRgwIjLoRzu9NRFCmKjy6skOaJEJVQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm1e2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 16:03:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FFo6BF000896;
	Mon, 15 Jun 2026 16:03:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg74c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 16:03:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FG3h2U29884974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 16:03:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C688A2004B;
	Mon, 15 Jun 2026 16:03:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90B5420043;
	Mon, 15 Jun 2026 16:03:43 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jun 2026 16:03:43 +0000 (GMT)
Date: Mon, 15 Jun 2026 18:03:42 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        svens@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Message-ID: <8410d3bb-3f51-4599-b80a-5b6c38178c36-agordeev@linux.ibm.com>
References: <20260615091741.76724-1-imbrenda@linux.ibm.com>
 <20260615091741.76724-2-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615091741.76724-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfX7irPc9/6BAzE
 nIqtQmrAKRuhFqh2AmXrmw7mthA59G/RlagbozJn7mQ0xiMbWIN1Qf6lxUjW3DIMUv5A1c/HAzg
 5sthJXT3N4+fJSN6K5KZj1nM88/lagg=
X-Proofpoint-GUID: 2kqLxzkoDvXVGmpOaoYeBZxaHNnAWkNM
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a302264 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=QAE54Fg8MHlRZdcWp2kA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfXymOXDJoyF1S5
 P4HIFL7CVY/lkg7K4XDLP5wMECXzTDq7rdHHpYJ5CDE1dpRi8sbYDlkGY5Smye/H7ixKLRtEH/v
 co+Zi6dat4QZO3X/QqG6HFgsMZSazRfgW9oVfGNASe/BrWmmsyC/XAqJJ+U+W+dtwlJSk8yjt6j
 6Ps8Q06r1WsPCn3IbhYpCjcj0yneTBsqbIc0q8n424QdMAN10+kQz9oLcKpdefYx6MzbhBPVcAc
 KxG0jSRKex7ln5b07kELKlNL+kUJ4+Nrp9V1u262KEZPOu9qMVXS00xRPfvC90BLc1qKWwy6mMW
 mB4UCri+kzLAF8lK0gRgXkn5qKgAsPVJjI7A4sKOP5aGwHEdqhMIrmrgHzyGtHBw39wzthMZIRg
 9PWyzr3nFa3ZKHCyJJmDYDJ4VF4PyyOsoTWTiUDNSBvkcKcQlwNsifCadfrtwEIJs4x4aEw9FRt
 kEqtPqCMjFYLe3vNdNA==
X-Proofpoint-ORIG-GUID: 2kqLxzkoDvXVGmpOaoYeBZxaHNnAWkNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150167

On Mon, Jun 15, 2026 at 11:17:41AM +0200, Claudio Imbrenda wrote:
> @@ -122,6 +122,8 @@ pte_t ptep_xchg_direct(struct mm_struct *mm, unsigned long addr,
>  
>  	preempt_disable();
>  	old = ptep_flush_direct(mm, addr, ptep, 1);
> +	if (pte_present(new))
> +		new = clear_pte_bit(new, __pgprot(_PAGE_UNUSED));

Why not before preempt_disable()?

>  	set_pte(ptep, new);
>  	preempt_enable();
>  	return old;
> @@ -160,6 +162,8 @@ pte_t ptep_xchg_lazy(struct mm_struct *mm, unsigned long addr,
>  
>  	preempt_disable();
>  	old = ptep_flush_lazy(mm, addr, ptep, 1);
> +	if (pte_present(new))
> +		new = clear_pte_bit(new, __pgprot(_PAGE_UNUSED));

Same here.

>  	set_pte(ptep, new);
>  	preempt_enable();
>  	return old;
