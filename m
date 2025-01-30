Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443EC2FB;
	Thu, 30 Jan 2025 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738241230; cv=none; b=M/SV12xUtwPcVnfoJfl2MhmjlHkVFVKfYM5xVdZPt+9FZryY3lsT9Imx9ShcQukZ4iBrrMaANvVGzd1Kcf2xUt+Ecy5ZidUl0liyTOstO/cyqtI3ddb3tReSvrgIMkinHLRRyv+c80i9lE0/dm0AR/NeSvK32xmFCAj9sZpwODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738241230; c=relaxed/simple;
	bh=XFIi9/G4BdxJp/q7ezQ2sTXJjNG8dXMzsSOWQ29LQzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeBzxL8La/tWK2uW6L+pKf6yIwxTeHTp0zKwWdF9Vh1NIegL2cq+noY3KXHAQTIyDRVbsHUVODzYgOnDxr8+B89uPp/6lQC62Mf2pIvY1DPcExnPDa+VsN9zh1xtG/nH0WXUAR077sdRBJ0fn9EQ7dRdyqQbVCcf/Wh4k4r0ADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=McPT4469; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="McPT4469"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TNDpjX024171;
	Thu, 30 Jan 2025 12:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=P7A10YjjX/Sg2ZycU7nTPVJJJYoZPA
	N1YEp6GFHnJU0=; b=McPT4469+ZHA3duOjLKDp+oSl6vIW3nuSih6I8vQTLxPla
	EzxZMXysqNc0e0MlyQuIcDjgPTPHtKU5yUFMvNsZ+MeVJ/PTGHNv8sIJCdMrWNfc
	nETY0GX4r4szLBLxVHGIQ9dFHSnuK0P3VkTxb+WIGm/JV3ZpFkzKqMyIrQQvDjpn
	4yCzGnN6qgIcBvVnokzLwJjnoKMst9LHaDQHVwqsGDO40XbB86ZzbtR8IKbCjXuo
	+3HId1WuzGXyBjvSW2vv0B+BTW6aeFgZ7U1x7ewB/MJ5CnqGkx75OGojJFMZiW2P
	NjpKsRtU2PurSdOYAJidpEi0aJiUVNQVWEhkFStQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fpm1nhwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 12:46:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50UBUwgg012337;
	Thu, 30 Jan 2025 12:46:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44danye8u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 12:46:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UCkmPq32899692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 12:46:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6379E20103;
	Thu, 30 Jan 2025 12:46:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2252E20102;
	Thu, 30 Jan 2025 12:46:48 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jan 2025 12:46:48 +0000 (GMT)
Date: Thu, 30 Jan 2025 13:46:47 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-hardening@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/vfio-ap: Replace one-element array with flexible
 array member
Message-ID: <20250130124647.15115-A-hca@linux.ibm.com>
References: <20250116131859.105756-2-thorsten.blum@linux.dev>
 <20250129213826.291cfe12.pasic@linux.ibm.com>
 <85863d7a-2d8b-4c1b-b76a-e2f40834a7a8@embeddedor.com>
 <20250130114615.6f591882.pasic@linux.ibm.com>
 <Z5tkaaMNh83x2t/x@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5tkaaMNh83x2t/x@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m4jugxUgEvR6yqup8jLp5WjVveREgZ-n
X-Proofpoint-GUID: m4jugxUgEvR6yqup8jLp5WjVveREgZ-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=2 bulkscore=0 phishscore=0 mlxlogscore=166 spamscore=2
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300097

On Thu, Jan 30, 2025 at 12:37:13PM +0100, Alexander Gordeev wrote:
> On Thu, Jan 30, 2025 at 11:46:15AM +0100, Halil Pasic wrote:
> > > > I'm not sure I understand the value of this. What we have here is not
> > > > a flexible array but a one element array. Something that in the generic
> > > > case could be many but particularly for vfio-ap is always one.  
> > > 
> > > You are correct. Only fake flexible arrays should be transformed into
> > > C99 flex-array members [1].
> > > 
> > > Thanks
> > > -Gustavo
> > > 
> > > [1] https://lwn.net/Articles/908817/
> > > 
> > 
> > Thanks! Alex, what do we do with this then? I think you picked it up
> > yesterday late. And I think, it might make sense to make this look
> > less like a fake flex-array...
> 
> Dropped.
> Thanks for looking into it!

Given that we already have 5dd4241964c8 ("vfio/ccw: replace one-element
array with flexible-array member") applied, we now end up with inconsistent
code. I'd prefer if we address _both_ code locations in a way that the code
looks similar, and people won't send similar patches again and again.

Halil, since you started this discussion, can you address this please?
