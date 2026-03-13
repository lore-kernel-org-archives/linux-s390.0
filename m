Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949C4C6D;
	Fri, 13 Mar 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411987; cv=none; b=AdN1dKnZfM0x4JRN4MZ42ApHHNFHqYWJ2E0xoh2LvRSW/hvmC9nbMoJ+/L6KdE/tep9/RLTgVAz+M4B7TmmM1hmqtWpiYZBQaxWqJsS3ZRTBxdfBmXruvIriFvRgKewY0L8p5Ib/y6l9zwaZYf0e+Opfkp7nDxezSmQRmq7uBFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411987; c=relaxed/simple;
	bh=cB1KVl0o9kqXLBzs2O+Fb7p+tx87FMP516kiMwVl6AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJNb+SbvuBV565JooT94dtYmQmYiUgIUa4Qvd2tTaq/oxUGM9Yva/uuIjLN6Zt32qh53MDGEI+ZoJwjz+rtiUCwvGB75h6PtLLkvVbxFPrLISZs/zCo7Qb2T7PW6eLAXKrUSd7rg2HAR/iRwg9ikgW6Pd9rsx0YcphL8tO6u+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zm9WktGf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zm9WktGf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6TFTX2581705;
	Fri, 13 Mar 2026 14:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=8ptQm4aXpTZmA2zIfl0xK8v0HN0gBuf/+lIfiF8ZMlY=; b=Zm9WktGftSeG
	tRYuDPxC6Q8AteT2DAq0YTrigOub+5cjZX3/Q3HJKYUAnTHOyJB4RPi6ijQMg5se
	fgmrZPHz4SJW65MU7Cgw3lVUf6/rGBWP2ZptHKlDrNFNUzdjPI6fRFFKYWgFNGyu
	wbXffIxnI7PF18u2vOTijAxQqp2FngMIEuCdN7f3l+73czflJZlisI4TS1B8KjaL
	14HyovGSA4ImtmidtBkh5pCr/Z37bC1OU2Qp7I80CoQTzc6OAT6aMA1lZU60l2Mb
	zeqxcB/egiTbtvqoXSKFzaCB+BiLRJkwjkc2caSKGdwNO+bkpRHnloLtpzk7ouAG
	zfTk8l6Xsg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh9508w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:26:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAFO4r014698;
	Fri, 13 Mar 2026 14:26:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha8f04g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:26:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DEQK2Z26673526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 14:26:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76D262004B;
	Fri, 13 Mar 2026 14:26:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6749C20043;
	Fri, 13 Mar 2026 14:26:20 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 14:26:20 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w13T2-0000000FEtQ-0Ytz;
	Fri, 13 Mar 2026 15:26:20 +0100
Date: Fri, 13 Mar 2026 15:26:20 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] debugobjects: Allow to configure the amount of
 pre-allocated objects
Message-ID: <20260313142620.GG2161595@p1gen4-pw042f0m>
References: <70f06193b3c3581802710ebcef74671e50c4c979.1772035270.git.bblock@linux.ibm.com>
 <20260311100431.GC46248@p1gen4-pw042f0m.fritz.box>
 <20260311104727.8f7b1492141b6d61fc1b2791@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311104727.8f7b1492141b6d61fc1b2791@linux-foundation.org>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b41e8f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ERy4sdM4mJLmFq4x3_AA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExMiBTYWx0ZWRfXwpWVJQKE9Hfa
 q3408Gh49c7Wl//v5BNX93dOpm5eDQR/o3DtVJbVUxJw61l97HQplncIvf/SBf2Bk03iX2z/F5k
 3c5IRfZ9WLJ5yc0GUT8IxE0asN3rEr86D1YIwdezvA0EnrxiOZwk2xJzSQG8XF6O7CQuonfFX6o
 lVBnHag5LNmmYsUr6CXfTZcDmFttXKHXx//b0/gMo4GZQJowEt2uadnu1EB9ihCo5FL38+0Xoxc
 hmT5hISepa5eQAxNQZDO1VFtpXRnN0oVUlzKG4u2BIFTLfYo4kvSjbgjsDPwZFqP8DKn1DuqPDH
 zZNKeY6sH4YZHi02SlUmyi/Ho52TunNv8Y5wF9bOLENaXMzPE8FTq1cBv3Tv+EgRqT1aAXktRi1
 l0vXEqjX/d+1Ii12x2J67kRZ+qSSei2/ME/Py61HblqUB/ZKzx1N0jaHGZBvfYBfZGHw8aqBaQN
 G+IQ2TW3io5mKD6CJYg==
X-Proofpoint-ORIG-GUID: EOHX5A25DJhv9UfVwyFasyCIAjD0xgux
X-Proofpoint-GUID: EOHX5A25DJhv9UfVwyFasyCIAjD0xgux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130112

On Wed, Mar 11, 2026 at 10:47:27AM -0700, Andrew Morton wrote:
> On Wed, 11 Mar 2026 11:04:31 +0100 Benjamin Block <bblock@linux.ibm.com> wrote:
> 
> > > ---
> > >  lib/Kconfig.debug  | 32 ++++++++++++++++++++++++++++++++
> > >  lib/debugobjects.c | 15 +++++++++++++--
> > >  2 files changed, 45 insertions(+), 2 deletions(-)
> > 
> > Gentle ping, any comments at all for tis?
> 
> Normally tglx stuff, but lgtm so I'll add it to mm.git and linux-next
> for some test.

Thanks.

> obj_static_pool[] is __initdata, so the consequences of making it large
> are very slight.  So do we really need
> CONFIG_DEBUG_OBJECTS_POOL_SIZE_SHIFT?  Requiring a rebuild is a huge
> hassle.  How about simply making the static pool much larger and leave
> it at that?

I was thinking about that but then couldn't decide what would be "big enough"
as constant value for "everyone". My test systems wasn't even that "big", and
I'm already at 1280 KiB reservation to make ODEBUG "survive" the boot. Not
sure I want to make this say 2 MiB without config option for everyone.

> Some statement (or, better, comment) which reveals the number of bytes which
> are (temporarily) consumed would be useful.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
