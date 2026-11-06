Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979519;
	b=b0iBTPtrVR/e6y+MHeBY2QBuXjSpB+ZkTN3QZacINRgqy5eWsZ4UrPaTMCKBxrmaif3m
	 CIzs1icWcYRnm6CzNpX1dr/bo/iSXi0BjxndN93NWzmc+ctSiC+6Go7OViVf41yF2HWiw
	 T5h0m43uklZa78h0qiw/eARivGc9DhE6tos82jSJ3CfvVErjBTVHoeY6jqJpQ45EXkwdP
	 gycohrQiQxg65JDpbtUNWavYLQNfqFBz+8PacrApWCMWrqtTkOwv57leBm7pPqecgD2EU
	 gFAGQcXG42i9W5PihNVwtIwmQoTcDtXztdv7iD8y3jDuzNE0ApffYCIn0IzN37ISYzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979519;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hWHIqjsyIDZD6I8p0tZ0+usxjAHNj6aeG+M2LbSi+ak=;
	b=laPAur1PN9HIW+ktPY4RAvMQw4S+PxqYjnF6Xt4W75RYAiAdmzbcGyEay1Ve4PrI3Xlg
	 dKpp2Xd7qjBdzYGZkH3lM1Nf1oOTDFEt6OU3C6UBJYC0Pz9UjxEgv0/VsgHbLGD8teF4L
	 x/SHMqDaRVMxuUdvJea7PYZnDMt1nsf09YiGQxbMCzwO9MlkxqYG2rALSVl+fE8u1VzqI
	 mqlzjNRs2M+ikBgSyWQrk40bFCobmSbyASD2jaIwlFDkYwKlysUwHJ/7MJJceDc5lCDyh
	 JrqMbA6WXtlwpQYJtf3fnKQccGIeTVzGLvYcM2SbNya3caRf3DyqfjstYf8betb6ilQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IQO7Lqee;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA8A606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA8A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IQO7Lqee
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEEPx1544354
	for <linux-s390@vger.kernel.org>; Fri, 6 Nov 2026 15:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hWHIqj
	syIDZD6I8p0tZ0+usxjAHNj6aeG+M2LbSi+ak=; b=IQO7LqeeuBWorYWLYqvebh
	jdUFgWJC5aoY6oJke/fG9V53YOxhyl0MXGnUArXsEDg+jVLxHqbkeMWlrolG6NB1
	uFNih7738t9wk02TnjhQOboNihzW0BGy/k6eyc5pvnLDpk2iTBRph78/EHwZImTA
	xEsc08Op7F6cWPEUyZpWwElVQuAS43s/BT0pfWAqqDtCMIRQARJZbsh0ZT5VTZ9U
	/8AtdqhG2ApaTDhAf9reS0ga5jW/fQ/1f8XriswYLLlQQgB8Rej+aN2kIxgZSSTH
	Sx0ntvY69QppesvOa6BxfWep8pyBrqk0O//1Ox5bNWSR2LvqjejibnjxZ9H7qKaA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbw7x8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 15:38:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FK98R3577944
	for <linux-s390@vger.kernel.org>; Fri, 6 Nov 2026 15:38:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v80t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 15:38:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FcWW939649550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:38:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4A472004F;
	Fri,  6 Nov 2026 15:38:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E2E62004B;
	Fri,  6 Nov 2026 15:38:32 +0000 (GMT)
Received: from osiris (unknown [9.111.63.138])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Nov 2026 15:38:32 +0000 (GMT)
Date: Fri, 6 Nov 2026 16:38:30 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5] s390/diag204: Add common diag204 interface with
 caching
Message-ID: <20261106153830.31530Ab1-hca@linux.ibm.com>
References: <20261104-diag204ioctl-v5-1-87a96638d58a@linux.ibm.com>
 <97ebb3cb-ce2f-4695-b4bd-8da2dcecf873@linux.ibm.com>
 <6345f71e-8532-4a58-b991-8f2a0efe1fea@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6345f71e-8532-4a58-b991-8f2a0efe1fea@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KcBx1EMOQCj7OR98UFdJwR3v1d-UGA7W
