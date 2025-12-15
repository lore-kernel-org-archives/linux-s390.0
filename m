Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534532D426;
	Mon, 15 Dec 2025 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784996; cv=none; b=bqv4cOlJzYXEapm+JR6hu/vQu4Fc4Xo0fSGiMotaLOd6p1BJNLI/yhTs6/gVeXNKxiv8FA74Fr1OJN9BuAQ0FZIFraygP4L9qVSS6lY7Eds7MRcs1KAMDMDtCLDWe4FjYwdNNzV/VMAdiWo6FAQ0haFs8PZW2xhac/2y9YXhkUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784996; c=relaxed/simple;
	bh=PNvUNg+Z3TNMTtEKPApc15v1K/IksAerz0HrFia5gts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO2G97HOLjjYXenKakj+lXg5PKqQPHyGa/fWcpCfnPeL6x5xA9dJ4vc6I6V6SLKfIFLMOoFzwz8ixq6O2OE57BD0Rc3F+xCtdhphZ5lxtCFcd9m99Db0ovbEW+C0eIEFCSlI3jXLOUywPj6fKmibg0keMYUdry9TAQqyVVgQDkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qPF9HPBn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qPF9HPBn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BEKF0w1022513;
	Mon, 15 Dec 2025 07:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SDjBfb1MSSR8AbXvVjtMwPIfxrW2FO
	1Fv99ClsCT2+8=; b=qPF9HPBnUXHKWFIuefF2pqB0NLtXIwAvmKjg3D6H+UVq+g
	iEZo9lPrejaBCuFrX32VIQ6fdcZF+ACZDVQ60QwrpwS59H5243QiXPKJqzI6Bqp7
	ornC6UfhFTdFSU9M28fWkoea96XpCA0Z2dILtT2tf2/j4lPZmlUT6nRnsnMvmea3
	OLN9Wo0MWE4hRiRFgYMc3SwndEXi7kbXClRNXUbsjolAAsz0XfUrlOO+XnoTIV7f
	5AzvVPv0YfkrFS1yrpcu8hNx0ehBalYWoP6T5p/cSWuMXVkhhVsC5D2VpQqgGvK4
	VLVPQBXVK1L/0wHiRXsizELjZ7vmvKbSujeQL4WA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkr4qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 07:49:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF6FAvA005686;
	Mon, 15 Dec 2025 07:49:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgnksyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 07:49:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BF7ngWt60227874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 07:49:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD11320043;
	Mon, 15 Dec 2025 07:49:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 031C220040;
	Mon, 15 Dec 2025 07:49:42 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.60.230])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Dec 2025 07:49:41 +0000 (GMT)
Date: Mon, 15 Dec 2025 08:49:39 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: change all pageblocks migrate type on
 coalescing
Message-ID: <ee518adf-3a07-4e08-9a6b-f5faba5ae073-agordeev@linux.ibm.com>
References: <20251212151457.3898073Add-agordeev@linux.ibm.com>
 <5e79bed1-598d-4e34-8f1e-87b6dba52bf8@suse.cz>
 <20251214160606.GA905277@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214160606.GA905277@cmpxchg.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JIJub7J5DXMnihwn6S63GJ7sHIpsKJ_W
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=693fbd99 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Hnd01_47jJv9e3yHuFcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: JIJub7J5DXMnihwn6S63GJ7sHIpsKJ_W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX8yTGGcv2gyA1
 zURzqJtX+YO4yogXW3v0DPGIJ8PvzkKLqdsM/EznvBWs6Bh+3e0Xbw5WqbNuSbdST7+JmElWU/o
 jZjlM+c1oJW/VgC/6M5qiYDvFrQZhsD1cZPqvq9/TmjuWfCEWDgJFYx8b9qTVep4zAdd6YA2GI9
 KWq+QXtsHpbXIPeh7Cm6LVwkC4iizw4hCB3HvRcm6lczNxdJ4ce6m187JNGqPDNqcA01EvBnqve
 Pz704PuNX21cagbNl3VMOqz6uYW1zez+xL5RhPXgc9ZgU7FlxS1bcKfADenx6tFktVbKtKXqxP+
 qs8nxkyJdKE+hvKaFfvH3CxYLV5iPnKgBsqHXkafOUMR8qwuR/VM9AE4t7S6krZ63Rerr6cNnuv
 j93EOjoOlm/nz8UCDJyX7o3YOJIyIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009

On Sun, Dec 14, 2025 at 11:06:06AM -0500, Johannes Weiner wrote:

Hi Johannes,

> The warning makes the issue loud, but your patch is arguably fixing an
> earlier commit that introduces type updates during merges.  How about:
> 
> Fixes: e6cf9e1c4cde ("mm: page_alloc: fix up block types when merging compatible blocks")
> Cc: stable@kernel.org

Yes, I was in doubt which commit to address - thanks for clearing it!
I will remove the last statement from the commit message and post v2.

Thanks!
