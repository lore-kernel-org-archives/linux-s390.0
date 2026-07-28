Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79841416860;
	Tue, 28 Jul 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228845; cv=none; b=Erv10B6lpAEC32cj1NNgNfTZeupeZ6EGfVAGdchLwLWfoNKWF2LuSJayFQ55oUGcBhAZF6TVVLLIqgBJIibStmy7tN8AF5ZT54mCuuDWW3U+my1fxubaESg5+m0GW3ffwEqe9wFLgVfO+9XcAye73CJeiZMWyI5iVUzIzha/THw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228845; c=relaxed/simple;
	bh=rBkXoOWMw1kCxqEz0Fja6nje37qLg28YnkN+PM0MIVI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZnxEK0zr9OBCP8XIG/9uMFJU0izQFgJojtunZ7Sx/PjuEu3CUxl46+KFOGfahxNAMJcAeTe2Jkzyh0ABGPu6J9RNs4jhLhSdtFnKThYUy8iFBHwHOmvTj68tmMXP7f/AX/5OPIVd9QtRWE5+xP3rgmqL99m9ABrQtV9qYtS1yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OqeuJFe2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OqeuJFe2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S8HZpf2808589;
	Tue, 28 Jul 2026 08:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=/ErWGasd7zLvWUlQwAnviCk9zM2HCEeXf5LCkVlmgEw=; b=OqeuJFe2Akbv
	lQW8C+TDqXeadpbEjdtlufctFfn/B8ETcSEfU0frVnE7sYS5xaUyrfaYd5F4mWva
	3dx9IAJPiqoj10tLUUJJNX021gOTugX3TwsFsCvUh/Hn9BFeJYY0IZxOuPM6b27D
	YFy29G4dzPxhfaP0iCxnCG9PfWQcK3iT9wmTkd2ejz/iaz1CUZANY0+R6tswfelX
	zHGkeV52LE/wNEd6a2Opyg3xl5Sn0zcVw6WaZdY/VKY4UL3lf9KyX9Et3911CFfr
	HYQL9wgahXjsYjg4n3LF+DUOzOfGJ8Zf4B8xgkiUQ2DFIDHRaaD2dUd5fuYdOOrM
	v6OwvRaEEQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycc9r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 08:53:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S8fGWe008101;
	Tue, 28 Jul 2026 08:53:55 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh8xw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 08:53:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S8rs3928377806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 08:53:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E35AD58050;
	Tue, 28 Jul 2026 08:53:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABF3A58045;
	Tue, 28 Jul 2026 08:53:52 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 08:53:52 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Jul 2026 10:53:52 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Holger Dengler
 <dengler@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter
 Oberparleiter <oberpar@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David
 Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] s390/crypto: Replace cond_resched() with schedule()
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260728082948.13361Ab7-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-2-hca@linux.ibm.com>
 <f88846b24b1250f89b503b6ddfda318c@linux.ibm.com>
 <20260728082948.13361Ab7-hca@linux.ibm.com>
Message-ID: <08722ec6365c8f033152a502b261f17f@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eg1xcWKFc_Hd-efH9kJLI2U1AgBwo-VX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA3NSBTYWx0ZWRfX6ROMAABfhGig
 TXknt+Q5QElcQre10pIB0y2J/zfXk1i9Ke3Gpyq3TISUNl4dosmgmNfbH70uCyMdnTJO1zGgKne
 /ImoZkyGVSsyPqkjcgOa+zSvJfuiyedhMljYuI7Ai5wVr4DGibXi5gzFITDBdiWvjTGIKYR3EZJ
 9bRQbuV4VW8I2u8G2ssQ/4I/Iwcmh5hcoenYF2BNl/paDLAGSd9ru4DUd7JA+NF7hDXN2rReF6W
 mv8Ce9gC3myU7cSsxnw3TPB9ZFEnP4KFBatBCF0htOIaqcaAn8m4CKqYBrbPN6mH2gorAQI8GH8
 pYpJxb68S9GThkPdNXG1sW/jxbX+cKMhq9T8H0eQ1JzSzWZ/H4aXwLcYd+gp27lKs8+aUCrwu1E
 aaIzy9j1zKPjGUeBWVOKED8TxtszszhoguWg7Kt41sZRU7HH7Rc16xt7LsuO4F2eIFqygXhXJBb
 dbmbRQyHhjjzWvDijSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA3NSBTYWx0ZWRfXyYc/492AyjJW
 ZEwCoekR8rQesLWW1lYnUUjafTLh/esiqciB4WEhZjUQBf01z2JFzF6Hfhz7Yn2eGEqT8XSXa7B
 +8Zp2g0l3baE/n6toH2l4QyFX+RzL4A=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a686e24 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=SZftPpj3e5f06-W8cZIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: eg1xcWKFc_Hd-efH9kJLI2U1AgBwo-VX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280075

On 2026-07-28 10:29, Heiko Carstens wrote:
> On Tue, Jul 28, 2026 at 09:05:16AM +0200, Harald Freudenberger wrote:
>> On 2026-07-27 18:24, Heiko Carstens wrote:
>> > The comment for all cond_resched() calls in crypto code says that the
>> > process should be scheduled away to avoid instant re-invocation of a
>> > callback. This is not what cond_resched() would do or did.
>> >
>> > Replace cond_resched() with a call to schedule() which comes closer, but
>> > it looks more like this code wants an msleep() call.
>> >
>> > Note that with [1] cond_resched() is always compiled away and becomes a
>> > no-op.
>> >
>> > [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>> >
>> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
>> > ---
>> >  arch/s390/crypto/paes_s390.c  | 8 ++++----
>> >  arch/s390/crypto/phmac_s390.c | 4 ++--
>> >  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> ...
> 
>> > -			cond_resched();
>> > +			schedule();
>> >  			return -ENOSPC;
>> >  		}
>> >  		break;
>> 
>> Ok for me but we agreed to have all this code going via Herbert Xu.
>> So please address this patch to Herbert and the crypto mailing list.
>> And then I'll add my Reviewed-by.
> 
> Well, the main question still remains: why did the code use 
> cond_resched()?
> 
> This doesn't make sense to me, at least when reading the comment. So to 
> me
> even the schedule() approach I proposed is questionable. Why didn't the 
> code
> use msleep() instead? Or can we just remove cond_resched() entirely 
> without
> any replacement?

Reading through the "documentation" of cond_resched() versus schedule() 
I would
suggest that schedule() is the better choice here. Maybe a mssleep() 
would also
work here as we are running in our own crypto engine. However, I would 
vote for
schedule() instead.
