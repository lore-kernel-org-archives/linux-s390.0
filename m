Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403E226D1D;
	Mon,  8 Sep 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331886; cv=none; b=EDVkxaYszlaKK7DrT79qfetRLdj1fGhR28Dw6MqVK/e/Roz50yd+8f9aGa9Xj72YfP4javXl/QCl9lelIgqNWQShd0w2eLg0jqvjTEDFSbpuiPl1bfUZxlmSBFU4LkixnQKi3rTEwgnlcvHMSAC+dh/FCqp7OQkSxCnQ+x2z/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331886; c=relaxed/simple;
	bh=FV1Jx3UNOeEL+L5Nadv/6Gyn+nvsh38hfa6Cnati12g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaXdc11oXkyUo1wmDA0gDLLgDaPUHBVKSkvMErkjcw6zUO8Uwb5xQFV5RFsSih3AsKOJE+4L6j9jpkkt20WiEWkAXg2c3NvHokTW7JKwEKbmo8HmwmPCgO0ukJ3jHD4M5IjtjnRjucpdOnxcBVWadVyxdhyhrVmMcA7thFtlMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y7pAgs1A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y7pAgs1A"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Bg3kB011739;
	Mon, 8 Sep 2025 11:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qG/xnkIWK4PuLPbvFIRXIRHxq2k2EO
	2GObCsaIP6WSM=; b=Y7pAgs1A41MTIdx4808aIXhO9ICG8HSOOpbH9xAuKbvpby
	/mgYPVXVi1u02Pnf/DkX/p6cnRlnTwGW5DXci0T3c+MslxUdrnXCena2lLddILmB
	PJJFcKQa035/jMS7GfHvybzEZ54n2C4HQ68hzY3tvMbjl5dtzvvM4giIoKG7BUJ7
	YoQkQ9DQz/To6VzSDR6Qy60AUdeolZCpJ3tZUfKGSWkQY1do9CuljWwHzamaZWe4
	YvSkZOlg22yfGrXK7QhA8aRgQ4v9ZcDN20nbrEn5TkadEK1WW6aXai8SOLe3P2d1
	mKJ1Qu/JzM1i8RJH60u8HhitsEnaXbw9rGwwYtsw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycp0ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 11:44:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588BgrQd016424;
	Mon, 8 Sep 2025 11:44:37 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycp0rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 11:44:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5889oEij017227;
	Mon, 8 Sep 2025 11:44:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gm5p43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 11:44:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588BiW7t48300348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 11:44:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65BCA2004D;
	Mon,  8 Sep 2025 11:44:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 135412004B;
	Mon,  8 Sep 2025 11:44:32 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Sep 2025 11:44:32 +0000 (GMT)
Date: Mon, 8 Sep 2025 13:44:30 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390: replace use of system_wq with system_percpu_wq
Message-ID: <912c038e-b03d-432d-be24-54c0f90193fd-agordeev@linux.ibm.com>
References: <20250905090857.108240-1-marco.crivellari@suse.com>
 <20250905090857.108240-3-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905090857.108240-3-marco.crivellari@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xd6P9vjBWpEvTMRhGj_a7wVvwWzpEyrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfXyVuFxx0gGQke
 1zslHwRri0qblw4OXkpXP62wi5j8ur7tGK60TuzvEtzbox67E3buhWBsSVAai3FK/1ma6Wboj+k
 P6VtYVB3edifzhgx++XXT+5NdPOHYDvPEVb7vNa2dFwNBjiuTAh0xwBc1YvJsI2H9vVcGb7M+2w
 ZioNBSnQN5pdKTdwicNFY9NFfarPnYobI9EEA6Tm+ew/MwlsXmhwXBZjYZ79hjVGFk1zcFX7Q3E
 TxCEe9FyE3i8DxpLYsD05dCeWL/g9TCKPZO9FXc44ZFB8IIyUt0BEfwYtDuDZK4+8bD/KGcBGhl
 70nAu1mI60NWIz4SUnWXHi+g78qln5uuwURydMFcwDlMgAGdg8OlhpovHbdbzf0i9OJni0BcIy5
 cX5meiYc
X-Proofpoint-GUID: kO6jCdgbmeu7TjSZrGsDOXkLXNUMrzf6
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68bec1a5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=Qu0Jw8_RmZsxXOKw89sA:9 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On Fri, Sep 05, 2025 at 11:08:57AM +0200, Marco Crivellari wrote:

Hi Marco,

> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_wq is a per-CPU worqueue, yet nothing in its name tells about that
> CPU affinity constraint, which is very often not required by users. Make
> it clear by adding a system_percpu_wq.

This paragraph is not exactly correct. You switch from system_wq to
system_percpu_wq - which are two different queues with the same
characteristics:

	system_wq = alloc_workqueue("events", 0, 0);                            
	system_percpu_wq = alloc_workqueue("events", 0, 0);                     

> queue_work() / queue_delayed_work() mod_delayed_work() will now use the
> new per-cpu wq: whether the user still stick on the old name a warn will
> be printed along a wq redirect to the new one.
> 
> This patch add the new system_percpu_wq except for mm, fs and net
> subsystem, whom are handled in separated patches.

I do not see this patch does anything like that.

> The old wq will be kept for a few release cylces.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  arch/s390/kernel/diag/diag324.c  | 4 ++--
>  arch/s390/kernel/hiperdispatch.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/diag/diag324.c b/arch/s390/kernel/diag/diag324.c
> index 7fa4c0b7eb6c..f0a8b4841fb9 100644
> --- a/arch/s390/kernel/diag/diag324.c
> +++ b/arch/s390/kernel/diag/diag324.c
> @@ -116,7 +116,7 @@ static void pibwork_handler(struct work_struct *work)
>  	mutex_lock(&pibmutex);
>  	timedout = ktime_add_ns(data->expire, PIBWORK_DELAY);
>  	if (ktime_before(ktime_get(), timedout)) {
> -		mod_delayed_work(system_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
> +		mod_delayed_work(system_percpu_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
>  		goto out;
>  	}
>  	vfree(data->pib);
> @@ -174,7 +174,7 @@ long diag324_pibbuf(unsigned long arg)
>  		pib_update(data);
>  		data->sequence++;
>  		data->expire = ktime_add_ns(ktime_get(), tod_to_ns(data->pib->intv));
> -		mod_delayed_work(system_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
> +		mod_delayed_work(system_percpu_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
>  		first = false;
>  	}
>  	rc = data->rc;
> diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
> index e7b66d046e8d..85b5508ab62c 100644
> --- a/arch/s390/kernel/hiperdispatch.c
> +++ b/arch/s390/kernel/hiperdispatch.c
> @@ -191,7 +191,7 @@ int hd_enable_hiperdispatch(void)
>  		return 0;
>  	if (hd_online_cores <= hd_entitled_cores)
>  		return 0;
> -	mod_delayed_work(system_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
> +	mod_delayed_work(system_percpu_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
>  	hd_update_capacities();
>  	return 1;
>  }
> -- 
> 2.51.0
> 
