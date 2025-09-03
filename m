Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D582797AF;
	Wed,  3 Sep 2025 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886042; cv=none; b=mTpMJJ5L3QBv3vv147UxisMCaEmMnqrRpPLq0cA/1pYAA8qas8HG5uIEGNz/v+TyZWXnpr0dXs/PIeITP7XVDvVLGWxHWS8oqz2K+KkQAq7dkwSdXMRhbnZgtTq8wbx+8cfxuSpXXUXjrb9xGZWQO9EdlAKjVfbUIftHXWAQw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886042; c=relaxed/simple;
	bh=pShCvz0hCXlxg4DiUyaGmZin7eZc/sfm8h/3zvpj5gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8azjvIQyl/noH/3MoA/7zWk+Lj+VRgdI96g78ehOsd/bq6FzWbaYbUok28cIPQxn36u9/E28j1faLmOkAWvNOiQwZ34jlhHWHN9tKShYuFwJ0KirK8oVRBA6wD2O+u4NeRPbZ8Y1zrMBOOUa0kuvWE+FgHM24C8Jlw/HgZBr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qGzoURdq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qGzoURdq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582J2UHR029478;
	Wed, 3 Sep 2025 07:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AiKq0DZ41X9J7+t02zQN/osPKUZRqw
	Eavk2A4iSSuQM=; b=qGzoURdqILlSZuQb2owZxn4Z87j7tCecGtj/L1lv5tzswJ
	rshzI7AWuwn6Pd0lQvXa3XF22caTpKqBBqolBhpmDbu3osgTHqhmu8Z7R0WCsl4X
	mJDRM0GhWnkdIooGIRzYi9DX1ZCB/fjtdNfWnmn820pJqtPe/mrBbBCl3W2s5c2i
	6uSwIGhKYGB1b4SJNVzt/GnS7yxw6OCEPVgGI2jRE0uDcWVlb/b2sQzhuOLj8icQ
	jSoI6Vcjlp4f3o530O8q8VLgDWsrr6euoRxvsHLJL7WcX1M7sOFtWwqZBzFAmOB8
	aNiJRbUp4zdd2pbfDiLll2X4wLMFntOVA1zfOwqg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvftm6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 07:53:44 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5837r3J4017985;
	Wed, 3 Sep 2025 07:53:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvftm6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 07:53:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5837m8Ci013959;
	Wed, 3 Sep 2025 07:53:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3e4du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 07:53:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5837rf2W40042966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Sep 2025 07:53:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6383C2004E;
	Wed,  3 Sep 2025 07:53:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB9142004B;
	Wed,  3 Sep 2025 07:53:40 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.83.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  3 Sep 2025 07:53:40 +0000 (GMT)
Date: Wed, 3 Sep 2025 09:53:39 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] perf: Fix the POLL_HUP delivery breakage
Message-ID: <aLf0A7RR19zyeTBo@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250811182644.1305952-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811182644.1305952-1-kan.liang@linux.intel.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=behrUPPB c=1 sm=1 tr=0 ts=68b7f408 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=QyXUC8HyAAAA:8 a=LfAqjl12Qpy5QSf7LNAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: E2OGfzWy17SRPri3VmpAF0PbB4VzOpRF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfXzZQEeuTw/da9
 qjyWKq8gz6DTyPKWN2nu0hKxdgHdBfGFb3KNz9DNNaXTWqpbn9NXaeOWx2y6gzb6T8s0v43iumj
 obaD8YaiHZji+SRresBI5HLjC345CBbR1T6LqbeDVC+pnP354sb5yoQH1oAUtCmEAka0jJfoYgb
 0a6J9z1dhW6iE1sAnkXXXyGK7oYnBfiEaYag96BplkR+QMTLavSCdN+6BQ1aidpaZzdld9R9/t7
 z6u4pl62mu586y5+aK5hNvw1cV9E9djqnQf7Wy8oVS7D9wZkYZaNpHYsR0vazkaJ5R27rb1ChTM
 nWnA4vQJBLl9wuAKv4/9d0GqiAEecn9UBd2gYozFn6mR6NfO/l9/3WIiAAIea5oieWZlUPWpWLo
 jodpneg3
X-Proofpoint-GUID: x6GzSGw-YWwpUdF5F_Rybu3d8MROhfnU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

On Mon, Aug 11, 2025 at 11:26:44AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The event_limit can be set by the PERF_EVENT_IOC_REFRESH to limit the
> number of events. When the event_limit reaches 0, the POLL_HUP signal
> should be sent. But it's missed.
> 
> The corresponding counter should be stopped when the event_limit reaches
> 0. It was implemented in the ARCH-specific code. However, since the
> commit 9734e25fbf5a ("perf: Fix the throttle logic for a group"), all
> the ARCH-specific code has been moved to the generic code. The code to
> handle the event_limit was lost.
> 
> Add the event->pmu->stop(event, 0); back.
> 
> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> Closes: https://lore.kernel.org/lkml/aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com/
> Reported-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  kernel/events/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index dd8cf3c7fb7a..ec19c456b66d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10378,6 +10378,7 @@ static int __perf_event_overflow(struct perf_event *event,
>  		ret = 1;
>  		event->pending_kill = POLL_HUP;
>  		perf_event_disable_inatomic(event);
> +		event->pmu->stop(event, 0);
>  	}
>  
>  	if (event->attr.sigtrap) {
> -- 
> 2.38.1
>

Hi All,

It would be great, if this patch can be integrated soon.

Thank you
