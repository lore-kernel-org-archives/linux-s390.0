Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57B841D205;
	Mon, 17 Aug 2026 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970650; cv=none; b=r2oPCbCAGZigXaBvcblQcNmPm4/yr4ARSGbitBQAv0uISzMLzGbmFvRPZYZmuY9UZFYAuBhPe8EpbQLjAR9kcPdHyWazOltM8piPQpKShW2AOrx+5ZuyT1t6N4wWZVNG9kogjbtHy8fyMl6zTuROoyys2AWq73Tjk2xdvDWU5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970650; c=relaxed/simple;
	bh=JHeIH2tKGzSiy94Kyeeliy+qi7UXXRpMGdxMafh0t+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3aaMKDyXKo6IldRshEItIvXUgiSnq8TzS4h35xRmH3KnyVJ8c/9O/FA5qi+MQUurJcqYmEBDiwL8IMX3rUT7h+U1SIFq/yMplNKp5ghpCohOOlHWXeZTIRikrCbTSOPDLf+ifkwg42bvXL5KBgAm+pG0BbGmlvcq2MbHt9jcxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rBkxQe0l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rBkxQe0l"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HCWAGF1442523;
	Mon, 17 Aug 2026 12:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1A89XK
	e493ycRWisJ1TywXDaBS10Yh1tyDERb7PZ+XU=; b=rBkxQe0lY0P1Nl8fKZ0J7J
	xo1efCt69Ki0Yz2fOaPR7Db+NUCmlv6ZNnf15syavGwnKMd9h6wNIp2++oVpAUwd
	lm1yOmRnZWdscZXfMyrXRXoiilEcTJppoF/XdiMsb5zErdT2LhoNykWZgIqPqKW+
	nveQdKKQsSKoKK3E3IkDkCtX0mMRAQSQaKmyczIojDe0wqiErNoEHvtnbXHEgwi8
	EK0a9G3+InSDjJLnhCi2id6gzpaYfntCdk09sZlhd+C3LtWZEXhb4CLJzFjTFY9m
	2lHyt00SlRoBHW5dVa9bLPKgQPtwJ0YjNWuYMRJAruYmKnTsN0IZ1QUucc6pCqjQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt1vwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 12:43:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HCfIi8013652;
	Mon, 17 Aug 2026 12:43:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejx1uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 12:43:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HChvXv6292116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 12:43:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC67058063;
	Mon, 17 Aug 2026 12:43:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B00A358057;
	Mon, 17 Aug 2026 12:43:52 +0000 (GMT)
Received: from [9.39.17.176] (unknown [9.39.17.176])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 12:43:52 +0000 (GMT)
Message-ID: <4954a75a-7dfe-437e-9a2d-17dcf81b4416@linux.ibm.com>
Date: Mon, 17 Aug 2026 18:13:50 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/smc: fix clcsock and lgr/lnk races in smc_diag
 dump path
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260807081606.3200128-1-mjambigi@linux.ibm.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260807081606.3200128-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a830210 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3vzxbusPCOJ1yxKwbXUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5NSBTYWx0ZWRfX92692Zkmadp8
 PDSHI4gQLo5cJHwXepjsqW2zLwi79Uk07sSvMAlzmQo4Q34DIyWW0XmgfXbqw/aDe9cogyf3+3a
 b+kQzheBAE6/lZdwTTrfwoYSD2lCUIs=
X-Proofpoint-GUID: dt7GUhKimeQgkHOJ1wVtAGvsidsYzJJa
X-Proofpoint-ORIG-GUID: 31kTdEVb3Y7BBaA0_HKgCQK3IaXLRpAP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5NSBTYWx0ZWRfX+J6iarJuIRbh
 EbK0uyysICZZ2CZeaDdYT/hBStiQCfUDa49FL6awbxQZTvu+39LahlXwCeOWYzwUq8KmSDweVjc
 CiG5k8A9GJdV+wLJ7PMZAy7EmRTTuClA+RnXHte5HG9tjdwjJUxUa02BZ23WsJ0ikn01URu6XXH
 xLuEi1YFyiHJaJ3LLgBpZPGchmNPoVzuw7k7ctn+cgyHMcg8Bv8cUzZmy396OVfTEwbFZB6NhX9
 UXZq9t5mI6GeWW42IYy1Qls5ve9FTqB7cXBYOFKaGghLrUHw5yMawdzZzKdz188SAU5aRw/Z3Ww
 L/mIDqrfq74lPSBQod1o4YuyzEZWMtJo5TQd/V/YfGjDM4ALLL9dL5OyGQl299ZerVAAbr66E0K
 GwyoSFeuwgmHgmy03naz43/Qqz006O0zg6sWu8v/QB42/9wn64PIPUQX5osXO2GSuCSj2wewjej
 IS7x2Xm1D3Ef5NhkDRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170095



On 07/08/26 1:46 pm, Mahanta Jambigi wrote:
> Two races in the SMC diag dump path:
> 
> Race 1: smc_diag_msg_common_fill() reads smc->clcsock fields after a
> NULL check, but smc_clcsock_release() can set clcsock = NULL under
> clcsock_release_lock between the check and the reads.  Hold the same
> mutex in the read path to make the check and reads atomic.
> 
> Race 2: __smc_diag_dump() dereferences conn->lgr and conn->lnk with no
> protection against concurrent teardown.  smc_close_active_abort() calls
> smc_conn_free() — which drops lgr and link refcounts — without first
> unhashing the socket, leaving stale pointers visible to the dump.  The
> teardown path holds lock_sock(sk) across smc_conn_free(); take the same
> lock in __smc_diag_dump() to serialise fully.
> 
> Both fixes require sleeping locks, which are illegal under the
> read_lock(&smc_hash->lock) held by smc_diag_dump_proto().  Pin each
> socket with refcount_inc_not_zero() before dropping the hash lock, call
> __smc_diag_dump() locklessly, then release the pin.  Restart sk_for_each()
> from head after each unlock rather than resuming mid-walk:
> smc_unhash_sk() nulls sk->sk_node.next via sk_del_node_init(), so
> resuming an interrupted walk silently truncates the dump.
> 
> Fixes: f16a7dd5cf27 ("smc: netlink interface for SMC sockets")
> Fixes: 9dbe086c69b8 ("net/smc: fix invalid link access in dumping SMC-R connections")
> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Hi D. Wythe and team,

I have addressed the review comments from syzbot and Sashiko for this
patch. Could you please review this when convenient?

Also, the following patch is related to the current patch and may be
reviewed together:

https://lore.kernel.org/netdev/20260813074315.554926-1-mjambigi@linux.ibm.com/
