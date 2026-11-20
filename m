Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184067;
	b=ilYfzmMMmU+D+SbFGw6MQeHApcJCTZSUhNbuYUZT+25PU5WvA/SWt7jBzpKEvlOIqQJL
	 98m8Bnp+677l8NbXutIFtCH2sHIZSgUbfgV0W45vW0m5EQQDU4d4w5GalqsYFfnQq5GoZ
	 PdbngHEFoA7oXti5BHZjGlS4dzzTNSAsGTKL93gDjsfd8deadIoklMtkoPR4FuPWRFEsg
	 QybQpX9uFKmucxy4O/D1zeFVJYG06sOaJkVVCQsZyuAWbQXKWg26kY4VXMgS46pRLSw8u
	 CMnUQKsWXPs1sWyT3UdGN9dxP2X3X12sYOh+WHRSY3U2KGVvJ6atQRJyHblRQhU/ZeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184067;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PvPx8KemO0xcM9BvIjOEVvpcXVwQS3ehLVp+q+/Y12c=;
	b=Rn+4Fg+pps8FwYGfgFGUcBaKEHaQCiHgpyBpFhflAMuEgV/52AOv9BAYL/tbvfSZOmuy
	 17gJU5rnLZQUEAlBx8Du16TrIqFJUYFXKvhOq7YTvA+oGioSnSKASbTB/OJzfplzgism5
	 vaFzCDzHUHtwO474PMGjrSSY+LRJms1k1uQLQ1ELXYB/W5WdFDaYaaEfthfWtuywEEd6c
	 K3tfQRxIIC1Vbfw0/hVmag/R6wan+PC1lwFItlmRkJBvldnOu97PSYbdBBJKPG1SerWDd
	 GsA3gVSYyKymmxw/N4pOfbt2WYo62o2dzprhXOwfysdSMSOI/1DqctkpYGeBd/PvFyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B5DXBemK;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D65606A320;
	Fri, 20 Nov 2026 14:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3D65606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B5DXBemK
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAueo32861278;
	Fri, 20 Nov 2026 14:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PvPx8KemO0xcM9BvIjOEVvpcXVwQS3
	ehLVp+q+/Y12c=; b=B5DXBemKh9Lh8Rak/aftkySB8nUn7NsasM5g/+jda1/202
	SNHoaGCp4T50AfG5uoLucmeIAlvT28FDySN7p1NkD6ZtwATMuH03SW5Q07GNENBL
	LZ8crLwhAp9yp516a+PR34CiZCkRsP1Uzum3VC3B7DLgM9v/MJ96zLNFPPuer3MJ
	EzzVOF0TcZzPwB++1501FHuJDNsHZ1mUAKrl8Wz5m6WwODC8ajQQvRUHTNfQLbnV
	D65Zv3Pw8HNWgu/r8A+wSIjspJXowyQ/dbRGgq/UWQbIwNf2dkuwF5eWySI59VZ0
	ecI6tQDSJ7Zbd3DNa6/jIzSO/ax9WVj+5PFGXxHw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x8hq4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 14:13:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKDVBTa1220811;
	Fri, 20 Nov 2026 14:13:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j2q5ng6nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 14:13:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AKEDdaU47513900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 14:13:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDBFB20043;
	Fri, 20 Nov 2026 14:13:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B608F20040;
	Fri, 20 Nov 2026 14:13:38 +0000 (GMT)
Received: from osiris (unknown [9.111.86.180])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Nov 2026 14:13:38 +0000 (GMT)
Date: Fri, 20 Nov 2026 15:13:37 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
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
        linux-s390@vger.kernel.org,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v3 01/23] KVM: arm64: Refactor idreg caching into
 dedicated structure
Message-ID: <20261120141337.222720-A-seiden@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-1-75e95980fb10@linux.ibm.com>
 <87ik1z8gsy.wl-maz@kernel.org>
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
In-Reply-To: <87ik1z8gsy.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ifAOkSVLFCM3CzBERqJcC9NJg_rpimD7
X-Proofpoint-GUID: ifAOkSVLFCM3CzBERqJcC9NJg_rpimD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NSBTYWx0ZWRfX1grFYOpSlxGw
 8U9gaIC7JaaXQFyArTP2A4hWJieHkkamYfmrPYx3g789KdPdqcGyBy/D//k1xZUO/aKYRm7wd94
 Ku39vjASwOWmvQOP1BiIQYSMpAUaNbyY8cGOnYjdniXsPxKNBnpOpKq0IbNmOjW7h+mOMIFqlZ2
 D12fcqRyN0Q8Dzpj8uJsm81mAiWtP2HGXzHwX3OfxYVDev84qTYQIpoaWWxXpALxsgvrJq2feQu
 7Y2foONElooJcrbPU0AEp8si+PAHtwolJRuL0i+rxnPZ3u0oYpRL6JFfrFEQTKkA/Gpyojc0CQP
 Qs0WuDmgkafbkyu4WHYIPYbPbYBtDgw3G4s+VhNuZ8c4vlsihN57gNFQ4mGErRqUWeOOsPPwxCu
 T0zJosPU7KFjQ8NQWg3bsRtOp8XlW+gn9R35ybhBCRVuPDgOP3/TWmIq7PE3KuASaFl27PvPeYB
 YH0n81NxFpODIyhAqMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NSBTYWx0ZWRfX7PEZIeKNrAen
 Ko9rFLMVrRfFLFVd1IbxaNDtLwwIRNzqqlwdxybsCQ/kVtWEXSxjeCUfFIm6G/pC8kyzqQzy/4L
 MjqKT4QezrVLsftKJw8+LmRsM8tmVwo=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6b00559d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=5Px26FCybgXTlaf_HfoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200055

On Sat, Nov 14, 2026 at 05:27:09PM +0000, Marc Zyngier wrote:
> On Fri, 06 Nov 2026 16:07:34 +0000,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 

...

> 
> Overall, I'd like to see a first patch introducing helpers that the
> code uses everywhere possible, then another patch that introduces the
> structure, the renaming, and changes the accessors without touching
> the rest of the code.

Sounds good. I'll implement that.

Thank you!

	Steffen

