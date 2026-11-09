Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253220;
	b=ePmlS95EckkhgRuzRqHYBSe3/5TeUwRaH8a325C38/AKcaM6+UeKiuu2UMlxufG3kQVz
	 p7xQnmPNOTHpvcJqOEhK4Ix0hxgb0bECUHak/t3lSurktB92h2yBh5yCFCR74tBHnV552
	 Kh1TizNDkkeU3pcWeLqKWufJm9DKZueJT5QIh4ftwj9lzMREtbA7j9Oj2m5+7zMkfuO+/
	 raECMVSWIcGJ+NH2Qau5OvGS9T28weGXM6oQguBfDQZj8hKKQe1EQXABxaDFYQkSeLRfN
	 h62yY6OC+LLcIGPp3qHR4OAWkfuCvpiuNZ56mKNOT/4+a2JFiOdpdz+SbUSa+b3tX/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253220;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cSdUp+iMz6dZTnvvh+UyrpHr0aFeanxLOXVNeb5C0Jw=;
	b=atPRB9fZez8E7qeW9Q8OxHOJVlESwjdcr2FBp9W+a1ZCDz7QeXp3JZAtrdSPPbOi1nIN
	 rPyd1qOpSelVeKigXV5pVPi0g5W9VI7VA7QXhZJsQqEVtooT6Xo0tQFwfVksAJrsWmw0i
	 ikrKbJFML3iuz37ZsoopQqdl1CgFVoFlUKMDoaKfEW9XqUiqqfJNkX/Dsq6BEx0wQyBWH
	 swLqVdh1aynP9vXnFwH/1Y1NmAdPei39SHKyRqh8zINF1K9e7k69TIE618V9GYuGn1+Vw
	 EhpeIQh26+dXV4mpc36waUiSekuBCwPK0qCoQbt3uXi+5VHNykpcOuulxzmcz2F6PNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p+IiLjyU;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C55606A339;
	Mon,  9 Nov 2026 19:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15C55606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p+IiLjyU
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9Hi6eQ016598;
	Mon, 9 Nov 2026 19:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cSdUp+
	iMz6dZTnvvh+UyrpHr0aFeanxLOXVNeb5C0Jw=; b=p+IiLjyU72+mDYtscn6S+8
	dNBQ0Jddr2OsPP2Ui+b557Ts/IVitRalTOCEJV/Uqoz2PedRdIkP82b1PbauWe4h
	9x+wEFuCr0X5ORE7BF5h+ys798PdwOREyzNABqKuzpABMlg4D0iwuy3Nlhq2Lv/1
	hV/8pYb3FVKmZU++T3OC/SnLRZTxv9HGyCZHAmzLMx2M2a++gqdy0huXqGbI8o+N
	4/qK+d9oEfe5XBwDBX5IVSfniAEQYBGIBqRbNQFfrZjLQlCKyY5x8IP/w/+p8bs/
	mnuLbHYeXz8PTtpVTyv7dsFj681qemT4IxiMcjRuH0qnJ2o69jfs0YFYtyygVrOg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6rvsx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 19:40:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9IvXpG482195;
	Mon, 9 Nov 2026 19:40:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y2rn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 19:40:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9JeBOG16646592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 19:40:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E442004F;
	Mon,  9 Nov 2026 19:40:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B85D2004B;
	Mon,  9 Nov 2026 19:40:11 +0000 (GMT)
