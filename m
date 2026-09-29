Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0225B090;
	Tue, 29 Sep 2026 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655592; cv=none; b=DNhHp9HWWfOel8Rqv9T0zqWHGk3x9x/uMYhFO9prb3MoORWMmgzlvEp4Qy/6dLdpjxhYxRN7Q1yV+hQ+vKRGPIi1nzFbiwdqsUP/7f5WIeTIGA8D6V6Yyf1Ga9NSejwVHQ9NykcJ2DoAG24/tfaRKvfi65K0qMYtb0EgF6801q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655592; c=relaxed/simple;
	bh=Is7VaZP9wf3fbUcq4Yzbmr5xX6HgP4L6p/1lWgX7Rpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvZA0vX7AOF3FzX5ImcuYNLDpQShzSu0O9NFHP0S+r1SLR3Iko8WntFhtYypVg6vhVdT9R83E5ucJA5jld5PZZYk2DhQxDVMOYugW9P1qDvwW5pBKPHU1owRP6qMqKVhcLySawqE/Ggjh9iiPulbO14kuLh2ea/8OGChmTPDukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UpwSPBry; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UpwSPBry"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46Lbe3076728;
	Tue, 29 Sep 2026 04:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UCoaHie55kyGg4JrFoWMLMH4ZYbUad
	etcp1lLdpAeDk=; b=UpwSPBry6N6XgHidsHmWmnArIZQxz9lggpREBynZMHIehz
	jlMokhOyEHri2vBp4URgOcJzUcrcLGHtEj2lrOYY9hefzK5L4WBF3n13PABDmpeD
	bsHhCxtXwLxpoUOcT4sVu1aZKMbujB8AHPl3MPhvWFVo3zdl4+PYAsi8SkBrxXSt
	JhqiKATu46tLlxfOvwFr9671R/VsZiWlslnBV7eE2IS9ojRJAHt2CwhMyN73vXT4
	3q7F9RzrXHP89W6+QYyEQrvfsG/w8z1+D33SvT5Fr6NpMTVAmbnxEvQ7znEVfYlI
	z5PbZGHLELBRMzPtK7petQDY3Tp0FgcWR4aYQxOw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j556dy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 04:19:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4HcIr1175984;
	Tue, 29 Sep 2026 04:19:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y7wy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 04:19:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T4JKob50921874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 04:19:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFBB92004B;
	Tue, 29 Sep 2026 04:19:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99A4920043;
	Tue, 29 Sep 2026 04:19:20 +0000 (GMT)
Received: from localhost (unknown [9.111.43.27])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 04:19:20 +0000 (GMT)
Date: Tue, 29 Sep 2026 06:19:20 +0200
From: Andreas Grapentin <gra@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v8 16/29] arm64: Share arm64 headers with s390
Message-ID: <ars6Jh5DiendDT7G@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-17-seiden@linux.ibm.com>
 <arqQ2Eat4VUBbl49@arm.com>
 <20260928162345.428362-C-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928162345.428362-C-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNiBTYWx0ZWRfX6Nn1f/umagMM
 1+irdbg0phEtd+BZvjSTdH7HQbGsCmhy3UprVF8arUBdsMZJ+2vmEsRH9BTFg7n6sjFwz4hBm+p
 wznk7RoGSpUUQWYHi5qisxSndJSLkEk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNiBTYWx0ZWRfX7mGjGWpPZTDW
 BwTe+UpwAhEwgur5zlUZ6JpYhHkujlYQYmos7k2vGrn7GmfK9jN071tje6//kHoGXN4+6WTjs7Q
 E19V39a1AXE0+VbnjKAUk/aCKdGJWXFtmDSyorcFq6Pa1mBR+DuLgGrtxWWKnG8TFp7WCeHjF/E
 4rgP5e31jDqfVLAjnnQF20yCImf6OJt4HBJ2k1Fbuv4Uv8RgORXNf7ognCXrNNZOK61mLZFrqfk
 /sxB5f6h22kO/Ge661UxZceyYENF0EOudvMUjZME0uoYEse48lopa/N+llegytw1xj4sVH5Ldlv
 XJjOzMG11Vy9FY98GMK5NSPpv4GsYzSLZfUoWHGQ/HxBPE0AXBsYfnmmQyV6NNsZ1PYbitqOy0M
 0c7npeCv3MQuT4aihFyATVs2nY0Tu9R1Kt+4dA59dwq8opp7GmQej+vWGHmpwyvtl1hqHlHeRP1
 ZyjBHf5iNjhnQxD57Pw==
X-Proofpoint-GUID: NCy8N2_ZnqFwaT3dU9M5d5pFwo3tFVN4
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abb3c51 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=i6sFrxAX1s6maLuQdwkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: MHF4wWmMN9gEzyso21XKl4nvdZcx3ejq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290016

On Sep 28 26, Steffen Eiden wrote:
> On Mon, Sep 28, 2026 at 05:07:52PM +0100, Catalin Marinas wrote:
> > On Fri, Sep 18, 2026 at 03:30:53PM +0200, Steffen Eiden wrote:
> > > +# Enable all code shared to s390
> > > +KBUILD_CFLAGS	+= -DARM64_S390_COMMON
> > > +KBUILD_AFLAGS	+= -DARM64_S390_COMMON
> > > +KBUILD_CPPFLAGS	+= -DARM64_S390_COMMON
> > 
> > Do we actually need these defines? They seem only to be used as markers
> > for the awk scripts to extract the definitions. Why do we need the C
> > preprocessor involved at all? Could we not just have comment markers:
> > 
> > /* ARM64_S390_COMMON_BEGIN */
> > ...
> > /* ARM64_S390_COMMON_END */
> >
> No technically we do not need those. They could be useful if we find out
> that AWK is the wrong tool and move to a C Preprocessor + diff based
> approach. 
> 
> if the ifdev is not closed the compiler will complain, but an 'arm did
> not destroy us' verifiaction tool ( I will send one soonish) could do
> the same.

iirc the last time we discussed this we didn't think that load-bearing
comments were the right tool here. We also briefly floated the idea of
using a #pragma region based approach, but in the end we went with the
#ifdef preprocessor directives instead, as the least invasive
non-comment marker that was available.

Best,
Andreas
