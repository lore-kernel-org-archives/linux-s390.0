Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976853655D8;
	Tue, 28 Jul 2026 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235419; cv=none; b=k3JJ+vhl4Co57LHNFpzQvr4bas7K7Vihn3Ckp9+9BE/n8LRHTqoO1eT9JpBQF1Xp7p38OPI4Tm7nibo9u4EhZKEiIm+r+WqK8D+QQ+rQgk29t53eqESEmMlDLAFy0Mf0gQOR3/uh5LOQe6WHZ/nPC3a8Ymjr2IjVYRFCF7Covw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235419; c=relaxed/simple;
	bh=BVSL3zMO7wh9+iRJzNBbE8Cg85ys++giyQcFV+E/8ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxYc1dZrO3tiGNM992j/HYvjFm/jnP16gBGDg4l4EjRIHLlsSWSCpvYPxS/ZhxWBZeXG3b0T/CqVnM3RTiyy8Hpb7HxH5P/ASzqCArTjkxjAliXABTzXMCeDB/eMt3OUfp7lEmo3lZI3mvvxJbaDlpXolAa1uflCK7YwvalPtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HF6Nhe3D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HF6Nhe3D"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S8IB4b512395;
	Tue, 28 Jul 2026 10:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BYc0Yo
	EVS9WQvvde3hdU7aS103pG7UlxyZo0yPccAr4=; b=HF6Nhe3DfgjwNoqJ3dlnsX
	cb91Jmr6hWeaxNJlROPFTIgkywWuaINE370bHj+plmanIJdfOIhM/b37/XzfSFcB
	v/Lhw6rNgDXRQkfn4GyOaAnVIuD1gW7rCfQEI2E64lu6duS71zbpdXGoCzgZDZza
	t29rDk0YAUE8fBexF9XGDlUNX+xEMm6WcpORPVL0BNinLIDWRoXIaW60/AeoPFVg
	hEkKT4HH9s1IoCH/+1AEoqr6dg9H3GalOySLyo7uVaiYzuQLay7AtuQKPZmeRP2L
	3gq7JTM8TT/OEQSqnpx3GPjgwy9S/BpF8T+PaHYbZmOfhVFfhAwORYazbY7/7usQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xmqp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 10:43:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SAg2aV029392;
	Tue, 28 Jul 2026 10:43:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg96m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 10:43:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SAhHi626673654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 10:43:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C752220043;
	Tue, 28 Jul 2026 10:43:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F0620040;
	Tue, 28 Jul 2026 10:43:17 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 10:43:17 +0000 (GMT)
Message-ID: <5b9f08f0-4412-4841-b7c1-21de21557fe4@linux.ibm.com>
Date: Tue, 28 Jul 2026 12:43:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] s390: Implement arch_do_panic
To: Bradley Morgan <include@grrlz.net>
Cc: agordeev@linux.ibm.com, akpm@linux-foundation.org, andreas@gaisler.com,
        borntraeger@linux.ibm.com, davem@davemloft.net, gor@linux.ibm.com,
        hca@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, pmladek@suse.com,
        sparclinux@vger.kernel.org, svens@linux.ibm.com
References: <8E5EEFE6-C655-4319-B659-E3817DD24954@grrlz.net>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <8E5EEFE6-C655-4319-B659-E3817DD24954@grrlz.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AzCsHLvmTIx-IUhh874i6A8fYheMLl_C
X-Proofpoint-ORIG-GUID: AzCsHLvmTIx-IUhh874i6A8fYheMLl_C
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MCBTYWx0ZWRfX4IgzPpFcKjBL
 iHCFUDQog44ErDqewXETDhx9zwX9zeNLq8EK30UU2foMGZx7Nd/VG2B0n2ZSHDQjXiFlRtzLf9I
 Vi9h86zC2uN+4u6t59nKJTQNcoUyOng=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6887ca cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pu_0fIP_DWjBY3u_oFMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MCBTYWx0ZWRfX1Fs/pHPx/tke
 Y32k7uvFFE5jDM7LEQ3xYxtnjOj0Ry4iB+o3hIFPkT049iakRyfCHCZRGmkcenB3g64vAoaQ1Gm
 6Bg3Qxn9/Xy6r685HrQ1WNCU6vGOX5b4RuT4e4YUn4+olOuWW7bsyn8dRUhDW0YfV1bY64wLitx
 6tlGze3VWkmfnMbVx7F+ptXmI3avTcMwb5hAXXoTS7n3EhUQUCYR8raL6esE+9JBlb8PgOlnJzb
 ehEnRAq+3Gzhy7/oYgcjgvznTvGhPPMCE6bKMSkdypdYJXZnzKlLNBCm/pkAlmHdHEPEe3AIops
 g4ZpPUBx6A0pCxsEvW8IWdQTCD73hpiJW/z6a9rIY1txqvwNSR1L2Sih88UAD2BnRMfe6iM01w+
 HSYeGa22w0LCTKDelR/XnJhupvdOS2YMwCSZSdWaTGknV8ABiB9RIQgzJyQIzJaJAiQM9Gx2ZFB
 V6eIWWZ0G0u79mk4Q7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280090

On 27/07/2026 15:01, Bradley Morgan wrote:

Hi Bradley,

>> This now means that the panic_timeout value takes precedence over user
>> defined on_panic behavior.
> 
> this is the part i want to poke at. distros routinely ship panic=N on
> the cmdline. with this change, anyone who configured on_panic=dump on
> such a system silently stops getting dumps, because
> emergency_restart() runs first and never returns. a reboot instead of
> the dump you explicitly asked for is strictly worse. if you and Sven
> want that semantic, fine, but spell it out properly and give the s390
> docs for on_panic a line about the new precedence.

FWICT, there is no mention of shutdown actions in kernel documentation.
s390's user documentation is a different story. I agree it should be
documented on Linux on IBM systems documentation.

I'd argue that specifying both on_panic=dump and panic=N (N>0) is
a configuration error, but maybe a pr_warn() could be added to the
when on_panic=dump is configured with panic=N is set. That could
hint what is wrong if anyone investigating dmesg and trying to
figure out why system didn't dump.

On another note, dumping via shutdown actions serves as a backup
and kdump is the main dump mechanism nowadays. Kdump always takes
precedence over panic=N.

> also worth saying in the changelog what this actually wins: today the
> INT_MIN notifier never returns, so sys_info, kmsg_dump, the post
> notifier crash_kexec path, the console flushes and the end banner
> never execute on s390 once on_panic fires. after this patch they all
> do. thats the headline and the changelog undersells it.
> 

Right, I will add that part to the commit message too.

>> Fixes: ff6b8ea68f4b ("[S390] ipl/dump on panic.")
> 
> What's broken? What's buggy? 

I can put a couple of sentences on how and why panic=
kernel command line argument was broken for s390.
> s/now allow/now allows/ in the changelog..

Will fix in next version!

Thank you

