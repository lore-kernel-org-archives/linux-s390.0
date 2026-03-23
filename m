Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD85265CA2;
	Mon, 23 Mar 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278531; cv=none; b=dcZAZkXC4r2/cHkinpeFOnwlZuLm9+VIxjyEFxfRVsK7YZrQ0G5kjvVcjT0IYrCu3ANO1vjhh3HHRCcnaHxo0rFbVF1P8rmUs6ZkVgYzKDfsPIDJs6ZKSqG9R04tGlNLMmtKbN9X206NwLaFvfchcSlc9jd43gCjy5Ow1bwfr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278531; c=relaxed/simple;
	bh=U3/09OFyfULHa8tdD++dW3jyclbVeS/hyksx0JM/gk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDkPAzGQPWKNP98lS96dZWrSPxCWh//dEiIH0e2Nn/i51yWylZQ3Q3STIHarY+GYZt2VAgbv36AKBrOJAt50OUifXNeCKr8xRbSRCsC8gWxHcVLEtB0Cbffnfqeo7sLEmYxxSbbAWFDgsuUSDwz/4lbNafhzdsc4mHqqIPi+6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jF3rVQLJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jF3rVQLJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NEkDjm666646;
	Mon, 23 Mar 2026 15:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=QNAlh5+aNWFxt331cT9hUYO
	rm84rrtEZOoyA1OtH0aI=; b=jF3rVQLJFW6REVBmDvCU5XMVaVG/Xs9WD1TqknD
	iDy5OoJW3CPW3YMaP+0gCKCtdZaCDgjcimAKKJpoATSJaH8Hetjpm6PhCGghCEMt
	UARQtlqj3CWmCL1j19q3De9w1nwkoNpShRME8oeAGjh5SOXFtYdOKjNcSrr4x6cv
	L/rb0QyMskLPCEvQL15JPW4fLAUtAmvxhl2GQ6WVihhb3DpHwL9xHjX8FDWIemJT
	ZY/VBwRPcS/vpMXPQ5gvZZb3frR9RZDjHxwpzBSY5TbMshuaRzcgFkh+8kk5BeqL
	hFe7+vNjj5AmjepzcWoY/WCzcROgVFvmSGnCfT3wDKX58LA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxqdr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:08:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NDi80m004407;
	Mon, 23 Mar 2026 15:08:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c1wjr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:08:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NF8iHI39715142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 15:08:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7C4D2004D;
	Mon, 23 Mar 2026 15:08:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C85812004B;
	Mon, 23 Mar 2026 15:08:44 +0000 (GMT)
Received: from vela (unknown [9.52.206.27])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 15:08:44 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.1)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1w4gtY-00000000dCD-2BSW;
	Mon, 23 Mar 2026 16:08:44 +0100
Date: Mon, 23 Mar 2026 16:08:44 +0100
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: Re: [PATCH] KVM: s390: Fix lpsw/e breaking event handling
Message-ID: <acFXfK0yyQmT0xGz@linux.ibm.com>
References: <bc995033-1850-43f8-b04d-66f78ede157d@linux.ibm.com>
 <20260317130440.103576-2-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317130440.103576-2-frankja@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c15781 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=4RSiKU3I6NhEqefK0yoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExNCBTYWx0ZWRfX0FTbuhyhMB5z
 wAAymV143wap2NttwlXSwZy4fvITLcVzvJjQnI7c7BSIOtejmLdmxjrdCmAGU9uzqSaHN4B2W4r
 d2UgEMcmyPBpdbOEQ4/WuXG5ktXV/YL6K3f/WTq1+92G6hbRv8YCTz346xUaiodwKu8HVpdWZkJ
 5dPB/2uxepNJ6sKtpwSBmzn2ucRCOqeh7Rr/T+g/e/Bv6t5C7be1l3F9NiegjMPxRxJSSQhdKl5
 1/oaUeJG4s+r5spwIpi1y5lAPWKgOk+oi0ypUvZfhmvuA9ZjM7db8bk+yVcXF6iY6RytC9jVpDE
 HJ+f5bsgZM6FyEbL6QgGkHtMZnx/fZifxuEozgbLwaf5qHluYhDHneoJgbhNmE0xl1u1GzN/s+z
 jwR1AcPn3nFyfhDfHHO8+crsDBae8xB9HTeAKGUfTXqZx/XwMRKPf/cP7YS8+hrFW/FAVjrwMXp
 tAXWBMmvtyJac0lIrsQ==
X-Proofpoint-GUID: qq43yOcGMlfvUdafBLEz8Ks1gP4ZmowG
X-Proofpoint-ORIG-GUID: qq43yOcGMlfvUdafBLEz8Ks1gP4ZmowG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230114

On Tue, Mar 17, 2026 at 01:03:54PM +0000, Janosch Frank wrote:
> LPSW and LPSWE need to set the gbea on completion but currently don't.
> Time to fix this up.
> 
> LPSWEY was designed to not set the bear.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com> 
