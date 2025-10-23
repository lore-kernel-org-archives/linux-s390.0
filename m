Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A732FB966;
	Thu, 23 Oct 2025 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232755; cv=none; b=hJOWlYSm5MYRsHfTsiRGqac1lOWS76Q1tSJchE85iOnqrQvaNLPmQ/IpdEPcZQmdRSHusDq3RLL/l0Ky2jYFBizlFuQPNPGpC9phK7emw0Uyw/egiKRiltkAwcGYifL2VjupAhdJgBshGhe3OsR86RW7vhhjg+syZBPc/I8/QwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232755; c=relaxed/simple;
	bh=7mp+ulcuJyz+KhmIvgVLg3IEruViKD3914aiIo7p83w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVySFaktM9LHc7jLekQZqHHGd6LycGLYCn6zC5hRstERvvt5DMuxJd8/40oBHZLjQNDR6YjVxn3sPIGnB+gAEfdaiZmwLVuT9ODm9jnutwawnk7A/368PpP+boQBHHdREFKvhp1HRtQ1GqGdmuucJbqD4zxufSCZQCbI4kWnasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lc1UekKr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lc1UekKr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N68EOj021232;
	Thu, 23 Oct 2025 15:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Nd4SaKKMA98JU+k00ehlfYzKtXQpGD
	xZPBuap1B0Xe8=; b=lc1UekKr5J77Cnjc25zwQaAHfHG8IOucuz5ZN+cVMMR5UM
	OSQK6nFneg969ppvgOV5BINVHd83uHQyC9SK0MzNmnKaLr+MsLLVnYwRtMjcEz5V
	taS7QVQEPf8T0ygZ92gRDPy1Sw/jgv1YAfna6SaFewb6Yr9ms1tRbuooEiUjZDo6
	CVFdj/UMUSFHhjtnOEmVMeo05N9npMfPPpZqKcyxAtliB9GMmkpzAmSsfmyMT4ql
	Ka5MPbIULdmxdq1jyd2ZrN5CIOXoOIt4hWoQ8q2QBiotsFstJk+bQgFM58iFRYTQ
	nRrq8KPC/S+CiZSQdnYRKZiVGAbzC453lOd8xukg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31chkbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:19:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NDTkWv017058;
	Thu, 23 Oct 2025 15:19:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky6jqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:19:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NFJ8mm50200868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 15:19:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7595F2004B;
	Thu, 23 Oct 2025 15:19:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43E3420043;
	Thu, 23 Oct 2025 15:19:08 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Oct 2025 15:19:08 +0000 (GMT)
Date: Thu, 23 Oct 2025 17:19:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v1 1/1] s390/pci: Restore IRQ unconditionally for the
 zPCI device
Message-ID: <20251023151905.9536Ff2-hca@linux.ibm.com>
References: <20251022164727.882-1-alifm@linux.ibm.com>
 <20251023074028.9536A84-hca@linux.ibm.com>
 <d611c17f342acc0d00b9921686474007a7d29213.camel@linux.ibm.com>
 <20251023120003.9536Ca9-hca@linux.ibm.com>
 <d3c612a9c5c9588508ca396baee2131699467bf8.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3c612a9c5c9588508ca396baee2131699467bf8.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XcAiDbq5XB-x3amTGgZs8fH-XvsjFAzv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwkZ48PzPNgA3
 lqyUHj1jLk1lO/qAYVxjTNXuEvBFH+kba8UNLCoQORX4GRq6oTuz0G8LZhIYZiPMkDlDXKOL+Jk
 oy2kwmgqMdvkwmP/a5ZWKoSXePAOOo7kxXqE831zmtcbKblhbYehI+2mLQpuQIaC6lMOnJUgVz4
 iTJ6KHDhcO8ApbH6zl/0hr3wjG/m6MaT6tHy4HJtlNL8kLlef9cWSIi5XmOSM8Ke1x+mj/FLQyJ
 xuS5tUv5Ct53KYAR/pbZGMkFFke9XHds/Gc5Q35Q0LK9HHd9dx+sN72EvBU8VyF/l7NuOB/cIss
 yHerpaiRw3skYm4g79zIJckFUHqt88YNWpLJeAarcQihKptJzGahjR3F85ZXRLVDJ75kl5sWBE7
 1RfzBUPnwevDRKYnVpSoF1fDZ5sy9g==
X-Proofpoint-GUID: XcAiDbq5XB-x3amTGgZs8fH-XvsjFAzv
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa4771 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gcFOmungAAAA:8 a=x38vKZ949yAUv3xi-J8A:9 a=CjuIK1q_8ugA:10
 a=mpxIG-sAcrd3FiiRqSpR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

> > > That said, I agree this could and probably should carry a fixes tag
> > > since the logic is kind of broken even if it doesn't break anything at
> > > the moment.
> > 
> > Can then somebody :) provide a tag, please? I'll add it when applying;
> > no need for a new version.
> 
> Of course :)
> 
> Cc: stable@vger.kernnel.org
> Fixes: c1e18c17bda6 ("s390/pci: add zpci_set_irq()/zpci_clear_irq()")

Applied, thanks!
