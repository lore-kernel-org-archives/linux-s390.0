Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E000311C27;
	Thu,  2 Oct 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759416214; cv=none; b=UV61iMa8RBJcJllsGSrzsH4EersnMtu+o3VG2sXCXGzLAI4F66TIASrTF64f+sswHzZt/EXEgqTERJq4MruZGSj6VsIT2c7KD0yGRl9IvsmJcOVEFUV5DrsJNwoX1pPY3FNLmcAsmrX8FO/L/nPqXB6vSi885zfO/NLTs7NQEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759416214; c=relaxed/simple;
	bh=TX6lxiqzVoYryBClnaB22OLqwc2CirkAL+RoFAqjnuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUL62L2wXtULx6wYakbASBGj7dym2fOm8GCMbUwHHqdFLggSkqWntZdkzkIYsd51F0/4asrsoURvF7rrR6tY3V7v856ATasFL6UqhKKIRv0PBIglMgpVo5uh2cxO4cWCOxLntmPeQo10M7xl0/hvhYQBCPdI31W7qaCYaqZLlsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=osZbTsPX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="osZbTsPX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592DsFXZ014093;
	Thu, 2 Oct 2025 14:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+KKO2R
	Q9X5b3SH2MnkmdS3AE03dbnGo39IZG+WyDtNY=; b=osZbTsPXs7eQxy1JWMEwfO
	lkSxNxx9jnWpYP/+9ujVGMQYc3ZiwX0kGfYXJBe5x8Hwp2YkJBfsX5sCe6cVZYWV
	S3jqcqX/wBSdmmDjV/mE9XmrDIlQLxjMfDd7JeJwkRKxBy+DAU3jOegYd20Posi7
	gTJJI37IaKy3pwUcuxzvxJdhWGCSfyRlq8te9QMEW2P4yU5x0XdDmsE4MhUdvPfq
	H+HEAeiC5IQCl4oLcJVVu6kd+Qu2XiXe3OpArdZCAqSS+ntFgjRQ8lLRjgTWJMf4
	jj0fP7g536I7MukNI0BoLd7VBYZDxUo0cfFH/xrz3+wIXomK2lBQTi3go9MqUE+w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwvs1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 14:43:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592DmBdk026752;
	Thu, 2 Oct 2025 14:43:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8n6d1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 14:43:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 592EhQ0H50921864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 14:43:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59A2B20040;
	Thu,  2 Oct 2025 14:43:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1808320043;
	Thu,  2 Oct 2025 14:43:26 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Oct 2025 14:43:26 +0000 (GMT)
Date: Thu, 2 Oct 2025 16:43:23 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] s390 fixes for 6.17-rc3
Message-ID: <20251002144323.69394Cc7-hca@linux.ibm.com>
References: <20250822123608.142112A72-agordeev@linux.ibm.com>
 <ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de>
 <20251002110526.7570C1c-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002110526.7570C1c-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX3PLBDIly4mg2
 keZ/JzaOp030ZfDMyD0V5ETCfdvJRiH+cyeuZhzAd5+hNDaSVGSdnGvUHslOne3/IEFDqFgcA73
 isv3OS5si5Vu/WgbBuMj7tKSAriSxul13b5ZC5JnrTQVo7IeEl22/vnCRdVg8XydHqQO7Byx71T
 CuIV2KB8CPPWEevVOlgQ40Evy6mV/Gz3Gw1700x9H2Y6JfuSbXOwg+fpzg5wQc4K6/s3W9TQHe7
 wHer5fRfEIfaZe1IhC6fWyiNOutsq+5vTRgez52enJzV/scfBbWoH7/M7/9sbH8KDOJI6x7Mc0v
 v5sUNNLqfLMDNHbAOWNNALs/x6E9skoBsUexANGmLCLnwQ2ZSh0B2vs/OjhezGmaz3vpxyWLDru
 rLmUECMyVbCZQ/wr/CktgZDFh8OF+w==
X-Proofpoint-ORIG-GUID: Z10YevIFXZbHNXMwDpwNkJWHHJnUj2u5
X-Proofpoint-GUID: Z10YevIFXZbHNXMwDpwNkJWHHJnUj2u5
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68de8f93 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=MIeSm9THH0csdDuaAvAA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

On Thu, Oct 02, 2025 at 01:05:26PM +0200, Heiko Carstens wrote:
> On Thu, Oct 02, 2025 at 12:44:41AM +0200, Thomas Weißschuh wrote:
> > Hi Alexander, Vasily and Heiko,
> > [    2.118473] Run /init as init process
> > [    2.142148] User process fault: interruption code 0006 ilc:0
> > [    2.142626] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc2-00002-gfcc43a7e294f #24 NONE
> > [    2.142739] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> > [    2.142822] User PSW : 0705200080000000 00000000804087b2
                                                       ^
> > [    2.142911]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:2 PM:0 RI:0 EA:1
> > [    2.142979] User GPRS: 0000000000000000 000000000040c060 ffffffffffffffff 0000000000000002
> > [    2.143022]            0000000000000800 00000000000007ff 0000000000000000 0000000000000000
> > [    2.143061]            0000000000000000 000003ff00000001 000000000040c000 000000007ff720ac
> > [    2.143106]            000000007ff720a4 0000000000409540 00000000804087b2 000000007ff71ec0
> > [    2.143406] User Code: Bad PSW.
> > [    2.144705] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004

...

> Hm, this looks like a qemu bug to me.
> 
> Ilya, could you have a look at this please?
> 
> The above report is a specification exception with an instruction length
> code of zero, while the PSW points to a 31 bit user space address. As far
> as I understand the architecture this is only possible for an early PSW
> specification exception (aka invalid PSW); however the PSW looks good to
> me.

I was wrong, the above bit should be zero otherwise it is indeed an early
PSW specification exception. I'll figure out where this comes from, but
might take a few days due to public holiday.
