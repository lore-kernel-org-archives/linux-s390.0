Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4923955CA;
	Tue, 13 Oct 2026 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878183; cv=none; b=cyrxZqIrAenWPgAZFxE7NSMY/wV6FS95O2T7PMROjqRBxIH9W5Rl8DPzOK9lhNcKcKDxFnIxDwe5iYbl94oJOV5SNFG/rMWQ8YcufUHglUwhKuJH2dMFTAhFCr4sHWZUHqmQptmZ6DRgJwcdR2FBfCZhnDAY2axH46vpnHs72W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878183; c=relaxed/simple;
	bh=xSIAJ1DaiDyKUyg9EdnSf+IwmHXFwU6ymJI9XH/LEPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It12Q6EiY8wTJIEYA0yv1v2cx2WqfUBkCDD/FtfEeCRT77RPJ7F4ewOxKWRt094ziRiiG+Xg8hO/WU+X9SpJk0ce6doCeN54ee2h3jBqnPTGrmg+LeMuGw1IySnEePW6XrOXcnNhlkgImiMyELoLQhOMcXGG6sj41hwthLxzT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TqJBD840; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TqJBD840"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2Edvx1891473;
	Tue, 13 Oct 2026 07:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Qw36zJzIfV1HHtX3EMvJVDGnqGH+1Q
	Yyy5NqHK+ee2Y=; b=TqJBD840LUVKklUlN500LNB0S8XB/G/Egzk+eW2QecBZIM
	rdzipJWa4XgAbWCP1s/UBZsLh6syAS/1YTc/An58AEopwwBcUV0wXp9KWnmfzCFB
	6aQ1846qUw/EBnsjj0SOh1BwPLBuTGsBcxZy85VPNpAkIOipSyvE7J56E/4F1gyQ
	iWedP0bvnooOfFDX4JqdG/8FSl6LOORLjNizU7wpqkeBTPFaVadzyFVtrKwRS0rG
	/9vbpwW+vwscqNe6VCfl969SRiBgPELb8dzKFah8mhKu6p507ltBMxP7j4/0djTf
	v/GlpEqiLQOZjvkcOi5hJpVJP/UaJNjat07d20Fw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3csna-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 07:56:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D7GBqh2227415;
	Tue, 13 Oct 2026 07:56:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjrrjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 07:56:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69D7uG0231916516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 07:56:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCBDF2004E;
	Tue, 13 Oct 2026 07:56:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78E5320040;
	Tue, 13 Oct 2026 07:56:16 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.64.221])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Oct 2026 07:56:16 +0000 (GMT)
Date: Tue, 13 Oct 2026 09:56:14 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/entry: Last breaking event vs invalid kernel
 stack
Message-ID: <1a65c29c-60aa-48c4-b82f-ae746d3f0781-agordeev@linux.ibm.com>
References: <20261002152055.3305184-1-hca@linux.ibm.com>
 <20261002152055.3305184-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002152055.3305184-2-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RkIfSTtuHVO2tGTH5mTt6xFlrO47eWqC
X-Proofpoint-ORIG-GUID: RkIfSTtuHVO2tGTH5mTt6xFlrO47eWqC
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acde425 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pQxpzdm-b1EoxyHjw28A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzMCBTYWx0ZWRfX3/I2ULnCGFhJ
 2IFt66Jw6fPNFNuTPaMhtYymmfrGXB+Nbn/zUU7Pym6Ta/BvnKRbaWbREjrUbMX6IWWTepxAj85
 4hnzj/Fw/aU2PYMSz0Z7ALdRlLLVHyc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzMCBTYWx0ZWRfX/tJs5zwtjizO
 AfFEMOE7SdwcfEzFnGSG40jgBNXbaMqKj8ol5JE7TZzGy7ma0jLE6zDJq6MR0/tkYbV6/NCFLF2
 6rDSTc/5FpPnoj2ibKoXEpOeKtg1seSL0ndBfSM4HoqzUt4JCAbkXtprf5MWA4l0SEAY29dd5h0
 IvwLG13dLcNeez366A9FCCIJ8xacA2PSjen4N+n6zIQGjI7/UU3gW78D3jqavBGG6q4/KTThR/U
 RaPgRNpe6HFHsTDdoa3RhaeP3h6EiX2Yai/SavNqjOu/Ow36haYZJZgenyoDT+FVii+Y0HKGWtN
 blp0LD7GafkFWQjHNpDmv0HPNRd/TuGehHiQfjjtufBqbogNR7oIUXfyF0humLWZy9vgEPXCndU
 ec9WrCwRP048WbHBlcHSN9Wad0DM4T3TR4iUzuRF4nTE3aFpo2HbI8VaObOT5EDzLxr0YkSSpJ8
 i/V2erSeYfqSnxSm3fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130030

On Fri, Oct 02, 2026 at 05:20:54PM +0200, Heiko Carstens wrote:
> In case an invalid kernel stack is detected the last breaking event
> address is copied to the orig_gpr2 member of the generated pt_regs
> structure. Correct location would be last_break. Fix this.
> 
> This adds help information to the printed messages:
> 
> Before:
> Kernel stack pointer invalid
> ...
> Last Breaking-Event-Address:
>  [<0000000000000000>] 0x0
> 
> After:
> Kernel stack pointer invalid
> ...
> Last Breaking-Event-Address:
>  [<000001b802c1ae1c>] proc_reg_write+0x5c/0xd0
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/entry.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 10dd9bbdf985..4e99ed559dbd 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -622,7 +622,7 @@ SYM_CODE_START(stack_invalid)
>  	stmg	%r8,%r9,__PT_PSW(%r11)
>  	mvc	__PT_R8(64,%r11),0(%r14)
>  	GET_LC	%r2
> -	mvc	__PT_ORIG_GPR2(8,%r11),__LC_PGM_LAST_BREAK(%r2)
> +	mvc	__PT_LAST_BREAK(8,%r11),__LC_PGM_LAST_BREAK(%r2)
>  	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
>  	lgr	%r2,%r11		# pass pointer to pt_regs
>  	jg	kernel_stack_invalid

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
