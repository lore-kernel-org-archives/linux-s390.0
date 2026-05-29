Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F335203F
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035728; cv=none; b=UnBlVWUIHDYrkg0AZt01AaW1BhdGMILq2rjzKNfFm77FuGM5LC0Vuau2WWSOAAGcVf2cUsrQG0GyOsoKNpCpUhmBl9a6j9Iz8QDIDw7REm4+4Rsh1b2ylvnEd2/x2NJ/JBv/kqb0MT4+GI4X2HdZwPE6CPFnkLEPzX8h/cdYxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035728; c=relaxed/simple;
	bh=hsy595PWbjuOw2S1R85Xckoiq9+b/9eIHT8dIY45izc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh/FQXixXXQWo5KiRmnhNANZVdJXRzG2QEby+u0Fikv2Y5vCc40N3Np5F0DhbveDIAGHxTZvvvAu5t9IPH0dRHytl3xBbFW4S0NQaGrsT6/YpaBJcUnpmr3pateC7At1LwrJ3+qw/lRXVLC16CrfT7Pt7rSeXigBfh70yrWGHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H5HLyD/J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H5HLyD/J"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlhfv1684658;
	Fri, 29 May 2026 06:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZbAllhPlZdMaj8MmO0xnHBlturkFwy
	jOnZuqklvdfaU=; b=H5HLyD/JYzmHVcTB1+CBW3j2L8MhUPoKOEEioLqsmD6Kyd
	uYs72OC8xPnRRC5g/0BdXstzF0rguL4gZ2qFXPbck/X0vtBiXmEVGBwrbKCy8DqJ
	SMU83rC742vlj7aISsFVzoVxF+xDcyRKQIbI9xmqFarFH9vzeo+qVBTSP5f0eGiH
	QLEngDnsd6bAkuR4lR7meyiHe1ctC0B7ceQBvEJnRSIMolZB7gyNEqVPQVjvd9EQ
	Fo09MkqkVbpuR4HV5fOuOnsgzp61yMfH09sIMqe+yZ92fNp3OQlY5HAPZcyKpz04
	i6T2LVrlnzOwdCpDKkGeWXogovhWXH9tSKEttEcA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884eyhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 06:22:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64T69Wig019440;
	Fri, 29 May 2026 06:22:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbbxjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 06:22:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64T6M1aW48234932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 06:22:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438C820040;
	Fri, 29 May 2026 06:22:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87F7F2004B;
	Fri, 29 May 2026 06:22:00 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.10.152])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 06:22:00 +0000 (GMT)
Date: Fri, 29 May 2026 08:21:59 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/6] s390/drivers: replace __get_free_pages() call with
 kmalloc()
Message-ID: <1d5ee7bd-b8f3-44f5-b3f4-52bb2bc7c79f-agordeev@linux.ibm.com>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <894c759b-fe6c-4dfe-8b60-3b74916498c6-agordeev@linux.ibm.com>
 <ahhcTBxuT154MmNI@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahhcTBxuT154MmNI@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19308d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=BWsc5X7a-1hmHRxHNtEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: o-qDd5Wwg4pNgrUz1p9RxF80QTljPKkl
X-Proofpoint-GUID: o-qDd5Wwg4pNgrUz1p9RxF80QTljPKkl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA1NyBTYWx0ZWRfX5CbxQXIJZ9XI
 VGpLQw9o6OP1CL4j+udzxM2HPz2ucv9Vo+Gg2jrumz48rKjDUwTOyjYHTmbR0HtgTDuNKPWZ65c
 UX9nYcLdytaKx2dg/xTba5JHwby2hq/U7Rtmd/MjLGcYoJlO94GxwVmGDW9k2D1Cid4j+Oy3+9H
 bXjf9CxgowfQpmoKh6Y5FNJDmQuPgFNn3xEq0iIoilk6NaijucPIXQn2birpSOWrGBflUs93v8W
 sSkULAe7sNlE9w6+iQsaPgm23fNPn77hWvu/sqYnhxLcr7WBZDOwPhzg3/4LHynz2CDOhxF7sJw
 3PxKSsufS9RpvIVz0etsiB54SITqHsx5u2AJQCJTmghQvezu9k46TzgUif/zEv+p0SeTi4QZzQQ
 IgH2pn45ZIVQ1GJZfQd8sGhIwcYDkP25ljlMny6MBobRYng+HvpVAEQNttx62ql0ySiMivcVwFq
 1nhH+F5Ot0RU+WVSfww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290057

On Thu, May 28, 2026 at 06:16:28PM +0300, Mike Rapoport wrote:
> > Did you use a particular tool/script to identify these locations?
> > The immediat question would by why these sources only and not the
> > others that also use the old functions?
> 
> I used an LLM to identify "the most safe callers to convert" to being with. 
> 
> Since every call site requires a manual review of the surrounding code and
> the actual usage, for the first round I limited the changes to allocations
> that are temporary or staging buffers.
> 
> With a less restrictive prompt I've got 57 patches to s390 (both arch/ and
> drivers/), bu that's too much for me to chew in a single setting :)

Thanks for the explanation!

> If you are curious, overall changes (before the human review) are here:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=gfp-to-kmalloc/v0.2

So you are planning to address all of those?

> -- 
> Sincerely yours,
> Mike.
