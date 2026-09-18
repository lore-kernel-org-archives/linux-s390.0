Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14AD308F07;
	Fri, 18 Sep 2026 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719632; cv=none; b=VobZamXOmcndL1VslmNINep5txmKmcXTaA04qqyJamslGrWFv1q+WI1k5YLnXi7IlVpvdlerBUJt0p7oT1OlriF026BC3YV0y+RVbYADZudWt/7Kh6cby7mejbc3lrTgxg1TIe/5j1ehorP4gDYz5pgmVD24bd1nuBqGmJBkfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719632; c=relaxed/simple;
	bh=JNIK7u6mInvCMxY6FaQiAgHvzKb1MvHSQiv5hjoikNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+RNPXfJ1jReUBpxe1GNvC9J5t4DM1mNqd7Q7u6xsSolDZ9+dvsizNZTq1mC3uKdFEaGT5v52Xghq6o4k9KMj9U8VQFwbLVLuIoh1Av+aPUEZ3LyFu4UhYwU5SN1MDBy+ph8pJaUVSqrPXz8tuspFS6eopdvY4wc8eXOa3HXmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MnzEimwo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MnzEimwo"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61q9u498803;
	Fri, 18 Sep 2026 08:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=9ebaq4jI8BxC90+bE9u0d7hONVv9ZncHpvrVPI4KBVw=; b=MnzEimwodcTv
	GxqA3OD+pv07TmF2nN67QUy0aWGUtdtSK8CFSJFtf+zVWK/hyEgI1mUvg0jRD2gg
	PorIbezpFlRZabIXnmbvZ6ikZuEwdgCIRj8IjDmO8PIyvJTG6RHJsjnTxoE1ujiR
	d9xjWhihjvEgyQHzpWwYMmH7ggw+W13NTxKlr00sHaEeTj19wi0FexGloM/pKvTw
	3HAPMS0ZZZa3GZNAjCZP2B4MPx9+VssKrHc1yIV4Cog/XVkLeKfUQneV/TuvtBDx
	tmoJ6RuRJuUoOAnbpeQxujF7xaZDTxT2CcGxbnXIlGBTcBO5n90qkeFLgVThfWeY
	UorEYIYdDw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvechn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:20:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I652Zw246075;
	Fri, 18 Sep 2026 08:20:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffef44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:20:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8KOve46268778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:20:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCC5220043;
	Fri, 18 Sep 2026 08:20:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A910F20040;
	Fri, 18 Sep 2026 08:20:24 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 08:20:24 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x7TpY-000000011ut-1noS;
	Fri, 18 Sep 2026 10:20:24 +0200
Date: Fri, 18 Sep 2026 10:20:24 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] s390/pci: Fix leak of struct pci_dev reference in
 zpci_report_status()
Message-ID: <20260918082024.GA241998@p14sgen6-pf6akexs>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-1-61a2f980e71d@linux.ibm.com>
 <20260918081749.GA39182@p14sgen6-pf6akexs.fritz.box>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918081749.GA39182@p14sgen6-pf6akexs.fritz.box>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfX+JRTk+8mHucR
 +0TUJ/zIhzHKzWOmsdpDrbuwsTjexLRH33rZ9Uhugk0ymFwJAz3HdkygJAZ4aaksT9v7r5e3xbj
 YRS+KvTW+PmVjQlv7gpjRt1HZxhErJU=
X-Proofpoint-ORIG-GUID: Nr913FyeI6ekTHtiDhAfOZ2_ko73Z_Ws
X-Proofpoint-GUID: Nr913FyeI6ekTHtiDhAfOZ2_ko73Z_Ws
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfXz7ocu++5y+k1
 mc2mF8qtEVShht3edzLXM4Axt3C0m4rz8NHbr6+Fye80Z3eDjOJJKeh+vRtUkHaraTtcRkAqt3B
 E23VX3j2cXqULD9JNAFDE2nLFe1PLiaDvfMoIiqvsywM/HVmEqnJo8vyzmwTc9OkJZOymghLT99
 chgUUbsFxSHtHboLpy0UytTVtT1hSMHAFb86oXEcKnGmKCHBQgihQsMDEDSCypS3IOrBB0Jy8oi
 IhS7J2crR5cDv/FHQ1t2PnCPhgQNuT+wD1cMhJJACIg9sGEN55wd0D7zr+buP8fIuUIrXUNd6Qv
 M+3bpu6QdN0ldLBqg0cUS/+R458Uez7APAScElmxDX5a8u8ud6W27yjvGXY6WrrULf/+iWy88ju
 wGUgf2WPWX7t8pVY2Kk/z0BCjI2LRzFuw43GCZgHSJeZRqh64QBs7HwEBx2tIp4sjuXrz3yi2Zp
 U0SwTMs70Sy4GgCdGtw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aacf44d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=StGZvYVBVS-s6NpHmy0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180109

On Fri, Sep 18, 2026 at 10:17:49AM +0200, Benjamin Block wrote:
> On Wed, Sep 16, 2026 at 05:14:10PM +0200, Niklas Schnelle wrote:
> > In zpci_report_status(), a reference to the pdev associated with the
> > zdev being reported about is acquired using pci_get_slot(). This
> > reference needs to be dropped with pci_dev_put(), but this call is
> > missing, thus leaking the reference. On subsequent hot unplug, this will
> > cause the struct pci_dev to not be released, leaking memory and
> > preventing reattach.
> > 
> > At the same time, the only existing caller already holds a pdev
> > reference. So instead of reacquiring and then dropping another reference,
> > simply pass the existing pdev pointer to zpci_report_status(). This gets
> > rid of the need for pci_get_slot() as well as the zdev->zbus check.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  arch/s390/pci/pci_event.c  |  2 +-
> >  arch/s390/pci/pci_report.c | 11 +++++------
> >  arch/s390/pci/pci_report.h |  4 +++-
> >  3 files changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> > index f317a1465dad..3b4941b65840 100644
> > --- a/arch/s390/pci/pci_event.c
> > +++ b/arch/s390/pci/pci_event.c
> > @@ -298,7 +298,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
> >  	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
> >  out_unlock:
> >  	device_unlock(&pdev->dev);
> > -	zpci_report_status(zdev, "recovery", status_str);
> > +	zpci_report_status(zdev, pdev, "recovery", status_str);
> 
> Hmm. Wasn't one of the previous fixes to move the lock below the status
> report?
> 
> Why is that missing here again?

Ah, nevermind, it's in the next patch. Bit confusing. Anyway, since it doesn't
make things worse, and it's fixed one patch later this should be fine.


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
