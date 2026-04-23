Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFADF3DFC63;
	Thu, 23 Apr 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947206; cv=none; b=oKtRMbyp5VEvACaGmaVPOQ8q91STG2zXT0V6DJq74VjTehP2OABWn8Ob2WCbLDCviAPt7jCx75LOEMRkgMNu1Rl5C2zOXss2CBqO5Z+ijvwRj4GYlzSFz/9G4xV1NvyPNitWtinAEhluOL1tS3zhxurcW/zDKbXIwR9G7j+jNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947206; c=relaxed/simple;
	bh=/Um/TRudrQAUQ3oqVng10HlOBulX1yUwOfAfxz9Jv+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Njm2+AWcXRYTFEX5RdiEMazLDNB4xoU8GAMSPyD9HnrloLyLfmpb4KyRtFJQLyDOYDVF7+zr/7MqO2CAlpsLuIpSkRDoAG6fF1EoyKMDKrbuNiTxKVPIwZEtaaAaZMZARONcxDC+Xo7tLOOaqq+bdVnfo9Qnys62vmp2fe3GVtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=koTLLeMM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="koTLLeMM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6BWVx3292235;
	Thu, 23 Apr 2026 12:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aW9kFp
	bYfmm+Pfdk+tU7J0hZ4IrRtXVJ9AFMZP5miZg=; b=koTLLeMMUt2SU6+20F3JTu
	PQDlSp89U88qcIwq5vBjfYSKI/mj19KWA/VGwz5Ofq9p01talQjvKrIOOIrt+VXU
	00VVgRkFb3MhowKs6Q0zp1T4vDJQgQxfk/FzxKXaOao3PdLfOp0WD4oypELMMn8s
	p0kFAp4VwhPDmhWsdS2+TjEaVixBglmMZCpok79MMdPiF2YKxnw5R5OpJ4xR70sW
	1ZLFlW2QoISUqGmNzHzAkCvEoQRDZY54H6fMbJ1FrTAtQxAEzH7DVwccsbIqb+E0
	xyp7pkoDvj90IcfmS9IXgA9xNIR1eXHowunw3w/DdNxFnAm0RWfA9Q3sqWm3TlPg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrfxrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:25:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NCKjT2004855;
	Thu, 23 Apr 2026 12:25:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky6ht7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:25:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NCPpWN52822418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 12:25:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4661A20040;
	Thu, 23 Apr 2026 12:25:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E11882004D;
	Thu, 23 Apr 2026 12:25:50 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Apr 2026 12:25:50 +0000 (GMT)
Date: Thu, 23 Apr 2026 14:25:49 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v1 00/27] KVM: s390: Introduce arm64 KVM
Message-ID: <20260423122549.361343-A-seiden@linux.ibm.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
 <86o6jd2925.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86o6jd2925.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zt3vVpbTZ3JZw269VpArRys1HjMYrHP_
X-Proofpoint-ORIG-GUID: Zt3vVpbTZ3JZw269VpArRys1HjMYrHP_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyMiBTYWx0ZWRfX6YnftMIcDNxa
 wwFbAB0x9MfljTMrRWnKYkTVaPODu5cjtZ5FML8uAPElYQi+1tllK8iBD4CBGvgJgPu2hq1g2i5
 90G8z2WezjZpCZjmyYJ58rv68j/gWD+crzxP3kRgPrYAvkIqAHY5RA+AGsm0SB32eONz/nBd/un
 y3rKxfhKyERqDNpldIi32mcvMjKcOcoFeooXXs6pQU3HEtAazYh6QoveAC7gVnd6k6PiBG+51GG
 GhS61h4MszQ2lr+taVtyK4nkDiTp1dOCVI9xRmtqTN49Bzils3WeKH3LoBaL7Mz+DU1k+voUDcO
 uU9kjYIiSbb92zPZm0DCHyk4BH95KUKXi6UIWqOSSLQDzxrtQl8s523Zcv1YNUJNQfFMZTTOLnI
 +/BOSycC/ggQqtfrlcYz3MmhNqDW624tOunmbUv0L4rxG91mPrKsmSAR15gb0YFbvbHTPLqlUXu
 EHF5zBhMPFmct29zq3w==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69ea0fd3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=_hb7cby5UekIfOObm9QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230122

Hi Marc & Will,

On Mon, Apr 20, 2026 at 11:57:38AM +0100, Marc Zyngier wrote:

