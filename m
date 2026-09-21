Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED63563E8
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995685; cv=none; b=qDuJkMlBmWoQLKa2NGkxzByzqUKcT8QdzE/SEr1xaq1wuG6eAlDuGUo22f7AMUABingLyNZWdiQ9NixtBhIGNvq1WBkSv9DMED/2XxhX4fuInjc6ybGm0x2sGuYXuXO53FjwPddJwPRgVcdUp1vDHeAkAri/+NHQWeLRxkGyVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995685; c=relaxed/simple;
	bh=eCTxGUxOZ36vWjGR9l4NlKR3Fy/a/uB+2QXcN2l+zhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5mWXBOce/KUaxgcO+7f6w7kJOesNFX4K9qdIqbEwqW0sBwgkBAIRuJfYOt5reIUDSaKXhfptDeaB/6yVpEEXQKhX+qi4YMTfquHqcZQZYk0Z1oAndn0fZRBE36P8xwrXSQBPM0akOHM0BaFy/LBdZZc2uViX1x9jioVwfmftUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HRH3mnuS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HRH3mnuS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB60BI161783
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 13:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=LstcQIbdc6iudhgx8bIeHsLzvI+eBN
	xKlqkoWtiXq7E=; b=HRH3mnuSKVspL2+MMMqBGKj+2CaMZSfhaELSjOYsmzwrg8
	4u96/vQgtq2NHWP0Gj41F6LMm+lQDlBOKUCCf2RWaLgfw5xfc29KDfAt6QjF2yT4
	rLAvTQ7IDf9nAVUqWNT0x5Zd4R9I6qj/vJVIMWAmPFnjcwDnIXHUk9QT93r5WWYH
	R/8qSg3EPTT4wzL3tBEfzS9SOdkZEP8/heSr6zJn6T85AddAKPoTLvK2m3FvF9Xw
	ZsAV8wES1D7fKqu+55FjKeeJYDL4KY/Gc8JcloPcqrwu2aVjdrSgCjOk2zvcKb+K
	68xauUb8kl+rLPD0kjz4LOoMIngqYe84MSpjmKCw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq8dub-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 13:01:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlVp21153715
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 13:01:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq5fu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 13:01:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LD1I8050397552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 13:01:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 345432004B;
	Mon, 21 Sep 2026 13:01:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F421D20049;
	Mon, 21 Sep 2026 13:01:17 +0000 (GMT)
Received: from osiris (unknown [9.111.14.239])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Sep 2026 13:01:17 +0000 (GMT)
Date: Mon, 21 Sep 2026 15:01:16 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, japo@linux.ibm.com, sumanthk@linux.ibm.com
Subject: Re: [PATCH] s390/pai: Simplify pai_init() and always return -ENODEV
 on failure
Message-ID: <20260921130116.9433D51-hca@linux.ibm.com>
References: <20260903081557.2023814-1-tmricht@linux.ibm.com>
 <20260914121406.39845Aa3-hca@linux.ibm.com>
 <fc096eca-cc22-40e0-b059-39d02d84431f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc096eca-cc22-40e0-b059-39d02d84431f@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab12aa2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ocgjo0Zcwvy8ga-pGRoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MyBTYWx0ZWRfX2xOWh3DEiYPX
 g5k3e+96egrW/Fpj3Zvn9GVpp0szX7JOzQUVf/MTdTaf75/ZkNfMfmsYbqcAq1O9uSEMrR0+5Xv
 aFM6rQi4qimAygSDzoYzWRec2mUpme6r7m+P2iCavoXG2K6wFrrfv+pFec1aGQul3pMc+BK0Hcl
 2cC3636kVhexWgzgqvMTrLWJRdxkEUEOZK7EwzDZgaAdVpeR0+skuPkljS/YZOImYi4Ez2dvQNo
 LUiK23teuddUp3tlv0PhLRiK+8xBuUyV/6+IVZE6M3TExT/r1jNv/nmGY9O8RxOm2f5F6QFl5Mk
 1tFLFNh8vPGQANv5FXo+wjzb+597GIaq1IqmSB10btVDzMfzBWTG6koPQ/5m9ceim0EV16+iA1U
 68vsHtemTJJXx97KXS1byjctqkY6E5kAsr4/8kUGYQbO/XgHyfPbpk7iKz4oyOk0dDT0yskmEtx
 niQzy/G6XS3LobCpmkw==
X-Proofpoint-ORIG-GUID: Vm9wFDutoxwaV_Z2RypoQ14cdg098AVk
X-Proofpoint-GUID: Vm9wFDutoxwaV_Z2RypoQ14cdg098AVk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MyBTYWx0ZWRfX/3lxT3QdFBiB
 KTop0E9mv3pKOqOqoFMR5eKuX1b1FKh0VeHvH1NX4CXLhBjFvTvLprsmASfo3zMtZc2b9mmWdko
 ki6y4GGP3Lu/58ewSwJt1zEE+eKhc1g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210183

On Mon, Sep 21, 2026 at 01:40:21PM +0200, Thomas Richter wrote:
> On 9/14/26 14:14, Heiko Carstens wrote:
> > On Thu, Sep 03, 2026 at 10:15:57AM +0200, Thomas Richter wrote:
> >> Code simplification and remove variable state.
> >> Return -ENODEV in all failures to indicate the PAI PMUs are not
> >> available.
> > 
> > Why do you want to hide different error / return codes? That makes
> > debugging in case of an error more difficult.
> 
> Well, hiding was not the intent.
> 
> The kernel common code does a lot of checks at event creation,
> then calls the PMU event_init() call back to install the event.
> When this fails the return code is checked and further action
> depends on this return code. See
> 
>   perf_init_event()
>   +--> perf_try_event_init()
>        +--> PMU->event_init()
> 
> See include/linux/perf_event.h for return code meanings.
> 
> When we return the value from cpuhp_setup_state(), it must no be
> -ENOENT and some other values. Because those are used for postprocessing.
> 
> Thats why I always return -ENODEV, meaning event is valid for PMU, but
> PMU not operational. I thouhgt this might fit best.

But what does have pai_init() to do with anything of the above?
pai_init() is called via init_call() mechanism.
