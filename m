Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853A1482E9;
	Thu,  8 Aug 2024 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111611; cv=none; b=toGCai4yeilgibImvYD8fBwkURcAEhtl8t58+NfdQSSPv5lIDToKE546cr5f4OWns8sjwRRvhp5jl+fo7F9P4EJTBRhCs3hv2e3lI3fV5eW8pemsiPmZEgbzio6sV//H3SSSblaX/5Z8PrldSgazmXhWUEuAEil9XeCHmdcTh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111611; c=relaxed/simple;
	bh=uKQ3e+rRipbc52EZ9/3ubN4gDzaoIHsFcfDD6xQ/S1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAJh5lm9SwAU3Hzjdu5QxQjv9nFpUg/pyOI5zu5vfZYe4sbSGRhdbWBatYTgwjLCxahA1TR5wEVYf1Mh+nqQYJ5qc2kX7QNbsy8zGqgq9CBIULRevqsJGxyuy7djaLwwsT6h3LTehvECOaCsEsZwZoASznLqh1K3CV4GF4omux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CZm4wM8v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CZm4wM8v"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4782fNrJ016194;
	Thu, 8 Aug 2024 10:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=y1zPW2qtS6K8ZiAt0cYh2AtCXW5
	MiQGck8fcLF0AWPA=; b=CZm4wM8vF+vLu4UtHmjXu6YNx85wgWZEKd4uT49Ml2n
	SEuEXU6P12/t76ra+zQxaf6Nn8XPStg1Lx9dlYZPba2o0YbnsjXHg4dCdvdemPuL
	zCLZ8xO0UbIUPqhYvytuaM1x3q8ybitpGTbs2hISicAjpPLqHau1AFyGBNY62jj4
	WQKEG2NVcG2EHb+PfuYT9t1FIpm6c3T3QLoFtaoOcS2f9KcLtuS98IVHLDi/iUF9
	FuDr7A3k3wfFkepqzULb+yCemqYeNV11i7LEXJc++OoOpjmw23BiB+TuxJt+4cAI
	qldimK8ki5k4cocyMiptyFpd6F9viZrrbIdebnmXWhg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uqcmvrta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 10:06:47 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 478A6kWL017511;
	Thu, 8 Aug 2024 10:06:46 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uqcmvrt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 10:06:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4789IVg3030238;
	Thu, 8 Aug 2024 10:06:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t1k3d9sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 10:06:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 478A6flS51904982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Aug 2024 10:06:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD28520074;
	Thu,  8 Aug 2024 10:06:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A90A520067;
	Thu,  8 Aug 2024 10:06:40 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.56.231])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Aug 2024 10:06:40 +0000 (GMT)
Date: Thu, 8 Aug 2024 12:06:38 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, rppt@kernel.org,
        akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_free_pages()
Message-ID: <ZrSYruB/Aa8+oBoZ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240808001415.6298-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808001415.6298-1-richard.weiyang@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QoRIWgoznaqXPJrGrCf_ad_2IXqdjEgp
X-Proofpoint-ORIG-GUID: D-c-bENEGnZt3vXfddoTRXf4D97jZCS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_10,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=910 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408080072

On Thu, Aug 08, 2024 at 12:14:13AM +0000, Wei Yang wrote:

Hi Wei,

...
> + * Return:
> + * An estimated number of free pages from memblock point of view.
> + */
> +unsigned long __init memblock_estimated_nr_free_pages(void)
> +{
> +	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
> +}

This could possibly be short on up to two pages due to lack of alignment.
The current uses are okay, but since you make it generic it probably matters.

Also, the returned value is not an estimation. Meaning the function name
is rather unfortunate AFAICT.

> +#define PHYS_PFN(x)	((unsigned long)((x) >> PAGE_SHIFT))

Thanks!
