Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9E405ACF;
	Tue, 24 Mar 2026 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366151; cv=none; b=nQ7PNAO4fhanM03oVRvA1ol89PhpuSMpVBtj7C8kb6C5kx81UimNSdkpeqPBJ93n1sUjFclvfOno7OgZIqqYKXtflOOh3Gw/7zJqmycZaBKuemsONG2H0+ruc5Nh7oDZx3ma2nSV4QAHV3+Vve1skzpXQkiD9wuP1OrMKIk8kEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366151; c=relaxed/simple;
	bh=KN+tBha+izJRni7kFgn01Duc0mFvOx9vlPJxnHhjHWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OacWGuck7OPSLtSQPH4OxJfhQ0hMbrWuwlqeEiIuhvGCa3qvew0UDDcF77K/3Xe4h6Oj3jjSqB6Pkg2uKhlGC3ReeNK/hFRCgh65VnV8bcPhuD3/J6Efnk7jCDlDSMs+k9tzUHUbPiSnJxrfqbpEp3+pHOA8dbqijDG/Az4/aGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AK8Mp7ze; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AK8Mp7ze"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O8gD9e662269;
	Tue, 24 Mar 2026 15:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HO7a1K
	90yVqC3KKHNQfLC9z2MA7WKfSY0hFhlfsJsPA=; b=AK8Mp7ze8UPv9IT+eigW90
	bLR159smvYxtkZc+8jWs2of9n4JkgR4PfeARNseCx6MdVxxPPTQbk+1N/LNKyANO
	9tBvnTwygEyDkBwAk7q4N30Sr0oTl2UIJPiusU+5k6l1QEjWF5YsMHUrhKVwKZ9H
	7yq60f3rZsk1FwXj83DNGN+aIFAkwPwBktDPaIHqGZPiJ8gj+ggaWXtzzTzVt8vP
	iU9HDnGhWUOys1x1ZwtfTze4os7oiaTLzseSIqBylDZjR3CdnicFJw6r86Fgbg68
	fx2TtF4k4apiL/lASyuBInRx3nTsmbS+WaQDIAIKa7PCD+ELFWyf4XKMg0ZLnLgQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuun9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:29:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ODCnBa004387;
	Tue, 24 Mar 2026 15:29:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c228kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:29:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFT33H15204778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:29:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1473C2004B;
	Tue, 24 Mar 2026 15:29:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9952B20043;
	Tue, 24 Mar 2026 15:29:01 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.26.26])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 24 Mar 2026 15:29:01 +0000 (GMT)
Date: Tue, 24 Mar 2026 16:28:58 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v2 6/8] KVM: s390: vsie: Fix unshadowing while shadowing
Message-ID: <20260324162858.0e305fc6@p-imbrenda>
In-Reply-To: <67810b81-a3d0-4517-96d2-e99b90a216cd@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
	<20260320161542.202913-7-imbrenda@linux.ibm.com>
	<67810b81-a3d0-4517-96d2-e99b90a216cd@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MLzhcKOzz0SzUIwCmYoGHwrty6FcQ-8L
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c2adc3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=rh5d3bxwEoKsl6cgku0A:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX6F8d61Io7YZB
 jZm/BM7OCQoW5WZ2YYiFgG9SHgmsgbdP9YsZky29bt2AK9hByR9opQThcO0WUxoFdwB9TZyLQYb
 J/dqTjgefTx8+U+DTC2ylLrvLUKGKA1/RygQ8inGirv8O41GVPE9Ww8Hs0C3EXVGVMxpAC8CIBD
 MfBac9S6utul/qE7dP1S2xZQ4SbhqkmoenKKkF6l9YFyBL7Xfosm3ex4a0acHe7F6JFuQFh7Oyl
 Qo3EBkKfASO4U8mfMOe1HLylNq/gd3l5PKpRPv/WZ/Tb9E6dp2O/Pdnfji2IcOLMrDaBhJMKXNP
 10+xEWWdaC93+riF16KcmbMqiKASju0O+2hdMD8qXB4TQeQEHyC6dUXclHLNTZEtnyQaY/pNr7/
 0rHLiOjJ9T3MPo9fo7m4ZWyRK6ZIrJRPQ0mkQI/C2pclT/VJBcm9tNfBVJG/3P11eySTqwSNiCU
 YW39Tr+sDJKL3bNujNw==
X-Proofpoint-GUID: MLzhcKOzz0SzUIwCmYoGHwrty6FcQ-8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240119

On Tue, 24 Mar 2026 15:52:02 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 3/20/26 17:15, Claudio Imbrenda wrote:
> > If shadowing causes the shadow gmap to get unshadowed, exit early to  
> 
> How can this happen?

one possibility is if g2 maps g3 memory pages over the top-level table
of the g2 -> g3 asce

there are probably other cases I can't think of

> 
> > prevent an attempt to dereference the parent pointer, which at this
> > point is NULL.
> > 
> > Opportunistically add some more checks to prevent NULL parents.  

