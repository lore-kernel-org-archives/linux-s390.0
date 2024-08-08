Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959584A36;
	Thu,  8 Aug 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133451; cv=none; b=gtujtyHUrskVPKZ32ceAKIh7KYmS2Eza7G5Nhp7caLzVk2vN+9js5InLP27iDgKgUZhj9jP5XvJGXDuMAackWGeQ8R4CDBxbX8JFIZgKwquG54zFDLS4cTwN+RzsYlDL4o9jRWGwbi/WImuAfOXkrCbyMTnxvHFS0Xj4BUycuvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133451; c=relaxed/simple;
	bh=t3Eh3P81p7u2J1jD19hGT51qcAJhVxSMOMR3RVzxMmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4JW0oK5Raqk66vSs8X5KoJnngb+2OFNmVK4RkObCcOLnkj6aV0XNg+kcDMtbNZJQJ3UbrWOkUCGN2ueVR67iw6xUedZA+Kx5TTFPCfuL2W0upPG7GZAlmguQgDWGIaAZKmrS0aMWCLptEXUbiR8R2y69x4E87puEcdJCZcQxzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AaZ8lDqW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AaZ8lDqW"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478CaIS9024933;
	Thu, 8 Aug 2024 16:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=zIwRR2ClsX9LOSQZIlPTXaUS9gt
	aMzoDoSdw+VJqN/s=; b=AaZ8lDqWuPeVYa6azYSmbUt5+KRlb4WhBdVixNZlws+
	dbTNwPqKVCy3OsMqreBMGhIdL8hAl5PQPX9oSZHsirKcNk5okVxTGJAsK66j6/1G
	SpcOWYNq8adxKwfclQmzxXQ8qvjUkEJWxRktwaYanndZDEw8zLyw/p0RpAzbQC2j
	vAomBwfWkGCSxO35HD1P2wMFHXMWudSnpPFSB03NBd3Qb275mEyfygrON14hvxsS
	JEscr/ydOSS95X8ZKWeyxIm7uapKPCrfgkI31IZKLzEX9ZlNs1kM+dGTKQNXcSWB
	v7DkZZJsCxhmV0dz54cdbPU3gU/i+sPDBxckpYj7yKw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkbrm4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 16:10:34 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 478GAXLX012271;
	Thu, 8 Aug 2024 16:10:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkbrm4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 16:10:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 478EQlMp024322;
	Thu, 8 Aug 2024 16:10:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90yaab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 16:10:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 478GAQrx40829282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Aug 2024 16:10:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4942F20040;
	Thu,  8 Aug 2024 16:10:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07EF920067;
	Thu,  8 Aug 2024 16:10:26 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Aug 2024 16:10:25 +0000 (GMT)
Date: Thu, 8 Aug 2024 18:10:24 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, rppt@kernel.org,
        akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_free_pages()
Message-ID: <ZrTt8NLqaPpKBZKr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240808001415.6298-1-richard.weiyang@gmail.com>
 <ZrSYruB/Aa8+oBoZ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240808142405.ttlcfkximywtde6i@master>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808142405.ttlcfkximywtde6i@master>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I88Rgv0M3bv42Qfs8v2efCUYJ-hx4yuQ
X-Proofpoint-ORIG-GUID: lyNApa4Ov3JeXE1Hu1WbH0xjvn8aptV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_16,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=862 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080114

On Thu, Aug 08, 2024 at 02:24:05PM +0000, Wei Yang wrote:
> >> + * An estimated number of free pages from memblock point of view.
> >> + */
> >> +unsigned long __init memblock_estimated_nr_free_pages(void)
> >> +{
> >> +	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
> >> +}
> >
> >This could possibly be short on up to two pages due to lack of alignment.
> >The current uses are okay, but since you make it generic it probably matters.
> >
> 
> I don't follow, would you mind giving more detail?

memblock_estimated_nr_free_pages() returns number of pages, not bytes.
Yet, both memblock_phys_mem_size() and memblock_reserved_size() return
a value which is not aligned on PAGE_SIZE. Therefore, the result of
PHYS_PFN() applied to the difference between the two functions might
be short on one (two?) page(s).

> >Also, the returned value is not an estimation. Meaning the function name
> >is rather unfortunate AFAICT.
> 
> From my point of view, this is an estimation for two reasons:
> 
> * value from memblock_xxx is not page size aligned
> * reserved memory maybe released during boot stage
> 
> It is not that easy to get the exact number of free pages here. Do I miss
> something?

No, with this reasoning it makes sense to me.

> -- 
> Wei Yang
> Help you, Help me

Thank you for the clarification!
