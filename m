Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A5275864;
	Tue,  9 Dec 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765291336; cv=none; b=tfWUBMhtTzI0fibu4dnouflz7CIe1W4aSkk5PnZT3KPLnhoufGvbc7qhe1gCIRE9FlzZ5dzExjH7g1HSoUIPiTVs5Kh2YScGGSIPtYI0/hhom63VYawKJY3D7RfpVraIIkHzB2aGRvlIV/f2ksKu8MRfx2dxdz79tMKKbAEuv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765291336; c=relaxed/simple;
	bh=3tpmDb3z1zLFkuI2f/6vQUz453SmuBDQx53AkKGK+OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZMVJfkTDsaw9inAbPcjdkGa4cEd04DAUdIceJT8wN+NW6yMvYqxTjeH1N/35VJWahuonimuOL8OhamHaE67OTuOE7G7Xfjw4lPe3n5g8kKijlBEWdd4vhzjL+NhECs8HG/sqp+Sf7wDJirtjrwpzaLjXrVzKjv7khnCynzAQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qrvhIzEZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qrvhIzEZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9AgG71016858;
	Tue, 9 Dec 2025 14:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ULh2eoR8GTvStCHRY+Oa+y5ogDftLx
	PO6TQM5ytS18E=; b=qrvhIzEZL+5/ptYPjkMsZZpkVrxpjHesWk2FyB/EqkiSQX
	S49KRncAHFvx9WDDPg6QBZ5AMFpOW6Y4XIbSDeHTl7eCf3e8jjLE6MUGAcDBmYXD
	B6PnGglBHQA8/Sd5Q/dksvoovYF72Mc3q6SkOLQoFjNwKR9LwBVRSCoHQ308NCyf
	BZ81vMB0vBcwvPlyHnOt0Cpqlt9JaoQ7SoadYAS0PCg77Ax/B8rYc7hdZq0a1Ojl
	6GNLefRyrc1cN2YJUNrcxwhHdhmBAwh1Uv+TVOI+w3AecYdeAaEDverwD6Bjh2l4
	VMcYHe3cjMIFUYpKw3mkwor0gOS5+CIkAHBdXJrw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvn1u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 14:42:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9BcjTn008472;
	Tue, 9 Dec 2025 14:42:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytmucyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 14:42:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9Eg2R658130864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 14:42:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F7CE20040;
	Tue,  9 Dec 2025 14:42:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E2BB20043;
	Tue,  9 Dec 2025 14:42:02 +0000 (GMT)
Received: from osiris (unknown [9.87.133.248])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Dec 2025 14:42:02 +0000 (GMT)
Date: Tue, 9 Dec 2025 15:42:00 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jens Remus <jremus@linux.ibm.com>,
        Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 6/9] s390/bug: Implement __WARN_printf()
Message-ID: <20251209144200.15189D45-hca@linux.ibm.com>
References: <20251209121701.1856271-1-hca@linux.ibm.com>
 <20251209121701.1856271-7-hca@linux.ibm.com>
 <20251209123540.GE3707837@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209123540.GE3707837@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dl6sGS1vblE9xbklErm9IWii7ugkcO19
X-Proofpoint-ORIG-GUID: Dl6sGS1vblE9xbklErm9IWii7ugkcO19
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6938353f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HNeoXCU7dB-zGeRosEQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfXyT3QMJZyWebP
 gokl+aPCEYmpR7XKolEBMyQb6Gjb/CZIk7I4bww39q8si53Dl++S/0lAHfbiIH+ItPFX0rsH1to
 IO4mBwi/hNSyICZoEP8jO14yhQeJxRYSInlpoB2or3jzN4qQq6Sg+H4BYhclRwU+lc5Ci1vhtU6
 Tbq5W4rZ8aCrdPFusGEgAZMwIjIj9rTVxkB5jjGT9tD5A9pdRrVI9HOTfE1/VpgQDhHyXpE/FhB
 frSeJ3NsinYXik/5l5CZgSQfj/2mbfEk/g49qu96zlGc9T4Tcs2dHndl3957YpE+dKrR9SLQddl
 XlVJP01bWf/EiPWDOGiZd7b0WsvE5hPW0IJb0HqnWfEk3bZwmqVXO2wIT/8W3iyDr0Blwc7ivNR
 Eu4+SSf44B8eKF0MxWf5HH7za3A5Wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

On Tue, Dec 09, 2025 at 01:35:40PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 09, 2025 at 01:16:58PM +0100, Heiko Carstens wrote:
> > +#define __WARN_print_arg(flags, format, arg...)				\
> > +do {									\
> > +	int __flags = (flags) | BUGFLAG_WARNING | BUGFLAG_ARGS;		\
> > +									\
> > +	__WARN_trap(__WARN_bug_entry(__flags, format), ## arg);		\
> > +} while (0)
> 
> So on x86 I had to add:
> 
> 	asm("");
> 
> after the __WARN_trap() call above, to inhibit tail call optimization,
> because:
> 
> > +void *__warn_args(struct arch_va_list *args, struct pt_regs *regs)
> > +{
> > +	struct stack_frame *stack_frame;
...
> > +	stack_frame = (struct stack_frame *)regs->gprs[15];
> > +	args->__overflow_arg_area = stack_frame + 1;
> > +	args->__reg_save_area = regs->gprs;
> > +	args->__gpr = 1;
> > +	return args;
> > +}
> 
> that would affect the stack layout here. You don't suffer this because
> you have a link register like setup?

Yes, in case of tail call optimization everything which needs to be known to
setup va_list is passed in registers. __overflow_arg_area will then point to
garbage, but it doesn't matter since it is unused for such cases.
