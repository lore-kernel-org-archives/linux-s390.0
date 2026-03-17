Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E8534DCD1;
	Tue, 17 Mar 2026 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747739; cv=none; b=cfuV6Y2/9umw9loXuIjwfgrRmnye4NV5bOUnnkuLIC3hiLG1JOsNKE/y5/YrxrqSpxeY+MEogXLdWT6hz6sgLlWoHmAUQLCRBkGipVtO1jIjnugFSBZ9kVSvODUT5AKY8OWWJVKvaMk+ntcj2ekMkTVQYKViYQqFSxHo5m4bQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747739; c=relaxed/simple;
	bh=0VahozmPjvOGvKm6LYH9TvuYbVuo0ivrVT+LLsJ8p8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hET4IpEXpw7fJ/w+AkUDKvf5RDECb3pnEiD6g1UBcPiSpYOjnHLVTzuyxmoV3KeCPLcnBxVRIKjIv8SGel5z/UODrLLUnqpItjdNFlww5Zo/ggJvZoBGjGedteEyAvALpnDNjLJfqRTtLB3C0GhL7XLFUEGK0IfUKVuJWFS7LbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H3c69P+c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H3c69P+c"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H8014O853168;
	Tue, 17 Mar 2026 11:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=o+INkhhiricWTdX4Z4bsVrL31b3fM/QC7fkRyiDwdiU=; b=H3c69P+cnPjZ
	CHa+OkPyATcgyXuaq4HbhSQ7tKbPF3rVsUuFmFD/TdrrOzbxwfK7YeIYTX6ocHYk
	dtggmGH1zQ2Tx84opo45owtbzwfvWlh15fErzQRZ5tvZD7gAPy874Pijqlz4kJ+T
	LpBsTF9lUmQwS63j+h5hYu4JrvHjgd6mFhjNG5jAAdY7KDvuWpvRH9bDa481mWNW
	9jn+GioGsgpfxHv27ECFfqt8CtBLdf/MJja3pL7XrR1PhwL8oDnZ0weugT1Ie53G
	f9nex2MS7S2UcrKEswM35FkdrDIIOukTP8Do1QQuLMEtpOWtQqAPUQNx/nZUGbaO
	3ISaufiLwQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaubwts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 11:42:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HBU4vV028713;
	Tue, 17 Mar 2026 11:42:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk8vy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 11:42:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HBgAkD33292700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 11:42:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 996942004B;
	Tue, 17 Mar 2026 11:42:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82DB620049;
	Tue, 17 Mar 2026 11:42:10 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.87.130.152])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Mar 2026 11:42:10 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w2SoM-00000006aTd-02AY;
	Tue, 17 Mar 2026 12:42:10 +0100
Date: Tue, 17 Mar 2026 12:42:09 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH] debugobjects: Allow to configure the amount of
 pre-allocated objects
Message-ID: <20260317114209.GK2161595@p1gen4-pw042f0m>
References: <70f06193b3c3581802710ebcef74671e50c4c979.1772035270.git.bblock@linux.ibm.com>
 <20260311100431.GC46248@p1gen4-pw042f0m.fritz.box>
 <20260311104727.8f7b1492141b6d61fc1b2791@linux-foundation.org>
 <20260313142620.GG2161595@p1gen4-pw042f0m>
 <20260314150649.9a7c4bf4554b1288eb471edc@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260314150649.9a7c4bf4554b1288eb471edc@linux-foundation.org>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEwNCBTYWx0ZWRfX6MBh5la28dvn
 5O8qzfcBqNY6jwPnEAvFLYVATdguloORjvGQ9kklIADq+yI6dLhAi+xdHIDUrtdz4qub7g5tJdX
 tStbRUx9Zg4y4mWxR4Aq2eb6MNdALGEnw+kM1AmmwRA2ZYl+THkqYbvxMadzAKDRlQ8MUD4c5JV
 Q+JgzyZlBqLsqhax6M7faohtOA9qXSuXTOn0ps941EnCaWqdT3nEBPpIKo3Z4h9Ir7PLUnMIN23
 XEk4pWAYQiCcjsdXaHfsgLK0fgfkqOBWMd60dzf2jeMaUF0CXKdxyIovFhkqLDXbkl0tcxxeQd3
 pUEzeKSp+b2AReqd1PBKfA7nGTWeX0hOqJr55stiWuuE9GtqNjakUw4C9z+ftZdE8zdr1/zjcnF
 VryJ+3LoNigKaOAjpkqg2KM3v36GIHnklQ5bdabTMeqVk2PLBG3EHMX2oXgJy3ggcSI0Ma84Uf2
 GHzEAknFX5RMdCzZKYg==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b93e15 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Vt2AcnKqAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=sFc_lIpcBJkQizF9-a8A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=v10HlyRyNeVhbzM4Lqgd:22
X-Proofpoint-ORIG-GUID: tnynZe1ulNqDZgxldC2rtLFvjPhmEY5X
X-Proofpoint-GUID: tnynZe1ulNqDZgxldC2rtLFvjPhmEY5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170104

On Sat, Mar 14, 2026 at 03:06:49PM -0700, Andrew Morton wrote:
> On Fri, 13 Mar 2026 15:26:20 +0100 Benjamin Block <bblock@linux.ibm.com> wrote:
> 
> > > obj_static_pool[] is __initdata, so the consequences of making it large
> > > are very slight.  So do we really need
> > > CONFIG_DEBUG_OBJECTS_POOL_SIZE_SHIFT?  Requiring a rebuild is a huge
> > > hassle.  How about simply making the static pool much larger and leave
> > > it at that?
> > 
> > I was thinking about that but then couldn't decide what would be "big enough"
> > as constant value for "everyone". My test systems wasn't even that "big", and
> > I'm already at 1280 KiB reservation to make ODEBUG "survive" the boot. Not
> > sure I want to make this say 2 MiB without config option for everyone.
> 
> 2MB of initmem probably just doesn't matter.  Annoying.
> 
> Do you understand *why* s390 is using so many objects?  Presumably the
> current much smaller default is OK for most systems - my googling for
> "Out of memory.  ODEBUG disabled" turned up very little.

Frankly, I don't know where all the objects come from on s390. I'll do some
digging, and try to trace the sources.. let's see what I can manage; but I'll
be on a trip for a couple of days.

> Oh, look what I found. 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1807440.html
> What happened to that?

Interesting, indeed. Nr. of CPUs and Memory. Well, I had 32 processors and 64
GiB memory, which all things considered isn't particularly huge these days.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
