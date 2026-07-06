Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF2422548;
	Mon,  6 Jul 2026 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339128; cv=none; b=iCtA9FIUFIYn67y71jGQKdxibV42y/krsu8TAibhRqU9eri2SO1PQ3YDwf1ZWnr/2Lij5BBSV67Ky93A78Iha7u8D27NzqsttJSeKxchoPYKSW0HTnXiXiSxbmklrG8YceVJzzqr5yq/t+MupKKOaXrDhJWu7mNYo2u3HhcI6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339128; c=relaxed/simple;
	bh=nEXi64q5a1wrNnASTARi80cobxBLMIzpl0YhDo40VEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ysq4BUbnB9tXtpObGOBjqsrkYjZpuKRwnhcnYQvrhvyQrmCPGhk+3eeFrhknW03mUuewVU3qjjDfcuD82c8/KbclZlr8mqCUGx2V3jbNx/Bh+7+qjU4dsL+T5DpEbTh3UI20Zt4IubAjOws6s8cmS6TRF8bD+Lv4begCM+AWkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i4sWTmK5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i4sWTmK5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIMoU041179;
	Mon, 6 Jul 2026 11:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tj+23o
	ywlRnO3Y+5JLlSRU3ga/eLwNTnH+xgyNne3Vw=; b=i4sWTmK5+VR1PoSNWVxdXk
	rt3DjDXyMiiQHiL4kHX7+684aNXrXz7widiZUazpiQWgknYy+n/n1JrWaK0Yvuhr
	Y6tVWr6fXpXboiNPwJ0PFQlk+CV5XPxjW6m2Xp2lQ/1th8V8JBDZbKPRJS8/RW7d
	qr57Q9L6koRqaEEyJifvLzjL3XnQPgTb+RqASci+BBQts9GORDQY08sQhGwF4BLZ
	g2WOLF5x2nI6cmFQ3/QgohjIWhe/R31KJ3PJWN0E4DxR9dMnDM3hqk8I7mOsy74J
	CabeMyYHsdnYaOjWu/1MmJr4LTj4DYY43FAh0wuiRo8VHdzaNqTt/H+m6xTgsbKQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn9b92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 11:58:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666Bnbxe016482;
	Mon, 6 Jul 2026 11:58:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvwjr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 11:58:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666BwKEX45941006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 11:58:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 257152004B;
	Mon,  6 Jul 2026 11:58:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23BB120040;
	Mon,  6 Jul 2026 11:58:19 +0000 (GMT)
Received: from osiris (unknown [9.111.31.209])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jul 2026 11:58:19 +0000 (GMT)
Date: Mon, 6 Jul 2026 13:58:17 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 19/27] s390: Introduce Start Arm Execution instruction
Message-ID: <20260706115817.104396-Q-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-20-seiden@linux.ibm.com>
 <8239c9ba-154c-4e2d-b2fc-700ba12eb585@linux.ibm.com>
 <721266da-db8f-4385-87c1-ca26c430892c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <721266da-db8f-4385-87c1-ca26c430892c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b9864 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=FTWlFeZUYPafzdOhfvQA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: P9k7z7Z_-LJ633J5h5ZAbGS_1o5NSp29
X-Proofpoint-ORIG-GUID: P9k7z7Z_-LJ633J5h5ZAbGS_1o5NSp29
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyMCBTYWx0ZWRfX86pjNKnjcEBv
 O1NRzWszvfaa3PA8qtTL/+y+PePzWaM1r8x16LoGaPRLdmAwbVhoI1m8XgW6n8wlRCI37pP8985
 Ji6iI1DvV2kxFN0JUtdutIAez+z40DI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyMCBTYWx0ZWRfXycyknJwSF+9d
 s22nUFQOtFXZ6AmwRN0W9n/PRaxHVLXKaEcPYiJzNb64Y8UZMRBRgKfFSKLfkgvGQZedtR2/pB2
 +1UiEhzN/Cr7ghUZaDXkLW3x1T+RVzpLgAlvSLu2of4XBOOkKTZGw8YN1Wq04aRSDI0+o6CcgcF
 Lf34IY3kmhxg2vnKd2rMECRSgqqxyXC5hU4iR5xcUT0XlLZuOQWXpoAW8u+1d8tvGGOU9aIS4k/
 Q21n45b2zSEqlc9iU5x6SYbFsyd4JB5A6MT4WS9WMMt74mZLhuOVUC+W7JLdH3UfLpHZ8SqjEsI
 CGcVQq4iJji2cBRtqu5OWKQGiIjS0lCAUmrNknec0vDk+8M6I8dFqCjYg+R3L3az5RpMf+Vw3xn
 p2xckP5k+7TSqORnSLYGyka9/CnIceFidfl3WJ21jlOfj/5ij9r2NuTzr8oN9vPEKm4gOcEmAOH
 26Qq12rBNLKJclH+PaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060120

On Mon, Jul 06, 2026 at 01:30:20PM +0200, Christian Borntraeger wrote:
> 
> 
> Am 06.07.26 um 13:17 schrieb Janosch Frank:
> 
> > > +SYM_FUNC_START(__sae64a)
> > > +    stmg    %r6,%r14,__SF_GPRS(%r15)    # store kernel registers
> > > +    STBEAR    __SF_SAE_BEAR(%r15)        # save breaking event address register
> > > +    .insn    rre,0xb9a50000,%r2,0        # Start Arm Execution
> > > +# Let the next instruction be NOP to avoid triggering a machine check
> > > +# and handling it in a guest as result of the instruction execution.
> > 
> > @Christian:
> > I have the feeling things got lost in translation when this comment was written.
> > How would we trigger a MCHECK by having an instruction after SIE/SAE?
> > AFAIU this allows us to have a label which we can check in the mcheck handler to decide who triggered the mcheck.
> 
> the original rationale was that some machine checks are nullifying some are terminating. So the PSW might point
> to SAE or the instruction afterwards for a guest machine check.
> In SIE, we use that nop to account any machine check on that nop as a guest machine check.
> 
> > 
> > Without the label the comment and NOP are useless as far as I can see.
> > So we need to decide if this still applies and then either remove it or add sae handling to mcck_int_handler and maybe other mcheck functions.
> 
> We plan to get more information on the machine checks for sae so we might no longer need that.
> But this series does not yet contain the machine check handling. Maybe its better to remove comment and
> nop and introduce that later when we add machine check handling and if still needed.

Ok I'll remove the comment and the nop for the next round.
