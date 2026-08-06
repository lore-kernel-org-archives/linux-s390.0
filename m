Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BC331ED5;
	Thu,  6 Aug 2026 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039809; cv=none; b=dq724K1NiEAuikZw64hUqqseXDNeKuYqUVbkXqfmlwZPm0yQf21rOG62+f9hercflo+fq7GYj4zxhmeXv9xenWmOJ065IjRJmBcJb9q/RBSA/d7O3IWUMOPc9ZHnMNGRf4ikWotN9eTffCD8gwu8pZcYS3oQh0hsBftfaZZUb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039809; c=relaxed/simple;
	bh=f6Zn2gc2cs4jIeDxBQLAOwRqn8a0wuUtR3+EcVhXMz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXtnP9ZliWFksqU/n3WUvix6Xk4xFeKB8U+4S0ygBo4pDCSP+hl216OHLuSIIEYJx1q5Uk5y6yW6uTjeXTuCs/hch+hYx6zo3tCdpJQli8bbDx7ziuQEVjeRaUFLRoKOj+29IrL6i4UfOHLJPIqdEqH+nS2mIontd8HxkL4yyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VeLKVRbU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VeLKVRbU"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Hm07H3256392;
	Thu, 6 Aug 2026 18:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VyyeoRfsUPeDh52IKPfas27KlthrHM
	5K7lr5zdjfTwM=; b=VeLKVRbUDdJ9qn4SMLlsOlrrDhp3Pw9/UdvoH86GQh40kH
	F2mNyCOWxVaauL0jV2Ajq4TkRomsZ2CORH2QGwv3X5Vbx+eqtq955w9wxWYGb/zA
	MLboMkTXyGf2RNlbiQUqVinTHs0d4fDvwceo9JlQCamfrMGlxXbAeLSnd5/Ubh8Q
	dGLBOvF/M5dbwgXpIChirIIs/KQs5NpK6/SSz01wKcNtQ+2mTOohRBcP1+/tqu9B
	7X1Guh4E17xszukbFnrfZybMnl2uhaDTnGGigDzzd2Kd2cDrU99wuSIkg+nEkGX2
	2DG89Wy23bvqCEMNmHGBSgG0hr0hdTA4/YpdIQ3Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0283a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:10:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HfGCT018621;
	Thu, 6 Aug 2026 18:10:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qvg4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:10:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676I9wpK33685894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 18:09:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAEDD20043;
	Thu,  6 Aug 2026 18:09:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97E5E20040;
	Thu,  6 Aug 2026 18:09:58 +0000 (GMT)
Received: from osiris (unknown [9.111.38.208])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 18:09:58 +0000 (GMT)
Date: Thu, 6 Aug 2026 20:09:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/dasd: Add __context_unsafe() attribute to
 various functions
Message-ID: <20260806180957.10725Aa3-hca@linux.ibm.com>
References: <20260806130050.2057443-1-hca@linux.ibm.com>
 <20260806130050.2057443-2-hca@linux.ibm.com>
 <f6ec3927-cf77-484c-a3d8-c0417f2f2870@acm.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ec3927-cf77-484c-a3d8-c0417f2f2870@acm.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a74cdfb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Evt7RIZt8xg5G9nE-bcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzOSBTYWx0ZWRfX3NqyvceSh6v1
 kd+ZG5Tv5HPw0v5nAlie389a3iin8dv1f2+pqA8RrUriUx7bstEumq6AkuVbEw9t+SMKpQ+4Gwb
 JDdceBnHxkhtIzDkIKrB0Y7avKC20udr4eDZ21QbzbGTKn/L20Tt9PUIRBPnCX4v2pCNuPVaGVK
 jSK/gmxrPZbB0uAOoK5Aa5dmohxDDG4MoX2Op9xc0V3PSEfFHa06irGIMNoEeK29ScRKVyGv47v
 QGjKJe0NrGDgzoU9rYBhdHCMWlpmqOizKqDTS2hy95xCDRC0O7MGRSXgyOx0TSyCbv4WTIkpVCi
 yPANssn96YrMMhRfHFOVwmapow/Y6NcmKETH39idWPRXN2olV21aGEYgvpxTJqxP0R4bafv3DpP
 qoSqBe1yLPYuISGlu3ty8ofc9tHsOciGvBg9jfm6Ke/ctopt+JX2W17X26os7Ee7zaZzVbUFEs6
 Ym3StD3YgIlcZaRH6Iw==
X-Proofpoint-ORIG-GUID: 0pqVgmyWNXbanQKBnirEFO8SxwQY8-6U
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzOSBTYWx0ZWRfX6fzTZ5QKBktN
 CeUp/pN3yHXSupXQSbGVHxoqxoGuNjk9/t6DrqzetAiMGI5tXxY2CZiiBik3+jA6xwTCd25pJ3V
 2eVUPLVAairn/RtJuUN0WrZpsoezvHo=
X-Proofpoint-GUID: 0pqVgmyWNXbanQKBnirEFO8SxwQY8-6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060139

On Thu, Aug 06, 2026 at 09:34:06AM -0700, Bart Van Assche wrote:
> On 8/6/26 6:00 AM, Heiko Carstens wrote:
> > diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
> > index bacf770c0e1f..b4dcef06edaa 100644
> > --- a/drivers/s390/block/dasd_eckd.c
> > +++ b/drivers/s390/block/dasd_eckd.c
> > @@ -1468,6 +1468,7 @@ static void dasd_eckd_path_available_action(struct dasd_device *device,
> >   }
> >   static void do_pe_handler_work(struct work_struct *work)
> > +__context_unsafe(/* Conditional locking */)
> >   {
> >   	struct pe_handler_work_data *data;
> >   	struct dasd_device *device;
> 
> __context_unsafe() should be avoided if there is a better solution.

Sure, I did that for other code, but this one is up to Stefan.

> For
> this driver I propose to make the following changes:
> - Change dasd_pe_handler_mutex into a semaphore. This driver locks this
>   mutex from one kernel thread and unlocks it from another kernel
>   thread. That's not allowed!

Yes, I did not realize that when adding those attributes, however that
was also reported by Sashiko.

> - Split the dasd_eckd_read_vol_info(), dasd_eckd_release(), ...
>   functions. Move the code between the mutex_lock() and mutex_unlock()
>   calls into a new function. Rework both functions such that the
>   mutex_lock() and mutex_unlock() calls end up in the same branch of an
>   if-statement.

Agreed, all for Stefan's todo list :)
