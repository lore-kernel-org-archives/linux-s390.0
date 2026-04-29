Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2134E744;
	Wed, 29 Apr 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487025; cv=none; b=vGlBpHu4DlivGLjLEuBVMQIi6a1GGxa67BtP11GpfBp5DvpaRGbGUFDcJgx6N5w7bOvQzOxghcsJ2eD6AbE5BpSA8W9NbvUZsG6HRgqxYQqANMBey+lVa/aj4ddL8zt+pb5VWktEVY1J7n31WEC/5VicDde1iWI0tdquRoGqqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487025; c=relaxed/simple;
	bh=KiruBSVhANb6D8J7R6X3uWaM6Yzub4B43ZJp5d4Y2MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIfn9KMSkTQj9tICgAfiS5A+3+lEDuogUgm7mxq9nFytM09MfmwuoMCooyLou4yK6SwJCgK8SCI+zPNhNFInU/l1QNXnpg8oSe1acRWW4PE7q1E3CtQNkdFS6kyyCjSkG5oZcDCxkaMFHNET46/04a1Xo6nAqsJyKfnptm1tqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MGew7bTj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MGew7bTj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TEvhwY899091;
	Wed, 29 Apr 2026 18:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hggstm15V1Locaw5qgAUyb5BTnjpbw
	6T+dhroKVFXLo=; b=MGew7bTjtK41h0yzNRTP/c0h4Qa/yNXJ+4eQah5LMi3Lxp
	FSMiSAZalSG6GQ7gcIxthvLK0drtsWKweWNPJsqfYQwJJcpwiUG14rg61m8FiUtJ
	NCGrmiyX0yUBLwZNK6rkiKw7ycdsgGLZJ/XYlyykp++H9o/IUI+6vqsXra0A24UJ
	byQP4f0EGLPQonP27J69Hn0LrKdLYyZR+ln/+oUoVBAfiJuVd8Mb15JhGLyt3SjB
	wAanuo0QHppGTKQS7R76NKOo1hERBvLe23NnofyJzw0RGrh8n0yG1boksUetcSCY
	qnDNPPEHdbMG6HJYgxrqSWE7e3FoAUs0NYyeZ4DQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5c0qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 18:23:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TI8lgK023121;
	Wed, 29 Apr 2026 18:23:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gfdf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 18:23:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TINa4X52035986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 18:23:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3825120043;
	Wed, 29 Apr 2026 18:23:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78E5B20040;
	Wed, 29 Apr 2026 18:23:35 +0000 (GMT)
Received: from localhost (unknown [9.111.69.68])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Apr 2026 18:23:35 +0000 (GMT)
Date: Wed, 29 Apr 2026 20:23:34 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Samir M <samir@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <tte9pra@ub.hpns>
References: <ttd89ul@ub.hpns>
 <073abb55-197a-4519-b177-f9f776624fed@paulmck-laptop>
 <ttd8que@ub.hpns>
 <024e1e59-c901-4494-9935-f6871af88b2d@paulmck-laptop>
 <2157a59f-a1d3-4007-b8ce-3a7b0e0b9057@paulmck-laptop>
 <ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop>
 <tte9o87@ub.hpns>
 <022fe334-1c53-41f1-94cd-96140b2f9cdf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <022fe334-1c53-41f1-94cd-96140b2f9cdf@paulmck-laptop>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f24cad cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NR5ev6yDxV4NLjt8mV4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4NCBTYWx0ZWRfX+C1w57xVNpc3
 TjBsE/YOaoqUZcHEGnDZOq+iIvGE9yM60SffvQBBkKN7na5/hwN8pjlhqFgSEJHYnPM5AvWF+h4
 lkRGsGreAwaTXlGHfvfBVG/8KO917Zqzchuz3dko7RHFTHNkrYZ9tn+gUoQf9V1RZLtBQO348PV
 a6slvDWFw32pWY2e4HhANhG756BmLfkEm6RltlwWtufydlWisx5Mq4O4N2MjU8Ox0Ljas8x4N1y
 DpmtPPrls3E1uW0vJYvdKIBSphYOI8qSaWvrseAOcf+TZrKUv88zlBWDg8b1azOnTw33SHlZMpW
 pPANi/UyVLuQxnIm+wxgGKwejumrANGkkkbV0wHzf44r3DDrUhIfhYTSCrk8epKMJYpvdcZVXyV
 oEoIVI7Y/hHrbLaRmgpfRRpW/TCnkMo75eRuKphL9Z8vh7d7DQL5oetIbPZuaj7PzE2t+whXpai
 Fw1AgzEKpzIKDT7h8Ug==
X-Proofpoint-GUID: R9WBkUSRa7-JAuxWi1uVPoI4oKH-GfyS
X-Proofpoint-ORIG-GUID: gQMOXejSNUXphDVRbOWUpW5z5BfQTHoF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290184

On Wed, Apr 29, 2026 at 11:05:02AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 29, 2026 at 07:50:31PM +0200, Vasily Gorbik wrote:
> > On Tue, Apr 14, 2026 at 12:24:12PM -0700, Paul E. McKenney wrote:
> > > On Thu, Apr 09, 2026 at 09:03:26PM -0700, Paul E. McKenney wrote:
> > > Please see below for the full patch, including refraining from queueing
> > > workqueue handlers on not-yet-online CPUs and diverting SRCU callbacks
> > > from not-yet-fully-online CPUs to the boot CPU's callback queue.
> > ...
> > > commit ce533a60b2ef29a9b516cc717e77c6b679bc09c0
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Thu Apr 9 11:16:02 2026 -0700
> > > 
> > >     srcu: Don't queue workqueue handlers to never-online CPUs
> > >     
...
> > >     
> > >     Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >     Tested-by: Vasily Gorbik <gor@linux.ibm.com>
> > >     Cc: Tejun Heo <tj@kernel.org>
> > 
> > I retested it on s390 and on x86 KVM with --smp 16,maxcpus=255, all
> > looks good to me.
> > 
> > FWIW, again:
> > 
> > Tested-by: Vasily Gorbik <gor@linux.ibm.com>
> > 
> > Would you mind adding Cc: stable so it gets picked up for v7.0?
> > 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > non-preemptible") is what made it reproducible for us.
> > 
> > Thank you!
> 
> And thank you for testing it, plus apologies for the hassle!
> 
> At my next rebase, I will add the following:
> 
> Fixes: 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when non-preemptible")
> Tested-by: Vasily Gorbik <gor@linux.ibm.com>
> 
> That should pull it into the needed -stable releases.
> 
> Seem reasonable?

Perfect, thanks Paul!
