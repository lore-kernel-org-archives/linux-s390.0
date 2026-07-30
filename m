Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC53D16F9
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408422; cv=none; b=pRBnxCtJnMG+26LJIwPz5NQkH7IeM8MX0XBmXIfA9r1ArdokF+5YDoloWj+7YM5UL6LMlxZFRtHUO7BVbxIbq1gAS+PWifyIGefSWawGH1aLM0zL3cZwt+HUWk92Z3e52nxSxPA+lspE8IExkW1rM7Ybzem7wIOSdxk7Y5+jEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408422; c=relaxed/simple;
	bh=H+VOMoMGkSHcP3hW5x+BKxRzBW4E4L15ZhqYFB2Q2Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6Cc5C6ciGWUjj5udoXIqaC5lbfv7MCuCl35CdD5QvRB1smj02TmUedfQZfS2J314aq8J2JmGKrkJ9GsqQPnX5KOsajesNUURhkwT0uDFiz9pm22RF/Fa25bLFZ2aiDzWdDDr2eCWEM2cBBICLMRhRhnZnbHQ9gaH3JEIOihk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZnfFwcLN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZnfFwcLN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHdKf2638614
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YgaBDBot1Lvg8nnkut1xF15Wcx4tRT
	f0/vuislNQHoE=; b=ZnfFwcLNxBOgsfahQutxC+yabtJmTDQE5ZAuvREXIBC3sf
	JYsfyaGPIxqQybP/su18Nv4bO3nGaAzyDT/2aAk/4mAhS1w6iNXEcmWd50jwhjnm
	1Hx8o5sPmmtDvEU5jPktvjzfcm4UjN6ts80T5pjd95yR3BJMPHbdZ/BPJbydcO5t
	2tpatcVKGmC246JZ7w0CWv66LuGzLnYA+2dduBbWE8v4PEawqAHhty32A4EoQsdi
	bf2NAS5FHbVNLczD2aD7FAaGvEM2lG82Ckrea6F7jzcpRu6gN5MLBp2Cfq6m0DcD
	wKQtH5gz/K5ZVuvChDUAmVNWxUBi9CVVs2hQ5mUg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nxd2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:46:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UAfReX009014
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:46:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkax9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 10:46:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UAkskb33161634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 10:46:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98C8820049;
	Thu, 30 Jul 2026 10:46:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E47320040;
	Thu, 30 Jul 2026 10:46:54 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 10:46:54 +0000 (GMT)
Date: Thu, 30 Jul 2026 12:46:53 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2 0/1] Fix missing mem scrub at clear key import in
 cca_clr2cipherkey()
Message-ID: <ttizhy5@ub.hpns>
References: <20260729140134.191448-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729140134.191448-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA3NyBTYWx0ZWRfXwwvGIsYSue0I
 CLb+L8FUL1S0FRavJah00ERMGbtYAdODRqHIG/uAS1kl/SeizWP6xhUNchpaCCSfLInEd7ob7Yu
 /FxB8Ifs1E2zBIg7adg8BF0d2hVhyxE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA3NyBTYWx0ZWRfXw4meL2o6AuKz
 /07jPGfLPNQ9egMqsjQ51zkrdFiZ1haI9JMol/M/UVvI17lkQTCUVP/s4NLn756O0D5XyhIP7yW
 MmYeEZdHRJ+nADfKMwtMwgOEJpqS/pr15shMLNazJBv7HtpATHdn2DUBdjQAvGpVgf+pWyd3pw0
 P1y9LNh7Qg5ZuEcIZ637Mz12LD3qnZHxuyluSkV2qov3qw/Hjyf3d1qBI/UeP8senOe08Ba7yeT
 aVY834OwhMF33A5KdXELVr50NQS7HBK8CklVvuM3Ov+mENczAvywZP7qQpSqDWDdwmMOMVD/cX3
 7RqVw1H1OXHjy7kq1hhakh89qosDXE6l/voV16SXnNY5JiyYpWIaEJwwdZsfYzsMztJ7tKOYq8e
 89BhmldyQd6xhjoxkuMPEpyuDdUUODj7Q2vG4RsdLsY79Wlo4YYeoU17VfgHAO5VVvW1vXEWLUW
 2JSPAOPIAiIVa+XkPsA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b2ba3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=e2as-ruOGLGTfvegKZoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qigE-T8fGH1XAohkuDMYr8hCj-beh5ZG
X-Proofpoint-ORIG-GUID: qigE-T8fGH1XAohkuDMYr8hCj-beh5ZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300077

On Wed, Jul 29, 2026 at 04:01:33PM +0200, Harald Freudenberger wrote:
> The helper function _ip_cprb_helper() uses internal buffer memory for
> building and processing CPRBs. After use this buffer was never
> scrubbed which could lead to leaving for example clear key material in
> memory which could be exposed via tricky reuse of this same memory.
> 
> Extent the _ip_cprb_helper() function with another parameter 'scrub'
> used to steer scrubbing of this buffer. So now the caller has the
> opportunity to decide if scrubbing is needed or not.
> 
> Extent the clear key to secure key token import process in function
> cca_clr2cipherkey() to tell the helper function from above to scrub
> the cprb buffer when the clear key value is part of the request data.
> 
> Add explicit scrubbing on return from function cca_clr2cipherkey() for
> the random EXOR buffer and the cprb buffer.
> 
> Overall this cleans the internal used buffer in case of clear key
> import to prevent sensitive data to get exposed.
> 
> Changelog:
> v1: initial version
> v2: added explicit scrubbing on return of cca_clr2cipherkey()
> 
> Harald Freudenberger (1):
>   s390/zcrypt: Fix missing mem scrub at clear key import in
>     cca_clr2cipherkey()
> 
>  drivers/s390/crypto/zcrypt_ccamisc.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Applied, thank you!
