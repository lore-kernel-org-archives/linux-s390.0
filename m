Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF217C228;
	Wed, 10 Jul 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601798; cv=none; b=pFH+iQnSEHkDwcb7tWP+ObKVUNsHXGddWJBMlRrWtBqdmJ/ucHAO8O4o29Q6dJVdSLAOU28TMSSu1IK/ZwfhItutX8LlgrAVK2cGKaFh/WgZEUPaWrrvf8dKfg3yiMtZGH7tHvQB/MYsn8WClXoJVw3JpkAXBRn51tDbpRoU7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601798; c=relaxed/simple;
	bh=rOMbhdaJbHmZDPs6iV5DzNfV0ysvfub6FKVnIIQCMsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ensh9g7gYw0dhkzxPtjK+IDqTwvAfDRCtHxmEdMNW43+ZwOw/JsZZjLQIMK3j8rgxIdxKuP6F2p7gCMzJzKTv3tKGYj1ACd6eAYSRxv8+Rs3P+iiBC8J/tGq+QK1ACU7F9KEoUuSf4SxkeU1p49sk+Z4Ff1xc8GKFJkV6ShA72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OaPgS4tN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OaPgS4tN"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7xFGI012802;
	Wed, 10 Jul 2024 08:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=v
	EDA+lPOnZ+sw70MnnvxuN9TYG7rrNJE/wN4s+twg0U=; b=OaPgS4tNDcWIs4HSV
	Q2CAgMGgshdWg4KtyTEs1y7IeEEeifaFB37bEl5EAfArSyr/lTIdkXK4mN/0yo1m
	Xdl1mlRBdvRUbhJt9f9vSeLefdn0MbJyTZBwIBwPwjcIm/JNnMLpec+qbJWvS9WS
	7F6mmqGeGOtd7/OLGn2bbs06WGZnB78o8WVpB3VnBWtaODnMWvWau0cpIBD0xOUM
	FtzsGtJqziaR+Q/PoSKzDf7R7Y/foCFVNK0AiiArqPafZINaW3OAWHzo/acoDYY5
	gsRaJ9MU5+cCuuOgi4oAzGzhmLhhFLcztPBTSHFmCUVzs8yZxUUhd7jS8gGwxIO+
	Ck7kw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 409pcug52x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 08:56:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46A703UB025952;
	Wed, 10 Jul 2024 08:56:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrmt6m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 08:56:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46A8uRv157475482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 08:56:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3519C20040;
	Wed, 10 Jul 2024 08:56:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA66920043;
	Wed, 10 Jul 2024 08:56:26 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.94.3])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jul 2024 08:56:26 +0000 (GMT)
Date: Wed, 10 Jul 2024 10:56:25 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Omar Sandoval <osandov@osandov.com>, linux-s390@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <Zo5MuXGcQwcC2pyw@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
 <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240709212141.31160508@meshulam.tesarici.cz>
 <Zo2j3hgOhh9EQld1@telecaster.dhcp.thefacebook.com>
 <20240710070246.001873c4@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710070246.001873c4@meshulam.tesarici.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZIz4oM2LQrFVc5S4QQGvYs7n03mMtJyg
X-Proofpoint-ORIG-GUID: ZIz4oM2LQrFVc5S4QQGvYs7n03mMtJyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_05,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 mlxlogscore=594 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100059

On Wed, Jul 10, 2024 at 07:02:46AM +0200, Petr Tesařík wrote:
...
> > I wasn't able to get real KASLR working on my s390x VM, but what I found
> > in testing without KASLR was:
> > 
> > - Before commit c98d2ecae08f ("s390/mm: Uncouple physical vs virtual
> >   address spaces"), KERNELOFFSET was not set at all (this is expected).
> > - After commit c98d2ecae08f ("s390/mm: Uncouple physical vs virtual
> >   address spaces"), but before commit 56b1069c40c7 ("s390/boot: Rework
> >   deployment of the kernel image"), KERNELOFFSET was set in a way that
> >   drgn understands even without KASLR (that's a little odd but fine with
> >   me).
> > - After commit 56b1069c40c7 ("s390/boot: Rework deployment of the kernel
> >   image"), KERNELOFFSET was set "incorrectly"
> > 
> > So at least for no KASLR, the breakage has been limited only to the 6.10
> > rcs, which isn't too late to fix. I'd be curious what the behavior was
> > with KASLR before 6.10, though.
> 
> OK, I'll check SLES 15 SP5 (kernel 5.14) and SP6 (kernel 6.4). Both
> enable KASLR, but it can be turned off on the command line (or I can
> even rebuild the kernel without CONFIG_RANDOMIZE_BASE if that makes a
> difference).

'nokaslr' kernel option should be enough.

> Petr T

Thanks!
