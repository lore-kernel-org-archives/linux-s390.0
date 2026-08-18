Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E26453A28;
	Tue, 18 Aug 2026 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049902; cv=none; b=IYU+4nXHdEC2LBVZk49NkRRh05sewex4OGXBPZPZY0jTxMnoXl2XUuPxfUFIPQ5wxq6/A6vzS/6XV05pkK2JS6ybnAa36p44cug/W0yhBMUnDiNOEouhK5eAB53E/pAOEDCvKNTAFUbvCg8y0xLsJVbGDf5DCumbD1XxBHVhEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049902; c=relaxed/simple;
	bh=Cl7d616gTup96cCwNosySjOABjEuNmm/kcFRJX3Ekjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euBbVj6VdSQo3JF/LGZWN2jsY2fDr+ym2khVEFYgiZg20un/E9yMSsjD3+UnaDvTazhlghRfDsgc13NeFnCC05DEMUg8lRgUINQjGHH4/Kp90iMlzZwhfxlY8vwSfe+utQoz2heO6Y3Td2WUon2tmyd9F10ShWdtLJHreTXBpgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EMCRjEdA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EMCRjEdA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IAVjR64173786;
	Tue, 18 Aug 2026 10:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tbXpttVsuetJr3+VmHB3otl2Mzim77
	xZlxllhY28aPQ=; b=EMCRjEdAFuB59GddFXXEZwAPIFf3C2eimG+tFaaRipfsUn
	Jf6yQvdU1MqxrOr5LwH/XyXsVd0IqOBtJWtQYoVySJOy0NY7phz3iyYMJQV+0+ij
	iQEcbMxgioJlZakOW9n+onfbzd+cW0kwxh/icQgQISmWYVBo8ZOYTUj8eXHHAXEI
	eGBBNmaWj7cuc/d37AKaTu3vEnIwJQ9fi0TQAJzu5+g4JeY0ipGF3vjmenTX96ar
	Vi1AUP5r3VrGA7SNt7MJ3j5qEaZhIRa47ZvC7hpFgirQZd0e+5QK+7Y05fMBQ79N
	8CEA+xx1h+w5USxCgXXsfqbPh+oikaXumjyFywCw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3qmu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 10:44:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IAfNaf005316;
	Tue, 18 Aug 2026 10:44:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek2ry4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 10:44:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IAiagU28770992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 10:44:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4318D20043;
	Tue, 18 Aug 2026 10:44:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D820920040;
	Tue, 18 Aug 2026 10:44:35 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Aug 2026 10:44:35 +0000 (GMT)
Date: Tue, 18 Aug 2026 12:44:34 +0200
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
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
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
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v6 09/33] arm64: Prepare sharing arm64 headers with s390
Message-ID: <20260818104434.21865-E-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-10-seiden@linux.ibm.com>
 <868q6a1g5q.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868q6a1g5q.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: IMEa1ueMZrlC32nvzHFCVIyKKZy1uQUE
X-Proofpoint-ORIG-GUID: sJsbPXWkL5txyrH7lViHRqG7hDGsDbwv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3NyBTYWx0ZWRfX8Rf8GMiM/Kc4
 w0e+D2Xp0/VumN+HTtClunRB19xe99yR85qLj8ZMFWB+Ee2mXbjf2e45BL7dLP3gVheMYuN9S4R
 BvPS+MMHDp8lEZsyj/27jNDPnfGpepc=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a84379a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Ayp3iYQmnfg5QYcjwMMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3NyBTYWx0ZWRfX+hrzWzC7QdyH
 XBzQQyNiXCVUgK+ETBR8bAxSnmVWEQhvrOcJWqSyW9urScwDqXbgnB6OJcp0hFle0V0vZ2RxzKV
 +5XhijPyYeftrgt6eeeauPzQuoAXWVk9MTA624m1mLZ29ZEMQoccMUdOA76ZgVROTDBxDwvcW4d
 cnTEUgAe35xLBA8h0vGhW8JVPzbjg2U2nfmnEs1xPTa8KWhFssYrQ0Hzlr/NXeTfmY2qmsvOQ8+
 qHQl2BhFRtAgo49ElhSnl06/KY5FAgKSPrV/1Sq1aKiBDBSmtkt5nyxpNfHxI4KvwlolAFL9RJu
 50wv5jMAudy/7up2D+74TBbbY04WgItzSYtSuvEBLPKSpEyAa1yO7lr7w295GmPKxJRmTRRp6iO
 pGHxHZBKNZUqhanA5CdOjcGYjPlUaZoW9WtC0JjNLTO7LySeitp/nm74C+SROQbeaehDGRH+Gql
 dmpOHmI8MRv+IYyZN5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180077

On Thu, Aug 13, 2026 at 11:14:09AM +0100, Marc Zyngier wrote:
> On Wed, 12 Aug 2026 16:36:05 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> 

...

> I don't mind the move, but please add a comment indicating that these
> are bit indices for for kvm_arch::flags, as we have now lost locality.
> 
> And whilst we're at it, there is not reason why this has to be a set
> of #define, it can perfectly be an enum, as the numbers themselves
> have no particular meaning. Something like the untested hack below.
>

Makes sense. Will do that.

	Steffen

