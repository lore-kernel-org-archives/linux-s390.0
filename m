Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227933;
	b=iu7rvftBaJtJt7GxltI5j+YTRaXBAJVkn4O/CR8Se+DmYjYkzhnkON2cAPRMExAnPsRj
	 5nDDSDlAW+JY7Bg4Japw/fZAJ4fsuFqTNup6LxbvWNJhl+14u/8iszjmFOAS7cLvY55dL
	 yFmdUDBH4ouO73vCVOeYSrkf3UW7Fz3M68iY3/UnLnLZqjjpxBbxUG8O+1Ae7imF0hBJE
	 SlFIydhrDPwgT3sqUb4BbNqtzAboT5HmDgeb2v5L9N1JA/4Y4OM4H1E0E9yvpkr0Tkxph
	 Fjq0j8ZcJadW70IO9p0gfyoekL9/9eDlGwv5OyB/V4eb52wNp3ILYvreNUQ/WGIJmDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227933;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uBmYvYbcHcho6XsbPQIL2RqnpsMy4oDpCQXMyiH5tSk=;
	b=nRljNMvJem5LTQ89d4FBZN6Ynpbc9o85GI5jTSmVWwHUIp+/4Mkj6bQFDOUXk+dU7pcm
	 FXSOeksEYoC0sJp3axSxOt0PzTDnxpQRT9u9id4e5gWv0Oi3lcDnFj0SZIXap5PgzOAgj
	 Hzh7Q/60mK1JL5OEsjcXYFf/4Ed0TJi9ah8s9GFP1wAotgW3afRh2nRoPxsnI6XsPs0HE
	 PEZeXs7Jug82KlcOU57FaOdAIZQkuw8NaF1pe7NcL5000ApefenWWDLwXmw2Nc102EiNE
	 tLfhq3JeUL7h2I5026RMh8cAhboZR1v26Xc4OW/wN0LHSoPBmiLWX5u5teTdK0ppOpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d9LiddVw;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC1C606A31C;
	Mon,  9 Nov 2026 12:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EC1C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d9LiddVw
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9AEL4f1916083;
	Mon, 9 Nov 2026 12:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uBmYvY
	bcHcho6XsbPQIL2RqnpsMy4oDpCQXMyiH5tSk=; b=d9LiddVw6uqFuHz6FCnUPM
	1s+vxZO3Z2/4ZY7hJTL0HdEcDjU8bJKLvhzwLZ3Sv69Sb4+5vmsBjghspw21lrI7
	pI0sL5RzaxbkuYNS+1qSZdPuOMq5w3pDJMdDCG0bKigfFPWaKGeFgcg15rJDLzJA
	pDffqht3syaxUnYO7NanFIMy76ofNpcTsnwipydEvBH31mY5icA324WoiJU9QDVD
	6ZBlVFWb1HLICaPwiNxQ/IEw2h/8WrhRzk3iKzAL/i5Tw5FOUVLcIYESdYn6XTyp
	n9HXexeJD/tAR1kQ3Tq3Rw7UU+DhRyCepGtEpXG/rB4joicYZQ2jIO5afVaa1YfA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdfvx5n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 12:38:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9A4vo54004496;
	Mon, 9 Nov 2026 12:38:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfajyr0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 12:38:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9CciU532178486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 12:38:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A344720043;
	Mon,  9 Nov 2026 12:38:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38FD520040;
	Mon,  9 Nov 2026 12:38:44 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 12:38:44 +0000 (GMT)
Message-ID: <4cb58287-4273-4518-8cac-aa3056dc28e2@linux.ibm.com>
Date: Mon, 9 Nov 2026 13:38:44 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/ccw: Flush notoper_work before returning from
 reset
To: Yuho Choi <oss.patchbox@gmail.com>, Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261106191029.469837-2-oss.patchbox@gmail.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261106191029.469837-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af1bed9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=MGMQWwHRxuE3iItJiNIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0OCBTYWx0ZWRfX5BjHtSlLwIWk
 VEjOYNO5uMgmvrdxkyVrvQJ7aDCRSOhbiN5CA5oKC0bpU2O+siO2aHy8hjsopmTEbCnLMPD5Otr
 kgoqfPcm+e1QUg0yIpFTHInOIAjsDQOD6x9FfJcqkSl0bZI2IJAk2f3mEBissh2wt9uLcfZJHna
 JvFja5C0UB8km5PZRREj0txU9M8rydZTrUi5zpvYVBD8dSTiZxeMNfzwX+jYmzXcoJKGCVYdKyt
 tUrjcmzfSxO9pb25o8u28vMorw0olY/sqeUf2Y/U4tX8o2T3PCosxnIW2ZE/OTrAvoUIGX6o8Ur
 370uNunIftqRYkMxyq7PUliptwIFu3aJhbGUGQ/HA4lpPlAi9Z4tw/stDO0ekmZrZ87zXSWHZT+
 yh37/rdRtZKyiCh0UWjDAKQRU9WPE/XAlUaWWDfFwaO0Vnx399LNiXkpHWMocQvvGuWKwgik3hf
 VNUmYG4hpFaOkk1UAJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0OCBTYWx0ZWRfX9wRkrOhZw+yU
 yD5VzBkW+s70LodyExEuv6RNKfHbNcBjgCjzOmsrLl9DYmeR609ZR/S9fuCclc95sMNrQJLwgVx
 Eq4AWIrD2iMOW8yoC/6UDZfnNmvYey8=
X-Proofpoint-GUID: 7PHhsw1CXkWbchPBwpBLaSAEodvwuPfj
X-Proofpoint-ORIG-GUID: HbA3pKVglMtZK2G6Mk2_WubN5R9GxW8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090048

Am 06.11.26 um 20:10 schrieb Yuho Choi:
> vfio_ccw_dma_unmap() is the DMA invalidation callback, which must unpin
> the pages covering the range before it returns.  It calls
> vfio_ccw_mdev_reset(), which raises a CLOSE event.
> 
> On the normal path fsm_close() calls cp_free() itself, so the pages are
> unpinned synchronously.  But if the subchannel cannot be disabled or
> quiesced, fsm_close() falls through to a NOT_OPER event.  Since commit
> 0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational"),
> fsm_notoper() only queues notoper_work, which is where cp_free() then
> runs.  That commit flushes the work in vfio_ccw_mdev_close_device() and
> vfio_ccw_mdev_release_dev(), but nothing waits for it on the reset
> path, so the callback returns with the pages still pinned.
> 
> Because notoper_work runs asynchronously, vfio_dma_do_unmap() can exhaust
> its 10 retries before cp_free() completes, hitting BUG_ON(++retries > 10)
> and taking the host down.  A further CLOSE cannot help either, as both
> CLOSE and OPEN are fsm_nop in the NOT_OPER state.

Does the the iommufd backend have the same problem?
iopt_unmap_iova_range() keeps calling the unmap callback and gives up with
WARN_ON(tries > 100) and -EDEADLOCK. So that path is also fixed, I guess.

[..]

> Fixes: 0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational")
cc stable ?

> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>


Eric, Matt,

can you have a look?

[..]
