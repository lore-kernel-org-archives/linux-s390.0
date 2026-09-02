Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FC49B1E1;
	Wed,  2 Sep 2026 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352945; cv=none; b=VBOR3xenYze33hv2abvzUicVzJ6oSbXwv9+AFAC/mu9GP3w4J0cbc5VLUAel2I87B3q5eVuy1uitZ9NEkVF7+s7u/c+hzTnMdk/j+QhvsNyfV9qwtAJLaWg34+Gk+tPAq7Bdfb+0nsS1nvC7eYmIshjJv1zjRP25L5YgE9Uu4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352945; c=relaxed/simple;
	bh=ya4i825jy1XPAF9fATyKN3huP2HorW90joM+TUQYcSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9wgvc1yn0/0P0UtTeCOv57IjMVb6/wKl5nQEP3Q1vapXHYsk4l34Pe3OLsj98whJRN4wGjnU2ovMvg/xQO1rTLnCO3GfhJ+qCGvdQnIVOfGgi00wAJzUHRvrSI5e/N94Ak8PHHlyFoV/z/40rkRXEEC5SOb8Bek1gtyIVMd1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uo0XEpDa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uo0XEpDa"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CW9uD4190243;
	Wed, 2 Sep 2026 12:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dOiTeKWuwA/odP2KKwquW501Owf+f4
	0tpwUxcpypkzw=; b=Uo0XEpDaaD6nlVgE2fElH6ZgG+3RUypgOIrmp0cKzeHUfL
	DpbWsa+zm4Mji+bX5Y3KsfZXOnpdPexKhOMGVwMZw8ozXimnBv8pISe7tDxjlaQg
	xcHmG8GbNoeuYxlxUvk/CeMjIJ3YPgaB6Vm4RJJZ2FOirqc/hM4jTed/SjK+b3Dt
	LaS3RI0DKYyqtCOd2fWDCCC+vOSBpMC6M0KHOZsgGXJmT4MaiRFX6oZAg3Mw7/+6
	Y9c9KjqZZvmF/ES9bfZ8M/i2Ez/NhYtUgly2JHznafPkXaCa9D+Lq81M35WuVrns
	05E6jZAXZsqrb4GJQVAgo7YiNF0XwV02JT8dvdrQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5pe54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 12:41:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682CfMji008248;
	Wed, 2 Sep 2026 12:41:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjaj11k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 12:41:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682Cfsuh50331914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 12:41:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3CA82004B;
	Wed,  2 Sep 2026 12:41:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82DFF20040;
	Wed,  2 Sep 2026 12:41:53 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  2 Sep 2026 12:41:53 +0000 (GMT)
Date: Wed, 2 Sep 2026 14:41:52 +0200
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
Subject: Re: [PATCH v7 11/23] KVM: arm64: Share arm64 code with s390
Message-ID: <20260902124152.438647-C-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-12-seiden@linux.ibm.com>
 <87se3tmlrv.wl-maz@kernel.org>
 <20260901084037.185345-C-seiden@linux.ibm.com>
 <87mru0m76g.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mru0m76g.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a981997 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=SYUwwzt97VIMazuNbKEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 6MjRUIWDIBt7iTZF9TiEC9Hdb4wCliq7
X-Proofpoint-ORIG-GUID: A6X86a91-zHRIEr2PDnZe-nHUUowbUAo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDExMSBTYWx0ZWRfX4Xd2aYS3gxXi
 TH9hCVoNES6hfFUJvnS7uX+oG0mTVmrsR+VcapYhsPjjuWkESTikaChjUYFVdtDakjTUoqdpBhr
 Ni+EkDCsBgUNCT+NyL5bnGEjSjOP6fY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDExMSBTYWx0ZWRfX4lpUgbsqkGlp
 pDNb4lKIS4w4mGoyrFkEwNBHyPgLAox/7ehHPfVu7RE5Y+aYlH6BV6n1tTkAFUvbTQ5Ek0/KIro
 1nBBtPq4ZfqyFKIXE14VrXqjdsGtsDR9E1vJqnvtjhkliY3n+VyURi+05R+k/I2cpnm9DzzRdN+
 iy7nj+v43x/fWlLv4uMFarTUObQLMss/S9T+2A7CNqRLlyRi14XTuiz2jxKP2jEu9GWWptMgs5f
 L34EoMGb+MCvBLuKJTNAExbFCermDog5UBHGUkMPzMsjmXxp8fEU/fYEtVzkgjNOUf7Nih9XQeX
 0lS0LrrYc9sCel/bQmiPAhyM+Tf5lguZlWo5La0blS3q+ezHK1SzbJv/A+HOx+/UbXDNMdkuY2j
 kd/jWIqjYPu8oov72HAtBpMApuNW5EPiQbDKxO/Zt7vuefAhqqjhcERDDHSGRra/gonOoyHj5Ro
 YJ+pP943TrBTt5zySxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020111

On Wed, Sep 02, 2026 at 08:41:27AM +0100, Marc Zyngier wrote:
> On Tue, 01 Sep 2026 09:40:37 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > On Tue, Sep 01, 2026 at 09:13:56AM +0100, Marc Zyngier wrote:
> > > Why the exit handler, and not the EC handlers aside from the UNKNOWN
> > > one? Yes, you probably aren't there yet in this series, but I can tell
> > > you are going to add more and more of these.
> > > 
> > > But the EC array is absolutely architectural, and there is no good
> > > reason to maintain your own.
> > > 
> > > So instead of this, why not keep the EC array altogether, and
> > > implement stubs for the ECs you don't support?
> > > 
> > > 	M.
> > > 
> > 
> > There was no specific reasson to define our own EC array as far as I
> > remember. I will try reusing the array and find out if there are any
> > issues with that. But I do not expect any. 
> > 
> > I assume the stubs probably just forward to handle_unknown_ec, or do you
> > have a different suggestion?
> 
> Probably. This is an indication of something being deeply wrong in the
> implementation (HW or SW). On reflection, kvm_handle_unknown_ec()
> should result in a KVM_BUG().
> 
> 	M.
> 
> -- 
> Jazz isn't dead. It just smells funny.


While I tried to implement the change I noticed that it might be a good
idea to share most if not all EC functions defined in handle_exit.c
The handling is architectural as well and s390 and arm do (and should)
not differ in their implementation.

But switching stubs to a real shared implementation is not possible if
we want to not mix up changes in arm64 and s390 in one patch. I.e. in
one patch expand the shared region and remove the stub. But we would
neet to do that in one so the (s390) kernel keeps compiling.

So my suggestion is:

For series 1 (and 2) s390 has its own, local implementation of
handle_exit without sharing any code with arm64 in regard to EC

When s390 has all the relevant code available (likely series 3) s390 can
switch to using most (if not all) EC handling code used by
arm_exit_handlers implemented in handle_exit.c.

This can be done without a mixed patch:

1. Mark arm64 handle_exit.c as shared (roughly the first 400Loc w/o
   includes) - s390 will not use it after this patch.
2. remove the handle exit code from s390's handle_exit.c and include the
   new generated handle_exit.inc

This approach brings us further into the share architecture not only code
approach you meantrioned in the comments regarding sys-regs. (I or
Andreas will provide a solution for this later :) ) 

Is that OK with you, what do you think?
	
	Steffen
