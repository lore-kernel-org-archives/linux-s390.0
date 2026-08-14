Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D84457B8;
	Fri, 14 Aug 2026 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712758; cv=none; b=dWqpLivVL2HFzZBKX1NzN1HBQx4Z7nfQnqkAETy77my5jsgZ6nEZtuoqo4bauvvPnm3zyRnwMI+oLGVEvMf+KA2MmwMnSj66xRAVBrRm79PqtRmOyjB2GyPm+eFRIiClVdCSoC1rcafb1n7E1szAS3He4R15KiZqJBqg/AgzbIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712758; c=relaxed/simple;
	bh=FaMxajwDmgrfyWezIBhw766aPBJd4ai4FYKK8Hwtw5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvluvyPViqlzVlNuem8bBM7AGulaSHIo4e4IChUmb02GWMyUe34LMRcPimV4l8TeUUVTX/0LmyLq1bbfINw17w/fRevsgaodebyPOtHlTicpWZArGLNRkv8zjgQXdUVER7eYXsZWNWCdFWuacxDIFGovaCsC/gP3f+goODRisCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AusQgJL1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AusQgJL1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1lpI860633;
	Fri, 14 Aug 2026 13:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JSRBH/kCMGuvkyn7WD4sI5kh/AXYN9
	405kzAXftjPyc=; b=AusQgJL1m9WcEIUWMLxNPFyN/Anol9QiQpYnBtN3B1TOef
	TjBprYVT//x/RmfaUTyryAXVaRqzRyF8YNBYADu6atr9oujf8nVp1bihpA8Q8dT8
	JZ6RslBAEQyZL/QKEqBqp9ZQJ+1Q3xuRwwOndi4/+QYKil8eonPE+W56jO6h5ddq
	9iqNuNtwOm5nyGW0Y8kbUCCnD6gxh9YqvT8A+fTieies50tHZG9MjXrjtBdt6zxY
	FoTAH6heHcLB/ijp+Z6ilqK9w9I+TsDHeFBzeYfwwQ/q5ZSq/yLjX3rvv/aB2p3R
	5a1qBWOIL35y5fkmPv+rPH2wMPTxvq+v5CdH/ggA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3bqc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 13:05:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ECuZIW008220;
	Fri, 14 Aug 2026 13:05:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gq8f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 13:05:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ED5pdp44499452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 13:05:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 228712004F;
	Fri, 14 Aug 2026 13:05:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5B5D20043;
	Fri, 14 Aug 2026 13:05:50 +0000 (GMT)
Received: from osiris (unknown [9.111.40.200])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Aug 2026 13:05:50 +0000 (GMT)
Date: Fri, 14 Aug 2026 15:05:49 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Jan Polensky <japo@linux.ibm.com>
Subject: Re: [PATCH] s390/pai: Handle multiple PMU stop callback invocations
Message-ID: <20260814130549.15373B35-hca@linux.ibm.com>
References: <20260813070815.2692398-1-tmricht@linux.ibm.com>
 <20260813072156.9C4311F000E9@smtp.kernel.org>
 <e13682db-e68a-4196-807b-8c67bea68a2a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13682db-e68a-4196-807b-8c67bea68a2a@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7f12b3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=5gAsseg2trt6j1QRJAUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: TgUXZxFOpt3HYQtP4-js0KGVEUWY6_qD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5OSBTYWx0ZWRfXw0OVl6T8tUXR
 Ji2eprhF3qLPghpOJL1CxVFHn7rA1acu0QAsyT69YtRtVPpo3SVSHQrmb2GxLkcLb3uAruG3MpR
 RFPS8ZCB9cdnyrS71uPcN7X5OMxNebmNtD5+AIIj2vFzg2wlsAOSNkOR3jM+F6rWU6byVbvsGb7
 HySOLajdyTvThfZWkJKP70Kt9/mS26rLWMTJL/X+YyJ3ZyWwSNlfcM6aDYVdADWD8NJxyg8+6x0
 gj4793WCoN1xeYW9pGy3UNjrFvZPVE7TMIGX+y/MRB4mfbYSOx7R2xYP/STIfEvDRcw3DL9f+7s
 63Xe+xj8i8JJoXFp5Tv7o2p27wUEGvrSho4r0guWCZiYfeQSguED2nVq/+QPl9DEZPlRQr0H0OG
 J3F44+yxHUZiiFwI063nbYXNlRFfVgri8AqC62RySIVSS1vRQSsPz6DI0+K1j4SufnXshSoQmLI
 /DbTXt8RPbLAMdmwRVg==
X-Proofpoint-ORIG-GUID: TgUXZxFOpt3HYQtP4-js0KGVEUWY6_qD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5OSBTYWx0ZWRfX97/u49SRYFMt
 L15nqadbFUP8Wg+huYHLwSvbguHB9X3BYE8Y6QpyS+uD0+KnfVoh3RKwP+A3zkyL27/KdldxLmq
 aTbW1Nejfr1y/N1xQVQiO8pR2uH3Jw0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140099

On Thu, Aug 13, 2026 at 11:33:59AM +0200, Thomas Richter wrote:
> On 8/13/26 09:21, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] Unsafe iteration over `cpump->syswide_list` in `pai_have_samples()` leads to a kernel crash (LIST_POISON dereference) if an event overflows and is synchronously throttled during the loop.
> > --
> 
> This can not happen. The syswide_list is anchored by per-CPU pai_map::syswide_list and tracks
> all events which are bound to that particular CPU. The event was installed only on that particular
> CPU and does not move with the process/task. Each CPU has its own list anchored by
>  pai_map::syswide_list.
> 
> The call chains are either
> 
>  paicrypt_sched_task() or paiext_sched_task
>  +--> pai_have_samples() iterates over syswide_list and calls
>       +--> pai_have_sample
...
>  I think this is safe or am I mistaken?

Looks like this is not safe. The following can happen:

-> pai_have_sample()
 -> pai_push_sample()
  -> perf_event_overflow()
   -> event->pmu->stop()
    -> pai_stop()
     -> list_del() modifies the list being traversed
      -> potential crash when list traversal continues

As sashiko proposed: using list_for_each_entry_safe() instead of
list_for_each_entry() would avoid that potential scenario.
