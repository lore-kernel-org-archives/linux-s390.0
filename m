Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E55387372;
	Mon,  2 Mar 2026 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468023; cv=none; b=E9n2E7XkezOmq5OEA9g490MvkRvnJzqSUfw9oGf2Ci1kXVMl6M8Biuvy3K0vrPwBqgDBhGdkp5aE9DycT2fzKxd23iIzmGGRiN7oA3N7OviEkVuN6qrXbrIOKVhfXvFTbwj4DkItYz9FonIzLf6nqZiYVWQpbroZfAJqv3hfAXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468023; c=relaxed/simple;
	bh=LGUdiTMxiDLzWEXNTkWeK2+4HIQctHmM31i/wl4FHrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CivLzxSvB6CM0QFJDUmg/9TaEmSyq4iNS7xPqdb1rJ/RyS8TwE0g0ujVA2SD/wU56Ym6VbJ8DfNiyGPzNVE7JK2qcrDv7R2UOAHSiogPOQZUp/k0hmY5XEBzVzKmH0Gq6oWHYYtMlAOPfKGZD/hNWBoo5equQxAuQ3qM3eZimrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b+8veLUv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b+8veLUv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622DWiKi2434588;
	Mon, 2 Mar 2026 16:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cdEYLgd25ZMtAdm7y0UpPD0J/tOArx
	hYmu3ksLnAsoE=; b=b+8veLUvR3kFfyiZX2OBJzCRUVDyfDpu+Q4az7dwVl7CTK
	WUHkK9sIUcLJQbMWZADk/QYuPaeMRKHss/XkOESoRcJA2yqpMCaIGYkeL9KPiAOG
	L03TR4PDUc3qZtNFQT2PpDAIT/8uXOJwzySFBEeYYl6Fs1C7OCob789Ucg6vzbfY
	qCm8hBMTiMnmor5tWS25l/I6kscLjucOdefUMi5fqpH+LUKns24Y2WhQUaaVkq/y
	SNmQg0d2H/AcvNFBG9XFKoylp8Mrj+BXIY70hhh06VszOByfbpXiiok3tnAK8RI0
	7GDvxT35BmjWNnBoLL7Z6Tv+Z+QRvZVUOCzYcUMQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrhyf27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 16:13:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622D8SKZ010327;
	Mon, 2 Mar 2026 16:13:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6jxr4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 16:13:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622GDXuN29885064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 16:13:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8142420043;
	Mon,  2 Mar 2026 16:13:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1350820040;
	Mon,  2 Mar 2026 16:13:33 +0000 (GMT)
Received: from localhost (unknown [9.111.42.248])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 16:13:32 +0000 (GMT)
Date: Mon, 2 Mar 2026 17:13:31 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] s390: Fix and improve inline assembly constraints
Message-ID: <your-ad-here.call-01772468011-ext-4920@work.hours>
References: <20260302133500.1560531-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302133500.1560531-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a5b732 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=HqOCiZ0a8VqM3oG_dVUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzNSBTYWx0ZWRfX3+Lr4bk/2Cm/
 klE4pqNLJX6LhMqayu6PzdSMJ9HHsxybsR+W6FUYVYppfDF+CSW+Ev+J3375M7ZGkK8llbfO6Ip
 2W3edPXIp4V4WA5v5BoatfB+XeUQeBSCbN9101mxT9Sz/g50/+wt2i07L+hDuhkO2HyiWkskSGo
 cC+I4L0jZ9UIMMxHiN32uo7VOFwuwyS7W/+GUeGnX71kqJMgoqlNsXxqwoTQbMIy7/AarpAOXaQ
 kVq/4yfL4OIaWmqTzip3G2dZEYFcSYyg8uikSzNuqbf47jQOao6wjWDAJDBMhD4Jzxkr8acuquq
 XRr00r5APl14LXqi4BbbDCg3TzYPYnoZ4GRpQCXLheap8jPzzXtjKJzcCXb9MuU+i9hfr4kIYsM
 pazga6gvhLgDgHD6/6FD+ASFL+aEXODcV4vsHHl+7KUXInB1syCRG7222flfi3O6lJmvJFOSsel
 hOR+Z5YGJ1tIWfq4U6g==
X-Proofpoint-GUID: FQeRo2OIy6jhghBM_2sfWR9u5JrRoXe6
X-Proofpoint-ORIG-GUID: FQeRo2OIy6jhghBM_2sfWR9u5JrRoXe6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020135

On Mon, Mar 02, 2026 at 02:34:57PM +0100, Heiko Carstens wrote:
> While looking at xor_xc_2() I realized that its inline assembly constraints
> are incorrect. Also the inline assembly constraints for the other xor()
> function look incorrect, but are not (execute instruction vs register
> zero). However that revealed another real bug on __stackleak_poison() with
> another incorrect inline assembly constraint.
> 
> Fix and improve all of them.
> 
> Heiko Carstens (3):
>   s390/xor: Fix xor_xc_2() inline assembly constraints
>   s390/xor: Improve inline assembly constraints
>   s390/stackleak: Fix __stackleak_poison() inline assembly constraint
> 
>  arch/s390/include/asm/processor.h |  2 +-
>  arch/s390/lib/xor.c               | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Applied, thank you!
