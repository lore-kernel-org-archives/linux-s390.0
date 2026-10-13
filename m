Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA048F005;
	Tue, 13 Oct 2026 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791875257; cv=none; b=mvCO+0E3SHeHhcgVODlF7NZ6d4R//7kfAqx1mOCowxUaKTt1sFXs1QF7laGHFPsLIUMLIttXLdZUqRRR99w6nSUed8HDYEPgrfCeJDZx9GAZy4sk6NH+V2qGYoyqmv255pOkwMMx3WHrF3/Z6j8MVcA0S68SzuPrPVCFLGxUVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791875257; c=relaxed/simple;
	bh=NSwKHf6UQUJyPOZE8jYIxQgicTYgDMApYsmQR3VPCh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ov6VHzj+wezhOYSJKVMP8X/beRCt6M+Ie0zIUVg0xPqsrfLb3DSAJp8xtDyuHHi/RsTt6m1bj7PUtwIAoOMht6b9IDZ2REO+/5dB9whuC0RrSXSDys2W5j68PqdLYnw+W4VzsIlaMxLSwc3VGVRUVi++vUQRLIVO2YH+lwtS+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ObSoaqmE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ObSoaqmE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2EjtP726214;
	Tue, 13 Oct 2026 07:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZnhVpwLQLQB4fDDT4IJGyJXgYCXqmX
	Khk00G+78IEKI=; b=ObSoaqmEHtqkT0T8Y7Ajc0GTIXmtjnGUwdPtH/61JgKqPJ
	Wzu0JuDEh414ncl1rD9MrvzKgB1f3PJFPRboQQYfz6U+i9geDUJB4uIBbwa+h6FY
	czNjCewHP3FrS987hoFn0UfqRLaKB0UmvhXCpSr2ZGssH1q3QO5wADPSthhPqN1H
	amDHE07B8VNexxbWKnNq8v6upkKTYXpwSwgsxlRArq+xULiuhnvr6ARviDx1QC7y
	T/LVdU0tPrRM7RQVzCb0ljac2Jer+ciqOquw5DgbojlvOZmBJosNvoMFZvREBU+L
	K0/HL2569wR8e1/y92slM0sAyvtxeAzBvHOclwOQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0c8f5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 07:07:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D253mI1022066;
	Tue, 13 Oct 2026 07:07:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg0e8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 07:07:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69D77Tur25756408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 07:07:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C76E42004D;
	Tue, 13 Oct 2026 07:07:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A798A2004B;
	Tue, 13 Oct 2026 07:07:29 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Oct 2026 07:07:29 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/signal: Fix incorrect return address in signal frame
In-Reply-To: <20261012153355.1529314-1-hca@linux.ibm.com> (Heiko Carstens's
	message of "Mon, 12 Oct 2026 17:33:55 +0200")
References: <20261012153355.1529314-1-hca@linux.ibm.com>
Date: Tue, 13 Oct 2026 09:07:29 +0200
Message-ID: <yt9dmrsixemm.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyNiBTYWx0ZWRfX/kwoxLBmXHrY
 kZYRbpAICyKGPNfDPYhiqQxV4AxNtAWOz2e00h4zPThmEbju9EXpO32UVdJ+7POcG17zz+ASXMX
 DwQNwYyenKwpaIvug7J4h7iqwji+dvpC4hb6urvYV/IpWAf4pctlZOkLMN8fidD1yuOnzpovOX1
 BOcvmLH8HTn92AHG4/fNRtCuizCmXCF0lXmphEe03/Q+p2yb9Y/Fp/dB65UY7F+a8pfwiOyG3XG
 0UOFFgkoFuOIzJ1bo8EevX8KLUuwA/UD5GcLTOZitZ42o/gCqhs2/wrZYmRLPzdGuFrJadqwrxh
 ncCRzB8gezBt0BTOmCZ8JF5DZMqL2IF7e01/4a7DQsKksjUCHNzM4gbIIKVNevTGjaATsIU51NB
 X8AZKvoB4uTUI7O8WgKq3HixNB1tHwB3Fmp2apfd74xdDG0//rs83KA6F2T6yGOIlwmPjKz8P2C
 40qOXecGTdfBAiHHvIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyNiBTYWx0ZWRfX+PrC2LQoOTHT
 wdPWobqBisd4+hzterCNcfOi9asqD1nUAzp1EQNYdXXQ70HCxT+EEIPAXaDBaPeoXBJWGhmR4Q5
 /nFIr630A9zSsrXkma0U6YhyKmTYJRM=
X-Proofpoint-ORIG-GUID: A0ZOZxIUQL0nWyGZnbmLzRBZMtE8UuzP
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acdd8b6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=YxXDSYN5aMXGUAyqVTYA:9
X-Proofpoint-GUID: A0ZOZxIUQL0nWyGZnbmLzRBZMtE8UuzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130026

Heiko Carstens <hca@linux.ibm.com> writes:

> exit_to_user_mode_loop() can call arch_do_signal_or_restart() multiple
> times when signals are pending.
>
> If the first call set up a vDSO system call restart by saving the real
> user return address and adjusting psw.addr so it points to the vDSO stub,
> a second call builds the signal frame with the wrong return address.
>
> Restore psw.addr from arch_data before building the signal frame.
>
> Fixes: df29a7440c4b ("s390/signal: switch to using vdso for sigreturn and syscall restart")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/signal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
> index 4874de5edea0..25781d4a0ad0 100644
> --- a/arch/s390/kernel/signal.c
> +++ b/arch/s390/kernel/signal.c
> @@ -475,7 +475,10 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
>  		}
>  		/* No longer in a system call */
>  		clear_pt_regs_flag(regs, PIF_SYSCALL);
> -
> +		if (!(current->restart_block.arch_data & 1)) {
> +			regs->psw.addr = current->restart_block.arch_data;
> +			current->restart_block.arch_data = 1;
> +		}
>  		rseq_signal_deliver(&ksig, regs);
>  		handle_signal(&ksig, oldset, regs);
>  		return;

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
