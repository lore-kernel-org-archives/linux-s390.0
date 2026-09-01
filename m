Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D063B14D1;
	Tue,  1 Sep 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272761; cv=none; b=lJCuJEs1HimesrGnkIcjDKJlkmHVXQx7WnisBe0orjh8vn22foP1OaPZqi+xFtcHqJ+tjFgBuKUnu9v+/DB3fNGFbAAF+M3tJkg4fSOg8A0oKVB8WK2yB51E1v88FO6ln7j0sDBl44uM2MCV6W4rKwMHJdcS0dQkec+/K4N3768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272761; c=relaxed/simple;
	bh=LOTCQsOY3jSCnGN/hhjKW7agRKqthDpdG20/R1oZR58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1iSw4PHpMldT0KCij8GH6bk2DTuimHaM7FfBp7tAFC2wCsC8KD21cM2wlAr619tGVGabk/mwxZu+Ge9ME/nClmkLKpH9R22xdzwQy66bQf/y2mfOK4UCN4Q4UmIcCGlNYL6zLJEVlhLaTcwx70htkiEE9j/rAAIU3Q1fCES3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T7/i7PwW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T7/i7PwW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681DW7nt1333760;
	Tue, 1 Sep 2026 14:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+UtEPetIYbkEkW6qpX4mMtufgGpeic
	fdKvgGmBH7Gn0=; b=T7/i7PwWo6P8vr/7z+0bsP8WwsHALlmwWKlvv+bhERGQrL
	LnZzPQlrH1SaTxN6Bfnny7vz7UTI/tRjSlO9C3wFXKWU4oABDcKFLI0hroMwDrC3
	p8opmR3IwTbOq6x/g8zH7QZT6S7j/ofCb5328UNeK1s3/sWT44Bt6tr6djrr8WIt
	RT9X+fajRfh+8DU30umg1eGDkAbmQ+flnF2jJMOs4gxBhxKZ8pfi0P94D0xDEW7u
	VvR5fGyq2S5FSwPdE92WKLvGCqhWaiEZU/UGldEgwSHm5FrJGPSGGfrxCcY+PjlA
	4sM2KKZxCn5PU9hSDMMKkS9Q/NJsEwIk+cyfOoXg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5gcs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 14:25:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681EBgZa008556;
	Tue, 1 Sep 2026 14:25:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hc3dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 14:25:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681EPpV143319568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 14:25:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A45E20043;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5069120040;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 14:25:51 +0000 (GMT)
Date: Tue, 1 Sep 2026 16:25:50 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 11/20] KVM: s390: arm64: Query Available Arm features
Message-ID: <20260901142550.231001-C-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-12-seiden@linux.ibm.com>
 <20260831194654.39B451F000E9@smtp.kernel.org>
 <d6fcf081-7613-4d3a-ab62-6c4f9a42816b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6fcf081-7613-4d3a-ab62-6c4f9a42816b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a96e074 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=p5KpVjJDTnW5N_pSrO4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: mc49I7FBG0xrHGz3VQJjUctauGACZLM9
X-Proofpoint-ORIG-GUID: mc49I7FBG0xrHGz3VQJjUctauGACZLM9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfX6/oBK93Dt9LR
 txAuLkSk+bRZIh/S4A0fP5ahlvLDqPoYHoTUaM7MpKoCLNW5RmoF+MLpBvGIWSzglikErSRS3Fx
 mbiaXVxDyozoAl7fggjYeIi+r18y2KA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfX6K8rBzagABvv
 3KzyHV8As6lOiT3mhqrQ66jpH4ksjs2JmY6Z5Lt9yJGQSdw3F6Azr28n2Qjt94J05eArHGxbH4c
 8AvKdF9G525D4YRjr7rFodiCqYw5NmMygPI66S6/r62lqf95bO3Uf6bzF1SSYtPe4PjeaAi0eLj
 4+WWHBrvkxomIFAvEGUTZtkeiIPk/aYyxkgB+XOWP0p80VPsgT1pbXeLu1p5vHtRm76kTFF4DhD
 rxIKZAzJLkKk5x1QEHZOby5NI2FDCmsyvtlYmZbej6fklF1oLH7lMBGEWKc2LpA39oT+vYZr8Rl
 AxNl+68AFM6L7I6iVKRY1J2F8bcn5a1MPDeKzl1wXfw6irhwch1rwISSHRXMWvWpOozsGyk5V5F
 EICxgjuAHFi0LgXZBGTqeKTT6MpkE3/2TNIBGo66bn4NE9TWoQk+Y9cQn5ucjX61tIHHw1xaN9o
 O1NrKw/RXDo36bSZE0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010124

