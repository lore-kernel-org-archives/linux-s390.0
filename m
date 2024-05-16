Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579278821;
	Thu, 16 May 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877510; cv=none; b=qX2gGFyF+f29Z0GgxsAoZoMNwoL383mhD7ZbqAHiE3Hz1vZguHQ0JEksXJ1MK2z9Rr4ZxEhB5AA+AEqTmmA44XOjuaSSxVnvy0vvSo4BX0vnHFukvY42oP/LiZp1o61bj1UtBztCZmbJBIMK0fjzkgdB6PxbKEFXL1W3A2bfBp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877510; c=relaxed/simple;
	bh=YjsP4L4icgq/Y6Q4/G0kLiCQWYTDum7px1qoh4b1Pb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DexYgErVdDxkeyCF4yfbEaikmu07ysmnfR6I1szBRRj1af5F6FC7da8QWQgWWIIQjq4eMHWJwxH3OEXVVCu0B5gab/MjgM+zz8Cyrkoqo/QvdFdLLSKwtbSwwILfQxkXH4tMSBQgdN7YvAa7vMBvGhY8t4W1b6f0BVwkB9kW3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YUOJPQPb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YUOJPQPb"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GGVJPB018436;
	Thu, 16 May 2024 16:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=mL2ixIV4yHVtZCx+rAwU6k84asoS2aeQfzHRCssL2Vs=;
 b=YUOJPQPbEYYFutYkCQkc99kuAzU85sKyDTb5lNqcEvXtXgFiFGUz6oDCIM/AFZhuFvw5
 Vliki+kqlrj1/3rUvInswqS29sd2toZB5dCXMp6JBSopfiaS7TigHb2KYoO3lebNHj3l
 e915XGpmEuh2MLI3K0VX1U85Qwg9nv1mkOxP5LWw8UdUEd9LG70L90cK45uFsg9ufi/f
 kpq0A//RvtbAMEaMoCqtL6O4WzCKSBKfVa7NLO++GZI0OcALtwnjbDDaEWCVPVEAOrmX
 Tx8npJ0Jb0ppTNVzS5CFYVHwzn72lVarLxz7nbYtZiFmiStAECedqR8oe248VOIP8ZKV dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5m9mr9us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 16:38:12 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44GGcB5H031698;
	Thu, 16 May 2024 16:38:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5m9mr9un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 16:38:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44GG032q006027;
	Thu, 16 May 2024 16:38:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2nq32jtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 16:38:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44GGc6Yu50463124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 16:38:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E542004E;
	Thu, 16 May 2024 16:38:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E71C2004F;
	Thu, 16 May 2024 16:38:06 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 May 2024 16:38:06 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>,
        Juri Lelli
 <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman
 <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Test online status in available_idle_cpu()
In-Reply-To: <yt9dcypwrc96.fsf@linux.ibm.com> (Sven Schnelle's message of
	"Wed, 08 May 2024 09:31:01 +0200")
References: <20240429055415.3278672-1-svens@linux.ibm.com>
	<xhsmhzft86wap.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	<yt9dcypwrc96.fsf@linux.ibm.com>
Date: Thu, 16 May 2024 18:38:06 +0200
Message-ID: <yt9dcyplg1ap.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5pjcHBMCZzEwX7JOBh20VbQir2_jpalz
X-Proofpoint-ORIG-GUID: FE1He3IUYj5Qu-s1LFpWnP_-O3LLwCPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=673 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160118

Sven Schnelle <svens@linux.ibm.com> writes:

> Valentin Schneider <vschneid@redhat.com> writes:
>
>> On 29/04/24 07:54, Sven Schnelle wrote:
>>> The current implementation of available_idle_cpu() doesn't test
>>> whether a possible cpu is offline. On s390 this dereferences a
>>> NULL pointer in arch_vcpu_is_preempted() because lowcore is not
>>> allocated for offline cpus. On x86, tracing also shows calls to
>>> available_idle_cpu() after a cpu is disabled, but it looks like
>>> this isn't causing any (obvious) issue. Nevertheless, add a check
>>> and return early if the cpu isn't online.
>>>
>>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>>
>>
>> So most of the uses of that function is in wakeup task placement.
>> o find_idlest_cpu() works on the sched_domain spans, so shouldn't
> deal with
>>   offline CPUs.
>> o select_idle_sibling() may issue an available_idle_cpu(prev) with
> an
>>   offline previous, which would trigger your issue.
>>
>> Currently, even if select_idle_sibling() picks an offline CPU, this
> will
>> get corrected by select_fallback_rq() at the end of
>> select_task_rq(). However, it would make sense to realize @prev
> isn't a
>> suitable pick before making it to the fallback machinery, in which
> case
>> your patch makes sense beyond just fixing s390.
>>
>> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
>
> Thanks for the review! Ingo/Peter, gentle ping, are you planning to
> take
> this patch?

Ping?

Thanks,

Sven
