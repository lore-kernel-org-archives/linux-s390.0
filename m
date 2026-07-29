Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847839A801;
	Wed, 29 Jul 2026 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326799; cv=none; b=DQGEfwOJZFvw4Dv5ejxjXszetBRBMfV4er2EF8GYRQyVJOz25rta+mSmDYmMF6wSiKso3pN8pD/u4FwY8uikxW0mPsqSNQ9zOaMT54Wz/xmShlltb0RNU+drQ5v/WnIod5o9YH2E+oH7OyqniXY6qiHGURJc1D64DEIDUp+Jlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326799; c=relaxed/simple;
	bh=HpgVurU+nylyA3Rgdw4bdJ2tZ2UuFI+0eC99fnLkWN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNpo1HpOGJcgFtp1sFCMp+9+pVDKzSCNhDUi0FJAeuJcTENwWGv9BfqgSD3dKDs96azl+843zOiApT5o9HBMJn+mciCnQQAJY4sGbPb1XZH96iYuaFZ/sR0r6Jm+X+zGwHqoC/7dZob3pHf45URhhFDbWVN1TM2CmipWEQPKNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CzLssd4f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CzLssd4f"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHj3R2164119;
	Wed, 29 Jul 2026 12:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KroCLLo6Ir++REJUNiBYab0SLZkFv/
	69xZeQbT2Mut8=; b=CzLssd4fIG5RpWCMg0J/IUxW6gnkZ41EHPf22AjOar+7bf
	PPACUCo/19TTJGRgQrnAifYZox8cF2jyRxXn/4WfXti66Vo9Y5FudRXg9ToAao+R
	o8NUgaU71fSevSF3Im+559N/wUmAJpk3BDxoWcy6zS5ckH5n5Lx9tChcafRLjs5b
	iDBT/sgTvyrBkEB0r5cA5JPjifqDDm0q3q90yPGVg9Q5rbnK0fAmlFWNdhTuiB7p
	ouUjBlAVpBazvOe/8cJ7DUGvirUNi4vlA6QEsQIf5qbIErdgLzH85EyQLyJH/7Dq
	zUJHoviB7w4z34VPMAag0PmYVPk/xmP1rA3Mvf/w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycjep6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:06:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBuGmm007188;
	Wed, 29 Jul 2026 12:06:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y69tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:06:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TC6QK833882546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:06:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A5FA20043;
	Wed, 29 Jul 2026 12:06:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2432E20040;
	Wed, 29 Jul 2026 12:06:26 +0000 (GMT)
Received: from osiris (unknown [9.111.35.133])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 12:06:26 +0000 (GMT)
Date: Wed, 29 Jul 2026 14:06:24 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Introduce arch_do_panic
Message-ID: <20260729120624.61563A64-hca@linux.ibm.com>
References: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
 <20260729085655.17504C1f-hca@linux.ibm.com>
 <6213badb-436d-4e2f-a537-7171bde074f3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6213badb-436d-4e2f-a537-7171bde074f3@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9-dc5MnsXb1TiB3foJxLeMpIPuPhTF9H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5NyBTYWx0ZWRfX0LJeJ9ONtSXp
 tmaDqR/TWzMVw2mLoY9F7/MP84GMiPc/p0HNpXEz9bmn5bjWyizeaiBxwrnr92TeyFVqf7z3CcS
 PuvKvLQLNeP4+sQAbUKDGon+HVwYocWGi29VgNzytg2agUeF0GVVxpYY9TwsvFapZxMlrN5iuck
 Szgd8VjWMsGdxlXbv6jsmEslfrF5tvURRGC/UOetsreKMC9HblFFWbsXlml80Yiz0EdY9XpEJ52
 uaOkibYY/BHz57qeUrC1t2WnkjaSYqElH7DyjKnjl0TksnOE9zMpoIofN/Ln4ghuMX5m7ScKhA1
 RXTjQip9dRLGZ/Bvbk96ck24dGltLvt3DWvG4ZSNv6OgkkFEygYC9xSgZHhczYKyEQw0M2cMnTX
 zcc4nZzJr9lH/fzwXkMZG04H5VsJIlFeO0fSQJaCITa/+a11b7p30oa7OINrS/oxYSPZY4YBUBx
 iGtsRoQltpTpXUCv13A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5NyBTYWx0ZWRfX42m5fhgSt+rw
 RKMiPRxyCbzfC1zDAcSIFi0jaTui8tVIuYiLuiSgVIIqV8/L/JlUPYgvGP2dSeRD5cFG5grPhNB
 c23epMgld7AwYFPehtcwUNfiiBl8NNE=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a69ecc7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=rtqY0JO_Aqn_8INGn9MA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 9-dc5MnsXb1TiB3foJxLeMpIPuPhTF9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290097

On Wed, Jul 29, 2026 at 12:48:49PM +0200, Mete Durlu wrote:
> On 29/07/2026 10:56, Heiko Carstens wrote:
> > On Mon, Jul 27, 2026 at 12:36:19PM +0200, Mete Durlu wrote:
> > Putting the define in a different header file per architecture doesn't
> > seem to be a good idea. There is no guarantee that this will work. So
> > either you find a common header file, where it is known that is (and
> > will be) included in panic.c, or you go with a weak function.
> 
> I went over the headers included to panic.c, either they are really
> irrelevant or not present on other archs. To me the best candidate
> header seems like "asm/bug.h"
> 
> $ find ./arch/ -name "bug.h" | grep include/asm | wc -l
> 16
> 
> $ ls ./arch | wc -l
> 22 # actually 21 as we shouldn't count Kconfig file
> 
> The architectures missing bug.h in their include/asm/ directory are
> hexagon, microblaze, nios2, um and xtensa
> 
> I believe 16/21 is a good ratio but if this is still not good
> enough, I'd like to fallback to __weak implementation.
> 
> What do you think Heiko?

Then go for __weak and wait if people shout at you :)
