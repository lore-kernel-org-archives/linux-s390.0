Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509837;
	b=KkGfzSLJPp/Prk0/pMG+ylRF8v+ec+g5h+L+3poSX/xqeG3u3TVqcju/zHT2T+DpnX4b
	 lzzEHOUFKLdxky2tAfOPdcgj5opL8Ddvh4Zme3CH94fhJZ7iEShdNaPqoMS4uiolN1qGa
	 Kuw2tQOePDLox3Zp9gauivMFdmhRYuC+bgsgRCJxgn6jTVJED7MxtFYTMW9cb07PGFPfF
	 0u/1TekC4mqEEaOUwk5rRvJuNmCn1LHXNwcwW/0WlvKGAbkzzYJ9JN7BTqkDmYB14Uz6Q
	 XLpgrH+5FxcK/foEksUy3W53IXkF/H3PPwT+Gn7nJzstq9vSWqhFAkaTHbEwAU7pMOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509837;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=O7m23VpeyyFGtHVQ0SDxRDbQjLNhp4OyIKa+PT9Wo+A=;
	b=ph8f7kRnIv8+wi83Lc2IVyuJaU4fcuZli5j7QQW16G5hsz6uZpf2zzZjmNCxuWzq5vyC
	 OCSln2Rbv0NEtNxVCh5RSA0PtZ/vt4kSfRQJkZx9d1Vn3hB3u1XU2zBgQE5cFuB+W8kxA
	 mW2BNh6JVEadOGXjuRB5gjkeTAztpdntDuKnP0ZqtTQ4mKF00XQFE+I0XeYrwXz/1zCDK
	 s66Rd6TimgCy6JOJHUb7S58LzXSD/C7m6Cs4uVPWf9nI9+6C9Fjnz6TWWKNfHshVMuVUO
	 jsFikohFrPbEaK5Ifp8uB1SLPvplJ8ZP+1froJv0El4SIrL3vlgAYXhD5gYesBqnwpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Ce/swp8J";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37396606A31E;
	Tue, 24 Nov 2026 08:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37396606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ce/swp8J
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO352Q81412829;
	Tue, 24 Nov 2026 08:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=O7m23VpeyyFGtHVQ0SDxRDbQjLNhp4
	OyIKa+PT9Wo+A=; b=Ce/swp8Jey/TeeaXBEZHjhd3Pn93Ab/qw0pPj0tNGQP33A
	zSE9CQFwrz8qlGB0l49GgybkyYeX1fk7YbTrooq78QG80VLmVKuL9Ak4RDomyeFg
	1nRd/6T4/F0d23KEu7qq1E59Sc5ydzvDVZ1fevsCdMLpebGiT6bhmVB61INM6Oqc
	2VENEAmq5cLlDO9bBxiUkiFH4NWRyUBG0AP5dILT+K7q+jK0jdG51p0JE/6AFkDd
	jlUxeHkttM3VbezbuAiTDVu8lf+xgKVcRGYdGY7rwq5ISJC4TCR5cgwh5ZJan2eC
	8LXMPoVlkqJlrgonEIDDZHJqxPLPivwRGzIXpuHQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fa6vb0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 08:43:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2nX6g2087387;
	Tue, 24 Nov 2026 08:43:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vj1r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 08:43:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AO8hJ8Y42926434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 08:43:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBB2B20043;
	Tue, 24 Nov 2026 08:43:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C42C2004D;
	Tue, 24 Nov 2026 08:43:19 +0000 (GMT)
