Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D74BB5DE
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004243; cv=none; b=dl5SVUpWG7MjiZned+RWecj2s0xmaeLDDXX+1FovTunNHmYm9v5sAM3u6G2zn0jEA3bjrkKqKPa2vhaVLT6r6pu86tPibBI/ObNKXD1TgQq8wllIj48gtWlqlW44aQdEGu1wpUPAErXRmsOu/J1n9iA7Z6M4DaQSlfYFxGpTR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004243; c=relaxed/simple;
	bh=8UR3jSdaq7hb4mRoeWtDcAAbXq61Qf+CNMAFA+2n5UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb5KAtkkRIsO9AOP2Ek0KWFW003GHPKNgtM+lSpRuP3j+M2WcQ4A3wHSYItToouS+Iyu5SHsWUKYObZgNmfIoHFcuXIopw+dBQML7fL3HtMJ5f9Zsp0CgXRUWu6yIiXVEurfK+1YhDWg+96nhxsiRHEO5K1hyaL16551rDC3Jig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZEEWgiSc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZEEWgiSc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8EkF1860575
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 15:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wEBr2szVKxn+HnC2lhH/19frvu8Lbh
	jrlnJocyEJHBA=; b=ZEEWgiScRRyIFUyru7IEcMI+YEL2HPq2HYIYnBv6AhS2Lu
	1Lpt4SwwYcX2h1eCcojfXucY42GOWSlQZmHKcwAT7pIPZgrkJvH66/9KZ3IDEsnq
	ehikW9JYa1LxPu9mAmT7ecZ5njmdOoodw8Il6Ux9xDO4FJE4mwiNZfwIQ2WuCRm8
	7AbcQIjnIgSJK4CFZpPToHKWE2lTbZf3EeAVgNYztlUfxuGP9YqqRocOxnXUdFXn
	h/gyWFf4ZdJ1DK1MLVnMAerF2jC+OP1eefF//u3muln4Sca//MiKPupLHO8Yi+Az
	5f4lBnocH74b125u77iB2hdlMIh9jpvWl5DRhcQw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg29b1c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 15:24:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFHV8E1489446
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 15:23:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq60te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 15:23:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LFNuuC53215702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 15:23:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F8E420049;
	Mon, 21 Sep 2026 15:23:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E907820040;
	Mon, 21 Sep 2026 15:23:55 +0000 (GMT)
Received: from osiris (unknown [9.111.14.239])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Sep 2026 15:23:55 +0000 (GMT)
Date: Mon, 21 Sep 2026 17:23:54 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] s390/cmf: Fix virtual vs physical address confusion
Message-ID: <20260921152354.9433H88-hca@linux.ibm.com>
References: <20260921131648.3636771-1-oberpar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921131648.3636771-1-oberpar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XaBM_VsvykjAtjSq9U_paneTV8nBJtL8
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab14c10 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ZS3Fz0Y9rkdUzaftGkkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyMCBTYWx0ZWRfXye0pUl3xs7+A
 JKjEqY3tY7Bik1eaJ5teuuuiRuuuClds5ehc4pgO3NsE7fmQdOkSlqoMNSsKKzDNC65tfCSJk+L
 NmFHdM2HN9JAi/o7UngdOfsXkwyQrg2zg8y1htbBrdPdKoP1LfP8XcSFXCBDDp3Wr/LSS6HsDfP
 rjo7aG/SLuiHC6NvMQMzDu8AhdA3MeSBaHetS9xAInbtgdx76rid5Qn2g4vgWOgESG/u3uixwB8
 9CGytcg6qpB6vZnjRqRQHjMp+pFfTqPTfLZ7lgI9apBQBH0geuOyZLsCHDnTXGN0bOpEVs1h4ZJ
 cxVRJGQW5qoOdQHyhM8E1pG72Po8oRm1qybUfwIGtI5bK85zBzel71A4zXTrbAShoeRHZoR99p5
 lcaKWIn63V+d3HD87q8/UE1KCo5XByWM8NNXHc+VVNGhfnls8uvuUnfnoNUk+Nk7lH4y7lM4ICC
 9ZcvZSUORbJTXOTXSUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyMCBTYWx0ZWRfX8m1ZIUqCrTTe
 Qbdl530jdokqCtMHDwqvCIRRdmVKULp6NUvauky0EnswDMG2YGxy9xFH6rcRUaL7zEBKZRBJkeo
 6UI9OeOMw/EZAKBa0KspY+Z2Rv24Jr8=
X-Proofpoint-GUID: XaBM_VsvykjAtjSq9U_paneTV8nBJtL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210220

On Mon, Sep 21, 2026 at 03:16:48PM +0200, Peter Oberparleiter wrote:
> The measurement block address is an absolute address. Define the
> associated schib_config and schib fields as dma64_t to enable automatic
> detection of incorrect assignments. Also add the missing virt_to_dma64()
> translation.
> 
> Without this fix, a wrong address will be used by firmware when storing
> extended format channel measurement data on kernels built with
> CONFIG_RANDOMIZE_IDENTITY_BASE=y.
> 
> Fixes: 14edd0d73bfe ("s390/cmf: fix virtual vs physical address confusion")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> ---
> v2:
>   - Change type of mba field from u64 to dma64_t
>   - Add fixes and cc-stable tags
> 
>  drivers/s390/cio/cio.h | 5 +++--
>  drivers/s390/cio/cmf.c | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Applied, thanks!
