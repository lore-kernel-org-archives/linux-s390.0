Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454257A704
	for <linux-s390@vger.kernel.org>; Thu, 15 Feb 2024 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994334; cv=none; b=VjE/9cpZHmpd1JZNssBUHEKURSB3V7ZMW27hEwa4KuvXJFpfgLsFQrPUpc4l3sU8gdZWiaf+7EnfPG8z9y7z3E/Tu2qMj2ouSIvA6A/ybcGBshyxY8mzh+phWAnZPWF04OrtujAEAQia0WAF1DHPkBJe1fBjbxPkyRqt7W2B7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994334; c=relaxed/simple;
	bh=PoVYOdbKRYKWTXuOVeZk8W1yf2XZ/eDDVh04aFHaMxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAPPhAR6AHCUZoMkEbsr8WO8PiL4JLLVGkBrDDu/GVVTdntjC0tW0ZsLk147rWmr3l7qCk/PlAOczG9qQo/CQPahrLOUYlrEAwKi5PVzqERm0mXGZA45roJYCgDo8DpYokjSaaAwoHyk9HmrPSMbFftLODN/7NzQOUqe119IvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fbVL3S9J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fbVL3S9J"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FAataJ031175;
	Thu, 15 Feb 2024 10:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NXbYufBhaB6AXcJrvydNw1ZrzpU9L9/Wz3bTojc5Wwk=;
 b=fbVL3S9JlMTavbPbn8szRzkBqMqCFmZ36WMeCY9dqixliY1LDK6/lFeV7BH+6ORUzKrI
 bn5SOrojDKHICMvK5sj79LbLyGg65DN3w939CguBHbb9oo+6iiXwLYmWF0DbNYLAzKY/
 myXrs9kBnchnU82QyEdBRU8iOcTD2B9marlXWe29LrIr2GJa1zaKH7E6a3JUilUrbnmj
 CLNG5CCLEec9YSsOHBgMcTOjtu3Grl2LSO+5W+RZJur/E4iQcf/qzwENlKDwtZBRUgRg
 gu0z2Nvr8K1myEbH2P05WBJjBVLd5f0RxqZFwd/ZCV5bPG02RVWUlCqquF7YXiZVJ6tu 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9h100cbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:52:09 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FAeTuN012177;
	Thu, 15 Feb 2024 10:52:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9h100cat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:52:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41F9Ts4S010083;
	Thu, 15 Feb 2024 10:52:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npm3t29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:52:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FAq21N2359886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 10:52:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A78720043;
	Thu, 15 Feb 2024 10:52:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D717D20040;
	Thu, 15 Feb 2024 10:52:01 +0000 (GMT)
Received: from localhost (unknown [9.171.10.232])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Feb 2024 10:52:01 +0000 (GMT)
Date: Thu, 15 Feb 2024 11:52:00 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        hca@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH 4/4] s390/kernel: vmlinux.lds.S: handle orphan .rela
 sections
Message-ID: <your-ad-here.call-01707994320-ext-4463@work.hours>
References: <20240213104707.673053-1-sumanthk@linux.ibm.com>
 <20240213104707.673053-5-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213104707.673053-5-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aagodOQ9VwZw0XJFDLUBjx6R-crucf9O
X-Proofpoint-GUID: PcCJXhfJLlPe0M8oFjiT77wIKu6vlDfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=472
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150086

On Tue, Feb 13, 2024 at 11:47:07AM +0100, Sumanth Korikkar wrote:
> When kernel is built with CONFIG_LD_ORPHAN_WARN and -fno-PIE, there are
> several warnings:
> 
> ld: warning: orphan section `.rela.iplt' from
> `arch/s390/kernel/head64.o' being placed in section `.rela.dyn'
> ld: warning: orphan section `.rela.head.text' from
> `arch/s390/kernel/head64.o' being placed in section `.rela.dyn'
> ld: warning: orphan section `.rela.init.text' from
> `arch/s390/kernel/head64.o' being placed in section `.rela.dyn'
> ld: warning: orphan section `.rela.rodata.cst8' from
> `arch/s390/kernel/head64.o' being placed in section `.rela.dyn'
> 
> Orphan sections are sections that exist in an object file but don't have
> a corresponding output section in the final executable. ld raises a
> warning when it identifies such sections.
> 
> Eliminate the warning by placing all .rela orphan sections in .rela.dyn
> and raise an error when size of .rela.dyn is greater than zero. i.e.
> Dont just neglect orphan sections.
> 
> This is similar to adjustment performed in x86, where kernel is built
> with -fno-PIE.
> commit 5354e84598f2 ("x86/build: Add asserts for unwanted sections")
> 
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  arch/s390/kernel/vmlinux.lds.S | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