On Tue, Sep 01, 2026 at 01:44:09PM +0200, Janosch Frank wrote:
> On 8/31/26 9:46 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> > - [Critical] The EX_TABLE entry in the `qaaf` inline assembly incorrectly places the exception fixup label on the non-faulting `lhi` instruction instead of the potentially faulting `.insn` instruction, which will cause unhandled hardware exceptions to panic the kernel.
> > - [High] `aef_sysfs_init()` unconditionally calls `aef_init_save_area()`, failing to skip it when the AEF facility is not present, causing a crash on older hardware.
> > - [High] Off-by-two index error when accessing the QAAF registers array in `kvm_qaaf_read_ftr_reg()`, causing KVM to read incorrect memory offsets for all features.
> > - [High] If QAAF initialization fails, the global capability flag `info.arm_guest_supp` is not cleared, leading KVM to initialize using uninitialized hardware capability data.
> > --
> 
> [...]
> 
> > > diff --git a/arch/s390/kernel/aef.c b/arch/s390/kernel/aef.c
> > > new file mode 100644
> > > index 0000000000000..825e2643a8921
> > > --- /dev/null
> > > +++ b/arch/s390/kernel/aef.c
> > [ ... ]
> > > +static int  __init aef_query_info(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (IS_ENABLED(CONFIG_KVM_S390_ARM64)) {
> > > +		info.sae_avail = sclp.has_aef;
> > > +		info.ptff_avail = ptff_query(PTFF_QAGTO) &&
> > > +				  ptff_query(PTFF_QAGPT);
> > > +		info.arm_guest_supp = info.sae_avail && info.ptff_avail;
> > > +	}
> > > +	if (!info.sae_avail)
> > > +		return 0;
> > > +
> > > +	ret = qaaf(QAAF_FC_QMC, (union qaaf_block *)&qmc);
> > > +	if (ret)
> > > +		return ret;
> > 
> > [Severity: High]
> > If the qaaf instruction fails and returns an error here, `info.arm_guest_supp`
> > remains set to true.
> > 
> > Because aef_sysfs_init() is called via an arch_initcall, the initialization
> > failure is ultimately ignored by the kernel. Later, kvm_s390_arm64_init()
> > checks `aef_info()->arm_guest_supp` and will proceed to initialize KVM using
> > the uninitialized `qmc` block.
> > 
> > Should `info.arm_guest_supp` be cleared before returning when qaaf() fails?
> 
> No, we can instead check the sclp bit for sae_avail and early return before
> the assignments.
> I don't see a gain in having this information shadowed considering the two
> patchsets that are floating around. Maybe you need it at a later time?

I'll dump it into sysfs and use it in the init of kvm-arm64.

The main use is to have a single stop check in the sysfs to find out if
arm-on-s390 is supported bu the machine. The check in init is just a
second use.

> 
> 
> sae_avail is also used in patch #20 where it makes even less sense.
> Either the machine and KVM have sae capabilities or we don't need the sysfs
> files. So why even add it as a file?
> 
> It's not like UV where we need to opt in, it's either supported or not.
> If it's not supported there's no need to have sysfs files.
> 

The idea behind this is to provide some information on why kvm-arm64 is
not available:
It might be because ptff has not all the supported calls or aef is not
there. Both must be present.

> 
> > 
> > [ ... ]
> > > +static int __init aef_sysfs_init(void)
> 
> aef_info_init()?
> 
> > > +{
> > > +	int rc = -ENOMEM;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_KVM_S390_ARM64))
> > > +		return 0;
> > > +
> > > +	rc = aef_query_info();
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	rc = aef_init_save_area();
> > > +	if (rc)
> > > +		return rc;
> > 
> > [Severity: High]
> > Will this execute the new qaaf instruction unconditionally on all hardware?
> > 
> > aef_query_info() correctly returns 0 if the AEF facility is absent (since
> > `info.sae_avail` would be false). However, aef_init_save_area() is called
> > immediately after without checking if the facility is actually supported.
> > 
> > Could this trigger an operation exception on older hardware?
> 
FWIW: this is a valid finding.


	Steffen
