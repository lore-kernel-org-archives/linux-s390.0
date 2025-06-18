Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F8D27F72D
	for <linux-s390@vger.kernel.org>; Wed, 18 Jun 2025 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239208; cv=none; b=sp+LqzXIxrVkETwlO5LcU9kUti4Tkw1DZYqsgRNJ+MlenLc858D7oXa7CTzZQBgvVxet2PiWGTfgY4WTy13xAieq2UDPh21F4MbLOoJloZV/A2uQo1vNDVzUmTS72rWgVdyylNpyGWUFD/KbiJHnth9s5gLbVcisjHp4r3xiEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239208; c=relaxed/simple;
	bh=fcWUPEJlPdbsuW6rlpNk5ZutJMUF344tA9G1lxnfN6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTsCJTNMa1aF268Vqug4sdrWLrn4AHBx37TwWJATSsBDG4ijDip2j0m5+Nl/wS8919F97MkolBAyweegB0yQZglLoAvpVW/WLCJDOCbRnlHp8K3EysF+8rN2Ub8pi5DKJD+dl7nv4RMEOUjXtPoL/+g7U12asIXAtzAsMJtQyp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eCvBl3oE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eCvBl3oE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I1UYN6014238
	for <linux-s390@vger.kernel.org>; Wed, 18 Jun 2025 09:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=zQIVQi4rVcXeYSr3oSQdKE/U9M3R6i
	yCe0FTT9xhBKA=; b=eCvBl3oExr8HDCZdfw+2HZtiSY5EG19q7riRBsJTuf75cz
	N8/Tx6el5b+Ijvv/pjB6TcWzFXiFpLAI+T6+fKkWDyJC9Wu3pBcMUfDh9+azsGxw
	xrlYeCoVWyDE2S3+1T5CdTNwq+sKPVFPSgGnBBHbyoM1eZRs3U0VaieHQh52cHMG
	GGv9dq50lCupW+r2pDbNz/zt8QDE5EZFEFs4D06ltrGVoTm/hyfXM3oIvDdVYbSv
	OTcJ2HEjROOBnKvfXPzYKNBx48tbcC7xdtPTgVyM7vgAsdLrSTwlkEXsn3xcgiYL
	71SYRnNrwT3JlahpKVsqE/9R09Mkc5Flo3JrIFeA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygndn32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 18 Jun 2025 09:33:25 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55I9XP7i018674;
	Wed, 18 Jun 2025 09:33:25 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygndn30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 09:33:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55I8IOA2025755;
	Wed, 18 Jun 2025 09:33:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 479xy5xbrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 09:33:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55I9XKO227394788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 09:33:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D9CF20043;
	Wed, 18 Jun 2025 09:33:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 302DD20040;
	Wed, 18 Jun 2025 09:33:20 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Jun 2025 09:33:20 +0000 (GMT)
Date: Wed, 18 Jun 2025 11:33:17 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        S390 ML <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] s390/boot: use the full title of the manual for facility
 bits
Message-ID: <20250618093317.7535E78-hca@linux.ibm.com>
References: <20250616163248.77951-1-xose.vazquez@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616163248.77951-1-xose.vazquez@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA4MCBTYWx0ZWRfX5FM4BrqzWl0/ Y6SiqiJuMj6qJ2ZI7FwPd6jnaSksLR5JNev3t9z2YLFyv/obyhhina24xdaqwl1kAOTz8vfQz+Z BE8j2e0ozK2SzEk5/Pea6OFhHazohNG6JEFKfUj4tngJ4kP9v9oz69BakEBdD5RWP4bu+3rPNcs
 awjDzYRJBw3Fm07YI3JvVPHS+KRinbcVNlLyTiHsLi0JLHHSd68epnzMTWSvtMyphUMrRY3kqxa 7xbz7bsNh4pRVOuiBh1MjynIQwYD/yab0xGYWl4/de2W4Gcgi5i576JLW5GcSRoZzBBvS08bYZT rG8Il1x7y0u2x6oqdntV/qkyyiA9sw9glyD7Ea3BU+ywFIfKXwF2eTprMNfScoj7/0mHF9JZlVn
 1OD8GZ086eEGT+gwOfZGxbPS00H2qiZucUDdTdimvY3Lm2HxmhA91kjPxvY1y+x0qmOhVXHm
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=685287e5 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7wVFnhiujdsryNmK0soA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: TyCtuH8F3I-YcEpOOCcRTBUBpwjH3QRv
X-Proofpoint-GUID: WVwyEUleByml3r78cxRO5Mb-8PwOD0zO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_03,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=588 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180080

On Mon, Jun 16, 2025 at 06:32:47PM +0200, Xose Vazquez Perez wrote:
> Also indicate the name of the section where they are listed, because it has a
> length of 2124 pages:
> z/Architecture Principles of Operation - Facility Indications
> 
> The current version is: Fourteenth Edition (May, 2022) SA22-7832-13
> 
> Cc: Heiko Carstens <hca@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:3/4=75%,authored:2/4=50%,added_lines:8/14=57%,removed_lines:41/47=87%)
> Cc: Vasily Gorbik <gor@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/4=25%,authored:1/4=25%,added_lines:5/14=36%,removed_lines:5/47=11%)
> Cc: Alexander Gordeev <agordeev@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/4=25%)
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com> (reviewer:S390 ARCHITECTURE)
> Cc: Sven Schnelle <svens@linux.ibm.com> (reviewer:S390 ARCHITECTURE,commit_signer:2/4=50%)
> Cc: S390 ML <linux-s390@vger.kernel.org> (open list:S390 ARCHITECTURE)
> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
> ---
>  arch/s390/boot/als.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/als.c b/arch/s390/boot/als.c
> index 79afb5fa7f1f..7d4cec1975c6 100644
> --- a/arch/s390/boot/als.c
> +++ b/arch/s390/boot/als.c
> @@ -65,7 +65,7 @@ static void facility_mismatch(void)
>  	boot_emerg("The Linux kernel requires more recent processor hardware\n");
>  	boot_emerg("Detected machine-type number: %4x\n", id.machine);
>  	print_missing_facilities();
> -	boot_emerg("See Principles of Operations for facility bits\n");
> +	boot_emerg("For facility bits, see: z/Architecture Principles of Operation - Facility Indications\n");

Fine with me, but please let's shorten this to:

	boot_emerg("See z/Architecture Principles of Operation - Facility Indications\n");

No need to resend, I guess Alexander can change this if he agrees.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
