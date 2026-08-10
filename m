Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97393DA5AF;
	Mon, 10 Aug 2026 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365333; cv=none; b=S328JGXals2ksRgafd3RM/rvCSrQDdYSP1ycnXdoZ7EFdwTT5uc25Ihz6KeRcYi4CcbdMc1RGg2WSZiKzhTKigEEYgWfmCAN5RuyZMT7ojsLo23p0PfChGFkHVLF0awKmkrrW/Q/vc+BaBglk1XhS3Ik47tKOarIcNlMTG9BH+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365333; c=relaxed/simple;
	bh=zPnvtX1kMzUnlSaR2oU4ivrs7ZOGtwf3d8FRP7aG64g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5WToelIKIYjG5sL9PW4lSJ1HFuafJlayljuHKwa9vLAOvmGSdmBi+NOOXqlYUbPpyQfLvWtwZ4vZNBNOdwtnhL/nBOE1y0LFcAQsBwFqgj8Q1xmdcrpMvt9+ngmu+fB0weh0e5p+7tTnDL0c0YBeUM5lBn5o1TFCTT0MKsJ8b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ve92XFgT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ve92XFgT"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9VaxP156594;
	Mon, 10 Aug 2026 12:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2z5Xb5UJdjIEAD2PxXYuyslNfoNf7E
	+rzO3xz6H/4EI=; b=Ve92XFgTOmakYeceT/9luEZKjTbVlg0hqWZ81TSmddBntZ
	hqVa603Ok8D7BJVG0DTj+tbvdCDH8inyvOtzpeOoFYZjqpweNTF2QOEfHFrksfEo
	DwPMeRk8aKuFBdjqnCp5pClf6EDyMd7AqfBeA8C8H5sURgP2wYgwJ16BghodDjp2
	34MvV8IsM3hXi2ww27zLJJlcT2kuMAWxzocYuIaL9Aa3iaKPuO24sA2JibiyIh1n
	lqH4c1qvA+QTS/VO52MhJLL/WCWttkiVW7csf3mp8hDhZiE78+9cLAbsoCA5/yRp
	E0GMX1iI2LVm+udZZbY31a0v4Ss5o5MciwK5XRCw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23gw7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 12:35:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ACQNx1017763;
	Mon, 10 Aug 2026 12:35:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespvwcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 12:35:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ACZDr39306498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 12:35:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C54E20040;
	Mon, 10 Aug 2026 12:35:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEC2020043;
	Mon, 10 Aug 2026 12:35:12 +0000 (GMT)
Received: from osiris (unknown [9.111.42.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Aug 2026 12:35:12 +0000 (GMT)
Date: Mon, 10 Aug 2026 14:35:11 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Bradley Morgan <include@grrlz.net>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v5 2/3] s390: Implement arch_do_panic()
Message-ID: <20260810123511.8689Ad1-hca@linux.ibm.com>
References: <20260810-arch_do_panic-v5-0-e86ae992c253@linux.ibm.com>
 <20260810-arch_do_panic-v5-2-e86ae992c253@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-arch_do_panic-v5-2-e86ae992c253@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a79c586 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=xda2vKbmwTTta3zORcEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwNyBTYWx0ZWRfXyQyAhPksGUQ2
 DK3AKdHQhgk5IpPmL9wrAjRY9Rar4pumocnV+DT0gzGEP+vax2Xoz+L4Ab6plAl8EvwsIe6mGaq
 wmXyHw6Awij3g5rmGsjIF9cVswZh03imgkQeVi4MQ/MM0d/5q7eCWwZzQrryt/P5ar7RyNQoOXw
 8B5Lx529bWdPnnFLjvfAuAIRLibjQQNyw4gkXUHuEvcQYQUlXNqb219P7MnvbU9e/O1h4pBKQuE
 yKNGjIvhBccJQF2xqN95QkmA238xm9SGubTjrir4f3K/B4HCmMs5HgNIKuhjmSkV7VC40X9moZP
 k5wQBQ3YLxua7+zBAbcTohWIxiAw8ZnlwDzfnqPc4aPRWhDvWG1/STvnHEFzVw0Gkh3kytLMBf7
 Gx+2nEW96/hfMTzkL+N+Wpo/pto9X852g93OJS8tN+exDTFKoUWRt7s820Czz6WNwUWBnJeoFA5
 T85WsgBvEwCJ7FinbFQ==
X-Proofpoint-ORIG-GUID: lrLa9ysbDhcimmRgQkkmtHZXQgmR-x8A
X-Proofpoint-GUID: lrLa9ysbDhcimmRgQkkmtHZXQgmR-x8A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwNyBTYWx0ZWRfX+C4A3yQdE0FC
 n9uu13g+BZ8z0X+MTWkBR5uVGdvc2Q7tcqeTNQ6A5BpsNjzKiKfKiVKbl3kPWyvPlhLlBq1jT1V
 bxJTEKriyP6jqyqBKltnYle7K7Yanb0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100107

On Mon, Aug 10, 2026 at 01:35:57PM +0200, Mete Durlu wrote:
> Implement s390 specific arch_do_panic() instead of using s390 specific
> ifdef sections in vpanic() code. disabled_wait() is now called after
> "end Kernel panic" marker.
> No functional changes.
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  arch/s390/kernel/traps.c | 7 +++++++
>  kernel/panic.c           | 3 ---
>  2 files changed, 7 insertions(+), 3 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
