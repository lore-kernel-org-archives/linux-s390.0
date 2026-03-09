Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A639283E;
	Mon,  9 Mar 2026 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053665; cv=none; b=TBX6gOqXdanAGjk9waC0EA3SzNRz7uth+SznzJcejegkouuCjdFseVqUw66J+vLUpe4AuaOZglus8rfTddcHGbhd1bMSSFT5LZeKYiZtW1tv2hQNijDoPgwFM/u7OJWMTIgG3C/4Qxn78F3svIxE/YH2uMO1mn4uego9eL344Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053665; c=relaxed/simple;
	bh=56IjPqKEuy6uM6HT7dWCbdno2kK/2SS2eI6YOx23iFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoaCT8vJxV0tPan3uAP9O1XI9JhU+D2ORHzlk8JTzDGCSpDCvgnQDxFp3rIQnl5cP3wKRImhwsvmnqY5MJI9N4HH/bu0QDX4LvkDbL1rw5X0i6l8IfQFa7me/T4tMLGATgEoxzAZiI4ycXUBMOmP1Fq+W9mgfG00Mb5llUZZZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eQSL2/TC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eQSL2/TC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628MLmBY1555330;
	Mon, 9 Mar 2026 10:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=GxFa5wVuY3PTINvQgo2Vl2sC57Wcw9v/OiStnBI/G2E=; b=eQSL2/TC/p1S
	XO3Op3cje7dOUGzcQd57z6Bq3WN02Jen8fRSt8oGbU9d52BRIiqo+GWDwqHgiAAb
	A6jRXQjA9GgsULvo/LbwAGepckQV6FcniBc5PxNTYziEwH3qI5UtrOCBK/UzSXz0
	3efOvWh7pUJ0GwymjaL44gIdd6OLnu3q29uMn7BvceX9y00IIcJb8QNGgErvBGbZ
	r217gcTFoez+mM0cXO20EgPTaokApxfT4Vk7IF4zTJkEtC3cyA4CdCnCsozeHxj3
	ZfYV0BkK2rm/pYcvrVPWKM7LTcVdJuJsPbliXMXnnR5WroXUcKPmtUp6/HnS602I
	SAVazITGqQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr5yd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 10:54:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6299DM9e021521;
	Mon, 9 Mar 2026 10:54:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsmrnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 10:54:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629AsFFs29294900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 10:54:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A23832004B;
	Mon,  9 Mar 2026 10:54:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D35120049;
	Mon,  9 Mar 2026 10:54:15 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  9 Mar 2026 10:54:15 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vzYFb-00000002y8q-1CqS;
	Mon, 09 Mar 2026 11:54:15 +0100
Date: Mon, 9 Mar 2026 11:54:15 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Tobias Schumacher <ts@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>
Subject: Re: [PATCH 4/4] s390/pci: Use lock guard for pci_rescan_remove_lock
Message-ID: <20260309105415.GB46248@p1gen4-pw042f0m.fritz.box>
References: <cover.1772815642.git.bblock@linux.ibm.com>
 <7be9c8ad56f5ef9366316c3621dece9a10f3eb8b.1772815642.git.bblock@linux.ibm.com>
 <4ad9163b-8ab6-841d-4a58-d10c7f4cdd07@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ad9163b-8ab6-841d-4a58-d10c7f4cdd07@linux.intel.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA5NyBTYWx0ZWRfX445LwtXWt0tS
 vQFxeYiH6yvhb3nVxVqgnl/3Ha/CcIveAd9Uu22VfkTt9pzcJN8RywUS094VB5K2biY5GV8FSIC
 irJGdcGk/Xv7MbuTSVDFfGe+jhbQMGfCVB8PHN6R5Mri3JDN9zC/MagkgYhn2eizjvespPFQaY6
 BdsDe4PYff1PXAwaQFwgxas4w6JxcMxI/yCyYAq738RHcVYJjTEZrqaQcM970h629HZTggKfiyP
 sNnzn0pp+o1WaGAJ0sNQCSxBJte0hOJiDa2ncwYGlCT/VbWu+3D9editg20GrB79rO150b0dskL
 ZM04Xc2hAmwjN/0u816OMwV72xYYhyIV9Jxh9toWkm0h6ZjDtvj1JQA1wZaEjgvyWVVuZaKYZ3y
 65JB3EV9cUse3BNprfxnnDkcDE3wx+6g0dmNWNmC3Ltwa0Y3635ysHs4alAsh9nckydFaIO5sq1
 kuGa31Vbfz1URCvIrig==
X-Proofpoint-GUID: bBYmcUOLd31755vRJjsz32tgQmS5akuT
X-Proofpoint-ORIG-GUID: tPTy1TpypBGTOxgpWxXHK-vzg7s64iem
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69aea6dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=5VACC5nshptmCMjhCrIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090097

On Mon, Mar 09, 2026 at 09:38:45AM +0200, Ilpo Järvinen wrote:
> On Fri, 6 Mar 2026, Benjamin Block wrote:
> > -		pci_lock_rescan_remove();
> > -		zpci_device_reserved(zdev);
> > -		pci_unlock_rescan_remove();
> > +		scoped_guard(pci_rescan_remove)
> > +			zpci_device_reserved(zdev);
> 
> Order in this series is weird. Why not introduce *guard() support before 
> the fix (reorder patches 2 and 3) and then use guard direct here so you 
> don't have to immediately change the code again to "convert" it to use 
> *guard() in patch 4?

The main intention here was to make it easier on me (and others) to retrofit
this in stable and/or distribution Kernels. I know this isn't a main concern
for the upstream master, but it would make my life a bit easier :)

Although, ofc., it isn't required, so in doubt, I can change it. Given that
the Maintainers are actually OK with the use of guards, in any case.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
