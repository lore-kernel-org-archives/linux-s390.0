Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995A35AC20;
	Tue,  2 Jun 2026 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408485; cv=none; b=Gv228nyPb98yEr8Khxo5KBeUrAxmAFcaWICyAia098EifE8rtfJPO21VHVuMu6l3Xe/Oqrsv6Ne+4KnYEAaCtUkTmONfgBlGZ5YZ98lbEVnRlNGCWHPRpSKTNioD/bAWq4z/cCegYyfyh0KCMOB2TdqsXYVftt9DDLT5a9pHKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408485; c=relaxed/simple;
	bh=R16RursrJFmylB04rE1NQz+dkfLCrX8fg/SlfL+8z1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLWy19Pe7pIXbyrpqNt7N6wxHTH4ORQgeKllujGVYFC9DJNE7OGNZK64M4+Sj8GH1a9WwRtOSEoQn2hys3TqkccKFBF43JuqOHBcareSnVXoohuPsGISueL5VRxklDuF9FnPlx0LvAoOFyzKseGGizVxhgYG548bCeL4h8BWKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jsA55+ei; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jsA55+ei"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6523UDct3293619;
	Tue, 2 Jun 2026 13:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jLSogptqIMxuyiKFgaOFK+J7ouPLj+
	gE0ZHvo8jHRvU=; b=jsA55+eiw6eqj/ONfg6woM1KTSf+xJrpdTkB7iwL63qwLA
	SwVt8EN3T+3ABzhpDIyznFdnbsE/PzpmJ17ILYVhqazowmzN1QooHHQ4bxagMvrl
	vfDoD0d6zYpa9eE979+ocIG5g3E93RkddASSNitu9ail8BzNHzjlVI/uZmB6CItt
	yc20r16dEBY51fm4naQ6JzDN44F/9OAl6RIRPvxojYRC1WEeYuRtCnFfxC6AqL0e
	o+kj/ti+V34FJP0NCXzUIlzvnvQh0ME3PPUdXKjTrU9s4x6NKp16c0uyf5dZiUvn
	JeZLF6Djb7VIF4SOS2kvVgpzJhsM+h3HgfeYZMXQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahnyy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 13:54:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652DOA9G007327;
	Tue, 2 Jun 2026 13:54:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k3h0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 13:54:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652DscZT43647460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 13:54:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30D7B2004B;
	Tue,  2 Jun 2026 13:54:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0928820043;
	Tue,  2 Jun 2026 13:54:38 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 13:54:37 +0000 (GMT)
Date: Tue, 2 Jun 2026 15:54:36 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/7] s390/percpu: Infrastructure for more efficient
 this_cpu operations
Message-ID: <20260602135436.10415A71-hca@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-2-hca@linux.ibm.com>
 <403de21c-957e-41ca-8c03-0bd110c49ec3-agordeev@linux.ibm.com>
 <20260601132750.9109A3b-hca@linux.ibm.com>
 <491a0085-9ba1-431b-9752-c1ac3fd602be-agordeev@linux.ibm.com>
 <20260601150813.9109C90-hca@linux.ibm.com>
 <20260602143209.1ce024e3@pumpkin>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602143209.1ce024e3@pumpkin>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEyNiBTYWx0ZWRfXzRVmtNp0+/Rx
 ffLj+8JAugHYhzxFsWKkPFH7Xb4VSGbW0CLgtuKjeFOgGhnss0dr72+Q12gxYsraLR7CIy+1OVJ
 DfzDhq/JSSf/9KePM+HyQ8Q4rOujT4jyl9kOULVT5hcaPABTpb1Yf8fnI8FT0S1ZFabpedrZNfz
 ZUD3asbS70doaZnv3iqt3xZbeEbUoMopgLTUaY1+qGzluZpYWUdK2umfboCqozyaFYGITqWOfU6
 642fqA5xVu3CMR4205dK4Iyts1LuFD5sQ6JZ66UJXy8+zc/09hD0nDOJ9/DrcTzt9ncHdNnEGcH
 G6GnJlaM6fPndrnVwmpyNIgxDenBXsk89aKAgBTZTtld+JE7kE1h09BpKxS/3Ag54u7Ez1hwz6z
 QHRECopYasnB+gHZAGLhhVoFOwVYkTRYmQsWSxDd+tLB26s9MV5+E+F52VvlAXc6LRDlRASKLXN
 yfocc8M/rk/5VVZtAkw==
X-Proofpoint-ORIG-GUID: wolZuH22T_kdsLTPujJOpMgDj9tOxrXB
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1ee0a3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=rWdP0wbPPiiOYCeSEhAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: LURjkPFc6azpMGiWxqqRdjTM8lvuux50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020126

On Tue, Jun 02, 2026 at 02:32:09PM +0100, David Laight wrote:
> On Mon, 1 Jun 2026 17:08:13 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> > It is: the check makes sure this is an AG instruction, which adds the
> > percpu offset from lowcore - by checking that the displacement is
> > correct, as well as that the base register is zero.
> > 
> > There could be a different AG instruction within the inline assembly,
> > for whatever reason.
> 
> Do you actually even need to check the instruction?
> 
> This sequence can only work for simple per-cpu accesses, so I don't
> see a reason to let the specified register point anywhere other than the
> base of the per-cpu data.
> 
> That means the process switch code can just load the register with the
> base of the per-cpu data for the new cpu.
> If that happens before the 'AG' is executed it won't matter.
> 
> The only reason would be to support non-offsettable memory accesses.
> But it looks like the 'laag    %r5,%r2,0(%r4)' in the example has an
> offset (of zero).
> Probably only stops you doing a direct access of an array.
> 
> That would mean that needs_fixup goes in the bin and percpu_exit() becomes:
> 	...
> 	reg = regs->percpu_register;
> 	if (likely(!reg))
> 		return;
> 	lc->percpu_register = reg;
> 	regs->gprs[reg] = lc->percpu_offset
> }
> 
> I guess I'm missing something?

The percpu register (in the above example %r4) first contains the base address
of a percpu variable. To get the actual percpu address of the variable the
percpu_offset of the corresponding cpu has to be added to that address, which
is what the AG instruction is doing.

What you propose would make a CPU's percpu_offset the address of any percpu
variable, which most likely would result in a crash.
