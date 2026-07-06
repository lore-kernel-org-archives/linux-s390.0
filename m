Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5A280A58;
	Mon,  6 Jul 2026 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351354; cv=none; b=A6KLMaB9jAWfVlZxxczbJr5aF+YDgqM3sVCKQL+u1Mn/lILUAAr2vSRJ9sWdKRFjnZ1/ZTtDqppsdedk72ZxmA93FSZGR33f2zAGGtKh+CPIojrP4Rv2kR5oIqgKBfBs0EgBf1m1/yYpUFZlr9l/XQkKQkoptlvMtTUuiRRU/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351354; c=relaxed/simple;
	bh=bIHEWvkTAGHbnRQB3xwn9gbj8HXRzSKU999umtrl5jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCss/1V9ZzWXVegg+Ueo6a1CbM433usKc/cTUhmoM1LyUi62j+GOx3PKvg+FBV7HN5R9/DkJQgY+9bLjo/4WESZ7J4KjdgTXMOeAq8n4OAFFycNPIS3OlwMrHIV1immFOaPtThLiecGLxPmchsvTEPPjL7NAuUzLGFTgmoK1/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KeqI6gVF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KeqI6gVF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIELx611282;
	Mon, 6 Jul 2026 15:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gdXJRU
	MSWqKmRZrf7St4GnL/l8gGuJVrf6ZNJQEoBM4=; b=KeqI6gVFcYgZqUHuuAcSMe
	SPq0kZ7lmpFLubajYqs8gVI72H7jXVGqTX20l5705sMX3nLFDUcWw9c900aqLsrv
	hZ33SmEzdq+5tXe83GnYHqoVacpgxvCKM1VKiOfXR3CoW2pH96R8ZknfmMutCyCL
	7BPAAMgvULWs6oV+HxZYKfDFiINWdSMcMjIeAsRFfNEQByRt0WDkXPyaylDKndR/
	FqPKEzSjG+dTIh7C1JCq9dwbZlV+Mg13mOIqXEkcl/dxMhjzocBYAA2tJhAkgWUw
	Abw0kIGppPFpBuoeDqps7xZWdUN7DpTZOFr4MTQBH5eIR9SAkxu8lpYOOvXiXVCw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3j542-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 15:22:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666FK12E012176;
	Mon, 6 Jul 2026 15:22:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h61a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 15:22:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666FMQ2j43778496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 15:22:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD69F20049;
	Mon,  6 Jul 2026 15:22:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 268EF20040;
	Mon,  6 Jul 2026 15:22:26 +0000 (GMT)
Received: from [9.111.136.146] (unknown [9.111.136.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 15:22:26 +0000 (GMT)
Message-ID: <7eb0eba2-3159-464a-9374-a31efa1ddbed@linux.ibm.com>
Date: Mon, 6 Jul 2026 17:22:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390/vdso: Pass --eh-frame-hdr to the linker
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260706151909.103539-1-jremus@linux.ibm.com>
 <20260706151909.103539-2-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260706151909.103539-2-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4bc838 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=7scW1GgyRHmQmRYzcv4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1NiBTYWx0ZWRfX/QLzw3vCpTPC
 /3yQEE8zYXToXjKq4LB1ONNt5+z2i+jZgiVrnM+PKElUYkhoJJ/EfXAWwXGCLilCmso58ol2IPZ
 Vq4yCoamou9T+OjeYuCRzrDrA1WVGIU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1NiBTYWx0ZWRfX0ovii//dJyTs
 kYCRszfSaH70dkLfu8clf+5JKxCw6Nx0ohNl8HZvtql1dfU1yd4OjfJqUdghA37sMDH6tRDDrQR
 hrHkXS/j4XgGoOm5rYUK1RCPlqhzVCFb4s0JHXt4y0hJMZE1R5wTrkl4+wfi67PmGJ3hb382IXG
 ygEJxsqINsrrF2E23SaSsNzeNUjunVA9W0eZS82Q3HoFerhP5MEb8QoBGhE8zmxFeXGBIN1PqiY
 Zwo8g5+aH9NjrsogTWTiZBVtvQumjg5xw2ppD7WjgtRgIMauAdhWiNrC+R+f4MFf6nwPz1g7yll
 d4lcRA4v2EKf+1j4GMBHR7cHvi0SmxqEhkVSI9HJoIOpTI5gToCuloLH3j0MX7s+zpAGH447hsR
 FTJjICdokWqrtHZGkP5EQadS03CzTD/kG+Ja+oPFliQH9icNN7QWdSkRytw+AvXHyIrxQ4TbKbG
 tLcwtkUbr9KgN+w+j/A==
X-Proofpoint-ORIG-GUID: Fzv94rV_X7xlo98nLfD6qgJR6x5B5qh_
X-Proofpoint-GUID: Fzv94rV_X7xlo98nLfD6qgJR6x5B5qh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060156

On 7/6/2026 5:19 PM, Jens Remus wrote:
> Commit 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link
> vDSO") accidentally broke the GNU_PTR_EH_FRAME program table entry in

s/GNU_PTR_EH_FRAME/GNU_EH_FRAME/ 

> the vDSO, causing it to be empty:
> 
>   $ readelf --program-headers arch/s390/kernel/vdso/vdso.so
>   ...
>   Program Headers:
>     Type           Offset             VirtAddr           PhysAddr
>                    FileSiz            MemSiz              Flags  Align
>   ...
>     GNU_EH_FRAME   0x0000000000000000 0x0000000000000000 0x0000000000000000
>                    0x0000000000000000 0x0000000000000000         0x8
>   ...
> 
> Originally, the compiler would implicitly add --eh-frame-hdr when
> invoking the linker, but when this Makefile was converted from invoking
> the linker via the compiler, to invoking it directly, the option was
> missed.
> 
> This is the s390 variant of x86 commit cd01544a268a ("x86/vdso: Pass
> --eh-frame-hdr to the linker").
> 
> Fixes: 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link vDSO")
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

