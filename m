Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBAE1DF739
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418004; cv=none; b=jNmmKr3YagG/BTzw9/xpHz8Pa2uhd8eY7Vtpka2VN7G+Cq54jpCRBogunrA09HFBIwNV6Uis7aoMmajxGTZ3GJtjzE/aAfRTKazJAaNx1/EQgCi/SfE7KaCCo1EVBr1bfnjb9govrloS5go8tP6DZgw4IU0zdAGVtPy2qEwXQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418004; c=relaxed/simple;
	bh=AuNEUdipdTYXJa7mLVtF0r5uxPPPqxuQTPKOW566hKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS3BVSegvKPwfTgZcV3Fbdfht8p2TTvKKeyETCa962PUR7xHXL6Kh7ariOXKuV7gL4Ar70BSK/mdhShiiu/qq4s6+jBCYQBYhtf83b6EvbeWPK5h2Ec61ckFROJgXUtvjZ6Hv2nf2tXq72o0drcEJXHHlDGRcz67SjmZCDxMPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QNu8Tnxv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QNu8Tnxv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V8CJkr020806;
	Mon, 31 Mar 2025 10:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2etRd+XojnqWwYMOHcOzZpc6NWZZzr
	uBOnp7r8QkBaM=; b=QNu8TnxvSEEUuxM224JLRnkQFRekM6mo4lrsBfig+fule9
	gWFh+7k/DBCkoEZPKoOszxG3rf5avnkW+KhJ6mZTqqSTA8HvVWL73/fY08YRz6/l
	AI2H4TFPU5cfFSygVqhg/qc6qUVS3jbMRfLZqXboz2Uy8Mm1Ey9ysEY7ytK6oukl
	NFSqMAb7iipM6SYHsNc8eS+pisKCkGulRHfy7F5qCkQafFJC8+8KGu1/IAXil+fL
	S6KfaVyLJjqTfgK75IHge7tnCehwwT6QIUfqktjuLr+ovsS11BJ7i3VsFGZ6b+fL
	9nYzf1PuIVXNUsbzFQnzxiWYMXET7jUsKtyHbLsg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qd4q2ne4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 10:46:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52V6ZNr2005420;
	Mon, 31 Mar 2025 10:46:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pww254ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 10:46:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VAkZAX32703128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 10:46:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43BFE2004B;
	Mon, 31 Mar 2025 10:46:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB72520040;
	Mon, 31 Mar 2025 10:46:34 +0000 (GMT)
Received: from osiris (unknown [9.179.29.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Mar 2025 10:46:34 +0000 (GMT)
Date: Mon, 31 Mar 2025 12:46:33 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v3 03/21] s390/ap: Introduce ap message buffer pool
Message-ID: <20250331104633.25223C45-hca@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
 <20250327143941.45507-4-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327143941.45507-4-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3AURRGCw2xa5-4F8EyxPxkFxXQa21uvX
X-Proofpoint-ORIG-GUID: 3AURRGCw2xa5-4F8EyxPxkFxXQa21uvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 adultscore=0 mlxlogscore=580
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310074

On Thu, Mar 27, 2025 at 03:39:23PM +0100, Harald Freudenberger wrote:
> +/*
> + * There is a need for a do-not-allocate-memory path through the
> + * ap bus layer. When ap_init_apmsg() with use_mempool set to true

Please describe exactly what the need for this path is. The current
description leaves the question: "why exactly is this needed?". And
this may confuse future readers: is this still needed?

Does this depend on (atomic?) context? Or is it just to avoid I/O?
If so, why?

> +	/* create ap msg buffer memory pool */
> +	ap_msg_pool = mempool_create_kmalloc_pool(ap_msg_pool_min_items,
> +						  AP_DEFAULT_MAX_MSG_SIZE);
> +	if (IS_ERR(ap_msg_pool)) {
> +		ap_msg_pool = NULL;
> +		goto out;
> +	}

This is not correct. mempool_create_kmalloc_pool() returns NULL on error.
Furthermore rc is not initialized on error (out path); you need to
preinitialize rc to -ENOMEM.
