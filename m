Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C099392C42;
	Fri, 24 Jul 2026 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897719; cv=none; b=aTvA4XT8+ImydHskJ0s9+VmlEwZY1z2hgy8CKTx97SVicWFTmA50B5Jue2mry3Dy9KShf7Dn/bMuNRWEAmxuiFxl5+iShBCe0Zqe1LSG66YS2sRNu8URUTtCPBxYBXLzhPYwOAd9EfAlPIBsSVVpVTbmd8UURr+A367TqMiVGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897719; c=relaxed/simple;
	bh=nx9M+45K+bloZULlLrIRAVr23cR/yOTxrX1Ceej1N4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re1zV1eWhJDWHLds7OTtSV0SoqRK6as4e3KFdQLnpkbagw53kW1Gc9q2sRGSujEFtN04pMzN1mzpYreBZE7Ek0++cQM3QidIDhM+xwDF1VoLbGYn9DsEC2V/qNDzd4cqG+5O31xwGIaXmtN5GLcz2bdgzyspjiBLRBmD6TYKVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VBwVPkCb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VBwVPkCb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OCggoQ1846071;
	Fri, 24 Jul 2026 12:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=DSeZxST8Z2xzZNa1zhUtTeRKBUaxnWPY4B9F7lKzN34=; b=VBwVPkCbyY/v
	l5YRDrSc/A8lvLapTxql48xcFKIATluomxT5MjUp0d2CEpuSNl66na8Z4woEd5VL
	oEMslsHNGUOh6F/Rjoyd8uUQUZ+7KYjtokswbqrq+ILfwf5j/2MO3HY+xueqUa0T
	KTA5gdupXszTfTdfIC/NZaF/+3HdG+98oRLWifLCmdBsULkiXMF1v1NgxL0Z+B+B
	MJtTzBHX77HTmB537zc6mUjx2NXa28a/AMRsyAl30i5RD501xdPEyz5Q/jhSD6/1
	uYkKFbJXcvIKSWbmRnkDMj3HnFzkIxJt4g1pPYp0f+VpzieUafDuUgGuHSArKSRl
	M9HYMUWy3w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abvs76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:55:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OCoTSR004241;
	Fri, 24 Jul 2026 12:55:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1grrfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:55:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OCtCJA32702816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 12:55:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 827C720097;
	Fri, 24 Jul 2026 12:55:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9D94200DB;
	Fri, 24 Jul 2026 12:55:11 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.224.78.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 12:55:11 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.4)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wnFQl-000000028cr-1pd7;
	Fri, 24 Jul 2026 14:55:11 +0200
Date: Fri, 24 Jul 2026 14:55:11 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: Allow SCLP Action Qualifiers for Spyre card
 status reporting
Message-ID: <20260724125511.GB14631@p1gen4-pw042f0m>
References: <20260724-sclp_allow_aqs_spyre-v1-1-569acfe11385@linux.ibm.com>
 <20260724124900.GA14631@p1gen4-pw042f0m>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724124900.GA14631@p1gen4-pw042f0m>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfXwz/+cxhZyssZ
 8VjWRaWp5bHDSRTyiSVWwElHuuURbaIT0lgBPokrRVW/kcU+aUBi37r1tA3uDRVdtWxJAglWrv3
 7HbgV2ggofNTQS6rTXomI+pTAmMR2Xlk+ObH3iAv/dEcH+vpqjbdehfOHHormL0qVDCiW8LNIZW
 tGqp+XfOeqgHxWTLp0fSzGDHJ6Rseb0UyYRQcWU3LrDlWxiOZDAgyKiOhRk2xE4zxEVGWxKWriJ
 72AFhrNLQg1NzHTJIMv3YhlSaAwVOPORORoOYHJlfz7a5/05Akd/D1ltuOO2cO5tZsgbuvqsXHg
 XpQHfvEvic3HyDEuObUY/ySyLwIIXkea+oPsVEoyVSDG/SU9CwyLEDSdo91hyXN1N0zXdZIt7Cw
 p2peLCIyuTYy0aRFHgmgHnnDz8dpxVabitylQ7Y1Dgvj0ZJpvQsBDlxii/fVU7lc/QoaQUHTJ/w
 vgw2fIijEJDA5K4XvWg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a6360b5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=W1gFA47YUPQWep858NcA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: t0r-mOlFBb8L4HstuNE6M74lprPXMOkX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX2BeS3U+elg5u
 1TGMZ1Nx2QCOA6IS5mPUivi1Cp1Sf07u5IfYidC+KDHMB7WdykwgiSlBYRCNJG+NMDDAyAAyQPv
 XGipDHpvMDnEwWohmZ00fC4QpoHLoWM=
X-Proofpoint-GUID: t0r-mOlFBb8L4HstuNE6M74lprPXMOkX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240115

On Fri, Jul 24, 2026 at 02:49:00PM +0200, Benjamin Block wrote:
> On Fri, Jul 24, 2026 at 02:23:01PM +0200, Niklas Schnelle wrote:
> > Add SCLP Action Qualifiers used by the Spyre stack for reporting of the
> > card's initialization status, recoverable errors, and telemetry data.
> > 
> > Co-developed-by: Andreas Krebbel <krebbel@linux.ibm.com>
> > Signed-off-by: Andreas Krebbel <krebbel@linux.ibm.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/sclp.h | 3 +++
> >  drivers/s390/char/sclp_pci.c | 3 +++
> >  2 files changed, 6 insertions(+)
--8<--
> 
> LGTM.
> 
> 
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>

Sorry.. 

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

Obviously.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