> Hi Steffen, s390 folks,
> 
> On Thu, 02 Apr 2026 05:20:56 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > By introducing a novel virtualization acceleration for the ARM architecture on
> > s390 architecture, we aim to expand the platform's software ecosystem. This
> > initial patch series lays the groundwork by enabling KVM-accelerated ARM CPU
> > virtualization on s390. To achieve this, a common KVM layer between s390 and
> > arm64 is introduced (see below for more details). Design considerations of
> > arm64 on the s390 Architecture The s390 virtualization architecture is extended
> > with a set of new instructions dedicated to supporting ARM-based virtual
> > machines. The s390 KVM host acts as EL2 (hypervisor) for a EL1/EL0
> > (OS/application) arm64 guest. To achieve this, the new Start-Arm-Execution
> > (SAE) instruction enables accelerated execution of arm64 VMs.  Additional new
> > s390 instructions aLre introduced to query available arm64 features, used to
> > populate the arm64 ID register contents, as well as, new s390 instructions to
> > save/restore various arm64 registers in the VM context.
> 
> Apologises for the delay in responding to this, things got delayed a
> bit with the Easter break. Since then, Will and I have been discussing
> this series and what it means for the future of the arm64 port.
> 
> By way of opening the discussion, we want to be clear that we are
> supportive of the effort. Our comments here should be seen as areas of
> potential improvement and not as rejection of what you are trying to
> achieve.
>
Thank you for your answer. We are happy to hear that you support our
efforts.
 
> * Code movement:
> 
>   The patches you have posted demonstrate that it is possible to
>   expose a large amount of arm64-specific code and definition to s390,
>   and yet still manage to build both architectures without regression.
>   However, the result looks rather messy and may adversely affect
>   maintainability on the arm64 side.
> 
>   The moving of files into shared locations is particularly painful,
>   and gets in the way of overall maintainability. Not only does it
>   break our comfortable habits, it makes the backporting of fixes
>   harder.  Importantly, these changes come with no benefit on the
>   arm64 side.
> 
>   Would it be possible to try some other means of reaching the
>   arm64-specific files *in situ*, either by making use of relative
>   paths, or by using symbolic links? Even better, files that are
>   generated on arm64 (such as the sysreg definitions) should equally
>   be generated for s390, locally to the s390 part of the tree.
> 
Yes, we can do that. Our first iteration had an extensive use of symlinks for
headers. We feared that this approach would gain no big support as it was
quite messy and gave a lot of surface for future errors. So we moved to the
current implementation. For the non-KVM headers I could see moving back to the
symlink approach to reduce the backport & maintainability burden for you.
Preferably, those headers are kept clean of any arm implementation specific
things (e.g. sysreg vs sysreg-defs).

For shared kvm headers and code, we think moving them to the proposed location
helps reducing regression issues when someone changes a function as that
location makes it 100% clear that this is shared code. Tagging a file 
as __shared__ by other means (e.g. by a file name suffix) may 
be OK for us as well if that reduces your maintenance burden.

The generated (e.g. sysreg) definitions are already generated into the s390
tree:
{outdir}/arch/s390/include/generated/asm/sysreg-gen-defs.h
We just reuse the makefile definitions from arm.

As a side note: We tried to reuse as much arm code as possible - to not
reinvent the wheel - while keeping the arm churn minimal. While going through
the arm code, we tried to spot parts that could benefit from refactoring and
did that. By moving especially the kvm code to another location we wanted to
emphasize that this code is shared between arm and s390 and possibly other
architectures in the future.

We will prototype alternatives including using symlinks and post them soon here. 

>   But that doesn't mean that we consider that the arm64 tree is
>   immutable and that we are not open to change, quite the opposite.
>   Most of the KVM/arm64 include files are an unholy mix of arch
>   definitions, data structures that have some arch relevance, but also
>   code and data that is strictly implementation specific. Splitting
>   these (as you already have for some include files) could both help
>   with sharing what is actually needed, keep the arm64-specific stuff
>   at bay, *and* benefit arm64's overall maintainability. We would need
>   some tooling to enforce the split and avoid regressing it, something
>   that could happen quickly given the level of activity on arm64. Yet
>   another way to achieve this could be to mechanically process the
>   arm64 files as part of the s390 build to extract the relevant
>   information, and we could help with this.

That is good to hear. We of course also wanted arm to improve with our changes.

> 
>   Looking a bit more into the distance, it is likely that KVM/arm64
>   will grow feature support quicker than s390 can absorb them, and
>   that some feature won't ever make any sense of s390 (pKVM, for
>   example).  We need to establish how these features can be built
>   without arm64 being hindered by s390. This is also true when adding
>   architectural support for features that don't exist in the s390 view
>   of arm64.

Yes, of course s390 should not hinder arm64 to progress. 120% agree! We will
be available in case that happens. However, I do not think this is a big
problem. By defining some arm feature macros to false we already did turn off
few arm features for us at compile time. Compiler optimization is a very good
friend here.

> 
> * UAPI and guest API:
> 
>   Obviously, one of our biggest concerns is the userspace API. We
>   appreciate that you want to reuse it as it is, warts and all, and
>   directly incorporate additional feature support as it becomes

Yes, implementing the arm64 kvm-UAPI was one of our primary goals so that we
can reuse existing arm64 VMMs e.g. Qemu.

>   available. This means that, should any divergence in UAPI appear,
>   the source of truth must be on the arm64 side. This has the
>   following consequences:

Yes, arm64 is the source of truth for us. That is the exact reason we did not
copy the (UAPI) headers but moved & share them.

