Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D86368D78;
	Mon, 14 Sep 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405382; cv=none; b=LiZagMsRicMtn5zLBXQrZcLiWceGMEQajuuoM80I+s77cyjh12YdoTWeWqTWD0APECa9h2OelE9oNtq0ZsAmydYAW1See5mfFLBbwULAA8zGkIFrIiz99/jf7nfDe7bx00SVqBDqKAgt+gHA0GBH0FcRxxU9+Cd9g+3kscrKrlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405382; c=relaxed/simple;
	bh=dYCXpFw25I3Y7h9Cj8YGjW/IEpXG/wwnKMKLMnnlhME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFRb6wBRiB9V3PozQZ8DEXgRSgDG9EnxMqBo9jIVOLCizAvc3k6bvVVTbcH315fxQOPbz4TcpnCdQHOBtZfOui/F5y82gjBlbgL/XGmg4nPs3kb3L/JVjCRUfoTs/Sc20GC+BYfOyPVubzKl6Ofv7xIB2cgbzuit8IskzZ9+sYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=avqkMUJX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="avqkMUJX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EFvlhe2495103;
	Mon, 14 Sep 2026 17:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dv33IYOEp6gB7I/zkPCMed4YnTOuiy
	Vonfo2LDra4BM=; b=avqkMUJX9bwy7vnvVLI0axJ9wtxv+VWe5KlJcTTWJzR4B4
	x9E2MC8He02jqhSdVss6ZcuB8iHAzcRzo3yxTHBfCP6CVNi0ojGXuh/4gFuLAekC
	mNSdEYLLmTEEUxisd+l+OcN7g5hkqwV67v+Hj3lk7y3VGcb3caijhA9ZobbHerro
	dUMs7+xqDD6O5fAnmeKK5TIR+oZnJl5/0F1PhE0Q3V9so6GThl2ONkvbwYbLGmTy
	dHm2ljAjFNZJJ3Qp6Lr62yPVqsWNtuHNc9LnS/KF0JPzBWNNNHU8LX6gxMqogvZT
	cFvfMD4S2FdWAf8JoKoo5ex254egUXKZCIDpY5ew==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4ttcg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 17:03:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68EGd86u2333687;
	Mon, 14 Sep 2026 17:02:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnjjgq3mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 17:02:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EH2tDe51053044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 17:02:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 257512004E;
	Mon, 14 Sep 2026 17:02:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C99AF2004D;
	Mon, 14 Sep 2026 17:02:54 +0000 (GMT)
Received: from osiris (unknown [9.87.150.220])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Sep 2026 17:02:54 +0000 (GMT)
Date: Mon, 14 Sep 2026 19:02:53 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Jan Polensky <japo@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ciunas@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/rwlock: Add contention tracepoints to rwlock
 slowpath
Message-ID: <20260914170253.14910D83-hca@linux.ibm.com>
References: <20260908135843.1384367-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908135843.1384367-1-japo@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QgubwiQRHltJ97dq5ZBuBi4FDk_ia1vJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0MSBTYWx0ZWRfX4tJO5h1ROpsS
 4lK/8Ijne0Q6HXl1LyFyeTYIu8P1xQVV5/rYNPw+YBtkn+9icNykLX33iZHORJXNbL4kj9tiAbA
 k2IpneO6ZQGbeAY88qdbmpRaL/8WakE=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa828c4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VFibKQHTiDGcZmGrcJYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QgubwiQRHltJ97dq5ZBuBi4FDk_ia1vJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0MSBTYWx0ZWRfX83maR1TKlfZD
 7/nosdhu3kyoufQDv2jxRvDgWxGk3GUMvJLoxekLOXN1FwxXsW6LoC3ZBDX8NarytP+ZYdX64Ov
 S4VKEl2RgEIWP+JrZKMEGn4qEdbtw3ubwFPYCY4mPXoooH2iCQndOAzX4mhRac1I+SGF1pWr8Qk
 RYXX5VGIrUuWUOohBrZY3al61lhL/agAJ7KD3HWKW1WncfV7dY1+v3CqiMgIr2ONmqbPrSscsKq
 vIT4JvnaiZz06/SfFQywiKltZhM5P6xvmqzGc9UYiC2HJXSDacB5tmpl5qsK7c+ZDcJIGgmikq2
 vdRM6qjoGHrfmtfTnvppNWdgovGlbSqXjyAxZHkSMs7z7uBpRCrwZo/9BClC97f7WyN1R3MWXX4
 5AOsrGOpzWorXnNef/p2TPMb/2Mba9xf/dT+KgzA7L21sAgetbnoHfqNLAhXC0GQqJS4zPCSIwR
 ZYzqJaYiWO4Azk2JLqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140241

On Tue, Sep 08, 2026 at 03:58:43PM +0200, Jan Polensky wrote:
> Instrument arch_read_lock_wait() and arch_write_lock_wait() with
> trace_contention_begin() and trace_contention_end().
> 
> These tracepoints are used by lock contention analysis tools such as
> perf lock contention to identify contended rwlocks and measure wait
> times. The generic implementation in kernel/locking/qrwlock.c already
> emits the same events from its read and write slowpaths.
> 
> For arch_read_lock_wait(), the in_interrupt() fast-path is intentionally
> left outside the tracepoint scope. That path spins without entering the
> wait queue, so it does not represent queue-based contention and its
> duration is not comparable to the normal slowpath. This matches the
> behaviour of queued_read_lock_slowpath() in qrwlock.c.
> 
> The include for <trace/events/lock.h> is already present from
> commit ffa796cc1f45 ("s390/spinlock: Add contention tracepoints to
> lock slowpath").
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
> v1 -> v2:
> - Fix tracepoint placement in arch_read_lock_wait() to avoid recursion deadlocks.
> 
>  arch/s390/lib/spinlock.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks!
