Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF689488765
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330122; cv=none; b=T6UsM20TyxgeX0jm2PFlCyyLEoux/gNi2lTmtiViAmsAAHRrzSQdAnI9Hcv8qAVia0CbycnY0INahj0r6/fkfsmXHyg6ZPoxmd+t0CVFfSRroHzWvDyU5xX/3UwMQb4nlankqdcmrR92hKhcIJOdxPTbDtz2zwO44fqRK7M42vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330122; c=relaxed/simple;
	bh=uIMFwTVPxo+j0rwDYGgK/87I+MCQMCy2uQfWgR/62No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Raj2qX3YKwjLA+Hm7PyyyaHiUsR03pf4RZAPHu0FRT6BnVLybbWIl0pIdVkM+pi2XDfIrMpzwD/Z5WF83NcBJApVtTkoeQFVMmR5FC3E2LjS6z2afUB/wiMAIlgtOdp/eJDaZeEMc8IjqW5XkqxQp20tbgtQtDaAExf9JTBD2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KsxaYZHa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KsxaYZHa"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHiC74063474
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 13:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DC/Gyos1QYJ71xL70J12OI0WdJbLEw
	5PM/5ootVEBVw=; b=KsxaYZHatARybpGsXz2Pi2AgC0oLQHDkSdR8XgeQ9lV7iM
	ELqVY23Rko5h+F1ijpviAwLSujZpsMVsHWh7e2WMq+EeK++7/NI8asvd7BQQRnZO
	MB84kjfLSObU3hOH3Yb3xs5gldyG8RM8rfPWpVksHV4+RhGup1GkNQeZQfZHO8dj
	Eq+ZGzMkfjRfAdAhR1GJ02iHUubmB6+zsg96oDb47wviqg2Pr9chjfXsEyf5GbYz
	czNEozGmdYBYmCRoQ0+k+RFLYBzRo/i8gEKSJmVRi+c8V5ulX93g3SEuCCB71BAV
	+j0b/jdujOTLTeAxlcND6HMthN78wFQN3T07ytNg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xtsrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 13:01:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCuLqJ015065
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 13:01:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y6g93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 13:01:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TD1o7h46727500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 13:01:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FE5F20043;
	Wed, 29 Jul 2026 13:01:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA71520040;
	Wed, 29 Jul 2026 13:01:49 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 13:01:49 +0000 (GMT)
Date: Wed, 29 Jul 2026 15:01:48 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/smp: Reflect (de)configured CPUs to cpu_enabled_mask
Message-ID: <ttixtj0@ub.hpns>
References: <20260723-enabled_cpus-v1-1-3a2cbdc374b0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723-enabled_cpus-v1-1-3a2cbdc374b0@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8y14PHEe_qXbrzXhpPOlxizBXEOImyLY
X-Proofpoint-ORIG-GUID: 8y14PHEe_qXbrzXhpPOlxizBXEOImyLY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwNiBTYWx0ZWRfX+kMVChtOd3PJ
 R9yJ2flkntiBiVnRELLxf1MwxaMOMwha2PE87x0QA2sTlp3VvLG2MrW078lPZDHVPR2ec+R2Qub
 Tryv4BiBXCWaQzkuU6hb2bKBT7ZOAYM=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a69f9c2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=h1IyOh74MZb93b_qYsEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwNiBTYWx0ZWRfX+YmSMrnKfkgD
 3/RdPwQbEcKdVNpD8uUjXEZORF6dmgAOneApx8YuNPAOxCt2GPkdQQJqyk2fctL8IgXZpr7ByQ8
 BEaL0EybWSWutxzFNFdu5eX0itDc7w91k0mLj9L5lDZDMAvbP0Dvsm95IBmxTcyM/snXbVDy839
 iYpyJ4KJkuKEKQ8pZMwfiYmaC76hESqkeUbNi/dJoJx07U1DwDKRxbhUAqnssInCOgF4Evq4wBh
 GAs3L9ra2E+W4+Yu2GZrkT+V91h1TvUKmK1rIDrfMoJXMqdzrRcqWyAZ+Awz3OKfrFQihozT5uz
 L6DrVFxXNlgLqycJAU3MfHZKTDTM5fUrJ0x87USGfqH9WvdvFbDLf+hd1xezidnMNcmZbsGWNwg
 GubbFXkwjouC05prO3uBQBIr8m0/OkLXeghT8mnv0akQ+mFRGM+KEG5sPfzUipn3Fpz2hiqbpXv
 dsAdVYirFeHOZInIljA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290106

On Thu, Jul 23, 2026 at 03:36:43PM +0200, Mete Durlu wrote:
> On s390, CPUs can be in a state where it is not possible to hotplug
> them online before certain prequisite steps. For example the CPUs which
> get introduced during runtime of a system can posses a "deconfigured"
> state which prevents them from being hotplugged online before they get
> configured. Another case is when users set the configured state of CPUs
> themselves via "chcpu" or sysfs attributes.
> 
> On s390 available CPUs are being registered as new devices via
> smp_add_core() either during boot or after a CPU rescan (for newly added
> CPUs during runtime). Registered CPUs are marked as enabled without
> considering the configure states. Add necessary checks to smp_add_core()
> and userspace configure attribute handler. Reflect the configured CPUs
> to cpu_enabled_mask to correctly represent which CPUs can be hotplugged
> online.
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
> 4e1a7df45480 ("cpumask: Add enabled cpumask for present CPUs that can
> be brought online") introduces a new cpumask to signify which CPUs can
> be hotplugged online at a given time.
> 
> Originally the concept is introduced to reflect CPUs which are being
> kept offline by firmware decisions. For s390 the configure state of the
> CPUs matches this concept. CPUs can assume configured or deconfigured
> state. When a CPU is in deconfigured state, it cannot be brought online
> util it is back in configured state.
>  
> On s390 available CPUs are being registered as new devices via
> smp_add_core() either during boot or after a CPU rescan (for newly added
> CPUs during runtime). Registered CPUs are marked as enabled without
> considering the configure states. Add necessary checks to smp_add_core()
> and userspace configure attribute handler. Reflect the configured CPUs
> to cpu_enabled_mask to correctly represent which CPUs can be hotplugged
> online.
> ---
>  arch/s390/kernel/smp.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thank you!
