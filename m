Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C33D969E;
	Thu,  9 Jul 2026 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593781; cv=none; b=DGKNT1yYGlGWUH7K3jyJFt1W02y24cBIwbTytUqFOj54DjeG3eA7KsggymRIbdryCvPhdnv2sIppCVn+CTGgG8DoQdQsWhJPgcD7WT/M/XpUfIpUGTY/0P10qrnZznwfaVKYkg33YBe//pd+elD7NjrFUL65ecnnaMT16IssDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593781; c=relaxed/simple;
	bh=5J+134eb2t6nGCA791k4kRjVtfTgbZPinCClOq4vl2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJjKOGLrBR45ixmtkwhIBxiQJBq41Up9Cnr3LkEMcio3p/vEDX/7CCb0VuN48A/EJFKq0f9itXvsDn3xJyyiUa39h0JEdNfiaZ1liUAL7MyCLvbieDfBZZRzD8+yMOqT0nqr+JUrpe2s6rd18nOgc+/VQ7F4htHpId6IFMit5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kBba0Os+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kBba0Os+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696INgZ1154744;
	Thu, 9 Jul 2026 10:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bJoHloQObio8/qxAX4AxkI6czcw5Vj
	8i2a2wOSd5VBI=; b=kBba0Os+VbStaBM6mW4XsOZirrcPYdNUgsrcYULHdmwgn3
	Ny6fLIm8cPJqIRFYBU/if4DsfkyG528krpZarhym2Qs2gO68lkBk3KsodE3KA7MJ
	3WVLIHAPWLEsZn/iJr/vuJYvtUQICwgTI93TYhmqNFSsuM8azcmS+AeD9jCRtmjL
	KDroXupo5I//O7JLV3lqdbnM9PejC/hPo27TvagD5IuZk42MM45LQmN/NuMOdK02
	EJJhrzDXbjSjgI6n1hYEGUnEHtMSucClrwyIxhzYB0DhHrVWMeommzuZd1ubJF0n
	SiVHDgK3/YhwJIqfLNiq7NBQSN3HD0/8zN7VuyaQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw518rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 10:42:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669AZ2L9030278;
	Thu, 9 Jul 2026 10:42:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hmm9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 10:42:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669AgpKc31457636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 10:42:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B33F32004E;
	Thu,  9 Jul 2026 10:42:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73BE120043;
	Thu,  9 Jul 2026 10:42:51 +0000 (GMT)
Received: from localhost (unknown [9.111.0.64])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 10:42:51 +0000 (GMT)
Date: Thu, 9 Jul 2026 12:42:50 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/uapi: Remove obsolete unistd_32.h from Kbuild file
Message-ID: <tthwlre@ub.hpns>
References: <20260701134727.882734-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701134727.882734-1-thuth@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MvF6PstUuoIKDSRGqZz4nR4ERMWBjR-K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfX8++Jc/h5Ndyv
 h6fDZyuN8SIuB18BBKFP79fBBxF70Fkoe3dhrNVDz7K9tLLiQz4BdNre+UYCiRDw5ti3BpWjEqO
 7EbtyN6NwtILMDRDXStuvALIHciWNt84Rnv6McCI+RYeVAU0mi6+eKuLKieJCZ+TJauJpSvaT0e
 RQ5xY4uMh019iGX3+Q5WsZFpkAIDacZtvu4qutiikleHnl6XrhEOuVZ8DraoF2tUpzkREPaTuzT
 h0a8sFpOORj6taPoHmksr1Mz6mFIE5G0rdMfwLALvk/jJGgswaviSNwuBY6k1kQJ3Okc8nRBwJ7
 k4VwrbdRbaY07atUdnJnDimLbnHlN+wkfJ8FSB7Schw204dVGeMPhI37hnQO2t3bkavecA90/Pi
 Mh0UuoZOUBAwgxeDr3ypoNAZyAKtU5RT+d44KQgJHRZdSwgJ4ay0p1f2xYePnOGzAYeuCJELIb9
 Sx3qMQYPHvZgAujNJdA==
X-Proofpoint-ORIG-GUID: MvF6PstUuoIKDSRGqZz4nR4ERMWBjR-K
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4f7b31 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=e9PFnbqw4GJfFSNQJooA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfXxQBjYJn1pAIi
 bcCXKzDVxhOFBp7pkoql3/Fd2lRqn9mwzbrzENJiQDIg4sDC+A3TrBQWRPqwEDKdyovsBa61BW2
 +UEvdNX3emVFTtTFDw82td7SjWNtM9c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090099

On Wed, Jul 01, 2026 at 03:47:27PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> unistd_32.h is not build anymore since commit 4ac286c4a8d90
> ("s390/syscalls: Switch to generic system call table generation").
> Thus drop the superfluous line from the Kbuild file now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/include/uapi/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Applied, thank you!
