Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70427497B8F;
	Mon, 12 Oct 2026 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818961; cv=none; b=Ma/UASv2Dj0n6zQtmdb65Utrajbh2SCb1BbmLYiV54WTWi6pdzexc8kj1cr1E1A7MQIt74ER/fC0ll67T8yeY70Yx5Y5ORUVc+Ev+Tb0sgX5pbyX/qMrJY7iNa+MBjUpXMMJvCDVZO+tl4m924X+w17Wg/1/HuczbL6twzD5rCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818961; c=relaxed/simple;
	bh=QAOmRhoZomfYsLuluMtKsXytIUCvyzBeKw6xQHDltoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgJ7voCw48fN3qbbPK2fKs7XsN06KHNHiFPLH6OtKEYaMFfaQBTPW1qAP8LkGVy2Nx2FC0N4CedSPjfJhltzaGLgh92RNyqGuWzmr3DIuwdtDeo1jCG+fmcR5DV4gbAbcDvqBNRQ1wA80cN42PcNV1gRAWd0P+Ca+ql3YyKkLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XyCMeT0J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XyCMeT0J"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEcqq182992;
	Mon, 12 Oct 2026 15:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vaENsX/Xovj3/Z2BUashPqqcOp8TEY
	AjAOWXTkt5n+Y=; b=XyCMeT0JbJ4zfSa4++xp9SqYs2nPegUZ/1bJrV8DseMQaH
	u7SpMpi7AHpqa8/oDkfqxA8xr9cF2/ixLdGM6ky3vQ86pI3GpYhjCwHLPRdGGfVU
	X/r89TrhLCnOpPB/AvijktIkZOBIG+A2eYxIJt4V+5hDf8KqtmTF7S/qsp4+Xk+H
	DEKWsNTiYEoWr0SREO4JMRMCLhyBNAMFUA5uiCEhxhDQQRu455aNJ2Bqn14Drzbv
	3ElVMFIfLNPFN7KGfWJekmveMMqAovKYWMjBG0rlF/s3nznVr9NDxI+7WCIo1AgF
	dWmdZf5UHI75gAqzmGMqtbVVH+FsIqLh/WFmBZEg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv39m23-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:29:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC56fX1238622;
	Mon, 12 Oct 2026 15:29:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppnx8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:29:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFTELx48038244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:29:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9F9F20049;
	Mon, 12 Oct 2026 15:29:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4535420040;
	Mon, 12 Oct 2026 15:29:14 +0000 (GMT)
Received: from osiris (unknown [9.111.15.154])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 15:29:14 +0000 (GMT)
Date: Mon, 12 Oct 2026 17:29:12 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 04/32] s390/bug: Indicate modified PSW in disassembly
Message-ID: <20261012152912.19350H7e-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-5-hca@linux.ibm.com>
 <b85d6175-5587-4bca-9851-30241bc96158@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b85d6175-5587-4bca-9851-30241bc96158@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _S8CsJkbkM866M-fADW-oKrOwYetP4uB
X-Proofpoint-ORIG-GUID: _S8CsJkbkM866M-fADW-oKrOwYetP4uB
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6accfccf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=nY3sA7zkoDGtY1Vn0XoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX2U/Xmrg3KPrh
 bTMpwaycf3KUVU6B+7IWoWbljOntYayzBCBDh2yfUKlUfLCSUXcBPCvarX8aFnT82owexbr2dc9
 PzKahnnOmLcUTjnPMn8JjugsKAyvaZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfXy/wjkpJyWjUR
 UR951S6fyLZWZTQrPM9w/CfZZvCCzeMBV3bZo6oqcotPRAi2BHDxvW2nv4rsxm/7xC9D7Qjo9wy
 qNpExxvwPkbjdeGNJoCh4vx3s6tDJZvcSH+7UOGwHsRui0jSWZ1HLkaPVT5NXua/cSryXKCXJrv
 Kty+vVIfdwXBYJPrGZD8SE/Viyh3bvB56yBHxh+ez36bnx1NwYiQPoy3FiMXxcJD4UsdzAGBFxr
 oJglAKEg+EjmC2ZyeedXDkzrkJQlyLimYQxp0i3ahUFlkfBf8jDfMGwXN2Rsk/2mGTIq0BFvObx
 POGiRM1mY9AIdJtIKwJWUHp2LpXArpBkt0OwM0jATDjstIt0yjctDvhlBTF/coWn5+p/MzxKvj+
 NFZSbDvqxJdp3/IWGcuCdX8XYGKN4X1Pl14TCcW8rFiP+mLhmTIzmI6Lt7adteQTpjsXy5ayIij
 mbA425aoMu6gnVSwW0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120060

On Mon, Oct 12, 2026 at 05:07:52PM +0200, Ilya Leoshkevich wrote:
> > -		pr_cont("%s", buffer);
> > -		ptr = buffer;
> > -		ptr += sprintf(ptr, "\n          ");
> > +		pr_cont("%s\n", buffer);
> 
> Should this really be pr_cont() and not printk()?
> The KERN_CONT doc says:
> 
>     only done after a line that had no enclosing \n
> 
> and the new code prints everything line-by-line.

I guess it doesn't matter too much. The old code worked around that (by
accident, not intentionally) by printing the new line the beginning.
Which is most likely also not correct.
So yes, I can change it to printk().
