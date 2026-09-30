Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232BD3D1AB3;
	Wed, 30 Sep 2026 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753315; cv=none; b=nWZmAKdH395zs8wSV3wtChzKQCHaI/7acN/x1oaUzNr8sa93jInWEJCOt4gep6+ZV3XEu7WaFGmsvF7m0YS9XnlJ9CfnK6yxBeEfArLDseVJt6xlaK2qHRRbnQE7H8szn5QzY1fC7hHr80Cz0HX75anOBPeHmrzhDxMLGd7Zbfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753315; c=relaxed/simple;
	bh=crfXBi6k42WA+BnhYLAJgvnaGtZorXB2udVsvlHftg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAgCVVl9ojr3Rz06wmib3g3CaY6EJ8Jp2koE2r+0VkkAET1lhY0M4sJnmP9tFke6Mp1jy40fFtd/5OR8MEIJ1DkAIjfSsVRVfd2TjU871BNxHM7qnziHXdRdCocqI05eWkcXIyfCK+HkaYQIhEygC07JpL9/G1pmUcaB85gjSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qyQqJw3n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qyQqJw3n"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNZfTl120044;
	Wed, 30 Sep 2026 07:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hRgj7Et2mslqCi74mWWVC1UpL1zk3V
	NNzSJBai5rckM=; b=qyQqJw3nC2zsh7oS8ERyU52BdcKrwVTFljr3BvDbpRd3B0
	0zPKlWOiZqcAP8lqqFDURkd2yhVvDnlffkj/n4slv1AsrKUOk5PJcib71T0qIsl7
	vFEguWe7hdEimsi5asqbi69ZCjF8u7AMcBtGVNa+9MyVMhx3uaKGMeZ1KBUKjaDn
	0AX5KFBUXsBtYy4SsX8EyIsqe+mfqJOKg8pQwXxwydhgKDHvFeFXrq9Qdbb5LCog
	ia7XEe99DG0ha1Y6NaGbGtug+FFxgE8Px2QXVMyw7/gCufVMbhCLB+JDdxbjLrJl
	g/XH2u8s24bAkyIjFrbMF2J2lk7AjCs0mxSZqwoQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4feaqur-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:28:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U4iFK52606339;
	Wed, 30 Sep 2026 07:28:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhnb27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:28:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68U7S5dp51380624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 07:28:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 470CB20040;
	Wed, 30 Sep 2026 07:28:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AD5F20049;
	Wed, 30 Sep 2026 07:28:04 +0000 (GMT)
Received: from osiris (unknown [9.111.12.23])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 30 Sep 2026 07:28:04 +0000 (GMT)
Date: Wed, 30 Sep 2026 09:28:03 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andreas Grapentin <gra@linux.ibm.com>, kvm@vger.kernel.org,
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
Message-ID: <20260930072803.664031-A-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-17-seiden@linux.ibm.com>
 <arqQ2Eat4VUBbl49@arm.com>
 <20260928162345.428362-C-seiden@linux.ibm.com>
 <ars6Jh5DiendDT7G@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
 <arvunF8epgpWh1YT@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arvunF8epgpWh1YT@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abcba0c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=yUGAwy5nKwvZNSSkddwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX3sU+2Dfn/vqZ
 9s9sMEAwJ/QoIm+wXUoUz+vMRPGFn+7t+mizIFcTMueUC3b+sVfDtayK78vJ/lweMyrYOj751+J
 e2uQYrwjTU5UmQIW6yiFB5Aec8OUzWs=
