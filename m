Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516324C67A;
	Fri, 21 Feb 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740178452; cv=none; b=QMykVQPeCfPRSSkjm05HPp6eRyGklvxpVBPSbgR02+HL+YjI4xfPp5w/zrEzG3jHsSW2GzZhhYVRLMAEXC483JbZ1F0tBTCD4CFy8m64OYaSPMxaO8+ts9vyW2FsJdbfkC4adZLKtjpqHir4GMCwLXtC2HRxlUhHkEBXtASF4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740178452; c=relaxed/simple;
	bh=eI4S9v5YQ1PflURECvTI2csLt60QaAtzmByL5uaBAK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+VOWQaU0cEiLCyNoyj6JhJgRUD620HqIdB1Xt9kUmp9Gvbc0/34b9inldF7ZMSayJErqk9e2yg/JaAgLEi4WAZs7gVSG9LHmpQBUzurjbhRMpNNey/eWGn9rQpYjr1yCKkz2Bgt4B/vGcB2KRLCgWgVDYRkL7KRele0NnjNSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WpDbNkrm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WpDbNkrm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIMtpW032172;
	Fri, 21 Feb 2025 22:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AApoA5LT2pOBlSaVwbegtYHGFdF4gh
	7t5yNn4T21+Ng=; b=WpDbNkrm0h413Ty0WK4/xDKod0Cd03LcHYLAnmKQGQKqax
	/n8CITDNGsHXjDNzGsu8ByiJgPPDMjIogqvc+I9c4zaN3jJ87ZAQo48j4H3O7k7O
	hwnEw6N2A/L7kq8s/P74zBdGiDTXNegbGiGA5nSETP0hDv6RReuyrRmtRrvFS8YW
	PJHw0duerhVveh4xBNmX0I69vIJ1Dqs5D+Z/EFsT2pvuoMcXaRCcfYDtYXObr8Hb
	pcdGkvghSVXM7hbcCffKtIlZMnTx3wZ48/vujYfJDpHrEIRt7SnkUlzWYiYXvaSa
	h27tlQJ4a7U9GsflPEctz8+JFnRK0x1zXpQGyUgQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xgb0dex8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 22:54:08 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51LMrw2X027218;
	Fri, 21 Feb 2025 22:54:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xgb0dex5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 22:54:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LMgbJP029303;
	Fri, 21 Feb 2025 22:54:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024tjq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 22:54:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LMs2MH54788566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 22:54:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0112B20040;
	Fri, 21 Feb 2025 22:54:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 686BE20043;
	Fri, 21 Feb 2025 22:54:01 +0000 (GMT)
Received: from localhost (unknown [9.171.80.218])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Feb 2025 22:54:01 +0000 (GMT)
Date: Fri, 21 Feb 2025 23:53:59 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schwidefsky@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] s390/sclp: Add check for get_zeroed_page()
Message-ID: <your-ad-here.call-01740178439-ext-9536@work.hours>
References: <20250218025216.2421548-1-haoxiang_li2024@163.com>
 <20250221151157.11661C33-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221151157.11661C33-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uyfsQj4h4Lv8spJFyg7i5yE1xPES5nLl
X-Proofpoint-ORIG-GUID: CEv_H1_UzSCmiSMwDE50TrePTHtYvKbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=465
 malwarescore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210153

On Fri, Feb 21, 2025 at 04:11:57PM +0100, Heiko Carstens wrote:
> On Tue, Feb 18, 2025 at 10:52:16AM +0800, Haoxiang Li wrote:
> > Add check for the return value of get_zeroed_page() in
> > sclp_console_init() to prevent null pointer dereference.
> > Furthermore, to solve the memory leak caused by the loop
> > allocation, add a free helper to do the free job.
> > 
> > Fixes: 4c8f4794b61e ("[S390] sclp console: convert from bootmem to slab")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> > ---
> > Changes in v2:
> > - Add a free helper to solve the memory leak caused by loop allocation.
> > - Thanks Heiko! I realized that v1 patch overlooked a potential memory leak.
> > After consideration, I choose to do the full exercise. I noticed a similar
> > handling in [1], following that handling I submit this v2 patch. Thanks again!
> > 
> > Reference link:
> > [1]https://github.com/torvalds/linux/blob/master/drivers/s390/char/sclp_vt220.c#L699
> > ---
> >  drivers/s390/char/sclp_con.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> 
> Ok, but this should come without Fixes and Cc stable, since in real life this
> code will never be executed. It is just to make the code look saner, and to
> avoid that more people look into this in the future.
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Applied, thank you!
