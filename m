Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACA16F903;
	Fri, 12 Jul 2024 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791751; cv=none; b=mMxsDbDrQEjHLMWZqK78Qe78vzmHNYWbrAClShoFe7YtXVdE7l9gmqgeKZvJLWdskqNZH9c5wCqdE78vMFMCjFbAkNGMTEZraYbbiL29WhlwbpPpb0iAAD6F5fe4E2i6QnElKrf65aZdTKJLhZukLJG2AKSpEiOFVx/0NBnqCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791751; c=relaxed/simple;
	bh=/GHck3otRGI+z1iWCjYzqXnhtMK76fR6lT8eDXJHyTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O51HvrObR3H6me6O7BIvqtY3Ts6WNW1og2BHDcoyieFXEYv74QTY/khAj0Rzrblrm6IEzoBMJ2bSWUlbSmJXFFB+6vIem0LKHue05OfejTwlnUqWhuMr33b3SJWSVM0bSKYlsUpKsPifW+g2ILwO/Yzxpn6lMPMCSH9snWiIR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lxkqY34Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lxkqY34Y"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDQoCl009190;
	Fri, 12 Jul 2024 13:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=/GHck3otRGI+z1iWCjYzqXnhtMK
	76fR6lT8eDXJHyTc=; b=lxkqY34YM+gBXe6sCZCHrzwjhYtufNntgOqzAl8YpYg
	i3i5CO1tejo0ZnjxXw10q0d0kHTcRnHJecunHQxRQ47HCS1HJvfQRvgS/E+/GwMC
	EQ2fhIMSZgyjHZBBNWnucVjNQIXw6fZzA+eayqzCV+B/l4sBLEGHeO5asxpuM8uV
	NATmwhhxge5uCKwpr27uqh0Oyv2Q4M7Oe60ldoXlKN77JuaoXFFKThlmeIHJA79q
	Mv1ZqScDRUJ5NzvXiD7QjOK+rxC6vYsEbWR2nqiswJWgiEzdpYmUMLPqB2XSCvW2
	0cGqQ+gYXpsX9qBCm3vdDRj2tA9567ZoNOkJaxVby5w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ay8c10n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 13:42:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46CAQ5Ii024575;
	Fri, 12 Jul 2024 13:42:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrn6qr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 13:42:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46CDgJ0u50266522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:42:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FAD42004D;
	Fri, 12 Jul 2024 13:42:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7D3E20040;
	Fri, 12 Jul 2024 13:42:18 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.61.90])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Jul 2024 13:42:18 +0000 (GMT)
Date: Fri, 12 Jul 2024 15:42:17 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
        linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <ZpEyucQA1rctAts6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
 <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240709212141.31160508@meshulam.tesarici.cz>
 <Zo5L9xZtIs4dCf0E@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ZpBrDvUpn4SzaqND@telecaster>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpBrDvUpn4SzaqND@telecaster>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Spb1I6nFXR-ZLsxYMgjH9eDArWiTr8sw
X-Proofpoint-ORIG-GUID: Spb1I6nFXR-ZLsxYMgjH9eDArWiTr8sw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=374
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120090

On Thu, Jul 11, 2024 at 04:30:22PM -0700, Omar Sandoval wrote:
Hi Omar,
...
> I'd be really grateful if KERNELOFFSET was always the difference between
> addresses in the kernel image and in memory like it is on other
> architectures, or even if there was another, s390x-specific field in
> vmcoreinfo for that.

Do you mean another s390x-specific field that would be the same
as KERNELOFFSET on other architectures?

> Thanks,
> Omar

Thanks!
