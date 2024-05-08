Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B32BB0F;
	Wed,  8 May 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153484; cv=none; b=Fy/NvOLNjlZT0nhvan/1agmIPNW2s1Fm5pDE13vNjJBurMgOYjoh1Q0kOmGM1sN4qwH+i3TIG/iq403haNHxBBKfD8EYXHOV66jFUOcwYoL4NQr+gATcChUVE3PhZyMags0Zt5nJmbqfexdGzpfTxiI5SSWEFBATybZcowawqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153484; c=relaxed/simple;
	bh=2/B1AvDbPYoRKpM4N7vRpJx55synkX9n2MdyVbBvh5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECZuNnH8Ee9wkgAok8YsRl9nD6TfSQtCSeVCj2lvYXjqCOTDhutknL8JlL2iCVf/fHM8bbGL1R6DO5OHorugxYI2dcvWXdYlkAlpvC2TsBrw003adaNV4OKKZelFu1S1+x5wdqXK35PDi5ecMh17CuD6Irba148r3i4gdsao1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qKZTgCAt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qKZTgCAt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448734Ro022337;
	Wed, 8 May 2024 07:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=t2f0wotfwBV4tNtAR6+IXWVQwGTlmNIE9DFhCSDIK2w=;
 b=qKZTgCAty/huNtPFxKZoHg4PrWfmka98WU0x4npDvhynFuVqUAIElOoH5ClGX2kcWaiJ
 GC82o3658dWz5nvcNjT41/MWJkOy4jMxCRWJRpzNxUdRwAZLkzBA0qlbvM8TA74f7WVK
 KRkZNRKnjbRXh6G8lHdd1aPKkDUis2MSGIO5exb9IMR6VmX0D2AKFhUHtdvN+czNlksS
 j9BEzaM2zxhJRQQfgmS2wqV1VUL8tFT+O4BiUipCru3S6Ujb6LgwF09Xw+tw01/AhNwF
 LadpIOvfl8ZIoohcBGF291xC4fozK602BCo/2sG/vnVKSDKTT2DWTwzxXEud3hJhd59z jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y04nnr2ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 07:31:07 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4487V6wP002988;
	Wed, 8 May 2024 07:31:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y04nnr2t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 07:31:06 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4484VvXI026664;
	Wed, 8 May 2024 07:31:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xysfwkcwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 07:31:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4487V2fg25101004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 May 2024 07:31:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8D9E20043;
	Wed,  8 May 2024 07:31:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B9842004E;
	Wed,  8 May 2024 07:31:01 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 May 2024 07:31:01 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
 <vincent.guittot@linaro.org>,
        Dietmar Eggemann
 <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel
 Bristot de Oliveira <bristot@redhat.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Test online status in available_idle_cpu()
In-Reply-To: <xhsmhzft86wap.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	(Valentin Schneider's message of "Thu, 02 May 2024 17:57:50 +0200")
References: <20240429055415.3278672-1-svens@linux.ibm.com>
	<xhsmhzft86wap.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Wed, 08 May 2024 09:31:01 +0200
Message-ID: <yt9dcypwrc96.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zL9zjBJQejBI0Pl9aBSvDVgQHV1GXQ6J
X-Proofpoint-ORIG-GUID: 7EJyJOe8lqN3UDWbP2TUSCtlnI3kCFJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_04,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=560 impostorscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405080054

Valentin Schneider <vschneid@redhat.com> writes:

> On 29/04/24 07:54, Sven Schnelle wrote:
>> The current implementation of available_idle_cpu() doesn't test
>> whether a possible cpu is offline. On s390 this dereferences a
>> NULL pointer in arch_vcpu_is_preempted() because lowcore is not
>> allocated for offline cpus. On x86, tracing also shows calls to
>> available_idle_cpu() after a cpu is disabled, but it looks like
>> this isn't causing any (obvious) issue. Nevertheless, add a check
>> and return early if the cpu isn't online.
>>
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>
>
> So most of the uses of that function is in wakeup task placement.
> o find_idlest_cpu() works on the sched_domain spans, so shouldn't deal with
>   offline CPUs.
> o select_idle_sibling() may issue an available_idle_cpu(prev) with an
>   offline previous, which would trigger your issue.
>
> Currently, even if select_idle_sibling() picks an offline CPU, this will
> get corrected by select_fallback_rq() at the end of
> select_task_rq(). However, it would make sense to realize @prev isn't a
> suitable pick before making it to the fallback machinery, in which case
> your patch makes sense beyond just fixing s390.
>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Thanks for the review! Ingo/Peter, gentle ping, are you planning to take
this patch?
