Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FA41A23B0;
	Thu,  9 Jan 2025 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423726; cv=none; b=aWndq0gcDUU65xO56qSdH+7NDJrdnujP8fv4muu/K11JxwjN9j1qqv39+W5jv360aslShcaox+PZXpNfNZWbrVKwMQlfaUZRtPDlxTo2KiweW0MtyE87vF0Rvl/67P0gfPfbzpZYM4TEjEJL4vpzGeOWUtPWFC19A+ujlSNnJB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423726; c=relaxed/simple;
	bh=D3sA98W32+zngVbnalNpt0EtP/yVNDM4WQtJkKd3srk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF77KBIbKasAvH7fpDo0SvI4qzE3z38ESan405k4ds1KYyZ1Y8kS6ydrXMMnSvq+aMRJ7sVi9Y+VOnlON5kBiLNhlCqf7SgAFiCic4G9ZRna1ucg5dDnhprQhBgo0r0VH5JBwfDW7posBI06j89SA1u7tzZG/oqBlLpXj+eIp/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HU3Eulhe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HU3Eulhe"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509864T9022893;
	Thu, 9 Jan 2025 11:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TEFEUs
	DUypMb0E06F+mIr6mms6VLi/ADn+g21sLTM6M=; b=HU3Eulheor5aaMA38MgqND
	w5D0VsYZ9Y4ZQYJZvyu4WLwzk/lzISPX279vOi1rwp0OvImCElaqBmZ7yGv4GXtm
	vKwEzqRIH6fu9psGCV1MCIKHOFAwC/4SQQ1AC5BtxaNM8wdtW+DAIciNpYPO6Ll6
	rLdpqprshTa3IetrfZ8gd5phbjzubOZ9ML1FsMTvRNrN2rZkXWtL51/wIfyNRwsc
	zmVXIeHDTR4Dx4SMQ7DiZQb0y62yBcOaIrAEugKNmaBRj2/WpqHifUmZzBe2/kuP
	CAm9wsvyCG2SQnvkSXl/G1rirz7QoOVkinRwkhD5FGKGs504YPdGvBwjkZgyGuxw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442an2gx1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 11:55:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5097ss8u003572;
	Thu, 9 Jan 2025 11:55:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfatd4rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 11:55:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509BtLqN63177092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 11:55:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2F272004B;
	Thu,  9 Jan 2025 11:55:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 379C620043;
	Thu,  9 Jan 2025 11:55:20 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jan 2025 11:55:20 +0000 (GMT)
Date: Thu, 9 Jan 2025 12:55:18 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Russell King <linux@armlinux.org.uk>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 10/17] s390/vdso: Switch to generic storage implementation
Message-ID: <20250109115518.9731-A-hca@linux.ibm.com>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
 <20241216-vdso-store-rng-v1-10-f7aed1bdb3b2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216-vdso-store-rng-v1-10-f7aed1bdb3b2@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lsyfqPho4h_myH3I0usc_uivjxmUZY2Q
X-Proofpoint-ORIG-GUID: lsyfqPho4h_myH3I0usc_uivjxmUZY2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=354 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090091

On Mon, Dec 16, 2024 at 03:10:06PM +0100, Thomas Weiﬂschuh wrote:
> The generic storage implementation provides the same features as the
> custom one. However it can be shared between architectures, making
> maintenance easier.
> 
> Co-developed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/s390/Kconfig                         |  1 +
>  arch/s390/include/asm/vdso.h              |  4 +-
>  arch/s390/include/asm/vdso/getrandom.h    | 12 ----
>  arch/s390/include/asm/vdso/gettimeofday.h | 15 +----
>  arch/s390/include/asm/vdso/vsyscall.h     | 20 -------
>  arch/s390/kernel/time.c                   |  6 +-
>  arch/s390/kernel/vdso.c                   | 97 ++-----------------------------
>  arch/s390/kernel/vdso32/vdso32.lds.S      |  7 +--
>  arch/s390/kernel/vdso64/vdso64.lds.S      |  8 +--
>  9 files changed, 17 insertions(+), 153 deletions(-)

Looks good to me and works.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
