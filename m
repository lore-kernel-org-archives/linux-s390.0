Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751922727EB;
	Tue, 11 Nov 2025 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861018; cv=none; b=QD5xy7GZXbtozUAQ1lCMR3TXqk2iapsbxAYjPfLiiTFDZ1Xa6+z4p8gP8RQK2OP90cjDzup9+APKcThOOGt3eqNDboamMGEfTnq3iG12lfU8WiiVQXPRW45HVnfoYFtZUL71Xn7gsonsqzUUgxujsb6S6QJ/xKK2XqdTSu2d1Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861018; c=relaxed/simple;
	bh=TfwNf40Qp5261OrhcSCO5Jo/DPB7mnjqgGQv1AEa2Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzlL5YZTT0RiTiNpMpsCUeayS6RgbxwG16lNmplCF/8tkwW+tKwkpi6/4bP9iU2SOELeHZwBD/8rKfN7uK2izWuZms8xMgQD6dbtq6inffR2nNaYKVhKpahlZoTcEXuMyupXDwLpKHRgeffLwMC6fHqzr5VRFUb+/n4zPqTOn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TzpTy6jB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TzpTy6jB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAJsmOj000443;
	Tue, 11 Nov 2025 11:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hkBvzTnghUoWkp4e1DpwhJbchVkbme
	soLgUC43qriTw=; b=TzpTy6jBo1LMzNvsyh7O2tzH5JzhSu6svzv8wySYDkl+Yp
	prc/RZIbk032WIuDBPCQsFVM/0D5bxbFpvUp3/pjbvkkeBHI8enTi/dunqGRoIn6
	uGhLdARO3ZeOwHSs+wLP6MUXmqsqgMbHgVuwgwsFXws6lc1m5/laxKsMPdy7z02Q
	J3fEjkkK44BH/nXc7UnEMdc3MmK+zREE4AMcy8wa+oOPZknBeUuIfCqkGz9j4q+m
	VAqQJGvLPQ2SRT0Lat3App6jjk0AsKjPfRC3EsrPqUq4hEJeCzujZRnvJC4My+hv
	XdnpwUlk3NdMgz7zv4xkv7fYiAEG7/VlrH+giLtA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m82vrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 11:36:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB9lWB8008218;
	Tue, 11 Nov 2025 11:36:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6mth0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 11:36:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ABBamI844237258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 11:36:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A19A220040;
	Tue, 11 Nov 2025 11:36:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A9C720043;
	Tue, 11 Nov 2025 11:36:48 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Nov 2025 11:36:48 +0000 (GMT)
Date: Tue, 11 Nov 2025 12:36:47 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 8/8] s390/syscalls: Switch to generic system call
 table generation
Message-ID: <20251111113647.8887B5c-hca@linux.ibm.com>
References: <20251110185440.2667511-1-hca@linux.ibm.com>
 <20251110185440.2667511-9-hca@linux.ibm.com>
 <f4531526-e981-4160-8369-50a8c8d86e36@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4531526-e981-4160-8369-50a8c8d86e36@app.fastmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=69131fd5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=IQB1duFbABfeMsQy1igA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: f59y20Bzo-ZyZPDnQRgM3t41yNdplSma
X-Proofpoint-ORIG-GUID: f59y20Bzo-ZyZPDnQRgM3t41yNdplSma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX17O53H9BQF6R
 try/qZbnJMkK3b/VDSVfoffnZCGKBdwoyQu8BZvPIRtxDD+5GG+DZfxhXtNDlg8Agh5YVh25OOK
 A0SIsDKbemPFt6JwPLyvqqYJYi0binR6ty33R8Rp7UtqQpb8ZZhWDEravQ3+Q56kti+3EiQF2u3
 3t8pju+3XpjtMKrlYzJuNN19iS75LRjdGlwlph9M5rl2Z7yUgHGm2p8AZ15pd2Odn8428rC4wnD
 LppQaM2wF3mOnogmPRkVY9JeTaIkqGZ0T0Uy9ik3r3L4yzvUfEwM5sS41qXX9iedpxMzp8/miZS
 Wb5sj7l/bWT2tt8PyXyxA4TMLy9QzjqDbpRShxricrFnjurwmERIAFJFqQwzjvbH9q1rUG6bcgu
 ofHCJ/uIbja0zJ4GCximwPeOeqy5RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

On Mon, Nov 10, 2025 at 09:51:53PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 10, 2025, at 19:54, Heiko Carstens wrote:
> > +161	common	sched_rr_get_interval		sys_sched_rr_get_interval
> > +162	common	nanosleep			sys_nanosleep
> > +163	common	mremap				sys_mremap
> > +167	common	query_module
> > +168	common	poll				sys_poll
> > +169	common	nfsservctl
> > +172	common	prctl				sys_prctl
> 
> Nothing wrong with your patch, but while reading through this, I noticed
> that we are somewhat inconsistent about syscalls that are gone, with
> three possible methods:
> 
> # 167 was query_module
> 167	common	query_module                  sys_ni_syscall
> 167	common	query_module
> 
> You use the third one now, which is the same as x86 but nothing
> else. The second one using an explicit 'sys_ni_syscall' is the
> most common and has the same effect, so maybe use that as well.

Ok, will change.

> Eventually we may want to convert everything to the first method
> and drop the syscall macros, but that would be visible in
> user-space and might cause regression, so it should be a
> separate series across all architectures if we want to go there.

Yes, I thought about to remove them, but this is user space
visible. Therefore I kept it for now.
