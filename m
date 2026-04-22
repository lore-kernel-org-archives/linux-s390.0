Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C528A1E6;
	Wed, 22 Apr 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868281; cv=none; b=Vdgk+vUGB93yRr80EUMeZOHrkihJ3YVzwapT0SCCctBJ6N3h5WXDEr06817BHlneNZn8jdyAhJi+ublrOY/fKkDQnC7lzqbGkvt5tW5jNj5pvjXlwSBmediY2NAO/MLCPWDNphCJoozMhbrPksxu5d/Q/zYR2l6Cda2lvOalb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868281; c=relaxed/simple;
	bh=qo+kvKacmlRsLljwYuAMP2dcX5LkjsfJ+a1e/lKtgeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLQkB0JXQf7M4IbOsJLjUdWZ+d0PmexddOC9JTR6bcS1/F8HfY8w3a9VeRbrdfUTyre2LS5fhTFc8mXINWz0eFffpol9twuVbsw65HBJ1pZuNtrZbLjYJJaOIA9ahNbf8a5YW53JustvFaYAo96LD+03qGFshFi5WYPtYbdNqkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZHPnn/l4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZHPnn/l4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MDVnr21018719;
	Wed, 22 Apr 2026 14:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=wc5xyRzLMgKaTWJhLQUu6Av9od0cCpXKLmDnSF8zkrs=; b=ZHPnn/l4QTGL
	msQ/H9O8twR4iULcL+PHfwHwkJgq7+5QjINxiUfxWjayrLBAgXui5FsAIFY//INL
	XciWgdsPjpKmNKHzBkZVQSCcxjWpLAFUjj15o3lmq2+Eo1EKI4XZ7WSqojnblTTr
	J+nXFNRN/pkEsgolu+2SAyZGFBM/j1Mca1VmwCzPp/HHTeLnXlq1dQvpEFaijK5+
	4WI75RNOIwlB3MIiS76uskTPFSzPkviyngecghMUc6v0pLn9NihqmW8jJJdKfvTO
	/ZxHgCH77ni6vMUvB0aJVLdMvcMUJZcA3cmn0HviYC80eUNClR4QG6NS9EAhSMnu
	JgDdtIQwjg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrbbpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:31:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MEKIGd003165;
	Wed, 22 Apr 2026 14:31:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxtk65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:31:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MEVEBU52691428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 14:31:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC9362004D;
	Wed, 22 Apr 2026 14:31:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C91F92004B;
	Wed, 22 Apr 2026 14:31:14 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Apr 2026 14:31:14 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wFYbi-0000000Fz5d-2Fng;
	Wed, 22 Apr 2026 16:31:14 +0200
Date: Wed, 22 Apr 2026 16:31:14 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ionut Nechita <ionut.nechita@windriver.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Gerd Bayer <gbayer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Heiko Carstens <hca@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] s390/pci: Fix circular/recursive deadlocks in
 PCI-bus and -device release
Message-ID: <20260422143114.GD2707369@p1gen4-pw042f0m>
References: <cover.1776866921.git.bblock@linux.ibm.com>
 <da7d517cf35528dd54b4323600302c3c9d3dc2c4.1776866921.git.bblock@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da7d517cf35528dd54b4323600302c3c9d3dc2c4.1776866921.git.bblock@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7e1QERqw--Lhv4FCdU2_1LuNWKOjZGkk
X-Proofpoint-ORIG-GUID: 9VsENo6kmKgg5TKXaTW1o_SvShJbismp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzOCBTYWx0ZWRfX6aSwDKvCqzu8
 Vyh2s63uolMb7hGqEuK0GFIW89F2TQ7bt7OfvzDDkwU2MxvTCSA7iVyDdaGi7M9iHdyq0icSXlk
 vesFJcwL/WZCbEzhiVGGmX8gSBCU1IW6SxlyR0OZG0aWcQDEAIPd2WcuEQYtqwlQBnuPfDrL06d
 oJ/6c89rR+qwx1sMFcjyN0ZPJ5ubVDQREXbSRAbkD0DIuwE7Lozriz9bgpYa75GdA5mUj/7tbSE
 0GAVTmbLBn/kzsBER3YGbV+3fN2I1T6j97JSBLwBc/Zv5qzYMXpOQInPDFdqNpoXdQNaQFT26+e
 WzjE91SGOIACvOLTpry/FMzkWyrysi1/Md1EEkfmL2OC708084pQF/ctgKhxv0eFgVo2/tV4CIT
 ja3iEKtSlfFlxrtWIaPyOmfdC5KmnGIb/SACsrQUHpTpCT9sM4fua0u3fgzcTgmgmGF2niAm4+x
 erA7tc1xZwJqvqoImmg==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69e8dbb7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Tnmygc6K0V6LZGle_IMA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220138

On Wed, Apr 22, 2026 at 04:22:13PM +0200, Benjamin Block wrote:
> When removing PCI device or PCI bus objects there are a couple of
> call-chains where it is possible that the kernel runs into a circular
> deadlock involving the central `pci_rescan_remove_lock`.
> 
--8<--
> 
> Fixes: 05bc1be6db4b2 ("s390/pci: create zPCI bus")
> Fixes: ab909509850b2 ("PCI: s390: Fix use-after-free of PCI resources with per-function hotplug")
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
> Reference-ID: JUP1193979

Ah, damn. This `Reference-ID` wasn't meant to be in the "final" email. Sorry.
I'll re-send without it.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
