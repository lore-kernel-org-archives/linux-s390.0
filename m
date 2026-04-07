Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA73A8FE9;
	Tue,  7 Apr 2026 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564044; cv=none; b=ciLDrvp3epOZVYSZ62899sMGh4mO3CNZKn7IC8SvfN61IMoPlW/SmQokh1XCA4QoqfHSlfn0WT/+67H7FZ+/VIrNJ0RhEeAhhKUuE9Wt9w0wJ5knX+gOYNhJE6Kz47uAVc+6s85/xHoSGWKbH6Wm0gN9ziI4ryZbTMIhIpjPHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564044; c=relaxed/simple;
	bh=LWJkha2yVYbk8Pj+EPr+8pmSKBCGZmHbentgW97kfxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jyw8Amlbz5xxsgilVGMblnuu6fgve5EZBVmcujscLzU/dhw9VshCmuX+mDVuWLOIHpskivgtDyEMUK8160ARxkLwJA8BrtMHTvlIBNFPJ5a+8+Uh9Q94edBQiOvnl86ShUHGOaBGVKjO0qUtoLEXkSvxZe6kYfmj4YTkj98Dkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f55/ZOOq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f55/ZOOq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmOth2592771;
	Tue, 7 Apr 2026 12:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DoolXRdlFDgrxRPbK+zXaCv+OQ6f1R
	i1AqY4eVWeaKA=; b=f55/ZOOqgIk0QuHaiGivdajdnjZFrdQDUolVJDp9meHdbV
	EsAeWbBNc2bnDHZbPEF6IIciWKNMZmgLTgUNyLqoJkaXCNLmt+r0qU1Ao29bLgYI
	GgCQLSf/x361NVWgdsPGX8Irwvmc5m5ssN8i5PzxRTf++KSRFpkAqo/PKTA3YTFq
	Mo/y8M7QGs/utHMLru1AE8QzOJM42yVAV3+FxxgRt9CNsEGD/b/Fa9kytSAEmv3w
	dSGAReoC83pmv+mSei/9Vrggl0ns0VazSQyvPwJq5paP33MxLj3dXM5/yvNxQ2hw
	Vlzp+MC7BOR9Yj2g9NQLm3qEfOZHVhNoxtLk6aWw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e2v48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:13:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BNA1G029863;
	Tue, 7 Apr 2026 12:13:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7b1ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:13:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637CDs7U49152408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 12:13:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3E8B2004B;
	Tue,  7 Apr 2026 12:13:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73DDB20040;
	Tue,  7 Apr 2026 12:13:54 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 12:13:54 +0000 (GMT)
Date: Tue, 7 Apr 2026 14:13:53 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v3 1/6] KVM: s390: Add some useful mask macros
Message-ID: <20260407121353.296205-A-seiden@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-2-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402150135.196943-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kxHGHMXZwkJq2f1YKkTi1HJBu8szkTZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExMCBTYWx0ZWRfX4U/Dw17gUXpE
 OplcykOuxuB0VKvasrzBD+qrQTHXZAT3+GlWYpPFPk3o+qOJj610M05x5/geI2QiBmJHKiQ0hVw
 7kxUFN0MwDzTj0gPN0bCQKgfJIWz1wz74U9bLd9sHd1l7VQdp28M5tB6mMlf4d6mu2rQ8QMVzxY
 zPi3IMKsDjpiXiGnfjKgbglWhnS/o6qCEbu32/7ZnY5Yq2vM0Hdsg5ghFjG7mDMS/RyTCcTP16/
 x+M262Ah8E5/78qXLRC1qbbfqwxYM5oa1g4Xh4yKw/BQU8wJKz4mpVeomCdaQodH+pbAizEJySn
 Bwek119e/ynQ84tmm2JneTYrKEH01Pv1D/UTVSWiDGDAfJ/OI7H4vXAL73SZXPS5OIXl0zi503R
 Y/6JI1vBMsNeMxEOKdK9HoEZU6Suzbv0idBjiJOpqL0gLOqdrkqM2vYVIN91mnjKfcexmNnzR1k
 8ks2vGpQQjUDTSAPLHA==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d4f508 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=vf6NJk7m3_Ogz1M4-hAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: kxHGHMXZwkJq2f1YKkTi1HJBu8szkTZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070110

On Thu, Apr 02, 2026 at 05:01:30PM +0200, Claudio Imbrenda wrote:
> Add _{SEGMENT,REGION3}_FR_MASK, similar to _{SEGMENT,REGION3}_MASK, but
> working on gfn/pfn instead of addresses. Use them in gaccess.c instead
> of using the normal masks plus gpa_to_gfn().
> 
> Also add _PAGES_PER_{SEGMENT,REGION3} to make future code more readable.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

