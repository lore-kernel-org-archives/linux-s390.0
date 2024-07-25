Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9A1741EF
	for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898661; cv=none; b=WRS9Xym+0Zg2MihWFgF7fxTN8Kyagpanh+KD7AZOAPBcgEqXA7WFLR0aG3eqcPhbiHjA4ikwnWXYmGQiOpex2ryuFmTM+dp6H9/gfzUuybUyI7hXbDqI2VNE0JGXDQM0HiodYpG/TOwWgmLZhx4HnMOK69fMTKo1cdE3fWqg68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898661; c=relaxed/simple;
	bh=FSh3hFJL6BqklUA0Dtjj2K0sCEC0fRxNaTnZ4l45HY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPAA8ikWIQf4/8rTxfBUykhnboHJVBeFaf7cm/ZMntB/xSCO4OEKUgVRPsxwE9HR7crALe3PdP5IjD5+FM5zvNX5PEGLSBoOn4npcGSPKEGb95uOFsKZLvxizt8d/gk73k2YWBuhyH+IJKQ2o3iu3K6Wa+23eAFmg09mcvTKM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B5/gBYl3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B5/gBYl3"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P911Ob030940
	for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 09:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=XeDFScjttdt2wYwBdRLFAFPSjVP
	mcxpCK7I2EC67NW8=; b=B5/gBYl3ECA07rJ0jI53cFxd2TbhQbslFt09mKn5njJ
	BHSMcJwqx0aU7yjf1lY2QBCovITKC8ksJMdQ0/beQPQPnw/cHNDSLGlWgfYlW7PZ
	XfHc4aRRycZGLp/CMBZmZjcIKMi+FNBi3XLTuskYMdvIilSuT1INSJ/RmReYlJGx
	XbyxqxqV1RzkXVcpSRQY4wTrwB77Lg/CjqjANiCuF973XHATpJo+2MnlEa4q1pnV
	VcxtHPw8KLaUHITVHnKouTXdF+aEgZ+0tFQ1cSiCtmDStLJLpREF4oA1pPwGi2XR
	KzD0UqanXusqZYVDw0mJS0C1W1tOaBBiVlEApbC9VUg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kdgx0wbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 09:10:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46P64n9q009111
	for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 09:10:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93nvds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2024 09:10:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46P9ApVS54002170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 09:10:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7A592004E;
	Thu, 25 Jul 2024 09:10:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EBF620040;
	Thu, 25 Jul 2024 09:10:51 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.38.250])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 25 Jul 2024 09:10:51 +0000 (GMT)
Date: Thu, 25 Jul 2024 11:10:49 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/ptdump: Add KMSAN page markers
Message-ID: <ZqIWmS8bBbFqAG1v@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240723124441.120044-1-iii@linux.ibm.com>
 <20240723124441.120044-3-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723124441.120044-3-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lrTGTaBCPcRQfjayMvVN3iKMuVDj2EAD
X-Proofpoint-GUID: lrTGTaBCPcRQfjayMvVN3iKMuVDj2EAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_09,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=613 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250058

On Tue, Jul 23, 2024 at 02:44:12PM +0200, Ilya Leoshkevich wrote:
> Add KMSAN vmalloc metadata areas to
> /sys/kernel/debug/kernel_page_tables. Example output:
> 
>     0x000003a95fff9000-0x000003a960000000        28K PTE I
>     ---[ vmalloc Area End ]---
>     ---[ Kmsan vmalloc Shadow Start ]---
>     0x000003a960000000-0x000003a960010000        64K PTE RW NX
>     [...]
>     0x000003d3dfff9000-0x000003d3e0000000        28K PTE I
>     ---[ Kmsan vmalloc Shadow End ]---
>     ---[ Kmsan vmalloc Origins Start ]---
>     0x000003d3e0000000-0x000003d3e0010000        64K PTE RW NX
>     [...]
>     0x000003fe5fff9000-0x000003fe60000000        28K PTE I
>     ---[ Kmsan vmalloc Origins End ]---
>     ---[ Kmsan Modules Shadow Start ]---
>     0x000003fe60000000-0x000003fe60001000         4K PTE RW NX
>     [...]
>     0x000003fe60100000-0x000003fee0000000      2047M PMD I
>     ---[ Kmsan Modules Shadow End ]---
>     ---[ Kmsan Modules Origins Start ]---
>     0x000003fee0000000-0x000003fee0001000         4K PTE RW NX
>     [...]
>     0x000003fee0100000-0x000003ff60000000      2047M PMD I
>     ---[ Kmsan Modules Origins End ]---
>     ---[ Modules Area Start ]---
>     0x000003ff60000000-0x000003ff60001000         4K PTE RO X
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/mm/dump_pagetables.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
