Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3122259F;
	Wed, 10 Jun 2026 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096650; cv=none; b=GvZ7rTfy10YI9GfIxgb876u+l/vJDYRtAe9LzFxXefamQiW9k+o1E3NPgMJKFckcADqjIKWULUbkCaNwRQapQdCYmgtwYMauxREptwEwZx81OiIcvNurLUwVvODzrWSX7oWMkkX3Q8A85OFZ8JAthWtW4TnfCsm8bFtZ85G3s2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096650; c=relaxed/simple;
	bh=oWOaaXlkCVv5uxt2sXh9GUnBE+6vcR158b8g2GOcbr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e/AegVlhsK2eFLyZs+DEvHDmquT/bn29f9HwBjVLltTcantRLooTnat/X+XNXr2oij5IZBEHhvaaY4du0u+NaBWgcDCtc1Yjikw1HEa0piLd5a66I9nlLaChYWcTfHiIphwLpbObMB5JQjD87Vwu5fU9MmRQ/plutCM9OU5VQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MFVyM728; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MFVyM728"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ABs0Qg1266651;
	Wed, 10 Jun 2026 13:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=oWOaaXlkCVv5uxt2sXh9GUnBE+6vcR
	158b8g2GOcbr4=; b=MFVyM728aZZAtpk2mErN5JrJT/QJdYK1cVQA8/UH06QK2j
	+RvCx3Q3B1zkN/+oMy6Wu9B/jIw+ZFJZrGRHObyzi0XZeCg5S94B4YRAVPARKlEo
	RuFjUn7WBM5lEjkP7o+3bby/v5WcRVkMcDgMrJxhq9Tf4zGI0awEx5oG3exFJ4G7
	724NS0r701ozxWfa4RTi9txzjXvukRCMGYOkAvZa7bO0QVIXqFfz6X59Swy5hc/u
	GYo3b6y1obLVxj65M6v74y+o9ctrRopKUCMezoPdac+qJdavWLf6PMWuh6wMynga
	zbqYdscad0BDxpuCYSapYLECFTLv21qXCsjBU4HQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye8thr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 13:03:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ACncNV018243;
	Wed, 10 Jun 2026 13:03:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjxqjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 13:03:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AD3T2F49086740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 13:03:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 816B72004E;
	Wed, 10 Jun 2026 13:03:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E7942004B;
	Wed, 10 Jun 2026 13:03:29 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 13:03:29 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
 <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Dietmar Eggemann
 <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin
 Schneider <vschneid@redhat.com>,
        John Stultz <jstultz@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Joel Fernandes
 <joelagnelf@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, "Aaron Lu"
 <ziqianlu@bytedance.com>
Subject: Re: linux-next crashes in scheduler on s390
In-Reply-To: <17e75ff4-cf90-4772-9965-92a7235ca806-agordeev@linux.ibm.com>
References: <17e75ff4-cf90-4772-9965-92a7235ca806-agordeev@linux.ibm.com>
Date: Wed, 10 Jun 2026 15:03:26 +0200
Message-ID: <yt9dmrx2wns1.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEyMSBTYWx0ZWRfX8ztmBfnYQHXV
 Kraz8ggcYm/DAHWOnHgaXd/YMfstzjeNwl/Sy5ywFurq1VbbWHvEbOl675r9fa2myErT7f2inSN
 O9rjgk3I0g9yiw15Do6m0snJGGKbcL6tuBlkqzoQ2xDCXj1+TmVPYLpgnjbli1ziJ9egPUSY5l4
 cs93KciyF2JkduvZ1Q51xVAtO5u08UyvodvrlgBcesy+LXyi4h6lq8zvhz5Acz/E8aBmY3wAktF
 8QnxLCh/PW8zPaAHZu55h8Daat6mNW5aXHvd6HjRm2/N6TFLvAoCWXV2I9lG8Z28RqxHy6EA38A
 inWwX3/TKa+IlxpdUbQTpXOo2Veys0kHyKQaxkzkNIWohLusOpkro5gLK4AXFTrAQ8e3RfBuRFL
 DP5bl/TM1BWM74VVLw/4w4gVUkOvAYtOMB65gHcAEQ7w9MLNY58BcT/Dmh8u9NYYkOAPtcHzywG
 rFIuK/+nFyu40sl7kmQ==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a2960a6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8
 a=VnNF1IyMAAAA:8 a=mU7hYW_smJ6EYCDG9gIA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: ecjgZR-H8jpIbbvPGWj48Djxu-XVL_ca
X-Proofpoint-ORIG-GUID: iSXWIMWjLyJg4_f2SAWCjpEEN3xb70Mi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100121

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> Hi All,
>
> Since about June 1st we're getting strace test suite (make -j$(nproc) check)
> crashes on s390 in linux-next. Those are pretty easy to reproduce, but I
> have not been able to nail it down to the particular commit/merge.
>
> I am going to bisect it, but since we are approaching v7.1 release, any
> hint would be greatly appreciated!
> [..]

I bisected it to
https://lore.kernel.org/all/20260511120627.944705718@infradead.org/
("[PATCH v2 08/10] sched/fair: Add newidle balance to pick_task_fair()")

Adding the patch proposed in
https://lore.kernel.org/all/20260603095108.GA1684319@bytedance.com/
fixes the issue for me.

To reproduce, running the strace test suite seems enough. If required, I
can try to figure out the exact test that crashes the kernel.
