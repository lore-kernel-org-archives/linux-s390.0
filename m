Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC97388878;
	Thu,  6 Aug 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027071; cv=none; b=dsloMEAymgWi6cotlhG3fgpWq02BDZ6ZmMm+sd7MzfTPjCh4PNLPKP+7CGrMU0JJIivmhfbJ4GqginfKlnJAmTKtxr5NHHSHenjeirm/8t6gK5mJ+gzGpeh8MaaVO6zZAUHe3ACfDIdsVZc/DLwb/0M6KOdvGO3OkyGlsLLu6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027071; c=relaxed/simple;
	bh=q9N0fwcAQUKilrQfG9yZAO+7O21xUnkl3tIe9ONINOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gph07G8olUpS4ggto4m5xKnmanRho1rXZjcy9gp83Xa6D2Z+KuUI4wegVwmv//sA0+R9XXv30FgpQJa9K7LsQCOB+v9gE1dw4INfYxJkSYYFQs/7yaxg0sLURm3xEeqbZ2s3mDgR3G4VhXuT19xKJH0TC3aJ35cRm5DdHHmd2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E91OVHIY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E91OVHIY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676DbTHa3403153;
	Thu, 6 Aug 2026 14:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iEsUms
	7+wr3Hd64+3XgamYoLENqFPttzvbH00bGL6lU=; b=E91OVHIYUDetIiZ0ZHjzEi
	bVG7o4TFecIf5ZC0nfTbAuG2xJHdtSQdZQXI4zO/7Ezjsq5w/VaG1b3ZYh2zR/ed
	hmolTydqFxenofRcmz/5McwrI5+dyqJo1gwGf+LsosD5k3JZsPLOg8eU8uWiRQ1d
	kNZdaek9C052+AB+YHapmNL505gD07txitlspCmzTGMlyo/zUrF4WfWMFkLiuhSB
	7HHQ0efQv1Jzj50NGcY8g+huFblNnknkTZYZvIhLzSO+uNWfH1oqba3WikXMwlH2
	1KSzj51QfeDxWDyjZKF8oYF9TSSHYXP+a4mm8ZMWVUMbUHA9EKAv8xQAL0kyqfyg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fr0ny4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:37:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676EQL8d010714;
	Thu, 6 Aug 2026 14:37:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qupnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:37:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676Ebh2P37159256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 14:37:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29B572004E;
	Thu,  6 Aug 2026 14:37:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FD6520043;
	Thu,  6 Aug 2026 14:37:42 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.53.22])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  6 Aug 2026 14:37:42 +0000 (GMT)
Date: Thu, 6 Aug 2026 16:37:39 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, KVM <kvm@vger.kernel.org>,
        David
 Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>
Subject: Re: [PATCH 1/1] KVM: s390: Fix memory corruption by not reinjecting
 CK machine checks
Message-ID: <20260806163739.7b1ee8fd@p-imbrenda>
In-Reply-To: <20260806125241.210170-2-borntraeger@linux.ibm.com>
References: <20260806125241.210170-1-borntraeger@linux.ibm.com>
	<20260806125241.210170-2-borntraeger@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3NkEF6gNitnVzz6GOHETFJILwOZxDG7o
X-Proofpoint-ORIG-GUID: 3NkEF6gNitnVzz6GOHETFJILwOZxDG7o
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExMiBTYWx0ZWRfX2P0fncNfwljL
 /3LAYjshJSZqCix9BT+RreStBLCD8H8ud59qK2UeL1w5xSCYMcddX4gn3lPXF6Q5JiVDi1Cn+na
 XoNQvT0EAtj0bhbHjYPNKpPAGkGkC70=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a749c3b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=WOMeMtZcLbvEFOhP14wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExMiBTYWx0ZWRfX+AWC4EWvfQX6
 0SmXA2yxGGMR+7LK+9wtwG3C/REa6+aXQ1dLB0jGPljzjLgvdJhGIYfoC1zOUFj57+tFoQozd5l
 r6k1JkIow4DCOGKJpV6GTD0oqI7cuT82E82YqAQ7Yk+zucLDD+bY41Dpzbl2oem2NJJneEwkZpK
 6edNdIw7Ry+mkBkvZZ2/BqNNopOU1nYHWV+KRfZiYaFvKOLsvuXFFjBJTuVXb6/e7irgIee8Z5Q
 7xlz/9BHkmETucLqyyLn1qBZFSGBQQgJyBZ2kV7FHCFmst40vJ9wPWsF/TpwlPvyKbJj89/W5kd
 cHcF/TSo1+R+fLG+AWnBs/W4/Mzbg7kEVhHeytJkZG0f2bZ0QIvPATgjUKzOyIpiRrcYEssHC97
 er7vK61Si2kXindkuGhGsAThvKBXU62UQHJ+fqJ49Ee8DwEBi44pYzZPhvxRH18ttVYuFosPVlc
 +2r21xg9n3Daoevi7UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060112

On Thu,  6 Aug 2026 14:52:41 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Channel-subsystem damage machine checks are for the host channel
> subsystem. The guest channel subsystem is emulated in the userspace VMM.
> There is no point in forwarding such machine checks into the guest.
> 
> This also simplifies the machine check reinjection and avoids kfree of a
> stack variable as reported by sashiko.  There might be still machine
> checks that have the ck bit set with another bit (like instruction
> damage), mask out the CK bit in s390_backup_mcck_info(), like the CP and
> ED bits already are.
> 
> Fixes: 4d62fcc0b692 ("KVM: s390: Inject machine check into the guest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  arch/s390/include/asm/nmi.h |  1 +
>  arch/s390/kernel/nmi.c      |  4 ++--
>  arch/s390/kvm/interrupt.c   | 24 ++++++++----------------
>  3 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
> index 6454c1531854..dd26c20bd231 100644
> --- a/arch/s390/include/asm/nmi.h
> +++ b/arch/s390/include/asm/nmi.h
> @@ -22,6 +22,7 @@
>  #define MCCK_CODE_SYSTEM_DAMAGE		BIT(63)
>  #define MCCK_CODE_EXT_DAMAGE		BIT(63 - 5)
>  #define MCCK_CODE_CP			BIT(63 - 9)
> +#define MCCK_CODE_CK			BIT(63 - 11)
>  #define MCCK_CODE_STG_ERROR		BIT(63 - 16)
>  #define MCCK_CODE_STG_KEY_ERROR		BIT(63 - 18)
>  #define MCCK_CODE_STG_DEGRAD		BIT(63 - 19)
> diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
> index e17a59d4d5a4..652b98795243 100644
> --- a/arch/s390/kernel/nmi.c
> +++ b/arch/s390/kernel/nmi.c
> @@ -345,7 +345,7 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
>  	sie_page = container_of(sie_block, struct sie_page, sie_block);
>  	mcck_backup = &sie_page->mcck_info;
>  	mcck_backup->mcic = get_lowcore()->mcck_interruption_code &
> -				~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE);
> +			~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE | MCCK_CODE_CK);

... here, instead of duplicating it?

>  	mcck_backup->ext_damage_code = get_lowcore()->external_damage_code;
>  	mcck_backup->failing_storage_address = get_lowcore()->failing_storage_address;
>  }
> @@ -357,7 +357,7 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
>  #define ED_STP_ISLAND	6	/* External damage STP island check */
>  #define ED_STP_SYNC	7	/* External damage STP sync check */
>  
> -#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE)
> +#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE | MCCK_CODE_CK)

it looks like this macro here should have been used above... ^

>  
>  /*
>   * machine check handler.

[...]