X-Proofpoint-GUID: KcBx1EMOQCj7OR98UFdJwR3v1d-UGA7W
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aedf47d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=_X_bAzGopjSKmhcr8CwA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfXzN41M4riynud
 lgV4KcnyVTUrCSkXOnJmbWvzu4b32mwfBYHXbgvTGQVDXaE5PmBm7b+jtV984h0Va9wY/6dpHJd
 rFYpZIcjWtedkpTT2/s3wT/fpfbxlhk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX3EF31SmzglUh
 TKCr/9W+Q19DPSa4FO0mz26y7H/3QLgJ1TfDH6/VfkOMQJCR7t0DfLeukuzVQ7fPOFHupafn38j
 JrAipHmUwSsYLMYArPm83Fi0VEiTSAQSo0D8bQkO8L0AMGMFt/SB1SPd8/eNIqWIQK76qFNMmrl
 YEb7NDxjhfGndmqKszXgjj2PJ4LHO/RvqvPCw4hO/OVpggVTnrzhsg9BdPbAmW4+b6fNR9FbOfc
 6T9W24uTJ85NAagJYgDQA180W6N7PIgV+m/2kE7L4gTu4W4tTteO0P/EbJywzJrC5pEiiitYBwy
 vloHDAwRft4BNL6hrIa07ybP7gg0bXTnvQC+Sq9rRHX+4fCTafrxKAv7vQ7pR3aiJuTh5PnmSv0
 dMJvWxZlRQ4XF9yg43QThNiCBNlRSwykuPcKSuhcqiZMeR6gWzEPRPlUcGg9voq87fb5XTJX3xH
 6qEo7ac1nE/3sJhPQQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

On Fri, Nov 06, 2026 at 12:12:54PM +0100, Mete Durlu wrote:
> On 06/11/2026 00:06, Ilya Leoshkevich wrote:
> > > +int diag204_store(void *buf, bool allow_busy)
> > > +{
> > > +    int rc;
> > > +
> > > +    if (!diag204_is_available())
> > > +        return -EOPNOTSUPP;
> > > +    if (!buf)
> > > +        return -EINVAL;
> > > +    rc = 0;
> > > +    if (allow_busy) {
> > > +        if (!mutex_trylock(&diag204_mutex))
> > > +            return -EBUSY;
> > > +    } else {
> > > +        if (mutex_lock_killable(&diag204_mutex))
> > > +            return -EINTR;
> > > +    }
> > > +    if (diag204_is_cache_valid())
> > > +        goto copy;
> > > +    rc = diag204_update_cache(allow_busy);
> > > +    if (rc)
> > > +        goto out;
> > > +copy:
> > > +    memcpy(buf, diag204_cache_info.buf, diag204_get_buf_size());
> > 
> > I wonder if it would make sense to return the buffer address and keep
> > the lock. Most callers should not take more time than memcpy() and would
> > benefit from simplified buffer management. Others can do memcpy()
> > themselves. __acquires() and __releases() annotations should help with
> > keeping such solution maintainable.
> 
> IMO keeping this self contained would keep the lock management
> burden away from the callers while also preventing duplicate
> lock release chunks and logic.
> __acquires() and __releases() should help indicate any misuse
> but I am not sure if it's worth it.
> One objective of this patch series is to simplify the diag204
> interface, so I would like to keep moving forward with the current
> approach if there is no big reason against it.

If you rework to a common diag204 interface, then in a way that improves it,
please. To be honest, I don't see that here. "allow_busy" got new semantics:
even if there is concurrent reader(!) of diag204_store() the caller will now
get -EBUSY - that doesn't make any sense to me.

We should end up the other way: first like Ilya said: return a pointer to a
locked buffer, that the caller can either copy or read from (make sure that
callers don't sleep (e.g. copy_to_user()) while accessing data. Then drop the
lock, when finished. Sounds like an rw semaphore would be the way to go, since
that allows for concurrent readers, which we will very likely end up with in
the future.

Furthermore updates of the buffer should happen concurrently by e.g. a
worker. _Only_ the worker should know and take care of the "bif" flag and
schedule itself again if busy was indicated. The worker could allocate a
second buffer, write into it, and replace the "global" buffer pointer while
having exclusive access to the semaphore (down_write()).

Readers should still get the old data, while the worker is not finished - if
there is no old data: add readers to a waitqueue, woken up by the worker, when
it is finished, etc... you get the basic idea. Callers of diag204 must _not_
specify anymore if "allow_busy" is ok or not - simplify that interface and
remove allow_busy handling completely from callers.

There are obviouly open points - up to you to solve them :)
