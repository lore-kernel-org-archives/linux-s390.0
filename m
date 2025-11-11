Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7FD2F90DE;
	Tue, 11 Nov 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860861; cv=none; b=CBmhhPajGHBSOfR+i4AbTC9EzkBDvr4wI4ui6rbIoyJZ556ciF3Sadb+r2KojEdzvC2KZaTy8OXTv/z7F27zpaF9at/xU1cfdLDL9SgiVZ3HzntGnhv1i/4E/S15Lk/T+F0fmY/KTLPpSjZrwI16pyp+Bp9veU8rcBkAP2xRWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860861; c=relaxed/simple;
	bh=kocVr2Dpl91oUEtI35ZgzEXJi0aefoXjocA/MF3uR/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAf2wzkjGIkPKqggyGn7jvJpRSRKMqaVMi662GsIf5Vzm9wVHNClF1teJQ6+qQRgntH+D2on6J4Xhe7EsfMohwb2flTwjOq0zy6obl58vNQSkS7gkPodZ7nPo4/XZNHrZClXy/gqb/KmJZ7aanoogNvlRICJHWZ8K6I7Rf4c4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iqvtZoji; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iqvtZoji"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAKjEGA022632;
	Tue, 11 Nov 2025 11:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2yRxE5f3QKPtWWmwJiCqlnY6QVijbd
	OgRGXf7AvOJ1o=; b=iqvtZoji7EplJqZIgTHaWbdI25KNCHc2m2j54Ga3KaFSby
	IfyqxB46l5cYHD6Y+zV4fXrnuw0O1hQSzAQgYLZQCCoCAzDL6eym7Xe5Rn0oypnG
	R86cviwcWKjaR0WmIJDd9tG+PBqMJWHcf2h/4JbM8cXpDzNIzvY2JiA3Rl2+2eVE
	3GJgf2ZsiMdvUejpWdwukE6gLTn4tqwLtWBFfebr5v6k72sn2W363dUfjufcwzwM
	kwDnZJJgo6C6sHs15VtJxxV0saRX6uKNxTxB6X0aUv+KNqpoDYrLU5iWlFxJkteG
	xz8GIt6EGB7dlIkkhIpQIbkyqvg3sQ+MvvlVopZA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m82vf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 11:34:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB9P4Mr008182;
	Tue, 11 Nov 2025 11:34:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6mtgqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 11:34:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ABBYCPA38535624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 11:34:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91AD620043;
	Tue, 11 Nov 2025 11:34:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A01420040;
	Tue, 11 Nov 2025 11:34:12 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Nov 2025 11:34:12 +0000 (GMT)
Date: Tue, 11 Nov 2025 12:34:11 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 5/8] s390: Remove compat support
Message-ID: <20251111113411.8887A5a-hca@linux.ibm.com>
References: <20251110185440.2667511-1-hca@linux.ibm.com>
 <20251110185440.2667511-6-hca@linux.ibm.com>
 <fdeed5df-5c97-4df6-9475-874fccc5b0c5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdeed5df-5c97-4df6-9475-874fccc5b0c5@app.fastmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=69131f39 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PIVeMw-qnhxw_CoLOA8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: iUWNaTwXUMqaXLRX4Yx5nd24Dzxs0AV_
X-Proofpoint-ORIG-GUID: iUWNaTwXUMqaXLRX4Yx5nd24Dzxs0AV_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfXwY9FQp6cw0+i
 6wMVfWacl4vddUw0xGeIgZH7ukCk8FcE5IHsaNnfVXRokTbUojBKZB7mv/sdjYj9ug9poIFABIa
 mbvc3fZ6weibxYBSxt9cGz5s6WZYckovVLjgpsHMNGipfWVXP4u7BpeeQIFj04+IGMbdpvB5no/
 T1aFsbvGDi5a0EDHSIG3iYMFD70LIduA58PsxkBUwQ2x4N9mlkIkMF58DTIPzHAyKTITSzVvaLy
 UyoDlVHn3Qy9TylWnUXhPEHptwG7LjidwfKkbT1jST6UppJW5tGB9tU948gpH/bvUR7SkOPWXGQ
 gIWj5R6hLgAl+vQ7HOQu/81zaGj8v1PC+7S8Lfg09x2zhbhJfM4YCQhsVn1UoFct95I3SGZLnq3
 Dt8cCB6jD0PtBkIty5LtC3etVGKdVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

On Mon, Nov 10, 2025 at 10:33:32PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 10, 2025, at 19:54, Heiko Carstens wrote:
> 
> > diff --git a/arch/s390/configs/compat.config b/arch/s390/configs/compat.config
> > deleted file mode 100644
> > index 6fd051453ae8..000000000000
> > --- a/arch/s390/configs/compat.config
> > +++ /dev/null
> > @@ -1,3 +0,0 @@
> > -# Help: Enable compat support
> > -CONFIG_COMPAT=y
> > -CONFIG_COMPAT_32BIT_TIME=y
> 
> I think you missed a reference to this file at
> 
> tools/testing/selftests/nolibc/Makefile.nolibc:DEFCONFIG_s390       = defconfig compat.config

Yes, and there is quite a bit more s390 specific compat stuff in
nolibc which I missed. Will address that - thanks!
