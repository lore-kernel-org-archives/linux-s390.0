Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA06336BCC2;
	Wed,  6 May 2026 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071082; cv=none; b=GuKnYV/d8upT9z1ewIw1ce/q5pb/Cx5gUKqulDN2ygo3LOWwSAou8+AvzzqA0Juqml35uiiWV+gCstH4cqHY7wNK9j2OghPT3oqFex1Ol+UP52ZW2cjMrwguCG05AQSnbHojFQQ/8G2O2JRHPMaXd7sNWtOsVOUbhXl+S9DxzKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071082; c=relaxed/simple;
	bh=nwtMCGM4GNPTK9aghg6gQrkRCWVMlLsUkA83Zi1S3vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzmAesuAUQnJ13ETn5FJu/x88t3wNAPXBj6oorRVGpOy7wa8/hFvGXRvyhLZGJFGrq1Vtl0eum6y0fPIUCtCt05mT95KGLdmwkFnwrT96jxepTrMIWBeZn3Oe7ZyhP1J5s9npmeXNxptqVuEFZIT5p8xdGfmGHZ32uZOd22LYb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tJFagwGg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tJFagwGg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646CNSmo2577247;
	Wed, 6 May 2026 12:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qzE9xiBxi2pltwwj6DC7v2tDRCfHl8
	5yteNbKkqKoQM=; b=tJFagwGg2mDqgGCXqe8CCZwcT52Rcr3xMLMa3PeZLxe9aZ
	5wMJZ74NBjkFDydA9jmS9NF7eDt40pqi2ViNZIWPTi94XBxNGkEJml9prHFFYyL4
	J4XXsioM0JadkXlXMu8rELc3uDLkzJREPwop/KKbZtuyU5e0onJauhP8W70Mv7Mv
	pcCjlAokH/oXabICy7KGBz2FOiK/0+9QZVZTRHK5XDNBiVIP/lO5U1lgGtysx6LX
	Kz2sVdjHNgZwqh20mxNQnNz7laAFo3ARHvM59lwR4AMky9iCZnb3UTY8/e8ZBbOR
	KeGj2Ev+Jp8OwUjJnk2pHD7qVqk1vou4hr99e3vA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4r0k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 12:37:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646COX3v020239;
	Wed, 6 May 2026 12:37:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjx6hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 12:37:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646CbsN044237062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 12:37:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77E5D2004B;
	Wed,  6 May 2026 12:37:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BBF220040;
	Wed,  6 May 2026 12:37:54 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 May 2026 12:37:54 +0000 (GMT)
Date: Wed, 6 May 2026 14:37:53 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
        meted@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        akpm@linux-foundation.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] s390: fix dead defaults for
 S390_MODULES_SANITY_TEST and S390_UNWIND_SELFTEST
Message-ID: <3ec20142-09d1-436f-a623-21a2440ef7f0-agordeev@linux.ibm.com>
References: <20260414215651.151228-1-julianbraha@gmail.com>
 <a3adc8e8-ce4c-458c-a0c8-c0e66078589d-agordeev@linux.ibm.com>
 <b3dba59d-22cc-4404-8876-8fd4e22021b5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3dba59d-22cc-4404-8876-8fd4e22021b5@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEyNCBTYWx0ZWRfX9ENoSldcCAAZ
 FDAB1PbDJZZghN1xd1KcCfXdI3YMupPvJIkRBqHvaKk+TBBRzaAIJXBS6gRKAZcyLwL2EyPMI3V
 Hy+0UkZTE4FCo5Y8o3Fd6DsTuFj3mxFr09lMrkOL2sZnKVARhBOataG9OuLx8cKqqxM+BM4zStW
 AXZ1/44/7knIRnCAQshT5GJStlWxgjKUEZZoJhpRlFr/v1dzCBzNGHbXrXmdh2+zROi4O8lAfYv
 3DHoxjCWghKQ4Ysnc6c4izgJpWCaMsvh4Fnycr3k21cvcuyjh2ye3livacfYG5nbaDxl4vXJXnF
 VGGRXayHncbfDkFCbCObPL4woeJSKRq10DUke51E7e8BTeQHuevKgCAytxb8hWqTl5bnm7Jq1+/
 nRPBKrIrpiaOTzNcGa/LANJRJ0GmB9txnIjRWW+OlTMKqNoTbq62R+ykp/0cJsRRIW6xkOdSHnX
 +dsSnKIFxHM6k9XS9vw==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fb3627 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=2pC8PvQXulDHDz19QhAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: BkwR2PwUUTi4Y40Xv7Qw0YHc1ml5JaAJ
X-Proofpoint-ORIG-GUID: Ntra-r3z7J-Ggldeh_q7XQFVgOxWsIax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060124

On Wed, Apr 29, 2026 at 10:39:14PM +0100, Julian Braha wrote:

Hi Julian,

> On Wed, 29 Apr 2026, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> > This tool is still in development, right?
> 
> You can find the latest release (v0.7) outside the tree here:
> https://github.com/julianbraha/kconfirm
> 
> And there's also a recent RFC to move it into the tree here:
> https://lore.kernel.org/all/20260427174429.779474-1-julianbraha@gmail.com/
> 
> > Anyway, I do not quite get what do you mean with the dead code.
> > Could you please elaborate?
> 
> Sure! In kconfig, default statements are evaluated in the order
> they appear (top --> bottom). This means that if you have an
> unconditional default statement at the top, e.g. 'default n', then all
> of the default statements that follow it will never be evaluated - in
> other words, they are dead code.
> 
> In the case of this code in particular, the 'def_tristate n' at the top
> does two things:
> 1. declares the type of the config option as a tristate,
> 2. sets the default value to 'n' unconditionally.
> 
> So, the 'default KUNIT_ALL_TESTS' statement that follows is dead code.
> 
> See also this sentence from the "Menu attributes" section of the kconfig
> docs:
> "If multiple default values are visible, only the first defined one is
> active."
> Source:
> https://docs.kernel.org/kbuild/kconfig-language.html

Thanks a lot for the clarificaiton!

In the end of the day I see no impact on the end result (aka the
generated config) - please correct me if I am wrong.

I think once the tool is officially included you could refer to it
in the commit message, but please do not add the described commits
as Fixes - these are no real issues.

> - Julian Braha

Thanks!
