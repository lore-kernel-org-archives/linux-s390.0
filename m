Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17625B09C;
	Wed, 27 May 2026 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890949; cv=none; b=F4kNoJlu+rTtMsw0Q2o1wbZV2c66oX+qvtrSEfUMSEoKkM414nLKZsAy6pGl4/nB08GuCc+iLX1rT9AQHqyzpUtF3Thp66oYrTXO8AM96PiG+SIumnTHcppMNp1GvnsYpHCmY9zudyX7nE+fnZrhp6fzIB76iyYE6phP7ed9XuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890949; c=relaxed/simple;
	bh=rhkJVtewVaSzTzQq5C7i5ojVIbvS3wK9enYlhrj8EyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a954j3AjEQpM2CxwMe/dfvTCbwgqUJmddzZhNe1USJvn1Qu+SArX3+AeSWQ1sRsrSNsVdl30ERlraE2VCI0VeCVlSXrfmAHxAZy+iedSO8cSNNaKj5L2v1b3aEDJ3pWpbTmSm674u48wCwt9LCdY+n0LwjjpVcoZHkUsu/de9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m5KIVUkw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m5KIVUkw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RDDUrD3595371;
	Wed, 27 May 2026 14:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9u9hc8f88HOdQUfn5+DG3f+VLqHSJq
	QE1vupKSGolko=; b=m5KIVUkw+jub7JZ+B0hMZ1TsLpZq9u9O9V74NKoPqqpeL/
	kqgiP7luEk24QVY5iIqDh8aX2j+FsdmbQJ5+2B3mxXOLYm5bBk5pvG8jmi6bD2H2
	5w9bx0gjgBtFqm9h9LVu3Wa14nuCbA+xwT2FOs6Zw07iVxs8aks+tUEXhbcQqC+X
	DKm/cI32AQQ208JXaERNoAMqFOqZUgNPjG1uvvgby8ojX3YTG4Csfj1C16W88mmP
	fx/mGzDWAqdINun+pJK7gpgoTUzsuif+r1lSFG9R9Lpz/FmvxJnSmi6qKVx8sYnx
	069RyLXZ0yRM07SI4GxO/ngpPm3lQ08cRaKABB4w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2hp3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:08:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RDs8Gg004311;
	Wed, 27 May 2026 14:08:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbkb0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:08:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RE8mUr29557046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 14:08:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E3D02004B;
	Wed, 27 May 2026 14:08:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2566120043;
	Wed, 27 May 2026 14:08:48 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 May 2026 14:08:48 +0000 (GMT)
Date: Wed, 27 May 2026 16:08:46 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Manuel Ebner <manuelebner@mailbox.org>, Kees Cook <kees@kernel.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/string: Remove strlcat() implementation
Message-ID: <20260527140846.9471D18-hca@linux.ibm.com>
References: <20260522143111.443100-1-hca@linux.ibm.com>
 <20260527140358.3838d1b5@pumpkin>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527140358.3838d1b5@pumpkin>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 05_2PUv3Btoo_TVe-AElD1FVanRgNVWR
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a16faf6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=ZhbBX3Y3aZzRguwoF8AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEzOCBTYWx0ZWRfX2GJXo/pxsjhI
 ku6Xe9vAatDcMM6FnEH1fyAlD2vdTs+eoaFQkHRk/uDspbFTUxzuM14CefypOFk4fPwiycIgns3
 WRbtXUjUKc9P7/idIxe/yaHX7EaCLE81tCULNJR42YOHv1kpLCY9lnEf8jC+zSLoW010hpKC7KG
 8Z0kI7lrDPNQM3O72vLUHTgb5A2Q7CVHsY/FMM8QAku6y9V4ssTtW/SltpeZlk7VhP4GRpXtWR1
 OlKzcmw5UqEQnp0hlwdO+/+L1AR0JPQgudaqXtoBhI9w5N1ip86tzOpEQ6DhcPxt5+TGPyfA2Mf
 201euuUbbb3riQcmiKia9KfxJVbsSNY7mOrYljAy9AbgCyLC9bAMo0Kv5rBdns0pBwp12qeiCPl
 KMxiKm3S4pccTQQUeRRROr3xJtYCpniKwvwuvfPyywkidy1MDmqnMu2hSKI5hqJehDUu7CNtNvn
 O1DwW7576gQAsBmcXFw==
X-Proofpoint-ORIG-GUID: gap1qxPLICM-M0o7crOVcz74FT7ufzhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270138

On Wed, May 27, 2026 at 02:03:58PM +0100, David Laight wrote:
> On Fri, 22 May 2026 16:31:11 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > strlcat() shouldn't be used anymore (see fortify-string.h), and will be
> > deprecated / removed sooner or later [1].
> > 
> ....
> >  #define __HAVE_ARCH_STRCAT	/* inline & arch function */
> ...
> >  #define __HAVE_ARCH_STRNCAT	/* arch function */
> 
> Those two should probably have gone first ...

Yes, except that we need strcat() for the boot code - there we cannot use the
generic variant. Of course it would be possible to copy the existing strcat()
implementation to the boot code, rename it to e.g. strconcatenate(), and
strcat()/strncat() would be gone, at least grep wise :)
