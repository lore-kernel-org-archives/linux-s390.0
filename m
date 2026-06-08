Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35E399372;
	Mon,  8 Jun 2026 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906252; cv=none; b=AUk/dIoTb2M5E9c6LxTd+m8SelMdTSjCCjY57kifHsK0KjqU/WoyqaA2YIfy4HV5AWLAxz64BX49INn4de9go1gN5WSJ8sm6adhst3XAPZ+cJ1kPTTBZRQvm/VZE5WKMFfzUAgAZITvfw5PkTpnad4NO+T4WgwwJu92sqkOQdEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906252; c=relaxed/simple;
	bh=PuW+2DQ9oqE9O+a/yBjXCO94jYHzNrX7BI8SzQ1G7os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK4eNtNn3PojBx9cQnrNp4fWF7LgaZh3PQlsMsRl+Jm0+vv2polaJjSqTVRT5uD/y8YulmaGx61batc4YvfQA/8bh3LYJKrDV2QEhWcQ63E+M7202Ba8E7/aJJln/feDlY/z91Ijt39CO1scsC90+aHDrEECeOM/wFNIzVp8tEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dBhyBufm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dBhyBufm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6579b1fu2990707;
	Mon, 8 Jun 2026 08:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ybZQjal46FeOrn2hm6lTCaz+t/9Rl0
	Db41fcp16G+Dg=; b=dBhyBufmfP4wvnfQ9Irzgd66IC9FtHX38d6Tu1bbxef+5D
	0zrk4mJoy93bWMF4jAi5szsjPx9Tw/dzN7SGBbodJGrGOqRuuK8F84HlhzE2TyZi
	mNUreGXVwOTCKQ0MBgGCTwM7lYoMjpWNi62HZ/MOKD34ZsLQ8YfyWNXNt1NStGko
	UDG3fuO7F/oCayF7r/a4ntffPKO+ByTOyV3ownyCK3wZPJOEFhQtJGcD5OCtAxsm
	CMSQeEW0+nlXK0XB7wiogaJIYF/YMDvNMwfcSVj9eLLutsaPf2MiNgLqeabF/Wke
	mikzD0yQUw13FncQ6E/KoY8Ke+RhapWMmlhDBZzg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhpf9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 08:09:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65884ZXK014601;
	Mon, 8 Jun 2026 08:09:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fv82v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 08:09:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65889pCN55968026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 08:09:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6EF920043;
	Mon,  8 Jun 2026 08:09:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2336620040;
	Mon,  8 Jun 2026 08:09:50 +0000 (GMT)
Received: from osiris (unknown [9.87.136.35])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 08:09:50 +0000 (GMT)
Date: Mon, 8 Jun 2026 10:09:48 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Oliver Upton <oupton@kernel.org>
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
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v1 12/26] KVM: arm64: Add PVM_ prefix to avoid name
 collisions
Message-ID: <20260608080948.100035-A-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
 <20260529155601.2927240-13-seiden@linux.ibm.com>
 <ah4GaFNM7xfS7CJC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah4GaFNM7xfS7CJC@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfXyCkHnN7Bi5ra
 BiLvAZzGqCaTUYlhd3Fu2wWFJ9R9s01M7j5kvTtiiXgAzuKU25KIjGu/i7RLgMErYk3Yn9t5okg
 oJxFxM9tZARCVdPpr7liIYYsfyLRnLjy8uuNen+Huw0vxnYjQulU0I8aTW9NwWZJBx2fD1jhvKB
 4GFLIrU2JmKmNrNA3KED9vSxCpVgdp3ct1nmcbMvOvpiMtUm2bDdujf4+e3OCVFpGo3fHvYgDZb
 qUr3+FWmcKKVISox41jOdQznLMMHuc+spBKWUsDra7nyaDWxixcMOYd6lxga/AgRwa6BlV8d32s
 1WfJDcNVFuo2gAHDjJ57La9sVXR0dNmatppsAyTb/UkgVgouggJ2i1jdzwNCwkjTwbhc3YGzNv+
 ky2AqTU5puiuEGrdKe8qbYbgLZOUuijjX/x/rA6u/DNBHv2WYzD3fPoJSgbU9vBQyCQfvz13MFL
 i8DwoVYtC6nBJM3B2OA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a2678d6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=sjSFLaudIdQReGWt298A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 0fCevorcLqPyPvXErUXpRrKCxITKL_ji
X-Proofpoint-GUID: 0fCevorcLqPyPvXErUXpRrKCxITKL_ji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080074

On Mon, Jun 01, 2026 at 03:23:36PM -0700, Oliver Upton wrote:
> On Fri, May 29, 2026 at 05:55:45PM +0200, Steffen Eiden wrote:
> > Rename ID_UNALLOCATED to PVM_ID_UNALLOCATED and read_id_reg to
> > pvm_read_id_reg to prevent future name collisions with other subsystems.
> > While at it, fix whitespace issues in the macro invocations
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> 
> No issues with the rename but do you even need the nVHE object at all
> for s390?

No we do not need those definitions. The problem comes with a later patch.
The ID_UNALLOCATED macro moves to include/kvm/arm64/sys_regs.h. Then
arch/arm64/kvm/hyp/nvhe/sys_regs.c redefines that macro.

I renamed the function to stay consistent. 

	Steffen