Received: from osiris (unknown [9.68.29.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Nov 2026 08:43:19 +0000 (GMT)
Date: Tue, 24 Nov 2026 09:43:18 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 23/23] s390: Report AEF features to sysfs
Message-ID: <20261124084318.23381-A-seiden@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-23-75e95980fb10@linux.ibm.com>
 <01631f5a-9140-4dcb-a91b-5c431b384be6@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01631f5a-9140-4dcb-a91b-5c431b384be6@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMyBTYWx0ZWRfX7AwKlo5hrmga
 OCLxVqCWWWZO3kcworetiGUy2WV/dgmYumQCiq6Ol5EFqHg85k8E03qj8ZKkW6ZhomFEtjg5uuO
 mrI7BZ6tIMKOXCXIfY63r7ngsdsXowyOHTrdkExWZicD1Xe/wULSID9bvyvjOlXKaBMzFdt+Je5
 rcpYNU1ES9EMG8xennhRF5KNoOlkIcu0+HnSImKLgzpnNIqRjizZjHTzXLSQJaNoOT3TQzOWJ8Z
 4XSmIhTRxPDbaD2akN/OQ58hnoar2LBUVOgfnqirlmwckzIp6aHPbMAm/kyPpOhuYRCp96FLWIY
 IaxLFB99pcLPO1q5wuNYFccmLTHHZ/iUbsM06Oqsacmm78u94YFXyhgHty7DfR/6Nu/vjTELHjo
 RK6s613cErTVTFcYyEe1DpKQHigT/XJgFzZw4lSvPCHQPRRwod0HiUblfl4nCnNkkFFe4NgRUY/
 yQOdQX3a5KMogTqz0wA==
X-Proofpoint-ORIG-GUID: 6GJrjQx_l6DWOdMijtAWCgD_iYEspNos
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b054e2d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=bireLN_HoqkOtvrXVMMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 6GJrjQx_l6DWOdMijtAWCgD_iYEspNos
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMyBTYWx0ZWRfXy5gfI4849inq
 e38ktmrAupucEPACzQtQFb06U77tqcFk/56FOIc5DRH1KOr3jmkqX1DHis5Rk5GcfYJfIant25k
 ZghX6D0s8lzz/DQ5oKO1FMjINkFmuyA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240033

On Mon, Nov 23, 2026 at 02:04:12PM +0100, Janosch Frank wrote:
> On 11/6/26 5:07 PM, Steffen Eiden wrote:
> > Display various information about the Arm execution Facility (AEF) to
> > userspace. The files are located in /sys/firmware/aef/. Show if the
> > feature is available and usable for the host, which formats are
> > available, and how many arm vCPUS per guest are supported by the
> > machine. Additionally, provide the raw binary output of QAAF fc1 (Query
> > Model Capabilities) in the file qmc and fc2 (Initial
> > System-Registers-Save Area) in the file save_area.
> > 
> > Co-developed-by: Janosch Frank <frankja@linux.ibm.com>
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> > Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >   Documentation/ABI/testing/sysfs-firmware-aef |  70 +++++++++++++++++
> >   arch/s390/kernel/aef.c                       | 113 +++++++++++++++++++++++++++
> >   2 files changed, 183 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-firmware-aef b/Documentation/ABI/testing/sysfs-firmware-aef
> > new file mode 100644
> > index 000000000000..6ccd8491a017
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-firmware-aef
> 
> [...]
> 
> > +
> > +What:		/sys/firmware/aef/query/sae_avail
> > +KernelVersion:	7.5
> > +Contact:	linux-s390@vger.kernel.org
> > +Description:	Read-only, decimal boolean. Reports 1 if the machine
> > +		provides the SAE instruction.
> > +
> > +What:		/sys/firmware/aef/query/ptff_avail
> > +KernelVersion:	7.5
> > +Contact:	linux-s390@vger.kernel.org
> > +Description:	Read-only, decimal boolean. Reports 1 if the PTFF
> > +		instruction supports the QAGTO and QAGPT subfunctions.
> > +
> > +What:		/sys/firmware/aef/query/edat2_avail
> > +KernelVersion:	7.5
> > +Contact:	linux-s390@vger.kernel.org
> > +Description:	Read-only, decimal boolean. Reports 1 if the EDAT-2
> > +		facility is available.
> 
> I don't think we need any of the three files above.
> sae should be reported as a feature in /proc/cpuinfo, same as sief2.
> 
> edat2 is facility 78 in the same file.
> 
> PTFF-QAF is unprivileged.

OK, I can remove those. Primarily, I added them for convenience. I'll
add those to the Documentation (I'll create one soonish)

> 
> Also, if aef is the requirement for the directory to exist, why would saef
> not be enabled?
>

You are right. I'll drop the three files.

I am thinking about always providing the aef directory. And just not
calling qaaf in the !aef case. Then userspace does not have to test if
the file exists and guess if the file does not exists because the kernel
does not support it or the HW. Or is this a non-issue?

	Steffen
