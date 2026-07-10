Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9275344998C;
	Fri, 10 Jul 2026 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669569; cv=none; b=s6urTiwqr00y4IKxI2zMXln9yaO4md1paF/knNQ1/ifsK3XEjHevRaRkOMmT7O/rkWUp9wkPOxjr64Jmfi3kFHIjxsX6SqVpetO5FSaOzAW87sxuAX/m9j0Tg3vAfMgQTcCWaQLt04Iou3Gs0qW0zhE8XH6fYakOioASwEGWlCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669569; c=relaxed/simple;
	bh=JnAewx0S6FKvY2adyhnGaspuRdr8K2s2RFHu/MiSLTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSQUwui09puJgc6HLbFW4veQqYQ8YuvwfjJhwZRtTTctKktKbfCuzH9KCupXZR3yz/3cTA8r1UaiyspiPDdeuX/ljH6ZFVEi8J0vYxSTzPzZzkInc9wMCbzwxGiu2zmKgtEoN0xaLO/NEEdzVnf65WvD6Vs49mdMWg5CrLZAhFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pj4Fwxni; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pj4Fwxni"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3nhu43493583;
	Fri, 10 Jul 2026 07:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CyR0wawecAlzmWpvQspnkZ1SPMtFD/
	WhOgGDRf6OIaw=; b=pj4FwxniVsMLOfOJjItfkK6qE8nuWON1P8XV9SSuGBw0Ub
	FMEnsdIDqPskXLwn0Iq57pYMbTB6MHUrmIg5FDh8npS1F/xx5XLvEIY6/ELSF0Ga
	KunkRmTy3idqzhnZVNux40co//oAFB3NVDlv8cOBQwa2Gl8QU+4wWn7QkTa4/YMi
	QF8ZXEnEW5NgX5EOheRcp3d21jVc9Jl13M1M1Fc4sAiaLOGf4asDEGq+beClQ/tf
	5kZYGS3sY7exttPsF7HILGYUqTmY+2cVOpGWOc1VupXRKK5EDCUaoSxmd+YKcRnI
	UYe4MPPe27tcA8z5QJPsRJXQdU4AM/a03VexsJeA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke5uy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 07:46:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A7YcVs024365;
	Fri, 10 Jul 2026 07:46:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hrvd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 07:46:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A7k22T51118568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 07:46:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CA822004B;
	Fri, 10 Jul 2026 07:46:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12D1920043;
	Fri, 10 Jul 2026 07:46:02 +0000 (GMT)
Received: from osiris (unknown [9.87.146.126])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 07:46:02 +0000 (GMT)
Date: Fri, 10 Jul 2026 09:46:00 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/vdso: Fix GNU_EH_FRAME PHDR
Message-ID: <20260710074600.17568Beb-hca@linux.ibm.com>
References: <20260706151909.103539-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706151909.103539-1-jremus@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a50a33f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=QIGkLDAR6kq93mu5Qc0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2OSBTYWx0ZWRfX+P8qnVTg+LCp
 i8ogMRzYiwQfHoCplXN5Hh1AAQGDcR2L3+DAN7BG3DlkY5ZNh5feKMVLXJnjBqXZ/dvoeSHoB+w
 tsw8Wc6IjxFeipCOAF70Lhj6mYSQI9plijrAOUa0Kg5OP8r6ak0Hb8hPFhfzec9Qc+f4AH9y+2n
 v+ljZf2oCGUprVzen218ehdLrPn9ggpsrtv9OEnrvc3+nzdVzA9gyOk77tnw4oT8224IfM01kYY
 r26j6r3qQQDl7R6OjGTBDMmW8GHp/PUHsi6BLkyR3obtdfaCxJSvguP7QaEFy0B/AtMqPnc6Mh7
 peOfAALuZzh4pcFr7yr4Xk1XKZyMtu91E74rRnWvUSExkCz86FJxkuQ2hgTckf/NSG48bt4kx1j
 OKpsKofDH4qjAArajEwai00JfHdkJH8Fo5NHLeOyTPYbvK+ps8tAM4kNUh3FPWX9pwXeUxr4Xf2
 sWkPZmzSTiNTZg2pCrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2OSBTYWx0ZWRfX24OcySBjFcME
 XUCGntS6oHR7Aeg/09P6Oab2rVqKUW1NEXtlj5MBqgTPQCIjYRNEHwmYvydBa7cSeKchBX51LSR
 WWtm4aX9No0PbnDPRoeMWJW6jM913lY=
X-Proofpoint-GUID: ohB8wC-d7R264flkU1UGM12Vopt4duFe
X-Proofpoint-ORIG-GUID: ohB8wC-d7R264flkU1UGM12Vopt4duFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100069

On Mon, Jul 06, 2026 at 05:19:07PM +0200, Jens Remus wrote:
> Patch 1 fixes the empty GNU_EH_FRAME program table header entry to
> enable unwinders and stacktracers to locate the .eh_frame_hdr section.
> 
> Patch 2 uses symbolic constants for the PHDR permission flags to improve
> readability and explicitly specifies the GNU_EH_FRAME PHDR to be read-
> only.
> 
> Regards,
> Jens
> 
> 
> Jens Remus (2):
>   s390/vdso: Pass --eh-frame-hdr to the linker
>   s390/vdso: Use symbolic constants for the PHDR permission flags
> 
>  arch/s390/kernel/vdso/Makefile   |  3 ++-
>  arch/s390/kernel/vdso/vdso.lds.S | 12 ++++++++----
>  2 files changed, 10 insertions(+), 5 deletions(-)

This series is in limbo state. Do you plan to send a new version to
address the very minor nits, or should it stay as is?

In any case:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
