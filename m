Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9632ED34;
	Fri, 20 Mar 2026 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006763; cv=none; b=CkXNXiWDjCBn9d+iNwVpGUeFY20AJcoqsoU2KYCv+Fa1p36O8SnPmHhBDmWsp+f9WG1tvCgMdIeBl4AJMBh2xKpAF6yQ4/7vRSwjZZ3G3QFl6r955/y+ogKfWdzEg+CxgWxYv0POpI8CagmvLYx67xhKkhA7ibpqJnKbpbHYYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006763; c=relaxed/simple;
	bh=4qDVv3xdz6EgdjyrUA5uidlnZvO60Yj9+Udl7m5dS7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKjEckj5xJ7aDDG+2+GgsMr4ZiGCUO9shfF4n+tvmYH+i81Vjx5kfkNiIUWhZSpZXP4jOs17iTO5oD0A3zU4NQqyWsOM4emeVCS11w/lMxPZKckNTvrHmcvd1nURzlSBFfeL2H58/SA6Allfacc9kXKri5Fsn9FYyViIep7sTkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qLVUIYl+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qLVUIYl+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K1kMOU1010865;
	Fri, 20 Mar 2026 11:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FtiGXQ4o382Z+spcVZUj/zZeLSW2Ve
	AgI/kXWB8SXOE=; b=qLVUIYl+qwgLkVAvel60FEhBVYhN4ZBRsA0zM97wDxz1VO
	oACoG9z2g/3eVw87KgVuOrcN49Ojcv1T46KtbUcHPROsKg8xUnSmQbn0E0Tx435T
	AmpARn28RzfxvZ3Et6RQVothRccYYWPPXkbC8fjtVNeQdv46wtED/JeP1uwCdL3+
	P/A8BTluy7KGAdI05jf4MPzABafivPRem4wUXJ1nEpeWyQCgwODBDSaIdPATE5TL
	tGk2EBAiHfu+YwIuJ83BuLn89SPSNooh4WlAaK6VE3Bvb72HIsUmzV4FngT3J7I5
	hdnpa1swVU9ZqMw1WPippTjb3X/MbsTq7USWle9g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3jak0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 11:39:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62K8EEtj015601;
	Fri, 20 Mar 2026 11:39:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0npyew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 11:39:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KBdBo050135464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 11:39:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6353F20043;
	Fri, 20 Mar 2026 11:39:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA43420040;
	Fri, 20 Mar 2026 11:39:10 +0000 (GMT)
Received: from osiris (unknown [9.111.11.140])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Mar 2026 11:39:10 +0000 (GMT)
Date: Fri, 20 Mar 2026 12:39:09 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/9] s390: Improve this_cpu operations
Message-ID: <20260320113909.9681Aad-hca@linux.ibm.com>
References: <20260319120503.4046659-1-hca@linux.ibm.com>
 <20260319135612.GI3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319135612.GI3738786@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JzGcqd2yhUhikjNr24eiIVlsvFVn8juj
X-Proofpoint-ORIG-GUID: JzGcqd2yhUhikjNr24eiIVlsvFVn8juj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA4NyBTYWx0ZWRfX3uW9SqUiD/g6
 FCEph7SCDxHLVvf8W9/Lyxh/T9OhEICH6A7D0Sg1aG+t/DCGOPbjqJ1/l7YAbuwSCngkdkqmsLi
 BLL/tG7KBBsbKYSIK+VWSO0jH4xMgyZfAyjYwZjHFNVRSs4EhDx07rmfydTAnWK5aibnCv/YXRM
 v5RugvSs7wu55iwqFpIPQIgpy3UaUzIFm9DZxBHFnatGPVokvQihl3ZbMRPbIjTKGvCbKIqb982
 cEKv81koaD1J5fVbpZwRYDIlOq7Y61pYLSHKXFR3fCChsjOzrtd6Z40U+3g8oiL5WQMgIRHInXu
 S+8NQeGXxuthmAyPEgI8OoGxVNDWGkvFA2OQllOe8ch/rCtWsygoiZztvBBKZrmgwjmyEgIV0zY
 8Ei2cB2M4agye3lNFclWn9z7lxCWOSbrt93oL3OrheuQmmxFcX0jWXZ9rZ9VxoxSWcfX38PZsCJ
 b+cUryXvPvshXpSKDqg==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69bd31e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=vyBrN-6Lojn0vnrHsAYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200087

On Thu, Mar 19, 2026 at 02:56:12PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 19, 2026 at 01:04:54PM +0100, Heiko Carstens wrote:
> > v2:
> > 
> > - Add proper PERCPU_PTR cast to most patches to avoid tons of sparse
> >   warnings
> > 
> > - Add missing __packed attribute to insn structure [Sashiko [2]]
> > 
> > - Fix inverted if condition [Sashiko [2]]
> > 
> > - Add missing user_mode() check [Sashiko [2]]
> > 
> > - Move percpu_entry() call in front of irqentry_enter() call in all
> >   entry paths to avoid that potential this_cpu() operations overwrite
> >   the not-yet saved percpu code section indicator  [Sashiko [2]]
> 
> Would it make sense to add arch hooks to irqentry_{enter,exit}() ?

I guess it would make sense to have some architecture hook which
allows to run code on all entry/exit paths instead of duplicating the
code n times.

But apparently my code seems to have more bugs (e.g. I didn't consider
kprobes which would make the instruction comparison not work). So this
has to wait until I'm back after vacation.
