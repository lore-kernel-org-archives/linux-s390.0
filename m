Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444F94A49BE;
	Wed, 16 Sep 2026 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550869; cv=none; b=XEZK3FVoWZMRM5m9G878AgOvYWdzS7wGwV9iS8RWmhRnYWD79jORJ0Cfrg8fu8EEsnO+IMveGqvgPtpYFHasZQUl1bhPH65tRKlBtxQ7+zIOL4bW+qeTtr5j02tImkiTPnkl8+VOUmetxTxpJrrgQbqZ55yNJe9YJ4uPddEpg+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550869; c=relaxed/simple;
	bh=W4UePgnVhIW1C7rPY4HPg6gmXrt5WfYqARgAjWDy2nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZG18uzMczdBINog03zoc0ZHmaCBtSXdScTk3Ia7T97i/Ap+SGVuo6xqytnYF05hQFiZ/2pQISF4gHJanuOIx3EQ7vY0V30mdT2Ivg2UG4ym5nAlW0Gomm4QMHIYqYVPjSckfyyZfwti9G8iZq3Uii5zEJQWOlHwGM2VXTOiO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RUzpbz8Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RUzpbz8Y"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLW5W91806375;
	Wed, 16 Sep 2026 09:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2/3jT32KmSfKpWdIJD3/VNO8qiz+e7
	Q3XqDSL2uo5is=; b=RUzpbz8YZ8dmoapigdBVgcIdHZcQoMTpLGiLc6gBzIIVPK
	v3SD78t8WXI4WIhko8iwi/myapHcDILEhB5pym4TTweV7MnK0Bw9j2WVNYLSgPtU
	mx3NMaj/l+lls/DLFl+JNSeWL+k5W8FOdkJKKtnfHyGJR1vf9soaNWZDqeeLmqiN
	CU4Y5JZ3TVMB+IT5Ih9togOTHBw4XOMxmHGGzBM805fAnIPpgs/zVB4/tw1ESWIh
	mkBdXmW4KnB/HxI3/kXfeLO4d0vGpYOvb40ciaTGyqYj2s1RqZ5adeCWHCrzO7Ra
	RTWSJ5M4VoZn7XBrUzmsZDSBaTe12P0CNlcOskNg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5huq9d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 09:27:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68G7Wcml1354827;
	Wed, 16 Sep 2026 09:27:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d65wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 09:27:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68G9RM0Z31064636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 09:27:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92C7E20043;
	Wed, 16 Sep 2026 09:27:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F45320040;
	Wed, 16 Sep 2026 09:27:22 +0000 (GMT)
Received: from osiris (unknown [9.111.77.138])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Sep 2026 09:27:22 +0000 (GMT)
Date: Wed, 16 Sep 2026 11:27:20 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 11/13] s390/qdio_setup: Use kzalloc() for the storage
 list
Message-ID: <20260916092720.15587B52-hca@linux.ibm.com>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-11-e931086fdde1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-s390-cio-ready-v2-11-e931086fdde1@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfX3EfgxXjPBT5o
 BBUjfOoIbHpPqoaIMHP7eooh33xckQldVv2ACcxJptWGjGm072Wf2o8f+AQMtzoHo8t+AfDN/Je
 jJePbNj379FOrKCNLjNGz4iAIrLUGd8gmTNXewHn+8BqjnudqCUcKQM+uYlllLJMKssGOha69eT
 6DA8YUTD8KOrcnwAfPEGZwHO7yig3iJRxtpAF9wBtcmRpBN9O/Rh8NxbYw1qYrLQsFwRX+xQXos
 UKS2wfjfim8TucXX7kUz9WjvC5HZBVM+3RHOaNi8G97dHZS1sFNV7Z+iLN0gxGADILdqEN/s+up
 aNnMjFvwRBF+767uSltCBStRsIYztL0kaWeHJwCkI0J6Z3Gy3eG2B4O8Va9DMJNV2Iw4tbDZr4j
 VTui0MD9SH32Vc+4rI8luLcZzaDvAfeXTzWAuhVQtxY3p/gGHleYBURkxYY1vbtdQbguZRDj15v
 +eE4tpocfE3IEJ9yVqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfX/spbEafXLIZk
 qPDrbpGZsKtGMKS2mpEw43VfY8k44CX7phBrfDUXkE3Si507jeJO9y5LjMxsKaMefZnkR1++19z
 /vbLROzXSS1WOe0ZmMFv0u/su7dOUXE=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aaa60ff cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=qeVUGtoKjQMzvgjGzkwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: fUUTaSIfwXODyVtJLznONvEXRuGwHtSo
X-Proofpoint-GUID: fUUTaSIfwXODyVtJLznONvEXRuGwHtSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160116

On Thu, Sep 10, 2026 at 02:00:13PM +0300, Mike Rapoport (Microsoft) wrote:
> __qdio_allocate_qs() allocates the storage list information block of a
> queue.
> 
> This memory can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
...
> @@ -109,7 +109,7 @@ static int __qdio_allocate_qs(struct qdio_q **irq_ptr_qs, int nr_queues)
>  			return -ENOMEM;
>  		}
>  
> -		q->sl_page = (void *)__get_free_page(GFP_KERNEL);
> +		q->sl_page = kzalloc(PAGE_SIZE, GFP_KERNEL);
>  		if (!q->sl_page) {

Speaking about unnecessary changes: why is this a conversion to
kzalloc() instead of kmalloc()?
