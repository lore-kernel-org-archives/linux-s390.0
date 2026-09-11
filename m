Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947A49E12F;
	Fri, 11 Sep 2026 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128675; cv=none; b=FVmmpVqSH1BoOPeYBXk9+OTWYe7DVhCJ+yfUdZ+1MNkrit9IiwNlfIjzR4qXwbBoQ5hDxqDCCYb8ULFd8zIXR6J+zdqsoGUIK58dCip552ImoFBNccuoznd9S5PWmekao6ukXQVeJ1n1Sb1xs/iWpAr4+uz/ZL0wKnFcF7gK8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128675; c=relaxed/simple;
	bh=HuYm4W3vzsxucXJ37lx6SX/wJgtWGWCIdeQ6dqbocQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7jgBEx82oWABowKlNxpTxmRPsJIwIozJJH4BvqpcgGPAtnI6CyCS0EU4F/qB1cqdwcvT5cmHG4j9jDBqOMY8YF0BKm/g2dp6UhQO1LTjo3nqVXU81UIYxeEeFBN5iObZPEWl3ZqJwzTRXYhCv0z6HtxmBhW4pV9+v3fpy9PyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C1B/e7g4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C1B/e7g4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BB1ge4457187;
	Fri, 11 Sep 2026 12:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hitssf
	Jh+BAoSSPoO9RPsMKDioeLjqiXO+CBQgdlOYA=; b=C1B/e7g4EVY379J29VlQmF
	R+9CqNo7ajN21t5RzTUEFDBL87/mb8GZHCFVoO5sO1nYygpZoSG6aHjr12PWvyDk
	K4hxZ5awnPmc49kkvqNw7gTDHslU7idYIyu0O/ZN1O/e1d++xW6Zh0t5sI8lD4gk
	qXiKB9f2fyDRW1uNGPd5LQrfwH6h03q5o5yItnr2UOF7TtYsxQT6c0OPslhzu4DI
	OFgkCD/XvNsnnb7ncoivN7rRQE28RZYxKOUPBYpuLy8LIb0DLaKinaoHywxR4n7M
	3MTZdXEEJIfDK33JASXciNQL4gy2JVIrSb9+hpNnCUQ9aADfaEtX6ZCeOK0R2/IA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qb8ha-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 12:11:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68BAo4vb1499347;
	Fri, 11 Sep 2026 12:11:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk664s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 12:11:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BCB5xQ27656814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 12:11:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C16E5805A;
	Fri, 11 Sep 2026 12:11:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C08C65803F;
	Fri, 11 Sep 2026 12:11:01 +0000 (GMT)
Received: from [9.124.211.27] (unknown [9.124.211.27])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 12:11:01 +0000 (GMT)
Message-ID: <765ef2c2-124c-4214-abdf-06b06d3ef631@linux.ibm.com>
Date: Fri, 11 Sep 2026 17:40:59 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: fix abort_work termination in
 smc_conn_free()
To: Paolo Abeni <pabeni@redhat.com>, sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260907114721.1303498-1-hidayath@linux.ibm.com>
 <20260908114743.481841F00A3A@smtp.kernel.org>
 <3991782b-7a63-4bc9-94c2-02b3f9173586@linux.ibm.com>
 <ebded824-c858-4187-948c-b5444f4bf82c@redhat.com>
Content-Language: en-GB
From: Hidayath Khan <hidayath@linux.ibm.com>
In-Reply-To: <ebded824-c858-4187-948c-b5444f4bf82c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SrHgsE58s3t8gBSWPUcIOQy7UnNlwvXT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE2OSBTYWx0ZWRfX8eFxag7UDNSU
 8WDpc6JMveNuTB/7pyOsNFXX/nYcSawIt/xetjbijvRhLvbysGNP2VBSVwwE6LPysVoS+uk1CgM
 40T9i0D5/wydo0PKlC8oaHgXjD3urzA=
X-Authority-Analysis: v=2.4 cv=E/dYNqdl c=1 sm=1 tr=0 ts=6aa3efda cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=UtPUOyP3EEdAFgR30jEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE2OSBTYWx0ZWRfXx82TxEo5jpr8
 0o7Q1oVxpFkhBlQ3WKzWDIN4RS+bEdo97znFGHXThqPpe/RaHwfOPxKBE6uvNe/ITMMBiiSXq/P
 r/7QghzGu+P3BO5dcMhdL0uv9sd0dbZiWTHTteaHnFNcs/6UKzwFSGwcr+yTDEq6doEzBQcpHqD
 hGtRJRziS9aaoMEt0GanJ5339d2yQCActUtN0df1Wph40fFa3ttSsnHl4NOz9ESOIQq4BIr1EVl
 AraPoNIALbW5TY/1dDWV0kdaGGZZAgma5tKyD8waS0ryBp2CC/Ibk0MClS43JVsLWLC7NQv8kXd
 QdSW1yJWnMCsm47Mk+LiW23SQVf1zeUPsLre0blfiiBAe8HagrhKXSsFWdZ92ahDLaKRZNJGlLh
 wlra5gEIdRyXYuoY7khawIht14/AzR4mXpHgysniq5ViefDQDd/UgCh67Y7ZF7qO0PFWe6BUrsy
 7d5m0ESOMsjVV92lLDA==
X-Proofpoint-GUID: SrHgsE58s3t8gBSWPUcIOQy7UnNlwvXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110169


On 10/09/26 4:20 pm, Paolo Abeni wrote:
> On 9/9/26 8:48 AM, Hidayath Khan wrote:
>> On 08/09/26 5:17 pm, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>
>>> Pre-existing issues:
>>> - [Critical] Late-queued `tx_work` can execute on a freed socket because it does not hold a socket reference, causing a use-after-free.
>>> --
>> Thanks for the Sashiko AI review. The finding is correct.
>>
>> tx_work is the only one of the three connection work items with no socket
>> reference:
>>
>>     close_work   sock_hold smc_cdc.c:420   sock_put smc_close.c:444
>>     abort_work   sock_hold smc_cdc.c:324   sock_put smc_core.c:1754
>>     tx_work        none                                  none
>>
>> The link group holds a reference while the connection is registered, which
>> is what hides this. smc_conn_free() drops it in smc_lgr_unregister_conn()
>> and never cancels tx_work - it only cancels abort_work - and the link
>> group usually outlives the socket, so lgr->tx_wq is still there to run an
>> item that was queued late.
>>
>> Worth noting the fix in this patch does not transfer. conn->freed works
>> for abort_work because abort_work holds a reference, so the socket is
>> alive and the flag is safe to read. tx_work holds nothing, so by the time
>> it runs there may be no conn to test. It needs the missing reference
>> rather than a guard: sock_hold() at the three queue sites, sock_put() in
>> smc_tx_work(), and the reference returned at the cancel sites that report
>> they removed a pending item.
>>
>> I will send that separately, since it is a different work item and a
>> different fix. This patch is unchanged.
> Could you please have a look at clashiko report, too? that looks
> correct, too and more strictly tied to the issue addressed here.
Yes, the findings are correct. I will look into the report.
>
> Also note that netdev-wise the most relevant sashiko instance is
> the nipa/clashiko one, as it includes reports/reviews/findings
> from the public clashiko instance.
Noted, thanks!
>
> /P
