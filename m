Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C438C2A5;
	Thu,  7 May 2026 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147805; cv=none; b=mLZDyrxL7fVgzVmqSo9NAnPKMfQoeu3IFcDeX/ojZr2BSs0rTgN0ufAl8WLvJ+V/DPI8TyNl/inuiNoVHpmf6vTopS3vh4pDrcPBhPt+v2R9WGkSTBdFytZ+f4klMr5FaortXQoklKaddhh3gxZpKvbWqpQYcT9hml75/6xZZ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147805; c=relaxed/simple;
	bh=eytBW7NjhWUeKGUKQUFPt9kMyH+xFSA3S79f+YSMQVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZsXBbOWujPUe9wEqS5hTszS7QeGfeMTYh9r7x6U6goSeuXvKfZb7dBtrqjxXSBotiJSTlKq6FzlMipIDUKIBIOvX77OoO+fitXVQuGcXofERpEmFbpiHPBC7ZPNNvpdxDhBWPfltkQN1htqW2Oyn4FsH1lM/rN92D0ou+nQO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mRgBPYZb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mRgBPYZb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6471MWHB3769724;
	Thu, 7 May 2026 09:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HkcWEmsEog+yppjNnjBNziioU4qu6l
	6bl+RSsad7Tsw=; b=mRgBPYZbAryZvFum5/MJvIPmmdsgCmonkXkOVTHVDnxTgP
	kYFM25zAcaAyBvV3J74YZ4zQCsWs8DOEGooBZPyu+/KBvFvzmC/+hlZpuoh7qWUo
	FuPczCtATTzXk/7l138ZxbXFoYI8o+N+z0eeKJ5uZ6IwiJlUzcqhMS7ZjiUmmNmU
	Os3Q5mFgyI+RhG55dhdheGYV+RjG+MiowE9yzgqLK0Blr2mcETMgrIukG3yMu1yK
	Mctl03bPBCcr1FHtaw86pOvaW/aAnOqfmrW0hLZd/kvi29oY/fLqX8rvmxnyB6Kq
	G3CIYlaw2MUi3zFasqdc3klwh+cOMon/GQw91/nA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6mga5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 09:56:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6479scY6020515;
	Thu, 7 May 2026 09:56:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywam4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 09:56:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6479uW8T47382798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 09:56:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEFE22004D;
	Thu,  7 May 2026 09:56:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBEC62004B;
	Thu,  7 May 2026 09:56:31 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 09:56:31 +0000 (GMT)
Date: Thu, 7 May 2026 11:56:30 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Douglas Freimuth <freimuth@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v5 3/4] KVM: s390: Change the fi->lock to a raw_spinlock
 for RT case
Message-ID: <20260507095630.10395Aa0-hca@linux.ibm.com>
References: <20260505173728.160562-1-freimuth@linux.ibm.com>
 <20260505173728.160562-4-freimuth@linux.ibm.com>
 <20260506045734.11230A02-hca@linux.ibm.com>
 <d39c54bc-1984-490c-9457-5eff63edef56@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d39c54bc-1984-490c-9457-5eff63edef56@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fc61d4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VKRDzwYnuGaEOsRBYKYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Mv9KWwsjjxuWgf98I6VMkJbZEt_36PGY
X-Proofpoint-GUID: Mv9KWwsjjxuWgf98I6VMkJbZEt_36PGY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA5NSBTYWx0ZWRfX7g8MU1rpJDhy
 XCv10zWRVPgwGioa1TZTUt7YglOIbpAOLasrvSxfB0rbd7nAV4mjfd8DiQJe9iikic//TZZrNcw
 EM8XXucV0uXcP2ZNhTOc4oHLpiy43RbxV3xDYnUln8PapGii+oMuY1BuNlqBp3TfimIdO3+dNDv
 jptkxoA/ITRyW7wOvNpjH/0VFozgH42cAr7DPwJaGBDSe7/9h83OuDdbTVrVmWxNF5g2fm2KkkX
 X2dGUNhCuj7KeD2rIDmBhf5RUoTMnunpBAwWYZj6WuLMRerYbyeAXs6CbrvtrEXO6JUfM9pT33R
 nsDKVnpoTyHCrFRvvZiC5U6mGcNcHbJvCKrqOS3UVRKdr/l7W7o2+S/74llgwsTyynmmUHljf7n
 GeoPAeMMLR+klWGM1eGwgaSXr+i1C7+Byc+fXD2jIG5+f6yOLrAsgpBs8ojH2QxNanscKuSiXD6
 lren/2g5tbbxGTowl0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070095

On Wed, May 06, 2026 at 10:50:52AM -0400, Douglas Freimuth wrote:
> On 5/6/26 12:57 AM, Heiko Carstens wrote:
> > On Tue, May 05, 2026 at 07:37:27PM +0200, Douglas Freimuth wrote:
> > > s390 needs to maintain support for an RT kernel. This requires the
> > > floating interrupt lock, fi->lock to be changed to a raw spin lock
> > > since the fi->lock maybe called with interrupts disabled in __inject_io.
> > > 
> > > Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> > > ---
> > >   arch/s390/include/asm/kvm_host.h |  2 +-
> > >   arch/s390/kvm/intercept.c        |  4 +-
> > >   arch/s390/kvm/interrupt.c        | 68 ++++++++++++++++----------------
> > >   arch/s390/kvm/kvm-s390.c         |  2 +-
> > >   4 files changed, 38 insertions(+), 38 deletions(-)
> > 
> > s390 does not support RT, but I guess you are referring to a lockdep splat
> > which you would see without doing this change, similar like we have seen at
> > other places.
> > 
> > Can you include the relevant parts of the splat for reference, please?
> 
> Heiko, thank you for you response. I dont recall trapping it with lockdep
> (while it was on) but discussion on the mailing list in an earlier version
> made us look closer (and we saw it across the AI models that reviewed the
> patch.) It appears that while RT isn't supported it can still be compiled in
> to the kernel so we wanted to mitigate the issues we would add to if someone
> does that while not impacting non-RT environments, the main use case.

RT support cannot be compiled in for s390, because of the missing
"select ARCH_SUPPORTS_RT", however you can still enable lockdep checks
for raw_spinlock vs spinlock nesting, which this seems to appear about?

See PROVE_RAW_LOCK_NESTING config option for a more detailed description.

Therefore my question about a lockdep splat. However I don't see why
using spin_lock() instead of raw_spin_lock() alone in irq disabled
context could be problematic. On the other hand this patch does
introduce a

      raw_spin_lock();
      spin_lock();
      spin_unlock();
      raw_spin_unlock();

sequence in __deliver_machine_check() which seems to be incorrect and
indeed should generate a lockdep splat iff PROVE_RAW_LOCK_NESTING is
enabled.
