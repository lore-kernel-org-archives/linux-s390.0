Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E457ADF76
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590048; cv=none; b=XhNuBNYpjUan3m4rie3TX0BoOAMuOQUJq9CQmDvqZlxAotB4Rf+qlY0Ygeac9lemlAwEMNoUB9RCkDn8NBRQ09kepdoi8hPJ7JzzKtXYIZuATjmFziJM8kwL04DFAPT009sEKuPj0y4+rXwk77+gI3DGA727lPhPHOHUSGsN7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590048; c=relaxed/simple;
	bh=vlVHyE97qaX4FN7PWmxemMUnWUia3tfid/52r6tWZuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsUzwcvqKprWednCjGqM88ooG2/MJ8MN8bfgi9aHomPif6LYAPviSQuuXRyRodgmaN4ahnjhOT0NdqlZevK95V1XSmMOUZBPnf4KqE0ep3HzM7nhXpwC/qs0EiVgtmQfLv/foMuvd3JTCbwMEYzRbiTRhFTRPp65xlshNeBB4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ThQsfLvW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ThQsfLvW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OG1lLQ2260384
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 16:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=afz7Tixxdk4yzQiEUD5O/d6vzG/G/V
	MeIachNu2wmMg=; b=ThQsfLvWMSZpepk3qggdTk+MGYgUBWez+vrLAmJ4lUfgVJ
	FfaGt4G+kyHEzWiNR1P5bJELa5VEGsrJgKUOGafq56Y4XLsVvElJn9DY7tNldf4k
	m9f8wuDqXLuql0kw7F0xGnzL4/4LwxumIk3HoNAefgwdjhG2wjqnL5d+YMbsdkyd
	Onqdpj/9Ba/az1YVV1BQySgrczgN7hIf+DJUtuPAsR3bmMi0bjM7uVWKQ+PMRDFv
	CZRnzla3/MzoYzIx/xKxDBP09fl+yBXvwVJd943wS0KYUTWS7c7wHi9bs5nN9Vcm
	V8neFWBWpyDLdRcLhsxp0UUKXQ2OmbvLkkgJkpMA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hjyf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 16:47:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OGfG2I016730
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 16:47:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgy4j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 16:47:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OGlKYo50856352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 16:47:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A8AE2004B;
	Mon, 24 Aug 2026 16:47:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A88120040;
	Mon, 24 Aug 2026 16:47:20 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Aug 2026 16:47:20 +0000 (GMT)
Date: Mon, 24 Aug 2026 18:47:18 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v4] s390/pai: Handle multiple PMU stop callback
 invocations
Message-ID: <ttka9au@ub.hpns>
References: <20260819055855.1001578-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819055855.1001578-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfX8IjAcV2nC22O
 BjyX9hBAhHA28izAThIby2r+9S5IV51Zp2285xAgdoE/eanUoT/+m5DiDvZh+7SuTw5QzGdwnGY
 4R/iPIkcQu6lgS955oViExiig8YEoX4=
X-Proofpoint-GUID: 4dSUH5jQgUCUNq9ShpBOLMoHH4dwExJJ
X-Proofpoint-ORIG-GUID: 4dSUH5jQgUCUNq9ShpBOLMoHH4dwExJJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfX6jStq25GvapX
 9Odvh5Bgho8hPddSSx+Q75mZxDl73c4Rsoc4bLODttexjpqHiKwfvq/JWTAYHlBX4+8F+vvZH7G
 TiEy8eqmqCpSNQTHe5Jp5FfiiGpayhDlcmAmj2XbHk8vvdZbNNXxlN703bZN3TX3h9KxLmPfqZP
 0f/8nKna0ZUbPtp1/84beRW1HUpSvZLG0hUlDajVEUzOIegyMHEjM7pHz3YjrXU1BjPjQOpzl53
 PNxs0pOv6xl0EFtim1NCo1ZxO3kSLf+oKtMlnyOWoa365VawTF357wfYB0z3q74acQBAe83KUuA
 ogufuY7st1gO7HFQbeGJitf4MZrakXDO/p8DzaUJsCNNg7lQmB5UsAVxJgEyYDImujcDMfoX73s
 ZA0/yE8dPWPzxaRjTWutcAE9d7HdL/hg+BKLThIaJEGAtRsw5HHDUZUpSx5trAme3+0u/GebMU2
 6TsqVSLa387OF0zSUuA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c759d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NVClWf_bVsLb5A40ADMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240139

On Wed, Aug 19, 2026 at 07:58:55AM +0200, Thomas Richter wrote:
> Handle the following scenario:
> The kernel protects itself against a very high sampling load and
> throttles the sampling using:
> 
>   perf_event_throttle() --> PMU->stop()
> 
> Shortly later the scheduler may terminate the task and removes it from the
> CPU. It again calls
> 
>   PMU->stop()
> 
> which results in two invocations of PMU->stop() called back to back.
> Protect against this and check the PERF_HES_STOPPED bit on function
> entry.  If it is already set return.
> Clear bit PERF_HES_STOPPED in PMU->start().
> 
> Prohibit ioctl(fd, PERF_EVENT_IOC_PERIOD, ...) call for this event.
> It sets perf_event::event_limit to a positive value and causes
> perf_event_overflow() to invoke pai_stop() call back function when
> perf_event::event_limit hits zero. This is not supported because the
> sample events CRYPTO_ALL and NNPA_ALL are only taken at schedule out
> of a task.
> 
> Use list_for_each_entry_safe() for safe iteration over syswide_list
> in pai_have_samples().
> 
>  #Cc: stable@vger.kernel.org # v6.19+
> Fixes: 9f66572f2889 ("s390/pai_crypto: Enable per-task and system-wide sampling event")
> Fixes: 582cc1b28e8c ("s390/pai_ext: Enable per-task and system-wide sampling event")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/perf_pai.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

Applied, thank you!
