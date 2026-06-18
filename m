Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF617A2F6
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758411; cv=none; b=leMvL3XOX6XU50RlhoYs3BmbA4HSHmQmur69UGAVFzJsC7X4oVV1fWiaskNj5Rw69jwqt+CLY82aF+KteXoKwqenGuRNLPDglZHdOAcihfME6vs+bGKNSztm2EC1bmRWY4ji6hz1lY4ZlijkpPt9dnEBkvF0ESgNGXvIP5VnEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758411; c=relaxed/simple;
	bh=MFhm8l4ruf2fEooaIu+l37twdALwn7UPgwdKawBUxs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1b1DAPprjuSLqHfo71tBfocMy1wrWI1JDKaEv5mvGq1t21PLVuRkRr8a7Z8CvdFZMfvkkzSiDM7P/Flsr+mlWUwKxfjf2jF+N1GNY9fVgDu8mSZjwaooKJscA3clzMmKPCYzrTJ4wRSKqzmOj0tDyz62Sy5NDEiKNBxfqMaQsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VJPm5J4a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VJPm5J4a"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmB6c1250639;
	Thu, 18 Jun 2026 04:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iRDHw4
	U2SLV51NVdDtkRblwAmzHvDfjgBhBuXsp9gQc=; b=VJPm5J4a4cYDzHFSFQPpO8
	YK782U/pIlSvOgZd6c4+EA52uFvDiRJSHgrBHzj/QXQoTFIXkOpTX0RSHE5FSUsE
	CfG5Blmn2UJH+/SoWT1cCHLYOoCmvcOKKUEI9JrY2PO7ffNvnPeJXUkEf6xHGQfc
	f5WoLamMCyA5HsD1Hst4jFMmp5UV+oIU1mQvrwXPmkW8b2tKG9TFmnptikMQOnv7
	AwLKxfbonOiG0vcxx9Bu4/gdAVAT9mwP2YFJuvL+ERolc86KnctDMNuwUZgIUquJ
	y0p5dtMNnCJl1iFOf7+qbUttWKeC+XyKAnJJCZUR58dEiIuRsebC6OZZK84kuo9g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ6bd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 04:53:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I4o2Rw015908;
	Thu, 18 Jun 2026 04:53:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a0c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 04:53:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I4rMP242402096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 04:53:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D435B2004B;
	Thu, 18 Jun 2026 04:53:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B50F420040;
	Thu, 18 Jun 2026 04:53:22 +0000 (GMT)
Received: from osiris (unknown [9.224.90.220])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Jun 2026 04:53:22 +0000 (GMT)
Date: Thu, 18 Jun 2026 06:53:20 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH -next] s390/idle: Add missing EXPORT_SYMBOL()
Message-ID: <20260618045320.11310A46-hca@linux.ibm.com>
References: <20260617145313.3910957-1-hca@linux.ibm.com>
 <ajLJhMC9SDjeSQtR@monoceros>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajLJhMC9SDjeSQtR@monoceros>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0MCBTYWx0ZWRfX5Fl1nhy7R6sA
 WKQ38gFHE/+IhTjVQjWnB8WIhlfo0fMxr3avfpGmrGCRGDd1Z0cg4dUkA9/8igX2/DnAXT6JooW
 RjPB8jvzlDJL6TIbl1aK0w9briB3YZM=
X-Proofpoint-ORIG-GUID: L6yFC2SqkXr5DCb8CzhrtYlsYQahUrUq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0MCBTYWx0ZWRfX4FW/RjYLWz04
 saD74b2b9j2gSa4N2IkMfwt5jrLb8OPp6bHfV6hUzS7IviiXjZHVNPyGxS+BhLe0p/70OtV4U28
 2NOwGF0L4IgPi3LimDyA0jcMFFPH5NIPpg7hU6on8gcF3LbCf4kDeZXOwCi3p+htc6SshG1O0IG
 LTvlFxJiJpPd+mRPwruEpjiJyb/za4ZAn39nhzg02ZkaMlgC7h8tdGQLOoaF1jCZr7SbSfDcC8I
 TvyoFo/rHG7q2gUbK+YtpAp0/Tw7zK+6d4Pbxz+NKx3KMFo7ZMjfpV7rA2jlz9PV2fgIBxkJ+m5
 tHPINn6sbOgXxOSsQWUmyzEo9TWDnTkJnma20rWy5kpVcu/+HPIuNNDNTxmiKk+RO/4eSIaG26s
 Blp6ZzaE1uY/FULGKGp8/UmJ9OMPgc6o0kT9kJpfCLGNkapWUNjRr69qcO+ZIGk7msZiNqPCJZE
 p5MVqIGpIVTqMD5O6fA==
X-Proofpoint-GUID: L6yFC2SqkXr5DCb8CzhrtYlsYQahUrUq
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a3379c8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=IpJZQVW2AAAA:8
 a=AznObN8yMimW66WVoNwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180040

On Wed, Jun 17, 2026 at 06:25:07PM +0200, Uwe Kleine-König wrote:
> On Wed, Jun 17, 2026 at 04:53:13PM +0200, Heiko Carstens wrote:
> > Uwe Kleine-König reported this build breakage caused by a recent commit
> > which provides arch specific kcpustat_field_idle()/kcpustat_field_iowait()
> > functions:
> > 
> > ERROR: modpost: "arch_kcpustat_field_idle" [drivers/leds/trigger/ledtrig-activity.ko] undefined!
> > ERROR: modpost: "arch_kcpustat_field_iowait" [drivers/leds/trigger/ledtrig-activity.ko] undefined!
> > 
> > Fix this by adding the missing EXPORT_SYMBOL().
> 
> Did you consider EXPORT_SYMBOL_GPL() which AFAIK is prefered over the
> non-GPL one?

My mistake. I really shouldn't write patches in a hurry a few minutes
before I shutdown my system (what could go wrong?).
Sashiko reported the same. Will also be fixed.

> Tested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Thanks a lot!
