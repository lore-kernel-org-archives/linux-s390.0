Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728031195C;
	Wed, 15 Jul 2026 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124010; cv=none; b=RLquU5ub3umpuNvSyUm0+9GamGwq3JoSx7X0Q7mC8AphApa9sgrWhbi4+zznrljClcs89WYvu3w1ZPUME2/KO9Dj1Rb46gfDZOIYk1v24NyHE6eFM2KDIwdU25LNxmPfI9GdyJKZceJVaFTHhnaH+r8k2prG5CuQJC8fN4wMS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124010; c=relaxed/simple;
	bh=YTf+ihIVxMqoNlpusGCMofMbUwzbMgPcKGoZRbFxNus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pz2xkmhSrb0nUDnOQwQlZ7IAg9Rsj8eoSfYAcWsHJ0223YsPY/K6el7+h/xcw4vdv4G7q+p8FmX0EDmWDZnrEE7Of08dRusPfmK5GiY4coccXrmYiDuHylHx1Y4J2Ni/+OwZ0OGu1wWUAX4iBxTJr1emYxQ8RgscmNB6vNR9sCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jHJOujG/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jHJOujG/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBfl954178915;
	Wed, 15 Jul 2026 13:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aB2cMqasFtckoreg6/T566aCNUep8f
	6PRe89NRkW01c=; b=jHJOujG/4bxqGREkUmwgmyBmR/mYPU2xFU6uDjmvW+hc9b
	cj/YL4uFHe4Hq3wF1TLhw+NE1Au1bHwPkeDG8UpMxTXtCjVdx6vU8pVc8K3Y1IlC
	40Gdf+Qgf+Z3TVTo4D31GxhxdLOOtbc4VGHddigpT8R/nyUJ23LJWypxcxwL8g91
	Onuc8glMxvoCAuW9MqyRRQwMYylu8G/IjnpsuZNTHUGVq9+R2PAlN+V7bThRvaVJ
	F/2kUoUU4wUigvSAj1UE48NTSroW58EpyEZn/0+rs566xmk8+IN92ZosYkiBD/y+
	WsZGcY1GVU4CUBMGVrIo4UrhF9FJBdJJ2Bosoqtg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwu84k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:59:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FDnhUO010852;
	Wed, 15 Jul 2026 13:59:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05q8hcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:59:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FDxpg631392258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 13:59:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76DA72004B;
	Wed, 15 Jul 2026 13:59:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B46E20040;
	Wed, 15 Jul 2026 13:59:51 +0000 (GMT)
Received: from osiris (unknown [9.111.23.166])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jul 2026 13:59:51 +0000 (GMT)
Date: Wed, 15 Jul 2026 15:59:49 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/syscall: Keep syscall number in extra ptregs
 member
Message-ID: <20260715135949.100936A27-hca@linux.ibm.com>
References: <20260715133830.2619853-1-svens@linux.ibm.com>
 <20260715133830.2619853-3-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715133830.2619853-3-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fu1yMJQ3oj1kYkAvgwpFKwb8xW-VvRAj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzNiBTYWx0ZWRfX0jUZdD4LLUra
 Ub6ia0uaNwuycrhh85tpqZJFyyefccfiXUCycgLI3i72bNkcUW8WBpsGhecoBlkHVYghtK/xUE8
 PQDeG/ZLXd32ejDQws2HfXyirOIGqXPQm5PA3PSzgaMZ8XZ+RXeh5BAU2XP9z2vT9LfSAJHqUWD
 k0s8jRqzNHIYfkvNJjXz06JTqs/GPT20PVKhFWe2R6engbQEDczdf3iTrPVlTnBovetJg04FJtj
 rATJGA5sWt/TkKsPEU7z7qCN4yBRprUSJA+paaLEfFLFfwwxaZOXErqE9m3XCVbb1sFmJueVfRu
 eYkPY8kqfci1Qmmg5GiP8Aj6+Lecr3CA03M8mwOV8PjViZ7/YAK27HmW+4HEC0ADcAw5lZjlDlR
 UU6SziAbnCuGVkWGJDuGgisx+/ufWUqk/zRjG+cM+gHhvH1x3iB6ENnloA8Y2BGArhAki5YsWt2
 JnHvQ1Z+goGZn1at1PA==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a57925c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=stEBtn2pn6onousJgE0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: fu1yMJQ3oj1kYkAvgwpFKwb8xW-VvRAj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzNiBTYWx0ZWRfX8JWFdz/WzCLK
 xTNbIESxlCFU8m2LMLo+X8trxReJmi5oYhthiqwH1rIYCnvtmBihtP5Nu4FOgyRlBmacWCjsxDi
 zutHEZeXZtY0eImFTfcQ6CaFjndQph0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150136

On Wed, Jul 15, 2026 at 03:38:30PM +0200, Sven Schnelle wrote:
> Move the syscall number from ptregs::int_code to another union member
> called syscall_nr. This simplifies the code a bit.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  arch/s390/include/asm/ptrace.h  |  2 +-
>  arch/s390/include/asm/syscall.h |  8 +++++---
>  arch/s390/kernel/ptrace.c       |  2 +-
>  arch/s390/kernel/signal.c       | 12 +++++-------
>  arch/s390/kernel/syscall.c      | 11 ++++-------
>  5 files changed, 16 insertions(+), 19 deletions(-)

...

> diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
> index 125ca4c4e30c..00e825d01504 100644
> --- a/arch/s390/kernel/ptrace.c
> +++ b/arch/s390/kernel/ptrace.c
> @@ -349,7 +349,7 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
>  			addr == offsetof(struct user, regs.gprs[2])) {
>  			struct pt_regs *regs = task_pt_regs(child);
>  
> -			regs->int_code = 0x20000 | (data & 0xffff);
> +			regs->syscall_nr = data;

This breaks peek_user(). So handling for that needs to be added too.

> -				regs->psw.addr =
> -					__rewind_psw(regs->psw,
> -						     regs->int_code >> 16);
> +				regs->psw.addr = __rewind_psw(regs->psw, SVC_LEN);

Why? This is unrelated to what you want to achieve, and it is broken
if the svc instruction is executed via exrl. Plus, let's not use
hardcoded instruction lengths if the CPU provides you the correct
length anyway.

Besides that it _seems_ to be ok. :)
