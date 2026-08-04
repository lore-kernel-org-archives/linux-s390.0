Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09241D627;
	Tue,  4 Aug 2026 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827641; cv=none; b=LY12xhKRuY6U4WjLyzLZDjOb4anb0F4FwqVPrT3TGikmec5EI41ljokRiYE4cTDutT1bl8O91vJfhlvEK5ZeJ25BVqeXEmT6D+r+5lGgU3WumPxYJ5tVkgJCU39Xd3cBPll8I1Vahgyc97JF6nza8iK8FHqjklQW3yFK98WB6QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827641; c=relaxed/simple;
	bh=iB7LAbQB9wnUsBMZOc1HkDyLZosHBMB2j8feHA1K5Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L50k1VFsRl+f7ZZcCUPTf2V/ugzDfqQINdWbU1+18T/yp9pfuUFQ+kyG71bm5nwD2sO07sP2ybtndQ/f5UQqM1cf3DQdw5ctsgwUubgaBRx985tPfikHJyo/vL0omJBPdaiAhrXvcuuEkmJvYmEfruzDthH5T5Dk56auJfK28R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GY4RTDjz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GY4RTDjz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741Iquf3657805;
	Tue, 4 Aug 2026 07:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vUE32F5PyxjvzAPaObeqRMSsRGv8gN
	bkIwzkhha1L2w=; b=GY4RTDjzrcBHJFguzMKgTPWXld4hjkUkt5mNRTTM1NuTpI
	B5aabeesGMSw0xh6e2YHrW1qiR9OVVHGsl8a3TnmjcP2Kmw4DcbEsRTPRVyrLGrY
	uXq2Foq6eMSySTWrpH0FfXrhKKf0SvavpqdXDF7Fmr5yBEM5d1Q9/480JF3Qj3ch
	XLYEcuUk/0babo1s8U2ECsxRI6hBWwqJF6YK43Jk6cwRlM0JFsdNJTFIAXm6u1Hw
	Ea+RRx4Pekz3XgNJ0isflq85SQ7slI4n8O2KARRiaAotvZAOuxYXTbV9Dx3KYOqV
	sS/mtpDM1YaHaU9Qi3bBr/pMb//naliNkBiXMOww==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4vmb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:13:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747BGg9017489;
	Tue, 4 Aug 2026 07:13:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qh1xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:13:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747DX6G44106180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:13:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DAED20063;
	Tue,  4 Aug 2026 07:13:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FDF120040;
	Tue,  4 Aug 2026 07:13:32 +0000 (GMT)
Received: from osiris (unknown [9.111.93.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 07:13:32 +0000 (GMT)
Date: Tue, 4 Aug 2026 09:13:30 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Danilo Krummrich <dakr@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        driver-core@lists.linux.dev,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, Boqun Feng <boqun@kernel.org>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
        rust-for-linux@vger.kernel.org
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
Message-ID: <20260804071330.24760Aaf-hca@linux.ibm.com>
References: <20260803180931.97202-1-ojeda@kernel.org>
 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfX3v88aBK5YIfi
 g0CikaZzU6SCLK4jvJrE43+u9qKt9mf/pN5sXI6EE7+YOrQwxGCR6kvT42IkPsEIOTdJdLFly5P
 3ielbbnqL/rmr8UZk6HHETEsXui4/CE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfX/C/TRi9AeEqi
 mx2uGAr6WflAIE7vELDGWbll/NjO/egbZIMz7QrrH+Zi/eCdkvdSEAf0iaONiV8FQm/3x091Xcf
 H/8HoGHm+a3+ODnWLJdH98CkPwyUu+AgpF/IQLMgMAeMOLPgS8fJAINZreJcLFa92S482K4OiPe
 1K+8p+F3nnBjBlF2DeRKqJjK9ECfhfxd7UwWpV48h9znsJPV0oLYH3P02ps8D+kMsWduz45lS9e
 uZPsrkB1a+6T2h2dtAXV8YK+YW2imnUu1UetLuXr64RT1KGph8ZY7x7dssr97DwNEj5o31oo0jO
 h8B6jtpA85w+gO+iXYyyZEQqzSxtqfXJRj0TORhm1p/wGJcNR66uciMDu7m6+ynZjF2aPzNiY5d
 /kt6bAK6mzO++k3A7/C963ENgSLy8J1QdO9pSCbtl3ct52B5GDlgvWsjX69Gw0ijP8yfh9kUKFs
 oI6JFrVenNDY5kAxgLQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a719122 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=kqwOr8l2DO9RG4HK3QcA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: Ft_qBtxc8u4mav5gIIbz5_nIC5A8xVIb
X-Proofpoint-GUID: 754QDw_B3uIUzLifpG3vuiI9ma9loci4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040052

On Mon, Aug 03, 2026 at 10:09:08PM +0200, Danilo Krummrich wrote:
> On Mon Aug 3, 2026 at 9:56 PM CEST, Arnd Bergmann wrote:
> > In theory you should be able to use rust code without PCI MMIO
> > support, but I can't see any practical downsides to making rust
> > 'depends on HAS_MMIO' to avoid having to add those #ifdef.
> 
> I think the implications should be minor without making Rust depend on
> CONFIG_HAS_IOMEM.
> 
> I just sent out a fix [1]; the only annoying part is [2], but we should change
> those doc-tests anyway. For the one in rust/kernel/io.rs we already did in
> driver-core-next.
> 
> [1] https://lore.kernel.org/driver-core/20260803200249.3494259-1-dakr@kernel.org/
> [2] https://lore.kernel.org/driver-core/20260803200249.3494259-2-dakr@kernel.org/

I'm wondering if it would make sense to make HAS_IOMEM always available
on s390, even though it doesn't make too much sense without PCI.
But at least it would make s390 again a bit less special.

Niklas, Gerd?
