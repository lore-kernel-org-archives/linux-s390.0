Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D019B5B1;
	Fri,  7 Aug 2026 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105732; cv=none; b=Squv4LY+R7OIKzww2dJu+8g4O8MV0sAATqwNQf3Hh9KV2DFGqSwlDD5q+KIRzIbOc/bgNuUKKwFiDuy65tgHrc955U278ljEWx4JsyuWEDEMuBhuluiH8J8fOiYcE/QqtUceipED+nYcP0Azqz+bxgbJ7BVEERMR4MisMvNvS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105732; c=relaxed/simple;
	bh=x5bDqzsQB/vzbpgtJ9dovybQnk5uwEbMe2ITsN9xyOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8PFpa79iL5AO8tJnS4whA3DeNI+IKzCpP8AGDxDAIrC+UOY7iNuagO7gDnF1ktYUSMzYGASmbvHdrO2+bB6y7opRVla7rgBQYwuKWtRFoADzVijWj7K6ALNhnFIJSG6LZzZzq8uE6R4+rYZ3MxzCKjO8pGO9uKnHyCdnrlzxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rsUnpH/d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rsUnpH/d"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HhLg4133728;
	Fri, 7 Aug 2026 12:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bSKVmEbhaTVEcY3ja3jrojMO3II7hk
	iVJDyM4+ltcz0=; b=rsUnpH/dyIwbn9oZXUBmBor15GubYbiXc20fwdZRXmmRXo
	PysVoaLdQCnrhoursXagssw2zz2PNGY8i3AdxtJ/7jzwQqXyaBYjOdQmN0By+yll
	M9DZZftniwAJ6OUsM97kcmDkxHhPnAcxzvN0vNqPL0kZSWA+sfkl27hylvKmd7/p
	Aai3G229NOJvfOG84tGlWq5/2FzjTqZCNG4m1qn7KEclqUYd+tBZlOsDxMa5Xgyr
	tnc1rURsVzH5IMe1hLjXsXtPY/6GNbR/6sKB9CQuLnOfRgiDlGcWoI1nlNP5gEYg
	iZvAu4giig7hFS/z6UpTv5tFSNCfyd7/7R6EYEsw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043tx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 12:28:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677CQJ7M024674;
	Fri, 7 Aug 2026 12:28:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgqedj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 12:28:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677CSLl930474536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 12:28:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8BDB20043;
	Fri,  7 Aug 2026 12:28:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82EEA20040;
	Fri,  7 Aug 2026 12:28:21 +0000 (GMT)
Received: from osiris (unknown [9.87.138.170])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 12:28:21 +0000 (GMT)
Date: Fri, 7 Aug 2026 14:28:20 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] s390/irqflags: Add out-of-line definitions of
 arch_local_irq_*() for KMSAN
Message-ID: <20260807122820.17243D88-hca@linux.ibm.com>
References: <20260806190500.3293578-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806190500.3293578-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5NSBTYWx0ZWRfX8h+ShR9MPBFu
 cUyXbVVyANHrKygyVVM0dUPR8TCzEhE4bKA3OMDNszMyblk1JsVB3FprmbIvGtihagcGGHN+eZW
 ENboalb+qJxjK9zK/zkjWw0BNlKHYp8PeCL9x+5UMQsDCXTa+rq4Pcgb5O+diqnd/4usmlC8J9o
 2MsywvvH8Ypd710bHV1o/JCH8CHFKciUYXWJ15UjI2sdWfT96SRz+lJB6gjSKCD/GlWTeWu2upB
 gpaIXSx5fD5oqNSeiScMdXJzYwmjdZ6l16//e9wPZGzkSLPTNAIrGcbQs6IYBjuz8M+GbkecvVZ
 8IkihPTArxxkrAFDqk8pIsaioUwZFgGJxhAE/xuADjEfUnEY3D6eYMYDz9uB5sAwu1SMVpzwn/J
 zHZ3rNSNPGsINYXds4EDBvBi+NYgqAUcZyT97WFxZy/1bh5lALod5jLPcrtYWDPnPSeWYIGZ+si
 T5wJAN8LJz/sxM82biw==
X-Proofpoint-ORIG-GUID: tmELDCYGCw8_PDYTsIjGTqnUokOzjvJs
X-Proofpoint-GUID: JJl-DYUjUoT2-Y9h3sEyc8Yt_whBcZ9d
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5NSBTYWx0ZWRfX1D7ReScQ0zoT
 fsChrtMuoD606cf192Z02SFd6qTUvm8JczhRRQc/iBsz/Y9/nOxYr45dYZmqezSqK9k0RAPxz1s
 qT1Jvx178d6UqOWI++okUzcnemRr/tE=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75cf6b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=5VUgms_2lQgtrsmniF4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070095

On Thu, Aug 06, 2026 at 09:04:45PM +0200, Ilya Leoshkevich wrote:
> Inline KMSAN arch_local_irq_*() definitions run afoul of
> -Wstatic-in-inline. Move them out-of-line. Make sure decompressor and
> non-GPL modules see the out-of-line definitions.
> 
> Cc: Boqun Feng <boqun@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607131219.euJHPSJ5-lkp@intel.com/
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Fixes: 1b301f5f28ba ("s390/irqflags: do not instrument arch_local_irq_*() with KMSAN")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> v1: https://lore.kernel.org/lkml/20260806101740.15764C97-hca@linux.ibm.com/
> v1 -> v2: Fix style issues (Heiko).
> 
>  arch/s390/include/asm/irqflags.h | 20 +++++++++++++-------
>  arch/s390/kernel/Makefile        |  1 +
>  arch/s390/kernel/irqflags.c      | 28 ++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 7 deletions(-)
>  create mode 100644 arch/s390/kernel/irqflags.c

Applied, thanks!
