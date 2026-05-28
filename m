Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1D233921;
	Thu, 28 May 2026 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977700; cv=none; b=OkZAtREMkPt6Xr6Ono8rM0JzyUIUTE20EGBpzB/SKoXHZjuIIfbtnHgqY7NPxTgn5+fpTQGyU5I42b2PAOta3vm+sXGmkWvWPE6NAY8i1L8e22MBDSwWnzd6cfZdUvT0ThO1lXM5C22tURjRwr/MlhFRePQShaeThcbswSSj6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977700; c=relaxed/simple;
	bh=+y5E3y9gpeX7yuCScJnSs4Q5KwSX9sRDN3Vq//RnXvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLnWvBcqgI1odZHACuqERXEw0ac+DsOpDfb7r3M4gIfz4INkvUCPbtArnMfznbIBxDcDKAkdbU8eo1ctZMBOE490pQaRXVWpFpO+eZBw1yYmnhUMK78dck3FCnAF7sfzJZmJTYQP19uKpzaa0zK/E1b/NKZ9mUb5sy1CZfRQmeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rxId8gD4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rxId8gD4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SCAEiE3426465;
	Thu, 28 May 2026 14:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5yJnabLImlofVgxVUGKFozxmmjnsmc
	3w0PcDsc8f0zw=; b=rxId8gD4ziBMBoN6tWlBQvGTpHCUbQJ9+Cufwcy8q/WLN6
	28CB+qvuCilEmfyCqeafczUssqmS43YoHyM6gBW78L4yc9gO2TNPJO6ZAok49qIf
	kGF/9rxexBjK13V4xoZV4tJTYy2cvxmWsNAWNXEphZU3uQN2T03QLJi43hwzqPca
	sQKg02LH3BQIP7wy231vr7rmccFDQYwswlnCbM4C5QHRhNaah2cIBG+6d8rCnkxs
	ASsaKVBR1SITmOUids1q4XMTf5tPqG8dvMHkWDfPYklFgBN+GiAixbQo+EKESdmP
	QNmOXTU+cY9yUNQx3jBkDBrHbIREcYaLGMBeSUdA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884kebu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:14:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SE988O014679;
	Thu, 28 May 2026 14:14:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8fan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:14:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SEEhYG53477816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 14:14:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A08A2004B;
	Thu, 28 May 2026 14:14:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A085120043;
	Thu, 28 May 2026 14:14:42 +0000 (GMT)
Received: from osiris (unknown [9.111.53.179])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 28 May 2026 14:14:42 +0000 (GMT)
Date: Thu, 28 May 2026 16:14:41 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: David Laight <david.laight.linux@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        "Christoph Lameter (Ampere)" <cl@gentwo.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
Message-ID: <20260528141441.15387D07-hca@linux.ibm.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
 <9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
 <20260520233409.0683f595@pumpkin>
 <d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
 <20260521103742.9603C8c-hca@linux.ibm.com>
 <5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
 <20260522091805.18098A5c-hca@linux.ibm.com>
 <cfdb20a6-5621-417b-9202-d788ca34251b@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfdb20a6-5621-417b-9202-d788ca34251b@os.amperecomputing.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a184dd8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=BSgQKqvjLk748zkeBjkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: xza3zhZyZYEvVuoiaTc0gNJCUuhnJjmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE0MyBTYWx0ZWRfX3KYA5+uVhsYG
 j7XUw/cnq1oWmUx24g0noSBjBatuA/cww3chtvWnqdtteysRirU9cC5xukt752OeiSUXj2/qg0e
 HyHAJ3eMX663Psb9WFrQjeaRfDd9jm/anknUjKBqC+/BrlQ9gc0gPbyAO0FXDZ6R+B8DiK/ZFT8
 qkQ7zMKeSfRKrcPvJCP3R1X1GJfk+9qz7Y/U+GRCl+lj67yHATuqhOgIfnD8/CH38xZkuhnS9Y7
 rertm/O84QOx27MWmLOKRB28vwpiePx0PXNVlQ7fiB3RFOuUuc/z5+TjAJBhbwDFv0BupS1ror9
 pIKy3z/rJc3W6KdQ/UPgdK4H06QMJ/IcelB6swG83Ug6wM+/QFTlLf94MrrtJlSpqSrmltj9EJs
 7DUWyQ+qyu3pintn5I/VAS2f33TfgUG4FGensWBRrG22urCdxq8N88waBXwZIue1v2GdwqxGQtd
 ZnvOgg7Xr1J4PpSg6Fw==
X-Proofpoint-GUID: ocxhgVtIENQxtx-9D95GI_7iUXXtv8xs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280143

On Wed, May 27, 2026 at 04:44:31PM -0700, Yang Shi wrote:
> On 5/22/26 2:18 AM, Heiko Carstens wrote:
> > It is amazing to see the performance improvements you see on arm64, however
> > I believe that is mainly because of the large amount of code which is
> > generated by the arm64 implementations of the preempt primitives
> > __preempt_count_add() and __preempt_count_dec_and_test().
> 
> Yes, we need 4 instructions on ARM64 for disabling/enabling preempt (one
> instruction is used to load current pointer, the other 3 instructions are
> used to RMW preempt_count). So I can remove 8 instructions in total for a
> single this_cpu ops. That's a lot. Given this_cpu ops are heavily used in
> kernel, we end up running fewer instructions and having better icache hit
> rate, the better icache hit rate also helps reduce cross node traffic for
> 2-socket system.

You save more. Look at arm64's __preempt_count_dec_and_test()
implementation: it is RMW + compare + READ + compare.

preempt_enable() generates this code, where x1 seems to contain the
preempt_count pointer:

  80:   f9400420        ldr     x0, [x1, #8]
  84:   d1000400        sub     x0, x0, #0x1
  88:   b9000820        str     w0, [x1, #8]
  8c:   b4000060        cbz     x0, 98 <bar+0x58>
  90:   f9400420        ldr     x0, [x1, #8]
  94:   b5000040        cbnz    x0, 9c <bar+0x5c>
  98:   94000000        bl      0 <preempt_schedule_notrace>
  9c:   ...

I assume arm64's instruction set does not allow for better code for
__preempt_count_dec_and_test() if you would fold the need_resched bit into
preempt_count and use atomic instructions + inline assembly with flag
output operands when modifying preempt_count.
As of now only x86 and s390 are doing that.
