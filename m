Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420537CD21;
	Fri, 28 Aug 2026 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933069; cv=none; b=DEONHohyqvPoeceDXIqnKaqvStYCZGkGURd9NwJMiYrGligCKcv3mRzks3Qdr4SBpBpIbA2WuXU6GXAManQHGxkq3NgJLMNXpnrK1K6X+qS0/BtgxXTqT4O7X1B7VtoZs72Kk2SCSJGBtMecVqlhRFHesE7q+DdAxff51epRAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933069; c=relaxed/simple;
	bh=YdHURS/OkStZN+lDVntHsnIayXRryLL9rVY3WqT0oys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVzrUO51OmiK9IK2micI5LGcVdMEfvcQL6Vhw/qwjWOJUAn8wcUJHOPqUJs3rA8g68lizcUwn4YBFVd/jYcVmvxa/89jdFdXWV9EXmD6y80wh5nl6uKONavyQ/2eeHCEIro8Dq8HbQDGqdv/qA7LQeZW1T8rtaxbqfr5r59av4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pnXUkCN3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pnXUkCN3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVcqL2186123;
	Fri, 28 Aug 2026 16:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dgH8c3K41onSn3JaUmFd6PfY9U5p0W
	8ii5soacR13YA=; b=pnXUkCN3smJhN/Xhj5/T4u6z9CmxFA6JvwVrwTGjBe7was
	MRFrmBoZlfHDK3LEBqiGCRc8KhDZ/bWew5u6BLLdP1uWbtWwlgRiTLGjP6KJ0r4X
	q0jppp5CVV8p+DN9U6k9mkJN0jZuiAhIIfT4d9RDxZ/VFQDCbg2Qsfo5vQGChg+6
	OEm+x98MEZhiHQ0u3aCcYeX6lLoAWR65O3cbbntx90rz4r8RqEr9QMZHelbtRUsH
	QvNeHYBSOnHJNFuCMiPW1rQLyTvnaJHDGGWLZIOV2bPqiXP59W3Z+RfTQu0tWdT8
	I8trrYyI2z4NV8oYxJ4Efb5fj4KfoVmtT5XTltNw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxw67a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 16:04:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SFuHKM028232;
	Fri, 28 Aug 2026 16:04:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyq33d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 16:04:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SG3v2M28508426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 16:03:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C8262004B;
	Fri, 28 Aug 2026 16:03:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE2720040;
	Fri, 28 Aug 2026 16:03:56 +0000 (GMT)
Received: from osiris (unknown [9.111.68.102])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Aug 2026 16:03:56 +0000 (GMT)
Date: Fri, 28 Aug 2026 18:03:54 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
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
        Ilya Leoshkevich <iii@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v6 28/33] KVM: s390: Add basic arm64 kvm module
Message-ID: <20260828160354.164752-A-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-29-seiden@linux.ibm.com>
 <a90009dd-d4eb-427d-b23c-23bcc19af478@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90009dd-d4eb-427d-b23c-23bcc19af478@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzOSBTYWx0ZWRfXxZjSXhp3nkOk
 y7KNrDuosG3X05DSyEWfW9Q0EQdVJ/Mmkf87YXU6yB+cI234f2wsHs0FCGXZo8lmx7gT7DIPSIT
 EV+vXHWoy2Qf/BT+85mlM7La/cOm7pg=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a91b172 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=GjRpCgEQHAvZYWd-grkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: lxX3HICFKqkj1nkyoBdOLCFKkY1MzdX5
X-Proofpoint-GUID: zBAItN-4a0Pfu2NxxPon1fOrObeMNtcw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzOSBTYWx0ZWRfX5/Kh0Zsnk+Tw
 7qfXF31QN8c73e83tylqE6SvfujuHTVzvUlSaqusvmw/QHy7o8JCudslqRQ1CsxIDrU60UTTA0a
 ThoIS4/ftcbdln79cNS6loGg0kQ7j78LZfRr+EmJvUqXsEmfy1+6NVPwl8r9APyIVUyxnK5rXLF
 oCxChN4UZ4DiV7h+cpGhOefVRH+Leg3r8mE4U3wy1AfoOYIbAVH/taWO6kYMcqyH1XwL1b4q7ym
 iq6fWeJtHcb/tNW17xtP/aUVluFaSP9/9CNw/0ZV2CWmdwCbK00RhONeVvBua+hSoTom92l0iiz
 Tjkd5zANSjQ6DnFCM0iBZ52HC+U8wxu6D2+HdBg/N3OlrttSXupKLwAZSlgLei9OSpsLRlNSutB
 L9UwewKVabT85N8UE7/yEOuy0DC6C9V10oNe1C4ZW1wQ8uluQ5zxK44HcTgB+4Q+IE+216Wxgy9
 OcwTXbjpXjHtrM//kAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280139

On Fri, Aug 28, 2026 at 01:33:00PM +0200, Janosch Frank wrote:
> On 8/12/26 5:36 PM, Steffen Eiden wrote:
> > Add basic code for the new arm64 on s390 KVM implementation.
> > Add kernel module boilerplate code and trivial functions.
> > Add tracing scaffolding.
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >   arch/s390/kvm/arm64/arm.c   | 157 ++++++++++++++++++++++++++++++++++++
> >   arch/s390/kvm/arm64/arm.h   |   7 ++
> >   arch/s390/kvm/arm64/guest.c |  92 +++++++++++++++++++++
> >   arch/s390/kvm/arm64/trace.h |  18 +++++
> >   4 files changed, 274 insertions(+)
> >   create mode 100644 arch/s390/kvm/arm64/arm.c
> >   create mode 100644 arch/s390/kvm/arm64/arm.h
> >   create mode 100644 arch/s390/kvm/arm64/guest.c
> >   create mode 100644 arch/s390/kvm/arm64/trace.h
> > 
> > diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> > new file mode 100644
> > index 000000000000..8e17b7eef813
> > --- /dev/null
> > +++ b/arch/s390/kvm/arm64/arm.c
> > @@ -0,0 +1,157 @@
> 
> [...]
> 
> > +
> > +static u64 kvm_max_guest_address(void)
> > +{
> > +	u64 max_addr;
> > +
> > +	if (sclp.hamax == U64_MAX)
> > +		max_addr = TASK_SIZE_MAX;
> > +	else
> > +		max_addr = min_t(u64, TASK_SIZE_MAX, sclp.hamax);
> > +	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;
> > +}
> We're sure that the MSLA + 1 - MSOA > MGPAS check aka VIR code 4 will never
> bite us? Or will you touch this up with the qmc support?

Series 2 with qmc support will in addition verify that the maximum guest
address is smaller or equal to MGPAS, which is calculated from the
PARange. MSO is always zero, so we should not run into this invalidity.

	Steffen