> 
>     - s390 cannot add extensions to the UAPI
> 
>     - s390 must be compatible with all future arm64 extensions
yes
> 
>   Similar concerns exist on the guest/hypervisor API, including:
> 
>   - errata mitigation: this is unsurprisingly a hot topic, which keeps
>     causing us some massive headaches. We are particularly concerned
>     about errata that need to be disclosed to the guest and acted upon
>     via a hypercall. Should there be a need for those, how will we
>     coordinate the deployment of such hypercall?
> 
>     The way it has been deployed so far is that PSCI has grown an
>     errata discovery mechanism. ARM assigns function numbers and
>     specifies what these hypercalls mitigate. KVM, in turn, takes part
>     in implementing the mitigation. We expect that s390 would follow
>     the same behaviour, including coordination with ARM for the
>     function numbering.

Yes. s390 will follow those things. We are planning to reuse the complete 
arm hypercall code including the current (and future) errata detection that
comes with it.
This change will come in one of the future series. 

> 
>   - device assignment: this is unknown territory for us, as we
>     commonly use vfio-pci (and more occasionally vfio-platform). How
>     would that look for an arm64 guest on s390?
> 
We plan to work with virtio-pci and vfio-pci. No plans to assign ccw devices to
 arm guests.

>   - s390-specific ISA extension: although we obviously cannot control
>     how you will decide to expose features to your arm64 guests,
>     KVM/arm64 makes a point of forbidding any use of implementation
>     specific instruction or system registers. We expect the s390
>     implementation to uphold this.
>

We have no plans of using private ISA extensions or deviations.

>   - s390-specific hypercalls: aside from the errata handling
>     mentioned above, we would very much like to avoid anything that is
>     implementation specific, and keep the hypercall space as small as
>     possible. In other words, an unenlightened arm64 guest must work
>     and continue to work.

Of course an unenlightened arm64 guest must keep working and it should
work with good performance and usability. This is another primary goal of
this project.
Given that we have some history of paravirtual optimizations on s390, we 
might propose some hypercalls in the future. But this will then very likely to
the benefit of all arm platforms and implemented on both host variants. 

> 
> * Overall maintenance
> 
>   Unsurprisingly, we are not totally familiar with s390. To say that
>   there is a learning gap would only be an understatement. So how do
>   we make sure we don't break things out of pure ignorance? Is there
>   any documentation we can refer to when hacking on code that will
>   eventually run on your side of the computing universe?

I am aware of the Kernel Documentation for s390.
Also, for the z/Architecture in general:
Principles of Operation might be a good start to learn about s390 architecture.

Of course we will be available for answering s390 architecture questions. 

> 
>   We need to be able to build and test what we produce. How do we go
>   about that? We appreciate that you may not be in a position to help
>   with this right now, but at least having a plan would be reassuring.
>   This should include things like automatic testing of our CI branches.
>   We are happy to test build s390 as part of our maintenance flow, if
>   pointed to existing binary toolchains compiled for arm64 and x86,
>   together with a typical configuration.
>

For your side:
Cross compiling the kernel is a good starting point. GCC/Clang cross compile
toolchains for s390 are available on all major distros. They are typically
postfixed with ‘-s390x-linux-gnu‘, note the x after s390. defconfig has KVMARM
in it - this should be suitable for testing you do not break s390 compilation.

You can get access to s390 resources for doing native builds in the LinuxONE
community cloud. Those are VMs itself -> run tests are not possible.
https://community.ibm.com/zsystems/l1cc
They also offer permanent access to OSS communities if necessary. We can help
to connect you with those teams.

Another option would be to spin-up a s390 qemu-tcg guest to build the kernel
'native'.

For us:
Yes we are planning to do regular tests to prevent breaking arm. Testing your
CI branches seems to be a good starting point for this. Do you have a few
pointers which are suited best?

>   What about debugging? We expect that you'd have to help, should an
>   arm64 change cause a regression on s390, as it is fairly unlikely
>   that we would be able to reproduce it.

Positive, we will do whatever we can to support you in any way.

> 
>   Finally, we feel it would be beneficial for both projects to swap
>   prisoners and have cross-reviewers in MAINTAINERS, so that there is
>   an s390 reviewer added to KVM/arm64, and an arm64 reviewer added to
>   KVM/s390.

Great Idea and I like the wording :)
We’ll start with the exchange. I (Steffen) would volunteer to be sent over to you.
I will add myself as kvm/arm64 reviewer in v2 of this series if that is OK for
you.

For the other way we appreciate any volunteers and also will ask around for suitable
people with arm and preferably also s390 knowledge. 

> 
> It probably would be beneficial to work through some of these things
> face-to-face. Maybe around LPC or KVM Forum if you manage to get
> there? Or some other place/time?

Totally agree, although I would prefer an earlier date (probably virtual) to 
get rid of any serious misunderstandings that may be there early. 
Surely, we can meet at LPC and/or KVM-forum as well to discuss even more.

Thank you very much for your openness and your constructive, honest
feedback.

	Steffen & the KVM/s390 team

> 
> Thanks,
> 
> 	Marc and Will
> 
> -- 
> Without deviation from the norm, progress is not possible.

