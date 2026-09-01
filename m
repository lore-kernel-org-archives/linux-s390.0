Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B4D35DA40;
	Tue,  1 Sep 2026 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255015; cv=none; b=VryyJWqcKyVBdjud4SGcKBfazR1infpbfCQwrK6I1Ybcde/1qlDz8XKWXhKWOSrrVvqnWF4PF7/tiDUaBOXjIw7Axte++O1L8IxKg2lriaq3ZofVRJCaqLlFfLgQjMSwfEAGaV75+RejmDJJ+4SH3SWp2+2IJS1gd3/ybSmAVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255015; c=relaxed/simple;
	bh=YF4qIttUj7lB4ltQZ7NC3u47Sx1QTjxtKc0N+xtbcJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am3s+Fkuob+7GEUBeAocRhg7mx+Lfw9MuFNVEo4YIXHoY3X2Yb/YRplemn4Df47guN0wCa90hCV1aDkUQv4+o+Abum8fuQnF29xgyDDfxfAe9Q7wyMdIdCyJjvk+C1iSw59ibTOHJVaTZCqxn7f07jmcfPRMpV8eT6BGHtdPU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AcuExZw4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AcuExZw4"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6817VbEY571790;
	Tue, 1 Sep 2026 09:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+sKj9tfk0MoT+Ht4idfi+B4AA+MZbQ
	ZunBLDDUvonyg=; b=AcuExZw4wZOM/HI1rB01RDPx3MvdEoAXlAqwCE8Y1J1CqE
	ZcgyGZN1ZzaFaa0h69XGUB+Vb68mPgJatftcHhPPYfcq5xQEnZO2PpxLXjAzto7q
	FpBZJI8/3wffsW3FnsiNOG0w408QzTfAk1s4UU1N8Dl9P1y2oKydxb3zzLx758S1
	3Wl+GJMnU5lLEJPfn9GgV8mf8elFn9iPrdtA54ELzqIPEkM9pr+2Ta3GDUZRUGi3
	ZseorKeETxe+sVAuiWjn+PniUnGZGosDNEPjRwKgGqTw0RcSMswPBHG5MW+TQ2fa
	zkCxlw+MSNNWCfarafeCHUVotrZeG6EDS8BgmT3g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54pvqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 09:29:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6819QHef031734;
	Tue, 1 Sep 2026 09:29:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4w2yfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 09:29:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6819TfSZ52101544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 09:29:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0C6C20043;
	Tue,  1 Sep 2026 09:29:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 881C120040;
	Tue,  1 Sep 2026 09:29:40 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 09:29:40 +0000 (GMT)
Date: Tue, 1 Sep 2026 11:29:39 +0200
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 06/20] KVM: arm64: Prepare sys_regs.c for sharing with
 s390
Message-ID: <20260901092939.231001-B-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-7-seiden@linux.ibm.com>
 <87pkyxmllo.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pkyxmllo.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4MCBTYWx0ZWRfX3NNLjMYJhQ+J
 PnkgXgDqjQ1zxC4Bt6UNbZzX3j0VLFEccbfJv3P8M4jb/Tq4s+12WHC6SXEAjdFpBdvI4ZQMXcm
 Bs2zdsITSvdZsAAJ+KI+T5lGiCs3Jg28Zgk+zhGCaWcQsyUWAM+GWIv0FfdbP5qrNEyfKWyD624
 uipG0junOfsNxnAD8xgqmO+1bNCyT91y/cDryTGh1ewwadm1L5XHc9GqTHXHzT+4CmemVKXFQLW
 zbeZomwA4GrwwhKv5eNcfOA7YHSj+RKzU1iQqshARnHiS+m3LEDRdm9ev/bBRN1IAsj1uteovvh
 HRu4UvLlJsMOTSP4nZRxKsy3vGL+3omJK20bd4QbclOQ1joALrvkpqbfjl9cMbjs99hUTMr8Nea
 5R0at1wEGqkX4bOzUQ6dC5jQfIKEaOLwomSfq/AajQXsmJP5ADaTJeJoTf1k5yTh1YKdU/AtWIe
 vZ06EUKL1eO2SLvysVQ==
X-Proofpoint-ORIG-GUID: H4c5ZkYE78F1AmN4S8l17S6U7m88SXt7
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a969b12 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=1oIFmkYgyMm4aX7jZ7kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: NfZeEAY2368YIHjJlXmBcv7hal8unP-s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4MCBTYWx0ZWRfX9vWOsXm0TQLz
 TDF3fY931hSxqwM8gW1F/5tul3x29Pg8lGGQWUh3k3B7zP9+pqCWKaCbC1TCcBV56OQSMHsOPxU
 DpsqHf7C+M/7NOPRaJvmuk/sIJWMUHU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010080

On Tue, Sep 01, 2026 at 09:17:39AM +0100, Marc Zyngier wrote:
> On Mon, 31 Aug 2026 15:55:21 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > Prepare sharing of sys_regs.c with s390 by moving functions to another
> > location inside sys_regs.c. This reduces the number of shared regions.
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/arm64/kvm/sys_regs.c | 100 +++++++++++++++++++-------------------
> >  arch/s390/kvm/arm64/arm.c |   2 +
> >  2 files changed, 52 insertions(+), 50 deletions(-)

...

> 
> Please split this. arm64 refactor and S390 changes should not be part
> of the same patch.

Sorry, this was a mistake.
	
	Steffen
