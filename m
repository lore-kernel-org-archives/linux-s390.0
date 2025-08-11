Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F9C23182D;
	Mon, 11 Aug 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920960; cv=none; b=C9j4OdSmHXvxXmJbbiThzMzBF5hxXWMC2odvMFZy03SvoIGJ6eJgxtsuTW2r92Pz2rZqczV3hrr8eR4+C3il8EoMwuYnLjbB6iGMBeNLk0thXZjMCDYPlN/gp75NUnXdlbG+BPMj61jBn99tgP/liA3d72bLUmLoxukhDKJ0DdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920960; c=relaxed/simple;
	bh=zH4I/qWBmTj/UCS245DeqVfocTTnLXpSZXiTreQq9g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbJEGEprNbzfe1AGjU/pY5UrWRPfX88ajVvaCiGG+/R0vfH7hv65nTvJBXMcnO5uF6KK4TQxiqjjLdjWA8qOSpvDvZrnHgTVEX2ke+4R85YqDPYLcOhrPHJe7KSRq5KGMNNWTxU3uID3ucY7+y1F3b9BNEG29Si4drXBd2GtK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SAu3idjS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SAu3idjS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BCiDfa016877;
	Mon, 11 Aug 2025 14:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xW/YR2CAuGIo8Mv7ueuj2nTaPnSyKu
	kQ6F9ZPFHFeqo=; b=SAu3idjSRLyc/WoQpbra4n8o9JHNCUMtSteJmaFiVts2EB
	cpEgvUY8GBuPnwBA9Af9rWiVGuCwVX9Wv7XoKCt+H0eA/oLZ/baB20bHazJxop0B
	LsVPmOb9auSGAdCmL9J+A6OzCYkiE6xSmr9IrLSaccW42e2zzAjKynxmAdQX9lfK
	G3w+mgXyuAeER4Ov9w5QzXOuaOL6HGfj+z8v50QI63Cexng3kX8VJlelL7Hygh3p
	YVRfE0nhrim+jFzcmAVQw5+MAQwt7PnObE4VGFpdTuhMHR60hbKgHG5ewzebP68r
	5tKz0xK+iz+OI3PbP5o4kMxv6qAq2qLvkR5hSmsw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnsgmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 14:02:12 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57BDNlLQ009025;
	Mon, 11 Aug 2025 14:02:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnsgmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 14:02:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BBS7dB025623;
	Mon, 11 Aug 2025 14:02:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvm5vvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 14:02:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BE29qD25100900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:02:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9647120043;
	Mon, 11 Aug 2025 14:02:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1AD12004B;
	Mon, 11 Aug 2025 14:02:08 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.57.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 Aug 2025 14:02:08 +0000 (GMT)
Date: Mon, 11 Aug 2025 16:02:07 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, eranian@google.com,
        ctshao@google.com, tmricht@linux.ibm.com, leo.yan@arm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V4 07/16] s390/perf: Remove driver-specific throttle
 support
Message-ID: <aJn33wiBoMMToyrY@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-8-kan.liang@linux.intel.com>
 <aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <aJMUZTJ7FmB9FW9r@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <575d9c34-5546-47a2-83e4-5f5d12a17cb5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <575d9c34-5546-47a2-83e4-5f5d12a17cb5@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4OCBTYWx0ZWRfX9KkZ5h1wzYpB
 +o84iHKBDm78BM2ZcUIgvKc+T61Fm+09cZZ/GPrtmkYkWvBuI2lguhD+7B82erXwvwocBBl6SFW
 9K0otwQhdgvCtzfOIlAjkuxK7z7aHx4cTmXdZGlVV2Mmhp/33RKxvOAmo0a2xwVje/A42jFvzU7
 XfymOHuNkMs8vTztjDz8tvMYfNPAxpmjiiKRSRKI7EhI3EOpqI151BBp+oo2aDEGT94WckBp+uz
 1GnlnR6geJnpNg34ZpfaOcIe0S26kuSiSbOVAdHtGr0AVgtYosl3BKioXNdIK1kRuhjCAfTfnDy
 ZZq73wW+ybgkoz0zC2MXS1cFAp9Js3uvO4NRhJvVez+4ixWd6PjBgnEXa7WYZmVyd+mh2foANKQ
 IlxMnDYC2xTKC6O378HZ6RMnYFzu8JZWf3elz9oPrjSrffefThxB687UCcBVz/LR5Cz24+AS
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=6899f7e4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=sND-jZSWRntckRgYaTcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: db5mFvmGPeF4vWle0Rq9UcbMwuIUNW1q
X-Proofpoint-ORIG-GUID: cILNIj_7ClKRabe8Zx_tmSPM-M1_2DIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110088

> >> Hi all,
> >>
> >> This seems to break POLL_HUP delivery to userspace - when event_limit reaches 0
> >>
> >> From perf_event_open man page:
> >> PERF_EVENT_IOC_REFRESH
> >>               Non-inherited overflow counters can use this to enable a
> >>               counter for a number of overflows specified by the
> >>               argument, after which it is disabled.  Subsequent calls of
> >>               this ioctl add the argument value to the current count.  An
> >>               overflow notification with POLL_IN set will happen on each
> >>               overflow until the count reaches 0; when that happens a
> >>               notification with POLL_HUP set is sent and the event is
> >>               disabled.
> >>
> >> When the event_limit reaches 0, the POLL_HUP signal is expected to be
> >> sent. Prior to this patch, an explicit call to event->stop() was made,
> >> which may have contributed to ensuring that the POLL_HUP signal was
> >> ultimately delivered. However, after  this change, I often did not
> >> observe the POLL_HUP signal being delivered as expected in the end
> 
> The event_limit case also returns 1. I missed it when fixing the
> throttle issue. :(
> 
> I didn't use the IOC_REFRESH before. According to the kernel code, it
> reschedules all the events of the event->pmu, when the ioctl is invoked.
> So we just need to move the event->pmu->stop() to the generic code as
> below. It should keep the behavior unchanged.
> 
> Could you please try the below fix?
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 14ae43694833..f492cbcd3bb6 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10341,6 +10341,7 @@ static int __perf_event_overflow(struct
> perf_event *event,
>  		ret = 1;
>  		event->pending_kill = POLL_HUP;
>  		perf_event_disable_inatomic(event);
> +		event->pmu->stop(event, 0);
>  	}
> 
>  	if (event->attr.sigtrap) {
> 
> Thanks,
> Kan

Hi Kan,

The above fix works.

Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Thank you
