Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA32512D8;
	Mon, 12 May 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067506; cv=none; b=ZtvQQspJ3ACObFqcZmWBWZmBbUUil5d24lKvwQR0bNYSzDwyLhaVNCwdvbYESBMwPLOo09bfL8I8AHppDOIYHOx69N1Y7aKkCGeCXiSJjqHGlWS640IMBVvOuYlE51gzOAs8dp63yna3Usa5a8mQoK2urKrFlfvkO5ETjnw7g5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067506; c=relaxed/simple;
	bh=zTCHXo5qj1aSrkhmhcy495wGkdhIvjJB1e8sLW6iDtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgEbe6Je4Si1VIG5pUBs0zo2aZ7sFt4kqx8sQJ5dN/90eHHDcd3SpXIFYRWloBohPn+2iDdj1fDIlYS6gRNbBFsZmc1LDvFNxfVyBQlFdkSIHipdscGnOZNmB/SI/ZUAK4a/9fINwJ27TZ70hhNi0c9THDFeMhZR3D3utRFIEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fP3ChIBS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fP3ChIBS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CGFYFB024389;
	Mon, 12 May 2025 16:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tGL/LbTAfn0zgVU3c0eZIOyEQsldEM
	IlaiE0jItqvvI=; b=fP3ChIBSynYYYRzIHYSYCcuOVycnIJD3w1w6VAcYo04tWC
	LGZMfh6cAxG/S8v9EMe8qJ9h2VMrye/hCZMEWttMYjh6zjdSABTqETWx0jVJ7D/4
	fIan3icK3kf1YjOWOi5NaYWfTi3sP8gFKXrRmyNWLcpEVbeOHVqiGebQvOZfxAXM
	JofCP+SvJYAoIV5r7jrmY4ZyMaIsSD9mDKQ46m95rpdOP/uKNTWQUPHm0FTxvNBr
	hMmpcWEGGxDlPSIEr8/MiuT8/t7OCXwF7qTf/xsFwY0OgJQT56TRWwiFwjxOIe65
	ZZi0YAB+beQYvTHi2wKc3BaFf72RENX4+6JszWjw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kbkstrvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 16:31:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54CGEgRb024804;
	Mon, 12 May 2025 16:31:34 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kbkstrvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 16:31:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54CCqoM2016337;
	Mon, 12 May 2025 16:31:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jh4tf0ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 16:31:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54CGVWjv54657416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 16:31:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 229C020114;
	Mon, 12 May 2025 16:31:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECD8020111;
	Mon, 12 May 2025 16:31:31 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 May 2025 16:31:31 +0000 (GMT)
Date: Mon, 12 May 2025 18:31:30 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <aCIiYgeQcvO+VQzy@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1747059374.git.agordeev@linux.ibm.com>
 <c8eeeb146382bcadabce5b5dcf92e6176ba4fb04.1747059374.git.agordeev@linux.ibm.com>
 <aCIUz3_9WoSFH9Hp@harry>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCIUz3_9WoSFH9Hp@harry>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DrhW+H/+ c=1 sm=1 tr=0 ts=68222267 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=dg7Irr5rqVmvLQufYEsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2NiBTYWx0ZWRfXweJ+O0011/Hs 6Hi4ZRGHDlEuF3MjSp1S3b9ZMbw7IQKKSMaelku9w/b5OsAN8qEomFNf5kouXsH7mtGlnlCEtvF uClj9wJ7drwFXTPRAGica6qa0XtOfr7AfpFn65OU1Qk88AedgaPcZzFgmtyYVTl1gdAOMd5cReN
 7ObWluXXhDlPUzQ8HHQs5PSuD5d2cgz/aoNx7GOtMH38Bg5oEmGMldZdfoberwf7kt4nxgOvDcd yg0cE04WpU+7ZqSJIa7fcet/D87eDR4Byn93QV2FLuyoct/FurVgShuCbiEJIiEXK4sneVy4W1+ OUKx76PhRj/rKDEod/2dQSvFl//4ji1YxiSn+KAogptSpp/IdFODEwhyxNz29TrgwQ2Y089pOFd
 Am9OmqgYtKMWOWD4ynpv24Q55k8wN5Ljbtd+PP9QNcpo5/3rlNXcQgMeLbIfPFNon0jcuU1p
X-Proofpoint-GUID: 13OLRlz25CD_Htxzm0V93LQo7uFLBEqY
X-Proofpoint-ORIG-GUID: _K-rkFkUazgqcTHuIiwz58rCfqji_YEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=597
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120166

On Tue, May 13, 2025 at 12:33:35AM +0900, Harry Yoo wrote:
> Thanks for the update, but I don't think nr_populated is sufficient
> here. If nr_populated in the last iteration is smaller than its value
> in any previous iteration, it could lead to a memory leak.
> 
> That's why I suggested (PAGE_SIZE / sizeof(data.pages[0])).
> ...but on second thought maybe touching the whole array is not
> efficient either.

Yes, I did not like it and wanted to limit the number of pages,
but did not realize that using nr_populated still could produce
leaks. In addition I could simply do:

	max_populted = max(max_populted, nr_populated);
	...
	free_pages_bulk(data.pages, max_populated);

> If this ends up making things complicated probably we should just
> merge v6 instead (v6 looks good)? micro-optimizing vmalloc shadow memory
> population doesn't seem worth it if it comes at the cost of complexity :)

v6 is okay, except that in v7 I use break instead of return:

	ret = apply_to_page_range(...);
	if (ret)
		break;

and as result can call the final:

	free_page((unsigned long)data.pages);

Frankly, I do not have strong opinion.

> -- 
> Cheers,
> Harry / Hyeonggon

Thanks!
