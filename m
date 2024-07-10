Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1516DEDA;
	Wed, 10 Jul 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601605; cv=none; b=h4W44jbZicIlB1VvGYAGENYa7U3vU+EtP+BjSS62D44TqDHG+XJim7K08y6i9Z4HDi3Z8ckRwvQS/QmKE6Qj2YYKlennz6PD/8CICdXIPLrY323L+UZhhVDxNW8b7s0b7QVZeCMe0F4J8K7+J1D/mQUebIC57/jjU8pOvRI8gcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601605; c=relaxed/simple;
	bh=48kaFR76cGweaiPZX8/blIIbHZ10G0UPd0OAEcs+kx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7MJDFlmZoPFgwK1k4REQHofPf+0JVImEtAqtjKmgLVFqEEg0tsAY6nRrCB2TzCXz2GVj9o7pmrhKQmtRei936g+RhmAbUUvgaLmAT6DaOmXl6q+TkKH62a1oRQtX6Vgs+jDvZ1s1+yR/m9ystJIlhNSJiPfmxjGNzhuNXT6eEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YVkwnwVr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YVkwnwVr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7hMY0003072;
	Wed, 10 Jul 2024 08:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=w
	cFx7G9rRtB7fe+0oHOdXRNW0v2qrJXId1IMIn8NgO8=; b=YVkwnwVrlupfgz7T7
	CLaa2ooKFYYPoT+jTmM8BTU72DHFwAj5/BBfFDn0iTD2Ty1Sik/jPGfMS4G339is
	RaRM13WGYg+7+f8gSnsIkRjJGrORn3Y3MbF0BfZouzKCEwGC/RVB1EwWAWJfZXv3
	msF6y7YbqEIAsj9vc6Jpj92yuf8OS5xSvee50+rBjWRXxbIJcETybWk5HOKU8fAK
	XaLg63mvBsFmaim47JuUfSoRZV/ENUSaPX2LibpGTYXCAOFIzSarGmxI4GmpooKM
	TWdzmJmbKYLnHVR3VzYdhekRT/lJMtneIKB0FLfkHVehxCpU/nYH4JvtdgdRteXf
	zt3Gw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40996q2hhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 08:53:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46A7b44H006903;
	Wed, 10 Jul 2024 08:53:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfmhy84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 08:53:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46A8rD9L53608736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 08:53:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8868520063;
	Wed, 10 Jul 2024 08:53:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1753E2005A;
	Wed, 10 Jul 2024 08:53:13 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.94.3])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jul 2024 08:53:12 +0000 (GMT)
Date: Wed, 10 Jul 2024 10:53:11 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Omar Sandoval <osandov@osandov.com>, linux-s390@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <Zo5L9xZtIs4dCf0E@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
 <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240709212141.31160508@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240709212141.31160508@meshulam.tesarici.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HBNwfXt0mccG-1IgRbqa-S21vQBQJlT2
X-Proofpoint-ORIG-GUID: HBNwfXt0mccG-1IgRbqa-S21vQBQJlT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=999 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407100057

On Tue, Jul 09, 2024 at 09:21:41PM +0200, Petr Tesařík wrote:

Hi Petr,
...
> > I would say to some degree there is also inconsisten with regard
> > to /proc/ files existence:
> > /proc/kcore    is enabled by CONFIG_PROC_KCORE option, while
> > /proc/kallsyms is enabled by CONFIG_KALLSYMS option.
> > I assume drgn expects both files exist and does not work otherwise.
> > 
> > Nevertheless, it is still possible to refer to only one file for
> > symbol resolution and use an always-present symbol. E.g _stext
> > could be leveraged like this:
> > 
> > # grep -w init_task /proc/kallsyms
> > 000003ffe13e9400 D init_task
> > # grep -w _stext /proc/kallsyms
> > 000003ffe0000000 T _stext
> > 
> > 0x3ffe13e9400 - 0x3ffe0000000 == 0x13e9400
> > 
> > # eu-readelf -s vmlinux | grep -w _stext
> > 178112: 0000000000100000      0 NOTYPE  GLOBAL DEFAULT        1 _stext
> > 
> > 0x13e9400 + 0x100000 == 0x14e9400
> > 
> > # eu-readelf -s vmlinux | grep -w init_task
> >   498: 0000000000000000      0 FILE    LOCAL  DEFAULT      ABS init_task.c
> > 182344: 00000000014e9400   8960 OBJECT  GLOBAL DEFAULT       28 init_task
> > 
> > I guess, the above holds true for all architectures.
> > If so, I would suggest consider using that approach.
> > 
> > Having said that, we will try to turn KERNELOFFSET from a synthetic
> > value "Used to compute the page offset" to what drgn expects it to be.
> 
> Thinking about it now, I'm not sure it makes life easier. Because then
> we'll have some old kernels with the current (unexpected) definition of
> KERNELOFFSET and some new kernels with a more standard definition of
> it, but if I read vmcoreinfo, how do I know if the value has the old or
> the new meaning?

The approach I suggested to consider would not use KERNELOFFSET at all.

> Petr T

Thanks!
