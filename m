Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ECE30EF9D;
	Thu, 23 Oct 2025 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220813; cv=none; b=Zczmi5kO9ZTB4CtvsWxp7Wk2qwnJ+J+i6kvzNrnohRTHp+oOQfNqNSv98q2QaxU8LkgV/zS6kn2Bi5oSA28V9BjSnVmGG15NR6tM3XYoyYsQ6mQb09Rsp6WOvpMGuVhNaVtdk0m8fzcc1W107N9nImK7GeePFcCHnKKX7v/mi4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220813; c=relaxed/simple;
	bh=XZNLK3hKGFznou+fNvWgMSs5kfYGdkg1ZtKr+DYHU4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2cGsVHht8s1e7MVwIrIVa+4RGe8jGTGNeDmkFH5fjPyOE4Vh/c84e5yRsVz2mCVo3i73Tnw9dQkFq6bPIlz6fIQ8KaSA00VfdLb2mL2JHYJSniBAd919H9g0CkuO/vINH6x+VqG+DpninBt5winxUREFQZsqGoymTRnNYA9/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P2iIn5B1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P2iIn5B1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3bN8Y006824;
	Thu, 23 Oct 2025 12:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=stK1Zk
	5MUrjtZnm8vJGvyJzUkES95uzRDeHMdMapYSs=; b=P2iIn5B1//Go3GjfhlUfJ8
	eABz82/x5P8CyNYy/+/cyuWf0Cr5lquT64hhuJ3uyCqRt+IE0Q9YYE72hp2xUrJo
	twlPou9GElmsFu1S4n7gsV2myz+mbWVP8pE4cucVIsODc3VazBUwOpfaRSze2LQO
	SWvNymaOoWELuHHaHX+tr0fH9gmydvx2mCx4B5k2AefektZ3GIMssa3zstJFzt2e
	3/VAOgO896fHw2DthITVJ5MeyH4OzKec/zkwkpnKpfjPiYx5AhVxq1AeOmFYQu5k
	NbxJc9lkkZzRms+b1J5lBfW/hdmo9ak+C5LGuCONIdBvE9G2LDo5XTRSNi8AzfZA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3271xv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 12:00:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NBmeM5011066;
	Thu, 23 Oct 2025 12:00:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1d858-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 12:00:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NC06LN48169284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 12:00:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B0B720043;
	Thu, 23 Oct 2025 12:00:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDE1420040;
	Thu, 23 Oct 2025 12:00:05 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Oct 2025 12:00:05 +0000 (GMT)
Date: Thu, 23 Oct 2025 14:00:03 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v1 1/1] s390/pci: Restore IRQ unconditionally for the
 zPCI device
Message-ID: <20251023120003.9536Ca9-hca@linux.ibm.com>
References: <20251022164727.882-1-alifm@linux.ibm.com>
 <20251023074028.9536A84-hca@linux.ibm.com>
 <d611c17f342acc0d00b9921686474007a7d29213.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d611c17f342acc0d00b9921686474007a7d29213.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa18ca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qS5ouzKY-k1a6jQLhV4A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0ylv/7WdYLIO
 NSU1oJBevnOPxVQNjp7OZUXLoblp+KEwtGakCATygXx8QEfvg0zOAFfffmHTvrJjjuDD0jojwDG
 mjfXuVLR2egyJvz24OzlgzSsiCscPAck6678izLJyHb9Pqn82e4t+Dfa6y6W3fsZ7jTUNHwEK6M
 sEglv/LQvFxmurmTAylzxkuTNIWQ/WkHr747Bse4g8EMlrpwp40jai8EW73vtrJ2ywnPVubiEtG
 frQHD1ahrWxkpgKx6g12R2HS5T8Nw7Qt3bS+iQr7xQoBKaU9e1kWhnHGVjs2kGclaEVoDfQPqjs
 iK4570GXWuAR37faN5l3CFgIcxolpZhKcREYKA2qcjFO1tuFVXnLOdgqZ03hQyQLG09H7uz9kVU
 zhLNyCkP6c8+QTJWeh5nPWDDT9Z+BA==
X-Proofpoint-GUID: BIwotFXZAG1_KM7ucV7k8xXWq1locIjC
X-Proofpoint-ORIG-GUID: BIwotFXZAG1_KM7ucV7k8xXWq1locIjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Thu, Oct 23, 2025 at 01:18:54PM +0200, Niklas Schnelle wrote:
> On Thu, 2025-10-23 at 09:40 +0200, Heiko Carstens wrote:
> > On Wed, Oct 22, 2025 at 09:47:26AM -0700, Farhan Ali wrote:
> > > Commit c1e18c17bda6 ("s390/pci: add zpci_set_irq()/zpci_clear_irq()"),
> > > introduced the zpci_set_irq() and zpci_clear_irq(), to be used while
> > > resetting a zPCI device.
...
> > The above sounds like this fixes a regression. Is there a reason why
> > there are no Fixes and stable tags?
> 
> It doesn't have a fixes tag because at the moment the problem is
> theoretical because no driver uses plain pci_restore_state() in
> recovery. Farhan is working on patches where this would be used in
> vfio-pci / PCI pass-through scenarios though.
> 
> The existing drivers re-use their shutdown and initialization routines
> to restore state and end up calling arch_teardown_msi_irqs() and
> arch_setup_msi_irqs() so it works out ok there. 
> 
> That said, I agree this could and probably should carry a fixes tag
> since the logic is kind of broken even if it doesn't break anything at
> the moment.

Can then somebody :) provide a tag, please? I'll add it when applying;
no need for a new version.
