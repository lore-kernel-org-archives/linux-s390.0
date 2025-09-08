Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F3D1C8605;
	Mon,  8 Sep 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331499; cv=none; b=jSbOllQ/EB1UW0EBJ++msdqrtK4ZL4Z8IBugbpbCt6jv3Yi3z/b8Gmo954yjVlSmHbeI0XCy9nkc0cRiv4Y/OhylEu4ZPaCNaz/PpLYOTRy6R9vMEFPpNng8WlRn3sNpcsUijpravI7sogm8fQoKIrdnzGu2YJd2zvnwZuwz6ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331499; c=relaxed/simple;
	bh=YD8QuYEYa0gfqlHQvWoPb9fVL+58WmU/vl6PJkfuLIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4UWTwJkoM5ec3b9ARFdszISzeymySpeu6tmg4EWkZ+6YrFrq1pzQQ/wUZ3BjpT6Fv1OgR0NBifkHfCWj6O6uGZBsuhwLKLk8+LQmhBEr8no2gzT7w1uP87DHrcW2X3xjseCblg5/cTQ3+r7rZY7haedO16QxMSNj3c6Yn/DVWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kXnDF+Pt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kXnDF+Pt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5886dlQd021177;
	Mon, 8 Sep 2025 11:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4cLpuk
	a8roRch9qOL0C/WjTJByijAs5sa6IyY3BemgQ=; b=kXnDF+PtROCklDcKXHl1L3
	iGmuRdrMErFjr83ya2qGfPyzToOtNe31swMBQAvdZDW2uZZxOyXwb0qenuxfNZQS
	yK1gGpMKoOPSCxnNo1gWsfkR8DHsFkHoN75xvE//3ZDN/WVd/KpDUwFcBQ4Nwyl3
	lZGe8LEpSH67yZxtrydzN5oTyB1M+EPWc2NFHxY0jPlQBGmlzHYZfgVC3XxbIyl9
	rExSh9BbPY7uNVjDLVZYiZRSLXD0pV6hD1I9Wq4rJVzzFyx1q6L1Xwl2RXjmNrWx
	Y1mFNDGPcZ5o3vd4ylUBDSTOj1DHOueX0Ke6wHQ8tB0NLThjvqq9Ge1csJVDeiQw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsh04h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 11:37:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588BYiZG031328;
	Mon, 8 Sep 2025 11:37:57 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsh04e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 11:37:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5889iiRb017172;
	Mon, 8 Sep 2025 11:37:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gm5nm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 11:37:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588BbqO744499454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 11:37:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B27AF20043;
	Mon,  8 Sep 2025 11:37:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6655320040;
	Mon,  8 Sep 2025 11:37:52 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Sep 2025 11:37:52 +0000 (GMT)
Date: Mon, 8 Sep 2025 13:37:51 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 1/2] drivers/s390: WQ_PERCPU added to alloc_workqueue
 users
Message-ID: <1f2a16a0-9c14-4403-9c39-35f8b8138188-agordeev@linux.ibm.com>
References: <20250905090857.108240-1-marco.crivellari@suse.com>
 <20250905090857.108240-2-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250905090857.108240-2-marco.crivellari@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX4fF0ialbnnbs
 CFAtlwu17iQpMh/loDEAS7bIFepY0AHPQwl+6n3rpkvWb4lP3CKZYxpcFdfm8iCjC/X3lI2nKjo
 0suW2Wx/A51Kaj920CYKfs7pwVNPn7B5ubCq5/CvoVDk3+dlNQY9K9zBtPM6MxqDgQBPPK7GwSu
 mA8E7XiRwxj/fFHes8OZ4kyL7RGIcaAIrUD9UDJRchHBl4QaKY6hHhFl+JZH32d01aoM/a9VoBx
 72iXPaCc9Qcy0fEwBN4oOfdspKBXFFC4bnDlgPcejA1fINDzJyPyGo6wcoTw729l5uUjlhXwko5
 FYlHdyI1KuOlkoQaO4AclT/Kiqs+AJ7/o0Fs1Vjt3E12sJmsrPJBCBBxWFcmhyfnwfIXzAyXg3p
 q3h609lW
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68bec015 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=VnNF1IyMAAAA:8 a=usnAHYiZvopSxf_OJaYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: w9UsgZlT_jS4cHztfgMNw96us2kheu-z
X-Proofpoint-ORIG-GUID: eQEN6vg2x-Ncwy5N2dLECV1Ih6NcGmiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

On Fri, Sep 05, 2025 at 11:08:56AM +0200, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.

A duplicate paragraph.

> This patch adds a new WQ_PERCPU flag to explicitly request the use of
> the per-CPU behavior. Both flags coexist for one release cycle to allow
> callers to transition their calls.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> All existing users have been updated accordingly.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/s390/char/tape_3590.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
> index 0d484fe43d7e..aee11fece701 100644
> --- a/drivers/s390/char/tape_3590.c
> +++ b/drivers/s390/char/tape_3590.c
> @@ -1670,7 +1670,7 @@ tape_3590_init(void)
>  
>  	DBF_EVENT(3, "3590 init\n");
>  
> -	tape_3590_wq = alloc_workqueue("tape_3590", 0, 0);
> +	tape_3590_wq = alloc_workqueue("tape_3590", WQ_PERCPU, 0);
>  	if (!tape_3590_wq)
>  		return -ENOMEM;

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!