Received: from [9.111.35.129] (unknown [9.111.35.129])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 19:40:10 +0000 (GMT)
Message-ID: <de7b6808-9f9e-4fcd-a0b2-335369dd7eac@linux.ibm.com>
Date: Mon, 9 Nov 2026 20:40:10 +0100
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
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yuho Choi <oss.patchbox@gmail.com>, Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vineeth Vijayan
 <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261106191029.469837-2-oss.patchbox@gmail.com>
 <4cb58287-4273-4518-8cac-aa3056dc28e2@linux.ibm.com>
 <20261109144953.GN663069@ziepe.ca>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261109144953.GN663069@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3NiBTYWx0ZWRfX4G1a4Pw/g7wM
 +82nkA3x0hUsk11oRX7zJtxN0EVQoMAL0jYQ0QccHyvNGC/AWCEEwRmhjd8/dWBOr901Oo2OCXb
 lQdyJeot1E45L1szg1CbOR7+506gn7U=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af221a0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Pjkd0tzdIERNFELBtG8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: k0hV1_7oyy_oMty6URswoLxqe5o577yE
X-Proofpoint-GUID: 0zgPJs9UngTPOBHfZRc8TD4yKWd59kiu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3NiBTYWx0ZWRfX7b7dUpyuAR0u
 RxcBxUBQITb5J45CQmhm9/O42OktyKwnJ3TEI0FWpvMTwWyI6FKRuT8qT3CmwFPZJf9YmJnNbu4
 GvG5CZNskrLsYrWGgWjznl8nOIICIxdQkVsY0iqAnxuOhymBXPwn8Or6+b9jq9EEAW/Q/AzO9XY
 /mFGk9cqWSOjE4RsCNOKp3RzkqZR8p1zOAHrPSgUrWvKgnedNvaCl98H0HW+hrjEQfMvDcNZ/5b
 ylttac8r+tgjR2JLNwtmrpl3l1xh3uK5ehOUpqYra6TwTXaXnfWOn2b529FQF22/uzRbpjG76G8
 wso80j93t+eqZJN8XViS72q6rPNL7bqr0FJ0dlOS8imThzTKWJSXORHLOSAf8+MHqyweN4hSdYz
 Fvcfe/+zgfuYJS2+DSs3fU58BtuVdG9a/0gsdDgop3r5HZVr1j8FtxnJyo8KwkmAehGIfidMdFS
 uhFZSssntnEldxXeNHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090076



Am 09.11.26 um 15:49 schrieb Jason Gunthorpe:
> On Mon, Nov 09, 2026 at 01:38:44PM +0100, Christian Borntraeger wrote:
>> Am 06.11.26 um 20:10 schrieb Yuho Choi:
>>> vfio_ccw_dma_unmap() is the DMA invalidation callback, which must unpin
>>> the pages covering the range before it returns.  It calls
>>> vfio_ccw_mdev_reset(), which raises a CLOSE event.
>>>
>>> On the normal path fsm_close() calls cp_free() itself, so the pages are
>>> unpinned synchronously.  But if the subchannel cannot be disabled or
>>> quiesced, fsm_close() falls through to a NOT_OPER event.  Since commit
>>> 0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational"),
>>> fsm_notoper() only queues notoper_work, which is where cp_free() then
>>> runs.  That commit flushes the work in vfio_ccw_mdev_close_device() and
>>> vfio_ccw_mdev_release_dev(), but nothing waits for it on the reset
>>> path, so the callback returns with the pages still pinned.
>>>
>>> Because notoper_work runs asynchronously, vfio_dma_do_unmap() can exhaust
>>> its 10 retries before cp_free() completes, hitting BUG_ON(++retries > 10)
>>> and taking the host down.  A further CLOSE cannot help either, as both
>>> CLOSE and OPEN are fsm_nop in the NOT_OPER state.
>>
>> Does the the iommufd backend have the same problem?
>> iopt_unmap_iova_range() keeps calling the unmap callback and gives up with
>> WARN_ON(tries > 100) and -EDEADLOCK. So that path is also fixed, I
>> guess.
> 
> Drivers are not allowed to refuse the shootdown, it is broken if
> someone has done this.

Agreed, but isnt that what the patch fixes? when CLOSE fails, vfio-ccw
currently returns from the unmap callback with the pages still pinned
and leaves the unpin to notoper_work. With the flush the pages are
unpinned before the callback returns, so the driver keeps the
contract on both backends.

  > Jason