X-Proofpoint-ORIG-GUID: _DlkOUTOeH3w63xnnfRbYKXk7OuwWqh_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX+QA+Jhr/nNEc
 g+1uQImKhn5dkXln+A0VcaP3Q1Z7lr4d2OR7I70b525QnlNe86XXIVCeXQnK64Hr/G3cJrXdDOW
 xarHfa1K54FmWIE84TlPDZSUduNs78AZVpH2ISdcXex054xZJVnqpsHV5M6KmLfEUDMCFr4g3w2
 TdZ0fnb/SBK//8Gm+2G1x9ZB4vSTBm3AJj3EtUN7rknmvx5+hG77220YBDIe/wcYsMZDTXYNXsb
 IKuxgvAh022qpVUXshSpAsOqrwtfVQIokbZtPZ2KwfDkLKhTkTzbL2WJvksNJb1BJy0TlSYUJOu
 i/rKLvzKVpluB1M6QVkX/iv8oemQeHNdLQACH3QwxymFk1JJ2qQiKrpBlmlm4iYK3u3qGnUFwDf
 gWxXFdWjFB9fqKIyN/BttHrHaIA8xN4GnKR+R0oBPspRkW6zK/s1c7suKsbZzlSXV5hbVU5JBa0
 gCooiWNfWe/80bWIEoA==
X-Proofpoint-GUID: 9uC9FNKzEs4mMhcFIr-EKf_de_z3-bc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300028

On Tue, Sep 29, 2026 at 06:00:12PM +0100, Catalin Marinas wrote:
> On Tue, Sep 29, 2026 at 06:19:20AM +0200, Andreas Grapentin wrote:
> > On Sep 28 26, Steffen Eiden wrote:
> > > On Mon, Sep 28, 2026 at 05:07:52PM +0100, Catalin Marinas wrote:
> > > > On Fri, Sep 18, 2026 at 03:30:53PM +0200, Steffen Eiden wrote:
> > > > > +# Enable all code shared to s390
> > > > > +KBUILD_CFLAGS	+= -DARM64_S390_COMMON
> > > > > +KBUILD_AFLAGS	+= -DARM64_S390_COMMON
> > > > > +KBUILD_CPPFLAGS	+= -DARM64_S390_COMMON
> > > > 
> > > > Do we actually need these defines? They seem only to be used as markers
> > > > for the awk scripts to extract the definitions. Why do we need the C
> > > > preprocessor involved at all? Could we not just have comment markers:
> > > > 
> > > > /* ARM64_S390_COMMON_BEGIN */
> > > > ...
> > > > /* ARM64_S390_COMMON_END */
> > > >
> > > No technically we do not need those. They could be useful if we find out
> > > that AWK is the wrong tool and move to a C Preprocessor + diff based
> > > approach. 
> > > 
> > > if the ifdev is not closed the compiler will complain, but an 'arm did
> > > not destroy us' verifiaction tool ( I will send one soonish) could do
> > > the same.
> > 
> > iirc the last time we discussed this we didn't think that load-bearing
> > comments were the right tool here. We also briefly floated the idea of
> > using a #pragma region based approach, but in the end we went with the
> > #ifdef preprocessor directives instead, as the least invasive
> > non-comment marker that was available.
> 
> The downside is that the macro affects the preprocessed code. We need to
> ensure they don't leak in uapi headers for example. Not a fan of this
> approach but I don't have a better suggestion either. At least we could
> write them as:
> 
> #if ARM64_S390_COMMON == 1

This is a great idea and an improvement. Thanks.

@Marc: Shall I sent a v9 of this series or do you want to pick v8 and I
send this as an improvement once picked?

Regarding UAPI: We will either import the whole uapi header or noting.
We will not modify ARM uapi headers for the arm64 on s390 feature.

> 
> so we get an error if someone misspells the macro name (or they leak in
> uapi headers, vDSO).
> 
> It would also be useful for the awk scripts look for the paired #endif
> rather than relying on the comment at the end of the line. Otherwise
> it's not really different from just sticking to comments.
> 

Are you suggesting that the AWK scripts should track the #if% and #endif
in the code and warn or reject if the marked endif for the shared code
does not match pairing with the starting #if? That makes sense yes. I'll
investigate and would add this as an improvement later on.

	Steffen

