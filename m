Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E939470457;
	Fri,  2 Oct 2026 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932676; cv=none; b=GkmpIOhIbz1UZht+GL5jPrdoT1qMq8w9RUGYHHd+pcGSfaD/IKwnkE1cLSbcWPrQzJ3EWWEF35U353l2TVNQ5FMREl8A4hgmvS7tISReu9uPdCiGBvtFIDc/bJA0idJ1ig2eURbn40wtA8X248IaLS2BB9bDYp4ozycNg2WWpP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932676; c=relaxed/simple;
	bh=G57u2qii/v7VAwt+ktBPH9MfBfnuJ8qot9Hpqxg9VFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiMRCT5JjUL528Qm2spA9mqZNOPevH9XEWVkr4HeOD9OFu5fvKaDRF5vTGjoJ1LTrcNRqKr5fZUAAHeF8aNJadxzZUfzBYXdeE4QScwuCzWBz8xz9zxw/2rbKlnyVOgmPGt7Hu/RnJxw+xW65HY8igD6Am3nso6zAbqWexokhD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZjppKu+X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZjppKu+X"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69265rQL3958830;
	Fri, 2 Oct 2026 09:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6uqtZCh5sKiBa1aMXAb5BJTAZQc8AK
	FENrdMiTf5wfM=; b=ZjppKu+Xb/f/KaoBLr2rFJugyrTL723BCaOwEBmWmBnC59
	k3r8m67jPcYaVd8ORwmboDqQoEByQbOHVKXkiJL13VNFqJhbyjcMUn1XYp/C3b0a
	U8LFHujV6zFRyMVGOeqqpZ4wy1hhuk+P8I1k6cW1wbzAxTeSphz+BxkDCWilpBXh
	rDTwYAsf8GpPZ2pM56xlO1fTtSZ8wotN4veMkOfZCBMv0NPP9V3NYCIgVA80Eoro
	JfCpcyI8gSweqzVDTicBhDn//xmFOYUyKIzv6hGahIOTdnjpF0/ACQwGz+n3RCfo
	rcVeSbyy1wMJGociV6QGqhvjz3tR7N/czr/pH2ag==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5rjd0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 09:17:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69262PFt2076520;
	Fri, 2 Oct 2026 09:17:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsj6a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 09:17:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6929HSmC45941162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 09:17:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BB3B20043;
	Fri,  2 Oct 2026 09:17:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F05972004E;
	Fri,  2 Oct 2026 09:17:26 +0000 (GMT)
Received: from osiris (unknown [9.87.132.225])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Oct 2026 09:17:26 +0000 (GMT)
Date: Fri, 2 Oct 2026 11:17:25 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>
Subject: Re: (subset) [PATCH v9 00/24] KVM: s390: Introduce arm64 KVM
Message-ID: <20261002091725.22510-B-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <179085262878.3865846.5787241839391727949.b4-ty@b4>
 <20261001132715.108643-A-seiden@linux.ibm.com>
 <86wls1315l.wl-maz@kernel.org>
 <20261002080015.22510-A-seiden@linux.ibm.com>
 <86v77k326m.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86v77k326m.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzNiBTYWx0ZWRfXzf+SaVRSYbxi
 wF6O6ItDg/TjjQZsWvIS6iA/pNx+kTGeei2b09mnkYuIYMQvNAu4GfhXOyjUUU0ecdGH3IcCXgs
 8zzy2BhHZFxJHD9SOSQgWcEEoP35fgc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzNiBTYWx0ZWRfX6ksXvNaSh//Y
 qLGbrcdum8WnH1erhMEoQABB1l9Je2YAFiwqN0X/a9GeNPNsbLWZkrcInVgphwEXJAfvKF8kzoA
 UIAjEcbcoTC6O+M2TpSUxiugeT+5/TVTNvt2jWqvO83EkDuQTG2CBYApKvu9ZWJ8WMo6+m/eQVZ
 uy3eJXQNOaX+DaYfQ9LeFKbrWhDTIw4gc0RD6NjqlK8itgz3tvrbx+JtuiptfSPSRb+M/VwxF10
 FaMYAZoIfFmS1t2noOk7/HasizlcmVvCPkkChT9+60jc69zF0PNT7/66sbeBXUkjVoZTLuqyFqR
 0FdGxTkEB4K9x55i0cDA+RhXD1blx10kci9trxb1/sLsHrRVwRkFUPhHRQap8hN3zbRRclFkFdh
 iFISzd2W8M8fXgxjMcGEbO1ZQSotv8F/yjGjvc9BFh9Hv7qdmfJciVbqVxUGbIp77a2oL5NOyTm
 HePgsSgJ7jxJP7IFoGg==
X-Proofpoint-GUID: 8jsrgeQygRoRTjmexax4kfknhqu-s8hs
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abf76ad cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ALOfu2a2d7XKILEI8oUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 6Gcx6D6PvRG4WEJpQqeeOPCS1cyvHcMq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020036

On Fri, Oct 02, 2026 at 10:02:41AM +0100, Marc Zyngier wrote:
> On Fri, 02 Oct 2026 09:00:15 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > Yes the positioning of the functions look good. It builds on top of
> > kvmarm/next + this (sightly relocated (line numbes are different) patch
> > + arm on s390 stuff.
> 
> Cool. I've now pushed out the rebuilt kvmarm/next branch with this,
> and hopefully it will make it into -next today.
> 
> Let me know if anything else is amiss.
> 
> > I'll work on a verification tool for you guys to make this process
> > easier.
> 
> I guess the ultimate verification tool is to build s390 with the rest
> of the patches, which I've just done. This doesn't lead to any error
> that wasn't already reported.

Yes. Fortuinately this will be availabel soon :) 

I wanted to create a simple build target or similar for arm64 that
mimics the s390 use of arm64 shared code but compiles using an arm64
toolchain to reduce friction for esp non-maintainers.

I have some ideas. They may work. Let's talk at plumbers about that.

	Steffen
